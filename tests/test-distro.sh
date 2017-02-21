#!/bin/bash
################################################################################
# This is used in the provisioning step of the Vagrantfile.
# Shall be "in-sync" with .travis.yml scripts.
################################################################################
distro=$1
test_case=$2
skip_test_idempotence=$3
if [[ "$distro" == "" ]]; then
    echo "Distribution not defined!"
    exit 1
fi

if [[ "$test_case" == "" ]]; then
    test_case=test1
fi

if [[ "$skip_test_idempotence" == "1" ]]; then
    skip_idempotence=1
else
    skip_idempotence=0
fi

echo "[$test_case] Distribution under test: ${distro}"

ansible_opts="$ANSIBLE_OPTS"
run_opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
container_id_file=$(mktemp)
init="env TERM=xterm python /etc/ansible/roles/role-under-test/tests/trap.py"

if [[ -d "/vagrant" ]]; then
    sudo systemctl restart docker
    cd /etc/ansible/roles/role-under-test
fi

RESULT=0
# Run container in detached state.
docker run --detach --volume="${PWD}":/etc/ansible/roles/role-under-test:ro ${run_opts} williamyeh/ansible:${distro} ${init} > "${container_id_file}"
RESULT+=$?

container_id="$(cat ${container_id_file})"

if [[ -n "${container_id}" ]]; then
    echo "[$test_case] Docker container ID: ${container_id}"

    if [[ "$distro" == "alpine3" ]]; then
        docker exec --tty ${container_id} env TERM=xterm apk update
        RESULT+=$?
    fi

    echo "[$test_case] Ansible version"
    docker exec --tty ${container_id} env TERM=xterm ansible --version

    echo "[$test_case] Ansible syntax check"
    docker exec --tty ${container_id} env TERM=xterm ansible-playbook $ansible_opts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$test_case/test.yml --syntax-check
    RESULT+=$?

    if [[ $RESULT -eq 0 ]]; then
        echo "[$test_case] Test"
        docker exec --tty ${container_id} env TERM=xterm ansible-playbook $ansible_opts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$test_case/test.yml
        RESULT+=$?

        if [[ $RESULT -eq 0 ]]; then
            echo "[$test_case] Verify"
            docker exec --tty ${container_id} env TERM=xterm sh /etc/ansible/roles/role-under-test/tests/$test_case/verify.sh
            RESULT+=$?

            if [[ $skip_idempotence -eq 0 ]]; then
                echo "[$test_case] Test idempotence"
                docker exec --tty ${container_id} env TERM=xterm ansible-playbook $ansible_opts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$test_case/test.yml
                RESULT+=$?
            fi
        fi
    fi

    echo "[$test_case] Cleanup"
    docker stop ${container_id} > /dev/null
    docker rm -v ${container_id} > /dev/null
else
    echo "[$test_case] Docker container was did not start correctly!"
    RESULT=1
fi

if [[ $RESULT -gt 0 ]]; then
    exit 2
fi

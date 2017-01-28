#!/bin/bash
################################################################################
# This is used in the provisioning step of the Vagrantfile.
# Shall be "in-sync" with .travis.yml scripts.
################################################################################
distro=$1
test_case=$2
skip_idempotence=$3
if [[ "$distro" == "" ]]; then
    echo "Distribution not defined!"
    exit 1
fi

if [[ "$test_case" == "" ]]; then
    test_case=test.yml
fi

if [[ "$skip_idempotence" != "1" ]]; then
    skip_idempotence=0
fi

#ansible_opts="-vvv"
ansible_opts=""
run_opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
container_id_file=$(mktemp)
init="env TERM=xterm python /etc/ansible/roles/role-under-test/tests/trap.py"

# Special for Vagrant to avoid problems with shared directories etc
if [[ -d "/vagrant" ]]; then
    sudo systemctl restart docker
    cd /etc/ansible/roles/role-under-test
fi

echo "Distribution under test: ${distro}"
RESULT=0
# Run container in detached state.
docker run --detach --volume="${PWD}":/etc/ansible/roles/role-under-test:ro ${run_opts} williamyeh/ansible:${distro} ${init} > "${container_id_file}"
RESULT+=$?

container_id="$(cat ${container_id_file})"

if [[ -n "${container_id}" ]]; then
    echo "Docker container ID: ${container_id}"

    if [[ "$distro" == "alpine3" ]]; then
        docker exec --tty ${container_id} env TERM=xterm apk update
        RESULT+=$?
    fi

    # Ansible syntax check.
    docker exec --tty ${container_id} env TERM=xterm ansible-playbook $ansible_opts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$test_case --syntax-check
    RESULT+=$?

    # Test role.
    docker exec --tty ${container_id} env TERM=xterm ansible-playbook $ansible_opts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$test_case
    RESULT+=$?

    if [[ "$skip_idempotence" == "1" ]]; then
        # Test role idempotence.
        docker exec --tty ${container_id} env TERM=xterm ansible-playbook $ansible_opts -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/$test_case
        RESULT+=$?
    fi

    # Cleanup
    docker stop ${container_id} > /dev/null
    docker rm -v ${container_id} > /dev/null
else
    echo "Docker container was did not start correctly!"
    RESULT=1
fi

if [[ $RESULT -gt 0 ]]; then
    exit 2
fi

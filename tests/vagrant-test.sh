#!/bin/bash -ux
################################################################################
# This is used in the provisioning step of the Vagrantfile.
# Shall be "in-sync" with .travis.yml scripts.
################################################################################
run_opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
distros="alpine3 centos6 centos7 debian7 debian8 ubuntu12.04 ubuntu14.04 ubuntu16.04"
container_id=$(mktemp)
init="env TERM=xterm python /etc/ansible/roles/role-under-test/tests/trap.py"

sudo systemctl start docker
cd /etc/ansible/roles/role-under-test

for distro in ${distros};
do
    RESULT=0
    # Run container in detached state.
    docker run --detach --volume="${PWD}":/etc/ansible/roles/role-under-test:ro ${run_opts} williamyeh/ansible:${distro} ${init} > "${container_id}"
    RESULT+=$?

    if [[ "$distro" == "alpine3" ]] ; then  docker exec --tty "$(cat ${container_id})" env TERM=xterm apk update ; fi
    RESULT+=$?

    # Ansible syntax check.
    docker exec --tty "$(cat ${container_id})" env TERM=xterm ansible-playbook -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/test.yml --syntax-check
    RESULT+=$?

    # Test role.
    docker exec --tty "$(cat ${container_id})" env TERM=xterm ansible-playbook -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/test.yml
    RESULT+=$?

    # Test role idempotence.
    docker exec --tty "$(cat ${container_id})" env TERM=xterm ansible-playbook -c local -i /etc/ansible/roles/role-under-test/tests/inventory /etc/ansible/roles/role-under-test/tests/test.yml
    RESULT+=$?

    # Cleanup
    docker stop "$(cat ${container_id})"
    docker rm -v "$(cat ${container_id})"

    if [[ $RESULT -gt 0 ]]; then
        echo "Test failed during test of distribution [$distro]!"
        exit 3
    fi
done
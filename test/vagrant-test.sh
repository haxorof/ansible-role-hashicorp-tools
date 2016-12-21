#!/bin/bash -ux
################################################################################
# This is used in the provisioning step of the Vagrantfile.
# Shall be "in-sync" with .travis.yml scripts.
################################################################################
run_opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
distro="centos7"
container_id=$(mktemp)
init="/lib/systemd/systemd"

cd /etc/ansible/roles/role-under-test
# Run container in detached state.
docker run --detach --volume="${PWD}":/etc/ansible/roles/role-under-test:ro ${run_opts} ansible/${distro}-ansible:stable "${init}" > "${container_id}"

# Ansible syntax check.
docker exec --tty "$(cat ${container_id})" env TERM=xterm ansible-playbook -c local -i /etc/ansible/roles/role-under-test/test/inventory /etc/ansible/roles/role-under-test/test/test-all-states.yml --syntax-check

# Test role.
docker exec --tty "$(cat ${container_id})" env TERM=xterm ansible-playbook -c local -i /etc/ansible/roles/role-under-test/test/inventory /etc/ansible/roles/role-under-test/test/test-all-states.yml

# Test role idempotence.
docker exec --tty "$(cat ${container_id})" env TERM=xterm ansible-playbook -c local -i /etc/ansible/roles/role-under-test/test/inventory /etc/ansible/roles/role-under-test/test/test-all-states.yml

# Cleanup
docker stop "$(cat ${container_id})"
#!/bin/bash -ux
################################################################################
# This is used in the provisioning step of the Vagrantfile.
# Shall be "in-sync" with .travis.yml scripts.
################################################################################
# Not yet Ansible 2.4 version in geerlingguy/docker-ubuntu1804-ansible
distros="geerlingguy/docker-ubuntu1204-ansible geerlingguy/docker-ubuntu1404-ansible geerlingguy/docker-ubuntu1604-ansible \
    geerlingguy/docker-centos6-ansible geerlingguy/docker-centos7-ansible \
    geerlingguy/docker-debian8-ansible geerlingguy/docker-debian9-ansible \
    geerlingguy/docker-fedora27-ansible"

script_dir=/vagrant

for distro in ${distros};
do
    $script_dir/test-distro.sh $distro
    RESULT=$?

    if [[ $RESULT -gt 0 ]]; then
        echo "Test failed during test of distribution [$distro]!"
        exit 3
    fi
done
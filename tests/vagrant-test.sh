#!/bin/bash -ux
################################################################################
# This is used in the provisioning step of the Vagrantfile.
# Shall be "in-sync" with .travis.yml scripts.
################################################################################
distros="alpine3 centos6 centos7 debian7 debian8 ubuntu12.04 ubuntu14.04 ubuntu16.04"

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
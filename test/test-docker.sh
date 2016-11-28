#!/bin/bash -ux
TEST_HOME=$HOME/ansible-test
mkdir -p $TEST_HOME/roles
cp /vagrant/* $TEST_HOME/
cd $TEST_HOME
ln -s /mnt/ansible $TEST_HOME/roles/role-under-test
$TEST_HOME/test.sh

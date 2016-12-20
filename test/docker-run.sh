#!/bin/bash
docker run --name ansible_test --rm -it -v '/vagrant:/vagrant' -v '/mnt/ansible:/mnt/ansible' ansible/centos7-ansible:stable /vagrant/test-docker.sh
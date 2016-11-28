#!/bin/bash -ux
ansible-playbook -v -c local -i inventory test.yml

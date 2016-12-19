#!/bin/bash -ux
EXIT_CODE=0
if [[ $EXIT_CODE -eq 0 ]]; then
    ansible-playbook -c local -i inventory test-present.yml
    EXIT_CODE=$?
fi
if [[ $EXIT_CODE -eq 0 ]]; then
    ansible-playbook -c local -i inventory test-specific.yml
    EXIT_CODE=$?
fi
if [[ $EXIT_CODE -eq 0 ]]; then
    ansible-playbook -c local -i inventory test-latest.yml
    EXIT_CODE=$?
fi
if [[ $EXIT_CODE -eq 0 ]]; then
    ansible-playbook -c local -i inventory test-latest-present.yml
    EXIT_CODE=$?
fi
if [[ $EXIT_CODE -eq 0 ]]; then
    ansible-playbook -c local -i inventory test-minimal.yml
    EXIT_CODE=$?
fi

if [[ $EXIT_CODE -eq 0 ]]; then
    echo ":OK"
else
    echo ":NOK"
fi
exit $EXIT_CODE


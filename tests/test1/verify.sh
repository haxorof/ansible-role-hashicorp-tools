#!/bin/sh

. /etc/profile.d/99-hashicorp-bin.sh
export PATH

RESULT=0

updateResult() {
  if [ $1 -gt 0 ]; then
    RESULT=$1
  fi
}

assertInPath() {
  echo "$PATH" | grep "$2" 1>/dev/null
  _result=$?
  if [ $_result -eq 0 ]; then
    if [ ! -f "$2/$1" ]; then
      _result=1
    fi
  fi
  if [ $_result -eq 0 ]; then
    echo -e "\e[32mok:\e[39m $1 in PATH"
  else
    echo -e "\e[31mfailed:\e[39m $1 NOT in PATH"
  fi
  updateResult $_result
}

assertInPath "packer.io" "/opt/bin"
assertInPath "terraform.io" "/opt/bin"
assertInPath "vault.io" "/opt/bin"

exit $RESULT
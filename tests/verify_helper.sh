#!/bin/sh

RESULT=0

updateResult() {
  if [ $RESULT -eq 0 ]; then
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

assertNotInPath() {
  echo "$PATH" | grep "$2" 1>/dev/null
  _result=$?
  if [ $_result -eq 0 ]; then
    if [ -f "$2/$1" ]; then
      _result=1
    else
      _result=0
    fi
  fi  
  if [ $_result -eq 0 ]; then
    echo -e "\e[32mok:\e[39m $1 NOT in PATH"
  else
    echo -e "\e[31mfailed:\e[39m $1 in PATH"
  fi
  updateResult $?
}

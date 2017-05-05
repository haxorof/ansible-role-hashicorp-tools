#!/bin/sh

. /etc/profile.d/99-hashicorp-bin.sh
export PATH

BASEDIR=$(dirname "$0")

. $BASEDIR/../verify_helper.sh

assertInPath "packer.io" "/opt/bin"

exit $RESULT
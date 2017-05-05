#!/bin/sh

. /etc/profile.d/99-hashicorp-bin.sh
export PATH

BASEDIR=$(dirname "$0")

. $BASEDIR/../verify_helper.sh

assertInPath "packer.io" "/opt/bin"
assertInPath "terraform.io" "/opt/bin"
assertInPath "vault.io" "/opt/bin"
assertNotInPath "consul.io" "/opt/bin"

exit $RESULT
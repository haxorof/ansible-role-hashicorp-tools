#!/bin/bash
TOOL=$1
if [[ "$TOOL" == "" ]]; then
    exit 1
fi
wget -q -O - https://releases.hashicorp.com/$TOOL | grep "href=\"/$TOOL" | cut -d/ -f3 | grep -v - | sed "s/\./ /g" | sort -r -n -k1 -k2 -k3 | sed "s/ /\./g"
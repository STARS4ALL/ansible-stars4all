#!/usr/bin/env bash

PLAYBOOK=$(basename $0 .sh)
./generico.sh ${PLAYBOOK} inventory "$@"

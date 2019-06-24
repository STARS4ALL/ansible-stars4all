#!/usr/bin/env bash


function usage() {
    SCRIPT=$(basename $0)
    printf "usage: ${SCRIPT} <playbook> <inventory_directory> (--help | [-t <tag_1><,tag_2>...] [options])\n\n" >&2
    printf "*************************************************\n"
    printf "ansible-playbook --help\n"
    ansible-playbook --help
    printf "*************************************************\n"
}



function valid_playbooks() {
	echo "Valid playbooks are:"
	for playbook_file in $(ls *.yml)
	do
		playbook_file="${playbook_file%%.*}"
		echo -e "\t- ${playbook_file#*/}"
	done
}



if [[ ${#} -lt 2 ]]; then
	echo "At least two parameters are needed:"
	usage
	valid_playbooks
	exit 1
fi



if [[ ! -f ${1}.yml ]]; then
	echo "Playbook ${1} (real file location ${1}.yml) doesn't exists"
	usage
	valid_playbooks
	exit 2
fi


PLAYBOOK="${1}.yml"
shift

if [[ ! -d ${1} ]]; then
	echo "${1} is not a directory. Please provide a valid inventory directory."
	usage
	exit 3
fi


INVENTORY_DIRECTORY="${1}"

shift


if [[ ! -z ${1} ]]; then
    if [ "${1}" == "--help" ]; then
        usage
        valid_playbooks
        exit 0
    else
        if ! [[ "${1}" =~ -.* ]]; then
        	TAGS="-t ${@}"
        else
        	TAGS="${@}"
        fi
    fi
fi


export ANSIBLE_HOST_KEY_CHECKING=False
#CMD="ansible-playbook -v ${PLAYBOOK} -i ${INVENTORY_DIRECTORY} --module-path=roles --vault-password-file .vault_pass.txt ${TAGS}"
CMD="ansible-playbook -v ${PLAYBOOK} -i ${INVENTORY_DIRECTORY} --module-path=roles ${TAGS}"
echo "Executing ${CMD}"
${CMD}

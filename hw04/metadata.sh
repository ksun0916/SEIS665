#!/bin/bash

ACTION=${1:-launch}
version="0.1.0"

function show_version() {
	echo $version
}

function create_file() {
	touch rds-message.txt
	nc -vz ecotech-db1.c8eytdpiqpun.us-east-1.rds.amazonaws.com 3306 >> rds-message.txt

	touch ecoweb1-identity.json
	curl http://169.254.169.254/latest/dynamic/instance-identity/document/ >> ecoweb1-identity.json
}

function display_help() {
	cat << EOF
        Usage: ${0} {-c|--create|-v|--version} <filename>
        OPTIONS:
        	-v | --version  Display the version
                -c | --create     Create files
                Examples:
                Display the version:
                                $ ${0} -v
                Create files:
                                $ ${0} -c
EOF
}


if [ -z "$1" ]
	then
		display_help
	else
		case "$ACTION" in
			-c| --create)
				create_file
				;;
			-v| --version)
				show_version
				;;
			*)
				echo "Usage ${0} {-v|-c}"
			exit 1
		esac
fi

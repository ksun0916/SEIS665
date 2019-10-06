#!/bin/bash

ACTION=${1:-launch}
if [ -z "$1" ]
	then
		sudo yum update -y
		sudo amazon-linux-extras install nginx1.12 -y
		sudo chkconfig nginx on
		sudo aws s3 cp s3://sk1911-assignment-3/index.html /usr/share/nginx/html/index.html
		sudo service nginx start
	else
		version="1.0.0"
		function show_version() {
			echo $version
			}
		function remove_file() {
			sudo service nginx stop
			rm -fr /usr/share/nginx/html/"${1}"
			yum remove nginx -y
			}
		function display_help() {
			cat << EOF
			Usage: ${0} {-v|--version|-r|--remove|-h|--help} <filename>
			OPTIONS:
				-v | --version	Display the version
				-r | --remove	Remove a file
				-h | --help	Display the command help
			Examples:
			Display the version:
				$ ${0} -v foo.txt
			Remove a file:
				$ ${0} -r foo.txt
			Display help:
				$ ${0} -h
EOF
}

		case "$ACTION" in
			-h| --help)
				display_help
				;;
			-r| --remove)
				remove_file "${2:-server}"
				;;
			-v| --version)
				show_version
				;;
			*)
				echo "Usage ${0} {-v|-r|-h}"
			exit 1
		esac
fi


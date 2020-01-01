#!/bin/bash

ACTION=${1:-launch}
version="2.0"

function update(){
	sudo yum update -y
}

function backupfile(){
	ls *.txt
	for a in *.txt
	do
		cat $a > $a.bak
	done
}

function midtermaws(){
	touch awscli.txt
	aws ec2 describe-instances --filters Name=instance.group-name,Values=midterm >> awscli.txt
	aws ec2 describe-security-groups --filters Name=group-name,Values=midterm >> awscli.txt
}

function metadata() {
	touch metadata.txt
	curl http://169.254.169.254/latest/meta-data/ami-id >> metadata.txt
	echo ' ' >> metadata.txt
	curl http://169.254.169.254/latest/meta-data/instance-id >> metadata.txt
	echo ' ' >> metadata.txt
	curl http://169.254.169.254/latest/meta-data/hostname >> metadata.txt
	echo ' ' >> metadata.txt
	curl http://169.254.169.254/latest/meta-data/security-groups >> metadata.txt
	echo ' ' >> metadata.txt
	curl http://169.254.169.254/latest/meta-data/public-hostname >> metadata.txt
	echo ' ' >> metadata.txt
}

function show_version() {
	echo $version
}

function display_help() {
	cat << EOF
	Script Name: midterm.sh
        Usage: ${0} {-v|--version|-m|--metadata}
        OPTIONS:
        	-v | --version  Display the version
                -m | --metadata   Save metadata to matadata.txt
		-a | --aws	Execute commands to awscli.txt
		-b | --backup	List txt files and backup
                Examples:
                Display the version:
                                $ ${0} -v
                Save metadata to metadata.txt:
                                $ ${0} -m
		Execute commands to awscli.txt:
				$ ${0} -a
		List txt files and back:
				$ ${0} -b
EOF
}


if [ -z "$1" ]
	then
		update
	else
		case "$ACTION" in
			-m| --metadata)
				metadata
				;;
			-v| --version)
				show_version
				;;
			-a| --aws)
				midtermaws
				;;
			-b| --backup)
				backupfile
				;;
			*)
				display_help
			exit 1
		esac
fi

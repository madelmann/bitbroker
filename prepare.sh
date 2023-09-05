#!/bin/bash

BASEPATH=`pwd`

echo "Preparing configuration..."

# check if we need to prepare the first-start config
if [ -f "libs/Config/base.conf" ]; then

	echo "No need to prepare anything, environment has already been set up."
	exit 0

else
	DATABASE_IP="127.0.0.1"
	DATABASE_PORT="3306"

	read -p "Broker Name: " BROKER
	read -p "Database Schema: " DATABASE_SCHEMA
	#read -p "Database IP: " DATABASE_IP
	#read -p "Database Port: " DATABASE_PORT
	read -p "DB User: " USER
	read -sp "DB Password: " PASSWORD

	export BASEPATH
	export BROKER
	export DATABASE_IP
	export DATABASE_PORT
	export DATABASE_SCHEMA
	export PASSWORD
	export USER

	envsubst < ${BASEPATH}/libs/Config/base.conf.tmp   > ${BASEPATH}/libs/Config/base.conf
	envsubst < ${BASEPATH}/libs/Config/Database.os.tmp > ${BASEPATH}/libs/Config/Database.os

fi

echo "Done preparing configuration for '${BROKER}'..."


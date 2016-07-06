#!/bin/bash
set -e

# Add app as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- app "$@"
fi

function checkLastCommand 
{
	if [ $? == 0 ]; then
		echo $(printf "%s ok" "$1")
	else
		echo $(printf "%s failed" "$1")
		exit 1
	fi
}  

if [ "$1" = 'app' ]; then
	# Change ownership
	#sudo chown -R app $APP_DIR
	#sudo chown -R app:app /usr/local/bin/gosu

	STRLOG="basic check of required environment variables ... "

	if [ -z "$APP_DIR" ]; then
		echo $(printf "%s failed" "$STRLOG")
		echo >&2 'error: you have not set required environment variables: APP_DIR'
		exit 1
	fi
	echo $(printf "%s ok" "$STRLOG")

	# Simple but effective 
	# Check if polymer components have been installed to setup some one time only needed setup
	if [ ! -d $APP_DIR/node_modules ]; then
			cd $APP_DIR && sudo npm install
			cd $APP_DIR && sudo npm install --only=dev
			cd $APP_DIR && sudo npm install webpack webpack-dev-server --global
			checkLastCommand "installing npm components"
	fi


	if [ "$ENV_TYPE" = 'local' -o "$ENV_TYPE" = 'test' ]; then
		echo "Local settings, starting server"
		cd $APP_DIR && webpack-dev-server --progress --colors --hot --inline --history-api-fallback --host=0.0.0.0 --port 8080
	elif [ "$ENV_TYPE" = 'prod' ]; then
		echo "Production not supported yet"
		exit 1
	else
		echo "ERROR: Neither production or development environment selected (ENV_TYPE=$ENV_TYPE is not valid)"
		exit 1
	fi

	echo
	echo 'App init process done. Ready for start up.'
	echo

fi

exec "$@"

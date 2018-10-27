#!/bin/bash

api-install() {
	docker-compose exec api ./script.sh install
}
#manager-install() {
#
#}

case "$1" in

	api-install)
		api-install
		;;

	install)
		docker-compose build
		docker-compose up -d
		sleep 3s
		api-install
		;;

	reset-docker)
		docker-compose down
		docker rm $(docker ps -a -q)
		docker rmi $(docker images -q)
		;;

	*)
		echo "options: {install|api-install|reset-docker}" >&2
		exit 3
		;;
esac


build:
	@ ${INFO} "Building openvidu browser library"
	@ cd openvidu-browser/ && yarn build && cp -r . ../openvidu-server/src/dashboard/node_modules/openvidu-browser
	@ ${INFO} "Building openvidu angular dashboard"
	@ cd openvidu-server/src/dashboard && yarn build
	@ ${INFO} "Building openvidu server"
	@ mvn package -DskipTests=true
	@ ${INFO} "Building openvidu docker image version:${OPENVIDU_VERSION}"
	@ cd openvidu-server/docker/openvidu-server-kms && ./create_image.sh ${OPENVIDU_VERSION}
	@ ${INFO} "Tagging image and pushing to google cloud"
	@ docker tag openvidu/openvidu-server-kms:latest gcr.io/edudoorlms/samvadam:1.2.0 && docker push gcr.io/edudoorlms/samvadam:1.2.0

# COLORS
GREEN	:= $(shell tput -Txterm setaf 2)
YELLOW 	:= $(shell tput -Txterm setaf 3)
WHITE	:= $(shell tput -Txterm setaf 7)
NC		:= "\e[0m"
RESET 	:= $(shell tput -Txterm sgr0)

# SHELL FUNCTIONS
INFO 	:= @bash -c 'printf "\n"; printf $(YELLOW); echo "===> $$1"; printf "\n"; printf $(NC)' SOME_VALUE
SUCCESS	:= @bash -c 'printf "\n"; printf $(GREEN); echo "===> $$1"; printf "\n"; printf $(NC)' SOME_VALUE

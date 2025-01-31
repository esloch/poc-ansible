
DOCKER_GET_IP:=docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
DOCKER_GET_HOST_ID:=docker ps -aqf "name=poc-ansible-host"


docker-get-host-ip:
	@$(DOCKER_GET_IP) `$(DOCKER_GET_HOST_ID)`


update-inventory:
	@export CONTAINER_ID=`$(DOCKER_GET_HOST_ID)` \
	&& echo `$(DOCKER_GET_IP) $$CONTAINER_ID` "ansible_port=2222" > inventory

ansible-ping:
	@ansible all -m ping

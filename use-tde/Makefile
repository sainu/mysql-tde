DOCKER_MYSQL_IMAGE_TAG=5.7
DOCKER_NETWORK=mysql-tde-use-tde-network
DOCKER_VOLUME_DATA_DIR=data
DOCKER_MYSQL_SERVER_CONTAINER_NAME=mysql-tde-use-tde-mysql-server
DOCKER_MYSQL_CLI_CONTAINER_NAME=mysql-tde-use-tde-mysql-cli
DOCKER_MYSQL_SH_CONTAINER_NAME=mysql-tde-use-tde-mysql-sh

.PHONY: init
init:
	mkdir -p $(DOCKER_VOLUME_DATA_DIR)
	docker pull mysql:$(DOCKER_MYSQL_IMAGE_TAG)
	docker network create $(DOCKER_NETWORK) > /dev/null 2>&1 || true
	chmod 755 init/init.sh

.PHONY: run
run:
	docker run \
		-it \
		--rm \
		--name $(DOCKER_MYSQL_SERVER_CONTAINER_NAME) \
		--network $(DOCKER_NETWORK) \
		-v `pwd`/$(DOCKER_VOLUME_DATA_DIR):/var/lib/mysql \
		-v `pwd`/init:/docker-entrypoint-initdb.d \
		-v `pwd`/my.cnf:/etc/conf.d/my.cnf \
		-e MYSQL_ROOT_PASSWORD=mysql \
		-e MYSQL_DATABASE=test \
		mysql:$(DOCKER_MYSQL_IMAGE_TAG)

.PHONY: cli
cli:
	docker run \
		-it \
		--rm \
		--network $(DOCKER_NETWORK) \
		--name $(DOCKER_MYSQL_CLI_CONTAINER_NAME) \
		mysql:$(DOCKER_MYSQL_IMAGE_TAG) \
		mysql -h$(DOCKER_MYSQL_SERVER_CONTAINER_NAME) -uroot -pmysql

.PHONY: sh
sh:
	docker run \
		-it \
		--rm \
		--network $(DOCKER_NETWORK) \
		--name $(DOCKER_MYSQL_SH_CONTAINER_NAME) \
		-v `pwd`/$(DOCKER_VOLUME_DATA_DIR):/var/lib/mysql \
		mysql:$(DOCKER_MYSQL_IMAGE_TAG) \
		/bin/sh

.PHONY: cli/down
cli/down:
	docker stop $(DOCKER_MYSQL_CLI_CONTAINER_NAME) > /dev/null 2>&1 || true

.PHONY: down
down:
	make cli/down
	docker stop $(DOCKER_MYSQL_SERVER_CONTAINER_NAME) > /dev/null 2>&1 || true

.PHONY: clean
clean:
	make down
	rm -rf $(DOCKER_VOLUME_DATA_DIR)
	docker network rm $(DOCKER_NETWORK) > /dev/null 2>&1 || true

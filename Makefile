YAML=srcs/docker-compose.yml
fresh:
	docker compose -f $(YAML) build --no-cache wordpress
	docker compose -f $(YAML) build --no-cache nginx
all:
	docker compose -f $(YAML) up
clean:
	docker rm -f webpress nginx mariadb

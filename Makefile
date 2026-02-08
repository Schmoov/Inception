YAML=srcs/docker-compose.yml
all:
	docker compose -f $(YAML) up
wp:
	docker compose -f $(YAML) build --no-cache wordpress
db:
	docker compose -f $(YAML) build --no-cache mariadb
nginx:
	docker compose -f $(YAML) build --no-cache nginx
fresh:
	wp
	db
	nginx
clean:
	docker rm -f webpress nginx mariadb

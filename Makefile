NAME := Inception

YAML := srcs/docker-compose.yml

all: $(NAME)

$(NAME):
	docker compose -f $(YAML) up

clean:
	docker compose -f $(YAML) down
re: clean all

fclean:
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q) 2>/dev/null
fre: fclean all


.PHONY: all clean fclean re fre

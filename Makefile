all:	up

up:
		@mkdir -p /home/${USER}/data/mdata
		@mkdir -p /home/${USER}/data/wdata
		@docker-compose -f srcs/docker-compose.yml up

down:
		@docker-compose -f srcs/docker-compose.yml down

ps:
		@docker-compose -f srcs/docker-compose.yml ps

fclean:	down
		@docker rm $$(docker ps -qa);\
		@docker image rm -f $$(docker images ls -q);\
		docker volume rm $$(docker volume ls -q);\
		docker system prune -a --force
		sudo rm -rf /home/${USER}/data

# Создавайте или перестраивайте сервисы
re: fclean up

.PHONY:	all up down ps fclean re
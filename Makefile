.PHONY: help up down
help:
	@sed -n -e 's/^# help: \(.*\)/\1/;t z' -e b -e ':z' -e 'N;s/\(.*\)\n\([^:]*\):.*/printf "%-20s - %s\\n" "\2" "\1"/p' Makefile | sh

# help: docker-compose up' with proper parameters
up:
	@docker-compose --env-file s3.env up

# help: docker-compose up for vanilla 
up-dev:
	@docker-compose --env-file s3.env -f docker-compose-dev.yml up

# help: 'docker-compose down' for vanilla
down-dev:
	@docker-compose --env-file s3.env -f docker-compose-dev.yml down

# help: 'docker-compose down'
down:
	@docker-compose --env-file s3.env down

# help: 'docker volume prune' - cleanup data
volume-prune:
	@docker volume prune

# help: 'docker volume -y prune' - cleanup data without prompt
volume-prune-force:
	@docker volume -y prune
# help: 'docker-compose down' and 'docker volume prune'
reset: down down-dev volume-prune

# help: 'docker exec -it dataverse asadmin'
asadmin:
	@docker exec -it dataverse asadmin 

# help: 'docker exec -it dataverse tail -F /opt/payara/appserver/glassfish/domains/production/logs/server.log'
payara-logs:
	@docker exec -it dataverse tail -n 1000  -F /opt/payara/appserver/glassfish/domains/production/logs/server.log

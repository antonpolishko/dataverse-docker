.PHONY: help
help:
	@sed -n -e 's/^# help: \(.*\)/\1/;t z' -e b -e ':z' -e 'N;s/\(.*\)\n\([^:]*\):.*/printf "%-20s - %s\\n" "\2" "\1"/p' Makefile | sh

#######################################################################################
.PHONY: up down
# help: docker-compose up' with proper parameters
up:
	docker-compose --env-file s3.env up

# help: 'docker-compose down'
down:
	docker-compose --env-file s3.env down


.PHONY: up-dev down-dev
# help: docker-compose up for vanilla 
up-dev:
	docker-compose --env-file s3.env -f docker-compose-dev.yml up

# help: 'docker-compose down' for vanilla
down-dev:
	docker-compose --env-file s3.env -f docker-compose-dev.yml down


.PHONY: up-prod down-prod
# help: 'docker-compose --env-file dataverse.s3.coronawhy.org.env up -d dataverse solr'
up-prod:
	docker-compose --env-file dataverse.s3.coronawhy.org.env up -d dataverse solr

# help: 'docker-compose --env-file dataverse.s3.coronawhy.org.env down dataverse solr'
down-prod:
	docker-compose --env-file dataverse.s3.coronawhy.org.env down
#######################################################################################

# help: 'docker exec -it dataverse bash'
shell devshell:
	docker exec -it dataverse bash

# help: 'docker volume prune' - cleanup data
volume-prune:
	docker volume prune

# help: 'docker volume -y prune' - cleanup data without prompt
volume-prune-force:
	docker volume -y prune
# help: 'docker-compose down' and 'docker volume prune'
reset: down down-dev volume-prune

# help: 'docker exec -it dataverse asadmin'
asadmin:
	docker exec -it dataverse asadmin 

# help: 'docker exec -it dataverse vim domain.xml'
edit-domain.xml:
	docker exec -it dataverse vim ./appserver/glassfish/domains/production/config/domain.xml 

# help: 'docker exec -it dataverse tail -F /opt/payara/appserver/glassfish/domains/production/logs/server.log'
payara-logs:
	docker exec -it dataverse tail -n 1000  -F /opt/payara/appserver/glassfish/domains/production/logs/server.log

# help: 'docker exec -it dataverse curl http://localhost:8080/api/admin/index'
solr-make-index::
	docker exec -it dataverse curl http://localhost:8080/api/admin/index | xargs

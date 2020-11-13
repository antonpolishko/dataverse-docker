.PHONY: help up down
help:
	@sed -n -e 's/^# help: \(.*\)/\1/;t z' -e b -e ':z' -e 'N;s/\(.*\)\n\([^:]*\):.*/printf "%-20s - %s\\n" "\2" "\1"/p' Makefile | sh

# help: docker-compose up' with proper parameters
up:
	@docker-compose --env-file s3.env up

# help: 'docker-compose down' and 'docker volumes prune'
down:
	@docker-compose --env-file s3.env down

# help: 'docker volume prune' - cleanup data
volume-prune:
	@docker volume prune

# help: 'docker volume -y prune' - cleanup data without prompt
volume-prune-force:
	@docker volume -y prune
# help: 'docker-compose down' and 'docker volume prune'
reset: down volume-prune


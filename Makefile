ifeq (rebuild,$(firstword $(MAKECMDGOALS)))
REBUILD := $(strip $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)))
$(eval $(REBUILD):;@:)
endif
REBUILD ?= app

rebuild:
	cd ../$(REBUILD) && $(extra) make docker

rebuild-all:
	cat compose.json | jq -r '.services | keys[]' | grep -v ubuntu-home | runmany '$(make) rebuild $$1'

include ../base/Makefile.docker

project_dir = $(shell pwd)/
client_objects = $(shell ls client/)
client_object_targets = $(foreach o, $(client_objects), website/static/js/$(o).js)

all: server client

client: $(client_object_targets)
server: website/server.js

website/server.js:
	cd server && pulp build -O --to $(project_dir)website/server.js

$(client_object_targets): website/static/js/%.js:client/%
	cd $< && pulp build -O --to $(project_dir)$@

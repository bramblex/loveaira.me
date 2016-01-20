
project_dir = $(shell pwd)/
client_objects = $(shell ls Client/) 
client_object_targets = $(foreach o, $(client_objects), Website/static/js/$(o).js)

all: Server Client

Client: $(client_object_targets)
Server: Website/Server.js

Website/Server.js:
	cd Server && pulp build -O --to $(project_dir)Website/Server.js	

$(client_object_targets): Website/static/js/%.js:Client/%
	cd $< && pulp build -O --to $(project_dir)$@


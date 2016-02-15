project_dir = $(shell pwd)/
client_objects = $(shell ls client/)
client_object_targets = $(foreach o, $(client_objects), website/static/js/$(o).js)

all: server client

client: $(client_object_targets)
server: website/server.js

website/server.js:
	cd server/ && pulp dep install
	cp server/package.json $(project_dir)website/package.json
	cd website/ && npm install
	cd server && pulp build --force -O --to $(project_dir)website/server.js
	sed -i -e 's/is_debug = true/is_debug = false/' $(project_dir)website/server.js
	-rm $(project_dir)website/server.js-e

$(client_object_targets): website/static/js/%.js:client/%
	cd $< && pulp browserify --force -O --to $(project_dir)$@

clean:
	-rm website/package.json
	-rm website/server.js
	-rm $(client_object_targets)

run: all
	node website/server.js

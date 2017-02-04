install: package.json Gemfile
	yarn && bundle install

build: node_modules Gemfile.lock
	bundle exec ./node_modules/grunt-cli/bin/grunt build

dev: node_modules Gemfile.lock
	bundle exec ./node_modules/grunt-cli/bin/grunt dev

server: node_modules
	node ./node_modules/node-static/bin/cli.js -a 0.0.0.0 -p 9080 build

dev-server:
	make dev server -j2

node_modules: package.json
	yarn

Gemfile.lock: Gemfile
	bundle install

.PHONY: install

.PHONY: build

.PHONY: dev

.PHONY: server

.PHONY: dev-server

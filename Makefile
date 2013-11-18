bootstrap-version = 3.0.2
fontawesome-version = 4.0.3
jquery-version = 1.10.2

build:
	recess src/less/style.less --compress > dist/css/style.min.css
	cat src/js/*.js | uglifyjs -o dist/js/script.min.js

clean-bootstrap-src:
	rm -rf src/vendor/bootstrap

clean-fontawesome-src:
	rm -rf src/vendor/font-awesome

clean-jquery-src:
	rm -rf src/vendor/jquery

clean-bootstrap:
	rm -rf dist/bootstrap

clean-fontawesome:
	rm -rf dist/font-awesome

clean-jquery:
	rm -rf dist/jquery

clean-layout:
	rm -rf dist/css/*.css
	rm -rf dist/js/*.js

configure-bootstrap: clean-bootstrap-src
	echo "You are now going to clone Twitter's Bootstrap $(bootstrap-version) repository."

	cd src/vendor && git clone https://github.com/twbs/bootstrap.git bootstrap --branch v$(bootstrap-version)
	cd src/vendor/bootstrap && npm install

configure-fontawesome: clean-fontawesome-src
	echo "You are now going to clone Font-Awesome $(fontawesome-version) repository."

	cd src/vendor && git clone https://github.com/FortAwesome/Font-Awesome.git font-awesome --branch v$(fontawesome-version)
	cd src/vendor/font-awesome && bundle install && npm install

configure-jquery: clean-jquery-src
	echo "You are now going to clone jQuery $(jquery-version) repository."

	cd src/vendor && git clone https://github.com/jquery/jquery.git jquery --branch $(jquery-version)
	cd src/vendor/jquery && npm install

bootstrap: clean-bootstrap
	echo "You are now going to build Twitter's Bootstrap $(bootstrap-version)."

	cd src/vendor/bootstrap/ && grunt

	mkdir -p dist/bootstrap
	cp -R src/vendor/bootstrap/dist/* dist/bootstrap/

fontawesome: clean-fontawesome
	echo "You are now going to build Font-Awesome $(fontawesome-version)."

	cd src/vendor/font-awesome && bundle exec jekyll build

	mkdir -p dist/font-awesome/css
	mkdir -p dist/font-awesome/fonts
	cp -R src/vendor/font-awesome/css/* dist/font-awesome/css
	cp -R src/vendor/font-awesome/fonts/* dist/font-awesome/fonts

jquery: clean-jquery
	echo "You are now going to build jQuery $(jquery-version)."

	cd src/vendor/jquery && grunt

	mkdir -p dist/jquery/js
	cp src/vendor/jquery/dist/jquery.min.js dist/jquery/js/jquery.min.js

clean-src: clean-bootstrap-src clean-fontawesome-src clean-jquery-src
clean: clean-bootstrap clean-fontawesome clean-jquery clean-layout
clean-all: clean-src clean
configure: configure-bootstrap configure-fontawesome configure-jquery
build-all: bootstrap fontawesome jquery build

help:
	@echo "Basic usage: 'make configure' and 'make build-all' for the first time; use 'make build' to build only the layout"
	@echo ""
	@echo "'make clean-bootstrap/fontawesome/jquery-src' to clean the src directory"
	@echo "'make clean-bootstrap/fontawesome/jquery' to clean the dist directory"
	@echo "'make configure-bootstrap/fontawesome/jquery' to clone the dependency repository and execute required commands before the build"
	@echo "'make configure' to clone all the dependencies repositories and executed required commands before their build"
	@echo "'make bootstrap/fontawesome/jquery' to build the dependency"
	@echo "'make build-all' to build all the dependencies"
	@echo "'make build' to build the layout"

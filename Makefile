sync-build = false
remote-host = user@server.remote.address
remote-dir = /var/www/domain/httpdocs/
certificate-file = /full/path/to/ssh/key/file (IT MUST BE THE FULL PATH)
rsync-exclude = --exclude '.svn' --exclude '.git' --exclude '.hg' --exclude '.DS_Store'

bootstrap-version = 3.0.2
fontawesome-version = 4.0.3
jquery-version = 1.10.2

dist-dir = dist/

build:
	mkdir -p $(dist-dir)/css
	mkdir -p $(dist-dir)/js
	mkdir -p $(dist-dir)/img
	mkdir -p $(dist-dir)/fonts

	#Copy all html files into the dist directory
	cd src && find . -path ./vendor -prune -o -type f -name "*.html" -exec rsync -Rv "{}" ../$(dist-dir)/ \;

	#Compile, concat and compress the LESS into a single style.min.css file to reduce HTTP requests
	recess src/less/style.less --compress > $(dist-dir)/css/style.min.css

	#Concat and compress all Javascripts into a single script.min.js file to reduce HTTP requests
	cat src/vendor/jquery/dist/jquery.min.js src/vendor/bootstrap/dist/js/bootstrap.min.js src/js/*.js | uglifyjs -o $(dist-dir)/js/script.min.js

	#Copy all images to dist/img directory
	cd src/img && find . -type f -a \( -name "*.png" -o -name "*.gif" -o -name "*.jpg" -o -name "*.jpeg" \) -exec rsync -Rv "{}" ../../$(dist-dir)/img/ \;

	#Copy all fonts to dist/fonts
	cp -R src/vendor/bootstrap/dist/fonts/* $(dist-dir)/fonts/ 2> /dev/null || :
	cp -R src/vendor/font-awesome/fonts/* $(dist-dir)/fonts/ 2> /dev/null || :
	cp -R src/fonts/* $(dist-dir)/fonts/ 2> /dev/null || :

ifeq ($(sync-build),true)

	#Sync to remote host
	rsync -rtvz $(rsync-exclude) -e "ssh -i $(certificate-file)" $(dist-dir)/ $(remote-host):$(remote-dir)

endif

clean-bootstrap:
	rm -rf src/vendor/bootstrap

clean-fontawesome:
	rm -rf src/vendor/font-awesome

clean-jquery:
	rm -rf src/vendor/jquery

clean:
	rm -rf dist

configure-bootstrap: clean-bootstrap
	echo "You are now going to clone Twitter's Bootstrap $(bootstrap-version) repository."

	#Clone the Bootstrap repository and install the required dependencies to build it
	cd src/vendor && git clone https://github.com/twbs/bootstrap.git bootstrap --branch v$(bootstrap-version)
	cd src/vendor/bootstrap && npm install

configure-fontawesome: clean-fontawesome
	echo "You are now going to clone Font-Awesome $(fontawesome-version) repository."

	#Clone the Font-Awesome repository and install the required dependencies to build it
	cd src/vendor && git clone https://github.com/FortAwesome/Font-Awesome.git font-awesome --branch v$(fontawesome-version)
	cd src/vendor/font-awesome && bundle install && npm install

configure-jquery: clean-jquery
	echo "You are now going to clone jQuery $(jquery-version) repository."

	#Clone the jQuery repository and install the required dependencies to build it
	cd src/vendor && git clone https://github.com/jquery/jquery.git jquery --branch $(jquery-version)
	cd src/vendor/jquery && npm install

bootstrap:
	echo "You are now going to build Twitter's Bootstrap $(bootstrap-version)."

	cd src/vendor/bootstrap/ && grunt

fontawesome:
	echo "You are now going to build Font-Awesome $(fontawesome-version)."

	cd src/vendor/font-awesome && bundle exec jekyll build

jquery:
	echo "You are now going to build jQuery $(jquery-version)."

	cd src/vendor/jquery && grunt

clean-dependencies: clean-bootstrap clean-fontawesome clean-jquery
clean-all: clean-dependencies clean
configure: configure-bootstrap configure-fontawesome configure-jquery
build-all: bootstrap fontawesome jquery build

help:
	@echo "Basic usage: 'make configure' and 'make build-all' for the first time; use 'make build' to build only the layout"
	@echo ""
	@echo "'make clean' to remove the dist directory"
	@echo "'make clean-bootstrap/fontawesome/jquery' to remove a dependency in src/vendor directory"
	@echo "'make clean-all' to remove the dist directory and all the dependencies in src/vendor directory"
	@echo "'make configure-bootstrap/fontawesome/jquery' to clone the dependency repository and execute required commands before the build"
	@echo "'make configure' to clone all the dependencies repositories and executed required commands before their build"
	@echo "'make bootstrap/fontawesome/jquery' to build a dependency"
	@echo "'make build-all' to build all the dependencies"
	@echo "'make build' to build the layout"

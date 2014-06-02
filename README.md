#[Layout Base Package with Bootstrap 3]
###a layout base package based in Bootstrap 3 and RECESS

A base package to build a layout based in mobile-first paradigm using Bootstrap 3.0.2 + RECESS + FontAwesome 4.0.3 + jQuery 1.10.2. It provides a Makefile to automate the build of the layout and its dependencies.

##Changelog
- v0.0.3 - started using LESS instead of RECESS;
         - Updated Bootstrap to version 3.1.1, FontAwesome to version 4.1.0 and jQuery to 1.11.1
- v0.0.2 - added the possibility to deploy the built layout to a remote server
- v0.0.1 - initial build using Bootstrap 3.0.2, FontAwesome 4.0.3 and jQuery 1.10.2

##Versioning

Font Awesome will be maintained under the Semantic Versioning guidelines as much as possible. Releases will be numbered with the following format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions, without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, please visit http://semver.org.

##Author
- Email: eu@rafaa.me
- GitHub: https://github.com/rafaame
- Website: http://rafaa.me

##Installing RECESS and UglifyJS
This package uses RECESS to process the .less files of the layout and UglifyJS to minify the .js files. To install these dependencies simply run:

	$ npm install

**Unfamiliar with `npm`? Don't have node installed?** That's a-okay. npm stands for [node packaged modules](http://npmjs.org/) and is a way to manage development dependencies through node.js. [Download and install node.js](http://nodejs.org/download/) before proceeding.

##Building for the First Time
In order to build the layout and its dependencies for the first time, you'll need to configure the dependencies first. Simply run:

    $ make configure
    $ make build-all

##Building the Layout
After you have configured and built all the dependencies and the layout for the first time, there's no need to rebuilt the dependencies again. In order to build only the layout, simply run:

	$ make build

or

	$ make

##Deploy Build to Development Server
In the version (>= 0.0.2) it is possible to deploy every build to a development server using rsync. All you need is to generate the SSH keys for the server you want to deploy the build to and edit the Makefile to match the server config.

To generate the SSH key to a specific user:

	$ ssh-keygen -f user

After that, you need to add this key to the authorized_keys file in the server:

	$ ssh-copy-id -i /path/to/user/key server.remote.address

You now should be able to login using the SSH key without having to enter the user password:

	$ ssh -i /path/to/user/key user@server.remote.address

Now edit the Makefile switching "sync-build" to true and adjusting the variables "remote-host", "remote-dir" and "certificate-file". After that, everytime you build the layout, it will be deployed to the server you specified using rsync.
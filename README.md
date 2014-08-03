#[Layout Base Package with Bootstrap 3]
###a layout base package based in Bootstrap 3, FontAwesome and jQuery

A base package to build a layout based in mobile-first paradigm using Bootstrap 3, LESS, FontAwesome and jQuery. It uses [Gulp](http://gulpjs.com/) to automate the build of the layout and its dependencies.

##Changelog
- v1.0.0 - started using [Gulp](http://gulpjs.com/) instead of make;
- v0.0.3 - started using LESS instead of RECESS;
         - Updated Bootstrap to version 3.1.1, FontAwesome to version 4.1.0 and jQuery to 1.11.1
- v0.0.2 - added the possibility to deploy the built layout to a remote server
- v0.0.1 - initial build using Bootstrap 3.0.2, FontAwesome 4.0.3 and jQuery 1.10.2

##Versioning

This project will be maintained under the Semantic Versioning guidelines as much as possible. Releases will be numbered with the following format:

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

##Installing needed dependencies
To install the dependencies simply run:

	$ npm install

**Unfamiliar with `npm`? Don't have node installed?** That's a-okay. npm stands for [node packaged modules](http://npmjs.org/) and is a way to manage development dependencies through node.js. [Download and install node.js](http://nodejs.org/download/) before proceeding.

##Deploy Build to Development Server
It is possible to deploy every build to a development server using SFTP. All you need is to have access to the server you want to deploy the build to via SSH and edit the config.json (actually you need to copy content from config.json.dist and create the config.json file) to match the server config.

After that, everytime you build the layout, the files in the 'distDir' that were changed will be deployed to the server you specified using SFTP.
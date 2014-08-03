var gulp = require('gulp'),
	rename = require('gulp-rename'),
	rimraf = require('rimraf'),
	concat = require('gulp-concat'),
	minifyCSS = require('gulp-minify-css'),
	less = require('gulp-less'),
	uglify = require('gulp-uglifyjs'),
	sftp = require('gulp-sftp'),
	changed = require('gulp-changed'),

	config = require('./config.json');

gulp.task('default', ['build']);

gulp.task('clean', function(cb)
{

	if(config.layout.cleanBeforeBuild)
		rimraf(config.layout.distDir + '/', cb);
	else
		cb();

});

gulp.task('build', ['build-page', 'build-img', 'build-font', 'build-css', 'build-js']);

gulp.task('build-page', ['clean'], function()
{

	return gulp
			.src(config.layout.dir + '/src/**/*.html')
			.pipe(changed(config.layout.distDir, {hasChanged: changed.compareSha1Digest}));

	if(config.layout.syncOnBuild)
		stream = stream.pipe(sftp
		({

			host: config.sftp.host,
			port: config.sftp.port,
			user: config.sftp.user,
			pass: config.sftp.pass,
			remotePath: (config.layout.remotePath ? config.layout.remotePath : config.sftp.remotePath )

		}));

	stream = stream.pipe(gulp.dest(config.layout.distDir));

	return stream;

});

gulp.task('build-img', ['clean'], function()
{

	return gulp
			.src
			([

				config.layout.dir + '/src/img/**/*.jpg',
				config.layout.dir + '/src/img/**/*.jpeg',
				config.layout.dir + '/src/img/**/*.png',
				config.layout.dir + '/src/img/**/*.gif',
				config.layout.dir + '/src/img/**/*.svg',
				config.layout.dir + '/src/img/**/*.ico'

			])
			.pipe(changed(config.layout.distDir + '/img/', {hasChanged: changed.compareSha1Digest}));

	if(config.layout.syncOnBuild)
		stream = stream.pipe(sftp
		({

			host: config.sftp.host,
			port: config.sftp.port,
			user: config.sftp.user,
			pass: config.sftp.pass,
			remotePath: (config.layout.remotePath ? config.layout.remotePath + '/img/' : config.sftp.remotePath + '/img/' )

		}));

	stream = stream.pipe(gulp.dest(config.layout.distDir + '/img/'));

	return stream;

});

gulp.task('build-font', ['clean'], function()
{

	var stream = gulp
					.src
					([

						config.layout.dir + '/src/font/**/*.eot',
						config.layout.dir + '/src/font/**/*.woff',
						config.layout.dir + '/src/font/**/*.ttf',
						config.layout.dir + '/src/font/**/*.svg'

					])
					.pipe(changed(config.layout.distDir + '/font/', {hasChanged: changed.compareSha1Digest}));

	if(config.layout.syncOnBuild)
		stream = stream.pipe(sftp
		({

			host: config.sftp.host,
			port: config.sftp.port,
			user: config.sftp.user,
			pass: config.sftp.pass,
			remotePath: (config.layout.remotePath ? config.layout.remotePath + '/font/' : config.sftp.remotePath + '/font/' )

		}));

	stream = stream.pipe(gulp.dest(config.layout.distDir + '/font/'));

	return stream;

});

gulp.task('build-css', ['clean'], function()
{

	var stream = gulp
					.src(config.layout.dir + '/src/less/style.less')
					.pipe(less())
					.pipe(minifyCSS())
					.pipe(rename('style.min.css'))
					.pipe(changed(config.layout.distDir + '/css/', {hasChanged: changed.compareSha1Digest}));

	if(config.layout.syncOnBuild)
		stream = stream.pipe(sftp
		({

			host: config.sftp.host,
			port: config.sftp.port,
			user: config.sftp.user,
			pass: config.sftp.pass,
			remotePath: (config.layout.remotePath ? config.layout.remotePath + '/css/' : config.sftp.remotePath + '/css/' )

		}));

	stream = stream.pipe(gulp.dest(config.layout.distDir + '/css/'));

	return stream;

});

gulp.task('build-js', ['clean'], function()
{

	var stream = gulp
					.src
					([

						'node_modules/jquery/dist/jquery.js',
						'node_modules/bootstrap/dist/js/bootstrap.js',
						config.layout.dir + '/src/js/**/*.js'

					])
					.pipe(concat('script.min.js'))
					.pipe(uglify())
					.pipe(changed(config.layout.distDir + '/js/', {hasChanged: changed.compareSha1Digest}));

	if(config.layout.syncOnBuild)
		stream = stream.pipe(sftp
		({

			host: config.sftp.host,
			port: config.sftp.port,
			user: config.sftp.user,
			pass: config.sftp.pass,
			remotePath: (config.layout.remotePath ? config.layout.remotePath + '/js/' : config.sftp.remotePath + '/js/' )

		}));

	stream = stream.pipe(gulp.dest(config.layout.distDir + '/js/'));

	return stream;

});
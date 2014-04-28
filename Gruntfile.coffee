module.exports = (grunt) ->
	# Project configuration.
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-compass'


	grunt.initConfig
		copy:
			static:
				files: [
					expand: true
					cwd: 'static/'
					src: ['**', '.htaccess']
					dest: 'public/'
				]
			vendor:
				files: [
					expand: true
					cwd: 'js/vendor/'
					src: ['**', '.htaccess'],
					dest: 'public/js/'
				]
		compass:
			dev:
				options:
					sassDir: 'sass'
					cssDir: 'public/css'
					fontsDir: 'public/css/fonts'
					debugInfo: true
					trace: true
					force: true
					relativeAssets: true
			prod:
				options:
					sassDir: 'sass'
					cssDir: 'public/css'
					fontsDir: 'alice/css/fonts'
					outputStyle: 'compressed'
					debugInfo: false
					trace: false
					force: false
					relativeAssets: false
		coffee:
			dev:
				options:
					sourceMap: true
				dest: 'public/js/app.js'
				src: [
					'js/**/*.coffee'
				]
				filter: 'isFile'
			prod:
				options:
					sourceMap: false
				dest: 'public/js/app.js'
				src: [
					'js/**/*.coffee'
				]
				filter: 'isFile'
		clean:
			public: ['public/']
			tmp: ['tmp/']
		watch:
			html:
				files: ['static/**/*']
				tasks: ['copy:static']
			js:
				files: [
					'js/**/*.coffee'
					'js/**/*.js'
				]
				tasks: ['coffee:dev']
			css:
				files: ['sass/**/*']
				tasks: ['compass:dev']

		grunt.registerTask 'default', ['dev']

		grunt.registerTask 'dev', [
			'copy:vendor'
			'copy:static'
			'compass:dev'
			'coffee:dev'
			'watch'
		]
		grunt.registerTask 'production', [
			'clean'
			'copy:vendor'
			'copy:static'
			'compass:prod'
			'coffee:prod'
		]
		grunt.registerTask 'heroku', ['production']
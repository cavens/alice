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
			vendor:
				files: [
					expand: true
					cwd: 'js/vendor/'
					src: ['**', '.htaccess'],
					dest: 'dist/js/'
				]
		compass:
			dev:
				options:
					sassDir: 'sass'
					cssDir: 'dist/css'
					fontsDir: 'dist/other'
					debugInfo: true
					trace: true
					force: true
					relativeAssets: true
			prod:
				src: 'sass'
				dest: 'dist/css'
				outputstyle: 'compressed'
				linecomments: false
				forcecompile: true
				debugsass: false
				relativeassets: true
		coffee:
			dev:
				options:
					sourceMap: true
				dest: 'dist/js/app.js'
				src: [
					'js/**/*.coffee'
				]
				filter: 'isFile'
			prod:
				options:
					sourceMap: false
				dest: 'dist/js/app.js'
				src: [
					'js/**/*.coffee'
				]
				filter: 'isFile'
		clean:
			dist: ['dist/']
			tmp: ['tmp/']
		watch:
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
			'compass:dev'
			'coffee:dev'
			'watch'
		]
		grunt.registerTask 'prod', [
			'clean'
			'copy:vendor'
			'compass:prod'
			'coffee:prod'
		]
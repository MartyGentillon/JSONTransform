module.exports = (grunt) ->
  allCoffeeFiles = ['gruntfile.coffee', 'src/**/*.coffee', 'test/**/*.coffee']

  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/json-transform.js': ['src/*.coffee']
        options:
          sourceMap: true
    mochaTest:
      test:
        options:
          reporter: 'spec'
        src: ['test/**/*.coffee']
    coffeelint:
      release:
        options:
          configFile: 'coffeelint-release.json'
        files:
          src: allCoffeeFiles
      dev:
        options:
          configFile: 'coffeelint.json'
        files:
          src: allCoffeeFiles
    coffee_jshint:
      files: allCoffeeFiles
      options:
        jshintOptions: ['node']




  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-coffee-jshint'

  grunt.registerTask 'default', ['coffee', 'mochaTest', 'coffeelint:release', 'coffee_jshint']
  grunt.registerTask 'test', ['mochaTest', 'coffeelint:dev']

module.exports = (grunt) ->
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
          src: ['gruntfile.coffee', 'src/**/*.coffee', 'test/**/*.coffee']
      dev:
        options:
          configFile: 'coffeelint.json'
        files:
          src: ['gruntfile.coffee', 'src/**/*.coffee', 'test/**/*.coffee']



  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['coffee', 'mochaTest', 'coffeelint:release']
  grunt.registerTask 'test', ['mochaTest', 'coffeelint:dev']

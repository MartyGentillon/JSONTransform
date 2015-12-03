module.exports = (grunt) ->
  allCoffeeFiles = ['gruntfile.coffee',
    'src/**/*.coffee',
    'test/**/*.coffee',
    'coverage/blanket.coffee']
  allTests = ['test/**/*.coffee']

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
          captureFile: 'reports/test_results.txt'
          require: 'coverage/blanket'
        src: allTests
      coverage:
        options:
          reporter: 'html-cov'
          quiet: true
          captureFile: 'reports/coverage.html'
        src: allTests
      live:
        options:
          reporter: 'spec'
          clearRequireCache: true
        src: allTests
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
    clean: ['lib', 'reports']
    watch:
      coffee:
        files: allCoffeeFiles
        tasks: ['coffee', 'mochaTest:live', 'coffeelint:dev', 'coffee_jshint']




  # consider failing build on insufficient coverage

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-coffee-jshint'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  # grunt.loadNpmTasks 'grunt-mocha-cov'
  # grunt.loadNpmTasks 'grunt-yaml-validator'

  grunt.registerTask 'default', ['coffee', 'mochaTest:test',
    'mochaTest:coverage', 'coffeelint:release', 'coffee_jshint']
  grunt.registerTask 'test', ['mochaTest:test', 'mochaTest:coverage',
    'coffeelint:dev', 'coffee_jshint']

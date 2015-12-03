# wrapper to instrument for coverage
path = require 'path'
srcDir = path.join(__dirname, '..', 'src')

require('blanket')(
  pattern:srcDir
  loader: './node-loaders/coffee-script'
)

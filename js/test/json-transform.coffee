assert = require('assert')
JSONTransform = require('../src/json-transform.coffee')
{describe, it} = require('mocha')

describe "baseline-test", ->
  it "should load jsonTransform", ->
    assert.equal(JSONTransform.verifyValue, 5, "it loaded")


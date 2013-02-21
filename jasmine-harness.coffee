attach = (obj) ->
  window[key] = obj[key] for key of obj

jasmine = require('./spec/lib/jasmine.js')

# attach jasmine to window
attach jasmine

html = require './spec/lib/jasmine-html.js'
tap = require './spec/lib/jasmine.tap_reporter.js'


# helper = require('./spec/SpecHelper')
# mock = require('./spec/Mock')
# expose helper
# expose mock

# insert test files here
# require('./spec/BaconSpec')
# require('./spec/PromiseSpec')()
# require('./spec/PerformanceTest')()

describe 'Basic Suite', ->
  it 'Should pass a basic truthiness test.', ->
    expect(true).toEqual(true)
    expect(false).toEqual(false)

startJasmine = ->
  jasmine.getEnv().addReporter new jasmine.TapReporter()
  jasmine.getEnv().execute()

currentWindowOnload = window.onload

window.onload = ->
  currentWindowOnload() if currentWindowOnload?
  setTimeout startJasmine, 1
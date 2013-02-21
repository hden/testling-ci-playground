window.isCommonJS = true # trick commonjs exports to work

runner = require('./spec/lib/jasmine.js')

# attach jasmine to window
window[key] = runner[key] for key of runner

html = require './spec/lib/jasmine-html.js'
tap = require './spec/lib/jasmine.tap_reporter.js'

# insert test files here
###
require.load './SpecHelper'
require.load './Mock'
require.load './BaconSpec'
require.load './PromiseSpec'
require.load './PerformanceTest'
###

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
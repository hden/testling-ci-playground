require.load './lib/jasmine.js'
# require.load './lib/jasmine-html.js'
# require.load './lib/jasmine.tap_reporter.js'

# insert test files here
###
require.load './SpecHelper'
require.load './Mock'
require.load './BaconSpec'
require.load './PromiseSpec'
require.load './PerformanceTest'
###

###
startJasmine = ->
  jasmine.getEnv().addReporter new jasmine.TapReporter()
  jasmine.getEnv().execute()

currentWindowOnload = window.onload

window.onload = ->
  currentWindowOnload() if currentWindowOnload?
  setTimeout startJasmine, 1
###
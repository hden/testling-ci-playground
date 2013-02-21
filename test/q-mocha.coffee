q = require 'q'

promiseHandler = (fn) ->
  (done) ->
    doneWasCalled = false
    value = fn.call(this, ->
      doneWasCalled = true
      done.apply this, arguments_
    )
    if q.isPromise(value)
      if doneWasCalled
        throw new Error("Promise was returned from test that called done")
      else
        value.then (->
          done() # ignore any "success" arguments
        ), done
    else
      done()  unless doneWasCalled
    value

# Override mocha's methods with promise-aware versions.
mocha_it = it
exports.it = (desc, fn) ->
  if fn then mocha_it(desc, promiseHandler(fn)) else mocha_it(desc)

exports.it.only = (desc, fn) ->
  if fn then mocha_it.only(desc, promiseHandler(fn)) else mocha_it.only(desc)

mocha_beforeEach = beforeEach
exports.beforeEach = (fn) ->
  mocha_beforeEach promiseHandler(fn)

mocha_afterEach = afterEach
exports.afterEach = (fn) ->
  mocha_afterEach promiseHandler(fn)
init = {}
p = require "particle"

buf = juno.Buffer.fromBlank juno.graphics.getSize!
_p = p 10, 10, .9, buf
_p\push 5,7
init.load = ->


init.update = (dt) ->
  _p\update!


init.draw = ->
  _p\draw!
  juno.graphics.copyPixels buf, 0, 0


init

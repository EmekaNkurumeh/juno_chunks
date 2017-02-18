init = {}
p = require "particle"
buf = juno.Buffer.fromBlank juno.graphics.getSize!
-- 18:21
init.load = ->


init.update = (dt) ->
  _p\update!


init.draw = ->
  _p\draw!
  juno.graphics.copyPixels buf, 0, 0


init

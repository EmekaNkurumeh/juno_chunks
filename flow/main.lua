init = require "init"

function juno.onLoad()
  init.load()
end

function juno.onUpdate(dt)
  init.update(dt)
end

function juno.onDraw()
  init.draw()
end

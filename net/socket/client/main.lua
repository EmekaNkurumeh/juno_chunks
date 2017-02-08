local client = require 'client'

function juno.onLoad()
  G.client = client(G.port, G.addr, G.title, G.updr)
  G.client:connect()
end

function juno.onUpdate(dt)
  G.client:update(dt)
end

function juno.onDraw()
  G.client:draw()
end

function juno.onKeyDown(key,char)
  G.client:input(key,char)
  if key == 'escape' then
    juno.onQuit()
    os.exit()
  end
end

function juno.onQuit()
  G.client:disconnect()
end

local client = require 'client'

function sol.onLoad()
  G.client = client(G.port, G.addr, G.title, G.updr)
  G.client:connect()
end

function sol.onUpdate(dt)
  G.client:update(dt)
end

function sol.onDraw()
  G.client:draw()
end

function sol.onKeyDown(key,char)
  G.client:input(key,char)
  if key == 'escape' then
    sol.onQuit()
    os.exit()
  end
end

function sol.onQuit()
  G.client:disconnect()
end

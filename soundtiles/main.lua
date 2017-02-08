Tile = require 'tile'
osc = require 'osc'

function juno.onLoad()
  juno.debug.setVisible(true)
  G.tile = {}
  for x = 1, 16 do
    G.tile[x] = {}
    for y = 1, 16 do
      local r, g, b
      r = (16 * x - 1) / 255
      g = (16 * y - 1) / 255
      b = ((16 * (y + x) / 2) - 1) / 255
      t = Tile((x*32)-32,(y*32)-32,32,32,{b,g,r},440,1)
      t:set_freq(400)
      t:set_amp(1)
      juno.audio.master:setCallback(t:set_gen('saw'))
      G.tile[x][y] = t
    end
  end
end

function juno.onUpdate(dt)

end

function juno.onDraw()
  for x = 1, 16 do
    for y = 1, 16 do
      tile = G.tile[x][y]
      tile:draw()
    end
  end
end

function juno.onKeyDown(key, char)
  if key == 'escape' then os.exit() end
end

-- function juno.onMouseMove(x, y)
--   gain = math.pow(1 - (y / juno.graphics.getWidth()), 1.8)
--   freq = math.pow(x / juno.graphics.getHeight(), 2) * 3000 + 120
-- end

function juno.onQuit()

end

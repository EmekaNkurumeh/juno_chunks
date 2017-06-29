Tile = require 'tile'
osc = require 'osc'

function sol.onLoad()
  sol.debug.setVisible(true)
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
      sol.audio.master:setCallback(t:set_gen('saw'))
      G.tile[x][y] = t
    end
  end
end

function sol.onUpdate(dt)

end

function sol.onDraw()
  for x = 1, 16 do
    for y = 1, 16 do
      tile = G.tile[x][y]
      tile:draw()
    end
  end
end

function sol.onKeyDown(key, char)
  if key == 'escape' then os.exit() end
end

-- function sol.onMouseMove(x, y)
--   gain = math.pow(1 - (y / sol.graphics.getWidth()), 1.8)
--   freq = math.pow(x / sol.graphics.getHeight(), 2) * 3000 + 120
-- end

function sol.onQuit()

end

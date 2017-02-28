local p = require "particle"
local perlin = require "perlin"
local rand = math.random
local floor = math.floor
local sin = math.sin
local cos = math.cos
local w, h = juno.graphics.getSize()

function refresh()
  G.particles = {}
  G.field = {}
  for i = 1, G.particle_count do
    local c = {rand(255) / 255, rand(255) / 255, rand(255) / 255}
    local particle = p:new(rand(w), rand(h), .9, G.screen, c)
    table.insert(G.particles, particle)
  end
end

function calculate_field()
  local sx = w / G.rows
  local sy = h / G.columns
  for x = 0, G.rows do
    if not G.field[x] then
      G.field[x] = {}
    end
    for y = 0, G.columns do
      if not G.field[x][y] then
        local v = {}
        v.dx = 0
        v.dy = 0
        G.field[x][y] = v
      end
      local rot = perlin:noise((x * sx) / 100, (y * sy)/ 100, G.drift) * 360
      G.field[x][y].dx = cos(rot)
      G.field[x][y].dy = sin(rot)
      if juno.debug.getVisible() then
        G.debug_screen:drawLine(x * sx, y * sy, x * sx + G.field[x][y].dx * 16, y * sy + G.field[x][y].dy * 16)
      end
    end
  end
end

function juno.onLoad()
  G.screen = juno.Buffer.fromBlank(juno.graphics.getSize())
  G.debug_screen = juno.Buffer.fromBlank(juno.graphics.getSize())
  perlin:load()
  calculate_field()
  refresh()
end

function juno.onUpdate(dt)
  calculate_field()
  for k, particle in ipairs(G.particles) do
    particle:update()
  end
  G.drift = G.drift + dt / 1000
  -- collectgarbage()
end

function juno.onKeyDown(key)
  if key == "tab" then
    juno.debug.setVisible(not juno.debug.getVisible())
    G.screen:setAlpha(juno.debug.getVisible() and .5 or 1)
  elseif key == "r" then
    juno.onLoad()
  elseif key == "escape" then
    os.exit()
  end
 end

function juno.onDraw()
  juno.graphics.drawBuffer(G.debug_screen, 0, 0)
  for k, particle in ipairs(G.particles) do
    particle:draw()
  end
  juno.graphics.drawBuffer(G.screen, 0, 0)
  G.debug_screen:clear()
  G.screen:clear()
end

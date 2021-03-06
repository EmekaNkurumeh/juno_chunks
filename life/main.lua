-- RULES
-- if neighbors <= 1 then "death"
-- if neighbors == 3 then "birth"
-- if neighbors > 4 then "death"
-- if neighbors > 2 and if neighbors < 3 "stasis"

local _ = require "lib.lume"
local coil = require "lib.coil"

math.randomseed(os.time())

local neighbors = {
  {-1, -1}, {0, -1}, {1, -1},
  {-1,  0},          {1,  0},
  {-1,  1}, {0,  1}, {1,  1}
}

coil.add(function()
  generate = coil.callback()
  while true do
    coil.wait(generate)
    for x = 0, G.width do
      for y = 0, G.height do
            
      end
    end
  end
end)

function init()
  for x = 0, G.width do
    G.cells[x] = {}
    for y = 0, G.height do
      G.cells[x][y] = false
    end
  end
end

function sol.onLoad()
  G.screen = sol.Buffer.fromBlank(G.width, G.height)
  G.cells = {}
  init()
end

function sol.onUpdate(dt)
  require("lib.stalker").update()
  collectgarbage()
  collectgarbage()
  coil.update(dt)
  generate()
end

function sol.onDraw()
  for x = 0, G.width do
    for y = 0, G.height do
      if G.cells[x][y] then 
        G.screen:drawPixel(x, y, 1, 1, 1, 1)
      else
        G.screen:drawPixel(x, y, 0, 0, 0, 1)
      end
    end
  end
  if G.mode == "pause" then
    G.screen:drawRect(64 - 2, 2, 1, 4, .8, .1, .3)
    G.screen:drawRect(64 - 4, 2, 1, 4, .8, .1, .3)
  else
  end
  sol.graphics.copyPixels(G.screen, 0, 0, nil, G.scale)
end

function sol.onKeyDown(k)
  local action = input[k]
  if action then return action() end
end

function sol.onMouseDown(x, y, button)
  if G.mode == "pause" then
    local x = math.floor(x/G.scale)
    local y = math.floor(y/G.scale)
    G.cells[x][y] = not G.cells[x][y]
  end
end

function sol.onQuit()
  for x = 0, G.width do
    for y = 0, G.height do
      G.cells[x][y] = nil
    end
  end
  collectgarbage()
  collectgarbage()
end

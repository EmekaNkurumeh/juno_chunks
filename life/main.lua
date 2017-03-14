-- RULES
-- if neighbors <= 1 then "death"
-- if neighbors == 3 then "birth"
-- if neighbors > 4 then "death"
-- if neighbors > 2 and if neighbors < 3 "stasis"

local _ = require "lib.lume"
local coil = require "lib.coil"

local Cell = require "cell"
math.randomseed(os.time())

coil.add(function()
  generate = coil.callback()
  while true do
    coil.wait(generate)
    if G.mode == "play" then
      for x = 0, G.width do
        for y = 0, G.height do
          G.cells[x][y]:update()
        end
      end
    end
  end
end)

function init()
  for x = 0, G.width do
    G.cells[x] = {}
    for y = 0, G.height do
      local cell = Cell(x, y)
      -- cell.alive = ({true, false})[_.weightedchoice{[1] = 1, [2] = 9}]
      G.cells[x][y] = cell
    end
  end
  for x = 4,5 do
    for y = 4, 5 do
      G.cells[x][y].alive = true
    end
  end
end

function juno.onLoad()
  G.screen = juno.Buffer.fromBlank(G.width, G.height)
  G.font = juno.Font.fromEmbedded(96)
  G.cells = {}
  init()
end

function juno.onUpdate(dt)
  require("lib.stalker").update()
  collectgarbage()
  collectgarbage()
  coil.update(dt)
  generate()
end

function juno.onDraw()
  for x = 0, G.width do
    for y = 0, G.height do
      G.cells[x][y]:draw()
    end
  end
  juno.graphics.copyPixels(G.screen, 0, 0, nil, G.scale)
end

function juno.onKeyDown(k)
  local action = input[k]
  if action then return action() end
end

function juno.onMouseDown(x, y, button)
  if G.mode == "pause" then
    local x = math.floor(x/G.scale)
    local y = math.floor(y/G.scale)
    G.cells[x][y].alive = not G.cells[x][y].alive
  end
end

function juno.onQuit()
  for x = 0, G.width do
    for y = 0, G.height do
      G.cells[x][y] = nil
    end
  end
  collectgarbage()
  collectgarbage()
end

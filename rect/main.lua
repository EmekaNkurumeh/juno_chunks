local Rect = require "rect"
local r1 = Rect(72, 72, 64, 64)
local r2 = Rect(128, 128, 64, 64)


function sol.onLoad()
end

function sol.onUpdate(dt)
  if sol.keyboard.isDown("left") then
    r2.x = r2.x - 4
  elseif sol.keyboard.isDown("right") then
    r2.x = r2.x + 4
  end

  if sol.keyboard.isDown("up") then
    r2.y = r2.y - 4
  elseif sol.keyboard.isDown("down") then
    r2.y = r2.y + 4
  end

  -- r1:reject(r2)
  r2:reject(r1)
end

function sol.onDraw()
  sol.graphics.drawBox(r1.x, r1.y, r1.width, r1.height)
  sol.graphics.drawBox(r2.x, r2.y, r2.width, r2.height)
end

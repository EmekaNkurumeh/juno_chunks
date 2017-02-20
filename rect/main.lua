local Rect = require "rect"
local r1 = Rect(72, 72, 64, 64)
local r2 = Rect(128, 128, 64, 64)


function juno.onLoad()
end

function juno.onUpdate(dt)
  if juno.keyboard.isDown("left") then
    r2.x = r2.x - 4
  elseif juno.keyboard.isDown("right") then
    r2.x = r2.x + 4
  end

  if juno.keyboard.isDown("up") then
    r2.y = r2.y - 4
  elseif juno.keyboard.isDown("down") then
    r2.y = r2.y + 4
  end

  -- r1:reject(r2)
  r2:reject(r1)
end

function juno.onDraw()
  juno.graphics.drawBox(r1.x, r1.y, r1.width, r1.height)
  juno.graphics.drawBox(r2.x, r2.y, r2.width, r2.height)
end

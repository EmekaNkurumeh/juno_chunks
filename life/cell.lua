local Object = require "lib.classic"

local Cell = Object:extend()

local check = {
  {-1, -1}, {0, -1}, {1, -1},
  {-1,  0},          {1,  0},
  {-1,  1}, {0,  1}, {1,  1}
}

function Cell:new(x, y)
  self.x = x
  self.y = y
  self.neighbors = 0
  self.alive = false
end

function Cell:update(dt)
  for __, t in ipairs(check ) do
    local r, g, b = G.screen:getPixel(self.x + t[1], self.y + t[2])
    if r ~= 0 and g ~= 0 and b ~= 0 then
      self.neighbors = self.neighbors + 1
    end
  end
  -- prin(self.neighbors)
  if self.neighbors < 2 then self.alive = false
  elseif self.neighbors > 3 then self.alive = false
  elseif self.alive == false and self.neighbors == 3  then self.alive = true
  else self.alive = self.alive end
end

function Cell:draw()
  if self.alive then
    return G.screen:drawPixel(self.x, self.y, 1, 1, 1)
  end
  return G.screen:drawPixel(self.x, self.y, 0, 0, 0)
end

return Cell

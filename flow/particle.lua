local particle = {}
particle.__index = particle

local w, h = sol.graphics.getSize()
local floor = math.floor

function  particle:new(x, y, drag, buf, color)
  local p = {}
  p.x = x or 0
  p.y = y or 0
  p.drag = drag or 0
  p.buf = buf
  p.px = p.x
  p.py = p.y
  p.vx = 0
  p.vy = 0
  p.color = color
  return setmetatable(p, particle)
end

function particle:push(x, y)
  self.vx = self.vx + (x or 0)
  self.vy = self.vx + (y or 0)
end

function particle:update()
  self.px, self.py = self.x, self.y
  self.vx = self.vx * self.drag
  self.vy = self.vy * self.drag
  self.x = self.x + self.vx
  self.y = self.y + self.vy
  self:edges()
  self:follow(G.field)
end

function particle:update_prev()
  self.px, self.py = self.x, self.y
end

function particle:edges()
  local w, h = self.buf:getSize()
  if self.x > w then
    self.x = self.x % w
    self:update_prev()
  elseif self.x < 0 then
    self.x = self.x % w
    self:update_prev()
  end
  if self.y > h then
    self.y = self.y % h
    self:update_prev()
  elseif self.y < 0 then
    self.y = self.y % h
    self:update_prev()
  end
end

function particle:follow(vec)
  local sx = w / G.rows
  local sy = h / G.columns
  local x = floor(self.x / sx)
  local y = floor(self.y / sy)
  if vec[x] and vec[x][y] then
    local v = vec[x][y]
    self:push(v.dx, v.dy)
  end
end

function particle:draw()
  -- self.buf:drawPixel(self.x, self.y, unpack(self.color))
  self.buf:drawLine(self.x, self.y, self.px, self.py, unpack(self.color))
end

function particle:__call(...)
  return self.new(...)
end

return setmetatable({}, particle)

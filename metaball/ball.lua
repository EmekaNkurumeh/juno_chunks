local Object = require "classic"

local Ball = Object:extend()

local w, h = G.screen:getSize()
local math_sqrt = math.sqrt
local function distance(x1, y1, x2, y2, squared)
  local dx = x1 - x2
  local dy = y1 - y2
  local s = dx * dx + dy * dy
  return squared and s or math_sqrt(s)
end

math.randomseed(os.time())


function Ball:new(x, y, r)
	self.x = x
	self.y = y
	self.r = r
	self.vx = 0
	self.vy = 0
	self.px = self.x
	self.py = self.y
	self:push(math.random(-0x5, 0x5), math.random(-0x5, 0x5))
end

function Ball:distance(x, y)
	return distance(x, y, self.x, self.y)
end

function Ball:push(x, y)
	self.vx = self.vx + (x or 0)
  self.vy = self.vy + (y or 0)
end

function Ball:update_prev()
  self.px, self.py = self.x, self.y
end

function Ball:edges()
  if self.x > w or self.x < 0 then
    self.vx = -self.vx
    self:update_prev()
  end
  if self.y > h or self.y < 0 then
    self.vy = -self.vy
    self:update_prev()
  end
end

function Ball:update(dt)
	self:update_prev()
  self.x = self.x + self.vx
  self.y = self.y + self.vy
  self:edges()
end

function Ball:show()
	G.screen:drawRing(self.x, self.y, self.r, 1, 0, 0)
end

return Ball
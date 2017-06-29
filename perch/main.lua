local width, height = sol.graphics.getSize()
local txt = sol.Font.fromEmbedded(16):render("No project loaded")
local txtPost = txt:clone()
local txtMask = txt:clone()
local particle_count = 64
local particles = {}

local sqrt = math.sqrt
local floor = math.floor
local ceil = math.ceil
local sin = math.sin

local function round(x)
  return x >= 0 and floor(x + .5) or ceil(x - .5)
end

local function random(a, b)
  if not a then a, b = 0, 1 end
  if not b then b = 0 end
  return a + math.random() * (b - a)
end

function sol.onLoad()
	math.randomseed(sol.time.getNow())
	sol.debug.setVisible(true)
	sol.graphics.setClearColor(0.15, 0.15, 0.15)
  for i = particle_count, 1, -1 do
  	local p = {
  		x  = random(width),
  		y  = random(height),
  		vx = random() * ({-1, 1})[round(random(1, 2))],
  		vy = random() * ({1, -1})[round(random(1, 2))],
		}
  	particles[i] = p
  end
end

function sol.onUpdate(dt)
  for i = particle_count, 1, -1 do
		local p = particles[i]
		if p.x >= (width + 16) or p.x < -16 then
			p.vx = -p.vx
		end
		if p.y >= (height + 16) or p.y < -16 then
			p.vy = -p.vy
		end
		p.x = p.x + p.vx
  	p.y = p.y + p.vy
  end
end

function sol.onDraw()
	-- Draw particles
	sol.graphics.setBlend("add")
  for i = particle_count, 1, -1 do
  	local p = particles[i]
  	sol.graphics.drawCircle(p.x, p.y, 4)
		for j = particle_count, 1, -1 do
			local o = particles[j]
			if sqrt((p.x - o.x)^2 + (p.y - o.y)^2) < 80 then
				sol.graphics.drawLine(p.x, p.y, o.x, o.y)
			end
		end
  end
	-- Draw text
	local n = sol.time.getTime() * 2
  local x = (1 + sin(n)) * txtMask:getWidth() / 2
  txtPost:copyPixels(txt)
  txtMask:clear(1, 1, 1, .5)
  txtMask:drawRect(x - 10, 0, 20, 100, 1, 1, 1, .6)
  txtMask:drawRect(x -  5, 0, 10, 100, 1, 1, 1, 1)
	sol.bufferfx.mask(txtPost, txtMask)
  local tx, ty = (height - txt:getWidth()) / 2, (height - txt:getHeight()) / 2
  sol.graphics.reset()
	sol.graphics.draw(txtPost, tx, ty + 130)
end

function sol.onKeyDown(k)
	if k == "escape" then
		sol.system.quit()
	end
end

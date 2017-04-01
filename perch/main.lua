local framebuffer = juno.Buffer.fromBlank(G.width, G.height)
local postbuffer = framebuffer:clone()
local bgcolor = { 0x28 / 0xFF , 0x00 / 0xFF , 0x50 / 0xFF , 0xFF / 0xFF }
local particle_count = 32
local particles = {}

function juno.onLoad()
	math.randomseed(os.time())
  for i = particle_count, 1, -1 do
  	local particle = {
  		x  = math.random(G.width),
  		y  = math.random(G.height),
  		vx = math.random(16),
  		vy = math.random(16),
  	}

  end
end

function juno.onUpdate(dt)
  require("lib.stalker").update()
  collectgarbage()
  collectgarbage()
end

function juno.onDraw()
	postbuffer = framebuffer:clone()
  framebuffer:clear(unpack(bgcolor))
  framebuffer:reset()
  -- do drawing of members
  juno.graphics.copyPixels(framebuffer, 0, 0)
end

function juno.onKeyDown(key, char)
	  if key == "tab" then
    local mode = not juno.debug.getVisible()
    juno.debug.setVisible(G.debug and mode)
  elseif key == "escape" then
    juno.onQuit()
    os.exit()
  elseif key == "r" and G.debug then
    juno.onLoad()
  end
end

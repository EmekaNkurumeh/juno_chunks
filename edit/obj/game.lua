local Game = require "lib.classic"
local _ = require "lib.lume"

function Game:new()
  error("use Game.init() instead")
end

function Game.init(width, height, color)
  Game.bgcolor = Color[color] and Color[color] or { _.color("#320065") }

  Game.width = width or G.width
  Game.height = height or G.height

  Game.framebuffer = sol.Buffer.fromBlank(G.width, G.height)
  Game.postbuffer = Game.framebuffer:clone()
end

function Game.update(dt)
  require("lib.stalker").update()
  collectgarbage()
  collectgarbage()
end

function Game.draw()
  Game.postbuffer = Game.framebuffer:clone()
  Game.framebuffer:clear(unpack(Game.bgcolor))
  Game.framebuffer:reset()
  -- do drawing of members
  sol.graphics.copyPixels(Game.framebuffer, 0, 0)
end

function Game.key(key, char)
  if key == "tab" then
    local mode = not sol.debug.getVisible()
    sol.debug.setVisible(G.debug and mode)
  elseif key == "`" then
    local mode = not sol.debug.getFocused()
    sol.debug.setFocused(G.debug and mode)
  elseif key == "escape" then
    sol.onQuit()
    os.exit()
  elseif key == "r" and G.debug then
    sol.onLoad()
  end
end

return Game

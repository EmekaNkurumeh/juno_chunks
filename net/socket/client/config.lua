function init()
  dofile("../../init.lua")
  require("moonscript")
  require("socket")
end

xpcall(init, os.exit)
require("moonscript")
math.randomseed(os.time())

G =  {
  title = ('%06x'):format(math.random(0xffffff)),
  width = 144,
  height = 144,
  scale = 4,
  port = sol._argv[3],
  addr = sol._argv[4],
  updr = sol._argv[5],
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale,
}

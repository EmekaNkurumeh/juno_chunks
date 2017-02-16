function init()
  dofile("../../init.lua")
  require("moonscript")
  require("enet")
end

xpcall(init, os.exit)
require("moonscript")
math.randomseed(os.time())

G =  {
  title = ('%06x'):format(math.random(0xffffff)),
  width = 144,
  height = 144,
  scale = 4,
  port = juno._argv[3],
  addr = juno._argv[4],
  updr = juno._argv[5],
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale,
}

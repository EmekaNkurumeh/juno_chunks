function init()
  dofile "init.lua"
  require "moonscript"
end

xpcall(init, os.exit)
require("moonscript")

math.randomseed(os.time())

G =  {
  title = 'soundtiles',
  width = 128,
  height = 128,
  scale = 4,
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale,
}

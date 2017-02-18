require("moonscript")
math.randomseed(os.time())

G =  {
  title = "flow",
  width = 144,
  height = 144,
  scale = 4,
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale,
}

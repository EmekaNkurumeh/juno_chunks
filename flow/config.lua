math.randomseed(os.time())
G =  {
  title = "flow",
  width = 144,
  height = 144,
  scale = 4,
  drift = 1,
  particle_count = 30000,
  rows = 16,
  columns = 16,
  particles = {},
  field = {}
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale,
}

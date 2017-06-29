G = {
  title   = "metaballs",
  width  = 256,
  height = 256,
  scale  = 2,
  balls = {}
}

return {
  title     = G.title,
  width     = G.width * G.scale,
  height    = G.height * G.scale
}
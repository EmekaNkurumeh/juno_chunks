pi = math.pi

function sol.onLoad()
  math.randomseed(os.time())
  G.timer = 0
  cir = {
    x = (G.width/2)*G.scale,
    y = (G.height/2)*G.scale,
    r = math.random(1,128)
  }
end

function sol.onUpdate(dt)
  G.fps = sol.time.getFps()
  interval = 1
  cir.o = 256*(math.sin(G.timer * 0.5 * pi / (G.fps*interval)))
  G.timer = G.timer + 1
end

function sol.onDraw()
  sol.graphics.drawCircle(cir.x,cir.y+cir.o,cir.r)
end

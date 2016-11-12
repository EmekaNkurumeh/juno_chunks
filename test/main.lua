local tick = require("tick")

image = {
  frames = 3,
  width = 8,
  height = 13,
  x = 64,
  y = 64,
  anfm = 0,
}
function play()
  image.anfm = image.anfm + 1
  if image.anfm > image.frames then
    image.anfm = 1
  end
end
screen = juno.Buffer.fromBlank(juno.graphics.getSize())
animlayer = juno.Buffer.fromBlank(image.width,image.height)
function juno.onLoad()
  juno.debug.setVisible(true)
  image.data = juno.Buffer.fromFile("zombie.png")
end
function juno.onUpdate(dt)
  require("stalker").update(dt)
  tick.update(dt)
  print(image.anfm)
  -- play()

end
tick.recur(function() play() end, .1)

function juno.onDraw()
  screen:drawRect(0,0,256,256,unpack{1,1,1})

  screen:drawBuffer(image.data,image.x,image.y,{x = 0+(1*(image.anfm*image.width)), y = 0, w = 8, h = 13})
  -- animlayer:copyPixels(image.data,0,0,{x = 0, y = 0, w = 8, h = 13})
  juno.graphics.copyPixels(screen,0,0,nil,4)
end

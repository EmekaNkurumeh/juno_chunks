-- local Ball = require "ball"

function juno.onLoad()
  G.screen = juno.Buffer.fromBlank(G.width, G.height)
  local ball = require "ball"
  for i = 1, 10 do 
    local b = ball(i + 1, i + 1, 5)
    G.balls[#G.balls + 1] = b
    juno.time.sleep(.3)

  end
end

function juno.onUpdate()
  for _, ball in pairs(G.balls) do
    ball:update()
  end
end

function juno.onDraw()
  for x = 0, G.width do 
    for y = 0, G.height do
      local sum = 0
      for _, ball in ipairs(G.balls) do
        local d = ball:distance(x, y)
        sum = sum + (ball.r / d)
      end
      G.screen:drawPixel(x, y, unpack{sum, .5, .7})
    end
  end
  juno.graphics.copyPixels(G.screen, 0, 0, nil, G.scale)
  G.screen:clear()
end
local math_sqrt = math.sqrt
local Min, Max = 1, 1
math.randomseed(os.time())


function sol.onLoad()
  G.screen = sol.Buffer.fromBlank(G.width, G.height)
  G.result = sol.Buffer.fromBlank(G.width / 4, G.height / 4)
  local ball = require "ball"
  for i = 1, 10 do 
    local b = ball()
    G.balls[#G.balls + 1] = b
    sol.time.sleep(.3)
  end
end

function sol.onUpdate()
  G.balls[1].x = sol.mouse.getX()/G.scale
  G.balls[1].y = sol.mouse.getY()/G.scale
  for _, ball in pairs(G.balls) do
    ball:update()
  end
end

function metaball(b, x, y)
  return b.r / math_sqrt((x - b.x)^2 + (y - b.y)^2)
end

function sol.onDraw()
  for x = 0, G.width do
    for y = 0, G.height do
      sum = 0
      for _, ball in ipairs(G.balls) do
        -- ball:show()
        sum = sum + metaball(ball, x, y)
        -- sum = sum + ((ball.r^2) / (x - ball.x)^2 + (y - ball.y) ^2)
      end
      -- G.screen:drawPixel(x, y, 1,1,1)
    end
  end

  sol.graphics.copyPixels(G.screen, 0, 0, nil, G.scale)
  -- sol.graphics.copyPixels(G.result, 0, 0, nil, G.scale)
  G.screen:clear()
  G.result:clear()
end
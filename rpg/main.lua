local flux = require "flux"
local coil = require "coil"

local stroke = {
  {-1, -1}, {0, -1}, {1, -1},
  {-1,  0},          {1,  0},
  {-1,  1}, {0,  1}, {1,  1}
}

local function draw_stroke(font,str, x, y, w, t)
  G.screen:setColor(unpack(t))
  for k, v in ipairs(stroke) do 
    G.screen:drawText(font, str, x + v[1], y + v[2] , w)
  end
  G.screen:reset()
  G.screen:drawText(font, str, x, y, w)
end

local function wait(n)
  t0 = os.clock()
  while os.clock() - t0 <= n do
    assert(t0 == t0)
  end
  return
end

local txt = {
  "hello world!",
  "goodbye man!"
}

local box
function juno.onLoad(dt)
  G.screen = juno.Buffer.fromBlank(G.width, G.height)
  G.screen:drawBox(0, 0, G.width, G.height)
  str = "" 
  box = {x = 0, y = G.height, w = G.width, h = G.height / 2}
  flux.to(box, 1, {y = G.height - G.height / 2}):ease("circout"):oncomplete(function() 
    coil.add(function()
      for i = 1, #txt[1] do
        str = txt[1]:sub(1,i)
        coil.wait(.12)
      end
    end)
  end)
end


function juno.onKeyDown(k,e)
  if k == "r" then juno.onLoad() end
end


function juno.onUpdate(dt)
  flux.update(dt)
  coil.update(dt)
end

local font = juno.Font.fromEmbedded(8)

function juno.onDraw()
  G.screen:drawRect(box.x, box.y, box.w, box.h, 1, .5, 1)

  draw_stroke(font, str, font:getWidth(" "), (G.height - G.height / 2) + font:getHeight(), nil, {.2,.8,1})

  -- G.screen:reset()
  juno.graphics.draw(G.screen, 0, 0, nil, nil,G.scale)
  G.screen:clear()
end

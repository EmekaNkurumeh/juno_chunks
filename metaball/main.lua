function distance(x1, y1, x2, y2)
  return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

function juno.onLoad()
  G.screen = juno.Buffer.fromBlank(G.width, G.height)
  for x = 0, G.width do 
    for y = 0, G.height do
      local d = distance(G.width / 2, G.height / 2, x, y) / 255
      G.screen:setPixel(x, y, unpack{d, d, d})
    end
  end
end

function juno.onUpdate()
  -- body
end

function juno.onDraw()
  juno.graphics.copyPixels(G.screen, 0, 0, nil, G.scale)
  -- G.screen:clear()
end
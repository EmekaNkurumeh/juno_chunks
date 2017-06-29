G = {
  title = "life",
  mode = "pause",
  width = 64,
  height = 64,
  scale = 8,
}

input = {
  ["up"] = function()

  end,
  ["down"] = function()

  end,
  ["left"] = function()

  end,
  ["right"] = function()

  end,
  ["tab"] = function()
    sol.debug.setVisible(not sol.debug.getVisible())
  end,
  ["escape"] = function()
    if sol.onQuit then sol.onQuit() end
    os.exit()
  end,
  ["p"] = function()
    G.mode = G.mode == "pause" and "play" or "pause"
  end,
  ["r"] = function()
    for x = 0, G.width do
      for y = 0, G.height do
        G.cells[x][y] = nil
      end
    end
    collectgarbage()
    collectgarbage()
    -- init()
    sol.onLoad()
  end
}

function prin(...)
  io.write(..., "\n")
end

return {
  title = G.title,
  width = 128 * 4,
  height = 128 * 4,
}

local _ = require "lib.lume"

G = {
  author = "emekamonkey",
  version = "0.1.0",
  license = "MIT",
  title = "p8",
  width = 512,
  height = 512,
  scale = 8,
  debug = true,
}

Color = {
  ["black"]       = { _.color("#000000") },
  ["dark-blue"]   = { _.color("#1d2b53") },
  ["dark-purple"] = { _.color("#7e2553") },
  ["dark-green"]  = { _.color("#008751") },
  ["brown"]       = { _.color("#ab5236") },
  ["dark-grey"]   = { _.color("#5f574f") },
  ["light-grey"]  = { _.color("#c2c3c7") },
  ["white"]       = { _.color("#fff1e8") },
  ["red"]         = { _.color("#ff004d") },
  ["orange"]      = { _.color("#ffa300") },
  ["yellow"]      = { _.color("#ffec27") },
  ["green"]       = { _.color("#00e436") },
  ["blue"]        = { _.color("#29adff") },
  ["indigo"]      = { _.color("#83769c") },
  ["pink"]        = { _.color("#ff77a8") },
  ["peach"]       = { _.color("#ffccaa") },
}

return {
  title = G.title,
  width = G.width,
  height = G.height
}

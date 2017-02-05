class Tile
  new: (x, y, w, h, c, t) =>
    @x = x or 0
    @y = y or 0
    @width = w or 0
    @height = h or 0
    @color = c or {1, 1, 1}
    @tone = t or 16
    @buf = juno.Buffer.fromBlank @width, @height
  update: (dt) =>
    if false
      @play!
  draw: () =>
    @buf\drawRect 0, 0, @width, @height, unpack @color
    juno.graphics.copyPixels @buf, @x, @y, nil


Tile

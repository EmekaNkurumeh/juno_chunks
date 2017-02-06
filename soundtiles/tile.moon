osc = require 'osc'

class Tile
  new: (x, y, w, h, c) =>
    @x = x or 0
    @y = y or 0
    @width = w or 0
    @height = h or 0
    @color = c or {1, 1, 1}
    @buf = juno.Buffer.fromBlank @width, @height
    @sound = juno.Source.fromBlank!

  set_freq: (@freq) =>

  set_amp: (@amp) =>

  set_gen: (generator) =>
    cb = (t) ->
      switch generator
        when 'sqr' gen = osc.sqr @freq, @amp
        when 'tri' gen = osc.tri @freq, @amp
        when 'saw' gen = osc.saw @freq, @amp
        when 'sin' gen = osc.sin @freq, @amp
        when 'wht' gen = osc.wht!
        when 'pnk' gen = osc.pnk!
        else gen = osc.wht!
      for i = 1, #t, 2
        out = gen i
        t[i], t[i + 1] = out, out
    @sound\setCallback cb


  update: (dt) =>
    if false
      @play!
  draw: () =>
    @buf\drawRect 0, 0, @width, @height, unpack @color
    juno.graphics.copyPixels @buf, @x, @y, nil

  -- G.tile[1][1].sound:setCallback(function(t)
  --   local gen = osc.wht()
  --   for i = 1, #t, 2 do 
  --     out = gen()
  --     t[i], t[i + 1] = out, out
  --   end
  -- end)

Tile

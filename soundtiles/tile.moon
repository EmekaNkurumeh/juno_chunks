osc = require 'osc'

class Tile
  new: (x, y, w, h, c) =>
    @x = x or 0
    @y = y or 0
    @width = w or 0
    @height = h or 0
    @color = c or {1, 1, 1}
    @buf = juno.Buffer.fromBlank @width, @height

  set_freq: (@freq) =>

  set_amp: (@amp) =>

  set_gen: (generator) =>
    local gen
    local delay
    delay = { idx: 0, max: 44100 * .4 }
    switch generator
      when 'sqr' gen = osc.sqr @freq, @amp
      when 'tri' gen = osc.tri @freq, @amp
      when 'saw' gen = osc.saw @freq, @amp
      when 'sin' gen = osc.sin @freq, @amp
      when 'wht' gen = osc.wht!
      when 'pnk' gen = osc.pnk!
      else gen = osc.wht!
    (t) ->
      for i = 1, #t, 2
        dt = 1 / 44100
        phase = @freq * .005 + dt
        out = gen i % phase
        out *= .05
        out += (delay[delay.idx] or 0) * .5
        delay[delay.idx] = out
        delay.idx = (delay.idx + 1) % delay.max
        t[i], t[i + 1] = out, out

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

math.randomseed(os.time!)
rand = math.random
floor = math.floor
sin = math.sin
cos = math.cos
wht = (amp) ->
  amp or= 1
  tb = :amp
  mtb= __call: => @amp * (math.random! * 2 - 1)
  setmetatable tb, mtb

pnk = (amp) ->
  amp or= 1
  tb = :amp, last: 0
  mtb = __call: =>
    @last = math.max(-1, math.min(1, @last + math.random! * 2 - 1))
    @amp * @last
  setmetatable tb, mtb

sx = 1
sy = 1

class 
  new: (@x, @y, @drag, @buf) =>
    @px = @x
    @py = @y
    @vx = 0
    @vy = 0

  push: (x, y) =>
    @vx += @x
    @vy += @y

  update: () =>
    @px, @py = @x, @y
    -- @vx *= @drag
    -- @vy *= @drag
    @x += @vx
    @y += @vy

  update_prev: () =>
    @px, @py = @x, @y

  edges: () =>
    w, h = @buf\getWidth!, @buf\getHeight!
    @x %= w
    @y %= h

  draw: () =>
    -- @buf\drawPixel @x, @y
    -- @edges!
    @buf\drawLine sin(@x)*1, @y, @px, @py

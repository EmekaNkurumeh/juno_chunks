sqr = (freq, amp) ->
  amp or= 1
  tb = :freq, :amp
  mtb = __call: (t) => ((@freq * t) % 1) > .5 and @amp or -@amp
  setmetatable tb, mtb

tri = (freq, amp) ->
  amp or= 1
  tb = :freq, :amp
  mtb = __call: (t) =>
    t = (@freq * t) % 1
    t < .5 and @amp * (4 * t - 1) or @amp * (3 - 4 * t)
  setmetatable tb, mtb

saw = (freq, amp) ->
  amp or= 1
  tb = :freq, :amp
  mtb = __call: (t) =>
    t = (@freq * t) % 1
    @amp * (2 * t - 1)
  setmetatable tb, mtb

sin = (freq, amp) ->
  amp or= 1
  tb = :freq, :amp
  mtb = __call: (t) =>
    t = (@freq * t) % 1
    @amp * math.sin(2 * math.pi * t)
  setmetatable tb, mtb

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

{:sqr, :tri, :saw, :sin, :wht, :pnk}

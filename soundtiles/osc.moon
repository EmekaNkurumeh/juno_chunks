sqr = (freq, amp) ->
  amp or= 1
  (t) -> ((freq * t) % 1) > .5 and amp or -amp

tri = (freq, amp) ->
  amp or= 1
  (t) ->
    t = (freq * t) % 1
    t < .5 and amp * (4 * t - 1) or amp * (3 - 4 * t)

saw = (freq, amp) ->
  amp or= 1
  (t) ->
    t = (freq * t) % 1
    amp * (2 * t - 1)

sin = (freq, amp) ->
  amp or= 1
  (t) ->
    t = (freq * t) % 1
    amp * math.sin(2 * math.pi * t)

wht = (amp) ->
  amp or= 1
  -> amp * (math.random! * 2 - 1) 

pnk = (amp) ->
  amp or= 1
  last = 0
  ->
    last = math.max(-1, math.min(1, last + math.random! * 2 - 1))
    amp * last
    
{:sqr, :tri, :saw, :sin, :wht, :pnk}

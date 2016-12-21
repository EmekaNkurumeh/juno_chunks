G = {
  box = {
    x = (juno.graphics.getWidth()/2)-128,
    y = (juno.graphics.getHeight()/2)-64,
    w = 128,
    h = 128,
    r = 0
  },
  gun = {
    x = (juno.graphics.getWidth()/2)-64,
    y = (juno.graphics.getHeight()/2)-16,
    r = 0
  }
}

function juno.onLoad()
  G.box_s = juno.Buffer.fromBlank(G.box.w,G.box.h)
  G.box_s:floodFill(0,0,unpack{.45,.89,.28})  
  
  G.gun_a = juno.Buffer.fromBlank(32,4)
  G.gun_a:floodFill(0,0,unpack{0,1,1})  
  
  G.gun_s = juno.Buffer.fromFile("penguinpistol.png")
  
end

function juno.onUpdate(dt)
  G.gun.r = math.atan2((juno.mouse.getY() - G.gun.y), (juno.mouse.getX() - G.gun.x))
  if juno.mouse.isDown("left") then
    print"blam"
  end
  if juno.mouse.isDown("right") then
    print"!!kablam!!"
  end
end



function juno.onDraw()
  juno.graphics.clear(50/255,23/255,76/255)

  juno.graphics.drawBuffer(G.box_s,G.box.x,G.box.y,nil,G.box.r)
  juno.graphics.drawBuffer(G.gun_a,G.gun.x,G.gun.y,nil,G.gun.r,4)
  juno.graphics.drawBuffer(G.gun_s,G.gun.x+math.cos(G.gun.r),G.gun.y+math.sin(G.gun.r),nil,G.gun.r,4,4,-(G.gun_a:getWidth()-6),10)
end

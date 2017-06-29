G = {
  box = {
    x = (sol.graphics.getWidth()/2)-128,
    y = (sol.graphics.getHeight()/2)-64,
    w = 128,
    h = 128,
    r = 0
  },
  gun = {
    x = (sol.graphics.getWidth()/2)-64,
    y = (sol.graphics.getHeight()/2)-16,
    r = 0
  }
}

function sol.onLoad()
  G.box_s = sol.Buffer.fromBlank(G.box.w,G.box.h)
  G.box_s:floodFill(0,0,unpack{.45,.89,.28})  
  
  G.gun_a = sol.Buffer.fromBlank(32,4)
  G.gun_a:floodFill(0,0,unpack{0,1,1})  
  
  G.gun_s = sol.Buffer.fromFile("penguinpistol.png")
  
end

function sol.onUpdate(dt)
  G.gun.r = math.atan2((sol.mouse.getY() - G.gun.y), (sol.mouse.getX() - G.gun.x))
  if sol.mouse.isDown("left") then
    print"blam"
  end
  if sol.mouse.isDown("right") then
    print"!!kablam!!"
  end
end



function sol.onDraw()
  sol.graphics.clear(50/255,23/255,76/255)

  sol.graphics.drawBuffer(G.box_s,G.box.x,G.box.y,nil,G.box.r)
  sol.graphics.drawBuffer(G.gun_a,G.gun.x,G.gun.y,nil,G.gun.r,4)
  sol.graphics.drawBuffer(G.gun_s,G.gun.x+math.cos(G.gun.r),G.gun.y+math.sin(G.gun.r),nil,G.gun.r,4,4,-(G.gun_a:getWidth()-6),10)
end

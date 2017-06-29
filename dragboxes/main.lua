x = 256 
y = 256

function sol.onUpdate(dt)
  if sol.mouse.isDown("left") then
    x,y = sol.mouse.getPosition()
  end
end

function sol.onDraw()
	sol.graphics.drawBox(0,0,x,y,unpack{.34,.72,.7})
	sol.graphics.drawBox(0,500-y,x,y,unpack{.98,.893,.92})
	sol.graphics.drawBox(500-x,0,x,y,unpack{.7823,.904,.9023})
	sol.graphics.drawBox(500-x,500-y,x,y,unpack{.189,.9504,.903})
end


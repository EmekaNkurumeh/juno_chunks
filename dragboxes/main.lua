x = 256 
y = 256

function juno.onUpdate(dt)
  if juno.mouse.isDown("left") then
    x,y = juno.mouse.getPosition()
  end
end

function juno.onDraw()
	juno.graphics.drawBox(0,0,x,y,unpack{.34,.72,.7})
	juno.graphics.drawBox(0,500-y,x,y,unpack{.98,.893,.92})
	juno.graphics.drawBox(500-x,0,x,y,unpack{.7823,.904,.9023})
	juno.graphics.drawBox(500-x,500-y,x,y,unpack{.189,.9504,.903})
end


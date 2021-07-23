local toggle=false
local zoom=1
local zoomRate=0.1
local mapFile="images/radar.jpg"

local zoomIn=getBoundKeys("radar_zoom_in")
local zoomOut=getBoundKeys("radar_zoom_out")
local moveUp=getBoundKeys("radar_move_north")
local moveDown=getBoundKeys("radar_move_south")
local moveLeft=getBoundKeys("radar_move_west")
local moveRight=getBoundKeys("radar_move_east")

local moveDirection
local zoomDirection
local xOffset=0
local yOffset=0

toggleControl("radar",false)

function drawMap()
	if toggle then
		if zoomDirection then
			if zoomDirection=="in" then
				if zoom<=5-zoomRate then
					zoom=zoom+zoomRate
				end
			elseif zoomDirection=="out" then
				if zoom>=1+zoomRate then
					zoom=zoom-zoomRate
				end
			end
		end
		
		if moveDirection then
			if moveDirection=="up" then
				yOffset=yOffset+1*zoom
			elseif moveDirection=="down" then
				yOffset=yOffset-1*zoom
			elseif moveDirection=="left" then
				xOffset=xOffset+1*zoom
			elseif moveDirection=="right" then
				xOffset=xOffset-1*zoom
			end
		end
		
		local w,h=guiGetScreenSize()
		local size=h*zoom
		local x=w/2-size/2+xOffset
		local y=h/2-size/2+yOffset
		
		dxDrawImage(x,y,size,size,mapFile,0,0,0,tocolor(255,255,255,175),false)
		
		for k,v in ipairs(getElementsByType("blip")) do
			local bx,by,bz=getElementPosition(v)
			local icon=getBlipIcon(v)
			if icon<10 then
				icon="0"..icon
			else
				icon=tostring(icon)
			end
			local bsize=getBlipSize(v)
			local r,g,b,a=getBlipColor(v)
			bx=math.round(x+(bx+3000)*size/6000)
			by=math.round(y-(by-3000)*size/6000)
			if icon~="00" then
				dxDrawImage(bx-4*bsize,by-4*bsize,8*bsize,8*bsize,"images/blips/"..icon..".png",0,0,0,tocolor(255,255,255,a),false)
			else
				dxDrawImage(bx-2*bsize,by-2*bsize,4*bsize,4*bsize,"images/blips/01.png",0,0,0,tocolor(0,0,0,a),false)
				dxDrawRectangle(bx-2*bsize+1,by-2*bsize+1,4*bsize-2,4*bsize-2,tocolor(r,g,b,a),false)
			end
		end
		
		local bx,by,bz=getElementPosition(getLocalPlayer())
		local brz=getPedRotation(getLocalPlayer())
		bx=math.round(x+(bx+3000)*size/6000)
		by=math.round(y-(by-3000)*size/6000)
		dxDrawImage(bx-8,by-8,16,16,"images/blips/02.png",360-brz,0,0,tocolor(255,255,255,255),false)
	end
end
addEventHandler("onClientRender",getRootElement(),drawMap)

function toggleMap()
	toggle=not toggle
end
bindKey("F11","down",toggleMap)

function zoomHandler(key,state)
--	outputDebugString(tostring(key))
	if table.find(zoomIn,key) then
		if state=="down" then
			zoomDirection="in"
		else
			zoomDirection=nil
		end
	elseif table.find(zoomOut,key) then
		if state=="down" then
			zoomDirection="out"
		else
			zoomDirection=nil
		end
	end
end
for k,v in ipairs(zoomIn) do
	bindKey(v,"both",zoomHandler)
end
for k,v in ipairs(zoomOut) do
	bindKey(v,"both",zoomHandler)
end

function radarMovementHandler(key,state)
	if state=="down" then
		if table.find(moveUp,key) then
			moveDirection="up"
		elseif table.find(moveDown,key) then
			moveDirection="down"
		elseif table.find(moveLeft,key) then
			moveDirection="left"
		elseif table.find(moveRight,key) then
			moveDirection="right"
		end
	else
		moveDirection=nil
	end
end
for k,v in ipairs(moveUp) do
	bindKey(v,"both",radarMovementHandler)
end
for k,v in ipairs(moveDown) do
	bindKey(v,"both",radarMovementHandler)
end
for k,v in ipairs(moveLeft) do
	bindKey(v,"both",radarMovementHandler)
end
for k,v in ipairs(moveRight) do
	bindKey(v,"both",radarMovementHandler)
end

function table.find(table,value)
	for k,v in ipairs(table) do
		if v==value then
			return true
		end
	end
	return false
end

function math.round(number,decimals)
	decimals=decimals or 0
	number=number*10^decimals
	return math.floor(number+0.5)/10^decimals
end

function getPlayerMapBoundingBox()
	if toggle==true then
		local w,h=guiGetScreenSize()
		local size=h*zoom
		local x1=w/2-size/2+xOffset
		local y1=h/2-size/2+yOffset
		local x2=w/2+size/2+xOffset
		local y2=h/2+size/2+yOffset
		return x1,y1,x2,y2
	end
	return false
end

function isPlayerMapVisible()
	return toggle
end
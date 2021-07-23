local screenW, screenH = guiGetScreenSize()

    r_title = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":personajes/fonts/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 )

 for i = 0, 4 do
     setInteriorFurnitureEnabled(i, false)
 end


function isCursorHover( posX, posY, width, height )
    if isCursorShowing( ) then
        local mouseX, mouseY = getCursorPosition( )
        local clientW, clientH = guiGetScreenSize( )
        local mouseX, mouseY = mouseX * clientW, mouseY * clientH
        if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
            return true
        end
    end
    return false
end
function dxDrawPickUp(TheElement,Image,distance,height,width,R,G,B,alpha)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getElementPosition(localPlayer)
	local distance = distance or 20
	local height = height or 1
	local width = width or 1
    local checkBuildings = checkBuildings or true
    local checkVehicles = checkVehicles or false
    local checkPeds = checkPeds or false
    local checkObjects = checkObjects or true
    local checkDummies = checkDummies or true
    local seeThroughStuff = seeThroughStuff or false
    local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
    local ignoredElement = ignoredElement or nil
	if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawMaterialLine3D(x, y, z+1+height-(distanceBetweenPoints/distance), x, y, z+height, Image, width-(distanceBetweenPoints/distance), tocolor(R or 255, G or 255, B or 255, alpha or 255))
			end
		end
	end
end

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end


function checkcollidableobjects()
	for i, obj in ipairs (getElementsByType("object")) do
		if getElementData(obj, "isMapInterior") and getElementInterior(obj) ~= getElementInterior(localPlayer) then
		setElementCollisionsEnabled ( obj, false )
		elseif getElementData(obj, "isMapInterior") then
		setElementCollisionsEnabled ( obj, true )
		end
	end
end
addEvent("check:collision", true)
addEventHandler("check:collision", localPlayer, checkcollidableobjects)



function disableClubMusic()
        setInteriorSoundsEnabled(false)
		setAmbientSoundEnabled( "gunfire", false )
end
addEventHandler("onClientPreRender", root, disableClubMusic)


offset = -0.3
state = "resta"
texturas_int = {
	[1] = dxCreateTexture("1.png"),
	[2] = dxCreateTexture("2.png"),
	[3] = dxCreateTexture("3.png"),
	[4] = dxCreateTexture("4.png"),
}

function renderPickup()
	for i,v in ipairs(getElementsByType('colshape')) do
		local x,y,z = getElementPosition(localPlayer)
		local x2,y2,z2 = getElementPosition(v)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 10 then
			local tipo = getElementData(v, "int_type")
			if tipo then
				if getElementDimension(v) == getElementDimension(localPlayer) and getElementInterior(v) == getElementInterior(localPlayer) then
				dxDrawPickUp(v, texturas_int[tipo] ,20,offset)
				if isElementWithinColShape ( localPlayer, v ) then
					if tipo == 3 or tipo == 4 then
						dxDrawTextOnElement(v, "Pulsa 'E' para ver opciones de compra", 0.4, 5,255,255,255,255,2)
					else
						dxDrawTextOnElement(v, "Pulsa 'E' para acceder", 0.4, 5,255,255,255,255,2)
					end
				end
				end
			end
		end
	end
	if offset <= -0.7 then
		state = "suma"
	elseif offset >= -0.3 then
		state = "resta"
	end

	if state == "suma" then
		offset = offset + 0.007
	else
		offset = offset - 0.007
	end
end
addEventHandler("onClientRender", root, renderPickup)



 onSalePanel = false
  onSalePanelPrice = false
  onSalePanelID = false
function enterOnSale(precio, ID)
	onSalePanelPrice = precio
	onSalePanelID = ID
	onSalePanel = true
	showCursor(true)
end
addEvent("interior:onsale", true)
addEventHandler("interior:onsale", localPlayer, enterOnSale)

function renderPanel()
	if onSalePanel then
        dxDrawRectangle(screenW * 0.3931, screenH * 0.2956, screenW * 0.2206, screenH * 0.3689, tocolor(234, 194, 124, 190), false)
        dxDrawRectangle(screenW * 0.3931, screenH * 0.2400, screenW * 0.2206, screenH * 0.0500, tocolor(130, 61, 19, 190), false)
        dxDrawText("PROPIEDAD EN VENTA", screenW * 0.3931, screenH * 0.2400, screenW * 0.6138, screenH * 0.2900, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("Esta propiedad está en venta:", screenW * 0.4037, screenH * 0.3178, screenW * 0.6075, screenH * 0.3756, tocolor(0, 0, 0, 190), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText("$ ".. onSalePanelPrice, (screenW * 0.4037) - 1, (screenH * 0.3756) - 1, (screenW * 0.6075) - 1, (screenH * 0.4333) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("$ ".. onSalePanelPrice, (screenW * 0.4037) + 1, (screenH * 0.3756) - 1, (screenW * 0.6075) + 1, (screenH * 0.4333) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("$ ".. onSalePanelPrice, (screenW * 0.4037) - 1, (screenH * 0.3756) + 1, (screenW * 0.6075) - 1, (screenH * 0.4333) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("$ ".. onSalePanelPrice, (screenW * 0.4037) + 1, (screenH * 0.3756) + 1, (screenW * 0.6075) + 1, (screenH * 0.4333) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("$ ".. onSalePanelPrice, screenW * 0.4037, screenH * 0.3756, screenW * 0.6075, screenH * 0.4333, tocolor(108, 186, 109, 190), 1.00, r_title, "center", "center", false, false, false, false, false)
        
        if isCursorHover(screenW * 0.4144, screenH * 0.4667, screenW * 0.1769, screenH * 0.0544) then
        	dxDrawRectangle(screenW * 0.4144, screenH * 0.4667, screenW * 0.1769, screenH * 0.0544, tocolor(130, 61, 19, 140), false)
    	else
    		dxDrawRectangle(screenW * 0.4144, screenH * 0.4667, screenW * 0.1769, screenH * 0.0544, tocolor(130, 61, 19, 190), false)
    	end
    	if isCursorHover(screenW * 0.4144, screenH * 0.5989, screenW * 0.1769, screenH * 0.0544) then
        	dxDrawRectangle(screenW * 0.4144, screenH * 0.5989, screenW * 0.1769, screenH * 0.0544, tocolor(130, 61, 19, 140), false)
        else
        	dxDrawRectangle(screenW * 0.4144, screenH * 0.5989, screenW * 0.1769, screenH * 0.0544, tocolor(130, 61, 19, 190), false)
        end
        dxDrawText("COMPRAR", screenW * 0.4144, screenH * 0.4667, screenW * 0.5913, screenH * 0.5211, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        dxDrawText("CANCELAR", screenW * 0.4144, screenH * 0.5989, screenW * 0.5913, screenH * 0.6533, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
	end
end
addEventHandler("onClientRender", root, renderPanel)

function interiorSalePanelClick ( button, state )
	if button == "left" and state == "down" then
		if onSalePanel then
			if isCursorHover(screenW * 0.4144, screenH * 0.4667, screenW * 0.1769, screenH * 0.0544) then
				triggerServerEvent("interior:buy", localPlayer, localPlayer, onSalePanelPrice, onSalePanelID)
				onSalePanel = false
				onSalePanelID = false
				onSalePanelPrice = false
				showCursor(false)
			elseif isCursorHover(screenW * 0.4144, screenH * 0.5989, screenW * 0.1769, screenH * 0.0544) then
				onSalePanel = false
				onSalePanelID = false
				onSalePanelPrice = false
				showCursor(false)
			end
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), interiorSalePanelClick )


-- muebles

 addEventHandler("onClientRender", root,
     function()
         dxDrawRectangle(screenW * 0.7675, screenH * 0.3211, screenW * 0.1769, screenH * 0.5700, tocolor(185, 143, 69, 200), false)
         dxDrawRectangle(screenW * 0.7675, screenH * 0.2700, screenW * 0.1769, screenH * 0.0456, tocolor(117, 69, 37, 255), false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.3511, screenW * 0.1594, screenH * 0.4778, tocolor(185, 143, 69, 200), false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.8400, screenW * 0.0781, screenH * 0.0400, tocolor(117, 69, 37, 255), false)
         dxDrawRectangle(screenW * 0.8575, screenH * 0.8400, screenW * 0.0781, screenH * 0.0400, tocolor(117, 69, 37, 255), false)
         dxDrawText("CATÁLOGO DE MUEBLES", screenW * 0.7675, screenH * 0.2711, screenW * 0.9444, screenH * 0.3156, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawText("FINALIZAR", screenW * 0.7762, screenH * 0.8400, screenW * 0.8544, screenH * 0.8800, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawText("DESHACER", screenW * 0.8575, screenH * 0.8400, screenW * 0.9356, screenH * 0.8800, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.3511, screenW * 0.1594, screenH * 0.0511, tocolor(117, 69, 37, 178), false)
         dxDrawText("COCINA", screenW * 0.7762, screenH * 0.3511, screenW * 0.9356, screenH * 0.4022, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.4067, screenW * 0.1594, screenH * 0.0511, tocolor(117, 69, 37, 178), false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.4622, screenW * 0.1594, screenH * 0.0511, tocolor(117, 69, 37, 178), false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.5189, screenW * 0.1594, screenH * 0.0511, tocolor(117, 69, 37, 178), false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.5744, screenW * 0.1594, screenH * 0.0511, tocolor(117, 69, 37, 178), false)
         dxDrawRectangle(screenW * 0.7762, screenH * 0.6311, screenW * 0.1594, screenH * 0.0511, tocolor(117, 69, 37, 178), false)
         dxDrawText("SALÓN", screenW * 0.7762, screenH * 0.4067, screenW * 0.9356, screenH * 0.4578, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawText("DORMITORIO", screenW * 0.7762, screenH * 0.4622, screenW * 0.9356, screenH * 0.5133, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawText("BAÑOS", screenW * 0.7762, screenH * 0.5189, screenW * 0.9356, screenH * 0.5700, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawText("ELECTRÓNICA", screenW * 0.7762, screenH * 0.5744, screenW * 0.9356, screenH * 0.6256, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
         dxDrawText("DECORACIÓN", screenW * 0.7762, screenH * 0.6311, screenW * 0.9356, screenH * 0.6822, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
     end
 )
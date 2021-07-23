    r_title = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  16)
    r_desc = dxCreateFont( ":personajes/fonts/Roboto-Italic.ttf", 16 )
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 )

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

function frac(cuenta)
    local cstring = tostring(cuenta)
    local part1 = string.sub(cstring, 1, 3)
    local part2 = string.sub(cstring, 4, 6)
    local part3 = string.sub(cstring, 7, 10)
    return part1.."-"..part2.."-"..part3
end

local screenW, screenH = guiGetScreenSize()
statson = {}
statson.hambre = false
statson.sed = false
statson.cansancio = false
ishudon = true
addEventHandler("onClientRender", root,
    function()
	if getElementData(localPlayer, "isLoged") and ishudon then
        dxDrawLine((screenW * 0.8575) - 1, (screenH * 0.0711) - 1, (screenW * 0.8575) - 1, screenH * 0.0933, tocolor(0, 0, 0, 201), 1, false)
        dxDrawLine(screenW * 0.9744, (screenH * 0.0711) - 1, (screenW * 0.8575) - 1, (screenH * 0.0711) - 1, tocolor(0, 0, 0, 201), 1, false)
        dxDrawLine((screenW * 0.8575) - 1, screenH * 0.0933, screenW * 0.9744, screenH * 0.0933, tocolor(0, 0, 0, 201), 1, false)
        dxDrawLine(screenW * 0.9744, screenH * 0.0933, screenW * 0.9744, (screenH * 0.0711) - 1, tocolor(0, 0, 0, 201), 1, false)
        dxDrawRectangle(screenW * 0.8575, screenH * 0.0711, screenW * 0.1169, screenH * 0.0222, tocolor(107, 39, 39, 201), false)
        dxDrawRectangle(screenW * 0.8575, screenH * 0.0711, (getElementHealth(localPlayer)*(screenW * 0.1169))/100, screenH * 0.0222, tocolor(164, 20, 20, 201), false)
		if getPedArmor(localPlayer) > 0 then
			dxDrawLine((screenW * 0.8575) - 1, (screenH * 0.0989) - 1, (screenW * 0.8575) - 1, screenH * 0.1211, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, (screenH * 0.0989) - 1, (screenW * 0.8575) - 1, (screenH * 0.0989) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.8575) - 1, screenH * 0.1211, screenW * 0.9744, screenH * 0.1211, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, screenH * 0.1211, screenW * 0.9744, (screenH * 0.0989) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.0989, screenW * 0.1169, screenH * 0.0222, tocolor(83, 83, 83, 201), false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.0989, getPedArmor(localPlayer)*(screenW * 0.1169)/100, screenH * 0.0222, tocolor(202, 202, 202, 201), false)
		end
		if isElementInWater(localPlayer) then
			dxDrawLine((screenW * 0.8575) - 1, (screenH * 0.1267) - 1, (screenW * 0.8575) - 1, screenH * 0.1489, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, (screenH * 0.1267) - 1, (screenW * 0.8575) - 1, (screenH * 0.1267) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.8575) - 1, screenH * 0.1489, screenW * 0.9744, screenH * 0.1489, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, screenH * 0.1489, screenW * 0.9744, (screenH * 0.1267) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1267, screenW * 0.1169, screenH * 0.0222, tocolor(69, 121, 127, 201), false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1267, getPedOxygenLevel(localPlayer)*(screenW * 0.1169)/1000, screenH * 0.0222, tocolor(140, 211, 213, 201), false)
		end
		
		if isCursorHover(screenW * 0.8575, screenH * 0.1667, screenW * 0.0319, screenH * 0.0222) and statson.sed == false and statson.cansancio == false then
			dxDrawLine((screenW * 0.8575) - 1, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.8575) - 1, screenH * 0.1889, screenW * 0.9744, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, screenH * 0.1889, screenW * 0.9744, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, screenW * 0.1169, screenH * 0.0222, tocolor(124, 89, 44, 201), false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, getElementData(localPlayer, "hambre")*(screenW * 0.1169)/100, screenH * 0.0222, tocolor(200, 102, 42, 201), false)
			dxDrawText("HAMBRE", screenW * 0.8581, screenH * 0.1667, screenW * 0.9731, screenH * 0.1889, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
			statson.hambre = true
		elseif statson.sed == false and statson.cansancio == false then
			dxDrawLine((screenW * 0.8575) - 1, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.8894, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.8575) - 1, screenH * 0.1889, screenW * 0.8894, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.8894, screenH * 0.1889, screenW * 0.8894, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, screenW * 0.0319, screenH * 0.0222, tocolor(124, 89, 44, 201), false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, (getElementData(localPlayer, "hambre") or 0)*(screenW * 0.0319)/100, screenH * 0.0222, tocolor(200, 102, 42, 201), false)
			statson.hambre = false
		end
		
		if isCursorHover(screenW * 0.9000, screenH * 0.1667, screenW * 0.0319, screenH * 0.0222) and statson.hambre == false and statson.cansancio == false then
			dxDrawLine((screenW * 0.8575) - 1, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.8575) - 1, screenH * 0.1889, screenW * 0.9744, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, screenH * 0.1889, screenW * 0.9744, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, screenW * 0.1169, screenH * 0.0222, tocolor(39, 44, 101, 201), false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, getElementData(localPlayer, "sed")*(screenW * 0.1169)/100, screenH * 0.0222, tocolor(31, 35, 183, 201), false)
			dxDrawText("SED", screenW * 0.8581, screenH * 0.1667, screenW * 0.9731, screenH * 0.1889, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
			statson.sed = true
		elseif statson.hambre == false and statson.cansancio == false then
			dxDrawLine((screenW * 0.9000) - 1, (screenH * 0.1667) - 1, (screenW * 0.9000) - 1, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9319, (screenH * 0.1667) - 1, (screenW * 0.9000) - 1, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.9000) - 1, screenH * 0.1889, screenW * 0.9319, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9319, screenH * 0.1889, screenW * 0.9319, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.9000, screenH * 0.1667, screenW * 0.0319, screenH * 0.0222, tocolor(39, 44, 101, 201), false)
			dxDrawRectangle(screenW * 0.9000, screenH * 0.1667, getElementData(localPlayer, "sed")*(screenW * 0.0319)/100, screenH * 0.0222, tocolor(31, 35, 183, 201), false)
			statson.sed = false
		end
        
		if isCursorHover(screenW * 0.9425, screenH * 0.1667, screenW * 0.0319, screenH * 0.0222) and statson.sed == false and statson.hambre == false then
			dxDrawLine((screenW * 0.8575) - 1, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, (screenH * 0.1667) - 1, (screenW * 0.8575) - 1, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.8575) - 1, screenH * 0.1889, screenW * 0.9744, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, screenH * 0.1889, screenW * 0.9744, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, screenW * 0.1169, screenH * 0.0222, tocolor(23, 62, 23, 201), false)
			dxDrawRectangle(screenW * 0.8575, screenH * 0.1667, getElementData(localPlayer, "cansancio")*(screenW * 0.1169)/100, screenH * 0.0222, tocolor(60, 162, 60, 201), false)
			dxDrawText("CANSANCIO", screenW * 0.8581, screenH * 0.1667, screenW * 0.9731, screenH * 0.1889, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
			statson.cansancio = true
		elseif statson.sed == false and statson.hambre == false then
			dxDrawLine((screenW * 0.9425) - 1, (screenH * 0.1667) - 1, (screenW * 0.9425) - 1, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, (screenH * 0.1667) - 1, (screenW * 0.9425) - 1, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.9425) - 1, screenH * 0.1889, screenW * 0.9744, screenH * 0.1889, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.9744, screenH * 0.1889, screenW * 0.9744, (screenH * 0.1667) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawRectangle(screenW * 0.9425, screenH * 0.1667, screenW * 0.0319, screenH * 0.0222, tocolor(23, 62, 23, 201), false)
			dxDrawRectangle(screenW * 0.9425, screenH * 0.1667, getElementData(localPlayer, "cansancio")*(screenW * 0.0319)/100, screenH * 0.0222, tocolor(60, 162, 60, 201), false)
			statson.cansancio = false
		end
		
			local hours, minutes = getTime()
			if (hours < 10) then
				hours = "0"..hours
			end
			if (minutes < 10) then
				minutes = "0"..minutes
			end
		
        dxDrawText(hours..":"..minutes, (screenW * 0.8575) - 1, (screenH * 0.0200) - 1, (screenW * 0.9744) - 1, (screenH * 0.0600) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText(hours..":"..minutes, (screenW * 0.8575) + 1, (screenH * 0.0200) - 1, (screenW * 0.9744) + 1, (screenH * 0.0600) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText(hours..":"..minutes, (screenW * 0.8575) - 1, (screenH * 0.0200) + 1, (screenW * 0.9744) - 1, (screenH * 0.0600) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText(hours..":"..minutes, (screenW * 0.8575) + 1, (screenH * 0.0200) + 1, (screenW * 0.9744) + 1, (screenH * 0.0600) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText(hours..":"..minutes, screenW * 0.8575, screenH * 0.0200, screenW * 0.9744, screenH * 0.0600, tocolor(255, 255, 255, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
		local m = getPlayerMoney ( localPlayer )
		local mstring = tostring(m)
		
		if m > 999 and m <= 999999 then
		mstring = tostring((m-(m%1000))/1000)..","..tostring(m%1000)
		elseif m > 999999 then
		mstring = tostring((m-(m%1000000))/1000000)..","..tostring(((m%1000000)-((m%1000000)%1000))/1000)..","..tostring((m%1000000)%1000)
		end
		
        dxDrawText("$ "..m, (screenW * 0.8575) - 1, (screenH * 0.1956) - 1, (screenW * 0.9744) - 1, (screenH * 0.2356) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText("$ "..m, (screenW * 0.8575) + 1, (screenH * 0.1956) - 1, (screenW * 0.9744) + 1, (screenH * 0.2356) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText("$ "..m, (screenW * 0.8575) - 1, (screenH * 0.1956) + 1, (screenW * 0.9744) - 1, (screenH * 0.2356) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText("$ "..m, (screenW * 0.8575) + 1, (screenH * 0.1956) + 1, (screenW * 0.9744) + 1, (screenH * 0.2356) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "left", "center", false, false, false, false, false)
        dxDrawText("$ "..m, screenW * 0.8575, screenH * 0.1956, screenW * 0.9744, screenH * 0.2356, tocolor(169, 223, 169, 201), 1.00, r_title, "left", "center", false, false, false, false, false)
		local itemsel = exports.items:getSelectedItem()
		dxDrawImage(screenW * 0.7500, screenH * 0.0556, screenW * 0.0988, screenH * 0.1722, ":items/img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), false)
		dxDrawImage(screenW * 0.7500, screenH * 0.0556, screenW * 0.0988, screenH * 0.1722, ":items/img/"..itemsel[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if itemsel[1] == 12 or itemsel[1] == 13 then
		dxDrawText('ID: '..itemsel[2], (screenW * 0.8050) - 1, (screenH * 0.2350) - 1, (screenW * 0.7913) - 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('ID: '..itemsel[2], (screenW * 0.8050) + 1, (screenH * 0.2350) - 1, (screenW * 0.7913) + 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('ID: '..itemsel[2], (screenW * 0.8050) - 1, (screenH * 0.2350) + 1, (screenW * 0.7913) - 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('ID: '..itemsel[2], (screenW * 0.8050) + 1, (screenH * 0.2350) + 1, (screenW * 0.7913) + 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('ID: '..itemsel[2], screenW * 0.8050, screenH * 0.2350, screenW * 0.7913, screenH * 0.2467, tocolor(255, 255, 255, 200), 1.00,r_text, "center", "center", false, false, false, false, false)
		elseif itemsel[1] == 16 or itemsel[1] == 17 then --telefonos móviles
		dxDrawText('#'..itemsel[2], (screenW * 0.8050) - 1, (screenH * 0.2350) - 1, (screenW * 0.7913) - 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..itemsel[2], (screenW * 0.8050) + 1, (screenH * 0.2350) - 1, (screenW * 0.7913) + 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..itemsel[2], (screenW * 0.8050) - 1, (screenH * 0.2350) + 1, (screenW * 0.7913) - 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..itemsel[2], (screenW * 0.8050) + 1, (screenH * 0.2350) + 1, (screenW * 0.7913) + 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..itemsel[2], screenW * 0.8050, screenH * 0.2350, screenW * 0.7913, screenH * 0.2467, tocolor(255, 255, 255, 200), 1.00,r_text, "center", "center", false, false, false, false, false)
		elseif itemsel[1] == 18 then --tarjetas
		dxDrawText('#'..frac(itemsel[2]), (screenW * 0.8050) - 1, (screenH * 0.2350) - 1, (screenW * 0.7913) - 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..frac(itemsel[2]), (screenW * 0.8050) + 1, (screenH * 0.2350) - 1, (screenW * 0.7913) + 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..frac(itemsel[2]), (screenW * 0.8050) - 1, (screenH * 0.2350) + 1, (screenW * 0.7913) - 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..frac(itemsel[2]), (screenW * 0.8050) + 1, (screenH * 0.2350) + 1, (screenW * 0.7913) + 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00,r_text, "center", "center", false, false, false, false, false)
        dxDrawText('#'..frac(itemsel[2]), screenW * 0.8050, screenH * 0.2350, screenW * 0.7913, screenH * 0.2467, tocolor(255, 255, 255, 200), 1.00,r_text, "center", "center", false, false, false, false, false)
		elseif itemsel[1] ~= 0 then--¿qué items no deben mostrar la cantidad?
		dxDrawText(itemsel[2], (screenW * 0.8050) - 1, (screenH * 0.2350) - 1, (screenW * 0.7913) - 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(itemsel[2], (screenW * 0.8050) + 1, (screenH * 0.2350) - 1, (screenW * 0.7913) + 1, (screenH * 0.2467) - 1, tocolor(0, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(itemsel[2], (screenW * 0.8050) - 1, (screenH * 0.2350) + 1, (screenW * 0.7913) - 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(itemsel[2], (screenW * 0.8050) + 1, (screenH * 0.2350) + 1, (screenW * 0.7913) + 1, (screenH * 0.2467) + 1, tocolor(0, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(itemsel[2], screenW * 0.8050, screenH * 0.2350, screenW * 0.7913, screenH * 0.2467, tocolor(255, 255, 255, 200), 1.00, r_text, "center", "center", false, false, false, false, false)
		end
	end
    end
)

function isHud()
	return ishudon
end


function togglehud()
	if ishudon then
	ishudon = false
	setPlayerHudComponentVisible("radar", false)
	setPlayerHudComponentVisible("crosshair", false)
	else
	ishudon = true
	setPlayerHudComponentVisible("radar", true)
	setPlayerHudComponentVisible("crosshair", true)
	end
end
addCommandHandler("togglehud", togglehud)




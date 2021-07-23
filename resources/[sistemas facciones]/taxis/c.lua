    r_title = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":personajes/fonts/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 )
local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender", root,
    function()
    	local veh = getPedOccupiedVehicle(localPlayer)
    	if isPedInVehicle(localPlayer) and isElement(veh) then
    		if getElementModel(veh) == 420 or getElementModel(veh) == 438 then
    			if getElementData(veh, "taximetro") then
			        dxDrawText("TAXIMETRO: "..getElementData(veh, "taximetro").."m", (screenW * 0.2894) + 1, (screenH * 0.8289) + 1, (screenW * 0.6919) + 1, (screenH * 0.8944) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			        dxDrawText("TAXIMETRO: "..getElementData(veh, "taximetro").."m", screenW * 0.2894, screenH * 0.8289, screenW * 0.6919, screenH * 0.8944, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
    			else
    				dxDrawText("TAXIMETRO: APAGADO", (screenW * 0.2894) + 1, (screenH * 0.8289) + 1, (screenW * 0.6919) + 1, (screenH * 0.8944) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			        dxDrawText("TAXIMETRO: APAGADO", screenW * 0.2894, screenH * 0.8289, screenW * 0.6919, screenH * 0.8944, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
    			end
    		end
    	end
    end
)
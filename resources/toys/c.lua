local toy_exceptions = {
	[1] = {},
	[2] = {14}
}


addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( startedRes )
	--mochila pequeña
		local alicetxd = engineLoadTXD("recipientes/smallback.txd", true)
		engineImportTXD(alicetxd, 1207)
		local alicedff = engineLoadDFF("recipientes/smallback.dff", 1207)
		engineReplaceModel(alicedff, 1207)
	--bolsa de plastico
		local alicetxd = engineLoadTXD("recipientes/plasticbag.txd", true)
		engineImportTXD(alicetxd, 1208)
		local alicedff = engineLoadDFF("recipientes/plasticbag.dff", 1207)
		engineReplaceModel(alicedff, 1208)
    end
);
local screenW, screenH = guiGetScreenSize()
mr = false
item1 = false
item2 = false
function mostrar_rec(inv1, inv2,img1,img2,huecos1,huecos2,dbID1, dbID2,pos1,pos2)
	item1 = false
	item2 = false
	if inv1 == nil and inv2 == nil then
	else
		if inv1 then
			item1 = {
				items = inv1,
				id = img1,
				dbid = dbID1,
				pos = pos1,
				huecos = huecos1
			}
		mr = item1
		end
		if inv2 then
			item2 = {
				items = inv2,
				id = img2,
				dbid = dbID2,
				pos = pos2,
				huecos = huecos2
			}
		if not inv1 then
			mr = item2
		end
		end
	end
end
addEvent("mostrar:recipientes", true)
addEventHandler("mostrar:recipientes", localPlayer, mostrar_rec)
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
function calcular_espacio_rec()
    local suma = 0
    for i=1, 15 do
        if mr.items[i][1] ~= 0 then
            suma = suma+1
        end
    end
    return suma
end

function es_excepcion( itemID )
	for i=1, #toy_exceptions[mr.id] do
		if itemID == toy_exceptions[mr.id][i] then
			return true
		end
	end
	return false
end

    r_title = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11 )
addEventHandler("onClientRender", root,
function()
    if getElementData(localPlayer, "isLoged") then
            --coordenadas raton--
        if isCursorShowing() then
        mmmx,mmmy = getCursorPosition ()
        local fullx,fully = guiGetScreenSize()
        cursorx,cursory = mmmx*fullx,mmmy*fully
        end
        ----
    if mr and exports.items:isInventoryOpened() then
    	if exports.vehiculos:isMaleteroOpened() then
		    if item1 then
		    	dxDrawRectangle(screenW * 0.7013, screenH * 0.3456, screenW * 0.0262, screenH * 0.0467, tocolor(0, 0, 0, 167), false)
		    	if recipienteInCursor == 1 then
		    		dxDrawImage(cursorx,cursory, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item1.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		    	else
		    		dxDrawImage(screenW * 0.7013, screenH * 0.3467, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item1.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		    	end

		    	if item2 then
		        dxDrawRectangle(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467, tocolor(0, 0, 0, 167), false)
			        if recipienteInCursor == 2 then
			        	dxDrawImage(cursorx,cursory, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item2.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
			        else
			        	dxDrawImage(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item2.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			        end
		    	end
		    elseif item2 then
		    	dxDrawRectangle(screenW * 0.7013, screenH * 0.3456, screenW * 0.0262, screenH * 0.0467, tocolor(0, 0, 0, 167), false)
		    	if recipienteInCursor == 1 then
		    		dxDrawImage(cursorx,cursory, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item2.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		    	else
		    		dxDrawImage(screenW * 0.7013, screenH * 0.3467, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item2.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		    	end
		    end
    	else
	        dxDrawRectangle(screenW * 0.7275, screenH * 0.3456, screenW * 0.1581, screenH * 0.4467, tocolor(0, 0, 0, 168), false)
	        dxDrawRectangle(screenW * 0.7275, screenH * 0.3156, screenW * 0.1581, screenH * 0.0256, tocolor(0, 0, 0, 255), false)
	        dxDrawText("Recipiente  "..calcular_espacio_rec().."/"..mr.huecos, screenW * 0.7275, screenH * 0.3156, screenW * 0.8856, screenH * 0.3411, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
	        
	        if mr.items[1][1] ~= 0 then
	        dxDrawRectangle(screenW * 0.7306, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i1" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else
	                dxDrawImage(screenW * 0.7306, screenH * 0.3533, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[1][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[2][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.7694, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i2" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[2][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.7694, screenH * 0.3522, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[2][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[3][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.8081, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i3" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[3][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.8081, screenH * 0.3522, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[3][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[4][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.8469, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i4" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[4][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.8469, screenH * 0.3533, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[4][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[5][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.7306, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i5" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[5][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.7306, screenH * 0.4233, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[5][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[6][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.7694, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i6" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[6][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.7694, screenH * 0.4244, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[6][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[7][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.8081, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i7" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[7][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.8081, screenH * 0.4244, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[7][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[8][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.8469, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i8" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[8][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.8469, screenH * 0.4244, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[8][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[9][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.7306, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	            if recipienteInCursor == "i9" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[9][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	            else   
	                dxDrawImage(screenW * 0.7306, screenH * 0.4956, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[9][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[10][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.7694, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	             if recipienteInCursor == "i10" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[10][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
	             else   
	                dxDrawImage(screenW * 0.7694, screenH * 0.4956, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[10][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[11][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.8081, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	             if recipienteInCursor == "i11" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[11][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
	             else   
	                dxDrawImage(screenW * 0.8081, screenH * 0.4967, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[11][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[12][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.8469, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	             if recipienteInCursor == "i12" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[12][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
	             else   
	                dxDrawImage(screenW * 0.8469, screenH * 0.4956, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[12][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[13][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.7306, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	             if recipienteInCursor == "i13" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[13][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
	             else   
	                dxDrawImage(screenW * 0.7306, screenH * 0.5678, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[13][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[14][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.7694, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	             if recipienteInCursor == "i14" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[14][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
	             else   
	                dxDrawImage(screenW * 0.7694, screenH * 0.5678, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[14][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end
	        if mr.items[15][1] ~= 0 then        
	        dxDrawRectangle(screenW * 0.8081, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
	             if recipienteInCursor == "i15" then
	                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[15][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
	             else   
	                dxDrawImage(screenW * 0.8081, screenH * 0.5678, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mr.items[15][1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	            end
	        end

	        if mr == item1 then
				dxDrawRectangle(screenW * 0.7013, screenH * 0.3456, screenW * 0.0262, screenH * 0.0467, tocolor(0, 0, 0, 167), false)
		        dxDrawImage(screenW * 0.7013, screenH * 0.3467, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item1.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	if item2 then
	        		if isCursorHover(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467) then
	        			dxDrawRectangle(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467, tocolor(100, 100, 100, 250), false)
	        		else
	        			dxDrawRectangle(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467, tocolor(0, 0, 0, 255), false)
	        		end
	       			dxDrawImage(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item2.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	end
	        elseif mr == item2 then
				dxDrawRectangle(screenW * 0.7013, screenH * 0.3456, screenW * 0.0262, screenH * 0.0467, tocolor(0, 0, 0, 167), false)
		        dxDrawImage(screenW * 0.7013, screenH * 0.3467, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item2.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	if item1 then
	        		if isCursorHover(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467) then
	        			dxDrawRectangle(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467, tocolor(100, 100, 100, 250), false)
	        		else
	        			dxDrawRectangle(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467, tocolor(0, 0, 0, 255), false)
	        		end
	       			dxDrawImage(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0456, ":toys/recipientes/img/"..item1.id..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	        	end
	        end  
	    
        dxDrawRectangle(screenW * 0.7275, screenH * 0.6633, screenW * 0.1581, screenH * 0.0256, tocolor(0, 0, 0, 255), false)
        dxDrawText("OPCIONES", screenW * 0.7275, screenH * 0.6633, screenW * 0.8856, screenH * 0.6889, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        if isCursorHover(screenW * 0.7338, screenH * 0.6989, screenW * 0.1444, screenH * 0.0300) then
        	dxDrawRectangle(screenW * 0.7338, screenH * 0.6989, screenW * 0.1444, screenH * 0.0300, tocolor(30, 30, 30, 255), false)
        else
        	dxDrawRectangle(screenW * 0.7338, screenH * 0.6989, screenW * 0.1444, screenH * 0.0300, tocolor(74, 74, 74, 255), false)
        end

        if isCursorHover(screenW * 0.7338, screenH * 0.7400, screenW * 0.1444, screenH * 0.0300) then
        	dxDrawRectangle(screenW * 0.7338, screenH * 0.7400, screenW * 0.1444, screenH * 0.0300, tocolor(30, 30, 30, 255), false)
        else
        	dxDrawRectangle(screenW * 0.7338, screenH * 0.7400, screenW * 0.1444, screenH * 0.0300, tocolor(74, 74, 74, 255), false)
        end
        dxDrawText("Destruir", screenW * 0.7325, screenH * 0.7000, screenW * 0.8781, screenH * 0.7289, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("Entregar", screenW * 0.7325, screenH * 0.7411, screenW * 0.8781, screenH * 0.7700, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
   
        end
    end
    end
end
)
function isCursorInRecipiente()
	if isCursorHover(screenW * 0.7275, screenH * 0.3456, screenW * 0.1581, screenH * 0.4467) then
		if not exports.vehiculos:isCursorInMaletero() and mr then
			return true
		else
			return false
		end
	else
		return false
	end
end
function calcular_espacio_recipiente()
	if mr then
		for i=1, #mr.items do
			if mr.items[i][1] == 0 then
				return i
			end
		end
		return false
	else
		return false
	end
end

function darRecipienteFromMaletero( recID, dbID, pos )
	triggerServerEvent("rec:darmaletero", localPlayer, localPlayer, recID, dbID, pos)
end
function getHuecoFromCursorItemRec( )
    if recipienteInCursor == "i1" then
        return 1
    elseif recipienteInCursor == "i2" then
        return 2
    elseif recipienteInCursor == "i3" then
        return 3
    elseif recipienteInCursor == "i4" then
        return 4
    elseif recipienteInCursor == "i5" then
        return 5
    elseif recipienteInCursor == "i6" then
        return 6
    elseif recipienteInCursor == "i7" then
        return 7
    elseif recipienteInCursor == "i8" then
        return 8
    elseif recipienteInCursor == "i9" then
        return 9
    elseif recipienteInCursor == "i10" then
        return 10
    elseif recipienteInCursor == "i11" then
        return 11
    elseif recipienteInCursor == "i12" then
        return 12
    elseif recipienteInCursor == "i13" then
        return 13
    elseif recipienteInCursor == "i14" then
        return 14
    elseif recipienteInCursor == "i15" then
        return 15
    end
end
recipienteInCursor=false
function addLabelOnClick ( button, state )
	if button=="left" and state=="down" and mr then
		if isCursorHover(screenW * 0.7306, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mr.items[1][1] ~= 0 then
            recipienteInCursor = "i1"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mr.items[2][1] ~= 0 then
            recipienteInCursor = "i2"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mr.items[3][1] ~= 0 then
            recipienteInCursor = "i3"
        elseif isCursorHover(screenW * 0.8469, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mr.items[4][1] ~= 0 then
            recipienteInCursor = "i4"
        elseif isCursorHover(screenW * 0.7306, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mr.items[5][1] ~= 0 then
            recipienteInCursor = "i5"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mr.items[6][1] ~= 0 then
            recipienteInCursor = "i6"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mr.items[7][1] ~= 0 then
            recipienteInCursor = "i7"
        elseif isCursorHover(screenW * 0.8469, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mr.items[8][1] ~= 0 then
            recipienteInCursor = "i8"
        elseif isCursorHover(screenW * 0.7306, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mr.items[9][1] ~= 0 then
            recipienteInCursor = "i9"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mr.items[10][1] ~= 0 then
            recipienteInCursor = "i10"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mr.items[11][1] ~= 0 then
            recipienteInCursor = "i11"
        elseif isCursorHover(screenW * 0.8469, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mr.items[12][1] ~= 0 then
            recipienteInCursor = "i12"
        elseif isCursorHover(screenW * 0.7306, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656) and mr.items[13][1] ~= 0 then
            recipienteInCursor = "i13"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656) and mr.items[14][1] ~= 0 then
            recipienteInCursor = "i14"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656) and mr.items[15][1] ~= 0 then
            recipienteInCursor = "i15"
		elseif isCursorHover(screenW * 0.7013, screenH * 0.3989, screenW * 0.0262, screenH * 0.0467) then --zona2
			if not exports.vehiculos:isMaleteroOpened() then
				if mr == item2 then
					mr = item1
				elseif item2 then
					mr = item2
				end
			else
				if item1 and item2 then
					recipienteInCursor = 2
				end
			end
		elseif isCursorHover(screenW * 0.7013, screenH * 0.3456, screenW * 0.0262, screenH * 0.0467) then --zona1
			if exports.vehiculos:isMaleteroOpened() then
				if item1 then
					recipienteInCursor = 1
				elseif item2 then
					recipienteInCursor = 1
				end
			end
		elseif isCursorHover(screenW * 0.7338, screenH * 0.6989, screenW * 0.1444, screenH * 0.0300) then 
			if not exports.vehiculos:isMaleteroOpened() then--Destruir
				triggerServerEvent("rec:destruir",localPlayer,localPlayer,mr.dbid,mr.id)
				if mr == item1 then
					if item2 then
						mr = item2
					else
						mr = false
					end
					item1 = false
				elseif mr == item2 then
					if item1 then
						mr = item1
					else
						mr = false
					end
					item2 = false
				end
			end
		elseif isCursorHover(screenW * 0.7338, screenH * 0.7400, screenW * 0.1444, screenH * 0.0300) then-- entregar
		end
	elseif button=="left" and state=="up" and mr then
		if exports.vehiculos:isMaleteroOpened() and recipienteInCursor then
			if exports.vehiculos:isCursorInMaletero() then
				if recipienteInCursor == 1 then
					if item1 then
						if exports.vehiculos:ponerItemEnMaletero(item1.id, item1.dbid, "rec") then
							triggerServerEvent("rec:quitar", localPlayer, localPlayer, item1.pos, item1.dbid, "maletero" )
							exports.login:addNotification("El recipiente se ha puesto correctamente en el maletero.", "success")
							if mr == item1 then
								if item2 then
									mr = item2
								else
									mr = false
								end
							end
							item1 = false
						end
					elseif item2 then
						if exports.vehiculos:ponerItemEnMaletero(item2.id, item2.dbid, "rec") then
							triggerServerEvent("rec:quitar", localPlayer, localPlayer, item2.pos, item2.dbid, "maletero" )
							exports.login:addNotification("El recipiente se ha puesto correctamente en el maletero.", "success")
							if mr == item2 then
								mr = false
								item2 = false
							end
						end
					end
				elseif recipienteInCursor == 2 then
					if exports.vehiculos:ponerItemEnMaletero(item2.id, item2.dbid, "rec") then
						triggerServerEvent("rec:quitar", localPlayer, localPlayer, item2.pos, item2.dbid, "maletero" )
						exports.login:addNotification("El recipiente se ha puesto correctamente en el maletero.", "success")
						if mr == item2 then
							if item1 then
								mr = item1
							else
								mr = false
							end
						end
						item2 = false
					end
				end
			end
		elseif exports.items:isCursorInBolsillo() and recipienteInCursor then
			local hueco = getHuecoFromCursorItemRec()
			local item = mr.items[hueco]
			exports.items:depositarItemFromRecipiente(item[1], item[2], hueco)
			updateRecipiente()
		end
		recipienteInCursor = false
	end
end
addEventHandler ( "onClientClick", getRootElement(), addLabelOnClick )

function ponerItemEnRecipiente( itemID, slot, hueco )
	if not es_excepcion(itemID) then
		if not hueco then
			if calcular_espacio_rec() < mr.huecos then
				local hueco = calcular_espacio_recipiente()
				if hueco then
					mr.items[hueco][1] = itemID
					mr.items[hueco][2] = slot
					updateRecipiente()
					return true
				else
					return false
				end
			else
				return false
			end
		else
			mr.items[hueco][1] = itemID
			mr.items[hueco][2] = slot
			updateRecipiente()
			return true
		end
	else
		exports.login:addNotification("No puedes guardar este objeto en este recipiente.", "error")
		return false
	end
end

--guardado--,
function updateRecipiente()
	triggerServerEvent("recipiente:update", localPlayer, localPlayer, mr.pos, mr.items)
end

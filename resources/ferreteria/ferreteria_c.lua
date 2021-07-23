local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1600 ), ( sy / 900 )

local w, h = 350, 400
local witem = 300
local abierto = nil
local elements = {}

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 10 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

local tick, ntick = 0, nil

function dibujarPanelFerreteria()
	tick = getTickCount()
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*50, tocolor(34,94,122, 164) )
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor(34,94,122, 162) )
	dxDrawText( "Ferretería", 0, y*(-350), sx, sy, tocolor(255,255,255), y*1, r_title, "center", "center" )
	
	dxDrawText( "Elige el tipo de copia que quieras hacer.", 0, y*(-255), sx, sy, tocolor(255,255,255), y*1, r_desc, "center", "center" )
	
	
	dxDrawRectangle( ( sx - x*witem )/2, ( sy - y*(h-200) )/2, x*witem, y*80, tocolor(2,105,156, 100) )
	dxDrawImage( ( sx - x*witem )/2, ( sy - y*(h-225) )/2, x*60, y*60, ":items/img/12.png" )
	dxDrawText( "Llave de vehículo.", ( sx - x*(witem-200) )/2, ( sy - y*(h-220) )/2, x*witem, y*80, tocolor(255,255,255), y*1, r_text )
	dxDrawText( "ID: ", ( sx - x*(witem-200) )/2, ( sy - y*(h-280) )/2, x*100, y*20, tocolor(255,255,255), y*1, r_desc )
	dxDrawRectangle( ( sx - x*(witem-400) )/2, ( sy - y*(h-330) )/2, x*100, y*15, isMouseInPosition( ( sx - x*(witem-400) )/2, ( sy - y*(h-330) )/2, x*100, y*15 ) and tocolor( 34,94,122, 150 ) or tocolor(2,105,156, 255) )
	dxDrawText( "Copiar", ( sx - x*(witem-465) )/2, ( sy - y*(h-330) )/2, x*100, y*15, tocolor(255,255,255), y*1, "default-bold" )
	if not elements[1] then
		elements[1] = guiCreateEdit( ( sx - x*(witem-250) )/2, ( sy - y*(h-275) )/2, x*100, y*20, "", false )
	end
	
	dxDrawRectangle( ( sx - x*witem )/2, ( sy - y*(h-400) )/2, x*witem, y*80, tocolor(2,105,156, 100) )
	dxDrawImage( ( sx - x*witem )/2, ( sy - y*(h-425) )/2, x*60, y*60, ":items/img/13.png" )
	dxDrawText( "Llave de propiedad.", ( sx - x*(witem-200) )/2, ( sy - y*(h-420) )/2, x*witem, y*80, tocolor(255,255,255), y*1, r_text )
	dxDrawText( "ID: ", ( sx - x*(witem-200) )/2, ( sy - y*(h-480) )/2, x*100, y*20, tocolor(255,255,255), y*1, r_desc )
	dxDrawRectangle( ( sx - x*(witem-400) )/2, ( sy - y*(h-530) )/2, x*100, y*15, isMouseInPosition( ( sx - x*(witem-400) )/2, ( sy - y*(h-530) )/2, x*100, y*15 ) and tocolor( 34,94,122, 150 ) or tocolor(2,105,156, 255) )
	dxDrawText( "Copiar", ( sx - x*(witem-465) )/2, ( sy - y*(h-530) )/2, x*100, y*15, tocolor(255,255,255), y*1, "default-bold" )
	if not elements[2] then
		elements[2] = guiCreateEdit( ( sx - x*(witem-250) )/2, ( sy - y*(h-475) )/2, x*100, y*20, "", false )
	end
	
	dxDrawText( "Introduce la ID de la llave y dale a copiar.", 0, y*(250), sx, sy, tocolor(255,255,255), y*1, r_desc, "center", "center" )
	
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*(h-700) )/2, x*w, y*50, isMouseInPosition( ( sx - x*w )/2, ( sy - y*(h-700) )/2, x*w, y*50 ) and tocolor(34,94,122, 150) or tocolor(2,105,156, 164) )
	dxDrawText( "Cerrar", 0, y*(350), sx, sy, tocolor(255,255,255), y*1, r_title, "center", "center" )
	
	if isMouseInPosition( ( sx - x*w )/2, ( sy - y*(h-700) )/2, x*w, y*50 ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 1000 then
			ntick = getTickCount()
			removeEventHandler( "onClientRender", getRootElement(), dibujarPanelFerreteria )
			abierto = false
			destroyElement( elements[1] ) elements[1] = nil
			destroyElement( elements[2] ) elements[2] = nil
		end
	end
	
	-- LLAVE DE VEHICULO BOTON COPIAR
	
	if isMouseInPosition( ( sx - x*(witem-400) )/2, ( sy - y*(h-330) )/2, x*100, y*15 ) and getKeyState( "mouse1" ) == true then 
		if not ntick or ( tick - ntick ) > 1000 then
			ntick = getTickCount()
			local idveh = guiGetText( elements[1] )
			if idveh and #idveh > 0 then
				triggerServerEvent( "ferreteria:copiar", getLocalPlayer(), idveh, 1 )
			else
				outputChatBox( "Introduce la ID de la llave. Puedes colocartela en el inventario y ver la ID en el HUD.", 255, 150, 0 )
			end
		end
	end
	
	
	-- LLAVE DE PROPIEDAD BOTON COPIAR
	
	if isMouseInPosition( ( sx - x*(witem-400) )/2, ( sy - y*(h-530) )/2, x*100, y*15 ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 1000 then
			ntick = getTickCount()
			local idprop = guiGetText( elements[2] )
			if idprop and #idprop > 0 then
				triggerServerEvent( "ferreteria:copiar", getLocalPlayer(), idprop, 2 )
			else
				outputChatBox( "Introduce la ID de la llave. Puedes colocartela en el inventario y ver la ID en el HUD.", 255, 150, 0 )
			end
		end
	end
end

addEvent( "ferreteria:abrir", true )
addEventHandler( "ferreteria:abrir", getRootElement(),
	function()
		if not abierto then
			abierto = true
			addEventHandler( "onClientRender", getRootElement(), dibujarPanelFerreteria ) 
		end
	end
)
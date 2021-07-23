local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1280 ), ( sy / 720 )

local avisos = {}

local abierto = false

local w, h = 350, 400
local w1, h1 = 330, 50

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end


r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  16)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 8 )
r_thin = dxCreateFont( ":fuentes/Roboto-Thin.ttf", 8 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )

local scroll, maxscroll = 1, 4

local tick, ntick = 0, nil

function dibujarPanel()
	tick = getTickCount()
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor(174, 140, 80, 162) )
	dxDrawRectangle( ( sx - x*(w-660) )/2, ( sy - y*h )/2, x*20, y*20, isMouseInPosition( ( sx - x*(w-660) )/2, ( sy - y*h )/2, x*20, y*20 ) and tocolor( 150, 0, 0, 150 ) or tocolor( 255, 0, 0, 150 ) )
	dxDrawText( "X", ( sx - x*(w-670) )/2, ( sy - y*(h-1) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_text )
	dxDrawText( "Centralita", x*0, y*(-350), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
	dxDrawText( "Consulta las llamadas realizadas al\ndepartamento. Usa el scroll para bajar o subir.", x*0, y*(-270), sx, sy, tocolor( 255, 255, 255 ), y*1, r_text, "center", "center" )
	
	fila = 0
	for i=scroll, scroll + maxscroll do
		if avisos[i] then
			fila = fila + 1
			dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+260)-fila*110) )/2, x*w1, y*h1, tocolor( 0, 0, 0, 100 ) )
			
			
			dxDrawText( "(( "..avisos[i][1].." ))", ( sx - x*(w1-20) )/2, ( sy - y*((h1+260)-fila*110) )/2, x*(100), y*20, tocolor( 200,200,200 ), y*1, r_thin )
			dxDrawText( "Situación: "..avisos[i][2], ( sx - x*(w1-20) )/2, ( sy - y*((h1+230)-fila*110) )/2, x*(100), y*20, tocolor( 255,255,255 ), y*1, r_desc )
			dxDrawText( "Teléfono: "..avisos[i][4], ( sx - x*(w1-20) )/2, ( sy - y*((h1+200)-fila*110) )/2, x*(100), y*20, tocolor( 255,255,255 ), y*1, r_desc )
			
			dxDrawImage( ( sx - x*(w1-500) )/2, ( sy - y*((h1+210)-fila*110) )/2, x*20, y*25, "gps.png" )
			
			dxDrawRectangle( ( sx - x*(w1-540) )/2, ( sy - y*((h1+200)-fila*110) )/2, x*(60), y*20, isMouseInPosition( ( sx - x*(w1-540) )/2, ( sy - y*((h1+200)-fila*110) )/2, x*(60), y*20 ) and tocolor( 150, 50, 0, 150 ) or tocolor( 0, 0, 0, 100 ) )
			dxDrawText( "Localizar", ( sx - x*(w1-550) )/2, ( sy - y*((h1+195)-fila*110) )/2, x*(100), y*20, tocolor( 255,255,255 ), y*1, r_desc )
			
			if isMouseInPosition( ( sx - x*(w1-540) )/2, ( sy - y*((h1+200)-fila*110) )/2, x*(60), y*20 ) and getKeyState( "mouse1" ) == true then
				if not ntick or ( tick - ntick ) > 500 then
					ntick = getTickCount()
					triggerServerEvent( "aviso:localizar", localPlayer, avisos[i], i )
					abierto = false				
					avisos = {}
					removeEventHandler( "onClientRender", getRootElement(), dibujarPanel )
				end			
			end
		end
	end
	if isMouseInPosition( ( sx - x*(w-660) )/2, ( sy - y*h )/2, x*20, y*20 ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 500 then
			ntick = getTickCount()
			abierto = false				
			avisos = {}
			removeEventHandler( "onClientRender", getRootElement(), dibujarPanel )
		end
	end
end

function bajarScroll()
	if #avisos > maxscroll then
		scroll = math.min( scroll + 1, (#avisos)-maxscroll )
	end
end
bindKey( "mouse_wheel_down", "down", bajarScroll )

function subirScroll()
	scroll = math.max( scroll - 1, 1 )
end
bindKey( "mouse_wheel_up", "down", subirScroll )

addEvent( "avisos:abrir", true )
addEventHandler( "avisos:abrir", getRootElement(),
	function( tablaAvisos )
		if not abierto then
			avisos = tablaAvisos
			addEventHandler( "onClientRender", getRootElement(), dibujarPanel )
			abierto = true
		end
	end
)
local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1024 ), ( sy / 768 )

local w, h = 300, 480

local witem, hitem = 290, 70

local wbut, hbut = 80, 25

local abierto = false

local arma_registro = 0

local ventana = 1

--[[

	DE SPUDBOY:

	Deagle, el gas pimienta, la porra, las escopetas, la mp5, los snipers, los c4’s, la m4

]]

local listaArmas = {

	{ 93, "Desert Deagle", "Pistola" },
	{ 111, "Gas pimienta", "De mano" },
	{ 85, "Porra policíaca", "De mano" },
	{ 94, "Escopeta", "Escopeta" },
--	{ 96, "Spaz", "Escopeta" },
	{ 98, "MP5", "Subfusil potente." },
	{ 103, "Francotirador", "Rifle" },
	{ 102, "Rifle de caza", "Rifle" },
	{ 101, "M4", "Rifle potente" },

}

local sacadas = {}

local tick, ntick = 0, nil

local scroll, maxscroll = 1, 4

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function haceClick( cx, cy, cw, ch )
	if isMouseInPosition( cx, cy, cw, ch ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 500 then
			ntick = getTickCount()
			return true
		end
	end
end

local textos = {

	"Elige tu arma. Si la tienes disponible, saldrá la foto\nsino, ya la habrás sacado y no podrás pillar otra.",
	"Registro de las armas sacadas de la armería.",

}

function getArmaIDFromName(nme)
	for i=1, #listaArmas do 
		if listaArmas[i][2] == nme then
			return listaArmas[i][1]
		end
	end
end

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", y*20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*11)
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*16)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", y*8 )
r_thin = dxCreateFont( ":fuentes/Roboto-Thin.ttf", y*8 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", y*11 )

function dibujarArmeria()
	tick = getTickCount()

	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor( 174, 140, 80, 150 ) )
	dxDrawText( "ARMERIA", x*0, y*(-420), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
	dxDrawText( textos[ventana], x*0, y*(-340), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
	
	dxDrawImage( ( sx - x*(w-560) )/2, ( sy - y*(h) )/2, x*20, y*20, 'cerrar.png', 0, 0, 0, isMouseInPosition(( sx - x*(w-560) )/2, ( sy - y*(h) )/2, x*20, y*20) and tocolor( 255, 255, 255, 100 ) or tocolor( 255,255,255 ) )
	
	if haceClick( ( sx - x*(w-560) )/2, ( sy - y*(h) )/2, x*20, y*20 ) then
		ventana = 1
		sacadas = {}
		removeEventHandler( "onClientRender", getRootElement(), dibujarArmeria )
		abierto = false
	end
	
	if ventana == 2 then
		dxDrawImage( ( sx - x*(w-10) )/2, ( sy - y*(h) )/2, x*30, y*40, ':gobierno/volver.png', 0, 0, 0, isMouseInPosition(( sx - x*(w-10) )/2, ( sy - y*(h) )/2, x*30, y*40) and tocolor( 255, 255, 255, 100 ) or tocolor( 255,255,255 ) )
		if haceClick( ( sx - x*(w-10) )/2, ( sy - y*(h) )/2, x*30, y*40 ) then
			ventana = 1
			sacadas = {}
		end
	end
	
	if ventana == 1 then
		fila = 0
		for i=scroll, scroll+maxscroll do 
			if listaArmas[i] then
				fila = fila + 1
				--174, 140, 80 otro rgb
				dxDrawRectangle( ( sx - x*witem )/2, ( sy - y*((hitem+360)-fila*150) )/2, x*witem, y*hitem, tocolor( 0,0,0, 50 ) )
				dxDrawText( listaArmas[i][2], ( sx - x*(witem-140) )/2, ( sy - y*((hitem+340)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.8, r_text )
				dxDrawImage( ( sx - x*(witem-20) )/2, ( sy - y*((hitem+340)-fila*150) )/2, x*50, y*50,  ':items/img/'..listaArmas[i][1]..".png" )
				
				--dxDrawText( sacadas[listaArmas[i][1]] and "A devolver" or "Disponible", ( sx - x*(witem-140) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*witem, y*hitem, sacadas[listaArmas[i][1]] and tocolor( 200, 0, 0 ) or tocolor( 0, 150, 0 ), y*1, r_desc )
				
				dxDrawText( listaArmas[i][3], ( sx - x*(witem-140) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.8, r_text )
				
				dxDrawRectangle( ( sx - x*(wbut-150) )/2, ( sy - y*((hbut+330)-fila*150) )/2, x*wbut, y*hbut, isMouseInPosition(( sx - x*(wbut-150) )/2, ( sy - y*((hbut+330)-fila*150) )/2, x*wbut, y*hbut) and tocolor( 220, 140, 80, 200 ) or tocolor(200,140,80,150) )
				
				dxDrawImage( ( sx - x*(wbut-100) )/2, ( sy - y*((hbut+325)-fila*150) )/2, x*20, y*20, "registrocepo.png", 0, 0, 0, isMouseInPosition( ( sx - x*(wbut-100) )/2, ( sy - y*((hbut+325)-fila*150) )/2, x*20, y*20 ) and tocolor( 255, 255, 255, 100 ) or tocolor(255,255,255) )

				dxDrawRectangle( ( sx - x*(wbut-150) )/2, ( sy - y*((hbut+390)-fila*150) )/2, x*wbut, y*hbut, isMouseInPosition(( sx - x*(wbut-150) )/2, ( sy - y*((hbut+390)-fila*150) )/2, x*wbut, y*hbut) and tocolor( 220, 140, 80, 200 ) or tocolor(200,140,80,150) )
				
				--if not sacadas[listaArmas[i][1]] then
					dxDrawText( "Sacar", ( sx - x*(wbut-195) )/2, ( sy - y*((hbut+320)-fila*150) )/2, x*wbut, y*hbut, tocolor(255,255,255), y*0.8, r_text )
					dxDrawText( "Guardar", ( sx - x*(wbut-185) )/2, ( sy - y*((hbut+380)-fila*150) )/2, x*wbut, y*hbut, tocolor(255,255,255), y*0.8, r_text )
				--else
					--dxDrawText( "Dejar", ( sx - x*(wbut-195) )/2, ( sy - y*((hbut+320)-fila*150) )/2, x*wbut, y*hbut, tocolor(255,255,255), y*0.8, r_text )
					--dxDrawText( "Sacada el "..os.date( "%d-%m-%Y %H:%M", sacadas[listaArmas[i][1]][1] ), ( sx - x*(witem-140) )/2, ( sy - y*((hitem+250)-fila*150) )/2, x*witem, y*hitem, tocolor(255,255,255), y*0.5, r_text )
				--end
				
				if haceClick( ( sx - x*(wbut-150) )/2, ( sy - y*((hbut+330)-fila*150) )/2, x*wbut, y*hbut ) then
					triggerServerEvent( "armeria:sacarArma", getLocalPlayer(), listaArmas[i][2], listaArmas[i][1] )
				elseif haceClick(  ( sx - x*(wbut-100) )/2, ( sy - y*((hbut+325)-fila*150) )/2, x*20, y*20 ) then
					triggerServerEvent( "armeria:getRegistroArmeria", getLocalPlayer(), listaArmas[i][2] )
					arma_registro = listaArmas[i][2]
					ventana = 2
				elseif haceClick( ( sx - x*(wbut-150) )/2, ( sy - y*((hbut+390)-fila*150) )/2, x*wbut, y*hbut ) then
					triggerServerEvent( "armeria:guardararma", getLocalPlayer(), listaArmas[i][2], listaArmas[i][1] )
				end
			end
		end
	elseif ventana == 2 then
		if #sacadas > 0 then
			fila = 0
			for i=scroll, scroll+maxscroll do 
				if sacadas[i] and sacadas[i].nombre_arma == arma_registro then
					fila = fila + 1
					--174, 140, 80 otro rgb
					dxDrawRectangle( ( sx - x*witem )/2, ( sy - y*((hitem+360)-fila*150) )/2, x*3, y*hitem, sacadas[i].tipo == 1 and tocolor( 0, 200, 0, 100 ) or tocolor( 200,0,0,100 ) )
					dxDrawRectangle( ( sx - x*witem )/2, ( sy - y*((hitem+360)-fila*150) )/2, x*witem, y*hitem, tocolor( 0,0,0, 50 ) )
					dxDrawText( sacadas[i].agente, ( sx - x*(witem-140) )/2, ( sy - y*((hitem+340)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.8, r_text )
					dxDrawImage( ( sx - x*(witem-20) )/2, ( sy - y*((hitem+340)-fila*150) )/2, x*50, y*50,  ':items/img/'..getArmaIDFromName( arma_registro )..".png" )
					
					
					dxDrawText( os.date( "%d-%m-%Y %H-%M",sacadas[i].fecha), ( sx - x*(witem-140) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.8, r_text )
					
					dxDrawText( sacadas[i].tipo == 1 and "Sacada" or "Devuelta", ( sx - x*(witem-140) )/2, ( sy - y*((hitem+260)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.8, r_text )
				end
			end
		else
			dxDrawText( "No hay registros", x*0, y*0, sx, sy, tocolor( 255, 255, 255 ), y*0.8, r_text, "center", "center" )
		end
	end
end

bindKey( "mouse_wheel_down", "down", function()
	scroll = math.min( scroll + 1, (#listaArmas) - maxscroll )
end)

bindKey( "mouse_wheel_up", "down", function()
	scroll = math.max( scroll - 1, 1 )
end )

addEvent( "armeria:actualizarDatos", true )
addEventHandler( "armeria:actualizarDatos", getRootElement(),
	function( datos )
		sacadas = {}
		sacadas = datos
	end
) 

addEvent( "armeria:abrir", true )
addEventHandler( "armeria:abrir", getRootElement(),
	function()
		if not abierto then
			addEventHandler( "onClientRender", getRootElement(), dibujarArmeria )
		end
	end
)

--[[addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		if getPlayerName( getLocalPlayer() ) == 'Staff_Blue' then
			addEventHandler( "onClientRender", getRootElement(), dibujarArmeria )
		end
	end
)--]]
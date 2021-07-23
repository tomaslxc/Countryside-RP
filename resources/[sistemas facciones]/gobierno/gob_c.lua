local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1024 ), ( sy / 768 )
local faccs = {}
local abierto = false
local ventana = 1
local faccselec = 0
local informes = {}
local empleados = {}
local ranks = {}
local ventanasueldo = nil
local idchar = nil

local indexplayer = nil

local tipo_informe = 0

guitexto = nil
guitexto2 = nil

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", y*20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf", y*11 )
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*11)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", y*9 )
r_thin = dxCreateFont( ":fuentes/Roboto-Thin.ttf", 8 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", y*11 )

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

local w, h = 350, 450
local w1, h1 = 345, 80

local scroll, maxscroll = 1, 3
local tick, ntick = 0, nil

function tlc(seconds)
    if seconds == "conectado" then
        return "Conectado"
    elseif seconds < 86400 then
        return "Hoy"
    else
        local horas = seconds/3600
        if horas < 48 then
            return "Ayer"
        else
            local dias = seconds/86400
            return "Hace "..math.floor(dias).." días"
        end
    end
end

function getDerechoName( id )
	if id == 1 then
		return "[Líder]"
	elseif id == 2 then
		return "[Encargado]"
	elseif id == 3 then
		return "[Dueño]"
	else
		return ""
	end
end

function dibujarPanel()
	tick = getTickCount()
	
	--[[
		
		PARTE SUPERIOR
	
	]]

	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor(174, 140, 80, 200) )
	
	dxDrawRectangle( ( sx - x*(w-660) )/2, ( sy - y*h )/2, x*20, y*20, isMouseInPosition( ( sx - x*(w-660) )/2, ( sy - y*h )/2, x*20, y*20 ) and tocolor( 255, 0, 0, 100 ) or tocolor(150, 0, 0) )
	dxDrawText( "X", ( sx - x*(w-670) )/2, ( sy - y*h )/2, x*20, y*20, tocolor(255,255,255), y*1, r_text )
	
	dxDrawLine(( sx - x*(w-660) )/2, ( sy - y*(h-160) )/2, x*w, ( sy - y*(h-160) )/2, tocolor(255,255,255), y*1 )
	
	
	dxDrawText( "Gestión", x*0, y*(-400), sx, sy, tocolor(255,255,255), y*1, r_title, "center", "center" )
	dxDrawText( "De entidades gubernamentales.", x*0, y*(-340), sx, sy, tocolor(255,255,255), y*1, r_desc, "center", "center" )
	dxDrawImage( ( sx - x*(w-10) )/2, ( sy - y*(h-10) )/2, x*70, y*70, "gob.png" )
	
	if isMouseInPosition( ( sx - x*(w-660) )/2, ( sy - y*h )/2, x*20, y*20 ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 500 then
			ntick = getTickCount()
			ventana = 1
			if isElement( guitexto ) then destroyElement( guitexto ) guitexto = nil end 
			faccs = {}
			abierto = false
			removeEventHandler( "onClientRender", getRootElement(), dibujarPanel )			
		end
	end
	
	
	--[[
	
		CUERPO DEL PANEL
	
	]]
	
	if ventana == 1 then
		fila = 0
		if isElement( guitexto ) then destroyElement( guitexto ) guitexto = nil end 
		for i=scroll, scroll + maxscroll do 
			if faccs[i] then
				fila = fila + 1
				dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+340)-fila*170) )/2, x*w1, y*5, tocolor(174, 140, 80) )
				dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+340)-fila*170) )/2, x*w1, y*h1, tocolor(0,0,0,100) )
				
				if fileExists( "faccsimgs/"..faccs[i][3]..".png" ) then
					dxDrawImage( ( sx - x*(w1-5) )/2, ( sy - y*((h1+325)-fila*170) )/2, x*70, y*70, "faccsimgs/"..faccs[i][3]..".png" ) -- Icono de la facc
				else
					dxDrawRectangle( ( sx - x*(w1-5) )/2, ( sy - y*((h1+325)-fila*170) )/2, x*70, y*70, tocolor( 0, 0, 0, 50 ) ) -- En caso de que no haya icono
				end
				
				dxDrawText( faccs[i][1], ( sx - x*(w1-150) )/2, ( sy - y*((h1+320)-fila*170) )/2, x*w1, y*h1, tocolor( 255, 255, 255 ), y*0.7, r_text )
				dxDrawText( "Presupuesto actual: "..faccs[i][2].."$", ( sx - x*(w1-150) )/2, ( sy - y*((h1+290)-fila*170) )/2, x*w1, y*h1, tocolor( 255, 255, 255 ), y*0.8, r_desc )
				
				
				dxDrawImage( ( sx - x*(w1-160) )/2, ( sy - y*((h1+260)-fila*170) )/2, x*30, y*30, "informes.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w1-160) )/2, ( sy - y*((h1+260)-fila*170) )/2, x*30, y*30 ) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )
				
				dxDrawImage( ( sx - x*(w1-250) )/2, ( sy - y*((h1+260)-fila*170) )/2, x*30, y*30, "empleados.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w1-250) )/2, ( sy - y*((h1+260)-fila*170) )/2, x*30, y*30 ) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )
				
				dxDrawRectangle( ( sx - x*(w1-350) )/2, ( sy - y*((h1+240)-fila*170) )/2, x*100, y*20, isMouseInPosition( ( sx - x*(w1-350) )/2, ( sy - y*((h1+240)-fila*170) )/2, x*100, y*20 ) and tocolor( 0, 0, 0, 200 ) or  tocolor( 0, 0, 0, 100 ) )
				dxDrawText( "Presupuesto", ( sx - x*(w1-380) )/2, ( sy - y*((h1+235)-fila*170) )/2, x*100, y*20, tocolor( 255,255,255 ), y*0.8, r_text )
				
				if isMouseInPosition( ( sx - x*(w1-350) )/2, ( sy - y*((h1+240)-fila*170) )/2, x*100, y*20 ) and getKeyState( "mouse1" ) == true then
					if not ntick or ( tick - ntick ) > 500 then
						ntick = getTickCount()
						faccselec = i
						ventana = 2
						scroll = 1
						
					end					
				elseif isMouseInPosition( ( sx - x*(w1-160) )/2, ( sy - y*((h1+260)-fila*170) )/2, x*30, y*30 ) and getKeyState( "mouse1" ) == true then
					if not ntick or ( tick - ntick ) > 500 then
						ntick = getTickCount()
						faccselec = i
						ventana = 3
						scroll = 1
						
						triggerServerEvent( "actualizarInformes", getLocalPlayer(), faccs[faccselec][3], 0, nil )
					end						
				elseif isMouseInPosition( ( sx - x*(w1-250) )/2, ( sy - y*((h1+260)-fila*170) )/2, x*30, y*30 ) and getKeyState( "mouse1" ) == true then
					if not ntick or ( tick - ntick ) > 500 then
						ntick = getTickCount()
						faccselec = i
						ventana = 4
						scroll = 1
						
						triggerServerEvent( "getListaEmpleados", getLocalPlayer(), faccs[faccselec][3] )
					end				
				end
				
			end
		end
	elseif ventana == 2 then
		dxDrawText( "Presupuesto", x*0, y*(-220), sx, sy, tocolor(255,255,255), y*1, r_text, "center", "center" )
		
		dxDrawText( faccs[faccselec][1], x*0, y*(-180), sx, sy, tocolor(255,255,255), y*1, r_desc, "center", "center" )
		
		dxDrawText( "Actual: "..faccs[faccselec][2], x*0, y*(-100), sx, sy, tocolor(255,255,255), y*0.7, r_text_final, "center", "center" )
		if not guitexto then
			guitexto = guiCreateEdit( ( sx - x*(w-200) )/2, ( sy - y*(h-380) )/2, x*150, y*20, "", false )
		end
		
		dxDrawRectangle( ( sx - x*(w-50) )/2, ( sy - y*(h-550) )/2, x*100, y*20, isMouseInPosition( ( sx - x*(w-50) )/2, ( sy - y*(h-550) )/2, x*100, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor( 0, 0, 0, 150 ) )
		dxDrawText( "Retirar", ( sx - x*(w-115) )/2, ( sy - y*(h-555) )/2, x*100, y*20, tocolor(255,255,255), y*0.8, r_button )
		
		dxDrawRectangle( ( sx - x*(w-450) )/2, ( sy - y*(h-550) )/2, x*100, y*20, isMouseInPosition( ( sx - x*(w-450) )/2, ( sy - y*(h-550) )/2, x*100, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor( 0, 0, 0, 150 ) )
		dxDrawText( "Ingresar", ( sx - x*(w-505) )/2, ( sy - y*(h-555) )/2, x*100, y*20, tocolor(255,255,255), y*0.8, r_button )
		
		dxDrawImage( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50, "volver.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50 ) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )
		
		if isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				ventana = 1
				scroll = 1
				faccselec = 0
			end					
		elseif isMouseInPosition( ( sx - x*(w-50) )/2, ( sy - y*(h-550) )/2, x*100, y*20 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				local texto = guiGetText( guitexto )
				if texto and tonumber( texto ) then
					triggerServerEvent( "facc:retirar", getLocalPlayer(), getLocalPlayer(), tonumber( texto ), faccs[faccselec][3] )
					faccs = {}
					if isElement( guitexto ) then destroyElement( guitexto ) guitexto = nil end 
					abierto = false
					removeEventHandler( "onClientRender", getRootElement(), dibujarPanel )								
				else
					outputChatBox( "Introduce una cantidad válida.", 255, 0, 0 )
				end
			end
		elseif isMouseInPosition( ( sx - x*(w-450) )/2, ( sy - y*(h-550) )/2, x*100, y*20 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				local texto = guiGetText( guitexto )
				if texto and tonumber( texto ) then
					triggerServerEvent( "facc:depositar", getLocalPlayer(), getLocalPlayer(), tonumber( texto ), faccs[faccselec][3] )
					faccs = {}
					if isElement( guitexto ) then destroyElement( guitexto ) guitexto = nil end 
					abierto = false
					removeEventHandler( "onClientRender", getRootElement(), dibujarPanel )								
				else
					outputChatBox( "Introduce una cantidad válida.", 255, 0, 0 )
				end
			end			
		end
	elseif ventana == 3 then
		dxDrawText( "Informes", x*0, y*(-250), sx, sy, tocolor(255,255,255), y*1, r_text, "center", "center" )
		dxDrawText( "Manipulación de presupuesto.", x*0, y*(-220), sx, sy, tocolor(255,255,255), y*0.7, r_text, "center", "center" )
		
		dxDrawRectangle( ( sx - x*(w-490) )/2, ( sy - y*(h-260) )/2, x*75, y*20, isMouseInPosition( ( sx - x*(w-490) )/2, ( sy - y*(h-260) )/2, x*75, y*20 ) and tocolor( 255, 150, 0, 100 ) or tocolor( 0, 0, 0, 150 ) )
		dxDrawText( "Reajustar filtros", ( sx - x*(w-495) )/2, ( sy - y*(h-266) )/2, x*120, y*20, tocolor( 255, 255, 255 ), y*0.7, r_button )
		
		dxDrawRectangle( ( sx - x*(w-10) )/2, ( sy - y*(h-320) )/2, x*50, y*20, ( isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-320) )/2, x*50, y*20 ) or tipo_informe == 1 ) and tocolor( 255, 150, 0, 100 ) or tocolor( 0, 0, 0, 150 ) )
		dxDrawText( "Ingresos", ( sx - x*(w-20) )/2, ( sy - y*(h-325) )/2, x*30, y*20, tocolor( 255, 255, 255 ), y*0.7, r_button )
		
		dxDrawRectangle( ( sx - x*(w-120) )/2, ( sy - y*(h-320) )/2, x*50, y*20, ( isMouseInPosition( ( sx - x*(w-120) )/2, ( sy - y*(h-320) )/2, x*50, y*20 ) or tipo_informe == 2 ) and tocolor( 255, 150, 0, 100 ) or tocolor( 0, 0, 0, 150 ) )
		dxDrawText( "Retirada", ( sx - x*(w-135) )/2, ( sy - y*(h-325) )/2, x*50, y*20, tocolor( 255, 255, 255 ), y*0.7, r_button )
		
		
		dxDrawRectangle( ( sx - x*(w-230) )/2, ( sy - y*(h-320) )/2, x*80, y*20, ( isMouseInPosition( ( sx - x*(w-230) )/2, ( sy - y*(h-320) )/2, x*80, y*20 ) or tipo_informe == 3 ) and tocolor( 255, 150, 0, 100 ) or tocolor( 0, 0, 0, 150 ) )
		dxDrawText( "Cambios sueldo", ( sx - x*(w-240) )/2, ( sy - y*(h-325) )/2, x*100, y*20, tocolor( 255, 255, 255 ), y*0.7, r_button )
		
		dxDrawText( "Nombre PJ:", ( sx - x*(w-20) )/2, ( sy - y*(h-270) )/2, x*30, y*20, tocolor( 255, 255, 255 ), y*0.7, r_button )
		if not guitexto then
			guitexto = guiCreateEdit( ( sx - x*(w-130) )/2, ( sy - y*(h-260) )/2, x*150, y*20, "", false )
		end
		
		if #informes > 0 then
			fila = 0
			for i=scroll, scroll + maxscroll do 
				if informes[i] then
					fila = fila + 1
					if tipo_informe == 3 then
						dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+100)-fila*105) )/2, x*w1, y*5, tocolor( 0, 200, 0 ) )
					else
						dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+100)-fila*105) )/2, x*w1, y*5, informes[i].tipo == 1 and tocolor( 0, 200, 0 ) or tocolor( 200, 0, 0 ) )
					end
					dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+100)-fila*105) )/2, x*w1, y*50, tocolor(0,0,0,100) )
					
					if informes[i].sueldo then
						dxDrawText( "Encargado: "..informes[i].encargado.." a "..informes[i].empleado, ( sx - x*(w1-5) )/2, ( sy - y*((h1+85)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_desc )
						dxDrawText( "Nuevo sueldo: "..informes[i].sueldo, ( sx - x*(w1-5) )/2, ( sy - y*((h1+60)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_desc )
						
						dxDrawText( "Fecha: "..os.date( "%d-%m-%Y %H:%M", informes[i].fecha ), ( sx - x*(w1-5) )/2, ( sy - y*((h1+35)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_desc )					
					else
						dxDrawText( "Encargado: "..informes[i].encargado, ( sx - x*(w1-5) )/2, ( sy - y*((h1+85)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_desc )
						dxDrawText( "Cantidad: "..informes[i].cantidad, ( sx - x*(w1-5) )/2, ( sy - y*((h1+60)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_desc )
						
						dxDrawText( "Fecha transacción: "..os.date( "%d-%m-%Y %H:%M", informes[i].fecha ), ( sx - x*(w1-5) )/2, ( sy - y*((h1+35)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_desc )
					end
				end
			end		
		else
			dxDrawText( "No hay informes para mostrar.", x*0, y*(-10), sx, sy, tocolor(255,255,255), y*1, r_text, "center", "center" )
		end
		
		
		dxDrawImage( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50, "volver.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50 ) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )
		
		if isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-320) )/2, x*50, y*20 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				if tipo_informe == 1 then tipo_informe = 0 else tipo_informe = 1 end
			end
		elseif isMouseInPosition( ( sx - x*(w-120) )/2, ( sy - y*(h-320) )/2, x*50, y*20 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				if tipo_informe == 2 then tipo_informe = 0 else tipo_informe = 2 end
			end
		elseif isMouseInPosition( ( sx - x*(w-230) )/2, ( sy - y*(h-320) )/2, x*80, y*20 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				if tipo_informe == 3 then tipo_informe = 0 else tipo_informe = 3 end
			end		
		elseif isMouseInPosition( ( sx - x*(w-490) )/2, ( sy - y*(h-260) )/2, x*75, y*20 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				if faccselec then
					local nombre = guiGetText( guitexto )
					if nombre and tostring( nombre ) ~= " " and #nombre > 5 then
						triggerServerEvent( "actualizarInformes", getLocalPlayer(), faccs[faccselec][3], tonumber( tipo_informe ), tostring( nombre ) )
					else
						triggerServerEvent( "actualizarInformes", getLocalPlayer(), faccs[faccselec][3], tonumber( tipo_informe ), false )
					end
				else
					outputChatBox( "Error con la facción.", 255, 0, 0 )
				end
			end				
		elseif isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50 ) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				ventana = 1
				scroll = 1
				faccselec = 0
			end
		end
		
	elseif ventana == 4 then
		dxDrawText( "Empleados", x*0, y*(-250), sx, sy, tocolor(255,255,255), y*1, r_text, "center", "center" )
		dxDrawText( "Gestión de empleados de "..faccs[faccselec][1], x*0, y*(-220), sx, sy, tocolor(255,255,255), y*0.7, r_text, "center", "center" )
		
		dxDrawText( "Click derecho en las flechas para editar\nlos derechos.", x*0, y*(-170), sx, sy, tocolor(255,255,255), y*0.7, r_text, "center", "center" )
		
		-- IDPJ, NOMBRE, DERECHO, RANGO, SUELDO, ULTIMACONEC
		if ventanasueldo then
			dxDrawRectangle( ( sx - x*(w-710) )/2, ( sy - y*(h-300) )/2, x*200, y*80, tocolor(174, 140, 80, 162) )
			dxDrawText( "Asignar nuevo sueldo", ( sx - x*(w-800) )/2, ( sy - y*(h-310) )/2, x*200, y*80, tocolor( 255, 255, 255 ), y*0.7, r_text )
			
			dxDrawText( "Asignar nuevo sueldo", ( sx - x*(w-800) )/2, ( sy - y*(h-310) )/2, x*200, y*80, tocolor( 255, 255, 255 ), y*0.7, r_text )
			
			if not guitexto then
				guitexto = guiCreateEdit( ( sx - x*(w-750) )/2, ( sy - y*(h-350) )/2, x*150, y*20, "", false )
			end
			
			dxDrawRectangle( ( sx - x*(w-710) )/2, ( sy - y*(h-420) )/2, x*50, y*20, isMouseInPosition( ( sx - x*(w-710) )/2, ( sy - y*(h-420) )/2, x*50, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor(0, 0, 0, 150) )
			dxDrawText( "Asignar", ( sx - x*(w-725) )/2, ( sy - y*(h-425) )/2, x*50, y*20, tocolor( 255, 255, 255 ), y*0.7, r_button )
			
			dxDrawRectangle( ( sx - x*(w-1010) )/2, ( sy - y*(h-420) )/2, x*50, y*20, isMouseInPosition( ( sx - x*(w-1010) )/2, ( sy - y*(h-420) )/2, x*50, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor(0, 0, 0, 150) )	
			dxDrawText( "Cerrar", ( sx - x*(w-1035) )/2, ( sy - y*(h-425) )/2, x*50, y*20, tocolor( 255, 255, 255 ), y*0.7, r_button )
			
			if isMouseInPosition( ( sx - x*(w-710) )/2, ( sy - y*(h-420) )/2, x*50, y*20 ) and getKeyState( "mouse1" ) == true then		
				if not ntick or ( tick - ntick ) > 500 then
					ntick = getTickCount()
					local sueldo = guiGetText( guitexto )
					if tonumber( sueldo ) then
						triggerServerEvent( "cambiarSueldo", getLocalPlayer(), tonumber( idchar ), tonumber( faccs[faccselec][3] ), tonumber( sueldo ), faccs[faccselec][1] )
					else
						outputChatBox( "El sueldo introducido es incorrecto.", 255, 0, 0 )
					end
				end				
			elseif isMouseInPosition( ( sx - x*(w-1010) )/2, ( sy - y*(h-420) )/2, x*50, y*20 ) and getKeyState( "mouse1" ) == true then
				if not ntick or ( tick - ntick ) > 500 then
					ntick = getTickCount()
					if isElement( guitexto ) then destroyElement( guitexto ) guitexto = nil end
					ventanasueldo = nil
					idchar = nil
					indexplayer = nil
				end				
			end
			
		end
		if #empleados > 0 then
			fila = 0
			for i=scroll, scroll + maxscroll do 
				if empleados[i] then
					fila = fila + 1
					
					local len_nombre = string.len( empleados[i][2] )
					
					dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+150)-fila*105) )/2, x*w1, y*50, tocolor(0,0,0,100) )
					if empleados[i][6] == "conectado" then
						dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+150)-fila*105) )/2, x*w1, y*2, tocolor(0,250,0) )
					else
						dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*((h1+150)-fila*105) )/2, x*w1, y*2, tocolor(255,0,0) )
					end
					
					dxDrawText( empleados[i][2].."  "..( getDerechoName( empleados[i][3] ) ) , ( sx - x*(w1-5) )/2, ( sy - y*((h1+140)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_text )
					
					dxDrawText( ranks[tonumber(empleados[i][4])][2], ( sx - x*(w1-5) )/2, ( sy - y*((h1+110)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.7, r_text )
					
					dxDrawText( "Sueldo: "..empleados[i][5].."$. Último fichaje: "..( empleados[i][6] == "conectado" and "Ahora" or tlc( empleados[i][6] ) ), ( sx - x*(w1-5) )/2, ( sy - y*((h1+75)-fila*105) )/2, x*w1, y*50, tocolor(255,255,255), y*0.8, r_desc )
					
					dxDrawImage( ( sx - x*(w1-450) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*20, y*20, "despedir.png" )
					
					dxDrawImage( ( sx - x*(w1-520) )/2, ( sy - y*((h1+125)-fila*105) )/2, x*20, y*20, "sueldo.png" )
					
					dxDrawImage( ( sx - x*(w1-580) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*25, y*20, "imgs/ascender.png" )
					
					dxDrawImage( ( sx - x*(w1-630) )/2, ( sy - y*((h1+125)-fila*105) )/2, x*25, y*20, "imgs/degradar.png" )
					
					if isCursorShowing() then
						scw,sch = guiGetScreenSize()

						cursorX,cursorY = getCursorPosition()

						absX,absY = cursorX*scw,cursorY*sch					
					end
					
					if isMouseInPosition( ( sx - x*(w1-450) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*20, y*20 ) then
						dxDrawText( "Despedir", absX+10, absY-1, 0, 0, tocolor(0,0,0), y*0.7, r_text )
						dxDrawText( "Despedir", absX+10, absY, 0, 0, tocolor(255,255,255), y*0.7, r_text )	
					elseif isMouseInPosition( ( sx - x*(w1-520) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*20, y*20 ) then
						dxDrawText( "Sueldo", absX+10, absY-1, 0, 0, tocolor(0,0,0), y*0.7, r_text )
						dxDrawText( "Sueldo", absX+10, absY, 0, 0, tocolor(255,255,255), y*0.7, r_text )					
					elseif isMouseInPosition( ( sx - x*(w1-580) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*25, y*20 ) then
						dxDrawText( "Ascender", absX+10, absY-1, 0, 0, tocolor(0,0,0), y*0.7, r_text )
						dxDrawText( "Ascender", absX+10, absY, 0, 0, tocolor(255,255,255), y*0.7, r_text )							
					elseif isMouseInPosition( ( sx - x*(w1-630) )/2, ( sy - y*((h1+125)-fila*105) )/2, x*25, y*20 ) then
						dxDrawText( "Degradar", absX+10, absY-1, 0, 0, tocolor(0,0,0), y*0.7, r_text )
						dxDrawText( "Degradar", absX+10, absY, 0, 0, tocolor(255,255,255), y*0.7, r_text )						
					end
					
					if isMouseInPosition( ( sx - x*(w1-450) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*20, y*20 ) and getKeyState( "mouse1" ) == true then
						if not ntick or ( tick - ntick ) > 500 then
							ntick = getTickCount()
							ventana = 1
							scroll = 1
							triggerServerEvent( "empresas:expulsar", getLocalPlayer(), empleados[i][1], faccs[faccselec][3] )
							faccs = {}
							if isElement( guitexto ) then destroyElement( guitexto ) guitexto = nil end 
							abierto = false
							removeEventHandler( "onClientRender", getRootElement(), dibujarPanel )		
							faccselec = 0
						end	
					elseif isMouseInPosition( ( sx - x*(w1-520) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*20, y*20 ) and getKeyState( "mouse1" ) == true then
						if not ntick or ( tick - ntick ) > 500 then
							ntick = getTickCount()
							ventanasueldo = true
							idchar = empleados[i][1]
							indexplayer = i
						end						
					elseif isMouseInPosition( ( sx - x*(w1-630) )/2, ( sy - y*((h1+125)-fila*105) )/2, x*25, y*20 ) and getKeyState( "mouse1" ) == true then
						if not ntick or ( tick - ntick ) > 500 then
							ntick = getTickCount()
							idchar = empleados[i][1]
							triggerServerEvent( "facc:descender", getLocalPlayer(), getLocalPlayer(), idchar, empleados[i][4], ranks, faccs[faccselec][3] )
							
							setTimer( function()
								triggerServerEvent( "getListaEmpleados", getLocalPlayer(), faccs[faccselec][3] )
							end, 200, 1 )
						end
					elseif isMouseInPosition( ( sx - x*(w1-630) )/2, ( sy - y*((h1+125)-fila*105) )/2, x*25, y*20 ) and getKeyState( "mouse2" ) == true then
						if not ntick or ( tick - ntick ) > 500 then
							ntick = getTickCount()
							idchar = empleados[i][1]
							triggerServerEvent( "facc:permisos", getLocalPlayer(), getLocalPlayer(), idchar, 'bajar', faccs[faccselec][3] )
							
							setTimer( function()
								triggerServerEvent( "getListaEmpleados", getLocalPlayer(), faccs[faccselec][3] )
							end, 200, 1 )
						end					
					elseif isMouseInPosition( ( sx - x*(w1-580) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*25, y*20 ) and getKeyState( "mouse1" ) == true then
						if not ntick or ( tick - ntick ) > 500 then
							ntick = getTickCount()
							idchar = empleados[i][1]
							triggerServerEvent( "facc:ascender", getLocalPlayer(), getLocalPlayer(), idchar, empleados[i][4], ranks, faccs[faccselec][3] )
							
							setTimer( function()
								triggerServerEvent( "getListaEmpleados", getLocalPlayer(), faccs[faccselec][3] )
							end, 200, 1 )
						end
					elseif isMouseInPosition( ( sx - x*(w1-580) )/2, ( sy - y*((h1+130)-fila*105) )/2, x*25, y*20 ) and getKeyState( "mouse2" ) == true then
						if not ntick or ( tick - ntick ) > 500 then
							ntick = getTickCount()
							idchar = empleados[i][1]
							triggerServerEvent( "facc:permisos", getLocalPlayer(), getLocalPlayer(), idchar, 'subir', faccs[faccselec][3] )
							
							setTimer( function()
								triggerServerEvent( "getListaEmpleados", getLocalPlayer(), faccs[faccselec][3] )
							end, 200, 1 )
						end					
					end					
				end
			end		
		else
			dxDrawText( "No hay empleados en esta empresa.", x*0, y*(-10), sx, sy, tocolor(255,255,255), y*1, r_text, "center", "center" )
		end
		
		
		dxDrawImage( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50, "volver.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50 ) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )
		
		if isMouseInPosition( ( sx - x*(w-10) )/2, ( sy - y*(h-790) )/2, x*50, y*50 ) and getKeyState( "mouse1" ) == true then		
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				ventana = 1
				scroll = 1
				faccselec = 0
			end				
		end
	end
end

addEvent( "actualizarEmpleados", true )
addEventHandler( "actualizarEmpleados", getRootElement(),
	function( members, rangos )
		empleados = {}
		empleados = members
		ranks = {}
		ranks = rangos
	end
)

bindKey( "mouse_wheel_down", "down", function()
	if abierto then
		if ventana == 1 or ventana == 2 then
			scroll = math.min( scroll + 1, (#faccs)-maxscroll )
		elseif ventana == 3 then
			scroll = math.min( scroll + 1, (#informes)-maxscroll )
		elseif ventana == 4 then
			scroll = math.min( scroll + 1, (#empleados)-maxscroll )
		end
	end
end)

bindKey( "mouse_wheel_up", "down", function()
	if abierto then
		scroll = math.max( scroll - 1, 1 )
	end
end)

addEvent( "informes:actualizar", true )
addEventHandler( "informes:actualizar", getRootElement(),
	function( tablaInformes )
		informes = {}
		informes = tablaInformes
	end
)

addEvent( "gob:abrirPanel", true )
addEventHandler( "gob:abrirPanel", getRootElement(),
	function( tablaGob )
		if not abierto then
			faccs = tablaGob
			abierto = true
			addEventHandler( "onClientRender", getRootElement(), dibujarPanel )
		end
	end	
)

--[[addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		if getPlayerName( getLocalPlayer() ) == "Staff_Blue" then
			addEventHandler( "onClientRender", getRootElement(), dibujarPanel )
			ventana = 3
		end
	end
)--]]
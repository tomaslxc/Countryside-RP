local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1280 ), ( sy / 768 )

local multasp = {}
local vehsp = {}

local datosveh = {}
local propiedades={}
local arrestos={}
local tipobusqueda = 1

local abierto = false
local scroll, maxscroll = 1, 4
local scrollveh, maxscrollveh = 1, 2

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

local ventana = 3
local guitexto = nil
local guitexto2 = nil
local witem, hitem = 300, 60
local w, h = 400, 550

local w1, h1 = 380, 280

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", y*20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*11)
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*16)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", y*8 )
r_thin = dxCreateFont( ":fuentes/Roboto-Thin.ttf", y*50 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", y*11 )

local tick, ntick = 0, nil 

function haceClick( x, y, w, h )
	if isMouseInPosition( x, y, w, h ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 500 then
			return true
		else
			return false
		end
	end
end

function resetearDatos()
	if isElement( guitexto ) then destroyElement( guitexto ) guitexto = nil end
	if isElement( guitexto2 ) then destroyElement( guitexto2 ) guitexto2 = nil end
	tipobusqueda = 1
	scroll, maxscroll = 1, 4
	scrollveh, maxscrollveh = 1, 2
	multasp = {}
	datosveh = {}
	propiedades={}
	vehsp = {}
end

function dibujarPDA()
	tick = getTickCount()

	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor( 174, 140, 80, 162 ) )
	dxDrawText( "Dispositivo policíaco", x*0, y*(-480), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
	
	dxDrawImage( ( sx - x*(w-750) )/2, ( sy - y*(h) )/2, x*25, y*25, "cerrar.png", 0, 0, 0, isMouseInPosition(( sx - x*(w-750) )/2, ( sy - y*(h) )/2, x*25, y*25) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )
	
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*(h-120) )/2, x*w, y*0.5, tocolor( 255, 255, 255, 150 ) ) -- Linea
	
	if isMouseInPosition( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor( 0, 0, 0, 150 ) ) then guiSetInputEnabled( true ) else guiSetInputEnabled( false ) end
	if haceClick(( sx - x*(w-750) )/2, ( sy - y*(h) )/2, x*25, y*25) then
		removeEventHandler( "onClientRender", getRootElement(), dibujarPDA )
		ventana = 0
		ntick = getTickCount()
		resetearDatos()
		guiSetInputEnabled( false )
		abierto = false
	end
	
	--[[ 
	
		MENU DE OPCIONES
	
	]]--
	
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*(h-122) )/2, x*70, y*20, isMouseInPosition( ( sx - x*w )/2, ( sy - y*(h-122) )/2, x*70, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor( 180, 100, 50, 150 ) )
	dxDrawText( "Multas", ( sx - x*(w-35) )/2, ( sy - y*(h-130) )/2, x*100, y*20, tocolor( 255, 255, 255 ), y*0.8, r_button )
	
	dxDrawRectangle( ( sx - x*(w-143) )/2, ( sy - y*(h-122) )/2, x*70, y*20, isMouseInPosition( ( sx - x*(w-148) )/2, ( sy - y*(h-122) )/2, x*70, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor( 180, 100, 50, 150 ) )
	dxDrawText( "Vehículos", ( sx - x*(w-167) )/2, ( sy - y*(h-130) )/2, x*100, y*20, tocolor( 255, 255, 255 ), y*0.8, r_button )
	
	dxDrawRectangle( ( sx - x*(w-287) )/2, ( sy - y*(h-122) )/2, x*70, y*20, isMouseInPosition( ( sx - x*(w-287) )/2, ( sy - y*(h-122) )/2, x*70, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor( 180, 100, 50, 150 ) )
	dxDrawText( "Propiedades", ( sx - x*(w-299) )/2, ( sy - y*(h-130) )/2, x*100, y*20, tocolor( 255, 255, 255 ), y*0.8, r_button )
	
	dxDrawRectangle( ( sx - x*(w-431) )/2, ( sy - y*(h-122) )/2, x*70, y*20, isMouseInPosition( ( sx - x*(w-431) )/2, ( sy - y*(h-122) )/2, x*70, y*20 ) and tocolor( 0, 0, 0, 200 ) or tocolor( 180, 100, 50, 150 ) )
	dxDrawText( "Arrestos", ( sx - x*(w-460) )/2, ( sy - y*(h-130) )/2, x*100, y*20, tocolor( 255, 255, 255 ), y*0.8, r_button )
	
	if haceClick(( sx - x*w )/2, ( sy - y*(h-122) )/2, x*70, y*20) then
		ntick = getTickCount()
		resetearDatos()
		ventana = 1
	elseif haceClick(( sx - x*(w-148) )/2, ( sy - y*(h-122) )/2, x*70, y*20) then
		ntick = getTickCount()
		resetearDatos()
		ventana = 2
	elseif haceClick(( sx - x*(w-287) )/2, ( sy - y*(h-122) )/2, x*70, y*20 ) then
		ntick = getTickCount()
		resetearDatos()
		ventana = 3
	elseif haceClick(( sx - x*(w-431) )/2, ( sy - y*(h-122) )/2, x*70, y*20 ) then
		ntick = getTickCount()
		resetearDatos()
		ventana = 4
	end
	
	--[[
		
		CUERPO DEL PANEL
		
	]]
	
	if ventana == 1 then
		dxDrawText( "Introduce el nombre del personaje", x*0, y*(-350), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
		
		if not guitexto then
			guitexto = guiCreateEdit( ( sx - x*(w-25) )/2, ( sy - y*(h-250) )/2, x*100, y*20, "", false )
		end
		
		dxDrawImage( ( sx - x*(w-235) )/2, ( sy - y*(h-250) )/2, x*20, y*20, "lupa.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-235) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) and tocolor( 255, 255, 255, 50 ) or tocolor( 255, 255, 255 ) )
		
		
		if #multasp > 0 then
			fila = 0
			for i=scroll, scroll + maxscroll do 
				if multasp[ i ] then
					fila = fila + 1
					if multasp[i].pagada == 0 then
						dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*1, y*hitem, tocolor( 200, 0, 0 ) )
						dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*witem, y*hitem, tocolor( 50, 50, 50, 150 ) )
						
						dxDrawText( "Agente: "..multasp[i].agente, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+295)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 
						dxDrawText( "Cantidad: "..multasp[i].cantidad.."$", ( sx - x*(witem-10) )/2, ( sy - y*((hitem+265)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final )
						dxDrawText( "Fecha: "..os.date( "%d-%m-%Y %H:%M",multasp[i].fecha), ( sx - x*(witem-10) )/2, ( sy - y*((hitem+240)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 						
						
						dxDrawText( "Motivo: "..multasp[i].motivo, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+205)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.8, r_desc ) 
					end
				end
			end	
		else
			dxDrawText( "No hay multas para mostrar.", x*0, y*(0), sx, sy, tocolor( 255, 255, 255 ), y*0.8, r_title, "center", "center" )
		end
		
		if haceClick(( sx - x*(w-235) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				local npj = guiGetText( guitexto )
				if npj and string.find( npj, "_" ) then
					triggerServerEvent( "pda:solicitarMultas", getLocalPlayer(), npj )
				else
					outputChatBox( "Introduce un nombre en el campo de nombre. Formato: Nombre_Apellido", 255, 0, 0 )
				end
			end
		end
	elseif ventana == 2 then
		dxDrawText( "Introduce el nombre del personaje o la matrícula", x*0, y*(-350), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
		
		if not guitexto then
			guitexto = guiCreateEdit( ( sx - x*(w-120) )/2, ( sy - y*(h-250) )/2, x*100, y*20, "", false )
		end
		if not guitexto2 then
			guitexto2 = guiCreateEdit( ( sx - x*(w-500) )/2, ( sy - y*(h-250) )/2, x*100, y*20, "", false )
		end
		
		dxDrawText( "Nombre:", ( sx - x*(w-15) )/2, ( sy - y*(h-256) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_desc )
		
		dxDrawText( "Matrícula:", ( sx - x*(w-385) )/2, ( sy - y*(h-256) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_desc )
		
		dxDrawImage( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20, "lupa.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) and tocolor( 255, 255, 255, 50 ) or tocolor( 255, 255, 255 ) )
		dxDrawImage( ( sx - x*(w-710) )/2, ( sy - y*(h-250) )/2, x*20, y*20, "lupa.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-710) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) and tocolor( 255, 255, 255, 50 ) or tocolor( 255, 255, 255 ) )
		
		if tipobusqueda == 1 then
			if #vehsp > 0 then
				fila = 0
				for i=scroll, scroll + maxscroll do 
					if vehsp[ i ] then
						fila = fila + 1
						
						dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*1, y*hitem, tocolor( 160, 100, 50 ) )
						dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*witem, y*hitem, tocolor( 50, 50, 50, 150 ) )
							
						dxDrawText( "Modelo: "..getVehicleNameFromModel( vehsp[i].modelo ), ( sx - x*(witem-10) )/2, ( sy - y*((hitem+295)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 
						dxDrawText( "Matricula: "..vehsp[i].matricula, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+265)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final )
						--dxDrawText( "((ID)): "..vehsp[i].id, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+240)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 						
							
						dxDrawText( "Bastidor: "..vehsp[i].id, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+205)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.8, r_desc ) 
					end
				end			
			else
				dxDrawText( "No hay vehículos para mostrar.", x*0, y*(0), sx, sy, tocolor( 255, 255, 255 ), y*0.8, r_title, "center", "center" )
			end
		elseif tipobusqueda == 2 then
			if datosveh then
				dxDrawText( "Propietario: "..(datosveh[2] or "?"), ( sx - x*(w-25) )/2, ( sy - y*(h-330) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_text )
				dxDrawText( "Matrícula: "..( datosveh[1] and getVehiclePlateText(datosveh[1]) or "?"), ( sx - x*(w-25) )/2, ( sy - y*(h-370) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_text )
				dxDrawText( "Modelo: "..( datosveh[1] and getVehicleNameFromModel( getElementModel( datosveh[1] ) ) or "?"), ( sx - x*(w-25) )/2, ( sy - y*(h-410) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_text )
				dxDrawText( "Bastidor: "..( datosveh[1] and getElementData( datosveh[1], "id" ) or "?"), ( sx - x*(w-25) )/2, ( sy - y*(h-450) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_text )
				
				
				
				dxDrawRectangle( ( sx - x*w1 )/2, ( sy - y*(h1-250) )/2, x*w1, y*h1, tocolor( 0, 0, 0, 150 ) )
				
				dxDrawText( "Multas asignadas", x*0, y*(10), sx, sy, tocolor( 255, 255, 255 ), y*1, r_text_final, "center", "center" )
				
				if #multasp > 0 then
					fila = 0
					for i=scrollveh, scrollveh + maxscrollveh do 
						if multasp[ i ] then
							fila = fila + 1
							dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem)-fila*150) )/2, x*1, y*hitem, tocolor( 200, 0, 0 ) )
							dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem)-fila*150) )/2, x*witem, y*hitem, tocolor( 50, 50, 50, 150 ) )
							
							dxDrawText( "Agente: "..multasp[i].agente, ( sx - x*(witem-10) )/2, ( sy - y*((hitem-10)-fila*150) )/2, x*witem, y*hitem, tocolor( 255,255,255 ), y*0.8, r_desc )
							dxDrawText( "Cantidad: "..multasp[i].cantidad.."$", ( sx - x*(witem-10) )/2, ( sy - y*((hitem-35)-fila*150) )/2, x*witem, y*hitem, tocolor( 255,255,255 ), y*0.8, r_desc )
							dxDrawText( "Fecha: "..os.date( "%d-%m-%Y %H:%M",multasp[i].fecha), ( sx - x*(witem-10) )/2, ( sy - y*((hitem-60)-fila*150) )/2, x*witem, y*hitem, tocolor( 255,255,255 ), y*0.8, r_desc )
							
							dxDrawText( multasp[i].motivo, ( sx - x*(witem-10) )/2, ( sy - y*((hitem-90)-fila*150) )/2, x*witem, y*hitem, tocolor( 255,255,255 ), y*0.8, r_desc )
						end
					end	
				else
					dxDrawText( "No hay multas para mostrar.", x*0, y*(250), sx, sy, tocolor( 255, 255, 255 ), y*0.8, r_title, "center", "center" )
				end
			else
				dxDrawText( "No hay vehículos para mostrar.", x*0, y*(0), sx, sy, tocolor( 255, 255, 255 ), y*0.8, r_title, "center", "center" )
			end
		end
		
		if haceClick( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) then
			ntick = getTickCount()
			local nombre = guiGetText( guitexto )
			if nombre and #nombre > 5 then
				tipobusqueda = 1
				triggerServerEvent( "pda:getVehiculosFromName", getLocalPlayer(), nombre )
			else
				outputChatBox( "Introduce un nombre válido para buscar en la base de datos.", 255, 0, 0 )
			end
		elseif haceClick( ( sx - x*(w-710) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) then
			ntick = getTickCount()
			local nombre = guiGetText( guitexto2 )
			if nombre and #nombre > 5 then
				tipobusqueda = 2
				triggerServerEvent( "pda:getPropietarioFromMatricula", getLocalPlayer(), nombre )
			else
				outputChatBox( "Introduce una matrícula válida para buscar en la base de datos.", 255, 0, 0 )
			end		
		end
	elseif ventana == 3 then
		dxDrawText( "Introduce el nombre del personaje.", x*0, y*(-350), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
		
		if not guitexto then
			guitexto = guiCreateEdit( ( sx - x*(w-120) )/2, ( sy - y*(h-250) )/2, x*100, y*20, "", false )
		end
		--[[if not guitexto2 then
			guitexto2 = guiCreateEdit( ( sx - x*(w-500) )/2, ( sy - y*(h-250) )/2, x*100, y*20, "", false )
		end--]]
		
		dxDrawText( "Nombre:", ( sx - x*(w-15) )/2, ( sy - y*(h-256) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_desc )
		
		--dxDrawText( "Propiedad:", ( sx - x*(w-380) )/2, ( sy - y*(h-256) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_desc )
		
		dxDrawImage( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20, "lupa.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) and tocolor( 255, 255, 255, 50 ) or tocolor( 255, 255, 255 ) )
		--dxDrawImage( ( sx - x*(w-710) )/2, ( sy - y*(h-250) )/2, x*20, y*20, "lupa.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-710) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) and tocolor( 255, 255, 255, 50 ) or tocolor( 160, 120, 50, 150 ) )
		
		if #propiedades > 0 then
			fila = 0
			for i=scroll, scroll + maxscroll do 					
				if propiedades[ i ] then
					fila = fila + 1
					dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*1, y*hitem, tocolor( 200, 0, 0 ) )
					dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*witem, y*hitem, tocolor( 50, 50, 50, 150 ) )
						
					dxDrawText( "Nombre: "..propiedades[i].name, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+295)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 
					dxDrawText( "Precio: "..( propiedades[i].precio or 0 ).."$", ( sx - x*(witem-10) )/2, ( sy - y*((hitem+265)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final )
					dxDrawText( "Ubicación: "..getZoneName( propiedades[i].x_out, propiedades[i].y_out ,propiedades[i].z_out ), ( sx - x*(witem-10) )/2, ( sy - y*((hitem+240)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 						
				end
			end			
		else
			dxDrawText( "No hay propiedades para mostrar.", x*0, y*(0), sx, sy, tocolor( 255, 255, 255 ), y*0.8, r_title, "center", "center" )
		end
		
		if haceClick( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) then
			ntick = getTickCount()
			local nombre = guiGetText( guitexto )
			if nombre and #nombre > 5 then
				triggerServerEvent( "pda:getPropiedades", getLocalPlayer(), nombre )
			else
				outputChatBox( "Introduce un nombre válido para buscar en la base de datos.", 255, 0, 0 )
			end
		end
	elseif ventana == 4 then
		dxDrawText( "Introduce el nombre del personaje.", x*0, y*(-350), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
		
		if not guitexto then
			guitexto = guiCreateEdit( ( sx - x*(w-120) )/2, ( sy - y*(h-250) )/2, x*100, y*20, "", false )
		end
		--[[if not guitexto2 then
			guitexto2 = guiCreateEdit( ( sx - x*(w-500) )/2, ( sy - y*(h-250) )/2, x*100, y*20, "", false )
		end--]]
		
		dxDrawText( "Nombre:", ( sx - x*(w-15) )/2, ( sy - y*(h-256) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_desc )
		
		--dxDrawText( "Propiedad:", ( sx - x*(w-380) )/2, ( sy - y*(h-256) )/2, x*20, y*20, tocolor( 255,255,255 ), y*1, r_desc )
		
		dxDrawImage( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20, "lupa.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) and tocolor( 255, 255, 255, 50 ) or tocolor( 255, 255, 255 ) )	
		
		if #arrestos > 0 then
			fila = 0
			for i=scroll, scroll + maxscroll do 					
				if arrestos[ i ] then
					fila = fila + 1
					dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*1, y*hitem, tocolor( 174, 100, 30 ) )
					dxDrawRectangle( ( sx - x*(witem) )/2, ( sy - y*((hitem+300)-fila*150) )/2, x*witem, y*hitem, tocolor( 50, 50, 50, 150 ) )
						
					dxDrawText( "Agente: "..arrestos[i].agente, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+295)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 
					dxDrawText( "Motivo: "..arrestos[i].motivo, ( sx - x*(witem-10) )/2, ( sy - y*((hitem+265)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final )
					dxDrawText( "Fecha: "..os.date( "%d-%m-%Y %H-%M" ,arrestos[i].fecha), ( sx - x*(witem-10) )/2, ( sy - y*((hitem+240)-fila*150) )/2, x*witem, y*hitem, tocolor( 255, 255, 255 ), y*0.5, r_text_final ) 						
				end
			end		
		else
			dxDrawText( "No hay registro de arrestos.", x*0, y*(0), sx, sy, tocolor( 255, 255, 255 ), y*0.8, r_title, "center", "center" )
		end

		if haceClick( ( sx - x*(w-330) )/2, ( sy - y*(h-250) )/2, x*20, y*20 ) then
			ntick = getTickCount()
			local nombre = guiGetText( guitexto )
			if nombre and #nombre > 5 then
				triggerServerEvent( "pda:getRegistroArrestos", getLocalPlayer(), nombre )
			else
				outputChatBox( "Introduce un nombre válido para buscar en la base de datos.", 255, 0, 0 )
			end
		end
	end
end

bindKey( "mouse_wheel_up", "down", function()
	if ventana == 2 and tipobusqueda == 2 then
		scrollveh = math.max( scrollveh - 1, 1 )
	else
		scroll = math.max( scroll - 1, 1 )
	end
end )

bindKey( "mouse_wheel_down", "down", function()
	if ventana == 2 and tipobusqueda == 2 then
		scrollveh = math.min( scrollveh + 1, (#multasp) - maxscrollveh )
	elseif ventana == 3 then
		scroll = math.min( scrollveh + 1, (#propiedades) - maxscroll )
	elseif ventana == 4 then
		scroll = math.min( scrollveh + 1, (#arrestos) - maxscroll )
	else
		scroll = math.min( scroll + 1, (#multasp) - maxscroll )
	end
end )

addEvent( "pda:recibirPropiedades", true )
addEventHandler( "pda:recibirPropiedades", getRootElement(),
	function( data )
		propiedades = {}
		propiedades = data
	end
)

addEvent( "pda:givedatosarrestos", true )
addEventHandler( "pda:givedatosarrestos", getRootElement(),
	function( data )
		arrestos = {}
		arrestos = data
	end
)
	
addEvent( "pda:givemultasveh", true )
addEventHandler( "pda:givemultasveh", getRootElement(),
	function( data )
		multasp = {}
		multasp = data
	end
)

addEvent( "pda:givedatospropietario", true )
addEventHandler( "pda:givedatospropietario", getRootElement(),
	function( data )
		datosveh = {}
		datosveh = data
		
		if datosveh then
			triggerServerEvent( "pda:solicitarMultasVeh", getLocalPlayer(), getLocalPlayer(), getElementData( data[1], "id" ) )		
		end
	end
)

addEvent( "pda:givevehiculos", true )
addEventHandler( "pda:givevehiculos", getRootElement(),
	function( data )
		vehsp = {}
		vehsp = data
		--outputChatBox( #vehsp )
	end
)

addEvent( "pda:givemultas", true )
addEventHandler( "pda:givemultas", getRootElement(),
	function( data )
		multasp = {}
		multasp = data
	end
)

addEvent( "pda:abrir", true )
addEventHandler( "pda:abrir", getRootElement(),
	function()
		if not abierto then
			addEventHandler( "onClientRender", getRootElement(), dibujarPDA )
			tipobusqueda = 1
			abierto = false
		end
	end
)

--[[addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		if getPlayerName( getLocalPlayer() ) == "Staff_Blue" then
			addEventHandler( "onClientRender", getRootElement(), dibujarPDA )
			tipobusqueda = 1
		end
	end
)--]]
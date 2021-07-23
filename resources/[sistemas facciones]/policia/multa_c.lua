local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1280 ), ( sy / 720 )

local poli = true
local veh = nil
local ventana = 1

local infoveh = {}
local registrocepo = {}
local abierto = false

local w, h = 300, 250
local wimg, himg = 250, 100

local witem, hitem = 250, 30

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

local guicantidad = nil
local guimotivo = nil

local scroll, maxscroll = 1, 3

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", y*20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*11)
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*16)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", y*8 )
r_thin = dxCreateFont( ":fuentes/Roboto-Thin.ttf", y*8 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", y*11 )

local tick, ntick = 0, nil

function dibujarPanelVeh()
	tick = getTickCount()
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor( 0, 0, 0, 150 ) )
	if ventana == 1 then
		
		dxDrawText( getVehicleNameFromModel( getElementModel( veh ) ), x*0, y*(-200), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
		dxDrawText( "Información del vehículo.", x*0, y*(-150), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
		
		dxDrawImage( ( sx - x*wimg )/2, ( sy - y*himg )/2, x*wimg, y*himg, "matricula.png" )
		
		dxDrawText( getVehiclePlateText( veh ), x*0, y*(10), sx, sy, tocolor( 0, 0, 0 ), y*2, r_text, "center", "center" )
		
		if poli then
			dxDrawImage( ( sx - x*(w-20) )/2, ( sy - y*(h-360) )/2, x*45, y*50, "multa.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-20) )/2, ( sy - y*(h-360) )/2, x*45, y*50 ) and tocolor( 255, 255, 255, 100 ) or tocolor(255,255,255) )
			dxDrawText( "Multar", ( sx - x*(w-45) )/2, ( sy - y*(h-470) )/2, x*45, y*50, tocolor(255,255,255), y*0.7, r_desc )
			
			dxDrawImage( ( sx - x*(w-150) )/2, ( sy - y*(h-360) )/2, x*45, y*50, "infoveh.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-150) )/2, ( sy - y*(h-360) )/2, x*45, y*50 ) and tocolor( 255, 255, 255, 100 ) or tocolor(255,255,255) )
			dxDrawText( "Información", ( sx - x*(w-150) )/2, ( sy - y*(h-470) )/2, x*45, y*50, tocolor(255,255,255), y*0.7, r_desc )
			
			dxDrawImage( ( sx - x*(w-270) )/2, ( sy - y*(h-360) )/2, x*45, y*50, "cepo.png", 0, 0, 0, isMouseInPosition(( sx - x*(w-270) )/2, ( sy - y*(h-360) )/2, x*45, y*50) and tocolor( 255, 255, 255, 100 ) or ( getElementData(veh,"cepo") == 1 and tocolor( 150, 0, 0, 150 ) or tocolor(255,255,255)) )
			dxDrawText( "Inmovilizar", ( sx - x*(w-280) )/2, ( sy - y*(h-470) )/2, x*45, y*50, tocolor(255,255,255), y*0.7, r_desc )
			
			dxDrawImage( ( sx - x*(w-400) )/2, ( sy - y*(h-360) )/2, x*45, y*50, "registrocepo.png", 0, 0, 0, isMouseInPosition( ( sx - x*(w-400) )/2, ( sy - y*(h-360) )/2, x*45, y*50 ) and tocolor( 255, 255, 255, 150 ) or tocolor( 255, 255, 255 ) )
			dxDrawText( "Registro", ( sx - x*(w-412) )/2, ( sy - y*(h-470) )/2, x*45, y*50, tocolor(255,255,255), y*0.7, r_desc )
			
			if isMouseInPosition(( sx - x*(w-20) )/2, ( sy - y*(h-360) )/2, x*45, y*50) and getKeyState( "mouse1" ) == true then
				if not ntick or ( tick - ntick ) > 500 then
					ntick = getTickCount()
					ventana = 2
				end
			elseif isMouseInPosition(( sx - x*(w-150) )/2, ( sy - y*(h-360) )/2, x*45, y*50) and getKeyState("mouse1") == true then
				if not ntick or ( tick - ntick ) > 500 then
					ntick = getTickCount()
					triggerServerEvent( "veh:solicitarDatos", getLocalPlayer(), veh )
					ventana = 3
				end				
			elseif isMouseInPosition(( sx - x*(w-270) )/2, ( sy - y*(h-360) )/2, x*45, y*50) and getKeyState("mouse1") == true then
				if not ntick or ( tick - ntick ) > 500 then
					ntick = getTickCount()
					triggerServerEvent( "veh:inmovilizarVeh", getLocalPlayer(), veh )
				end					
			elseif isMouseInPosition( ( sx - x*(w-400) )/2, ( sy - y*(h-360) )/2, x*45, y*50 ) and getKeyState( "mouse1" ) == true then
				if not ntick or ( tick - ntick ) > 500 then
					ntick = getTickCount()
					triggerServerEvent( "veh:solicitarRegistros", getLocalPlayer(), veh )
					ventana = 4
				end					
			end
 		end
	elseif ventana == 2 then
		dxDrawText( "PONER MULTA", x*0, y*(-200), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
		dxDrawText( "Multar "..getVehicleNameFromModel( getElementModel( veh ) ), x*0, y*(-150), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
		
		dxDrawText( "Cantidad $:", ( sx - x*(wimg-20) )/2, ( sy - y*(himg-5) )/2, x*100, y*20, tocolor(255,255,255), y*0.7, r_text )
		dxDrawText( "Comentario:", ( sx - x*(wimg-20) )/2, ( sy - y*(himg-110) )/2, x*100, y*20, tocolor(255,255,255), y*0.7, r_text )
		if not guicantidad then
			guicantidad = guiCreateEdit( ( sx - x*(wimg-150) )/2, ( sy - y*himg )/2, x*100, y*20, "", false )
		end
		if not guimotivo then
			guimotivo = guiCreateEdit( ( sx - x*(wimg-150) )/2, ( sy - y*(himg-100) )/2, x*100, y*20, "", false )
		end
		
		dxDrawRectangle( ( sx - x*(w-200) )/2, ( sy - y*(h-350) )/2, x*100, y*20, isMouseInPosition(( sx - x*(w-200) )/2, ( sy - y*(h-350) )/2, x*100, y*20) and tocolor(180, 100, 20, 200) or tocolor(160, 100, 20, 150) )
		dxDrawText( "Multar", ( sx - x*(w-270) )/2, ( sy - y*(h-357) )/2, x*100, y*20, tocolor(255,255,255), y*0.7, r_button )
		
		if isMouseInPosition(( sx - x*(w-200) )/2, ( sy - y*(h-350) )/2, x*100, y*20) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				local cantidad = tonumber( guiGetText( guicantidad ) )
				local motivo = tostring( guiGetText( guimotivo ) )
				if cantidad and motivo then
					triggerServerEvent( "veh:colocarMulta", getLocalPlayer(), veh, cantidad, motivo )
					if isElement( guicantidad ) then destroyElement( guicantidad ) guicantidad = nil end
					if isElement( guimotivo ) then destroyElement( guimotivo ) guimotivo = nil end
					ventana = 1
				else
					outputChatBox( "Parámetros incorrectos.", 255, 0, 0 )
				end
			end		
		elseif isMouseInPosition(( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55) and getKeyState( "mouse1" ) == true then
			if not ntick or ( tick - ntick ) > 500 then
				ntick = getTickCount()
				if isElement( guicantidad ) then destroyElement( guicantidad ) guicantidad = nil end
				if isElement( guimotivo ) then destroyElement( guimotivo ) guimotivo = nil end
				ventana = 1
			end
		end
		
		dxDrawImage( ( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55, ":gobierno/volver.png", 0, 0, 0, isMouseInPosition(( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55) and tocolor(255,255,255,100) or tocolor(255,255,255) )
	elseif ventana == 3 then
		dxDrawText( "INFORMACIÓN", x*0, y*(-200), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
		dxDrawText( "Información del vehículo.", x*0, y*(-150), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
		
		dxDrawText( "Dueño: "..( #infoveh > 0 and infoveh[1] or "" ), ( sx - x*(wimg-20) )/2, ( sy - y*(himg-5) )/2, x*100, y*20, tocolor(255,255,255), y*0.7, r_text )
		dxDrawText( "Matrícula: "..getVehiclePlateText( veh ), ( sx - x*(wimg-20) )/2, ( sy - y*(himg-55) )/2, x*100, y*20, tocolor(255,255,255), y*0.7, r_text )
		dxDrawText( "Impuestos: ", ( sx - x*(wimg-20) )/2, ( sy - y*(himg-105) )/2, x*100, y*20, tocolor(255,255,255), y*0.7, r_text )
		
		dxDrawImage( ( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55, ":gobierno/volver.png", 0, 0, 0, isMouseInPosition(( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55) and tocolor(255,255,255,100) or tocolor(255,255,255) )
		
	elseif ventana == 4 then
		dxDrawText( "REGISTROS", x*0, y*(-200), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
		dxDrawText( "Registros de cepo.", x*0, y*(-150), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )	
		
		
		dxDrawImage( ( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55, ":gobierno/volver.png", 0, 0, 0, isMouseInPosition(( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55) and tocolor(255,255,255,100) or tocolor(255,255,255) )

		if #registrocepo > 0 then
			fila = 0
			for i=scroll, scroll + maxscroll do 
				if registrocepo[i] then
					fila = fila + 1
					dxDrawRectangle( ( sx - x*witem )/2, ( sy - y*((hitem+160)-fila*65) )/2, x*witem, y*hitem, tonumber(registrocepo[i].tipo) == 1 and tocolor( 200, 0, 0, 150 ) or tocolor( 0, 200, 0, 150 ) )
					
					dxDrawText( registrocepo[i].agente, ( sx - x*(witem-5) )/2, ( sy - y*((hitem+155)-fila*65) )/2, x*witem, y*hitem, tocolor(255,255,255), y*0.8, r_desc )
					dxDrawText( os.date( "%d-%m-%Y %H:%M",registrocepo[i].fecha), ( sx - x*(witem-5) )/2, ( sy - y*((hitem+130)-fila*65) )/2, x*witem, y*hitem, tocolor(255,255,255), y*0.8, r_desc )
				end
			end
		else
			dxDrawText( "Sin registros.", x*0, y*(10), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )	
		end
	end
	
	if isMouseInPosition(( sx - x*(w-20) )/2, ( sy - y*(h-390) )/2, x*45, y*55) and getKeyState( "mouse1" ) == true and ventana > 1 then
		if not ntick or ( tick - ntick ) > 500 then
			ntick = getTickCount()
			if isElement( guicantidad ) then destroyElement( guicantidad ) guicantidad = nil end
			if isElement( guimotivo ) then destroyElement( guimotivo ) guimotivo = nil end
			ventana = 1
		end
	end
	
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*(h-500) )/2, x*w, y*30, isMouseInPosition(( sx - x*w )/2, ( sy - y*(h-500) )/2, x*w, y*30) and tocolor( 180, 100, 20, 200 ) or tocolor( 160, 100, 20, 150 ) )
		
	dxDrawText( "Cerrar", x*0, y*(280), sx, sy, tocolor( 255, 255, 255 ), y*1, r_button, "center", "center" )
	
	if isMouseInPosition( ( sx - x*w )/2, ( sy - y*(h-500) )/2, x*w, y*30 ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 500 then
			ntick = getTickCount()
			if isElement( guicantidad ) then destroyElement( guicantidad ) guicantidad = nil end
			if isElement( guimotivo ) then destroyElement( guimotivo ) guimotivo = nil end
			abierto = false
			veh = nil
			poli = nil
			ventana = 1
			removeEventHandler( "onClientRender", getRootElement(), dibujarPanelVeh )
		end
	end
end

local wpanel, ypanel = 300, 400

local multasp = {}
local abiertomultas = false

local wmulta, hmulta = 250, 60

function panelMultas()
	tick = getTickCount()
	dxDrawRectangle( ( sx - x*wpanel )/2, ( sy - y*ypanel )/2, x*wpanel, y*ypanel, tocolor(0,0,0,150) )
	dxDrawText( "Tus multas", x*0, y*(-350), sx, sy, tocolor(255,255,255), y*1, r_title, "center", "center" )
	dxDrawText( "Consulta o paga aquí tus multas pendientes.", x*0, y*(-300), sx, sy, tocolor(255,255,255), y*1, r_desc, "center", "center" )
	
	if multasp and #multasp > 0 then
		fila = 0
		for i=scroll, scroll + maxscroll do
			if multasp[i] and multasp[i].pagada == 0 then
				fila = fila + 1
				
				dxDrawRectangle( ( sx - x*wmulta )/2, ( sy - y*((hmulta+300)-fila*130) )/2, x*wmulta, y*hmulta, tocolor( 0, 0, 0, 150 ) )
				dxDrawRectangle( ( sx - x*wmulta )/2, ( sy - y*((hmulta+300)-fila*130) )/2, x*2, y*hmulta, multasp[i].pagada == 0 and tocolor(255,0,0,100) or tocolor( 0, 200, 0, 150 ) )
				dxDrawText( "Agente: "..multasp[i].agente, ( sx - x*(wmulta-10) )/2, ( sy - y*((hmulta+290)-fila*130) )/2, x*wmulta, y*hmulta, tocolor( 255, 255, 255 ), y*0.7, r_button )
				dxDrawText( "Cantidad: "..multasp[i].cantidad.."$", ( sx - x*(wmulta-10) )/2, ( sy - y*((hmulta+260)-fila*130) )/2, x*wmulta, y*hmulta, tocolor( 255, 255, 255 ), y*0.7, r_button )
				dxDrawText( multasp[i].motivo, ( sx - x*(wmulta-10) )/2, ( sy - y*((hmulta+210)-fila*130) )/2, x*wmulta, y*hmulta, tocolor( 255, 255, 255 ), y*0.8, r_desc )
				
				--if multasp[i].pagada == 0 then
					dxDrawRectangle( ( sx - x*(wmulta-280) )/2, ( sy - y*((hmulta+265)-fila*130) )/2, x*80, y*25, isMouseInPosition(( sx - x*(wmulta-280) )/2, ( sy - y*((hmulta+265)-fila*130) )/2, x*80, y*25) and tocolor(180,100,90,100) or tocolor( 160, 100, 50, 150 ) )
					
					dxDrawText( "Pagar multa", ( sx - x*(wmulta-305) )/2, ( sy - y*((hmulta+255)-fila*130) )/2, x*100, y*25, tocolor(255,255,255), y*0.7, r_button )
					
					if isMouseInPosition(( sx - x*(wmulta-280) )/2, ( sy - y*((hmulta+265)-fila*130) )/2, x*80, y*25) and getKeyState("mouse1") == true then
						if not ntick or ( tick - ntick ) > 500 then
							ntick = getTickCount()
							triggerServerEvent( "multas:pagarMulta", getLocalPlayer(), multasp[i] )
						end					
					end
				--end
			end
		end
	else
		dxDrawText( "No tienes multas.", x*0, y*(0), sx, sy, tocolor(255,255,255), y*1, r_text, "center", "center" )
	end
	
	dxDrawRectangle( ( sx - x*wpanel )/2, ( sy - y*(ypanel-740) )/2, x*wpanel, y*30, isMouseInPosition(( sx - x*wpanel )/2, ( sy - y*(ypanel-740) )/2, x*wpanel, y*30) and tocolor(180,100,90,100) or tocolor(160,100,50,150) )
	
	dxDrawText( "Cerrar", x*0, y*(370), sx, sy, tocolor(255,255,255), y*1, r_button, "center", "center" )
	
	if isMouseInPosition(( sx - x*wpanel )/2, ( sy - y*(ypanel-740) )/2, x*wpanel, y*30) and getKeyState("mouse1") == true then
		if not ntick or ( tick - ntick ) > 500 then
			ntick = getTickCount()
			abiertomultas = false
			scroll, maxscroll = 1, 3
			multasp = {}
			removeEventHandler( "onClientRender", getRootElement(), panelMultas )
		end
	end
end

addEvent( "multas:givedatos", true )
addEventHandler( "multas:givedatos", getRootElement(),
	function( datos )
		if abiertomultas then
			multasp = {}
			multasp = datos
		end
	end
)

addEvent( "multas:abrirPanel", true )
addEventHandler( "multas:abrirPanel", getRootElement(),
	function( )
		if not abiertomultas then
			abiertomultas = true
			addEventHandler( "onClientRender", getRootElement(), panelMultas )
		end
	end
)

bindKey( "mouse_wheel_down", "down", function()
	if abiertomultas then
		scroll = math.min( scroll + 1, (#multasp) -maxscroll)
	else
		scroll = math.min( scroll + 1, (#registrocepo) -maxscroll)
	end
end
)

bindKey( "mouse_wheel_up", "down", function()
	scroll = math.max( scroll - 1, 1)
end
)

addEvent( "veh:ofrecerRegistroCepo", true )
addEventHandler( "veh:ofrecerRegistroCepo", getRootElement(),
	function( datos )
		registrocepo = {}
		registrocepo = datos
	end
)

addEvent( "veh:actualizarDatosVeh", true )
addEventHandler( "veh:actualizarDatosVeh", getRootElement(),
	function( datos )
		infoveh = {} -- limpiamos la tabla pq somos unos putos amos
		infoveh = datos
	end
)

addEvent( "veh:mostrarPanel", true )
addEventHandler( "veh:mostrarPanel", getRootElement(),
	function( ispoli, vehiculo )
		if not abierto then
			abierto = true
			poli = ispoli
			scroll = 1
			maxscroll = 3
			veh = vehiculo
			addEventHandler( "onClientRender", getRootElement(), dibujarPanelVeh )
		end
	end
)

--[[addEventHandler( "onClientResourceStart", resourceRoot,
	function( ispoli )
		if getPlayerName( getLocalPlayer() ) == "Staff_Blue" then
			addEventHandler( "onClientRender", getRootElement(), dibujarPanelVeh )
			poli = ispoli
		end
	end
)--]]
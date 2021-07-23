local sx, sy = guiGetScreenSize()
local x, y = ( sx /1024 ), ( sy/768 ) -- Para multiplicar y tal

local blip,col
local ganancias = 0
local planta = {}
local haciendo = {} -- 1 = cosechar, 2 = arar es para no crear eventos innecesarios

r_desc = dxCreateFont( ":jobs/Roboto-Italic.ttf", 10 )

setWorldSpecialPropertyEnabled( "randomfoliage", false ) -- Quitar las plantas que daban por culo

local startx = -100
local max_x = 120
local ntick, ntickshow = 0,nil

function drawAyuda()
	ntick = getTickCount()
	if ( ntick - ntickshow ) > 0 then
		removeEventHandler( "onClientRender", getRootElement(), drawAyuda ) 
		ntick, ntickshow = 0,nil
	else
		if startx < max_x then startx = math.min( startx + 10, max_x ) end
		dxDrawRectangle( x*startx, y*400, x*110, y*2, tocolor(34,94,122,150) )
		dxDrawRectangle( x*startx, y*400, x*110, y*130, tocolor(2,105,156,20) )
		dxDrawImage( x*(startx-50), y*365, x*200, y*200, "trigo.png" )
		dxDrawText( "Esta es la planta de trigo\nque necesitas cosechar.", x*(startx+120), y*400, x*110, y*130, tocolor(255,255,255), y*1, r_desc )
	end
end

function drawMiniAyuda()
	ntickshow = getTickCount() + 5000
	addEventHandler( "onClientRender", getRootElement(), drawAyuda ) 
end

function getTrabajo()
    local time = getRealTime()
    if getActividadJob( time.month ) == 1 then
        if isElement( col ) then destroyElement( col ) col = nil end
        if isElement( blip ) then destroyElement( blip ) blip = nil end   
        outputChatBox( " [Inglés] Granjero dice: Hey. este mes de "..nombreMeses[time.month].." necesitamos recoger lo que ha salido. Ve a cosechar.", 255, 255, 255 )
        startCosechar()
    else
        outputChatBox( " [Inglés] Granjero dice: Este mes necesitamos cultivar. Pilla un tractor y ponte a arar el terreno.", 255, 255, 255 )
    end
end

addEvent( "granjero:introduce", true )
addEventHandler( "granjero:introduce", getRootElement(),
    function()
        outputChatBox( "Has elegido trabajar de granjero. Se te ha marcado en el mapa la posición del trabajo. Ve hasta ahí y sigue las instrucciones.", 255, 150, 0 )
        blip = createBlip(2340.8310546875, -815.0166015625, 127.4416885376, 0, 2, 0, 255, 0, 255, 0, 9999 )
        col = createColSphere( 2340.8310546875, -815.0166015625, 127.4416885376, 10 )
        addEventHandler( "onClientColShapeHit", col, function(element)
                if element == getLocalPlayer() then
                    outputChatBox( "Este es el trabajo de granjero. Acércate al almacén y habla con el granjero para saber lo que tienes que hacer.", 0, 255, 0 )
                    if isElement( col ) then destroyElement( col ) col = nil end
                    if isElement( blip ) then destroyElement( blip ) blip = nil end
                    triggerServerEvent("aplicarJobGranjero", localPlayer, localPlayer) 
                    -- Esto lo ponemos solo la primera vez para que sepan donde ir
                    col = createColSphere(2339.3349609375, -816.8779296875, 127.31285858154,5)
                    blip = createBlip( 2339.3349609375, -816.8779296875, 127.31285858154, 0, 2, 0, 255, 0,255, 0, 9999 )
                    addEventHandler( "onClientColShapeHit", col, function(element)
						outputChatBox( "(( La próxima vez que quieras trabajar dale click al NPC y que te asigne una tarea. ))", 255, 255, 0 ) 
						drawMiniAyuda()
                        local time = getRealTime()
                        if getActividadJob( time.month ) == 1 then
                            if isElement( col ) then destroyElement( col ) col = nil end
                            if isElement( blip ) then destroyElement( blip ) blip = nil end   
                            outputChatBox( " [Inglés] Granjero dice: Hey. este mes de "..nombreMeses[time.month].." necesitamos recoger lo que ha salido. Ve a cosechar.", 255, 255, 255 )
                            startCosechar()
                        else
                            if isElement( col ) then destroyElement( col ) col = nil end
                            if isElement( blip ) then destroyElement( blip ) blip = nil end   
                            outputChatBox( " [Inglés] Granjero dice: Hey. este mes de "..nombreMeses[time.month].." necesitamos recoger lo que ha salido. Ve a cosechar.", 255, 255, 255 )
                            startArar()                   
                        end
                    end
                    )
                end
            end 
        )
    end
)

function getIDPlantaPisada(m)
    for i=1, #planta do 
        if planta[i].marker == m then 
            return i
        end
    end
    return false
end

function getIDMarkerPisado(m)
    for i=1, #planta do 
        if planta[i].marker == m then 
            return i
        end
    end
    return false
end

addCommandHandler( "cc",
	function()
		for i=1, 50 do 
			outputChatBox( " " )
		end
	end
)

addEventHandler( "onClientMarkerHit", getRootElement(),
    function(p)
        if p == getLocalPlayer() then
			if haciendo[p] == 1 then
				if planta and #planta > 0 then
					local idplanta = getIDPlantaPisada(source)
					if idplanta then 
						setPedAnimation( getLocalPlayer(), "bd_fire", "wash_up", 0, true, true, false, true )
						
						ganancias = ganancias + math.random(10,20)
						if isElement( planta[idplanta].obj ) then destroyElement( planta[idplanta].obj ) planta[idplanta].obj = nil end
						if isElement( planta[idplanta].marker ) then destroyElement( planta[idplanta].marker ) planta[idplanta].marker = nil end
						if isElement( planta[idplanta].blip ) then destroyElement( planta[idplanta].blip ) planta[idplanta].blip = nil end
						table.remove(planta,idplanta)
						if #planta == 0 then 
							outputChatBox( "Has podido recoger "..ganancias.." gramos de trigo. Has recibido tu recompensa.", 255, 150, 0 )
							triggerServerEvent("dar:recompensagranjero",localPlayer,localPlayer,tonumber(ganancias))
							ganancias = 0
							haciendo[p] = nil

						end
					else    
						outputChatBox( "(( Hubo un error con la planta. ))", 255, 0, 0 )
					end
				end
			elseif haciendo[p] == 2 then
				local veh = getPedOccupiedVehicle(p)
				if veh and getElementModel(veh) == 531 then				
					local idmarker = getIDMarkerPisado(source)
					if idmarker then
						ganancias = ganancias + math.random(10,20)
						if isElement( planta[idmarker].marker ) then destroyElement( planta[idmarker].marker ) planta[idmarker].marker = nil end
						if isElement( planta[idmarker].blip ) then destroyElement( planta[idmarker].blip ) planta[idmarker].blip = nil end			
						table.remove(planta,idmarker)
						if #planta == 0 then 
							outputChatBox( "Has podido arar "..ganancias.."m2 de terreno. Ya queda menos de preparación para plantar. Deja el tractor en su sitio.", 255, 150, 0 )
							triggerServerEvent("dar:recompensagranjero",localPlayer,localPlayer,tonumber(ganancias))
							ganancias = 0
							haciendo[p] = nil
						end
					else
						outputChatBox( "(( Hubo un error con el marker. ))", 255, 0, 0 )
					end
				else
					outputChatBox( "(( Debes estar subido al tractor para arar este terreno. ))", 255, 150, 0 )
				end
			end
        end
    end
)

function startCosechar()
	haciendo[getLocalPlayer()] = 1
    for i=1, #ruta do 
        planta[i] = { 
            obj = createObject( 862, ruta[i][1], ruta[i][2], ruta[i][3]-0.9 ), 
            marker = createMarker( ruta[i][1], ruta[i][2], ruta[i][3]-0.9, "cylinder", 1, 255,255,255,20 ),
			blip = createBlip( ruta[i][1], ruta[i][2], ruta[i][3], 0, 1, 255, 255, 255, 255, 0, 99999 )
        }
    end
end

function startArar()
	haciendo[getLocalPlayer()] = 2
    for i=1, #ruta do 
        planta[i] = { 
            marker = createMarker( ruta[i][1], ruta[i][2], ruta[i][3]-0.9, "cylinder", 1.2, 0,150,0,20 ),
			blip = createBlip( ruta[i][1], ruta[i][2], ruta[i][3], 0, 1, 255, 255, 255, 255, 0, 99999 )
        }
    end
end

addEvent( "granjero:obtenerTarea", true )
addEventHandler( "granjero:obtenerTarea", getRootElement(),
    function()
		if haciendo[ getLocalPlayer() ] then
			outputChatBox( " [Inglés] Granjero dice: Coño, pero si ya tienes una tarea pendiente muchacho. Si la acabas podrás hacer más.", 255, 255, 255 )
		else
			local time = getRealTime()
			if getActividadJob( time.month ) == 1 then
				drawMiniAyuda()
				if isElement( col ) then destroyElement( col ) col = nil end
				if isElement( blip ) then destroyElement( blip ) blip = nil end   
				outputChatBox( " [Inglés] Granjero dice: Hey. este mes de "..nombreMeses[time.month].." necesitamos recoger lo que ha salido. Ve a cosechar.", 255, 255, 255 )
				startCosechar()
			else
				if isElement( col ) then destroyElement( col ) col = nil end
				if isElement( blip ) then destroyElement( blip ) blip = nil end   
				outputChatBox( " [Inglés] Granjero dice: Este mes de "..nombreMeses[time.month].." necesitamos arar el terreno. Pilla un tractor y ponte a ello.", 255, 255, 255 )
				startArar()			
			end	
		end
    end
)

bindKey("m","down",function() showCursor( not isCursorShowing() ) end )
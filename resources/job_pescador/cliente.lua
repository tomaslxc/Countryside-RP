local sx, sy = guiGetScreenSize()
local x, y = ( sx /1024 ), ( sy/768 ) -- Para multiplicar y tal

local blip,col
local ganancias = 0
local pescados = {}
local haciendo = {} -- 1 = cosechar, 2 = arar es para no crear eventos innecesarios

r_desc = dxCreateFont( ":jobs/Roboto-Italic.ttf", 10 )

setWorldSpecialPropertyEnabled( "randomfoliage", false ) -- Quitar las plantas que daban por culo

local startx = -100
local max_x = 120
local ntick, ntickshow = 0,nil


addEvent( "pescador:introduce", true )
addEventHandler( "pescador:introduce", getRootElement(),
    function()
        outputChatBox( "Has elegido ser pescador. Se te ha marcado en el mapa la posición del trabajo. Ve hasta ahí y sigue las instrucciones.", 255, 150, 0 )
        blip = createBlip( 2954.8232421875, -1506.45703125, 1.6535439491272, 0, 2, 0, 255, 0, 255, 0, 9999 )
        col = createColSphere( 2954.8232421875, -1506.45703125, 1.6535439491272, 10 )
        addEventHandler( "onClientColShapeHit", col, function(element)
                if element == getLocalPlayer() then
                    outputChatBox( "Este es el trabajo de pescador. Acércate al muelle y habla con el encargado para empezar tu trabajo.", 0, 255, 0 )
                    if isElement( col ) then destroyElement( col ) col = nil end
                    if isElement( blip ) then destroyElement( blip ) blip = nil end
                    triggerServerEvent("aplicarJobPescador", localPlayer, localPlayer)  
                    -- Esto lo ponemos solo la primera vez para que sepan donde ir
                    col = createColSphere(2949.1088867188, -1507.3610839844, 1.8250000476837,5)
                    blip = createBlip( 2949.1088867188, -1507.3610839844, 1.8250000476837, 0, 2, 0, 255, 0,255, 0, 9999 )
                    addEventHandler( "onClientColShapeHit", col, function(element)
						outputChatBox( "(( La próxima vez que quieras trabajar dale click al NPC y que te asigne una tarea. ))", 255, 255, 0 ) 
                            if isElement( col ) then destroyElement( col ) col = nil end
                            if isElement( blip ) then destroyElement( blip ) blip = nil end   
                            outputChatBox( " [Inglés] Pescador dice: Bienvenido al muelle, sube a un barco y empieza a pescar peces.", 255, 255, 255 )
                            startPescador()                  
                    end
                    )
                end
            end 
        )
    end
)

function getIDMarkerPisado(m)
    for i=1, #pescados do 
        if pescados[i].marker == m then 
            return i
        end
    end
    return false
end

addEventHandler( "onClientMarkerHit", getRootElement(),
    function(p)
        if p == getLocalPlayer() then
			if haciendo[p] == "pescar" then
				local veh = getPedOccupiedVehicle(p)
				if veh and getElementModel(veh) == 453 then	--barco de pescador			
					local idmarker = getIDMarkerPisado(source)
					if idmarker then
						if isElement( pescados[idmarker].marker ) then destroyElement( pescados[idmarker].marker ) pescados[idmarker].marker = nil end
						if isElement( pescados[idmarker].blip ) then destroyElement( pescados[idmarker].blip ) pescados[idmarker].blip = nil end			
						table.remove(pescados,idmarker)
						if #pescados == 0 then
							ganancias = math.random(10,20)
							outputChatBox( "Has pescado ".. ganancias .." peces. Has recibido tu recompensa.", 255, 150, 0 )
							haciendo[p] = nil
                            triggerServerEvent("dar:recompensa",localPlayer,localPlayer,tonumber(ganancias))
						end
					else
						outputChatBox( "(( Hubo un error con el marker. ))", 255, 0, 0 )
					end
				else
					outputChatBox( "(( Debes estar subido al barco para poder pescar. ))", 255, 150, 0 )
				end
			end
        end
    end
)

function startPescador()
	haciendo[getLocalPlayer()] = "pescar"
    for i=1, #ruta do 
        pescados[i] = { 
            marker = createMarker( ruta[i][1], ruta[i][2], ruta[i][3]-0.9, "cylinder", 10, 0,150,0,20 ),
			blip = createBlip( ruta[i][1], ruta[i][2], ruta[i][3], 0, 1, 255, 255, 255, 255, 0, 99999 )
        }
    end
end

addEvent( "pescador:obtenerTarea", true )
addEventHandler( "pescador:obtenerTarea", getRootElement(),
    function()
		if haciendo[ getLocalPlayer() ] then
			outputChatBox( " [Inglés] Pescador dice: Ya tienes una tarea pendiente. Si la acabas podrás hacer más.", 255, 255, 255 )
		else
				if isElement( col ) then destroyElement( col ) col = nil end
				if isElement( blip ) then destroyElement( blip ) blip = nil end   
				outputChatBox( " [Inglés] Pescador dice: Empieza a pescar. Sube a tu barco y hazte con muchos peces.", 255, 255, 255 )
				startPescador()			
		end
    end
)

bindKey("m","down",function() showCursor( not isCursorShowing() ) end )
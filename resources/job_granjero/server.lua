local tractores = {
    -- 531 tractor
    -- {-104.4765625, 81.048828125, 3.0831091403961, 0.3790283203125, 0, 75.684814453125},
    -- {-103.7177734375, 83.65234375, 3.0814416408539, 0.384521484375, 0, 73.7841796875},
    -- {-102.9541015625, 86.3955078125, 3.0816938877106, 0.3900146484375, 0, 73.141479492188},
    -- {-102.099609375, 89.0849609375, 3.0793287754059, 0.4010009765625, 0, 72.24609375},
    -- {-101.2568359375, 92.0693359375, 3.0823903083801, 0.384521484375, 0, 70.581665039063},
    -- {-100.125, 94.9306640625, 3.0808744430542, 0.4669189453125, 0.1318359375, 71.3232421875},

}

-- skin, x, y, z, rot, int, dim
local datosBot = { 162, 2339.3349609375, -816.8779296875, 127.31285858154, 290, 0, 0 }
local pedTrabajo
local tractor = {}

function crearGranjeroBot()
	if isElement( pedTrabajo ) then destroyElement( pedTrabajo ) end
    local skin, x, y, z, rot, int, dim = unpack( datosBot )
    pedTrabajo = createPed( skin, x, y, z, rot )
	setElementFrozen( pedTrabajo, true )
    setElementInterior( pedTrabajo, int )
    setElementDimension( pedTrabajo, dim )
    setTimer( function()
        setPedAnimation( pedTrabajo, "shop", "smoke_ryd" )
    end, 500, 1 )
end

addEventHandler( "onResourceStart", resourceRoot,
    function()
        for i=1, #tractores do 
            tractor[i] = createVehicle( 531, unpack( tractores[i] ) )
            setVehicleRespawnPosition( tractor[i], unpack( tractores[i] ) )
        end
		crearGranjeroBot()
		addEventHandler( "onPedWasted", getRootElement(), crearGranjeroBot ) -- Esto para que cuando muera reaparezca el bot
    end
)
function recompensaGranjero( player, ganancias )
    if getElementData(player,"farmeado") >= 6000 then
        outputChatBox("Has alcanzado el máximo de 6000$ farmeados al día.",player,200,0,0)
    else
    exports.personajes:addCharMoney(player, tonumber(ganancias))
    setElementData(player,"farmeado", getElementData(player,"farmeado")+tonumber(ganancias))
    end
end
addEvent("dar:recompensagranjero", true)
addEventHandler("dar:recompensagranjero", root, recompensaGranjero)
function elementClicked( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" then
        if isElement( pedTrabajo ) then
			if source == pedTrabajo then
				local x, y, z = getElementPosition( thePlayer )
				if getDistanceBetweenPoints3D( x, y, z, datosBot[2], datosBot[3], datosBot[4] ) < 3 and getElementDimension(thePlayer) == datosBot[7] and getElementInterior(thePlayer) == datosBot[6] then
					if getElementData( thePlayer, "trabajo" ) == "Granjero" then
						triggerClientEvent( thePlayer, "granjero:obtenerTarea", thePlayer )
					else
						outputChatBox( " [Inglés] Granjero dice: Lo siento, no te he visto antes por aquí. Puedes trabajar con permiso del ayuntamiento. Acércate y pregunta.", thePlayer, 255, 255, 255 )
					end
				end 
			end
        end
    end
end
addEventHandler( "onElementClicked", root, elementClicked )

addCommandHandler("pos",
    function(p,cmd)
        local x, y, z = getElementPosition(p)
        local rotx, roty, rotz = getElementRotation(p)
        outputChatBox( "{"..x..", "..y..", "..z..", "..rotx..", "..roty..", "..rotz.."},", p, 255, 255, 255 )
    end
)

addCommandHandler("posv",
    function(p,cmd)
        local veh = getPedOccupiedVehicle(p)
        if veh then
            local x, y, z = getElementPosition(veh)
            local rotx, roty, rotz = getElementRotation(veh)
            outputChatBox( "{"..x..", "..y..", "..z..", "..rotx..", "..roty..", "..rotz.."},", p, 255, 255, 255 )
        end
    end
)

function darJobGranjero( player )
    setElementData(player, "trabajo", "Granjero")
end
addEvent("aplicarJobGranjero", true)
addEventHandler("aplicarJobGranjero", root, darJobGranjero)
local barcos = {
    -- 531 barco
    -- {-103.7177734375, 83.65234375, 3.0814416408539, 0.384521484375, 0, 73.7841796875},
    -- {-102.9541015625, 86.3955078125, 3.0816938877106, 0.3900146484375, 0, 73.141479492188},
    -- {-102.099609375, 89.0849609375, 3.0793287754059, 0.4010009765625, 0, 72.24609375},
    -- {-101.2568359375, 92.0693359375, 3.0823903083801, 0.384521484375, 0, 70.581665039063},
    -- {-100.125, 94.9306640625, 3.0808744430542, 0.4669189453125, 0.1318359375, 71.3232421875},
-- ID vehiculos de trabajo pescador:


}

-- skin, x, y, z, rot, int, dim
local datosBot = { 44, 
2949.1088867188, -1507.3610839844, 1.8250000476837, 250,0, 0 }
local pedTrabajo
local barco = {}

function crearPescadorBot()
	if isElement( pedTrabajo ) then destroyElement( pedTrabajo ) end
    local skin, x, y, z, rot, int, dim = unpack( datosBot )
    pedTrabajo = createPed( skin, x, y, z, rot )
	setElementFrozen( pedTrabajo, true )
    setElementInterior( pedTrabajo, int )
    setElementDimension( pedTrabajo, dim )
end

addEventHandler( "onResourceStart", resourceRoot,
    function()
        for i=1, #barcos do 
            barco[i] = createVehicle( 453, unpack( barcos[i] ) )
            setVehicleRespawnPosition( barco[i], unpack( barcos[i] ) )
        end
		crearPescadorBot()
		addEventHandler( "onPedWasted", getRootElement(), crearPescadorBot ) -- Esto para que cuando muera reaparezca el bot
    end
)

function elementClicked( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" then
        if isElement( pedTrabajo ) then
			if source == pedTrabajo then
				local x, y, z = getElementPosition( thePlayer )
				if getDistanceBetweenPoints3D( x, y, z, datosBot[2], datosBot[3], datosBot[4] ) < 3 and getElementDimension(thePlayer) == datosBot[7] and getElementInterior(thePlayer) == datosBot[6] then
					if getElementData( thePlayer, "trabajo" ) == "Pescador" then
						triggerClientEvent( thePlayer, "pescador:obtenerTarea", thePlayer )
					else
						outputChatBox( " [Inglés] Pescador dice: Lo siento, no te he visto antes por aquí. Puedes trabajar con permiso del ayuntamiento. Acércate y pregunta.", thePlayer, 255, 255, 255 )
					end
				end 
			end
        end
    end
end
addEventHandler( "onElementClicked", root, elementClicked )

function recompensa( player, ganancias )
    if getElementData(player,"farmeado") >= 6000 then
        outputChatBox("Has alcanzado el máximo de 6000$ farmeados al día.",player,200,0,0)
    else
    exports.personajes:addCharMoney(player, tonumber(ganancias)*4)
    setElementData(player,"farmeado", getElementData(player,"farmeado")+tonumber(ganancias)*4)
    end
end
addEvent("dar:recompensa", true)
addEventHandler("dar:recompensa", root, recompensa)

local vehsID = {
--pescador
 {85, 2964.5380859375, -1517.451171875, -0.3534109890461, 359.62646484375, 359.89013671875, 259.29931640625,"Pescador"},
 {86, 2966.9248046875, -1507.876953125, -0.35349634289742, 359.59350585938, 359.86267089844, 260.86486816406,"Pescador"},
 {87, 2968.2861328125, -1498.09765625, -0.35267323255539, 359.6044921875, 359.84069824219, 262.86437988281,"Pescador"},
 {88, 2970.6884765625, -1487.5341796875, -0.35428214073181, 359.49462890625, 359.86267089844, 259.22790527344,"Pescador"},
 --granjero
 {41, 2339.130859375, -811.548828125, 127.62407684326, 2.2027587890625, 4.5318603515625, 270.50537109375,"Granjero"},
 {42, 2339.25390625, -807.6484375, 127.9312210083, 1.8621826171875, 4.6527099609375, 266.30859375,"Granjero"},
 {43, 2338.892578125, -804.21484375, 128.18241882324, 2.054443359375, 4.59228515625, 268.505859375,"Granjero"},
 {44, 2338.861328125, -800.505859375, 128.46934509277, 2.1533203125, 4.5538330078125, 269.96154785156,"Granjero"},
 {45,2338.8115234375, -796.5009765625, 128.77633666992, 2.17529296875, 4.5428466796875, 270.17028808594,"Granjero"},
}
function isJobVeh( id )
    for i,v in pairs(vehsID) do
        if  vehsID[i][1] == tonumber(id) then
            return i
        end
    end
    return false
end
function abt( player )
    for i,v in ipairs(getElementsByType("vehicle")) do
        if getElementData(v, "id") and isJobVeh(getElementData(v, "id")) then
            if isVehicleLocked(v) then
                setVehicleLocked(v, false)
                setVehicleEngineState ( v, true )
                setElementData(v,"fuel",100)
            end
        end
    end
    outputChatBox("Has abierto los vehículos de job.", player, 0, 200,0)
end
addCommandHandler("abrirvehiculosjob",abt)

function addHelmetOnEnter ( thePlayer, seat, jacked )
    if getElementData(source, "id") and isJobVeh(getElementData(source, "id")) then
        local index = isJobVeh(getElementData(source, "id"))
        if vehsID[index][8] == getElementData(thePlayer, "trabajo") then
        setVehicleEngineState ( source, true )
        else
            cancelEvent()
            outputChatBox("No tienes este trabajo.",thePlayer,200,0,0)
        end
    end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), addHelmetOnEnter )

function alsubir2 ( thePlayer, seat, jacked )
    if getElementData(source, "id") and isJobVeh(getElementData(source, "id")) then
        setVehicleEngineState ( source, true )
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), alsubir2 )


function isVehicleOccupied(vehicle)
    assert(isElement(vehicle) and getElementType(vehicle) == "vehicle", "Bad argument @ isVehicleOccupied [expected vehicle, got " .. tostring(vehicle) .. "]")
    local _, occupant = next(getVehicleOccupants(vehicle))
    return occupant and true, occupant
end
function respawnJobsV()
    for i,veh in ipairs(getElementsByType("vehicle")) do
        if getElementData(veh, "id") and isJobVeh(getElementData(veh, "id")) then
            local index = isJobVeh(getElementData(veh, "id"))
            if not isVehicleOccupied(veh) then
                setElementPosition(veh, vehsID[index][2],vehsID[index][3],vehsID[index][4])
                setElementRotation(veh, vehsID[index][5],vehsID[index][6],vehsID[index][7])
                fixVehicle(veh)
                setVehicleDoorState ( veh, 0, 0 )
                setVehicleDoorState ( veh, 1, 0 )
                setVehicleDoorState ( veh, 2, 0 )
                setVehicleDoorState ( veh, 3, 0 )
                setVehicleDoorState ( veh, 4, 0 )
                setVehicleDoorState ( veh, 5, 0 )
                setVehiclePanelState ( veh, 0, 0 )
                setVehiclePanelState ( veh, 1, 0 )
                setVehiclePanelState ( veh, 2, 0 )
                setVehiclePanelState ( veh, 3, 0 )
                setVehiclePanelState ( veh, 4, 0 )
                setVehiclePanelState ( veh, 5, 0 )
                setVehiclePanelState ( veh, 6, 0 )
                setElementData(veh, "fuel", 100)
                setVehicleEngineState ( veh, true )
            end
        end
    end
end
setTimer ( respawnJobsV, 60000, 0 )

function darJobPescador( player )
    setElementData(player, "trabajo", "Pescador")
end
addEvent("aplicarJobPescador", true)
addEventHandler("aplicarJobPescador", root, darJobPescador)
local mecashapes = {
	[4] = {

2058.876953125, -1868.28125, 13.546875}
}

addCommandHandler("mecanico",
	function ( source,cmd )
	local factions = exports.facciones:getPlayerFaction(source)
	if factions[1] == 4 or factions[2] == 4 then
		local x,y,z = getElementPosition(source)
		if getDistanceBetweenPoints3D(x,y,z,mecashapes[4][1],mecashapes[4][2],mecashapes[4][3]) < 10 then
			if isPedInVehicle(source) then
			triggerClientEvent(source,"open",source)
	        else
	        outputChatBox("Usted debe estar en un vehiculo",source,255,0,0)
	    	end
	    else
	    	outputChatBox("Debes estar en el taller para poder hacer esto.", source, 200,0,0)
	    end
    end
	end)

addCommandHandler("reparar",
function(source,cmd)
local factions = exports.facciones:getPlayerFaction(source)
if factions[1] == 4 or factions[2] == 4 then
	local x,y,z = getElementPosition(source)
	if getDistanceBetweenPoints3D(x,y,z,mecashapes[4][1],mecashapes[4][2],mecashapes[4][3]) < 10 then
		if isPedInVehicle(source) then
		local vehiculo = getPedOccupiedVehicle(source)
		setElementHealth(vehiculo,1000)
		else
			outputChatBox("Debes estar en un vehículo.", source, 200,0,0)
		end
 	else
	    outputChatBox("Debes estar en el taller para poder hacer esto.", source, 200,0,0)
	end
end
end)

addEvent("cambiarSuspension",true)
addEventHandler("cambiarSuspension",getRootElement(), function(cantidad)
	outputChatBox("La cantidad de suspension puesta seria:"..cantidad,source,255,0,0)

local resultado = cantidad / 15 
local vehiculo = getPedOccupiedVehicle(source)
 resetearHandling(vehiculo, 'suspensionForceLevel')
 resetearHandling(vehiculo, 'suspensionDamping')

 setVehicleHandling(vehiculo, "suspensionForceLevel",resultado)
 setVehicleHandling(vehiculo, "suspensionDamping", resultado )
end)

addEvent("restaurarSuspension",true)
addEventHandler("restaurarSuspension",getRootElement(),
function()
outputChatBox("La pieza ha sido restaurada a su origininalidad",source,0,255,0)
local vehiculo = getPedOccupiedVehicle(source)
 resetearHandling(vehiculo, 'suspensionForceLevel')
 resetearHandling(vehiculo, 'suspensionDamping')
end)

addEvent("cambiarFrenos",true)
addEventHandler("cambiarFrenos",getRootElement(),
function(cantidad)
outputChatBox("La cantidad de transmision puesta seria:"..tonumber(cantidad),source,255,0,0)
local vehiculo = getPedOccupiedVehicle(source)

 resetearHandling(vehiculo, 'brakeDeceleration')

setVehicleHandling(vehiculo, "brakeDeceleration", getOriginalHandling( getElementModel(vehiculo) )['brakeDeceleration']+tonumber(cantidad))

end)





addEvent("faseoTransmision",true)
addEventHandler("faseoTransmision",getRootElement(),
function  ( cantidad )
outputChatBox("La cantidad de transmision puesta seria:"..tonumber(cantidad),source,255,0,0)
local vehiculo = getPedOccupiedVehicle(source)
resetearHandling(vehiculo, 'engineAcceleration')
setVehicleHandling(vehiculo,"engineAcceleration",tonumber(cantidad))	
end)

addEvent("faseoTurbo",true)
addEventHandler("faseoTurbo",getRootElement(),
function  ( cantidad )
local vehiculo = getPedOccupiedVehicle(source)
resetearHandling(vehiculo, 'engineInertia')
setVehicleHandling(vehiculo,"engineInertia",tonumber(cantidad))
end)


addEvent("quitarTurbo",true)
addEventHandler("quitarTurbo",getRootElement(),
function  (  )
local vehiculo = getPedOccupiedVehicle(source)
resetearHandling(vehiculo, 'engineInertia')
outputChatBox("El turbo se ha sido desinstalado",source,0,255,0)
end)

addEvent("restaurarFrenos",true)
addEventHandler("restaurarFrenos",getRootElement(),
function  (  )
outputChatBox("La pieza ha sido restaurada a su origininalidad",source,0,255,0)
local vehiculo = getPedOccupiedVehicle(source)
resetearHandling(vehiculo, 'brakeDeceleration')
end)

addEvent("restaurarTransmision",true)
addEventHandler("restaurarTransmision",getRootElement(),
function  (  )
outputChatBox("La pieza ha sido restaurada a su origininalidad",source,0,255,0)
local vehiculo = getPedOccupiedVehicle(source)
resetearHandling(vehiculo, 'engineAcceleration')
end)

function Color ( player, r, g, b, modo )
local vehicle = getPedOccupiedVehicle( player )
	if vehicle and r and g and b then
			r1, g1, b1, r2, g2, b2 = getVehicleColor(vehicle, true)
			if modo == 1 then
				setVehicleColor (vehicle, r, g, b, r2, g2, b2)
			elseif modo == 2 then
				setVehicleHeadLightColor ( vehicle, r, g, b )
			elseif modo == 3 then
				setVehicleColor (vehicle, r1, g1, b1, r, g, b)
		end
	end
end
addEvent( "pintar", true )
addEventHandler( "pintar", getRootElement(), Color)

function Redas ( thePlayer, modo)
    local vehicle = getPedOccupiedVehicle( thePlayer )
    if vehicle then
			if modo == 0 then
				removeVehicleUpgrade ( vehicle, 1073 )
				removeVehicleUpgrade ( vehicle, 1074 )
				removeVehicleUpgrade ( vehicle, 1075 )
				removeVehicleUpgrade ( vehicle, 1076 )
				removeVehicleUpgrade ( vehicle, 1077 )
				removeVehicleUpgrade ( vehicle, 1078 )
				removeVehicleUpgrade ( vehicle, 1079 )
				removeVehicleUpgrade ( vehicle, 1080 )
			else
				addVehicleUpgrade ( vehicle, modo )
				outputChatBox("Las ruedas se han cambiado",source,0,255,0)
			end
		end
end
addEvent( "larueda", true )
addEventHandler( "larueda", getRootElement(), Redas)

function pEGAS ( player, modo)
    local vehicle = getPedOccupiedVehicle( player )
    if vehicle then
		if modo == 1 then
			setVehiclePaintjob ( vehicle, 0 )
		elseif modo == 2 then
			setVehiclePaintjob ( vehicle, 3 )
		elseif modo == 3 then
			setVehiclePaintjob ( vehicle, 2 )
		elseif modo == 4 then
			setVehiclePaintjob ( vehicle, 1 )
		end
	end
end
addEvent( "onpegas", true )
addEventHandler( "onpegas", getRootElement(), pEGAS)

function qital ( ID )
    theVehicle = getPlayerOccupiedVehicle ( source )
    if ( theVehicle ) then
	 outputChatBox("Desinstalaste una pieza ",source,255,0,0)
 removeVehicleUpgrade ( theVehicle, ID )
        end
    end
addEvent( "qitala", true )
addEventHandler( "qitala", getRootElement(), qital)

function ponerAre(ID)
 local theVehicle = getPlayerOccupiedVehicle ( source )
    if ( theVehicle ) then
         addVehicleUpgrade ( theVehicle, ID )
    outputChatBox("Instalaste una pieza ",source,255,0,0)
    end
end
addEvent( "ponerMejoras", true )
addEventHandler( "ponerMejoras", getRootElement(), ponerAre)



function getVehicleOriginalProperty( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then -- Make sure there's a valid vehicle and a property string
        local modelID = getElementModel ( element )
        local handlingTable = getOriginalHandling ( modelID ) -- Get the handling as table and save as handlingTable
        local value = handlingTable[property] -- Get the value from the table
        
        if value then -- If there's a value (valid property)
            return value -- Return it
        end
    end
    
    return false -- Not an element, not a vehicle or no valid property string. Return failure
end

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function resetearHandling( veh, tipo )
	if isElement(veh) then
		local handlingOriginal = getOriginalHandling( getElementModel(veh) )[ tipo ]
		if handlingOriginal then
			setVehicleHandling( veh, tipo, handlingOriginal )
			return true
		end
	end
	return false
end
local faseos = {

	[1] = {1.5,2.5,3},-- TRANSMISION engineAcceleration (sumamos)
	[2] = {5,10,15},-- FRENOS brakeDeceleration (sumamos)	
	[3] = {1,3,6},	-- TURBO engineInertia (se resta)

}
local nombreHandlings = { "engineAcceleration", "brakeDeceleration", "engineInertia" }
function aplicarFaseo( player, cmd, tipo, nivel )
local factions = exports.facciones:getPlayerFaction(player)
if factions[1] == 4 or factions[2] == 4 then
		local x,y,z = getElementPosition(player)
			if getDistanceBetweenPoints3D(x,y,z,mecashapes[4][1],mecashapes[4][2],mecashapes[4][3]) < 10 then
				if isPedInVehicle(player) then
					local veh = getPedOccupiedVehicle(player)
					if tonumber(tipo) and tonumber(nivel) then
						 if faseos[tonumber(tipo)][tonumber(nivel)] ~= nil or nivel == 0 then
							if tonumber(tipo) == 3 then
								local handlingOriginal = getOriginalHandling( getElementModel(veh) )[ nombreHandlings[tonumber(tipo)] ]
								if handlingOriginal then
									if tonumber(nivel) == 0 then
										setVehicleHandling( veh, nombreHandlings[tonumber(tipo)], handlingOriginal )
										setElementData( veh, tonumber(tipo), tonumber(nivel) )
										outputChatBox("Has faseado el turbo a su valor original", player, 200,100,0)
									else
										setVehicleHandling( veh, nombreHandlings[tonumber(tipo)], handlingOriginal - faseos[tonumber(tipo)][tonumber(nivel)] )
										outputChatBox("Has faseado el turbo en el nivel de potencia "..nivel, player, 200,100,0)
										setElementData( veh, tonumber(tipo), tonumber(nivel) )
									end
								end
							else
								local handlingOriginal = getOriginalHandling( getElementModel(veh) )[ nombreHandlings[tonumber(tipo)] ]
								if handlingOriginal then
									if tonumber(nivel) == 0 then
										setVehicleHandling( veh, nombreHandlings[tonumber(tipo)], handlingOriginal)
										setElementData( veh, tonumber(tipo), tonumber(nivel) )
										if tonumber(tipo) == 2 then
											outputChatBox("Has faseado los frenos a su valor original", player, 200,100,0)
										else
											outputChatBox("Has faseado la transmision a su valor original", player, 200,100,0)
										end
									else
										setVehicleHandling( veh, nombreHandlings[tonumber(tipo)], handlingOriginal + faseos[tonumber(tipo)][tonumber(nivel)] )
										setElementData( veh, tonumber(tipo), tonumber(nivel) )
										if tonumber(tipo) == 2 then
											outputChatBox("Has faseado los frenos a su nivel de potencia "..nivel, player, 200,100,0)
										else
											outputChatBox("Has faseado la transmision a su nivel de potencia "..nivel, player, 200,100,0)
										end
									end
								end				
								if tonumber(tipo) == 1 then
									local handlingOriginal = getOriginalHandling( getElementModel(veh) )[ "maxVelocity" ]
									if handlingOriginal then
										if tonumber(nivel) == 0 then
											setVehicleHandling( veh, "maxVelocity", handlingOriginal )
											setElementData( veh, tonumber(tipo),tonumber(nivel) )
										else
											setVehicleHandling( veh, "maxVelocity", handlingOriginal + ( tonumber(nivel) * 10 ) )
											setElementData( veh, tonumber(tipo), nivel )
										end
									end					
								end
							end
						 end
					else
						outputChatBox("Syntax: /fasear [tipo] [nivel]",player, 255,255,255)
						outputChatBox("Tipos:",player,255,255,255)
						outputChatBox("1 - Transmision",player,255,255,255)
						outputChatBox("2 - Frenos",player,255,255,255)
						outputChatBox("3 - Turbo",player,255,255,255)
						outputChatBox("Niveles de faseo (1, 2 o 3) ( nivel 0 sería default )",player,255,255,255)
					end
				end
		end
	end
end
addCommandHandler("fasear", aplicarFaseo)

local tact = false

addCommandHandler( "ctest",
	function(p)
		if tact == false then
			outputChatBox( "Modo test activado", p, 0, 255, 0 )
			tact = true
			bindKey( p, "w", "down", function()
				if tact == true then
					local veh = getPedOccupiedVehicle(p)
					outputChatBox( "Iniciando test...", p, 255, 150, 0 )
					setTimer( function(v)
						outputChatBox( getElementSpeed(v,1) )
					end, 3000, 1, veh)
				end
			end)
		else
			outputChatBox( "Modo test desactivado", p, 255, 0, 0 )
			tact = false
		end
	end
)

addCommandHandler( "phand",
	function( p, cmd, id )
		local veh = getPedOccupiedVehicle( p )
		if veh then
			local model = getElementModel( veh )
			local mhand = getModelHandling( model )["engineAcceleration"]
			if setVehicleHandling( veh, "engineAcceleration", mhand + transmisiones[tonumber(id)] ) then
				outputChatBox( "Aplicado el handling de transmision al vehiculo. Nivel: "..id, p, 0, 255, 0 ) 
			else
				outputChatBox( "No se ha podido aplicar el handling al vehiculo.", p, 255, 0, 0 )
			end
		end	
	end	
)

addCommandHandler( "rhand",
	function(p)
		local veh = getPedOccupiedVehicle( p )
		if veh then
			if resetearHandling( veh, "engineAcceleration" ) then
				outputChatBox( "Handling reseteado", p, 0, 255, 0 )
			else
				outputChatBox( "Fallo en resetear el handling.", p, 255, 0, 0 )
			end
		end
	end
)
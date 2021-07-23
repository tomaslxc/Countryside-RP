local policias = { [598] = true, [599] = true, [490] = true, [596] = true, [523] = true, }
local vradar = {}

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

addEventHandler( "onColShapeHit", getRootElement( ),
	function( p )
		if p and isElement(p) and getElementType(p) == "vehicle" then
			local vehs = getElementsByType('vehicle')
			for i=1, #vehs do 
				local veh = vehs[i]
				if vradar and vradar[veh] then
					if source == vradar[veh].col then
						local policia = getVehicleOccupant(veh,0)
						if policia then
							local speed = math.floor( getElementSpeed(p,"km/h") )
							if speed > vradar[veh].vel then
								outputChatBox( "Detectado vehiculo "..getVehicleNameFromModel( getElementModel(p) ).." a una velocidad de "..speed.."km/h", policia, 255, 150, 0 )
								break
							end
						end
					end
				end
			end
		end
	end	
)

addCommandHandler( "vehradar",
	function(p,cmd,limite)
		local faccs = exports.facciones:getPlayerFaction( p )
		if faccs[2] == 2 or faccs[2] == 2 then
			local limite = tonumber(limite)
			local veh = getPedOccupiedVehicle(p)
			if veh then
				if policias[ getElementModel(veh) ] then
					if limite and limite >= 50 then
						local x, y, z = getElementPosition(veh)
						exports.chatsystem:me( p, "aprieta un botón y activa el radar de velocidad de la patrulla." )
						vradar[veh] = { col = createColSphere( x, y, z, 30 ), vel = limite }
						attachElements( vradar[veh].col, veh )
					else
						if not vradar[veh] then
							outputChatBox( "Syntax: /"..cmd.." [limite. Minimo 50km/h para que detecte]", p, 255, 255, 255 )
						else
							if isElement( vradar[veh].col ) then destroyElement( vradar[veh].col ) end
							vradar[veh] = nil
							exports.chatsystem:me( p, "aprieta un botón y desactiva el radar de velocidad de la patrulla." )
							outputChatBox( "Has desactivado el radar del vehículo.", p, 255, 150, 0 )
						end
					end
				else
					outputChatBox( "Este no es un vehiculo policial.", p, 255, 0, 0 )
				end
			else
				outputChatBox( "Tienes que estar en un vehiculo para utilizar el radar.", p, 255, 150, 0 )
			end
		end
	end
)
local bicicletas = {
	
	-- Los santos
        {1704.4365234375, -1927.669921875, 13.081188201904, 359.6484375, 0, 268.23669433594},
        {1703.890625, -1925.33203125, 13.081773757935, 359.6484375, 359.99450683594, 269.23095703125},
        {1703.7587890625, -1923.0419921875, 13.081632614136, 359.6484375, 0, 270.01647949219},
        {1703.5869140625, -1920.798828125, 13.081379890442, 359.6484375, 359.99450683594, 267.73132324219},	
}

local bici = {}

setTimer( function()
	for i=1, #bici do 
		if not getVehicleOccupant( bici[i] ) then
			respawnVehicle( bici[i] )
		end
	end
end, 3*60000, 0 )

addCommandHandler( "respawnbicis",
	function(p)
		if hasObjectPermissionTo( p, "command.spectate", false ) then
			for i=1, #bici do 
				if not getVehicleOccupant( bici[i] ) then
					respawnVehicle( bici[i] )
				end
			end			
			outputChatBox( "** Has respawneado las bicis. **", p, 0, 220, 145 )
		end
	end
)

function itsBicicleta(veh)
	for i=1, #bici do 
		if veh == bici[i] then
			return true
		end
	end
	return false
end

function enterVehicle ( player, seat, jacked )
	if itsBicicleta( source ) then
		toggleControl( player, "vehicle_fire", false )
		if ( tiempochar - getRealTime().timestamp ) < 0 then
			cancelEvent()
			outputChatBox( "Se te ha acabado el tiempo de uso de las bicicletas.", player, 255, 150, 0 )
		end
	else
		toggleControl( player, "vehicle_fire", true )
	end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )

addEventHandler( "onResourceStart", resourceRoot,
	function()
		for i=1, #bicicletas do 
			bici[i] = createVehicle( 509, unpack( bicicletas[i] ) )
			setVehicleRespawnPosition( bici[i], unpack( bicicletas[i] ) )
		end
	end
)

addCommandHandler( "posveh",
	function( p )
		local veh = getPedOccupiedVehicle(p)
		if veh then
			local x, y, z = getElementPosition( veh )
			local rx, ry, rz = getElementRotation( veh )
			outputChatBox( "{"..x..", "..y..", "..z..", "..rx..", "..ry..", "..rz.."},", p )
		end
	end
)
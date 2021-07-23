function startTaximeter( player )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 3 or factions[2] == 3 then
			if isPedInVehicle(player) then
				local veh = getPedOccupiedVehicle(player)
				if getElementModel(veh) == 420 or getElementModel(veh) == 438 then
					if getElementData(veh, "taximetro") then
						removeElementData(veh, "taximetro")
						exports.login:addNotification(player, "Has apagado el taxímetro del taxi", "success")
						setVehicleTaxiLightOn ( veh, false )
					else
						setElementData(veh, "taximetro", 0)
						exports.login:addNotification(player, "Has encendido el taxímetro del taxi", "success")
						setVehicleTaxiLightOn ( veh, true )  
					end
				end
			end
		end
	end
end
addCommandHandler("toggletaximetro", startTaximeter)


	setTimer(
		function( )
			for i,v in ipairs(getElementsByType("vehicle")) do
				if getElementData(v, "taximetro") then
					local vx, vy, vz = getElementVelocity( v )
					local speed = math.sqrt( vx * vx + vy * vy )
					if speed > 0 then
						setElementData(v, "taximetro", math.floor(getElementData(v, "taximetro")+(10*speed)))
					end
				end
			end
		end,
		1000,
		0
	)


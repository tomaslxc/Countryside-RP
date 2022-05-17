function openRadio (thePlayer)
	local veh = getPedOccupiedVehicle ( thePlayer )
	if isPedInVehicle (thePlayer) then
		--if getVehicleOccupant (veh,0) then
			triggerClientEvent ("openRadio",getRootElement(),thePlayer)
		--end
	end
end
addCommandHandler ("radio", openRadio)

function devolverInformacion (player,action,link)
	local x,y,z = getElementPosition (player)
	local veh = getPedOccupiedVehicle ( player )
	if action == "play" then
		triggerClientEvent ("receive", getRootElement(), player, action, link, x, y, z, veh)
	elseif action == "reanudar" then
		triggerClientEvent ("receive", getRootElement(), player, action, link, x, y, z, veh)
	elseif action == "pausar" then
		triggerClientEvent ("receive", getRootElement(), player, action, link, x, y, z, veh)
	elseif action == "stop" then
		triggerClientEvent ("receive", getRootElement(), player, action, link, x, y, z, veh)
	end
end
addEvent ("sendInformation", true)
addEventHandler ("sendInformation", getRootElement(), devolverInformacion)
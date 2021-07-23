
local connection = exports.mysql:connect()


function cargarRopa(player, ropa1, ropa2, ropa3,raza)
	for i, players in ipairs ( getElementsByType("player") ) do
		if ropa1 and ropa2 and ropa3 and raza then
			triggerClientEvent(players,"ropa:poner", players, player, ropa1, ropa2, ropa3,raza)
		end
		if getElementData(players, "isLoged") then
			if getElementModel(players) == 0 then
				local data = exports.personajes:getPlayerRopaData(players)
				triggerClientEvent(player,"ropa:poner", player, players, data.ropa1, data.ropa2, data.ropa3, data.raza)
			end
		end
	end
end

function ponerRopa(player, ropa1, ropa2, ropa3,raza)
	for i, players in ipairs ( getElementsByType("player") ) do
		if ropa1 and ropa2 and ropa3 and raza then
			removePedClothes( player, 17 )
			triggerClientEvent(players,"ropa:poner", players, player, ropa1, ropa2, ropa3,raza)
		end
	end
end


function vestidor(player, cmd)
	if getElementData( player, "isLoged" ) then
		local q = dbQuery( connection, "SELECT * FROM ropas_compradas WHERE personaje_id=?", exports.personajes:getCharID(player) )
		local data = dbPoll( q, -1 )
		triggerClientEvent(player, 'mostrar:vestidor', player, data)	
	end
end
addCommandHandler('vestidor', vestidor)

function actualizarRopa( player, ropaID, tipo )
	if removePedClothes( player, 17 ) then
		outputChatBox( "Se te ha quitado el traje.", player, 255, 0, 0 )
	end
	exports.personajes:actualizarRopa(player, ropaID, tipo)
	exports.chatsystem:sendame(player, "Se cambia de ropa")
end
addEvent('actualizar:ropa', true)
addEventHandler('actualizar:ropa', root, actualizarRopa)
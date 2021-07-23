

function cargarCabezaS(player)
	for i, players in ipairs ( getElementsByType("player") ) do
		if getElementData(players, "isLoged") and getElementModel(players) == 0 then
		local cabezaid = exports.personajes:getCabeza(players)
		triggerClientEvent(player,"cabeza:poner", player, players, cabezaid)
		end
	end
end

function cargarCabeza(player, cabezaid)
	if cabezaid then
		for i, players in ipairs ( getElementsByType("player") ) do
			triggerClientEvent(players,"cabeza:poner", players, player, cabezaid)
		end
	end
	
	cargarCabezaS(player)
end

addEventHandler( "onResourceStart", resourceRoot,
	function()
		setTimer( function()
			cargarCabezaS( root )
		end, 1000, 1 )
	end
)



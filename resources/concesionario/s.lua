local connection = exports.mysql:connect()
conce_blueberry = createPed ( 57, -1433.2275390625, -536.619140625, 14.272255897522 )

setElementDimension ( conce_blueberry, 621 )
setElementInterior (  conce_blueberry, 122 )

function abrirConcesionarioBlueberry( button, state, player )
	if button =="left" and state =="down" then
		local x,y,z = getElementPosition(player)
		local x2,y2,z2 = getElementPosition(source)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 5 then
			local q = dbQuery( connection, "SELECT * FROM pedidos_concesionario WHERE personaje_id=?", exports.personajes:getCharID(player) )
			local data = dbPoll( q, -1 ) 
			triggerClientEvent(player, "conce:abrir", player, 1, data)
		end
	end
end
addEventHandler( "onElementClicked", conce_blueberry, abrirConcesionarioBlueberry )

function comprarVeh( player, modelo, coste, id )
	local pmoney = exports.personajes:getCharMoney(player)
	if pmoney >= coste then
		if exports.items:tienehueco(player, 12) then
			exports.personajes:takeCharMoney(player, coste)
			exports.vehiculos:crearVehiculo(modelo,0,0,0,0,0,0,530.900390625, -1286.96875, 17.2421875,exports.personajes:getCharID(player),0,0,0,player,true)
			outputChatBox("Vehículo comprado con éxito.",player,0,200,0)
			dbExec( connection, "DELETE FROM pedidos_concesionario WHERE id=?", id )
		else
			exports.login:addNotification(player,"No tienes hueco en tu inventario como para recibir la llave de este vehículo.", "error")
		end
	else
		exports.login:addNotification(player, "No tienes suficiente efectivo como para comprar este vehículo. Pedido borrado.", "error")
		dbExec( connection, "DELETE FROM pedidos_concesionario WHERE id=?", id )
	end
end
addEvent("comprar:vehiculo", true)
addEventHandler("comprar:vehiculo", root, comprarVeh)
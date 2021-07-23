local connection = exports.mysql:connect()
local rutasCamionero = {}
function checkRoutes( player )
local factions = exports.facciones:getPlayerFaction(player)
	if factions[1] == 6 or factions[2] == 6 then -- cambiar a 7
		if getElementDimension(player) == 0 then
			local rquery = dbQuery( connection, "SELECT dimension FROM tiendas WHERE materiales < ? AND dimension > ?",48,0 )
			local shops_to_refill = dbPoll( rquery, -1 )
			local shops_refill = {}
			for i,v in ipairs(shops_to_refill) do
				local intquery = dbQuery( connection, "SELECT * FROM interiores WHERE id = ?",v.dimension )
				local interior_to_refill = dbPoll( intquery, -1 )
				for j,n in ipairs(interior_to_refill) do
					table.insert(shops_refill, {n.id, n.x_out, n.y_out, n.z_out, n.dimension_out,estadoruta(n.id)})
				end
			end
			triggerClientEvent(player, "open_panel_rutas", player, shops_refill)
		end
	end
end
addCommandHandler("rutascamionero", checkRoutes)

local colshapeRuta = {}
local cajacargamento = {}
function empezarRuta( player, ruta )
	if rutasCamionero[player] ~= nil then
		exports.login:addNotification(player, "Ya tienes una ruta activada, terminala antes de empezar otra", "error")
	else
		rutasCamionero[player] = tonumber(ruta[1])
		triggerClientEvent(player, "mostrar-ruta", player, ruta)
		exports.login:addNotification(player, "La ruta te ha sido marcada en el mapa, ve a entregar la mercancía lo antes posible.", "warning")
		colshapeRuta[player] = createColSphere ( ruta[2], ruta[3], ruta[4], 10 )
	end
end
addEvent("empezar:ruta:camionero", true)
addEventHandler("empezar:ruta:camionero", root, empezarRuta)

function retirarCargamento( player )
 if isElement(colshapeRuta[player]) then
 	if isElementWithinColShape ( player, colshapeRuta[player] ) then
 		if isElement(cajacargamento[player]) then
 			exports.login:addNotification(player, "Ya tienes un cargamento descargado, entrégalo antes de seguir", "error")
 		else
 			local vehs_cercanos = getElementsWithinColShape ( colshapeRuta[player], "vehicle" )
 			if estaCamionCerca(vehs_cercanos) then
	 		cajacargamento[player] = createObject(2912,0,0,0 )
	 		exports.attach_objeto:attachElementToBone(cajacargamento[player],player,12,0.2,0,0.2,90,90,70)
	 		setPedAnimation(player,"CARRY","crry_prtial",0,true,true,false,true) 
	 		exports.chatsystem:me(player, "descarga el contenido del camión, manteniendo la caja en sus manos.")
	 		else
	 			exports.login:addNotification(player, "Debes estar cerca del camión para poder sacar la mercancía", "error")
	 		end
 		end
 	end
 end
end
addCommandHandler("sacarcargamento", retirarCargamento)

local idcamiones = { [414] = true, [499] = true, [498] = true }

function estaCamionCerca( vehs )
	for i,v in ipairs(vehs) do
		if idcamiones[ getElementModel( v ) ] then
			return true
		end
	end
	return false
end

function entregarCargamento( player )
local factions = exports.facciones:getPlayerFaction(player)
if factions[1] == 6 or factions[2] == 6 then
 if isElement(cajacargamento[player]) and isElement(colshapeRuta[player]) then
 	if isElementWithinColShape ( player, colshapeRuta[player] ) then
 		destroyElement(cajacargamento[player])
 		setPedAnimation(player,"CARRY","putdwn",2000,false) 
 		local estado = math.random(1,10)
 		if estado > 6 then
 			outputChatBox("Has entregado una caja, pero aún tienes que entregar más. Vuelve a descargar.",player,200,100,0)
 		else
 			outputChatBox("Has completado el pedido correctamente.",player,0,200,0)
 			destroyElement(colshapeRuta[player])
 			rellenartienda(player)
 			rutasCamionero[player] = nil
 			triggerClientEvent(player, "finalizar:pedido", player)
 			local comision = exports.facciones:getPlayerFactionComision(player, 6)/100
 			local amount = math.random(40,80)
 			local for_player = amount*comision
			local for_company = amount-for_player
			outputChatBox("Has conseguido "..for_player.." dólares para ti y "..for_company.." dólares para la empresa.",player,0,200,0)
			exports.personajes:addCharMoney(player, tonumber(for_player))
			dbExec( connection, "UPDATE `facciones` SET `presupuesto`=presupuesto+"..(tonumber(for_company)).." WHERE `id`=6")
 		end
 	end
 end
end
end
addCommandHandler("entregacarga", entregarCargamento)

function estadoruta( id )
	for i,v in ipairs(getElementsByType("player")) do
		if rutasCamionero[v] ~= nil then
			if rutasCamionero[v] == tonumber(id) then
				return "Ocupada"
			end
		end
	end
	return "Disponible"
end

function camioneroOff ( quitType )
	if isElement(cajacargamento[source]) then
		destroyElement(cajacargamento[source])
	end
	if isElement(colshapeRuta[source]) then
		destroyElement(colshapeRuta[source])
	end
	if rutasCamionero[player] ~= nil then
		rutasCamionero[player] = nil
	end
end
addEventHandler ( "onPlayerQuit", root, camioneroOff )

function rellenartienda( player )
	if rutasCamionero[player] ~= nil then
		dbExec(connection,"UPDATE tiendas SET `materiales`=? WHERE `dimension`=?", 50, rutasCamionero[player])
	end
end
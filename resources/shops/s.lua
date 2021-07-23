local connection = exports.mysql:connect()

function loadShops()
--	connection = dbConnect('sqlite', 'sql.db')
	local query = dbQuery( connection, "SELECT * FROM tiendas ORDER BY id ASC" )
	local data = dbPoll(query, -1)
	for i, tienda in ipairs (data) do
		spawnShop(tienda)
	end
end
addEventHandler ( "onResourceStart", resourceRoot, loadShops )

function spawnShop( shop )
	local ped = createPed(shop.skin, shop.x, shop.y, shop.z, shop.rot)
	setElementDimension(ped, shop.dimension)
	setElementInterior(ped, shop.interior)
	addEventHandler( "onElementClicked", ped, openShop )
	local ped_array = {
		name = shop.name,
		shopid = shop.shop_id,
		materiales = shop.materiales,
		id = shop.id
	}
	setElementData(ped, "pedArray", ped_array)
	setElementFrozen(ped, true)
end

function crearShop(player, cmd, nombre, tipo, skin, owner )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if nombre and tipo and skin then
				local x,y,z = getElementPosition(player)
				local rx,ry,rz = getElementRotation(player)
				local ins = dbQuery( connection, "INSERT INTO tiendas (name,shop_id,skin,linked_int,x,y,z,rot,dimension,interior) VALUES (?,?,?,?,?,?,?,?,?,?)",nombre,tipo,skin,owner,x,y,z,rz,getElementDimension(player),getElementInterior(player))
				local result, num_affected_rows, ID = dbPoll ( ins, -1 )
				local ped = createPed(skin, x,y,z,rz)
				setElementDimension(ped, getElementDimension(player))
				setElementInterior(ped, getElementInterior(player))
				addEventHandler( "onElementClicked", ped, openShop )
				local ped_array = {
					name = nombre,
					shopid = tonumber(tipo),
					materiales = 50,
					id = tonumber(ID)
				}
				setElementData(ped, "pedArray", ped_array)
				setElementFrozen(ped, true)
				outputChatBox("Has creado una nueva tienda ID "..ID,player,0,200,0)
			else
				outputChatBox("Syntax:/creartienda [nombre] [tipo] [skin] [ownerID (0 si no tiene)]",player,255,255,255)
			end
		end
	end
end
addCommandHandler("creartienda", crearShop)

function borrarTienda( player,cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if tonumber(id) then
			dbExec(connection,"DELETE FROM tiendas WHERE id=?", tonumber(id))
			for i,v in ipairs(getElementsByType("ped")) do
				if getElementData(v, "pedArray") then
					local d = getElementData(v, "pedArray")
					if d.id == tonumber(id) then
						destroyElement(v)
						outputChatBox("Has borrado la tienda ID "..id.." correctamente", player, 0, 200,0)
					end
				end
			end
			else
				outputChatBox("Syntax: /borrartienda [ID]",player,255,255,255)
			end
		end
	end
end
addCommandHandler("borrartienda", borrarTienda)

function getNearbyTiendas( player, cmd )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		local tiendas = {}
		local dim, int = getElementDimension( player ), getElementInterior( player )
		outputChatBox( "Tiendas cercanas: ", player, 255, 255, 0 )
		for i,v in ipairs(getElementsByType("ped")) do
			local px, py, pz = getElementPosition( v )
			if getElementData( v, "pedArray" ) and getElementInterior( v ) == int and getElementDimension( v ) == dim and getDistanceBetweenPoints3D( px, py, pz, unpack( { getElementPosition(player) } ) ) < 5 then
				table.insert( tiendas, getElementData( v, "pedArray" ) )
			end
 		end
		if #tiendas > 0 then
			for i=1, #tiendas do 
				local v = tiendas[i]
				outputChatBox( "     - ["..v.id.."] Nombre: "..v.name..", Tipo: "..v.shopid..", Materiales: "..v.materiales, player, 255, 255, 255 )
			end
		else
			outputChatBox( "     No hay tiendas.", player, 255, 0, 0 )
		end
	end
end
addCommandHandler( "nearbyshops", getNearbyTiendas )

function esTiendaDeRopa( id )
	if id == 6 or id == 7 or id == 8 or id == 9 or id == 10 or id == 11 or id == 14 then
		return true
	else
		return false
	end
end


function esTiendaIlegal( id )
	if id == 12 then
		return true
	else
		return false
	end
end

function openShop( button, state, player )
	if button == "left" and state == "down" then
		local x,y,z = getElementPosition(player)
		local x1,y1,z1 = getElementPosition(source)
		if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 5 then
			local ped_array = getElementData(source, "pedArray")
			if esTiendaDeRopa(ped_array.shopid) then
				local ropadata = exports.personajes:getPlayerRopaData(player)
				triggerClientEvent(player, "shop:open:ropa", player, ped_array.shopid, ropadata, ped_array.id)
	--		elseif esTiendaIlegal(ped_array.shopid) then
			--	local factions = exports.facciones:getPlayerFaction(player)
				--if factions[1] == 0 or factions[2] == 0 then
				--	local d = exports.facciones:getPlayerFactionRights(player, 0, 5)
					--if d >= 2 then
			--			triggerClientEvent(player, "shop:open", player, ped_array.shopid, ped_array.id)
					--end
				else
		--		outputChatBox("Sujeto: No te conozco, fuera de aquí.",player,200,200,200)
			--	end
		--	else
				triggerClientEvent(player, "shop:open", player, ped_array.shopid, ped_array.id)
			end
		end
	elseif button == "right" and state =="down" then
		if getElementData(player, "staff") and getElementData(player, "staff") >= 3 then
			local ped_array = getElementData(source, "pedArray")
			outputChatBox("Tienda con ID "..ped_array.id,player,0,200,0)
		end
	end
end
function crearNuevoTelefono()
	local ins = dbQuery( connection, "INSERT INTO phones (activo) VALUES (?)",1)
	local result, num_affected_rows, ID = dbPoll ( ins, -1 )
	return ID
end
local pagos = {}
function finalizarCompra( player, carrito, shop_id, idTablaShop)

	if idTablaShop and idTablaShop == 13 and findSkin(getElementModel(player)) then
		return
	end
	
local query = dbQuery( connection, "SELECT * FROM tiendas WHERE id=?",shop_id )
local data = dbPoll(query, -1)
if data[1].materiales > 0 then
	if not exports.toys:tieneRecipiente(player, "mano") then
		pagos[player] = 0
		for k,item in pairs(carrito) do
			pagos[player] = pagos[player] + item.price
		end
		if exports.personajes:getCharMoney(player) >= pagos[player] then
			for k,item in pairs(carrito) do
				if idTablaShop ~= 13 then
					if item.id == 16 or item.id == 17 then
						local numero = crearNuevoTelefono()
						carrito[k].slot = tonumber(numero)
					end
				else
					local tab = getElementData(player, 'Skins:Save') or {}
					table.insert(tab, {item.id, item.name})
					setElementData(player, 'Skins:Save', tab)
				end
			end
			
			exports.personajes:takeCharMoney(player, pagos[player])
			if idTablaShop ~= 13 then
				exports.toys:dar_recipiente(player, 2,true,carrito)
			end
			exports.chatsystem:sendame(player, "Paga en efectivo y agarra la bolsa de la compra")
			setPedAnimation ( player, "dealer", "shop_pay", 3000, false, true,
                      true, false, 250, false)
			dbExec( connection, "UPDATE `tiendas` SET `materiales`=`materiales`-"..tonumber(#carrito).." WHERE `id`="..shop_id)
		else
			exports.login:addNotification(player, "No tienes suficiente dinero", "error")
		end
	else
		exports.login:addNotification(player, "Tienes las manos ocupadas y no puedes cargar con la bolsa de la compra", "error")
	end
else
	outputChatBox("Esta tienda no tiene stock.",player, 200,0,0)
end
end
addEvent("shop:comprar",true)
addEventHandler("shop:comprar", root,finalizarCompra)

function ropaComprar( player, ropaID, amount,shop_id )
local query = dbQuery( connection, "SELECT * FROM tiendas WHERE id=?",shop_id )
local data = dbPoll(query, -1)
if data[1].materiales > 0 then
	if getElementModel(player) == 0 then
	if not exports.personajes:hasRopa(player, tonumber(ropaID)) then
		if exports.personajes:getCharMoney(player) >= amount then
			exports.personajes:takeCharMoney(player, amount)
			exports.chatsystem:sendame(player, "Paga en efectivo y obtiene la prenda de ropa")
			setPedAnimation ( player, "dealer", "shop_pay", 3000, false, true,
                      true, false, 250, false)
			exports.personajes:darPrenda(player, ropaID)
			outputChatBox('Has comprado la prenda con ID '..ropaID..' correctamente por $'..amount, player, 0, 200,0)
			dbExec( connection, "UPDATE `tiendas` SET `materiales`=`materiales`-1 WHERE `id`="..shop_id)
		else
			exports.login:addNotification(player, "No tienes suficiente dinero", "error")
		end
	else
		exports.login:addNotification(player, "Ya tienes esta prenda en tu armario", "error")
	end
	else
		outputChatBox("Por el momento no está implementada la tienda para skins femeninos.",player,200,0,0)
	end
else
	outputChatBox("Esta tienda no tiene stock.",player, 200,0,0)
end
end
addEvent("ropa:comprar",true)
addEventHandler("ropa:comprar", root,ropaComprar)

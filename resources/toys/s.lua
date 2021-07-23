local connection = exports.mysql:connect()

r_list={--[id]=objeto,hueso,x,y,z,rx,ry,rz,sitio,hueco
	[1] = {1207,3,0,-0.13,0.1,0,0,0,"espalda",10},--mochila pequeña
	[2] = {1208,12,0,0,0,0,-100,0,"mano",10},--bolsa de plastico
}



recipientes = {}
function loadRecipientes(player)
	local q = dbQuery( connection, "SELECT * FROM recipientes WHERE owner=? AND maletero=?", exports.personajes:getCharID(player),0 )
	local rec = dbPoll( q, -1 )
	local inte = getElementInterior(player)
	local dime = getElementDimension(player)
	if not recipientes[player] then
		recipientes[player] = {}
	end
	for i, data in ipairs(rec) do

		if recipientes[player][data.pos] ~= nil and isElement(recipientes[player][data.pos].objeto) then
			destroyElement(recipientes[player][data.pos].objeto)
			recipientes[player][data.pos] = nil
		end

		recipientes[player][data.pos] = {
			datos = {data.id,data.owner,data.tipo,data.pos},
			items = {fromJSON(data.i1),fromJSON(data.i2),fromJSON(data.i3),fromJSON(data.i4),fromJSON(data.i5),fromJSON(data.i6),fromJSON(data.i7),fromJSON(data.i8),fromJSON(data.i9),fromJSON(data.i10),fromJSON(data.i11),fromJSON(data.i12),fromJSON(data.i13),fromJSON(data.i14),fromJSON(data.i15)},
			objeto = createObject (r_list[data.tipo][1] , 0,0,0 )
		}
		setElementDimension(recipientes[player][data.pos].objeto, dime)
		setElementInterior(recipientes[player][data.pos].objeto, inte)
		exports.attach_objeto:attachElementToBone(recipientes[player][data.pos].objeto,player,r_list[data.tipo][2],r_list[data.tipo][3],r_list[data.tipo][4],r_list[data.tipo][5],r_list[data.tipo][6],r_list[data.tipo][7],r_list[data.tipo][8])
	end
end

function dar_recipiente(player, tipo, hasItems, carrito)
	local pos = r_list[tipo][9]
	local inte = getElementInterior(player)
	local dime = getElementDimension(player)
	local ID_player = exports.personajes:getCharID(player)
	if pos == "espalda" then
		if recipientes[player][1] == nil then
			local query_rec = "INSERT INTO recipientes (owner,tipo,pos,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
			local ins = dbQuery( connection,query_rec,ID_player,tonumber(tipo),1,"[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]")
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			recipientes[player][1] = {
				datos = {ID,ID_player,tonumber(tipo),1},
				items = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}},
				objeto = createObject (r_list[tipo][1] , 0,0,0 )
			}
			setElementDimension(recipientes[player][1].objeto, dime)
			setElementInterior(recipientes[player][1].objeto, inte)
			exports.attach_objeto:attachElementToBone(recipientes[player][1].objeto,player,r_list[tipo][2],r_list[tipo][3],r_list[tipo][4],r_list[tipo][5],r_list[tipo][6],r_list[tipo][7],r_list[tipo][8])
			return 1
		else
			return false
		end
	elseif pos == "mano" then
		if recipientes[player][2] == nil then
			local query_rec = "INSERT INTO recipientes (owner,tipo,pos,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
			local ins = dbQuery( connection,query_rec,ID_player,tonumber(tipo),2,"[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]")
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			recipientes[player][2] = {
				datos = {ID,ID_player,tonumber(tipo),2},
				items = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}},
				objeto = createObject (r_list[tipo][1] , 0,0,0 )
			}
			setElementDimension(recipientes[player][2].objeto, dime)
			setElementInterior(recipientes[player][2].objeto, inte)
			exports.attach_objeto:attachElementToBone(recipientes[player][2].objeto,player,r_list[tipo][2],r_list[tipo][3],r_list[tipo][4],r_list[tipo][5],r_list[tipo][6],r_list[tipo][7],r_list[tipo][8])
			if hasItems then
				for k,item in pairs(carrito) do
					recipientes[player][2].items[k][1] = item.id
					recipientes[player][2].items[k][2] = item.slot
				end
				saveRecipientes(player)
			end
			return 2
		else
			return false
		end
	end
end

function darItemRecipiente( player, id, itemID, slot )
	triggerClientEvent(player, "dar:itemrecipiente", player, itemID, slot,id)
end

function quitar_recipiente( player, id, dbid, tipo)
	if recipientes[player] then
		if isElement(recipientes[player][tonumber(id)].objeto) then
			if tipo == "maletero" then
				local inv = recipientes[player][tonumber(id)].items
				local query = "UPDATE `recipientes` SET `i1`=?,`i2`=?,`i3`=?,`i4`=?,`i5`=?,`i6`=?,`i7`=?,`i8`=?,`i9`=?,`i10`=?,`i11`=?,`i12`=?,`i13`=?,`i14`=?,`i15`=?,`maletero`=? WHERE `id`=?"
				dbExec(connection, query, toJSON(inv[1]),toJSON(inv[2]),toJSON(inv[3]),toJSON(inv[4]),toJSON(inv[5]),toJSON(inv[6]),toJSON(inv[7]),toJSON(inv[8]),toJSON(inv[9]),toJSON(inv[10]),toJSON(inv[11]),toJSON(inv[12]),toJSON(inv[13]),toJSON(inv[14]),toJSON(inv[15]),1,dbid)
			elseif tipo == "destruir" then
				dbExec(connection, "DELETE FROM `recipientes` WHERE `id`=?", dbid)
			end
		destroyElement(recipientes[player][tonumber(id)].objeto)
		end
		recipientes[player][tonumber(id)] = nil
	end
end
addEvent("rec:quitar", true)
addEventHandler("rec:quitar", root, quitar_recipiente)

function poner_recipiente_desde_maletero(player, recid, dbid, hueco )
	local pos = r_list[recid][9]
	if pos == "espalda" then
		if recipientes[player][1] == nil then
			local query = "UPDATE `recipientes` SET `owner`=?,`maletero`=? WHERE `id`=?"
			dbExec(connection, query, exports.personajes:getCharID(player),0, dbid)
			exports.vehiculos:quitarRecipienteMaletero(player, hueco)
			loadRecipientes(player, recid)
			mostrar_panel_recipientes(player)
		else
			exports.login:addNotification(player, "No puedes equiparte este recipiente porque tienes la espalda ocupada.", "error")
		end
	elseif pos == "mano" then
		if recipientes[player][2] == nil then
			local query = "UPDATE `recipientes` SET `owner`=?,`maletero`=? WHERE `id`=?"
			dbExec(connection, query,exports.personajes:getCharID(player), 0, dbid)
			exports.vehiculos:quitarRecipienteMaletero(player, hueco)
			loadRecipientes(player, recid)
			mostrar_panel_recipientes(player)
		else
			exports.login:addNotification(player, "No puedes equiparte este recipiente porque tienes la mano ocupada.", "error")
		end
	end
end
addEvent("rec:darmaletero", true)
addEventHandler("rec:darmaletero", root, poner_recipiente_desde_maletero)

function mostrar_panel_recipientes(player)
	local r = recipientes[player]
	if r == nil then

	elseif recipientes[player][1] ~= nil and recipientes[player][2] ~= nil then
		triggerClientEvent(player, "mostrar:recipientes", player, r[1]["items"], r[2]["items"], r[1]["datos"][3],r[2]["datos"][3],r_list[r[1]["datos"][3]][10],r_list[r[2]["datos"][3]][10],r[1]["datos"][1],r[2]["datos"][1],r[1]["datos"][4],r[2]["datos"][4])
	elseif recipientes[player][1] == nil and recipientes[player][2] ~= nil then
		triggerClientEvent(player, "mostrar:recipientes", player, false, r[2]["items"], false,r[2]["datos"][3],false,r_list[r[2]["datos"][3]][10],false,r[2]["datos"][1],false,r[2]["datos"][4])
	elseif recipientes[player][1] ~= nil and recipientes[player][2] == nil then
		triggerClientEvent(player, "mostrar:recipientes", player, r[1]["items"], false, r[1]["datos"][3],false,r_list[r[1]["datos"][3]][10],false,r[1]["datos"][1],false,r[1]["datos"][4],false)
	end
end

function tieneRecipiente( player, zona )
	if zona == "espalda" then
		if recipientes[player][1] ~= nil and isElement(recipientes[player][1].objeto) then
			return true
		else
			return false
		end
	elseif zona == "mano" then
		if recipientes[player][2] ~= nil and isElement(recipientes[player][2].objeto) then
			return true
		else
			return false
		end
	end
end

--GUARDADO--
function recipienteUpdateFromClient( player, pos, items )
	if isElement(recipientes[player][tonumber(pos)].objeto) then
		recipientes[player][tonumber(pos)].items = items
	end
end
addEvent("recipiente:update", true)
addEventHandler("recipiente:update", root, recipienteUpdateFromClient)

function saveRecipientes( player )
	if recipientes[player][1] ~= nil and isElement(recipientes[player][1].objeto) then
		local inv = recipientes[player][1].items
		local query = "UPDATE `recipientes` SET `i1`=?,`i2`=?,`i3`=?,`i4`=?,`i5`=?,`i6`=?,`i7`=?,`i8`=?,`i9`=?,`i10`=?,`i11`=?,`i12`=?,`i13`=?,`i14`=?,`i15`=? WHERE `id`=?"
		dbExec(connection, query, toJSON(inv[1]),toJSON(inv[2]),toJSON(inv[3]),toJSON(inv[4]),toJSON(inv[5]),toJSON(inv[6]),toJSON(inv[7]),toJSON(inv[8]),toJSON(inv[9]),toJSON(inv[10]),toJSON(inv[11]),toJSON(inv[12]),toJSON(inv[13]),toJSON(inv[14]),toJSON(inv[15]),recipientes[player][1].datos[1])
	end
	if recipientes[player][2] ~= nil and isElement(recipientes[player][2].objeto) then
		local inv = recipientes[player][2].items
		local query = "UPDATE `recipientes` SET `i1`=?,`i2`=?,`i3`=?,`i4`=?,`i5`=?,`i6`=?,`i7`=?,`i8`=?,`i9`=?,`i10`=?,`i11`=?,`i12`=?,`i13`=?,`i14`=?,`i15`=? WHERE `id`=?"
		dbExec(connection, query, toJSON(inv[1]),toJSON(inv[2]),toJSON(inv[3]),toJSON(inv[4]),toJSON(inv[5]),toJSON(inv[6]),toJSON(inv[7]),toJSON(inv[8]),toJSON(inv[9]),toJSON(inv[10]),toJSON(inv[11]),toJSON(inv[12]),toJSON(inv[13]),toJSON(inv[14]),toJSON(inv[15]),recipientes[player][2].datos[1])
	end
end
---BORRADO--

function destoyRecipiente( player, dbid, id )
	quitar_recipiente( player, id, dbid, "destruir")
	outputChatBox("Has destruido el recipiente y todo lo que había en su interior", player, 200,0,0)
end
addEvent("rec:destruir",true)
addEventHandler("rec:destruir",root,destoyRecipiente)

function quitPlayer ( quitType )
	if getElementData(source, "isLoged") then
		if recipientes[source] ~= nil and recipientes[source][1] ~= nil then
			if isElement(recipientes[source][1].objeto) then
				saveRecipientes(source)
			destroyElement(recipientes[source][1].objeto)
			end
		end
		if recipientes[source] ~= nil and recipientes[source][2] ~= nil then
			if isElement(recipientes[source][2].objeto) then
				saveRecipientes(source)
			destroyElement(recipientes[source][2].objeto)
			end
		end
		recipientes[source] = nil
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

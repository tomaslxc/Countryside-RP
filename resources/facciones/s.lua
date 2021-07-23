local connection = exports.mysql:connect()
-- dbExec( connection, "UPDATE `cheques_bancarios` SET `activo`=0 WHERE `id`="..numero)
-- local ins = dbQuery( connection, "INSERT INTO cuentas_bancarias (owner, pin, dinero) VALUES (?,?,?)",exports.personajes:getCharID(player), tonumber(pin), 0)
-- 		local result, num_affected_rows, ID = dbPoll ( ins, -1 )
function getPlayerFaction( player )
	local q = dbQuery( connection, "SELECT * FROM pjs_en_facciones WHERE id_personaje=?", exports.personajes:getCharID(player) )
	local rec = dbPoll( q, -1 )
	local factions = {}
	if (rec[1] ~= nil) then
		table.insert(factions, rec[1].id_faccion)
	end
	if rec[2] ~= nil then
		table.insert(factions, rec[2].id_faccion)
	end
	if #factions > 0 then
		return factions
	else
		return false
	end
end
function getPlayerFactionComision( player, faccID )
	local q = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", tonumber(faccID) )
	local rec = dbPoll( q, -1 )
	return rec[1].comision
end
function getFactionType( faccID )
	local q = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", faccID )
	local rec = dbPoll( q, -1 )
	return rec.tipo
end
function getPlayerFactionRights( player, id_extract, factionID )
	if id_extract ~= 0 then
		local q = dbQuery( connection, "SELECT * FROM pjs_en_facciones WHERE id_personaje=? AND id_faccion=?", id_extract,factionID )
		local rec = dbPoll( q, -1 )
		if (rec[1] ~= nil) then
			return rec[1].derecho
		else
			return false
		end
	else
		local q = dbQuery( connection, "SELECT * FROM pjs_en_facciones WHERE id_personaje=? AND id_faccion=?", exports.personajes:getCharID(player), factionID )
		local rec = dbPoll( q, -1 )
		if (rec[1] ~= nil) then
			return rec[1].derecho
		else
			return false
		end
	end
end
function isPlayerInFaction( player, faccID )
	local factions = getPlayerFaction(player)
	if factions then
		if factions[1] == tonumber(faccID) or factions[2] == tonumber(faccID) then
			return true
		else
			return false
		end
	else
		return false
	end
end
function getFactionNameFromID( factionID )
	local q = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", factionID )
	local rec = dbPoll( q, -1 )
	return rec[1].name
end
function addFactionBind()
	for i, player in ipairs(getElementsByType("player")) do
		bindKey (player , "f3", "down", openFactionPanel, player)
		bindKey (player , "f2", "down", openFactionPanel2, player)
	end
end
addEventHandler ( "onResourceStart", resourceRoot, addFactionBind )

function addFactionBind_OnLogin()
	bindKey (source , "f3", "down", openFactionPanel, source)
	bindKey (source , "f2", "down", openFactionPanel2, source)
end
addEventHandler("onPlayerJoin", getRootElement(), addFactionBind_OnLogin)

function openFactionPanel( player )
	if getElementData(player, "isLoged") then
		local faccIDs = getPlayerFaction(player)
		if faccIDs then
			local rights = getPlayerFactionRights(player,0,faccIDs[1])
			triggerClientEvent(player, "open:faction", player, {faccIDs[1]}, rights)
		else
			exports.login:addNotification(player,'No perteneces a ninguna facción', 'error')
		end
	end
end
addCommandHandler("facc",openFactionPanel)

function openFactionPanel2( player )
	if getElementData(player, "isLoged") then
		local faccIDs = getPlayerFaction(player)
		if faccIDs and faccIDs[2] ~= nil then
			local rights = getPlayerFactionRights(player,0,faccIDs[2])
			triggerClientEvent(player, "open:faction", player, {faccIDs[2]}, rights)
		else
			exports.login:addNotification(player,'No perteneces a ninguna facción', 'error')
		end
	end
end
addCommandHandler("facc2",openFactionPanel2)

function cargarDatosFaccion( player, faccID )

	local q_info = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", faccID )
	local res_info = dbPoll( q_info, -1 )
	local q_rangos = dbQuery( connection, "SELECT * FROM rangos_facciones WHERE id_faccion=? ORDER BY pos DESC", faccID )
	local res_rangos = dbPoll( q_rangos, -1 )
	local q_miembros = dbQuery( connection, "SELECT * FROM pjs_en_facciones WHERE id_faccion=?", faccID )
	local res_miembros = dbPoll( q_miembros, -1 )

	local info = res_info[1]
	local rangos = {}
	local miembros = {}

	for i=1,#res_rangos do
		rangos[res_rangos[i].id] = {res_rangos[i].pos, res_rangos[i].nombre}
		for j=1,#res_miembros do
			if res_miembros[j].rango == res_rangos[i].id then
				local nombre = exports.personajes:getCharNameFromID(res_miembros[j].id_personaje)
				local lastcon = exports.personajes:getCharLastConnection(res_miembros[j].id_personaje)
				table.insert(miembros, {res_miembros[j].id_personaje,nombre,res_miembros[j].derecho,res_miembros[j].rango,res_miembros[j].sueldo,lastcon})
			end
		end
	end

	triggerClientEvent(player, "update_faction", player, miembros,rangos,info,exports.personajes:getCharID(player))
end
addEvent("trigger_facc_info", true)
addEventHandler("trigger_facc_info", root, cargarDatosFaccion)
function idRangoSiguiente(tablee, pos )
	for i,v in pairs(tablee) do
		if tablee[i][1] == pos then
			return i
		end
	end
end
function hayRangoSiguiente(tablee, pos)
	for i,v in pairs(tablee) do
		if tablee[i][1] == pos then
			return i
		end
	end
	return false
end
function hay_rango( tablee, id_rango_actual, how )
	for i,rango in pairs(tablee) do
		if i == id_rango_actual then
			if how == "descender" then
				if tablee[i][1] == 1 then
					return false
				else
					return idRangoSiguiente(tablee, tablee[id_rango_actual][1]-1)
				end
			else
				return hayRangoSiguiente(tablee, tablee[id_rango_actual][1]+1)
			end
		end
	end
end
function mensaje_a_faccion( faccID,message )
	for i,players in ipairs(getElementsByType("player")) do
		local factions = getPlayerFaction(players)
		if factions then
			if factions[1] == faccID or factions[2] == faccID then
				outputChatBox( message, players, 255,128,0)
			end
		end
	end
end

function ascender( player, id_ascendido, id_rango_actual, rangos_faccion,factionID )
	local id_rango_siguiente = hay_rango(rangos_faccion, id_rango_actual, "ascender")
	if id_rango_siguiente then
		dbExec( connection, "UPDATE `pjs_en_facciones` SET `rango`="..id_rango_siguiente.." WHERE `id_personaje`="..id_ascendido.." AND `id_faccion`="..factionID)
		local otherName = string.gsub(exports.personajes:getCharNameFromID(id_ascendido),'_',' ')
		local name = string.gsub(getPlayerName(player),'_',' ')
		local rankName = rangos_faccion[id_rango_siguiente][2]
		mensaje_a_faccion(factionID, name.." ha ascendido a "..otherName.." a "..rankName)
	else
		exports.login:addNotification(player, "No hay más rangos establecidos", "error")
	end
end
addEvent("facc:ascender", true)
addEventHandler("facc:ascender", root, ascender)

function descender( player, id_ascendido, id_rango_actual, rangos_faccion,factionID )
	local id_rango_siguiente = hay_rango(rangos_faccion, id_rango_actual, "descender")
	if id_rango_siguiente then
		dbExec( connection, "UPDATE `pjs_en_facciones` SET `rango`="..id_rango_siguiente.." WHERE `id_personaje`="..id_ascendido.." AND `id_faccion`="..factionID)
		local otherName = string.gsub(exports.personajes:getCharNameFromID(id_ascendido),'_',' ')
		local name = string.gsub(getPlayerName(player),'_',' ')
		local rankName = rangos_faccion[id_rango_siguiente][2]
		mensaje_a_faccion(factionID, name.." ha degradado a "..otherName.." a "..rankName)
	else
		exports.login:addNotification(player, "No hay más rangos establecidos", "error")
	end
end
addEvent("facc:descender", true)
addEventHandler("facc:descender", root, descender)

local rank_states = {
    [0] = "Miembro",
    [1] = "Líder",
    [2] = "Encargado",
    [3] = "Dueño"
}

function cambiarPermisos( player, id_otro, how, factionID )
	local actual_permiso = getPlayerFactionRights(player, id_otro,factionID)
	if how == "subir" then
		if actual_permiso == 3 then
			exports.login:addNotification(player, "No hay más permisos", "error")
		else
			dbExec( connection, "UPDATE `pjs_en_facciones` SET `derecho`="..(actual_permiso+1).." WHERE `id_personaje`="..id_otro.." AND `id_faccion`="..factionID)
			local otherName = string.gsub(exports.personajes:getCharNameFromID(id_otro),'_',' ')
			local name = string.gsub(getPlayerName(player),'_',' ')
			local rankName = rank_states[actual_permiso+1]
			mensaje_a_faccion(factionID, name.." ha subido a "..otherName.." a "..rankName)
		end
	elseif how == "bajar" then
		if actual_permiso == 0 then
			exports.login:addNotification(player, "No hay más permisos", "error")
		else
			dbExec( connection, "UPDATE `pjs_en_facciones` SET `derecho`="..(actual_permiso-1).." WHERE `id_personaje`="..id_otro.." AND `id_faccion`="..factionID)
			local otherName = string.gsub(exports.personajes:getCharNameFromID(id_otro),'_',' ')
			local name = string.gsub(getPlayerName(player),'_',' ')
			local rankName = rank_states[actual_permiso-1]
			mensaje_a_faccion(factionID, name.." ha bajado a "..otherName.." a "..rankName)
		end
	end
end
addEvent("facc:permisos", true)
addEventHandler("facc:permisos", root, cambiarPermisos)

function expulsar( player, id_otro,factionID )
	local tu_permiso = getPlayerFactionRights(player,0,factionID)
	local su_permiso = getPlayerFactionRights(player,id_otro,factionID)

	if su_permiso >= tu_permiso then
		exports.login:addNotification(player, "No puedes hacer esto", "error")
	else
		local otherName = string.gsub(exports.personajes:getCharNameFromID(id_otro),'_',' ')
		local name = string.gsub(getPlayerName(player),'_',' ')
		mensaje_a_faccion(factionID, otherName.." ha sido expulsado por "..name)
		dbExec(connection, "DELETE FROM pjs_en_facciones WHERE id_personaje=? AND id_faccion=?",id_otro,factionID)
	end
end
addEvent("facc:expulsar", true)
addEventHandler("facc:expulsar", root, expulsar)

function cambiar_sueldo( player, id_otro, nuevo_sueldo,factionID )
	if tonumber(nuevo_sueldo) and tonumber(nuevo_sueldo) >= 0 then
		dbExec( connection, "UPDATE `pjs_en_facciones` SET `sueldo`="..(nuevo_sueldo).." WHERE `id_personaje`="..id_otro.." AND `id_faccion`="..factionID)
		
		local ins = dbQuery( connection, "INSERT INTO registrosueldos (encargado, fecha, sueldo, id_faccion, empleado) VALUES (?,?,?,?,?)", getPlayerName( player ), getRealTime().timestamp, tonumber( nuevo_sueldo ), tonumber( factionID ), exports.personajes:getCharNameFromID( id_otro ) )
		local result, num_affected_rows, ID = dbPoll ( ins, -1 )
	else
		exports.login:addNotification(player, "El sueldo introducido no es correcto", "error")
	end
end
addEvent("facc:cambiarsueldo", true)
addEventHandler("facc:cambiarsueldo", root, cambiar_sueldo)

function invitar( player, otherPlayer, factionID )
	local other, name = exports.login:getNID( player, otherPlayer )
	if other and getElementData(other, "isLoged") then
		local otherFactions = getPlayerFaction(other)
		if otherFactions and #otherFactions > 1 then
			exports.login:addNotification(player, "Este jugador no puede estar en más facciones", "error")
		elseif otherFactions and otherFactions[1] == factionID then
			exports.login:addNotification(player, "Este jugador ya está en la facción", "error")
		else
			local q_rangos = dbQuery( connection, "SELECT * FROM rangos_facciones WHERE id_faccion=? ORDER BY pos DESC", factionID )
			local res_rangos = dbPoll( q_rangos, -1 )
			local ins = dbQuery( connection, "INSERT INTO pjs_en_facciones (id_personaje, id_faccion, rango) VALUES (?,?,?)",exports.personajes:getCharID(other), tonumber(factionID), res_rangos[#res_rangos].id)
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			outputChatBox("Ahora perteneces a la facción "..getFactionNameFromID(factionID), other, 0, 200,0)
		end
	else
		exports.login:addNotification(player, "El jugador no está conectado", "error")
	end
end
addEvent("facc:invitar", true)
addEventHandler("facc:invitar", root, invitar)






-- COMANDOS ADMINISTRATIVOS

-----------------------------------------------------------------------------

function meterEnFaccion( player, cmd, otherPlayer, factionID )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 3 then
		local other, name = exports.login:getNID( player, otherPlayer )
		if other and getElementData(other, "isLoged") then
			local otherFactions = getPlayerFaction(other)
			if otherFactions and #otherFactions > 1 then
				exports.login:addNotification(player, "Este jugador no puede estar en más facciones", "error")
			elseif otherFactions and otherFactions[1] == factionID then
				exports.login:addNotification(player, "Este jugador ya está en la facción", "error")
			else
				local q_rangos = dbQuery( connection, "SELECT * FROM rangos_facciones WHERE id_faccion=? ORDER BY pos DESC", factionID )
				local res_rangos = dbPoll( q_rangos, -1 )
				local ins = dbQuery( connection, "INSERT INTO pjs_en_facciones (id_personaje, id_faccion, rango) VALUES (?,?,?)",exports.personajes:getCharID(other), tonumber(factionID), res_rangos[#res_rangos].id)
				local result, num_affected_rows, ID = dbPoll ( ins, -1 )
				outputChatBox("Ahora perteneces a la facción "..getFactionNameFromID(factionID), other, 0, 200,0)
			end
		else
			exports.login:addNotification(player, "El jugador no está conectado", "error")
		end
	end
end
addCommandHandler( "setfaction", meterEnFaccion )

function getListaFacciones( player )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 2 then
		local q_faccs = dbQuery( connection, "SELECT * FROM facciones ORDER BY id ASC" )
		local faccs = dbPoll( q_faccs, -1 )
		if faccs and #faccs > 0 then
			outputChatBox( "---- Lista de facciones ----", player, 255, 255, 0 )
			for i=1, #faccs do 
				local v = faccs[i]
				outputChatBox( "	["..v.id.."] "..v.name, player, 255, 255, 255 )
			end
		else
			outputChatBox( "Fallo en obtener la lista de facciones.", player, 255, 0, 0 )
		end
	end
end
addCommandHandler( "listafaccs", getListaFacciones )

function listarRangosDeFacc( player, cmd, idfacc )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 2 then
		local q_faccs = dbQuery( connection, "SELECT * FROM rangos_facciones WHERE id_faccion=? ORDER BY id ASC", tonumber(idfacc) )
		local faccs = dbPoll( q_faccs, -1 )
		if faccs and #faccs > 0 then
			outputChatBox( "---- Lista de rangos en la faccion "..tonumber(idfacc).." ----", player, 255, 255, 0 )
			for i=1, #faccs do 
				local v = faccs[i]
				outputChatBox( "	["..v.pos.."] "..v.nombre, player, 255, 255, 255 )
			end
		else
			outputChatBox( "Fallo en obtener la lista de facciones.", player, 255, 0, 0 )
		end	
	end
end
addCommandHandler( "rangosfacc", listarRangosDeFacc )

function setJugadorRango( player, cmd, otherPlayer, idfacc, idrango )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 3 then
		local other, name = exports.login:getNID( player, otherPlayer )
		if other and getElementData(other, "isLoged") then		
			local q_faccs = dbQuery( connection, "SELECT * FROM rangos_facciones WHERE id_faccion=? AND pos=? ORDER BY id ASC", tonumber(idfacc), tonumber(idrango) )
			local faccs = dbPoll( q_faccs, -1 )
			if faccs and #faccs > 0 then
				local charid = exports.personajes:getCharID( other )
				if charid then
					dbExec( connection, "UPDATE `pjs_en_facciones` SET `rango`="..faccs[1].id.." WHERE `id_personaje`="..charid.." AND `id_faccion`="..idfacc)
					outputChatBox( "Le has asignado el rango "..faccs[1].nombre.." a "..name.." en la faccion "..getFactionNameFromID(idfacc), player, 0, 255, 0 )
					outputChatBox( "El staff "..getPlayerName(player).." te ha asignado el rango "..faccs[1].nombre.." en la facción "..getFactionNameFromID(idfacc), other, 0, 255, 0 )
				else
					outputChatBox( "Fallo en obtener la ID del jugador.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "No se puede encontrar el rango con esa ID.", player, 255, 0, 0 )
			end
		else
			outputChatBox( "Syntax: /"..cmd.." [id jugador] [id facc] [id rango]", player, 255, 255, 255 )
		end
	end
end
addCommandHandler( "setfactionrango", setJugadorRango )

function cambiarDerechosJugador( player, cmd, otherPlayer, idfacc, idderecho )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 4 then
		if tonumber( idfacc ) and tonumber( idderecho ) then
			local other, name = exports.login:getNID( player, otherPlayer )
			if other and getElementData(other, "isLoged") then
				if isPlayerInFaction( other, idfacc ) then
					if rank_states[tonumber(idderecho)] then
						local charid = exports.personajes:getCharID( other )
						if charid then
							dbExec( connection, "UPDATE `pjs_en_facciones` SET `derecho`="..tonumber(idderecho).." WHERE `id_personaje`="..charid.." AND `id_faccion`="..idfacc)
							outputChatBox( "Has puesto a "..name.." como "..rank_states[tonumber(idderecho)].." en la faccion "..getFactionNameFromID(idfacc), player, 0, 255, 0 )
						else
							outputChatBox( "Fallo en obtener la ID del personaje.", player, 255, 0, 0 )
						end
					else
						outputChatBox( "La id del derecho no es válida. (del 0 al 3)", player, 255, 0, 0 )
					end
				else
					outputChatBox( "El jugador no está en la facción.", player, 255, 0, 0 )
				end
			end
		else
			outputChatBox( "Syntax: /"..cmd.." [id jugador] [id facc] [id derecho (del 0 al 3)]", player, 255, 255, 255 )
		end
	end
end
addCommandHandler( "setfactionderechos", cambiarDerechosJugador )



-----------------------------------------------------------------------------



function renombrar( player, new_name, factionID )
	dbExec( connection, "UPDATE `facciones` SET `name`='"..(new_name).."' WHERE `id`="..factionID)
end
addEvent("facc:renombrar", true)
addEventHandler("facc:renombrar", root, renombrar)


function abandonar( player, factionID )
	dbExec( connection, "DELETE FROM pjs_en_facciones WHERE id_personaje=? AND id_faccion=?",exports.personajes:getCharID(player),factionID)
	outputChatBox("Te has ido de la facción.",player, 0, 200,0)
end
addEvent("facc:abandonar", true)
addEventHandler("facc:abandonar", root, abandonar)

function actualizar_rangos( player,rangos,factionID )
	for i, r in pairs(rangos) do
		dbExec( connection, "UPDATE `rangos_facciones` SET `nombre`='"..(r[2]).."' WHERE `id_faccion`="..factionID.." AND `pos`="..r[1])
	end
	local name = string.gsub(getPlayerName(player),'_',' ')
	mensaje_a_faccion(factionID, name.." ha actualizado los rangos.")
end
addEvent("facc:actualizar_rangos", true)
addEventHandler("facc:actualizar_rangos", root, actualizar_rangos)

function nuevo_rango( player,rango,factionID,lastpos )
	if #rango > 1 then
		local ins = dbQuery( connection, "INSERT INTO rangos_facciones (nombre, id_faccion, pos) VALUES (?,?,?)",rango,factionID,lastpos+1)
		local result, num_affected_rows, ID = dbPoll ( ins, -1 )
	else
		exports.login:addNotification(player, "Nombre de rango incorrecto", "error")
	end
end
addEvent("facc:nuevo_rango", true)
addEventHandler("facc:nuevo_rango", root, nuevo_rango)

---AÑADIR REGISTRO BANCARIO EN FACCIONES DE TIPO LEGAL---

function depositar( player,money,factionID )
	if tonumber(money) and tonumber(money) > 0 then
		local charMoney = exports.personajes:getCharMoney(player)
		if charMoney >= tonumber(money) then
			dbExec( connection, "UPDATE `facciones` SET `presupuesto`=presupuesto+"..(tonumber(money)).." WHERE `id`="..factionID.."")
			exports.personajes:takeCharMoney(player, tonumber(money))
			local ins = dbQuery( connection, "INSERT INTO registrosfacc (tipo, cantidad, encargado, id_faccion, fecha) VALUES (1,?,?,?,?)", tonumber(money), getPlayerName( player ), tonumber( factionID ), getRealTime().timestamp )
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			outputChatBox("Presupuesto agregado correctamente.", player, 0, 200,0)
		else
			exports.login:addNotification(player, "No tienes suficiente dinero", "error")
		end
	else
		exports.login:addNotification(player, "Cantidad incorrecta", "error")
	end
end
addEvent("facc:depositar", true)
addEventHandler("facc:depositar", root, depositar)

function retirar( player,money,factionID )
	if tonumber(money) and tonumber(money) > 0 then
		local q_f = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", factionID )
		local res = dbPoll( q_f, -1 )
		if res[1].presupuesto >= tonumber(money) then
			dbExec( connection, "UPDATE `facciones` SET `presupuesto`=presupuesto-"..(tonumber(money)).." WHERE `id`="..factionID.."")
			exports.personajes:addCharMoney(player, tonumber(money))
			outputChatBox("Presupuesto retirado correctamente.", player, 0, 200,0)
			
			local ins = dbQuery( connection, "INSERT INTO registrosfacc (tipo, cantidad, encargado, id_faccion, fecha) VALUES (2,?,?,?,?)", tonumber(money), getPlayerName( player ), tonumber( factionID ), getRealTime().timestamp )
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
		else
			exports.login:addNotification(player, "No hay suficiente dinero en la facción", "error")
		end
	else
		exports.login:addNotification(player, "Cantidad incorrecta", "error")
	end
end
addEvent("facc:retirar", true)
addEventHandler("facc:retirar", root, retirar)

function getAllInformes( factionID, name )
	if name then
		local q_faccs = dbQuery( connection, "SELECT * FROM registrosfacc WHERE id_faccion=? AND encargado=? ORDER BY id ASC", tonumber( factionID ), tostring( name ) )
		local faccs = dbPoll( q_faccs, -1 )
		if faccs and #faccs > 0 then
			return faccs
		else
			return false
		end
	else
		local q_faccs = dbQuery( connection, "SELECT * FROM registrosfacc WHERE id_faccion=? ORDER BY id ASC", tonumber( factionID ) )
		local faccs = dbPoll( q_faccs, -1 )
		if faccs and #faccs > 0 then
			return faccs
		else
			return false
		end	
	end
end

facturas = {}
facturas_timers = {}
function hacerFactura( player, cmd, otherPlayer, faccID, amount, ... )
	if otherPlayer and faccID and amount and ... then
		local mensaje = table.concat({ ... }, " ")
		local other, name = exports.login:getNID( player, otherPlayer )
		if isPlayerInFaction(player, faccID) then
			if facturas[other] == nil then
				local percent = getPlayerFactionComision(player, faccID)/100
				facturas[other] = {tonumber(amount), player, percent, faccID,exports.personajes:getCharID(player),mensaje}
				outputChatBox("Has entregado correctamente una factura.", player, 0,200,0)
				outputChatBox("Usa /pagarfactura para pagar la factura de "..amount.." dólares. Se cancela en 10 segundos.", other, 0,200,0)
				facturas_timers[other] = setTimer ( function()
					if facturas[other] ~= nil then
					facturas[other] = nil
					outputChatBox("Se ha cancelado la factura", player, 200,0,0)
					outputChatBox("Se ha cancelado la factura", other, 200,0,0)
					end
				end, 10000, 1 )
			else
				outputChatBox("Esta persona ya tiene una factura pendiente", player, 200,0,0)
			end
		else
			outputChatBox("No perteneces a esta facción", player, 200,0,0)
		end
	else
		outputChatBox("Syntax: /factura [jugador] [ID facción] [cantidad] [concepto]", player, 255,255,255)
	end
end
addCommandHandler('factura', hacerFactura)

function aceptarFactura( player )
	if facturas[player] ~= nil then
		local currentMoney = exports.personajes:getCharMoney(player)
		if currentMoney >= facturas[player][1] then
			local percent = facturas[player][3]
			local com_player = facturas[player][2]
			local for_player = facturas[player][1]*percent
			local for_company = facturas[player][1]-for_player
			if isElement(com_player) then
				exports.personajes:addCharMoney(com_player, tonumber(for_player))
			end
			dbExec( connection, "UPDATE `facciones` SET `presupuesto`=presupuesto+"..(tonumber(for_company)).." WHERE `id`="..facturas[player][4].."")
			exports.personajes:takeCharMoney(player, tonumber(facturas[player][1]))
			outputChatBox("La factura ha sido pagada correctamente.", com_player, 0, 200, 0)
			outputChatBox("Has pagado la factura correctamente.", player, 0, 200, 0)
			local ins = dbQuery( connection, "INSERT INTO facturas (hecha_para,hecha_por,cantidad,motivo,faccion) VALUES (?,?,?,?,?)",exports.personajes:getCharID(player),facturas[player][5],for_company,facturas[player][6],facturas[player][4])
			dbFree(ins)
			facturas[player] = nil
			killTimer(facturas_timers[player])
		else
			outputChatBox("No tienes suficiente dinero para pagar la factura", player, 200,0,0)
		end
	end
end
addCommandHandler("pagarfactura", aceptarFactura)

function verfacciones( player )
	local factions = getPlayerFaction(player)
	outputChatBox(toJSON(factions),player,255,255,255)
end
addCommandHandler("verfaccs", verfacciones)

function getFactionPresupuesto( faccID )
	local q = dbQuery( connection, "SELECT presupuesto FROM facciones WHERE id=?", faccID )
	local res = dbPoll( q, -1 )	
	if res and res[1].presupuesto then
		return tonumber( res[1].presupuesto )
	else
		return false
	end
end

function setFactionPresupuesto( faccID, nuevo )
	local q = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", faccID )
	local res = dbPoll( q, -1 )	
	if res and #res > 0 then
		if dbExec( connection, "UPDATE facciones SET presupuesto=? WHERE id=?", tonumber(nuevo), faccID ) then
			return true
		else
			return false
		end	
	else
		return false
	end
end

function removeFactionPresupuesto( faccID, cantidad )
	local q = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", faccID )
	local res = dbPoll( q, -1 )	
	if res and #res > 0 then
		if res[1].presupuesto >= cantidad then
			local npres = res[1].presupuesto - cantidad
			if dbExec( connection, "UPDATE facciones SET presupuesto=? WHERE id=?", tonumber(npres), faccID ) then
				return true
			else
				return false
			end	
		else
			return false
		end
	else
		return false
	end
end

function addFactionPresupuesto( faccID, mas )
	local q = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", faccID )
	local res = dbPoll( q, -1 )	
	if res and #res > 0 then
		local actual = res[1].presupuesto
		local nuevo = actual + tonumber( mas )
		if dbExec( connection, "UPDATE facciones SET presupuesto=? WHERE id=?", tonumber(nuevo), faccID ) then
			return true
		else
			return false
		end	
	else
		return false
	end
end

function pagarSueldos()
	local q1 = dbQuery( connection, "SELECT * FROM facciones ORDER BY id ASC")
	local f = dbPoll( q1, -1 )
	for i,faccion in ipairs(f) do
		local q2 = dbQuery( connection, "SELECT * FROM pjs_en_facciones WHERE id_faccion=?", faccion.id)
		local pjs = dbPoll( q2, -1 )
		for j,pj in ipairs(pjs) do
			if pj.sueldo > 0 then
			local reduccion = pj.sueldo - faccion.subvencion
			dbExec( connection, "UPDATE `facciones` SET `presupuesto`=presupuesto-"..tonumber(reduccion).." WHERE `id`="..faccion.id)
			local ins = dbQuery( connection, "INSERT INTO pagos_facciones (character_id,faction_id,amount) VALUES (?,?,?)",pj.id_personaje,pj.id_faccion,pj.sueldo)
			dbFree(ins)
			end
		end
	end
end
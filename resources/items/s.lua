connection = exports.mysql:connect()

numactual = {}

inventarios = {}

function cargarItems( player )
	if getElementData( player, "isLoged" ) then
		local playerid = exports.personajes:getCharID(player)
		local query = dbQuery( connection, "SELECT * FROM inventarios WHERE personajeID=?", playerid )
		local data = dbPoll( query, -1 )
		if data[1] ~= nil then
			inventarios[player] = {
				{playerid, true},--1
				fromJSON(data[1].rap1),--rap1 2
				fromJSON(data[1].rap2),--rap2 3
				fromJSON(data[1].rap3),--rap3 4
				fromJSON(data[1].rap4),--rap4 5
				fromJSON(data[1].pecho),--pecho 6
				fromJSON(data[1].espalda),--espalda 7
				fromJSON(data[1].bols1),--bol1 8
				fromJSON(data[1].bols2),--bol2 9
				fromJSON(data[1].bols3),--bol3 10
				fromJSON(data[1].bols4)--bol4 11
			}
			triggerClientEvent(player, "pasar:inv", player, inventarios[player])
		else
			inventarios[player] = {
				{playerid, false},
				{0,0},--rap1
				{0,0},--rap2
				{0,0},--rap3
				{0,0},--rap4
				{0,0},--pecho
				{0,0},--espalda
				{0,0},--bol1
				{0,0},--bol2
				{0,0},--bol3
				{0,0}--bol4
			}
			triggerClientEvent(player, "pasar:inv", player, inventarios[player])
		end
		bindKey(player, 'i', 'down', toggleinv)
		toggleControl ( player, 'next_weapon', false )
		toggleControl ( player, 'previous_weapon', false )
	end
end
--Abrir inv--
function toggleinv(player)
	triggerClientEvent(player,'open:inve', player)
	exports.toys:mostrar_panel_recipientes(player)
end

function updateInv(player, content)
	inventarios[player] = content
end
addEvent("inv:update", true)
addEventHandler("inv:update", root, updateInv)


addEventHandler( "onResourceStart", resourceRoot,
	function()
		setTimer( function()
        for i, players in ipairs(getElementsByType("player")) do
        	if getElementData(players, "isLoged") then
				cargarItems( players )
				bindKey(players, 'i', 'down', toggleinv)
				toggleControl ( players, 'next_weapon', false )
				toggleControl ( players, 'previous_weapon', false )
       		end
        end
		end, 2500, 1 )
	end
)

---guardar datos--

addEventHandler( "onResourceStop", resourceRoot,
    function( resource )
        for i, players in ipairs(getElementsByType("player")) do
        	if getElementData(players, "isLoged") then
				savePlayerItems(players)
       		end
        end
   end
)
function quitarArma( player, weaponID )
	takeWeapon(player, tonumber(weaponID))
end
addEvent("quitar:arma",true)
addEventHandler("quitar:arma",root,quitarArma)
function quitPlayer ( quitType )
	if getElementData(source, "isLoged") then
	savePlayerItems(source)
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

function savePlayerItems( player )
	local inv = inventarios[player]
	if inv[1][2] == false then
		local ins = dbQuery( connection, "INSERT INTO inventarios (personajeID,rap1,rap2,rap3,rap4,pecho,espalda,bols1,bols2,bols3,bols4) VALUES (?,?,?,?,?,?,?,?,?,?,?)",inv[1][1],toJSON(inv[2]),toJSON(inv[3]),toJSON(inv[4]),toJSON(inv[5]),toJSON(inv[6]),toJSON(inv[7]),toJSON(inv[8]),toJSON(inv[9]),toJSON(inv[10]),toJSON(inv[11]))
		dbFree(ins)
	else
		dbExec( connection, "UPDATE `inventarios` SET `rap1`=?,`rap2`=?,`rap3`=?,`rap4`=?,`pecho`=?,`espalda`=?,`bols1`=?,`bols2`=?,`bols3`=?,`bols4`=? WHERE `personajeID`="..inv[1][1].."",toJSON(inv[2]),toJSON(inv[3]),toJSON(inv[4]),toJSON(inv[5]),toJSON(inv[6]),toJSON(inv[7]),toJSON(inv[8]),toJSON(inv[9]),toJSON(inv[10]),toJSON(inv[11]))
	end
	inventarios[player] = nil
end
--Bind update--

function updateBind ( res )
	for i, players in ipairs(getElementsByType("player")) do
    	if getElementData(players, "isLoged") then
    	bindKey(players, 'i', 'down', toggleinv)
    	toggleControl ( players, 'next_weapon', false )
		toggleControl ( players, 'previous_weapon', false )
   		end
    end
end
addEventHandler ( "onResourceStart", resourceRoot, updateBind )

--asignar item seleccionado--
function asignar_item_seleccionado(player, item, previo, datanew, dataprevio )
	if previo ~= 0 and dataprevio.itype == "arma" then
		for i, players in ipairs ( getElementsByType("player") ) do
			triggerClientEvent(players, "removeShader", players, player,"tazer")
		end
		if getElementData(player, "tazer") then
			removeElementData(player, "tazer")
		end
		takeAllWeapons ( player )
	end

	if item ~= 0 and datanew.itype == "arma" and not exports.toys:tieneRecipiente(player, "mano") then
		if datanew.value == "taser" then
			setElementData(player, "tazer",true)
			for i, players in ipairs ( getElementsByType("player") ) do
				triggerClientEvent(players, "aplyShader", players, player,"tazer")
			end
			giveWeapon(player, 24, item[2], true)
		else
			for i, players in ipairs ( getElementsByType("player") ) do
				triggerClientEvent(players, "removeShader", players, player,"tazer")
			end
			giveWeapon(player, datanew.value, item[2], true)
		end
	end
end
addEvent("asignar:item", true)
addEventHandler("asignar:item", root, asignar_item_seleccionado)

--usefull
armaspesadas = {30}
function esArmaPesada( itemID )
	for i=1, #armaspesadas do
		if armaspesadas[i] == itemID then
			return true
		end
	end
	return false
end
function tienehueco(player, itemID)
	if esArmaPesada(itemID) then -- armas pesadas que van solo en pecho y espalda
		if inventarios[player][6][1] == 0 then
			return 6
		elseif inventarios[player][7][1] == 0 then
			return 7
		else
			return false
		end
	else
		for i=2, 11 do
			if inventarios[player][i][1] == 0 then
				return i
			end
		end
		return false
	end
end

function itemHas( player, itemID, slot )
	if slot then
		for i, hueco in pairs(inventarios[player]) do
			if hueco[1] == itemID and hueco[2] == tonumber(slot) then
				return i
			end
		end
		return false
	else
		for i, hueco in pairs(inventarios[player]) do
			if hueco[1] == itemID then
				return i
			end
		end
		return false
	end
end

function deleteItem( player, itemID, slot )
	if slot then
		triggerClientEvent(player, 'inv:delete', player, itemID, slot)
	else
		triggerClientEvent(player, 'inv:delete', player, itemID)
	end
end

function darItem( player, itemID, slot )
	triggerClientEvent(player, 'inv:give', player, itemID, slot)
end

--USOS--

function usarItem( player, itemID, slot, tipo )
	if itemID == 12 then--llaves de vehículo
		if exports.vehiculos:usarLlaves(player, slot) then
			local x,y,z = getElementPosition(player)
			local interior = getElementInterior(player)
			local dimension = getElementDimension(player)
			for i, players in ipairs(getElementsByType("player")) do
				local x1,y1,z1 = getElementPosition(players)
				if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 20 then
					triggerClientEvent(players, "item:sonido", players, itemID, x,y,z, interior, dimension)
				end
			end
		end
		setTimer ( function()
		triggerClientEvent(player, "item:usado", player)
		end, 200, 1 )
	elseif itemID == 13 then--Llaves de propiedad
		exports.interiores:usarLlaves(player, slot)
	elseif itemID == 16 then
		if not numactual[ player ] then
			numactual[ player ] = tonumber( slot )
			outputChatBox( "Estás utilizando ahora "..slot.." como número.", player, 0, 255, 0 )
			outputChatBox( "/sms [numero] [mensaje] para enviar un mensaje.", player, 0, 150, 0 )
			outputChatBox( "/llamar [numero] para llamar a un numero.", player, 0, 150, 0 )
		else
			numactual[ player ] = nil
			outputChatBox( "Has dejado de utilizar este numero.", player, 255, 0, 0 )
		end
	elseif itemID == 17 then
		if not numactual[ player ] then
			numactual[ player ] = tonumber( slot )
			outputChatBox( "Estás utilizando ahora "..slot.." como número.", player, 0, 255, 0 )
			outputChatBox( "/sms [numero] [mensaje] para enviar un mensaje.", player, 0, 150, 0 )
			outputChatBox( "/llamar [numero] para llamar a un numero.", player, 0, 150, 0 )
		else
			outputChatBox( "Has dejado de utilizar este numero.", player, 255, 0, 0 )
		end
	elseif tipo == "comida" then
		if getElementData(player, "comiendo") or getElementData(player, "hambre") >= 100 then
			setElementHealth(player, getElementHealth(player)-5)
			exports.chatsystem:sendame(player, "Empieza a vomitar por haber comido muy rápido")
			setPedAnimation(player, "food", "eat_vomit_p", 3000, false, false, false, false)
			triggerClientEvent(player, "item:usado", player)
		else
			setElementData(player, "comiendo",true)
			exports.chatsystem:sendame(player, "Empieza a comer algo")
			setPedAnimation(player, "food", "eat_burger", 3000, false, false, false, false)
			if getElementData(player, "hambre") <= 80 then
				setElementData(player, "hambre", getElementData(player, "hambre") + 20)
			else
				setElementData(player, "hambre", 100)
			end
			triggerClientEvent(player, "item:usado", player)
			setTimer ( function()
			removeElementData(player, "comiendo")
			end, 3000, 1 )
		end
      elseif itemID == 44 then
						if not getElementData(source, "muerto") then
							setPedAnimation( source, "gangs", "smkcig_prtl", true, true, true, false)
						end
			exports.chatsystem:sendame(player, "saca un cigarro de marihuana y empieza a fumarlo")
						triggerClientEvent ( source, "droga.marihuana", source )

	elseif tipo == "bebida" then
		setElementData(player, "comiendo",true)
		exports.chatsystem:sendame(player, "Empieza a beber algo")
		setPedAnimation(player, "bar", "dnk_stndm_loop", 3000, false, false, false, false)
		if getElementData(player, "sed") <= 80 then
			setElementData(player, "sed", getElementData(player, "sed") + 20)
		else
			setElementData(player, "sed", 100)
		end
		triggerClientEvent(player, "item:usado", player)
		setTimer ( function()
		removeElementData(player, "comiendo")
		end, 3000, 1 )
	end
	triggerClientEvent(player, "item:usado", player)
end
addEvent("usar:item", true)
addEventHandler("usar:item", root, usarItem)

function entregar( player, other, item )
	if tienehueco(other, item[1]) then
		local x,y,z = getElementPosition(player)
		local x2,y2,z2 = getElementPosition(other)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 3 then
			deleteItem(player, item[1], item[2])
			darItem(other, item[1], item[2])
			exports.chatsystem:sendame(player, "Le entrega algo a "..string.gsub(getPlayerName(other),"_"," "))
			outputChatBox(string.gsub(getPlayerName(player),"_"," ").." te ha entregado un item.", other, 0,200,0)
			outputServerLog ( "[ITEM] "..string.gsub(getPlayerName(player),"_"," ").." le ha dado itemID "..item[1].." a "..string.gsub(getPlayerName(other),"_"," ") ) 
			
		end
	end
end
addEvent("entregar:item",true)
addEventHandler("entregar:item", root, entregar)
function existeNumeroMovil( numero )
	local query = dbQuery( connection, "SELECT * FROM phones WHERE phone=?", numero )
	local data = dbPoll( query, -1 )
	if data[1] ~= nil then
		return true
	end
	return false
end

avisos = {}
llamadas = {}

function getAvisos( facc )
	if avisos[ facc ] then
		return avisos[ facc ]
	else
		return false
	end
end

function removeAviso( facc, id )
	if avisos[ facc ] then
		if avisos[facc][id] then
			avisos[facc][id] = nil
			return true
		else
			return false
		end
	else
		return false
	end
end

function llamarMovil( player, cmd, othernumber, ... )
if getElementData(player, "isLoged") then
	number = numactual[ player ]
	if tonumber(number) and tonumber(othernumber) then
		if itemHas(player, 16, tonumber(number)) or itemHas(player, 17, tonumber(number)) then
			if not llamadas[player] then
				if existeNumeroMovil(tonumber(othernumber)) then
					for i,other in ipairs(getElementsByType("player")) do
						if getElementData(other, "isLoged") and inventarios[other] ~= nil then
							if itemHas(other, 16, tonumber(othernumber)) or itemHas(other, 17, tonumber(othernumber)) then
								if llamadas[other] ~= nil then
									outputChatBox("Esta línea se encuentra ocupada o fuera de cobertura.",player,200,0,0)
								else
									llamadas[player] = {
										salida = other,
										contacto = player,
										estado = "comunicando"
									}
									llamadas[other] = {
										salida = player,
										contacto = other,
										estado = "esperando"
									}
									outputChatBox("Llamando...",player, 255,200,0)
									outputChatBox("Tienes una llamada entrante del número #"..number..". Usa /contestar para coger el teléfono.",other,255,200,0)
									setTimer ( function()
										if llamadas[player] ~= nil and llamadas[player].estado == "comunicando" then
											outputChatBox("El número al que has llamado no responde ...",player ,200,0,0)
											llamadas[player] = nil
											if isElement(other) then
												llamadas[other] = nil
												outputChatBox("La llamada se ha cortado.",other ,200,0,0)
											end
										end
									end, 10000, 1 )
								end
								break
							end
						end
					end
				elseif tonumber(othernumber) == 911 then
					local mensaje = table.concat( { ... }, " " )
					if mensaje and #mensaje > 5 then
						local x, y, z = getElementPosition( player )
						if not avisos[2] then
							avisos[2] = {}
						end
						for i,v in ipairs(getElementsByType("player")) do
							local factions = exports.facciones:getPlayerFaction(v)
							if factions then
								if factions[1] == 2 or factions[2] == 2 then
									outputChatBox("Nueva llamada al 911 de #"..number..". Usa /avisos para atender la llamada.",v,255,100,0)
									outputChatBox( "Situación: "..mensaje, v, 255, 100, 0 )
								end
							end
						end
						outputChatBox("Has dejado una llamada en el buzón de la Policía.",player, 255,200,0)
						table.insert( avisos[2], { getPlayerName( player ):gsub( "_", " " ), mensaje, { x, y, z }, number } )
					else
						outputChatBox( "Centralita: Por favor, especifica una situación. ( /llamar 911 situacion )", player, 255, 200, 0 )
					end
				elseif tonumber(othernumber) == 111 then
					for i,v in ipairs(getElementsByType("player")) do
						local factions = exports.facciones:getPlayerFaction(v)
						if factions then
							if factions[1] == 3 or factions[2] == 3 then
								outputChatBox("Nueva solicitud de #"..number,v,255,100,0)
							end
						end
					end
					outputChatBox("Has dejado una llamada en el buzón de la central de taxis.",player, 255,200,0)
				elseif tonumber(othernumber) == 990 then
					for i,v in ipairs(getElementsByType("player")) do
						local factions = exports.facciones:getPlayerFaction(v)
						if factions then
							if factions[1] == 1 or factions[2] == 1 then
								outputChatBox("Nueva emergencia de #"..number,v,255,100,0)
							end
						end
					end
					outputChatBox("Has dejado una llamada en el buzón del hospital.",player, 255,200,0)
				else
					outputChatBox("El número al que has llamado no responde ...",player ,200,0,0)
				end
			else
				exports.login:addNotification(player, "Ya estás en una llamada","error")
			end
		end
	else
		if not numactual[ player ] then
			outputChatBox( "No tienes un número asignado.", player, 255, 0, 0 )
			outputChatBox( "Recuerda, ponte el telefono en la mano y dale click derecho para asignarte su numero y poder llamar o enviar mensajes.", player, 255, 255, 255 )
		else
			outputChatBox("Syntax: /llamar [otronumero]",player,255,255,255)
		end
	end
end
end
addCommandHandler("llamar",llamarMovil)

function sms( player, cmd, otronumero, ... )
	if getElementData( player, "isLoged" ) then
		local numero, otronumero = numactual[player], tonumber( otronumero )
		if otronumero then
			local query = dbQuery( connection, "SELECT * FROM phones WHERE phone=? AND activo=1", otronumero )
			local data = dbPoll( query, -1 )
			if data and data[1] ~= nil then
				local mensaje = table.concat( { ... }, " " )
				if mensaje and #mensaje > 5 then
					local ins = dbQuery( connection, "INSERT INTO sms (telefono,mensaje,destino) VALUES (?,?,?)", numero, mensaje, otronumero )
					dbFree(ins)
					outputChatBox( "SMS enviado a "..otronumero..".", player, 255, 200, 0 )
					local players = getElementsByType( 'player' )
					for i=1, #players do 
						local v = players[i]
						if v and getElementData( v, "isLoged" ) and ( itemHas( v, 16, otronumero ) or itemHas( v, 17, otronumero ) ) then
							outputChatBox( "Has recibido 1 sms de "..numero.." (/mensajes).", v, 255, 200, 0 )
						end
					end
				else
					outputChatBox( "Se requieren 5 caracteres mínimo para el mensaje.", player, 255, 150, 0 )
				end
			else
				outputChatBox( "Compañía telefónica: No existe este número en nuestra base de datos.", player, 255, 200, 0 )
			end
		else
			outputChatBox( "Syntax: /"..cmd.." [numero de destino] [mensaje]", player, 255, 255, 255 )
		end
	end
end
addCommandHandler( "sms", sms )

function deleteMensaje( player, cmd, id )
	if getElementData( player, "isLoged" ) then
		local numero = numactual[ player ]
		local id = tonumber( id )
		if numero and ( itemHas( player, 16, numero ) or itemHas( player, 17, numero ) ) then
			local query = dbQuery( connection, "SELECT * FROM sms WHERE destino=? AND id=?", numero, id )
			local data = dbPoll( query, -1 )			
			if data and data[1] ~= nil then
				if dbExec( connection, "DELETE FROM sms WHERE id=?", id ) then
					outputChatBox( "Mensaje "..id.." eliminado del teléfono.", player, 0, 200, 0 )
				end
			else
				outputChatBox( "Fallo al leer el mensaje.", player, 255, 0, 0 )
			end
		else
			if not numero then
				outputChatBox( "No tienes un número asignado. Ponte el teléfono en la mano y dale click derecho para asignártelo.", player, 255, 200, 0 )
			else
				outputChatBox( "Syntax: /"..cmd.." [id del mensaje (puedes ver las ids con /mensajes [tu telefono])]", player, 255, 255, 255 )
			end
		end
	end	
end
addCommandHandler( "borrarsms", deleteMensaje )

function leerMensaje( player, cmd, id )
	if getElementData( player, "isLoged" ) then
		local numero = numactual[ player ]
		local id = tonumber( id )
		if numero and ( itemHas( player, 16, numero ) or itemHas( player, 17, numero ) ) then
			local query = dbQuery( connection, "SELECT * FROM sms WHERE destino=? AND id=?", numero, id )
			local data = dbPoll( query, -1 )			
			if data and data[1] ~= nil then
				outputChatBox( "SMS de "..data[1].telefono.." (/borrarsms "..id.." para borrarlo):", player, 255, 200, 0 )
				outputChatBox( data[1].mensaje, player, 200, 200, 200 )
			else
				outputChatBox( "Fallo al leer el mensaje.", player, 255, 0, 0 )
			end
		else
			if not numero then
				outputChatBox( "No tienes un número asignado. Ponte el teléfono en la mano y dale click derecho para asignártelo.", player, 255, 200, 0 )
			else
				outputChatBox( "Syntax: /"..cmd.." [id del mensaje (puedes ver las ids con /mensajes [tu telefono])]", player, 255, 255, 255 )
			end
		end
	end	
end
addCommandHandler( "versms", leerMensaje )

function verMensajes( player, cmd )
	if getElementData( player, "isLoged" ) then
		local numero = numactual[ player ]
		if numero and ( itemHas( player, 16, numero ) or itemHas( player, 17, numero ) ) then
			outputChatBox( "Tu lista de mensajes: ", player, 255, 255, 0 )
			local query = dbQuery( connection, "SELECT * FROM sms WHERE destino=?", numero )
			local data = dbPoll( query, -1 )			
			if data and #data > 0 then
				for i=1, #data do 
					local v = data[i]
					local id, tel = v.id, v.telefono
					outputChatBox( "     ["..id.."] De: "..tel.." (/versms "..numero.." "..id.." para verlo)", player, 255, 255, 255 )
				end
			else
				outputChatBox( "     La lista está vacía.", player, 255, 255, 255 )
			end
		else
			if not numero then
				outputChatBox( "No tienes un número asignado. Ponte el teléfono en la mano y dale click derecho para asignártelo.", player, 255, 200, 0 )
			else
				outputChatBox( "Syntax: /"..cmd.."", player, 255, 255, 255 )
			end
		end
	end	
end
addCommandHandler( "mensajes", verMensajes )

addCommandHandler( "servicios",
	function( player, cmd )
		if getElementData( player, "isLoged" ) then
			outputChatBox( "---- Lista de servicios de Countryside ----", player, 255, 255, 0 )
			outputChatBox( "     - Taxistas: 111", player, 255, 255, 255 )
			outputChatBox( "     - Hospital: 990", player, 255, 255, 255 )
			outputChatBox( "     - Policía: 911", player, 255, 255, 255 )
		end
	end
)

function cogerLlamada( player )
if getElementData(player, "isLoged") then
	if llamadas[player] ~= nil then
		if llamadas[player].estado == "esperando" then
			if isElement(llamadas[player].salida) then
				outputChatBox("Has respondido a la llamada, usa /p para hablar por el teléfono.",player, 255,200,0)
				outputChatBox("La otra persona ha contestado a tu llamada, usa /p para hablar por teléfono.", llamadas[player].salida,255,200,0)
				llamadas[player].estado = "hablando"
				llamadas[llamadas[player].salida].estado = "hablando"
			end
		end
	end
end
end
addCommandHandler("contestar",cogerLlamada)

function hablarPorTelefono( player, cmd, ... )
if getElementData(player, "isLoged") then
	if llamadas[player] ~= nil and llamadas[player].estado == "hablando" then
	if ... then
		if isElement(llamadas[player].salida) then
			if llamadas[llamadas[player].salida].estado == "hablando" then
				local mensaje = table.concat({...}," ")
				for i,v in ipairs(getElementsByType("player")) do
					local x1,y1,z1 = getElementPosition(v)
					local posX,posY,posZ = getElementPosition(player)
					local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
					if distance <= 5 and getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
					outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por teléfono: "..mensaje.."", v, 200,200,200,false )
					elseif distance <= 10 and distance > 5 and getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
					outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por teléfono: "..mensaje.."", v, 150,150,150,false )
					elseif distance <= 15 and distance > 10 and getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
					outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por teléfono: "..mensaje.."", v, 100,100,100,false )
					elseif distance <=20 and distance > 15 and getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
					outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por teléfono: "..mensaje.."", v, 50,50,50,false )
					end
				end
				outputChatBox("[Teléfono]: "..mensaje,llamadas[player].salida,255,204,255)
				outputServerLog(string.gsub(getPlayerName(player),"_"," ").." dice por teléfono:"..mensaje)
			else
				outputChatBox("Se ha cortado la llamada.",player, 200,0,0)
				outputChatBox("Se ha cortado la llamada.",llamadas[player].salida, 200,0,0)
				llamadas[player] = nil
				llamadas[llamadas[player].salida] = nil
			end
		else
			outputChatBox("Se ha cortado la llamada.",player, 200,0,0)
			llamadas[player] = nil
		end
	else
		outputChatBox("Syntax: /p [mensaje]",player,255,255,255)
	end
	end
end
end
addCommandHandler("p", hablarPorTelefono)



function colgarLlamada( player )
if getElementData(player, "isLoged") then
	if llamadas[player] ~= nil then
		if llamadas[player].estado == "comunicando" or llamadas[player].estado == "hablando" then
			outputChatBox("Llamada colgada.",player,200,0,0)
			if isElement(llamadas[player].salida) then
				outputChatBox("Llamada colgada.",llamadas[player].salida,200,0,0)
				llamadas[llamadas[player].salida] = nil
			end
			llamadas[player] = nil
		end
	end
end
end
addCommandHandler("colgar",colgarLlamada)
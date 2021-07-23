local connection = exports.mysql:connect()

function mouseS(player,key,state)
	showCursor(player, not isCursorShowing(player))
end

local stats = {
[ 69 ] = 500,
[ 70 ] = 999,
[ 71 ] = 999,
[ 72 ] = 999,
[ 73 ] = 500,
[ 74 ] = 999,
[ 75 ] = 500,
[ 76 ] = 999,
[ 77 ] = 999,
[ 78 ] = 999,
[ 79 ] = 999,
}

addEventHandler( "onPlayerChangeNick", root,
	function( )
		if getElementData(source, "isLoged") then
			cancelEvent( )
		end
	end
)

addEvent('onCharacterLogin')
addEvent('onCharacterLogout')

function existeDatoEnPersonaje(dato, tipo)
	local q = dbQuery( connection, "SELECT * FROM personajes ORDER BY ID ASC" )
	local pjs = dbPoll( q, -1 )
	for i, pj in ipairs(pjs) do
		if tipo == "dni" then
			if pj.dni == dato then
				return true
			end
		elseif tipo == "nombre" then
			if pj.nombre == dato then
				return true
			end
		end
	end
	return false
end


function iniciarCertificacionS (player, p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
	triggerClientEvent(player, "panel:certificacion", player, p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
end

function checkPCU( player, aprobado )
	if aprobado then
		dbExec(connection, "UPDATE `cuentas` SET `pcu`=? WHERE `ID`=?",1,exports.login:getUserID(player))
		exports.login:addNotification(player, "Has aprobado el proceso de certificación.", "success")
		iniciarSeleccion (player, exports.login:getUserID(player))
	else
		dbExec(connection, "UPDATE `cuentas` SET `p1`=?,`p2`=?,`p3`=?,`p4`=?,`p5`=?,`p6`=?,`p7`=?,`p8`=?,`p9`=?,`p10`=? WHERE `ID`=?",math.random(1,5),math.random(1,5),math.random(1,5),math.random(1,5),math.random(1,5),math.random(1,5),math.random(1,5),math.random(1,5),math.random(1,5),math.random(1,5),exports.login:getUserID(player))
		kickPlayer(player, "No has aprobado el test, vuelve a intentarlo.")
	end
end
addEvent('pj:pcu', true)
addEventHandler('pj:pcu', root, checkPCU)

function iniciarSeleccion (player, userid)
	local q = dbQuery( connection, "SELECT * FROM personajes WHERE userID=?", userid )
	local data = dbPoll( q, -1 )
	local t = getRealTime()
	triggerClientEvent(player, "panel:seleccion", player,data,t.timestamp )
end

function checkPJ(player, nombre,edad,altura,dni)
	if existeDatoEnPersonaje(dni, "dni") then
		exports.login:addNotification(player, "Ya existe un personaje con este número de DNI, por favor, usa otro.", "error")
	elseif existeDatoEnPersonaje(string.gsub(nombre, " ", "_"), "nombre") then
		exports.login:addNotification(player, "Ya existe un personaje con este nombre.", "error")
	else
		triggerClientEvent(player, "pj:personalizacion", player)
	end
end
addEvent("check:pj", true)
addEventHandler("check:pj", root, checkPJ)


function crearPersonaje(player, nombre,edad,altura,dni,sexo,skin,cabeza,ropa1,ropa2,ropa3,raza,fit,fat)
	if existeDatoEnPersonaje(dni, "dni") then
		exports.login:addNotification(player, "Has tardado demasiado en crear tu personaje y han registrado uno con el mismo DNI. Pulsa cancelar.", "error")
	elseif existeDatoEnPersonaje(string.gsub(nombre, " ", "_"), "nombre") then
		exports.login:addNotification(player, "Has tardado demasiado en crear tu personaje y han registrado uno con el mismo nombre. Pulsa cancelar.", "error")
	else
		if sexo == "hombre" then
		local ins = dbQuery( connection, "INSERT INTO personajes (userID,nombre,skin,dni,edad,altura,cabeza,raza,ropa1,ropa2,ropa3,fitness,fatness,estilocaminar,licencias,puntos_coche) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",exports.login:getUserID(player), string.gsub(nombre, " ", "_"), skin, dni, edad, altura,cabeza,raza,ropa1,ropa2,ropa3,fit,fat,'118','0','0')
		local result, num_affected_rows, ID = dbPoll ( ins, -1 )
		exports.login:addNotification(player, "Personaje creado correctamente, serás dirigido al selector.", "success")
		local q = dbQuery( connection, "SELECT * FROM personajes WHERE userID=?", exports.login:getUserID(player) )
		local data = dbPoll( q, -1 )
		triggerClientEvent(player, "creado:exito", player, data)
		else
		local ins = dbQuery( connection, "INSERT INTO personajes (userID,nombre,skin,dni,edad,altura,estilocaminar,licencias,puntos_coche) VALUES (?,?,?,?,?,?,?,?,?)",exports.login:getUserID(player), string.gsub(nombre, " ", "_"), skin, dni, edad, altura,'129','0','0')
		local result, num_affected_rows, ID = dbPoll ( ins, -1 )
		exports.login:addNotification(player, "Personaje creado correctamente, serás dirigido al selector.", "success")
		local q = dbQuery( connection, "SELECT * FROM personajes WHERE userID=?", exports.login:getUserID(player) )
		local data = dbPoll( q, -1 )
		triggerClientEvent(player, "creado:exito", player, data)
		end
	end
end
addEvent("crear:pj", true)
addEventHandler("crear:pj", root, crearPersonaje)

personajes = {}
function spawnPJ(player, data)
	setElementData(player, "isLoged", true)
	setElementData(player, "yo", data.yo)
	setElementData(player, "pcu", data.EP)
	setElementData(player, "farmeado", data.farmeado)
	setElementData(player, "trabajo", data.job)
	setElementData(player, "licencias", data.licencias)
	setElementData(player, "puntos_coche", data.puntos_coche)
	fadeCamera(player, true, 3)
	spawnPlayer ( player, data.x, data.y, data.z, data.rot, data.skin, data.interior, data.dimension )
	setElementDimension(player, data.dimension)
	setElementInterior(player, data.interior)
	setCameraTarget(player)
	setPlayerName(player, data.nombre)
	setElementHealth(player, data.vida)
	setPedArmor(player, data.chaleco)
	outputChatBox("Estás jugando como "..string.gsub(data.nombre, "_", " ")..".",player,255,255,255)
	personajes[player] = {
		id = data.ID,
		userid = data.userID,
		nombre = data.nombre,
		edad = data.edad,
		altura = data.altura,
		dinero = data.dinero,
		timestamp = data.timestamp,
		dni = data.dni,
		ck = data.ck,
		cabezaid = data.cabeza,
		ropa1 = data.ropa1,
		ropa2 = data.ropa2,
		ropa3 = data.ropa3,
		raza = data.raza,
		fitness = data.fitness,
		fatness = data.fatness,
		timerhambre = nil,
		timersed = nil,
		timercansancio = nil,
	}
	for k, v in pairs(stats) do 
		setPedStat( player, k, v )
	end
	setPlayerMoney(player, data.dinero)
	setElementData(player, "hambre", data.hambre)
	setElementData(player, "sed", data.sed)
	setElementData(player, "cansancio", data.cansancio)
	if data.skin == 0 then
	setPedHeadless(player, true)
	setPedStat ( player, 21, data.fatness )
	setPedStat ( player, 23, data.fitness )
	exports.items:cargarItems(player)
	exports.cabezas:cargarCabeza(player, data.cabeza)
	exports.clothes:cargarRopa(player, data.ropa1, data.ropa2, data.ropa3, data.raza)
	setPedWalkingStyle(player, data.estilocaminar)
	else
	exports.items:cargarItems(player)
	exports.cabezas:cargarCabeza(player, false)
	exports.clothes:cargarRopa(player, false, false, false, false)
	setPedWalkingStyle(player, data.estilocaminar)
	end
	exports.toys:loadRecipientes(player)
	 -- setPedFightingStyle ( player, data.fightstyle ) 
-- HUD características --
	setPlayerHudComponentVisible(player, "radar", true)
	setPlayerHudComponentVisible(player, "crosshair", true)
-- BINDS --
	bindKey(player, "m", "down", mouseS)
	exports.vehiculos:asignarBinds(player)

--- Timers---
	
	personajes[player].timerhambre = setTimer ( function()--timer hambre
	if isElement(player) and getElementData(player, "isLoged") and not getElementData(player, "ajaileado") and not getElementData(player, "arrestado") then
		if getElementData(player, "hambre") > 0 then
		setElementData(player, "hambre", getElementData(player, "hambre") - 1 )
		else
		setElementHealth(player, getElementHealth(player)-5)
		end
	end
	end, 146000, 0 )
	
	personajes[player].timersed = setTimer ( function()--timer sed
	if isElement(player) and getElementData(player, "isLoged") and not getElementData(player, "ajaileado") and not getElementData(player, "arrestado") then
		if getElementData(player, "sed") > 0 then
		setElementData(player, "sed", getElementData(player, "sed") - 1 )
		else
		setElementHealth(player, getElementHealth(player)-5)
		end
	end
	end, 108000, 0 )
	
	personajes[player].timercansancio = setTimer ( function()--timer cansancio
	if isElement(player) and getElementData(player, "isLoged") and not getElementData(player, "ajaileado") and not getElementData(player, "arrestado") then
		if getElementData(player, "cansancio") > 0 then
		--setElementData(player, "cansancio", getElementData(player, "cansancio") - 1 )
		else
		setElementHealth(player, getElementHealth(player)-5)
		end
	end
	end, 292000, 0 )

--aplicar sanciones--
	local jdata = dbQuery( connection, "SELECT * FROM jails WHERE personaje_id=?", personajes[player].id )
	local jails = dbPoll( jdata, -1 )
	for i,v in ipairs(jails) do
		if v.tipo == 0 then
			setElementData(player, "arrestado", {tonumber(v.created_at),tonumber(v.updated_at), tonumber(v.tiempo)})
		end
		if v.tipo == 1 then
			setElementData(player, "ajaileado", {tonumber(v.created_at),tonumber(v.updated_at), tonumber(v.tiempo)})
			setElementPosition(player,405.30859375, 2462.9736328125, 16.5)
		end
	end
end
addEvent("pj:spawn",true)
addEventHandler("pj:spawn", root, spawnPJ)

function savePlayer(player)
	if personajes[player] then
	
	if isPedDead(player) then
	setElementHealth(player, 0)
	setPedArmor(player, 0)
	end
	
	local t = getRealTime()
	local x,y,z = getElementPosition(player)
	local rx,ry,rz=getElementRotation(player)
	local data = getPlayerRopaData(player)
	local q = "UPDATE `personajes` SET `ropa1`=?,`ropa2`=?,`ropa3`=?,`skin`=?,`dni`=?,`vida`=?,`chaleco`=?,`dinero`=?,`ck`=?,`timestamp`=?,`x`=?,`y`=?,`z`=?,`rot`=?,`interior`=?,`dimension`=?, `hambre`=?, `sed`=?, `cansancio`=?, `farmeado`=?, `job`=?, `licencias`=?, `puntos_coche`=? WHERE `ID`="..(personajes[player].id)..""
	dbExec( connection,q ,data.ropa1, data.ropa2, data.ropa3,getElementModel(player), personajes[player].dni,getElementHealth(player),getPedArmor(player),personajes[player].dinero,personajes[player].ck, t.timestamp,x,y,z,rz,getElementInterior(player),getElementDimension(player),getElementData(player, "hambre"),getElementData(player,"sed"),getElementData(player,"cansancio"),getElementData(player,"farmeado"),getElementData(player, "trabajo"), getElementData(player,"licencias"), getElementData(player,"puntos_coche") )
	if getElementData(player, "ajaileado") or getElementData(player, "arrestado") then
		local jail = getElementData(player, "ajaileado")
		dbExec(connection, "UPDATE `jails` SET `updated_at`=? WHERE `personaje_id`="..(personajes[player].id).."",tonumber(jail[2]))
	end

	personajes[player] = nil


	end
end

function actualizarRopa( player, ropaID, tipo )
	if getElementModel(player) == 0 then
		if tipo == 0 then
			personajes[player].ropa1 = tonumber(ropaID)
		elseif tipo == 2 then
			personajes[player].ropa2 = tonumber(ropaID)
		elseif tipo == 3 then
			personajes[player].ropa3 = tonumber(ropaID)
		end
		local data = getPlayerRopaData(player)
		exports.clothes:cargarRopa(player, data.ropa1, data.ropa2, data.ropa3, data.raza)
	end
end

function quitPlayer ( quitType )
	if personajes[source] then
	killTimer ( personajes[source].timerhambre )
	killTimer ( personajes[source].timersed )
	killTimer ( personajes[source].timercansancio )
	savePlayer(source)

	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

addEventHandler( "onResourceStop", resourceRoot,
    function( resource )
        for i, players in ipairs (getElementsByType("player")) do
			if personajes[players] then
			savePlayer(players)
			end
		end
   end
)

function asignMouse ( res )
	for i, players in ipairs (getElementsByType("player")) do
		if getElementData(players, "isLoged") then
			bindKey(players, "m", "down", mouseS)
		end
	end
end
addEventHandler ( "onResourceStart", resourceRoot, asignMouse )

--UTILES--

function getCharID(player)
	if personajes[player] then
	return personajes[player].id
	end
end

function getCabeza(player)
	if personajes[player] then
	return personajes[player].cabezaid
	end
end

function getPlayerRopaData(player)
	if personajes[player] then
		local data = {
			ropa1 = personajes[player].ropa1,
			ropa2 = personajes[player].ropa2,
			ropa3 = personajes[player].ropa3,
			raza = personajes[player].raza
		}
		return data
	end
end

function addCharMoney( player, amount )
	local actualmoney = personajes[player].dinero
	personajes[player].dinero = actualmoney+amount
	setPlayerMoney(player, personajes[player].dinero)
end
function getCharMoney( player )
	return personajes[player].dinero
end
function setCharMoney( player, amount )
	personajes[player].dinero = amount
	setPlayerMoney(player, amount)
end

function takeCharMoney( player, amount )
	local actualmoney = personajes[player].dinero
	if ((actualmoney-amount) <= 0) then
		personajes[player].dinero = 0
		setPlayerMoney(player, 0)
	else
		personajes[player].dinero = actualmoney-amount
		setPlayerMoney(player, personajes[player].dinero)
	end
end
function getCharNameFromID( ID )
	local q = dbQuery( connection, "SELECT nombre FROM personajes WHERE ID=?", ID )
	local data = dbPoll( q, -1 )
	if data[1] ~= nil then
		return data[1].nombre
	else
		return false
	end
end
function getCharIDFromName( ID )
	local q = dbQuery( connection, "SELECT ID FROM personajes WHERE nombre=?", ID )
	local data = dbPoll( q, -1 )
	if data[1] ~= nil then
		return data[1].ID
	else
		return false
	end
end
function getCharLastConnection( ID )
	local t = getRealTime()
	local q = dbQuery( connection, "SELECT timestamp FROM personajes WHERE ID=?", ID )
	local data = dbPoll( q, -1 )
	local seconds = t.timestamp - data[1].timestamp
	for p, players in ipairs (getElementsByType("player")) do
		if getCharID(players) == ID then
			return "conectado"
		end
	end
	return seconds
end
function getCharDNI( player )
	return personajes[player].dni
end
function hasRopa( player, ropaID )
	local q = dbQuery( connection, "SELECT ropa_id FROM ropas_compradas WHERE personaje_id=?", getCharID(player) )
	local data = dbPoll( q, -1 )
	local existe = false
	for i, d in ipairs(data) do
		if d.ropa_id == tonumber(ropaID) then
			existe = true
			break
		end
	end

	return existe
end

function darPrenda( player, ropaID )
	if not hasRopa(player, ropaID) then
		local ins = dbQuery( connection, "INSERT INTO ropas_compradas (personaje_id, ropa_id) VALUES (?,?)",getCharID(player), ropaID)
		dbFree(ins)
	end
end

--respawn

local respawnDelay = tonumber( get( 'respawn_delay' ) ) or 180
local wastedTimes = { }

addEventHandler( "onResourceStart", resourceRoot,
	function( )
		-- clients need this setting
		setElementData( source, "respawnDelay", respawnDelay )
	end
)

addEventHandler( "onPlayerWasted", root,
	function( )
		-- save when the player died to avoid anyone bypassing our delay
		wastedTimes[ source ] = getTickCount( )
	end
)

addEventHandler( "onPlayerQuit", root,
	function( )
		wastedTimes[ source ] = nil
	end
)

addEvent( "onPlayerRespawn", true )
addEventHandler( "onPlayerRespawn", root,
	function( )
		if source == client then
			-- we only want players who're actually dead and logged in
			if getElementData( source, "isLoged" ) and isPedDead( source ) then
				-- check if we can already respawn
				if wastedTimes[ source ] and getTickCount( ) - wastedTimes[ source ] >= respawnDelay * 1000 then
					-- hide the screen
					fadeCamera( source, false, 1 )
					
					-- spawn him at the hospital
					setTimer(
						function( source )
							if isElement( source ) and getElementData( source, "isLoged" ) and isPedDead( source ) then

								if getElementModel(source) == 0 then
									--1048.9755859375, -313.3125, 76.503540039062
									if getElementData(source, "arrestado") then
										spawnPlayer ( source, 1048.9755859375, -313.3125, 76.503540039062, 0, 0, 0,0 )
									else
										spawnPlayer ( source, 2033.556640625, -1408.3623046875, 17.1640625, 0, 0, 0,0 )
									end
									setElementData(source, "sed", 100)
									setElementData(source, "cansancio", 100)
									setElementData(source, "hambre", 100)
									setPedHeadless(source, true)
									fadeCamera( source, true )
									setCameraTarget( source, source )
									setCameraInterior( source, 0 )
									exports.clothes:cargarRopa(source, personajes[source].ropa1, personajes[source].ropa2, personajes[source].ropa3, personajes[source].raza)
								else
									if getElementData(source, "arrestado") then
										spawnPlayer ( source, 1048.9755859375, -313.3125, 76.503540039062, 0, getElementModel(source), 0,0 )
									else
										spawnPlayer ( source, 2033.556640625, -1408.3623046875, 17.1640625, 0, getElementModel(source), 0,0 )
									end
									setElementData(source, "sed", 100)
									setElementData(source, "cansancio", 100)
									setElementData(source, "hambre", 100)
									fadeCamera( source, true )
									setCameraTarget( source, source )
									setCameraInterior( source, 0 )
									exports.clothes:cargarRopa(source, false, false, false, false)
								end
								
							end
						end,
						1200,
						1,
						source
					)
					
					-- reset the wasted time counter
					wastedTimes[ source ] = nil
				end
			end
		end
	end
)
---- comandos elementales

function pay(player, cmd, otherPlayer, cantidad)
	if otherPlayer and cantidad then
		if tonumber(cantidad) and tonumber(cantidad) > 0 then
			local other, name = exports.login:getNID( player, otherPlayer )
			if other ~= player then
			local x,y,z = getElementPosition(player)
			local x2,y2,z2 = getElementPosition(other)
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 3 then
			local am = getCharMoney(player)
				if am >= tonumber(cantidad) then
					takeCharMoney(player, tonumber(cantidad))
					addCharMoney(other, tonumber(cantidad))
					outputChatBox("Le has dado $"..tonumber(cantidad).." a "..string.gsub(getPlayerName(other),"_"," "),player,0,200,0)
					outputChatBox(string.gsub(getPlayerName(player),"_"," ").." te ha dado $"..tonumber(cantidad),other,0,200,0)
					outputServerLog ( "[$$] "..string.gsub(getPlayerName(player),"_"," ").." le ha dado "..cantidad.." dólares a "..string.gsub(getPlayerName(other),"_"," ") ) 
				else
					outputChatBox("No tienes tanto dinero.",player,200,0,0)
				end
			else
				outputChatBox("Este jugador está demasiado lejos.",player,200,0,0)
			end
			else
				outputChatBox("No puedes darte dinero a ti mismo.",player,200,0,0)
			end
		else
			outputChatBox("Debes introducir una cantidad numérica mayor que 0.",player,200,0,0)
		end
	else
		outputChatBox( "Command: /" .. cmd .. " [Jugador/ID] [cantidad]", player, 255, 255, 255 )
	end
end
addCommandHandler("pagar", pay)

function mostrarDNI( player, cmd, otherPlayer )
	if otherPlayer then
		local other, name = exports.login:getNID( player, otherPlayer )
		local x,y,z = getElementPosition(player)
		local x1,y1,z1 = getElementPosition(other)
		if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) <= 3 then
		exports.chatsystem:sendame(player, "Le muestra su D.N.I a "..string.gsub(getPlayerName(other), "_"," "))
		outputChatBox("D.N.I de "..string.gsub(getPlayerName(player), "_", " "),other,255,255,255)
		outputChatBox("------------------------------------------------------",other,255,255,255)
		outputChatBox("Nº "..getCharDNI(player),other,255,255,255)
		outputChatBox("------------------------------------------------------",other,255,255,255)
		end
	else
		outputChatBox( "Command: /" .. cmd .. " [Jugador/ID]", player, 255, 255, 255 )
	end
end
addCommandHandler("dni", mostrarDNI)
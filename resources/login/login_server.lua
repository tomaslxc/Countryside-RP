local connection = exports.mysql:connect()

function addNotification(player, text, type)
	if (player and text and type) then
		triggerClientEvent(player, 'addNotification', player, text, type);
	end
end

cuentasLogeadas = {}

cuentas = {} -- creamos una tabla donde el indice será el elemento player y tendrá la información de esa cuenta

function isAccountLogged(id)
	for i, players in ipairs (getElementsByType("player")) do
		if cuentas[players] then
			if cuentas[players].userid == id then
			return true
			end
		end
	end
	return false
end

function quitPlayer ( quitType )
	if cuentas[source] then
		table.remove(cuentasLogeadas, username)
		cuentas[source] = nil
	end
end
addEventHandler ( "onPlayerQuit", root, quitPlayer )

--[[ 
staff:
1- tester
2- ayudante
3- mod
4- go
5- admin
6- director
]]--

function loginPlayer(player, username, password ) -- voy a comprobar que desde el panel se envía todo bien 
	local q = dbQuery( connection, "SELECT * FROM cuentas WHERE username=? and password=?", username, md5(password) )
	local data = dbPoll( q, -1 )
	if data[1] ~= nil then -- si encuentra data[1] quiere decir que existe la cuenta en la base de datos
		if data[1].ban == 1 then
			addNotification(player, "Esta cuenta está baneada.", "error")
		else
			if not isAccountLogged(data[1].ID) then
				if data[1].pcu == 0 then
					cuentas[player] = {
					userid = data[1].ID,
					account = username,
					pass = password
					}
					table.insert(cuentasLogeadas, username)
					addNotification(player, "Has iniciado sesión, debes completar el proceso de certificación.", "success")
					triggerClientEvent("belepesfunkctsiker", player)
					exports.personajes:iniciarCertificacionS(player,data[1].p1, data[1].p2, data[1].p3, data[1].p4, data[1].p5, data[1].p6, data[1].p7, data[1].p8, data[1].p9, data[1].p10)
					setElementData(player, "staff", data[1].staff)
					if data[1].staff == 6 then
						local account = getAccount(username, password)
						if account then
						logIn(player, account, password)
						else
						addAccount(username, password)
						local account = getAccount(username, password)
						logIn(player, account, password)
						end
					end
				else
					cuentas[player] = {
					userid = data[1].ID,
					account = username,
					pass = password
					}
					table.insert(cuentasLogeadas, username)
					addNotification(player, "[Iniciando sesión] Serás dirigido a la selección de personajes.", "success")
					setElementData(player, "staff", data[1].staff)
					if data[1].staff == 6 then
						local account = getAccount(username, password)
						if account then
						logIn(player, account, password)
						else
						addAccount(username, password)
						local account = getAccount(username, password)
						logIn(player, account, password)
						end
					end

						triggerClientEvent("belepesfunkctsiker", player)
						--aqui salta al panel de seleccion de pj
						exports.personajes:iniciarSeleccion(player, data[1].ID)

				end
			else
				addNotification(player, "Esta cuenta ya está logeada.", "error")
			end
		end
	else
		addNotification(player, "Esta cuenta no existe.", "error")
	end
end
addEvent("attemptLogin", true)
addEventHandler("attemptLogin", getRootElement(), loginPlayer)

function getUserID(player)
	if cuentas[player] then
		return cuentas[player].userid
	end
end


function registerPlayer(player, username, password, correo)
	local q = dbQuery( connection, "SELECT * FROM cuentas WHERE username=? and password=?", username, md5(password) )
	local cuenta = dbPoll( q, -1 )
	
	local q2 = dbQuery( connection, "SELECT * FROM cuentas WHERE serial=?", getPlayerSerial(player) )
	local cuentaSerial = dbPoll( q2, -1 )
	
	if #cuentaSerial < 2 then
		if cuenta[1] ~= nil then
			addNotification(player, "Ya existe una cuenta con ese nombre de usuario.", "error")
		else
			local p1= math.random(1,5)
			local p2= math.random(1,5)
			local p3= math.random(1,5)
			local p4= math.random(1,5)
			local p5= math.random(1,5)
			local p6= math.random(1,5)
			local p7= math.random(1,5)
			local p8= math.random(1,5)
			local p9= math.random(1,5)
			local p10= math.random(1,5)
			local ins = dbQuery( connection, "INSERT INTO cuentas (username,password,correo,pcu,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,serial,ip) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",username, md5(password), correo, 0, p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,getPlayerSerial(player),getPlayerIP(player))
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			addNotification(player, "Has registrado la cuenta correctamente, ya puedes iniciar sesión.", "success")
		end
	else
	addNotification(player, "No pueden haber tantas cuentas por serial.", "error")
	end
end
addEvent("attemptRegister", true)
addEventHandler("attemptRegister", getRootElement(), registerPlayer) -- en teoría nos hemos logeado, voy a reconectar para probar que funciona

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
    
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
    
    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end
    
    return timestamp
end

addEventHandler("onPlayerCommand", root,
function(cmd)
     if cmd == "logout" then
          cancelEvent()
     elseif cmd == "register" then
          cancelEvent()
	     elseif cmd == "login" then
          cancelEvent()
		 
     end
end)



local ids = { } -- el script de LOGIN asigna tmbn la ID temporal que sale en el scoreboard

addEventHandler( "onPlayerJoin", root,
	function( )
		for i = 1, getMaxPlayers( ) do
			if not ids[ i ] then
				ids[ i ] = source
				setElementData( source, "playerid", i )
				
				break
			end
		end
	end
)

addEventHandler( "onResourceStart", resourceRoot,
	function( )
		for i, source in ipairs( getElementsByType( "player" ) ) do
			ids[ i ] = source
			setElementData( source, "playerid", i )
		end
	end
)

addEventHandler( "onPlayerQuit", root,
	function( type, reason, responsible )
		for i = 1, getMaxPlayers( ) do
			if ids[ i ] == source then
				ids[ i ] = nil
				
				if reason then
					type = type .. " - " .. reason
					if isElement( responsible ) and getElementType( responsible ) == "player" then
						type = type .. " - " .. getPlayerName( responsible )
					end
				end
				
				break
			end
		end
	end
)
function getPlayerFromNombre(n)
	for i, players in ipairs (getElementsByType("player")) do
		if getPlayerName(players) == n then
		return players
		end
	end
end
function getNID( player, targetName )--pendiente de modificar!!
	if targetName then
		targetName = tostring( targetName )
		
		local match = { }
		if targetName == "*" then
			match = { player }
		elseif tonumber( targetName ) then
			match = { ids[ tonumber( targetName ) ] }
		elseif ( getPlayerFromNombre ( targetName ) ) then
			match = { getPlayerFromNombre ( targetName ) }
		else	
			for key, value in ipairs ( getElementsByType ( "player" ) ) do
				if	getPlayerName(value) and getPlayerName(value):lower():find( targetName:lower() ) then
					match[ #match + 1 ] = value
				end
			end
		end
		
		if #match == 1 then
			if getElementData(match[ 1 ], "isLoged") then
				return match[ 1 ], getPlayerName(match[ 1 ]), getElementData( match[ 1 ], "playerid" )
			else
				if player then
					outputChatBox( getPlayerName( match[ 1 ] ).. " no está logeado.", player, 255, 0, 0 )
				end
				return nil
			end
		elseif #match == 0 then
			if player then
				outputChatBox( "Ningún jugador coincide con tu búsqueda.", player, 255, 0, 0 )
			end
			return nil 
		elseif #match > 10 then
			if player then
				outputChatBox( #match .. " jugadores coinciden con tu búsqueda.", player, 255, 204, 0 )
			end
			return nil
		else
			if player then
				outputChatBox ( "Jugadores que coinciden con tu búsqueda: ", player, 255, 204, 0 )
				for key, value in ipairs( match ) do
					outputChatBox( "  [" .. getElementData( value, "playerid" ) .. "] " .. string.gsub(getPlayerName(value), "_", " "), player, 255, 255, 0 )
				end
			end
			return nil 
		end
	end
end
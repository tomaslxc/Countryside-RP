local connection = exports.mysql:connect()

addCommandHandler( "avisos",
	function( player )
		if getElementData( player, "isLoged" ) then
			local factions = exports.facciones:getPlayerFaction(player)
			if factions[1] == 2 or factions[2] == 2 then
				local tablaavisos = exports.items:getAvisos(2)
				if tablaavisos and #tablaavisos > 0 then
					triggerClientEvent( player, "avisos:abrir", player, tablaavisos )
				else
					outputChatBox( "No hay avisos registrados en el sistema.", player, 255, 0, 0 )
				end
			end
		end
	end
)

addCommandHandler( "pda",
	function( player )
		if getElementData( player, "isLoged" ) then
			local factions = exports.facciones:getPlayerFaction(player)
			if factions[1] == 2 or factions[2] == 2 then
				triggerClientEvent( player, "pda:abrir", player )
			end
		end
	end
)

function getDatosArmeria( )
	local query = dbQuery( connection, "SELECT * FROM registro_armeria" )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		return data
	else
		return {}
	end	
end

function getDatosArmeriaOfID( name_arma )
	local query = dbQuery( connection, "SELECT * FROM registro_armeria WHERE nombre_arma = '"..tostring(name_arma).."'" )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		return data
	else
		return {}
	end	
end

addEvent( "armeria:guardararma", true )
addEventHandler( "armeria:guardararma", getRootElement(),
	function( nombrearma, idarma )
		local tiene_item = exports.items:itemHas( source,  tonumber(idarma) )
		if tiene_item then
			local ins = dbQuery( connection, "INSERT INTO registro_armeria (agente,nombre_arma,fecha,tipo) VALUES (?,?,?,?)", getPlayerName(source), tostring(nombrearma), getRealTime().timestamp, '2' )
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			if result then
				exports.items:deleteItem( source, tonumber(idarma) )
				outputChatBox( "Has guardado satisfactoriamente el arma de la armeria.", source, 0, 255, 0 )
				triggerClientEvent( source, "armeria:actualizarDatos", source, getDatosArmeria() )
			else
				outputChatBox( "(( Error con la base de datos ))", source )
			end
			dbFree(ins)
		else
			outputChatBox( "No tienes ese arma en el inventario.", source, 255, 0, 0 )
		end
	end
)

addEvent( "armeria:sacarArma", true )
addEventHandler( "armeria:sacarArma", getRootElement(),
	function( nombrearma, idarma )
		local ins = dbQuery( connection, "INSERT INTO registro_armeria (agente,nombre_arma,fecha,tipo) VALUES (?,?,?,?)", getPlayerName(source), tostring(nombrearma), getRealTime().timestamp, '1' )
		local result, num_affected_rows, ID = dbPoll ( ins, -1 )
		if result then
			exports.items:darItem( source, tonumber(idarma) )
			outputChatBox( "Has sacado satisfactoriamente el arma de la armeria. Recuerda devolverla.", source, 0, 255, 0 )
			triggerClientEvent( source, "armeria:actualizarDatos", source, getDatosArmeria() )
		else
			outputChatBox( "(( Error con la base de datos ))", source )
		end
		dbFree(ins)
	end
)

addEvent( "armeria:getRegistroArmeria", true )
addEventHandler( "armeria:getRegistroArmeria", getRootElement(),
	function( nombrearma )
		triggerClientEvent( source, "armeria:actualizarDatos", source, getDatosArmeriaOfID( nombrearma ) )
	end
)

addEvent( "pda:getPropiedades", true )
addEventHandler( "pda:getPropiedades", getRootElement(),
	function( nombre )
		triggerClientEvent( source, "pda:recibirPropiedades", source, exports.interiores:getCharacterPropiedades( nombre ) )
	end
)

function getTiempoRetirada( charid )
	local query = dbQuery( connection, "SELECT tiempo FROM licencias_retiradas WHERE idchar=?", tonumber( charid ) )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		return data[1].tiempo
	else
		return false
	end
end

function getRegistroPresos( name )
	local query = dbQuery( connection, "SELECT * FROM registropresos WHERE idchar=?", tonumber( exports.personajes:getCharIDFromName( name ) ) )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		return data
	else
		return {}
	end
end

function solicitarMultasVeh( player, idveh )
	local query = dbQuery( connection, "SELECT * FROM multas WHERE vehiculo=1 AND idveh=?", tonumber( idveh ) )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		local multasenviar = {}
		for i=1, #data do 
			if data[i].pagada == 0 then
				table.insert( multasenviar, data[i] )
			end
		end
		triggerClientEvent( player, "pda:givemultasveh", player, multasenviar )
	else
		triggerClientEvent( player, "pda:givemultasveh", player, {} )
	end
end
addEvent( "pda:solicitarMultasVeh", true )
addEventHandler( "pda:solicitarMultasVeh", getRootElement(), solicitarMultasVeh )

addEvent( "pda:getRegistroArrestos", true )
addEventHandler( "pda:getRegistroArrestos", getRootElement(),
	function( name )
		triggerClientEvent( source, "pda:givedatosarrestos", source, getRegistroPresos( name ) )
	end
)

addEvent( "pda:getPropietarioFromMatricula", true )
addEventHandler( "pda:getPropietarioFromMatricula", getRootElement(),
	function( matricula )
		triggerClientEvent( source, "pda:givedatospropietario", source, exports.vehiculos:getPropietarioFromMatricula( tostring(matricula) ) )
	end
)

addEvent( "pda:getVehiculosFromName", true )
addEventHandler( "pda:getVehiculosFromName", getRootElement(),
	function( name )
		triggerClientEvent( source, "pda:givevehiculos", source, exports.vehiculos:getVehiculosFromName( tostring(name) ) )
	end
)

addCommandHandler( "retirarpuntos",
	function( player, cmd, idotro, puntos )
		if getElementData( player, "isLoged" ) then
			local factions = exports.facciones:getPlayerFaction(player)
			if factions[1] == 2 or factions[2] == 2 then
				local other, name = exports.login:getNID( player, idotro )
				local puntos = tonumber( puntos )
				if other and puntos then
					local sus_puntos = getElementData( other, "puntos_coche" )
					if sus_puntos == 0 then
						outputChatBox( "El jugador no tiene puntos en el carnet.", player, 255, 0, 0 )
					else
						if puntos >= sus_puntos then

							local hasta = getRealTime().timestamp + ((86400)*14)
							outputChatBox( "El jugador "..name.." se ha quedado sin puntos. Se le ha retirado el carnet temporalmente.", player, 255, 150, 0 )
							outputChatBox( "Se te ha retirado el carnet de conducir al tener 0 puntos.", other, 255, 0, 0 )
							outputChatBox( "No podrás sacarte el carnet de nuevo hasta: "..os.date( "%d-%m-%Y %H:%M", hasta ), other, 255, 0, 0 )
							
							if not getTiempoRetirada( exports.personajes:getCharID( other ) ) then
								local ins = dbQuery( connection, "INSERT INTO licencias_retiradas (idchar,tiempo) VALUES (?,?)", exports.personajes:getCharID(other), tonumber( hasta )  )
								local result, num_affected_rows, ID = dbPoll ( ins, -1 )
								dbFree ( ins )							
							else
								dbExec( connection, "UPDATE licencias_retiradas SET tiempo=? WHERE idchar=?", tonumber( hasta ), exports.personajes:getCharID(other) )
							end
							
							setElementData( other, "puntos_coche", 0 )
							setElementData( other, "licencias", 3 )
						else
							setElementData( other, "puntos_coche", tonumber( sus_puntos - puntos ) )
							outputChatBox( "Le has retirado "..puntos.." a "..name, player, 0, 255, 0 )
							outputChatBox( "El agente "..getPlayerName(player):gsub("_"," ").." te ha retirado "..puntos.." puntos del carnet.", other, 255, 0, 0 )
						end
					end
				else
					outputChatBox( "Syntax: /"..cmd.." [id] [a retirar]", player, 255, 255, 255 )
				end
			end			
		end		
	end
)

--[[function cambioPuntos(theKey, oldValue, newValue)
    if (getElementType(source) == "player") then
		if (theKey == "licencias") and (newValue == 0) then
			local hasta = getRealTime().timestamp + ((86400)*14)
			setElementData( source, "licencias", 0 )
			outputChatBox( "Se te ha retirado el carnet de conducir al tener 0 puntos.", source, 255, 0, 0 )
			outputChatBox( "No podrás sacarte el carnet de nuevo hasta: "..os.date( "%d-%m-%Y %H-%M", hasta ), source, 255, 0, 0 )
		end
    end
end
addEventHandler("onElementDataChange", root, cambioPuntos)--]]

local blipLocalizar =  {}

addEvent( "aviso:localizar", true )
addEventHandler( "aviso:localizar", getRootElement(),
	function( aviso, id )
		local nombre, mensaje, pos, numero = unpack( aviso )
		local x, y, z = unpack( pos )
		blipLocalizar[ source ] = { 
			blip = createBlip( x, y, z, 0, 2, 0, 255, 0, 255, 0, 99999 ),
			col = createColSphere( x, y, z, 10 ),
		}
		addEventHandler( "onColShapeHit", blipLocalizar[ source ].col, function( player, _ )
			if blipLocalizar[ player ] and source == blipLocalizar[ player ].col then
				if isElement( blipLocalizar[player].blip ) then destroyElement( blipLocalizar[player].blip ) end
				if isElement( blipLocalizar[player].col ) then destroyElement( blipLocalizar[player].col ) end
				outputChatBox( "Has llegado al lugar desde donde se realizó la llamada.", player, 0, 200, 0 )
			end
		end)
		setElementVisibleTo( blipLocalizar[source].blip, root, false )
		setElementVisibleTo( blipLocalizar[source].blip, source, true )
		outputChatBox( "Has atendido el aviso. Número: "..numero..".", source, 0, 255, 0 )
		outputChatBox( "Localizacion: "..getZoneName( x, y, z )..".", source, 0, 255, 0 )
		exports.items:removeAviso( 2, id )
	end
)

function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=1,9 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end

addCommandHandler( "cachear",
	function( player, cmd, id )
		if getElementData( player, "isLoged" ) then
			local other, name = exports.login:getNID( player, id )
			if other then
				local x, y, z = getElementPosition( player )
				if getDistanceBetweenPoints3D( x, y, z, unpack( { getElementPosition( other ) } ) ) < 5 and getElementDimension( other ) == getElementDimension( player ) and getElementInterior(other) == getElementInterior(player) then
					local armas = getPedWeapons( other )
					exports.chatsystem:me( player, "empieza a cachear a "..name )
					outputChatBox( "Dinero que lleva encima: $"..getPlayerMoney(other), player, 0, 255, 0 )
					outputChatBox( "Armas que hayas podido palpar:", player, 255, 255, 0 )
					for i=81, 121 do 
						if exports.items:itemHas( other, i ) then
							local name = exports.items:getItemNameFromID( i )
							if name then
								outputChatBox( "    - Lleva "..name, player, 255, 255, 255 )
							else
								outputChatBox( "    -Lleva ?", player, 255, 255, 255 )
							end
						end
					end
					if exports.items:itemHas( other, 14 ) then -- La COLT que no se a quien se le ocurrio ponerle ID bajita.
						outputChatBox( "    - Lleva Colt 45", player, 255, 255, 255 )
					end
				end				
			else
				outputChatBox( "Syntax: /"..cmd.." [id]", player, 255, 255, 255 )
			end
		end
	end
)

addEvent("onAnimationLoadd", true)
addEventHandler("onAnimationLoadd", root, 
function (blockName, animationName)
	local players = getElementsByType("player")
	triggerClientEvent(players, "onAnimationLoadd", client, blockName, animationName)
end)

function quitarcono(player)
	if not isPedInVehicle ( player ) then
	local nombreplayer = getPlayerName(player)
	local factions = exports.facciones:getPlayerFaction(player)
		if factions then
			if factions[1] == 2 or factions[2] == 2 then
			local x,y,z = getElementPosition(player)
			local col = createColSphere ( x, y, z, 1)
			local tObj = getElementsWithinColShape( col, "object" )
				for i,v in ipairs(tObj) do
				destroyElement(col)
					if getElementModel(v) == 1238 then
					destroyElement(v)
					setPedAnimation(player, "bomber", "bom_plant_loop", 3000, false, false, false, false)
					exports.chatsystem:sendame(player, "Se agacha recogiendo el cono del suelo")
					break
					end
				end
			end
		end
	end
end
addCommandHandler('quitarcono',quitarcono)

function cono(player)
	if not isPedInVehicle ( player ) then
	local nombreplayer = getPlayerName(player)
	local factions = exports.facciones:getPlayerFaction(player)
		if factions then
			if factions[1] == 2 or factions[2] == 2 then
				local x,y,z = getElementPosition(player)
				local rx,ry,rz = getElementRotation(player)
				local cono = createObject(1238,x,y,z-0.7,0,0,rz)
				setElementDimension(cono, getElementDimension(player))
				setElementInterior(cono, getElementInterior(player))
				setElementCollisionsEnabled(cono, false)
				setPedAnimation(player, "bomber", "bom_plant_loop", 3000, false, false, false, false)
				exports.chatsystem:sendame(player, "Se agacha y pone un cono en el suelo")
			end
		end
	end
end
addCommandHandler('cono',cono)


function animRender( player )
    setPedAnimationProgress( player, "pass_smoke_in_car", 1.9 )
    setTimer( animRender, 50, 1, player )
end


function esposar(player,cName,otherPlayer)
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 2 or factions[2] == 2 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
				local x,y,z = getElementPosition(other)
				local x2,y2,z2 = getElementPosition(player)
				if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 3 then
					if getElementData(other, "esposado") then
						removeElementData(other, "esposado")
						toggleControl ( other, "sprint", true )
						toggleControl ( other, "fire", true )
						toggleControl ( other, "aim_weapon", true )
						toggleControl ( other, "next_weapon", true )
						toggleControl ( other, "previous_weapon", true )
						toggleControl ( other, "accelerate", true )
						toggleControl ( other, "brake_reverse", true )
						exports.chatsystem:sendame(player, "Le quita las esposas a "..string.gsub(getPlayerName(other), "_", " "))
						setPedAnimation(player, "bd_fire", "wash_up", 3000, false, false, false, false)
						setPedAnimation( other)
						for i, players in ipairs(getElementsByType("player")) do
							local x1,y1,z1 = getElementPosition(players)
							if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 20 then
								triggerClientEvent(players, "ejecutarSonidoPolicia", players, "esposas",x,y,z)
							end
						end
					else
						toggleControl ( other, "sprint", false )
						toggleControl ( other, "fire", false )
						toggleControl ( other, "aim_weapon", false )
						toggleControl ( other, "next_weapon", false )
						toggleControl ( other, "previous_weapon", false )
						toggleControl ( other, "accelerate", false )
						toggleControl ( other, "brake_reverse", false )
						setPedWeaponSlot ( other, 0 )
						setElementData(other, "esposado",true)
						exports.chatsystem:sendame(player, "Le pone las esposas a "..string.gsub(getPlayerName(other), "_", " "))
						setPedAnimation(player, "bd_fire", "wash_up", 3000, false, false, false, false)
						triggerClientEvent(other, "playCuffAnim", other)
						for i, players in ipairs(getElementsByType("player")) do
							local x1,y1,z1 = getElementPosition(players)
							if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 20 then
								triggerClientEvent(players, "ejecutarSonidoPolicia", players, "esposas",x,y,z)
							end
						end
					end
				end
				end
			else
				outputChatBox("Syntax: /esposar [ID/Jugador]",player,255,255,255)
			end
		end
	end
end
addCommandHandler('esposar',esposar)

local ref = {}

function getAllPolicias( )
	local pl = {}
	local players = getElementsByType( 'player' )
	for i=1, #players do 
		local v = players[i]
		local factions = exports.facciones:getPlayerFaction(v)
		if factions[1] == 2 or factions[2] == 2 then
			table.insert( pl, v )
		end
	end
	return pl
end

addCommandHandler( "ref",
	function( player )
		if getElementData( player, "isLoged" ) then
			local factions = exports.facciones:getPlayerFaction(player)
			if factions[1] == 2 or factions[2] == 2 then
				local pacos = getAllPolicias()
				if ref[ player ] then
					if ref[player] then destroyElement( ref[player] ) end
					ref[player] = nil
					outputChatBox( "Has cancelado los refuerzos.", player, 255, 0, 0 )
					for i=1, #pacos do
						if pacos[i] ~= player then
							outputChatBox( "[REFUERZOS] El agente "..getPlayerName( player ):gsub( "_"," " ).." ya no necesita refuerzos.", pacos[i], 255, 0, 0 )
						end
					end
				else
					ref[ player ] = createBlipAttachedTo( player, 0, 2, 255, 0, 0, 255, 0, 65535 )
					zonename = getZoneName( unpack( { getElementPosition( player ) } ) )
					outputChatBox( "Has solicitado refuerzos utilizando la radio.", player, 0, 255, 0 )
					for i=1, #pacos do
						setElementVisibleTo( ref[player], root, false )
						setElementVisibleTo( ref[player], pacos[i], true )
						if pacos[i] ~= player then
							outputChatBox( "[REFUERZOS] El agente "..getPlayerName( player ):gsub( "_"," " ).." necesita refuerzos en "..zonename, pacos[i], 255, 150, 0 )
						end
					end					
				end
			end
		end
	end	
)

function vertiempoarresto( player )
	if getElementData(player, "arrestado") then
		local jail = getElementData(player, "arrestado")
		local minutos = jail[3] + ((jail[1] - jail[2])/60)
		outputChatBox("Te quedan "..math.floor(minutos).." minutos de arresto.",player,200,0,0)
	end
end
addCommandHandler("verarresto",vertiempoarresto)

	setTimer ( function()
		for i,v in ipairs(getElementsByType("player")) do
			local jail = getElementData(v, "arrestado")
			if jail and jail ~= nil then
				local current_t = jail[2]
				local needed_t = jail[1]+(jail[3]*60)
 				if current_t >= needed_t then
					jail = nil
 					removeElementData(v, "arrestado")
 					dbExec(connection,"DELETE FROM jails WHERE personaje_id=?", exports.personajes:getCharID(v))
 					setElementPosition(v, 1015.173828125, -380.435546875, 76.503540039062)
 					setElementDimension(v, 0)
 					setElementInterior(v, 0)
 					outputChatBox("Has sido liberado, espero que hayas aprendido la lección.", v, 0,200,0)
 				end
				if getElementData( v, "arrestado" ) then
					setElementData(v, "arrestado", {jail[1], jail[2]+1, jail[3]})
				end
			end
		end
	end, 1000, 0 )


function arrestar( player, cmd, otherPlayer, tiempo, tipo, ... )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 2 or factions[2] == 2 then
			if otherPlayer then
				if getElementDimension(player) == 252 then--int carcel
					local other, name = exports.login:getNID( player, otherPlayer )
					local query = dbQuery( connection, "SELECT * FROM jails WHERE personaje_id=? AND tipo=?",exports.personajes:getCharID(other),0)
					local data = dbPoll(query, -1)
					if data[1] == nil then
						local tipo = tonumber( tipo )
						if tipo and tipo == 1 or tipo == 2 and tonumber( tiempo ) and ... then
							local motivo = table.concat({...}, " ")
							local ntiempo = ( tipo == 1 and tiempo or (tiempo*1440) )
							local t = getRealTime().timestamp
							local ins = dbQuery( connection, "INSERT INTO jails (personaje_id,tiempo,razon,jaileado_por,created_at) VALUES (?,?,?,?,?)",exports.personajes:getCharID(other), tonumber(ntiempo), motivo, exports.personajes:getCharID(player),tonumber(t))
							local result, num_affected_rows, ID = dbPoll ( ins, -1 )
							outputChatBox("Has arrestado correctamente a "..string.gsub(getPlayerName(other),"_", " "),player,0,200,0)
							outputChatBox("Tiempo:"..tiempo.." "..( tipo == 1 and "minutos" or "días" )..". Razón: "..motivo,player,0,200,0)
							outputChatBox("Has sido arrestado durante "..tiempo.." "..( tipo == 1 and "minutos" or "días" )..". Motivo: "..motivo,other,0,200,0)
							setElementData(other, "arrestado", {tonumber(t),tonumber(t), tonumber(ntiempo)})
							
							local ins = dbQuery( connection, "INSERT INTO registropresos (idchar,tiempo,motivo,fecha,agente) VALUES (?,?,?,?,?)",exports.personajes:getCharID(other), tonumber(ntiempo), motivo, getRealTime().timestamp, getPlayerName( player ) )
							local result, num_affected_rows, ID = dbPoll ( ins, -1 )
						else
							outputChatBox( "El tipo debe ser 1 para minutos o 2 para días.", player, 200, 0, 0 )
						end
					else
						outputChatBox("Esta persona ya está arrestada, devuelvelo a su celda!",player, 200, 0,0)
					end
				else
					outputChatBox("Debes estar en la prisión para arrestar a alguien.", player, 200,0,0)
				end
			else
				outputChatBox("Syntax: /"..cmd.." [ID/Jugador] [Tiempo] [Tipo. 1=minutos, 2=dias] [Razón]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("arrestar", arrestar)

function liberarPreso( player, cmd, otherPlayer )
	local factions = exports.facciones:getPlayerFaction(player)
	if getElementData( player, "isLoged" ) and factions then
		if factions[1] == 2 or factions[2] == 2 or getElementData( player, "staff" ) >= 3 then	
			local other, name = exports.login:getNID( player, otherPlayer )
			if other then
				local query = dbQuery( connection, "SELECT * FROM jails WHERE personaje_id=? AND tipo=?",exports.personajes:getCharID(other),0)
				local data = dbPoll(query, -1)
				if data and #data > 0 then
					dbExec(connection,"DELETE FROM jails WHERE personaje_id=?", exports.personajes:getCharID(other) )
 					removeElementData(other, "arrestado")
 					setElementPosition(other, 1015.173828125, -380.435546875, 76.503540039062)
 					setElementDimension(other, 0)
 					setElementInterior(other, 0)
 					outputChatBox("Has sido liberado por "..getPlayerName(player):gsub("_"," ")..".", other, 0,200,0)
					outputChatBox( "Has liberado a "..name..".", player, 0, 200, 0 )
					outputDebugString( "El staff "..getPlayerName(player).." ha liberado a "..name )
				else
					outputChatBox( "El jugador "..name.." no consta como preso en la base de datos.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id preso]", player, 255, 255, 255 )
			end
		end
	end
end
addCommandHandler( "liberar", liberarPreso )

function ondutypolicia( player )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 2 or factions[2] == 2 then
			if getElementDimension(player) == 383 then
				if not exports.items:itemHas(player, 93) then
					exports.items:darItem(player, 93, 50)
				end
				if not exports.items:itemHas(player, 81) then
					exports.items:darItem(player, 81, 50)
				end
				setPedArmor(player, 100)
				local ropadata = exports.personajes:getPlayerRopaData(player)
				local derecho = exports.facciones:getPlayerFactionRights(player, 0, 2)
				outputChatBox("Ahora estás de servicio.",player,250,200,0)
				if derecho >= 1 then
					exports.personajes:actualizarRopa(player, 116, 0)
					exports.personajes:actualizarRopa(player, 20, 2)
					exports.personajes:actualizarRopa(player, 95, 3)
				else
					exports.personajes:actualizarRopa(player, 117, 0)
					exports.personajes:actualizarRopa(player, 27, 2)
					exports.personajes:actualizarRopa(player, 95, 3)
				end
			end
		end
	end
end
addCommandHandler("servicio",ondutypolicia)

function offdutypolicia( player )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 2 or factions[2] == 2 then
			if getElementDimension(player) == 383 then
				setPedArmor(player, 0)
				if not exports.items:itemHas(player, 93) or not exports.items:itemHas(player, 81) then
					outputChatBox("(( Has salido de servicio sin tus armas, será notificado a la administración ))",player, 255,0,0)
					outputServerLog(getPlayerName(player).." ha dejado el servicio policial sin todas sus armas, quizás está bugeandolas")
				end
				exports.items:deleteItem(player, 93)
				exports.items:deleteItem(player, 81)
				local data = exports.personajes:getPlayerRopaData(player)
				outputChatBox("Ahora ya no estás de servicio.",player,250,200,0)
			end
		end
	end
end
addCommandHandler("dejarservicio",offdutypolicia)

function asignarMulta( player, cmd, otherPlayer, cantidad, ... )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 2 or factions[2] == 2 then
			local other, name = exports.login:getNID( player, otherPlayer )
			if other then
				local motivo = table.concat( { ... }, " " )
				local cantidad = tonumber(cantidad)
				if cantidad and cantidad > 0 then
					if motivo and #motivo > 5 then
						local ins = dbQuery( connection, "INSERT INTO multas (idchar,cantidad,motivo,agente,pagada,fecha) VALUES (?,?,?,?,?,?)", exports.personajes:getCharID( other ), tonumber(cantidad), motivo, getPlayerName( player ), '0', getRealTime().timestamp )
						local result, num_affected_rows, ID = dbPoll ( ins, -1 )						
						if tonumber(ID) then
							outputChatBox( "Has recibido una multa de "..getPlayerName(player):gsub("_"," ")..":", other, 255, 255, 0 )
							outputChatBox( "	- Motivo: "..motivo, other, 255, 255, 255 )
							outputChatBox( "	- Cantidad: "..cantidad.."$", other, 255, 255, 255 )
							outputChatBox( "	- Agente: "..getPlayerName(player):gsub("_"," "), other, 255, 255, 255 )
							outputChatBox( "	- Fecha: "..os.date( "%d-%m-%Y %H:%M", getRealTime().timestamp ), other, 255, 255, 255 )
							
							outputChatBox( "Asignada la multa a "..name.." por "..motivo.." con cantidad "..cantidad.."$.", player, 0, 255, 0 )
						else
							outputChatBox( "Fallo en asignar la multa a "..name, player, 255, 0, 0 )
						end
					else
						outputChatBox( "Debes añadir un motivo de la multa con un mínimo de 5 carácteres.", player, 200, 0, 0 )
					end
				else
					outputChatBox( "Debes asignar una cantidad de $ para poder multar.", player, 255, 0, 0 )
					outputChatBox( "Syntax: /"..cmd.." [id jugador] [cantidad $] [motivo (min 5 caracteres)]", player, 255, 255, 255 )
				end
			end
		end
	end
end
addCommandHandler( "multar", asignarMulta )

function obtenerMultas( player, cmd, otherPlayer )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 2 or factions[2] == 2 then
			local other, name = exports.login:getNID( player, otherPlayer )
			if other then
				local q = dbQuery( connection, "SELECT * FROM multas WHERE idchar=?", exports.personajes:getCharID(other) )
				local data = dbPoll( q, -1 )
				if data and #data > 0 then
					outputChatBox( "Multas de "..name..": ", player, 255, 255, 0 )
					for i=1, #data do 
						local v = data[i]
						if v then
							local motivo, cantidad, agente, pagada = v.motivo, v.cantidad, v.agente, v.pagada
							outputChatBox( "     - Multa "..i..": ", player, 200, 200, 0 )
							outputChatBox( "          - Motivo: "..motivo, player, 255, 255, 255 )
							outputChatBox( "          - Cantidad: "..cantidad.."$", player, 255, 255, 255 )
							outputChatBox( "          - Agente: "..agente, player, 255, 255, 255 )
							outputChatBox( "          - Pagada: "..( pagada == 0 and "No" or "Sí" ), player, 255, 255, 255 )
						end
					end
				else
					outputChatBox( "El jugador "..name.." no tiene multas.", player, 255, 255, 255 )
				end
			end
		end
	end	
end
addCommandHandler( "multas", obtenerMultas )

local colarmeria = createColSphere( -1317.23828125, -551.7724609375, 16.777500152588, 2 )
setElementDimension( colarmeria, 383 )
setElementInterior( colarmeria, 5 )

function abrirArmeria( player, cmd )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 2 or factions[2] == 2 then
			local derechos = exports.facciones:getPlayerFactionRights( player, exports.personajes:getCharID( player ), 2 )
			if derechos >= 1 then
				triggerClientEvent( player, "armeria:abrir", player )
			end
		end
	end	
end
addCommandHandler( "armeria", abrirArmeria )

function aplicartaser( player )
	local x,y,z = getElementPosition(player)
	for i, players in ipairs(getElementsByType("player")) do
		local x1,y1,z1 = getElementPosition(players)
		if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 20 then
			triggerClientEvent(players, "ejecutartaser", players, "taser",x,y,z)
		end
	end
	setElementFrozen(player, true)
	setPedAnimation(player, "crack", "crckidle2", -1, true, true, false)
	setTimer ( function()
		setElementFrozen(player, false)
		setPedAnimation(player)
	end, 10000, 1 )
end
addEvent("aplicar:tazer",true)
addEventHandler("aplicar:tazer", root, aplicartaser)
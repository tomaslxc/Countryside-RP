local tarifas = {

	100, -- Teorico
	100, -- Practico

}

local connection = exports.mysql:connect()

setTimer( function()
	local vehs = getElementsByType( 'vehicle' )
	for i=1, #vehs do 
		if getElementModel( vehs[i] ) == 401 and not getVehicleController ( vehs[i] ) then
			respawnVehicle( vehs[i] )
		end
	end
end, 5*60000, 0 )

function getMultas( charid )
	local query = dbQuery( connection, "SELECT * FROM multas WHERE idchar=? AND pagada=0", tonumber( charid ) )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		return true
	else
		return false
	end
end

function getTiempoRetirada( charid )
	local query = dbQuery( connection, "SELECT tiempo FROM licencias_retiradas WHERE idchar=?", tonumber( charid ) )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		return data[1].tiempo
	else
		return false
	end
end

function crearPedTeorico()
	pedTeorico = createPed( 150, -1437.333984375, -532.994140625, 14.272255897522, -70 )
	setElementInterior( pedTeorico, 112 )
	setElementDimension( pedTeorico, 625 )
	setElementFrozen( pedTeorico, true )
end

function enterVehicle ( player, seat, jacked )
    if ( getElementModel(source) == 401 ) then
		local licencias = getElementData( player, "licencias" )
		if not licencias or licencias == 0 then
			cancelEvent()
			outputChatBox( "(( Aún no puedes realizar el examen práctico. No posees el teórico. ))", player, 255, 150, 0 )
		elseif licencias == 2 then
			cancelEvent()
			outputChatBox( "(( Ya tienes el carnet. No puedes utilizar estos vehículos para uso personal. ))", player, 255, 150, 0 )
		else
			outputChatBox( "-- Comandos y binds de vehículos --", player, 255, 255, 0 )
			outputChatBox( "    - /motor o 1: Encender o apagar el motor del vehículo.", player, 255, 255, 255 )
			outputChatBox( "    - /luces o 2: Encender o apagar las luces del vehículo.", player, 255, 255, 255 )
			outputChatBox( "    - /puertas o 3: Abrir o cerrar el vehículo.", player, 255, 255, 255 )
			outputChatBox( "    - /frenomano o 0: Poner o quitar el freno de mano.", player, 255, 255, 255 )
			outputChatBox( "    - /cinturon: Ponerse o quitarse el cinturón.", player, 255, 255, 255 )
			triggerClientEvent( player, "startPractico", player )
		end
    end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle ) 

addEvent( "teorico:cederNota", true )
addEventHandler( "teorico:cederNota", getRootElement(),
	function( nota )
		if nota == 1 then
			if getPlayerMoney( source ) >= tarifas[1] then
				exports.personajes:takeCharMoney( source, tonumber( tarifas[1] ) )
				outputChatBox( "¡Felicidades! Has obtenido el permiso teórico de conducir. Ahora podrás pasar al práctico por otros "..tarifas[2].."$", source, 0, 255, 0 )
				setElementData( source, "licencias", 1 )
				exports.facciones:addFactionPresupuesto( 5, tonumber( tarifas[1] ) )
				dbExec( connection, "UPDATE `personajes` SET `licencias`=1 WHERE `ID`=?",exports.personajes:getCharID(source))
			else
				outputChatBox( "No tienes dinero suficiente para pagar el exámen teórico ("..tarifas[1].."$)", source, 255, 0, 0 )
			end
		else
			outputChatBox( "Lamentablemente no has podido superar el test teórico.", source, 255, 0, 0 )
		end
	end
)

addEventHandler( "onPedWasted", resourceRoot,
	function( )
		if source == pedTeorico then
			destroyElement( source )
			crearPedTeorico()
		end
	end
)

addEventHandler( "onResourceStart", resourceRoot,
	function()
		crearPedTeorico()
	end
)

function elementClicked( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" and source == pedTeorico then
        if not isPedDead( thePlayer ) and getElementData( thePlayer, "isLoged" ) then
			local licencias = getElementData( thePlayer, "licencias" )
			if not licencias or licencias == 0  then
				triggerClientEvent( thePlayer, "teorico:abrir", thePlayer )
			elseif licencias == 1 then
				outputChatBox( "(( Ya tienes el teórico hecho. Dirígete a un Bravura para hacer el examen práctico. ))", thePlayer, 255, 150, 0 )			
			elseif licencias == 3 then
				local charid = exports.personajes:getCharID( thePlayer ) 
				local tiempo = getTiempoRetirada( charid )
				if tiempo then
					outputChatBox( "No puedes sacarte el carnet hasta el "..os.date( "%d-%m-%Y %H:%M", tiempo ), thePlayer, 255, 0, 0 )
				else
					if not getMultas( charid ) then
						outputChatBox( "Puedes examinarte de nuevo. Ten cuidado esta vez.", thePlayer, 0, 255, 0 )
						triggerClientEvent( thePlayer, "teorico:abrir", thePlayer )
					else
						outputChatBox( "Tienes multas sin pagar. No puedes examinarte.", thePlayer, 255, 0, 0 )
					end
				end
			end
	    end
    end
end
addEventHandler( "onElementClicked", getRootElement(), elementClicked )

addEvent( "practicoTerminar", true )
addEventHandler( "practicoTerminar", getRootElement(),
	function()
		local v = getPedOccupiedVehicle( source )
		if v then
			respawnVehicle( v )
			local health = getElementHealth( v )
			if health >= 300 then
				if getPlayerMoney( source ) >= tarifas[2] then
					exports.personajes:takeCharMoney( source, tonumber( tarifas[2] ) )
					outputChatBox( "Felicidades! Te has sacado con éxito tu exámen práctico.", source, 0, 200, 0 )
					setElementData( source, "licencias", 2 )
					setElementData( source, "puntos_coche", 12 )
					dbExec( connection, "UPDATE `personajes` SET `licencias`=2 WHERE `ID`=?",exports.personajes:getCharID(source))
					exports.facciones:addFactionPresupuesto( 5, tonumber( tarifas[2] ) )
				else
					outputChatBox( "¿No llevas dinero? Pues suspendido...", source, 255, 0, 0 )
				end
			else
				outputChatBox( "Has destrozado el vehículo, burro! Suspendido.", source, 255, 0, 0 )
			end
		else
			outputChatBox( "¿Dónde está el coche? Estás suspendido.", source, 255, 0, 0 )
		end
	end
)

addCommandHandler( "licencias",
	function( player, cmd, otro )
		if getElementData( player, "isLoged" ) then
			local licencia = getElementData( player, "licencias" )
			local puntos = getElementData( player, "puntos_coche" ) or 0
			if licencia then
				local other, name = exports.login:getNID( player, otro )
				if other then
					exports.chatsystem:me( player, "le muestra sus licencias a "..name )
					exports.chatsystem:sendame(player, "Saca y muestra sus licencias")
					outputChatBox("Le has mostrado tus licencias a "..name, player, 0, 200, 0 )
					outputChatBox( "Licencias de vehículos: ", other, 255, 255, 0 )
					if licencia == 3 then
						outputChatBox( "    - Licencia de vehículo retirada.", other, 255, 0, 0 )
					else
						outputChatBox( "    - Teórico: "..( licencia > 0 and "Sí" or "No" ), other, 255, 255, 255 )
						outputChatBox( "    - Práctico: "..( licencia == 2 and "Sí" or "No" ), other, 255, 255, 255 )
						outputChatBox( "    - Puntos: "..puntos, other, 255, 255, 255 )
					end
				end
			else
				outputChatBox( "Fallo con las licencias.", player, 255, 0, 0 )
			end
		end
	end
)
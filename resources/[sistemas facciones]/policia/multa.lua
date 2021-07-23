local connection = exports.mysql:connect()
local botmultas={}

local botsMultas = {

	{
-1314.9248046875, -542.392578125, 16.777500152588, -60, 5, 383}, -- Blueberry
	{1468.43359375, 1308.6923828125, 26.74843788147, 178, 20, 552}, -- Montgomery

}

function crearMultasBot()
        for i,v in ipairs(botsMultas) do
            botmultas[i] = createPed( 141, v[1], v[2], v[3], v[4] )
            setElementInterior( botmultas[i], v[5] )
            setElementDimension( botmultas[i], v[6] )
			addEventHandler( "onElementClicked", botmultas[i], multasclick )
            setElementFrozen( botmultas[i], true )
        end
end
addEventHandler( "onResourceStart", resourceRoot, crearMultasBot) -- Creamos el ped al iniciar el script
addEventHandler( "onPedWasted", getRootElement(), crearMultasBot ) -- Esto para que cuando muera reaparezca el bot

function isPolicia( player )
	local factions = exports.facciones:getPlayerFaction( player )
	if factions then
		if factions[1] == 2 or factions[2] == 2 or getElementData( player, "staff" ) >= 3 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function getOwnerName( id, facc )
	if facc == 1 then
		local query = dbQuery( connection, "SELECT name FROM facciones WHERE id=?", tonumber(facc) )
		local data = dbPoll(query, -1)		
		if data and data[1].name then
			return data[1].name
		else
			return "ERROR"
		end
	else
		return exports.personajes:getCharNameFromID( tonumber(id) )
	end
end

function solicitarMultas( player, idchar )
	local query = dbQuery( connection, "SELECT * FROM multas WHERE idchar=?", tonumber( idchar ) )
	local data = dbPoll(query, -1)	
	if data and #data > 0 then
		local multasenviar = {}
		for i=1, #data do 
			if data[i].pagada == 0 then
				table.insert( multasenviar, data[i] )
			end
		end
		triggerClientEvent( player, "multas:givedatos", player, multasenviar )
	else
		triggerClientEvent( player, "multas:givedatos", player, {} )
	end
end
addEvent( "multas:solicitar", true )
addEventHandler( "multas:solicitar", getRootElement(), solicitarMultas )

addEvent( "pda:solicitarMultas", true )
addEventHandler( "pda:solicitarMultas", getRootElement(),
	function( name )
		local query = dbQuery( connection, "SELECT ID FROM personajes WHERE nombre=?", tostring(name) )
		local data = dbPoll(query, -1)	
		if data and #data > 0 then
			if data[1].ID then
				local query = dbQuery( connection, "SELECT * FROM multas WHERE idchar=?", tonumber( data[1].ID ) )
				local data = dbPoll(query, -1)	
				if data and #data > 0 then
					local multasenviar = {}
					for i=1, #data do 
						if data[i].pagada == 0 then
							table.insert( multasenviar, data[i] )
						end
					end
					triggerClientEvent( source, "pda:givemultas", source, multasenviar )
				else
					outputChatBox( "El ciudadano "..name.." no tiene multas.", source, 0, 255, 0 )
				end				
			else
				outputChatBox( "Fallo con la ID del personaje del jugador.", source, 255, 0, 0 )
			end
		else
			outputChatBox( "Fallo en obtener los datos. Este ciudadano no se encuentra...", source, 255, 0, 0 )
		end
	end
)

function multasclick( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" then -- if left mouse button was pressed down
        local x, y, z = getElementPosition( thePlayer )
        local x2, y2, z2 = getElementPosition( source )
        if getDistanceBetweenPoints3D( x, y, z, x2,y2,z2 ) < 3 and getElementDimension(thePlayer) == getElementDimension(source) and getElementInterior(thePlayer) == getElementInterior(source) then
			local charid = exports.personajes:getCharID( thePlayer )
			if charid then
				triggerClientEvent( thePlayer, "multas:abrirPanel", thePlayer )
				setTimer( function()
					solicitarMultas( thePlayer, tonumber( charid ) )
				end, 100, 1)
			end
        end 
    end
end


addEvent( "multas:pagarMulta", true )
addEventHandler( "multas:pagarMulta", getRootElement(),
	function( datosMulta )
		local charid = exports.personajes:getCharID( source )
		if charid then
			if exports.personajes:getCharMoney( source ) >= tonumber( datosMulta.cantidad ) then
				if dbExec( connection, "UPDATE multas SET pagada=1 WHERE idmulta=?", tonumber( datosMulta.idmulta ) ) then
					exports.personajes:takeCharMoney( source, tonumber( datosMulta.cantidad ) )
					outputChatBox( "Multa de "..tonumber( datosMulta.cantidad ).." pagada con éxito.", source, 0, 255, 0 )
					solicitarMultas( source, tonumber( charid ) )
					exports.facciones:addFactionPresupuesto( 2, tonumber( datosMulta.cantidad ) )
				else
					outputChatBox( "Error con el sistema de multas.", source, 255, 0, 0 )
				end
			else
				outputChatBox( "No tienes suficiente dinero.", source, 255, 0, 0 )
			end
		end
	end
)

addEvent( 'veh:solicitarRegistros', true )
addEventHandler( 'veh:solicitarRegistros', getRootElement(),
	function( veh )
		local query = dbQuery( connection, "SELECT * FROM registrocepo WHERE idveh=?", tonumber( getElementData(veh,"id") ) )
		local data = dbPoll(query, -1)	
		if data and #data > 0 then
			triggerClientEvent( source, "veh:ofrecerRegistroCepo", source, data )
		else
			triggerClientEvent( source, "veh:ofrecerRegistroCepo", source, {} )
		end
	end
)

addEvent( "veh:inmovilizarVeh", true )
addEventHandler( "veh:inmovilizarVeh", getRootElement(),
	function(veh)
		local cepo = getElementData( veh, "cepo" )
		if cepo == 1 then
			if dbExec( connection, "UPDATE vehiculos SET cepo=0 WHERE id=?", tonumber( getElementData( veh, "id" ) ) ) then
				setElementData( veh, "cepo", 0 )
				exports.chatsystem:me( source, "le quita el cepo a el/la "..getVehicleNameFromModel( getElementModel(veh) ) )
				setElementFrozen( veh, false )
				local ins = dbQuery( connection, "INSERT INTO registrocepo (idveh,agente,fecha,tipo) VALUES (?,?,?,?)", tonumber( getElementData( veh, "id" ) ), getPlayerName( source ), getRealTime().timestamp, '0' )
				local result, num_affected_rows, ID = dbPoll ( ins, -1 )
				dbFree ( ins )
			else
				outputChatBox( "Fallo en quitar el cepo al vehículo.", source, 255, 0, 0 )
			end		
		else
			if dbExec( connection, "UPDATE vehiculos SET cepo=1 WHERE id=?", tonumber( getElementData( veh, "id" ) ) ) then
				setElementData( veh, "cepo", 1 )
				exports.chatsystem:me( source, "le coloca un cepo a el/la "..getVehicleNameFromModel( getElementModel(veh) ) )
				setElementFrozen( veh, true )
				local ins = dbQuery( connection, "INSERT INTO registrocepo (idveh,agente,fecha,tipo) VALUES (?,?,?,?)", tonumber( getElementData( veh, "id" ) ), getPlayerName( source ), getRealTime().timestamp, '1' )
				local result, num_affected_rows, ID = dbPoll ( ins, -1 )
				dbFree ( ins )
			else
				outputChatBox( "Fallo en colocar el cepo al vehículo.", source, 255, 0, 0 )
			end
		end
	end
)

addEvent( "veh:colocarMulta", true )
addEventHandler( "veh:colocarMulta", getRootElement(),
	function( veh, cantidad, motivo )
		local query = dbQuery( connection, "SELECT owner FROM vehiculos WHERE id=?", tonumber( getElementData(veh,"id") ) )
		local data = dbPoll(query, -1)		
		if data and data[1].owner then
			local ins = dbQuery( connection, "INSERT INTO multas (idchar,cantidad,motivo,agente,pagada,fecha,vehiculo,idveh) VALUES (?,?,?,?,?,?,?,?)", data[1].owner, tonumber(cantidad), motivo, getPlayerName( source ), '0', getRealTime().timestamp, 1, tonumber( getElementData(veh,"id") ) )
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			if tonumber( ID ) then
				outputChatBox( "Has multado este "..getVehicleNameFromModel( getElementModel(veh) )..".", source, 0, 255, 0 )
				outputChatBox( "Motivo: "..motivo, source, 255, 255, 255 )
				outputChatBox( "Cantidad: "..cantidad.."$", source, 255, 255, 255 )
				exports.chatsystem:me( source, "coloca una multa en el/la "..getVehicleNameFromModel( getElementModel(veh) ) )
			else
				outputChatBox( "Fallo al colocar la multa al jugador.", source, 255, 0, 0 )
			end
		end
	end
)

addEvent( "veh:solicitarDatos", true )
addEventHandler( "veh:solicitarDatos", getRootElement(),
	function( veh )
		local tablaEnviar = {}
		local query = dbQuery( connection, "SELECT * FROM vehiculos WHERE id=?", tonumber( getElementData(veh,"id") ) )
		local data = dbPoll(query, -1)
		if data and #data > 0 then
			tablaEnviar = { getOwnerName( tonumber( data[1].owner ), tonumber( data[1].facc ) ) }
			triggerClientEvent( source, "veh:actualizarDatosVeh", source, tablaEnviar )
		else
			outputChatBox( "Fallo en obtener los datos, sal de ese apartado.", source, 255, 0, 0 )
		end
	end
)

function vehicleInfo( theButton, theState, player )
    if theButton == "left" and theState == "down" and getElementType( source ) == 'vehicle' and getElementData( source, "id" ) and not isPedInVehicle( player ) then
        local x, y, z = getElementPosition( player )
		local vx, vy, vz = getElementPosition( source )
		local int, dim = getElementInterior( source ), getElementDimension( source )
		local intp, dimp = getElementInterior( player ), getElementDimension( player )
		if getDistanceBetweenPoints3D( x, y, z, vx, vy, vz ) < 7 and int == intp and dim == dimp then
			triggerClientEvent( player, "veh:mostrarPanel", player, isPolicia(player), source )
		end
    end
end
addEventHandler( "onElementClicked", getRootElement(), vehicleInfo )
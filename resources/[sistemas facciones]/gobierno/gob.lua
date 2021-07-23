local faccsgob = { 5, 1, 2, 4, 6 }
local connection = exports.mysql:connect()


function getFactionName( factionID )
	local q = dbQuery( connection, "SELECT * FROM facciones WHERE id=?", factionID )
	local rec = dbPoll( q, -1 )
	if rec and #rec > 0 then
		return rec[1].name
	end
end

function getImpuestosSobre( tipo )
	if not tipo then
		local q_info = dbQuery( connection, "SELECT * FROM impuestos ORDER BY id DESC" )
		local res = dbPoll( q_info, -1 )		
		if res and #res > 0 then
			return res
		else
			return false
		end
	else
		local q_info = dbQuery( connection, "SELECT * FROM impuestos WHERE sobre=?", tostring(tipo) )
		local res = dbPoll( q_info, -1 )
		if res and #res > 0 then
			return res
		else
			return false
		end
	end
end

addEvent( "impuestos:getall", true )
addEventHandler( "impuestos:getall", getRootElement(),
	function()
		local tabla = {}
		local all = getImpuestosSobre()
		if all then
			for i=1, #all do 
				table.insert( tabla, all[i] )
			end
		end
		triggerClientEvent( source, "impuestos:topanel", source, tabla )
	end
)

function despedirMiembro( id_otro, factionID )

	local otherName = string.gsub(exports.personajes:getCharNameFromID(id_otro),'_',' ')

	dbExec(connection, "DELETE FROM pjs_en_facciones WHERE id_personaje=? AND id_faccion=?",id_otro,factionID)
	
	outputChatBox( "Has expulsado a "..otherName.." de "..getFactionName( tonumber( factionID ) ), source, 0, 255, 0 )
	outputDebugString( "El miembro del gobierno "..getPlayerName( source ).." ha expulsado a "..otherName.." de "..getFactionName( tonumber( factionID ) ) )

end
addEvent("empresas:expulsar", true)
addEventHandler("empresas:expulsar", getRootElement(), despedirMiembro )

function actualizarListaEmpleados( faccid )
	local faccID = tonumber( faccid )
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
	triggerClientEvent( source, "actualizarEmpleados", source, miembros, rangos )
end
addEvent( "getListaEmpleados", true )
addEventHandler( "getListaEmpleados", getRootElement(), actualizarListaEmpleados )

addEvent( "cambiarSueldo", true )
addEventHandler( "cambiarSueldo", getRootElement(),
	function( idchar, idfacc, sueldo, faccname )
		if dbExec( connection, "UPDATE `pjs_en_facciones` SET `sueldo`="..(tonumber(sueldo)).." WHERE `id_personaje`="..tonumber(idchar).." AND `id_faccion`="..tonumber(idfacc)) then
		
			local nombre = exports.personajes:getCharNameFromID( tonumber( idchar ) )
			outputChatBox( "Cambiado el sueldo de "..nombre.." a "..sueldo.."$ en "..faccname, source, 0, 255, 0 )
		
			local ins = dbQuery( connection, "INSERT INTO registrosueldos (encargado, fecha, sueldo, id_faccion, empleado) VALUES (?,?,?,?,?)", getPlayerName( source ), getRealTime().timestamp, tonumber( sueldo ), tonumber( idfacc ), exports.personajes:getCharNameFromID( tonumber( idchar ) ) )
			local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			
			actualizarListaEmpleados( tonumber( idfacc ) )
		else
			outputChatBox( "Fallo en cambiar el sueldo.", source, 255, 0, 0 )
		end
	end
)

addEvent( "actualizarInformes", true )
addEventHandler( "actualizarInformes", getRootElement(),
	function( faccid, tipo, nombre )
		if tipo == 0 then
			if not nombre then
				local informes = exports.facciones:getAllInformes( tonumber( faccid ) )
				if informes and #informes > 0 then
					triggerClientEvent( source, "informes:actualizar", source, informes )
				else
					outputChatBox( "[Base de datos] No se encuentran informes con esos filtros.", source, 255, 0, 0 )
				end
			else
				local informes = exports.facciones:getAllInformes( tonumber( faccid ), tostring( nombre ) )
				if informes and #informes > 0 then
					triggerClientEvent( source, "informes:actualizar", source, informes )
				else
					outputChatBox( "[Base de datos] No se encuentran informes con esos filtros.", source, 255, 0, 0 )
					triggerClientEvent( source, "informes:actualizar", source, {} )
				end			
			end
		elseif tipo < 3 then
			if not nombre then
				local q_faccs = dbQuery( connection, "SELECT * FROM registrosfacc WHERE id_faccion=? AND tipo=? ORDER BY id ASC", tonumber( faccid ), tonumber( tipo ) )
				local faccs = dbPoll( q_faccs, -1 )
				if faccs and #faccs > 0 then
					triggerClientEvent( source, "informes:actualizar", source, faccs )
				else
					outputChatBox( "[Base de datos] No hay registros con esos filtros en el sistema.", source, 255, 0, 0 )
					triggerClientEvent( source, "informes:actualizar", source, {} )
				end					
			else
				local q_faccs = dbQuery( connection, "SELECT * FROM registrosfacc WHERE id_faccion=? AND tipo=? AND encargado=? ORDER BY id ASC", tonumber( faccid ), tonumber( tipo ), nombre )
				local faccs = dbPoll( q_faccs, -1 )
				if faccs and #faccs > 0 then
					triggerClientEvent( source, "informes:actualizar", source, faccs )
				else
					triggerClientEvent( source, "informes:actualizar", source, {} )
					outputChatBox( "[Base de datos] No hay registros con esos filtros en el sistema.", source, 255, 0, 0 )
				end					
			end
		elseif tipo == 3 then
			if not nombre then
				local q_faccs = dbQuery( connection, "SELECT * FROM registrosueldos WHERE id_faccion=? ORDER BY id ASC", tonumber( faccid ) )
				local faccs = dbPoll( q_faccs, -1 )
				if faccs and #faccs > 0 then
					triggerClientEvent( source, "informes:actualizar", source, faccs )
				else
					triggerClientEvent( source, "informes:actualizar", source, {} )
					outputChatBox( "[Base de datos] No hay registros con esos filtros en el sistema.", source, 255, 0, 0 )
				end					
			else
				local q_faccs = dbQuery( connection, "SELECT * FROM registrosueldos WHERE id_faccion=? AND encargado=? ORDER BY id ASC", tonumber( faccid ), nombre )
				local faccs = dbPoll( q_faccs, -1 )
				if faccs and #faccs > 0 then
					triggerClientEvent( source, "informes:actualizar", source, faccs )
				else
					triggerClientEvent( source, "informes:actualizar", source, {} )
					outputChatBox( "[Base de datos] No hay registros con esos filtros en el sistema.", source, 255, 0, 0 )
				end					
			end
		end
	end
)

addEvent( "ascenderJugador", true )
addEventHandler( "ascenderJugador", getRootElement(),
	function( idchar, facc )
		
	end
) 

addCommandHandler( "gestiongob",
	function( player, cmd )
		if getElementData( player, "isLoged" ) then
			local faccs = exports.facciones:getPlayerFaction( player )
			if faccs[1] == 5 or faccs[2] == 5 then
				if exports.facciones:getPlayerFactionRights( player, exports.personajes:getCharID( player ), 5 ) == 3 then
					local tfaccs = {}
					for i=1, #faccsgob do 
						local presupuesto = exports.facciones:getFactionPresupuesto( faccsgob[i] )
						local nombre = getFactionName( faccsgob[i] )
						tfaccs[i] = { nombre, presupuesto, faccsgob[i] }
					end
					triggerClientEvent( player, "gob:abrirPanel", player, tfaccs )
				end
			end	
		end
	end
)
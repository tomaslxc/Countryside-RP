local infos = {}

local connection = exports.mysql:connect()

addEventHandler( "onResourceStart", resourceRoot,
	function()
		local query = dbQuery( connection, "SELECT * FROM infos ORDER BY id ASC")
		local data = dbPoll(query, -1)
		if data and #data > 0 then
			for i=1, #data do 
				local v = data[i]
				table.insert( infos, { v.id, v.text, v.creador, v.x, v.y, v.z, v.interior, v.dimension } )
			end
		else
			outputDebugString( "No hay infos para mostrar." )
		end
		setTimer( function()
			triggerClientEvent( root, "infos:refresh", root, infos )
		end, 1000, 1 )
	end
)

addEventHandler( "onPlayerJoin", getRootElement(),
	function()
		setTimer( function()
			triggerClientEvent( root, "infos:refresh", root, infos )
		end, 1000, 1 )	
	end
)

function getTextFromID( id )
	for i=1, #infos do 
		if infos[i][1] == id then
			return i
		end
	end
end

addCommandHandler( "nearbyinfos",
	function( player, cmd )
		if getElementData( player, "isLoged" ) and getElementData( player, "staff" ) >= 3 then
			outputChatBox( "Textos cercanos:", player, 255, 255, 0 )
			for i=1, #infos do 
				local px, py, pz = getElementPosition( player )
				local id, texto, creador, tx, ty, tz, int, dim = unpack( infos[i] )
				local dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
				if dim == getElementDimension( player ) and int == getElementInterior( player ) and dist < 10 then
					outputChatBox( "     ["..id.."] Texto: "..texto..". Creado por: "..creador, player, 255,255,255 )
				end
			end
		end
	end
)

addCommandHandler( "borrarinfo",
	function( player, cmd, id )
		if getElementData( player, "isLoged" ) and getElementData( player, "staff" ) >= 3 then
			local infoindex = getTextFromID( tonumber(id) )
			if infoindex then
				dbExec(connection,"DELETE FROM infos WHERE id=?", tonumber(id))
				table.remove( infos, infoindex )
				triggerClientEvent( root, "infos:refresh", root, infos )
				outputChatBox( "Has borrado correctamente el info con ID "..id..".", player, 0, 255, 0 )
				outputDebugString( "El staff "..getPlayerName( player ):gsub("_"," ").." ha borrado el info con ID "..id )
			else
				outputChatBox( "No se encuentra el texto con esa ID.", player, 255, 0, 0 )
			end
		end
	end
)

addCommandHandler( "crearinfo",
	function( player, cmd, ... )
		if getElementData( player, "isLoged" ) and getElementData( player, "staff" ) >= 3 then
			local texto = table.concat( {...}, " " )
			if texto and #texto > 5 then
				local x, y, z = getElementPosition( player )
				local int, dim = getElementInterior( player ), getElementDimension( player )
				local ins = dbQuery( connection, "INSERT INTO infos (text,creador,x,y,z,interior,dimension) VALUES (?,?,?,?,?,?,?)", texto, getPlayerName(player), x, y, z, int, dim )
				local result, num_affected_rows, ID = dbPoll ( ins, -1 )
				if tonumber(ID) then
					outputChatBox( "Creado el texto con ID "..ID..".", player, 0, 255, 0 )
					
					table.insert( infos, { ID, texto, getPlayerName(player), x, y, z, int, dim } )
					triggerClientEvent( root, "infos:refresh", root, infos )
					
					outputDebugString( "El staff "..getPlayerName(player).." creó el texto "..ID..": "..texto )
				else
					outputChatBox( "Error al crear el INFO.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Introduce un texto mayor a 5 caracteres.", player, 255, 0, 0 )
			end
		end
	end
) 
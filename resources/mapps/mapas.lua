function editarMapa( player, cmd, ruta, mapa, int, dim )
	if getElementData( player, "isLoged" ) and getElementData( player, "staff" ) >= 5 then
		if tostring( ruta ) and tostring( mapa ) then 
			local map = xmlLoadFile( ":"..tostring(ruta).."/"..tostring(mapa)..".map" )
			if map then
				outputChatBox( "Cambiando datos del mapa...", player, 0, 255, 0 )
				local children = xmlNodeGetChildren( map )
				for key, value in ipairs( children ) do
					if xmlNodeGetName( value ) == "object" then
						xmlNodeSetAttribute( value, "dimension", ""..dim.."" )
						xmlNodeSetAttribute( value, "interior", ""..int.."" )
					end
				end
				xmlSaveFile( map )
				xmlUnloadFile( map )
				outputChatBox( "Mapa "..ruta.." editado correctamente.", player, 0, 255, 0 )
				if restartResource( getResourceFromName( ruta ) ) then
					outputChatBox( "Mapa reiniciado y valores cambiados correctamente.", player, 0, 255, 0 )
				else
					if startResource( getResourceFromName( ruta ) ) then
						outputChatBox( "Mapa iniciado y en marcha.", player, 0, 255, 0 )
					else
						outputChatBox( "No se puede iniciar el recurso. Inicialo manualmente.", player, 255, 0, 0 )
					end
				end
			else
				outputChatBox( "No se puede cargar el mapa.", player, 255, 0, 0 )
			end
		else
			outputChatBox( "Syntax: /"..cmd.." [ruta del mapa (la carpeta)] [nombre del .map] [interior nuevo] [dimension nueva]", player, 255, 255, 255 )
		end
	end
end
addCommandHandler( "cambiarmap", editarMapa )
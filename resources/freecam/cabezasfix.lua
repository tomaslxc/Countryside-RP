addEvent( "ocultarCabeza", true )
addEventHandler( "ocultarCabeza", getRootElement(),
	function( player, estado )
		local cbz = exports.cabezas:getCabezaPlayer( player )
		if estado == 1 then
			if cbz then
				setElementAlpha( cbz, 0 )
			end				
		else
			if cbz then
				setElementAlpha( cbz, 255 )
			end		
		end
	end
)
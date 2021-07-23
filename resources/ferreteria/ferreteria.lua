local bots = {}

local botsf = {
	-- X, Y, Z, ROT, DIM, INT
	

        {-1330.2373046875, -547.73828125, 14.179900169373, 184, 15, 716}, -- BOT GASOLINERA LS, MANSON ST
	{-1330.390625, -547.734375, 14.179900169373, 178, 15, 625},

}

function abrirPanel(b,s,player)
	if b == 'left' and s == 'down' then
		local px, py, pz = getElementPosition( source )
		local x, y, z = getElementPosition( player )
		if getDistanceBetweenPoints3D( x, y, z, px, py, pz ) < 5 and getElementDimension( source ) == getElementDimension( player ) and getElementInterior( source ) == getElementInterior( player ) then
			triggerClientEvent( player, "ferreteria:abrir", player )
		end
	end
end

function crearBotFerreteria()
	for i=1, #botsf do 
		local x, y, z, rot, int, dim = unpack(botsf[i])
		if isElement( bots[i] ) then destroyElement( bots[i] ) bots[i] = nil end
		bots[i] = createPed( 32, x, y, z, rot )
		setElementInterior( bots[i], int )
		setElementDimension( bots[i], dim )
		setElementFrozen( bots[i], true )
		addEventHandler( "onElementClicked", bots[i], abrirPanel )
	end
end
addEventHandler( "onResourceStart", resourceRoot, crearBotFerreteria )
addEventHandler( "onPedWasted", resourceRoot, crearBotFerreteria )



-- FUNCION DE COPIAR EL ITEM


addEvent( "ferreteria:copiar", true )
addEventHandler( "ferreteria:copiar", getRootElement(),
	function( id, tipo )
		if tonumber( id ) and tipo then
			if tipo == 1 then
				if exports.items:itemHas( source, 12, tonumber(id) ) then
					if getPlayerMoney( source ) >= 15 then
						exports.personajes:takeCharMoney( source, 15 )
						outputChatBox( "Has realizado una copia de la llave.", source, 0, 255, 0 )
						exports.items:darItem( source, 12, tonumber(id) )
					else
						outputChatBox( "La copia cuesta 15$. No llevas tanto encima", source, 255, 0, 0 )
					end
				else
					outputChatBox( "No tienes una llave con esa ID en el inventario.", source, 255, 0, 0 )
				end
			else
				if exports.items:itemHas( source, 13, tonumber(id) ) then
					if getPlayerMoney( source ) >= 15 then
						exports.personajes:takeCharMoney( source, 15 )
						outputChatBox( "Has realizado una copia de la llave.", source, 0, 255, 0 )
						exports.items:darItem( source, 13, tonumber(id) )
					else
						outputChatBox( "La copia cuesta 15$. No llevas tanto encima", source, 255, 0, 0 )
					end
				else
					outputChatBox( "No tienes una llave con esa ID en el inventario.", source, 255, 0, 0 )
				end			
			end
		end
	end
)
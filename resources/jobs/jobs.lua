botJob = {} 
-- Los datos del bot son: skin, posx, posy, posz y rotacion, int, dim
datosBot = {
    {93, -1258.939453125, -537.5166015625, 14.206249237061, 0, 4, 622 },
    {93, -1425.7568359375, -531.6767578125, 14.279465675354,205,1,490 }, --- Blueberry
	{76, 1471.4580078125, 1308.8671875, 26.74843788147, 174.14416503906, 20,552},
    {93, 1489.0400390625, 1305.5556640625, 1093.2963867188, 0, 3, 637 },

}
function crearBotJob()

	for i=1, #datosBot do 
		local v = datosBot[i]
		if isElement( botJob[i] ) then destroyElement( botJob[i] ) botJob[i] = nil end
			botJob[i] = createPed( v[1], v[2], v[3], v[4], v[5] )
			setElementInterior( botJob[i], v[6] )
			setElementDimension( botJob[i], v[7] )
			setElementFrozen( botJob[i], true )
			addEventHandler( "onElementClicked", botJob[i], jobbotclick )
			setTimer( function() -- Si no pones un timer no pondrá la anim o la pondrá random depende de cómo le de.
				setPedAnimation( botJob[i], "cop_ambient", "coplook_loop",-1,false,false,false)
			end, 500, 1 )		
	end
end
addEventHandler( "onResourceStart", resourceRoot, crearBotJob) -- Creamos el ped al iniciar el script
addEventHandler( "onPedWasted", getRootElement(), crearBotJob ) -- Esto para que cuando muera reaparezca el bot

-- Funcion de darle click al bot

local tanim = nil

function jobbotclick( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" then -- if left mouse button was pressed down
            local x, y, z = getElementPosition( thePlayer )
            local x2, y2, z2 = getElementPosition( source )
            if getDistanceBetweenPoints3D( x, y, z, x2,y2,z2 ) < 3 and getElementDimension(thePlayer) == getElementDimension(source) and getElementInterior(thePlayer) == getElementInterior(source) then
                triggerClientEvent( thePlayer, "jobs:abrirPanel", thePlayer )
				if not tanim then
					setPedAnimation( source, "gangs", "prtial_gngtlka" )
					outputChatBox( " [Inglés] Trabajadora dice: Mira, aqui tienes una lista de algunos sitios en los que podrías ayudar para desarrollar el condado.", thePlayer, 255, 255, 255 )
				end
            end 
    end
end
 -- add a handler function for the event
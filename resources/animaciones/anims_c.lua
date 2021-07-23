local localPlayer = getLocalPlayer( )
local screenX, screenY = guiGetScreenSize( )

bindKey( "space", "down",
	function( )
		if getPedAnimation( localPlayer ) and getElementData(localPlayer, "isLoged") then
			triggerServerEvent( "anims:reset", localPlayer )
		end
	end
)

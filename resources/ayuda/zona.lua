local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)
local x, y = ( screenWidth / 1280 ), ( screenHeight / 720 )

function createText ( )
	if getElementData( getLocalPlayer(), "isLoged" ) then
		local playerX, playerY, playerZ = getElementPosition ( localPlayer )       -- Get our player's coordinates.
		local playerZoneName = getZoneName ( playerX, playerY, playerZ )          -- Get name of the zone the player is in.

		dxDrawText ( playerZoneName, x*0, y*651, screenWidth, screenHeight, tocolor ( 0, 0, 0 ), 2, "default-bold", "center", "center" )
		dxDrawText ( playerZoneName, x*0, y*650, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 2, "default-bold", "center", "center" )
	end
end

function HandleTheRendering ( )
    addEventHandler ( "onClientRender", root, createText ) -- keep the text visible with onClientRender.
end

addEventHandler ( "onClientResourceStart", resourceRoot, HandleTheRendering )
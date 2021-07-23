local infos = {}
local pickups = {}

addEvent( "infos:refresh", true )
addEventHandler( "infos:refresh", getRootElement(),
	function( ninfos )
		infos = ninfos
	end
)

local regular = dxCreateFont(":fuentes/Roboto-Regular.ttf", 10)
local bold = dxCreateFont(":fuentes/Roboto-BoldCondensed.ttf", 10)
local screenW, screenH = guiGetScreenSize()

addEventHandler( "onClientRender", root,
	function()
		if infos and #infos > 0 then
			for i=1, #infos do 
				local id, texto, creador, tx, ty, tz, int, dim = unpack( infos[i] )
				local px, py, pz = getCameraMatrix( )
				local dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
				if dist < 15 and int == getElementInterior( localPlayer ) and dim == getElementDimension( localPlayer ) then
					local s = { getScreenFromWorldPosition( tx, ty, tz+0.3 ) }
					if s[1] and s[2] then
						dxDrawImage( s[1]-30, s[2]+20, 60 + ( 15 - dist ) * 0.02, 60 + ( 15 - dist ) * 0.02, "info.png" )
						dxDrawText( texto, s[1], s[2]+2, s[1], s[2], tocolor(0,0,0), 0.85 + ( 15 - dist ) * 0.02, regular, "center", "center" )
						dxDrawText( texto, s[1], s[2], s[1], s[2], tocolor(255,255,255), 0.85 + ( 15 - dist ) * 0.02, regular, "center", "center" )
					end
				end
			end
		end
	end
)
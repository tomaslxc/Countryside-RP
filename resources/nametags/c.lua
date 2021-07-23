    r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 14 )
    r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 9 )
    r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )

local fuente = dxCreateFont( "fuente.ttf", 12 )
local fuente_yo = dxCreateFont( "fuenteyo.ttf", 10 )
local screenW, screenH = guiGetScreenSize()


-- settings
local dist_visible = 30
local _max_distance = 100 -- max. distance it's visible
local _min_distance = 7.5 -- minimum distance, if a player is nearer his nametag size wont change
local _alpha_distance = 10 -- nametag is faded out after this distance
local _nametag_alpha = 255 -- alpha of the nametag (max.)
local _bar_alpha = 255 -- alpha of the bar (max.)
local _scale = 0.2 -- change this to keep it looking good (proportions)
local _nametag_textsize = 0.4 -- change to increase nametag text
local _nametag_yosize = 0.45
local _nametag_amesize = 0.6
local _chatbubble_size = 15
local _bar_width = 40
local _bar_height = 3.5
local _bar_border = 0.5

-- adjust settings
local _, screenY = guiGetScreenSize( )
real_scale = screenY / ( _scale * 800 ) 
local _alpha_distance_diff = _max_distance - _alpha_distance
local localPlayer = getLocalPlayer( )



addEventHandler( 'onClientRender', root, 
	function( )
if getElementData(localPlayer, "isLoged") then
	if screenH >= 600 and screenW > 800 then
	if isNametag then
		-- get the camera position of the local player
		local cx, cy, cz = getCameraMatrix( )
		local dimension = getElementDimension( localPlayer )
		local interior = getElementInterior( localPlayer )
		
		-- loop through all players
		for i, player in ipairs( getElementsByType("player") ) do
			if getElementDimension( player ) == dimension and getElementInterior( player ) == interior and isElementOnScreen( player ) then
				local px, py, pz = getElementPosition( player )
				local lx, ly, lz = getElementPosition(localPlayer)
				local distanciap = getDistanceBetweenPoints3D( px, py, pz, lx, ly, lz )
				local distance = getDistanceBetweenPoints3D( px, py, pz, cx, cy, cz )
				if distance <= _max_distance and ( getElementData( localPlayer, "collisionless" ) or isLineOfSightClear( cx, cy, cz, px, py, pz, true, true, false, true, false, false, true, getPedOccupiedVehicle( player ) ) ) then
				
					local dz = 1 + 2 * math.min( 1, distance / _min_distance ) * _scale
					if isPedDucked( player ) then
						dz = dz / 2
					end
					pz = pz + dz
					local sx, sy = getScreenFromWorldPosition( px, py, pz )
					if sx and sy then
						local cx = sx
						
						-- how large should it be drawn
						distance = math.max( distance, _min_distance )
						local scale = _max_distance / ( real_scale * distance )
						
						-- visibility
						local alpha = ( ( distance - _alpha_distance ) / _alpha_distance_diff )
						local bar_alpha = ( ( alpha < 0 ) and _bar_alpha or _bar_alpha - (alpha * _bar_alpha) ) * ( getElementData( localPlayer, "collisionless" ) and 1 or getElementAlpha( player ) / 255 )
						if bar_alpha > 0 then
							local nametag_alpha = bar_alpha / _bar_alpha * _nametag_alpha
							
							-- draw the player's name
							
							if distanciap <= dist_visible then
							if getElementData(player, "AMECHAT") then
							local width, height = math.ceil( _bar_width * scale ), math.ceil( _bar_height * scale )
							dxDrawText( "> "..getElementData(player,"AMECHAT") or "", sx, sy, sx, sy, tocolor(0,0,0), (scale * _nametag_amesize), "sans", "center", "center" )
							dxDrawText( "> "..getElementData(player,"AMECHAT") or "", sx, sy, sx, sy, tocolor(194,162,218), (scale * _nametag_amesize), "sans", "center", "center" )
							sy = sy + 2.5 * height
							end
							end
							
							if distanciap <= dist_visible and player ~= localPlayer then
								if getElementData(player,"adminduty") then
									if getElementData(player, "staff") == 3 then
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx+3, sy+5, sx, sy, tocolor( 0, 0, 0, nametag_alpha ), (scale * _nametag_textsize), r_title, 'center', 'bottom' )
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx, sy, sx, sy, tocolor( 105, 215, 104, nametag_alpha ), scale * _nametag_textsize, r_title, 'center', 'bottom' )
									elseif getElementData(player,"staff") == 4 then
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx+3, sy+5, sx, sy, tocolor( 0, 0, 0, nametag_alpha ), (scale * _nametag_textsize), r_title, 'center', 'bottom' )
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx, sy, sx, sy, tocolor( 186, 90, 93, nametag_alpha ), scale * _nametag_textsize, r_title, 'center', 'bottom' )
									elseif getElementData(player, "staff") >= 5 then
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx+3, sy+5, sx, sy, tocolor( 0, 0, 0, nametag_alpha ), (scale * _nametag_textsize), r_title, 'center', 'bottom' )
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx, sy, sx, sy, tocolor( 120, 179, 191, nametag_alpha ), scale * _nametag_textsize, r_title, 'center', 'bottom' )
									else
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx+3, sy+5, sx, sy, tocolor( 0, 0, 0, nametag_alpha ), (scale * _nametag_textsize), r_title, 'center', 'bottom' )
										dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx, sy, sx, sy, tocolor( 255, 128, 0, nametag_alpha ), scale * _nametag_textsize, r_title, 'center', 'bottom' )
									end
								elseif getElementData(player, "esposado") then
									dxDrawText("[Esposado]"..string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx+3, sy+5, sx, sy, tocolor( 0, 0, 0, nametag_alpha ), (scale * _nametag_textsize), r_title, 'center', 'bottom' )
									dxDrawText("[Esposado]"..string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx, sy, sx, sy, tocolor( 255, 255, 255, nametag_alpha ), scale * _nametag_textsize, r_title, 'center', 'bottom' )
								elseif getElementData( player, "hablando" ) then
									dxDrawText( "[...] "..string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx+3, sy+5, sx, sy, tocolor( 0, 0, 0, nametag_alpha ), (scale * _nametag_textsize), r_title, 'center', 'bottom' )
									dxDrawText( "[...] "..string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx, sy, sx, sy, tocolor( 255, 255, 255, nametag_alpha ), scale * _nametag_textsize, r_title, 'center', 'bottom' )								
								else
									dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx+3, sy+5, sx, sy, tocolor( 0, 0, 0, nametag_alpha ), (scale * _nametag_textsize), r_title, 'center', 'bottom' )
									dxDrawText( string.gsub(getPlayerName( player ), "_", " ").." ("..getElementData(player, "playerid")..")", sx, sy, sx, sy, tocolor( 255, 255, 255, nametag_alpha ), scale * _nametag_textsize, r_title, 'center', 'bottom' )
								end
							if getElementData(player, "yo") then
							local width, height = math.ceil( _bar_width * scale ), math.ceil( _bar_height * scale )
							sy = sy + 1.2 * height
							dxDrawText( getElementData(player,"yo") or "", sx, sy, sx, sy, tocolor(0,0,0), (scale * _nametag_yosize), r_desc, "center", "center" )
							dxDrawText( getElementData(player,"yo") or "", sx, sy, sx, sy, tocolor(153,153,255), (scale * _nametag_yosize), r_desc, "center", "center" )
							end
							end

							-- draw the health bar
							local width, height = math.ceil( _bar_width * scale ), math.ceil( _bar_height * scale )
							sy = sy + 1.2 * height
							local sx = sx - width / 1.75
							local border = math.ceil( _bar_border * scale )
							
							-- draw the armor bar
							local armor = math.min( 100, getPedArmor( player ) )
							if armor > 0 then
								if distanciap <= dist_visible and player ~= localPlayer then
								-- outer background
								dxDrawRectangle( sx, sy, width, height, tocolor( 0, 0, 0, bar_alpha ) )
								
								-- get the colors
								local r, g, b = 255, 255, 255
								
								-- inner background, which fills the whole bar but is somewhat transparent
								dxDrawRectangle( sx + border, sy + border, width - 2 * border, height - 2 * border, tocolor( r, g, b, 0.4 * bar_alpha ) )
								
								-- fill it with the actual armor
								dxDrawRectangle( sx + border, sy + border, math.floor( ( width - 2 * border ) / 100 * getPedArmor( player ) ), height - 2 * border, tocolor( r, g, b, bar_alpha ) ) 
								end
								-- set the nametag below
								sy = sy + 1.2 * height
							end
							if distanciap <= dist_visible and player ~= localPlayer then
							-- outer background
							dxDrawRectangle( sx, sy, width, height, tocolor( 0, 0, 0, bar_alpha ) )
							
							-- get the colors
							local health = getElementHealth(player)
							local r, g, b = 200,0,0
							
							-- inner background, which fills the whole bar but is somewhat transparent
							dxDrawRectangle( sx + border, sy + border, width - 2 * border, height - 2 * border, tocolor( r, g, b, 0.4 * bar_alpha ) )
							
							-- fill it with the actual health
							dxDrawRectangle( sx + border, sy + border, math.floor( ( width - 2 * border ) / 100 * health ), height - 2 * border, tocolor( r, g, b, bar_alpha ) )
							end
							-- chat icon if the player has one
							if chaticon then
								local square = math.ceil( _chatbubble_size * scale )
								local sy = sy + square / 1.9
								local r, g, b = 255 - 128 * health / 100, 127 + 128 * health / 100, 127
								dxDrawImage( cx, sy, square, square, chaticon == true and "chat.png" or "console.png", 0, 0, 0, tocolor( r, g, b, nametag_alpha ) )
							end
						end
					end
				
				end
			end
		end
	end
	else
		dxDrawText("Algunas funciones han sido deshabilitadas debido a tu baja resolución.", (screenW * 0.3075) - 1, (screenH * 0.9556) - 1, (screenW * 0.6594) - 1, (screenH * 0.9889) - 1, tocolor(0, 0, 0, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Algunas funciones han sido deshabilitadas debido a tu baja resolución.", (screenW * 0.3075) + 1, (screenH * 0.9556) - 1, (screenW * 0.6594) + 1, (screenH * 0.9889) - 1, tocolor(0, 0, 0, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Algunas funciones han sido deshabilitadas debido a tu baja resolución.", (screenW * 0.3075) - 1, (screenH * 0.9556) + 1, (screenW * 0.6594) - 1, (screenH * 0.9889) + 1, tocolor(0, 0, 0, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Algunas funciones han sido deshabilitadas debido a tu baja resolución.", (screenW * 0.3075) + 1, (screenH * 0.9556) + 1, (screenW * 0.6594) + 1, (screenH * 0.9889) + 1, tocolor(0, 0, 0, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Algunas funciones han sido deshabilitadas debido a tu baja resolución.", screenW * 0.3075, screenH * 0.9556, screenW * 0.6594, screenH * 0.9889, tocolor(254, 254, 254, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
   
	end
	end
end
)


setTimer( function()
	if isChatBoxInputActive() or isConsoleActive() then
		triggerServerEvent( "setDataHablando", localPlayer, 1 )
	else
		triggerServerEvent( "setDataHablando", localPlayer, 0 )
	end
end, 2000, 0 )


isNametag = true
function vernametags()
	if isNametag then
	isNametag = false
	else
	isNametag = true
	end
end
addCommandHandler("togglenametags", vernametags)
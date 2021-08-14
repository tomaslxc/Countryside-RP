local sx, sy = guiGetScreenSize(  )

local tw,th = sx*0.35, sy*0.48
local tx,ty = sx/2 - tw/2, sy/2 - th/2

local columns = {{"ID",7},{"Nombre",2.25}}
local resto,scroll = 0,0

--local female = {9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 298, 304}
local eF = 0
local index = false

addEventHandler( "onClientRender", getRootElement(),
	function()
		if vestVisible then

			dxDrawRectangle(tx, ty, tw, th, tocolor(0,0,0,170), false)
			dxText('Vestuario', tx, ty, tw, th, tocolor(255,255,255), .6, .7, 'bankgothic', 'center')

			local cX = 0

			for ic, vc in ipairs(columns) do

				dxDrawText(vc[1], sx*0.08+tx+cX, ty+sy*0.04, 1, 1, tocolor( 255,255,255 ), 0.5, 0.6, 'bankgothic')
				cX = cX + dxGetTextWidth(vc[1], 1, 'default-bold' ) * vc[2]

			end

			local cY = 0
			local female = localPlayer:getData('Skins:Save') or {}
			for i = (1+scroll), #female-(resto-scroll) do

				local cX = 0
				local v = female[i]

				if (sy*0.37)+cY <= ((sy/600)*(402)) then

					if isCursorOver(tx, ty+sy*0.07+cY, tw, dxGetFontHeight( 1, 'default-bold' ) * 2) or index == i then
						dxDrawRectangle(tx, ty+sy*0.07+cY, tw, dxGetFontHeight( 1, 'default-bold' ) * 2, tocolor(220,220,220,50), false)
						if not click and getKeyState('mouse1') then
							index = i
						end
					end

					for ic, vc in ipairs(columns) do

						if vc[1] == 'ID' then
							dxDrawText(v[1]..'', sx*0.08+tx+cX, ty+sy*0.07+cY, 1, dxGetFontHeight( 1, 'default-bold' ) * 2 + ty+sy*0.07+cY , tocolor( 255,255,255 ), 0.8, 1, 'default-bold', 'left', 'center')
						elseif vc[1] == 'Nombre' then
							dxDrawText(v[2], sx*0.08+tx+cX, ty+sy*0.07+cY, 1, dxGetFontHeight( 1, 'default-bold' ) * 2 + ty+sy*0.07+cY , tocolor( 255,255,255 ), 0.8, 1, 'default-bold', 'left', 'center')
						end

						cX = cX + dxGetTextWidth(vc[1], 1, 'default-bold' ) * vc[2]

					end

				else
					resto = resto + 1
				end
				
				cY = cY + dxGetFontHeight( 1, 'default-bold' )	* 2
			end

			dxDrawRectangle(tx+tw/4+eF, ty+(sy*0.43)+eF, tw/2-eF*2, sy*0.04-eF*2, tocolor(0,200,200,150), false)
			dxText('usar', tx+tw/4+eF, ty+(sy*0.43)+eF, tw/2-eF*2, sy*0.04-eF*2, tocolor(255,255,255), .5, .6, 'bankgothic', 'center', 'center')

			if not click and getKeyState('mouse1') then
				if isCursorOver(tx+tw/4+eF, ty+(sy*0.43)+eF, tw/2-eF*2, sy*0.04-eF*2) then
					eF = sx * 0.001
					if tonumber(index) then
						triggerServerEvent('Usar:SkinF', resourceRoot, female[index][1])
					end
				elseif not isCursorOver(tx, ty, tw, th) then
					showCursor(false)
					vestVisible = false
					index = nil
				end
			else
				eF = 0
			end

			if resto > 0 then

				if not tickscroll or getTickCount() - tickscroll > 70 then

					if getKeyState( "pgup" ) or getKeyState( 'mouse_wheel_up' ) then

						if scroll > 0 then

							scroll = scroll - 1

						end

					elseif getKeyState( "pgdn" ) or getKeyState( 'mouse_wheel_down' ) then

						if scroll < resto then

							scroll = scroll + 1

						end

					end

					tickscroll = getTickCount(  )

				end

			end

			click = getKeyState( 'mouse1' )
		end
	end
)



addCommandHandler('vestuario',
	function()
		vestVisible = true
		showCursor(true)
	end
)

function dxText(t, x,y,w,h, ...)
	return dxDrawText(t, x, y, w+x, h+y, ...)
end

function isCursorOver(x,y,w,h)

	if isCursorShowing() then

		local sx,sy = guiGetScreenSize(  ) 
		local cx,cy = getCursorPosition(  )
		local px,py = sx*cx,sy*cy

		if (px >= x and px <= x+w) and (py >= y and py <= y+h) then

			return true

		end

	end
	return false
end
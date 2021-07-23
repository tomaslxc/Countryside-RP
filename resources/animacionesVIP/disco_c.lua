local customBlockName = "dance"

local IFP = engineLoadIFP( "files/anims/dance.ifp", customBlockName )

if not IFP then
	outputChatBox( "Failed to load 'ped.ifp'" )
end

local animations = {"dance_horse", "dance_dab", "dance_fan"}

function playCustomAnimation(blockName, animID)
	if animations[animID] then
		--outputChatBox("Syncronization started")
		triggerServerEvent("onAnimationLoad", localPlayer, blockName, animations[animID])
	end
end

addEvent("onAnimationLoad", true)
addEventHandler("onAnimationLoad", root, 
function (blockName, animName)
	--outputChatBox(getPlayerName(source).. " changed anim")
	engineReplaceAnimation( source, "ped", "ATM", blockName, animName)
	--outputChatBox(getPlayerName(source).. " done")
	for index, key in pairs(getElementsByType("player")) do
		setPedAnimation ( source, blockName, animName, -1, false, false, true, false )
		setPedAnimationSpeed ( source, "dance_dab", 0.1 )
		setPedAnimationSpeed ( source, "dance_fan", 0.1 )
	end
end)

-- Drawing things

local sX, sY = guiGetScreenSize()
local w, h = 96, 96
local x, y = sX * 0.5 - w * 0.5 , sY * 0.5 - h * 0.5
local dist = 250
local lastClick = 0
local showAnimations = false

function isMouseInCircle(x, y, r)
	if isCursorShowing( ) then
		local cx, cy = getCursorPosition()
		local cx, cy = cx*sX, cy*sY
		return (x-cx)^2+(y-cy)^2 <= r^2
	end
	return false
end


function openPanelBailes()
	if showAnimations then
	showAnimations = false
	else
	showAnimations = true
	end
end
addEvent("openBailes", true)
addEventHandler("openBailes", localPlayer, openPanelBailes)

addEventHandler("onClientRender", root,
function()
	if showAnimations then
		dxDrawImage(x - 202, y - 202, 500, 500, "files/images/circlebig.png", 0, 0, 0, tocolor(0, 0, 0, 100))
		dxDrawImage(x, y, w, h, "files/images/circle.png")
		dxDrawImage(x + w * 0.25, y + h * 0.25, w*0.5, h*0.5, "files/images/dance.png", 0, 0, 0, tocolor(0, 0, 0, 255))

		--Lets generate dynamic circles by rotation and distance from center.

		local fakeSeparation = 360 / #animations
		local separation = (360) / #animations
		local currentDegres = 0
		for i = 1, #animations do
			local radians = currentDegres * 3.14159265359 / 180
			local aX = dist * math.sin(radians)
			local aY = dist * math.cos(radians)

			if (isMouseInCircle(x + aX + w*0.5, y + aY + h*0.5, 48)) then
				dxDrawImage(x + aX, y + aY, w, h, "files/images/circle.png", 0, 0, 0, tocolor(255, 75, 75, 255))
				dxDrawImage(x + aX + w * 0.25, y + aY + h * 0.25, w*0.5, h*0.5, "files/images/"..animations[i]..".png", 0, 0, 0, tocolor(255, 255, 255, 255))
				if getKeyState("mouse1") and getTickCount() > lastClick + 500 then
					playCustomAnimation("dance", i)
					lastClick = getTickCount()
					showAnimations = false
				end
			else
				dxDrawImage(x + aX, y + aY, w, h, "files/images/circle.png")
				dxDrawImage(x + aX + w * 0.25, y + aY + h * 0.25, w*0.5, h*0.5, "files/images/"..animations[i]..".png", 0, 0, 0, tocolor(0, 0, 0, 255))
			end

			currentDegres = currentDegres + separation
		end

		if (isCursorShowing()) then
			local mX, mY = getCursorPosition()
			local mX, mY = mX * sX, mY * sY

			local mX, mY = mX - x, mY - y

			local cursorAngle = -math.atan2(mX, mY)
			local deg = cursorAngle * (180 / 3.14159265359)

			dxDrawImage(x, y, w, h, "files/images/arrow.png", deg, 0, 0, tocolor(255, 0, 0, 255))
		end
	end
end)
function sonidoEject(sound,x,y,z)
    playSound3D (":policia/"..sound..".mp3", x,y,z)
end
addEvent("ejecutarSonidoPolicia", true)
addEventHandler("ejecutarSonidoPolicia", localPlayer, sonidoEject)

function sonidoEject2(sound,x,y,z)
    playSound3D (":policia/taser.wav", x,y,z)
end
addEvent("ejecutartaser", true)
addEventHandler("ejecutartaser", localPlayer, sonidoEject2)

local customB = "cuff"

--local IFP = engineLoadIFP( ":policia/dealer.ifp", customB )

--if not IFP then
--	outputChatBox( "Failed to load 'ped.ifp'" )
--end

local animations = {"DEALER_IDLE"}


function playCustomAnimationn(blockName, animID)
	if animations[animID] then
		--outputChatBox("Syncronization started")
		triggerServerEvent("onAnimationLoadd", localPlayer, blockName, animations[animID])
	end
end

addEvent("onAnimationLoadd", true)
addEventHandler("onAnimationLoadd", root, 
function (blockName, animName)
	--outputChatBox(getPlayerName(source).. " changed anim")
	engineReplaceAnimation( source, "ped", "ATM", blockName, animName)
	--outputChatBox(getPlayerName(source).. " done")
	setPedAnimation (source, blockName, animName, -1, false, true, false, false)
	-- setPedAnimation ( source, blockName, animName, 2000, true, true, false, false,1000 )
end)

function playCuffAnim(  )
	playCustomAnimationn("cuff", 1)
end
addEvent("playCuffAnim", true)
addEventHandler("playCuffAnim", localPlayer, playCuffAnim)

function arrestadoNoMuere ( attacker, weapon, bodypart )
	if getElementData(source, "arrestado") or getElementData(source, "ajaileado") then
		cancelEvent()
	elseif attacker and getElementData(attacker, "tazer") then
		triggerServerEvent("aplicar:tazer",localPlayer, localPlayer)
		cancelEvent()
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), arrestadoNoMuere )
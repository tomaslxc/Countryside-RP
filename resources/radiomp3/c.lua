radioWindow = guiCreateWindow(453, 214, 477, 168, "Disquetera del vehículo", false)
guiWindowSetSizable(radioWindow, false)
guiSetVisible (radioWindow,false)

btnClose = guiCreateButton(237, 119, 226, 31, "Cerrar ventana", false, radioWindow)
lblInfo = guiCreateLabel(12, 119, 218, 32, "Puedes buscar links de música", false, radioWindow)
guiLabelSetColor(lblInfo, 24, 208, 230)
editRadio = guiCreateEdit(62, 31, 406, 26, "", false, radioWindow)

lblLink = guiCreateLabel(25, 36, 31, 15, "Link:", false, radioWindow)
btnReproducir = guiCreateButton(19, 76, 125, 37, "Reproducir/Renaudar", false, radioWindow)
btnPausar = guiCreateButton(179, 76, 125, 37, "Pausar", false, radioWindow)
btnParar = guiCreateButton(338, 76, 125, 37, "Parar", false, radioWindow)

playing = {}
sound = {}

function openPanel (player)
	if player == getLocalPlayer() then
		if guiGetVisible (radioWindow) == false then
			showCursor (true)
			guiSetVisible (radioWindow,true)
		else
			showCursor (false)
			guiSetVisible (radioWindow,false)
		end
	end
end
addEvent ("openRadio", true)
addEventHandler ("openRadio", getRootElement(), openPanel)

function close ()
	if source == btnClose then
		showCursor (false)
		guiSetVisible (radioWindow,false)
	end
end
addEventHandler ("onClientGUIClick", getRootElement(), close)

function playOptions ()
	if source == btnReproducir then
		local link = guiGetText (editRadio)
		if link ~= "" then
			if playing [localPlayer] ~= true then
				triggerServerEvent ("sendInformation", getLocalPlayer(), localPlayer, "play", link)
			elseif playing [localPlayer] == true then
				triggerServerEvent ("sendInformation", getLocalPlayer(), localPlayer, "reanudar", link)
			end
		end
	elseif source == btnPausar then
		if playing [localPlayer] == true then
			triggerServerEvent ("sendInformation", getLocalPlayer(), localPlayer, "pausar")
		end
	elseif source == btnParar then
		if playing [localPlayer] == true then
			triggerServerEvent ("sendInformation", getLocalPlayer(), localPlayer, "stop")
		end
	end
end
addEventHandler ("onClientGUIClick", getRootElement(), playOptions)

function receive (player,action,link,x,y,z,veh)
	if action == "play" then
		sound [player] = playSound3D (link,x,y,z,false)
		if sound [player] then playing [player] = true end
		attachElements ( sound [player], veh )
	elseif action == "reanudar" then
		setSoundPaused ( sound [player], false)
	elseif action == "pausar" then 
		setSoundPaused ( sound [player], true)
	elseif action == "stop" then
		detachElements ( sound [player], veh )
		stopSound ( sound [player] )
		playing [player] = nil
		sound [player] = nil
	end
end
addEvent ("receive", true)
addEventHandler ("receive", getRootElement(), receive)

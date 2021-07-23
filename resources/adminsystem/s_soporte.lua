local dudas = {
	-- ["Nombre_Apellido"] = "Mi duda es", <--- [La tabla se forma de esta manera]
}

function recursoIniciado()
	outputDebugString("[RECURSO - SOPORTE] El recurso inicio correctamente.")
end
addEventHandler("onResourceStart", resourceRoot, recursoIniciado)

function duda(p, _, ...)
	mensajeduda = table.concat({...}, " ")
	if mensajeduda and #mensajeduda > 0 then
		playerName = getPlayerName(p)
		if type(dudas[playerName]) == "table" and type(dudas[playerName][1]) == "string" then
			outputChatBox("#D84444[Soporte] #FFFFFFYa enviaste un mensaje al soporte, espera a que te respondan o usa /csoporte.", p, 0, 0, 0, true)
			return false
		else
			dudas[playerName] = {mensajeduda}
			outputChatBox("#44D858[Soporte] #FFFFFFEnviaste un mensaje al soporte, espera a que te respondan o puedes usar /csoporte para cancelarla.", p, 0, 0, 0, true)
			outputDebugString("[Soporte] Llegó un mensaje al soporte desde"..playerName.." [INFO] Soporte: "..mensajeduda)
			for i, players in ipairs(getElementsByType("player")) do
				if getElementData(players, "staff") >=3 then
					outputChatBox("#44D858[Soporte] Llegó un mensaje al soporte desde #FF7800"..playerName.." #FFFFFFusa /rsoporte ["..playerName.."]\n#44D858[Soporte]: #FFFFFF"..mensajeduda.."", players, 0, 0, 0, true)
				end
			end
			return true
		end
	else
		outputChatBox("#D84444[Soporte] #FFFFFF /soporte [duda/reporte] ", p, 0, 0, 0, true)
	end
end

function rduda(p, _, id, ...)
	if getElementData(p, "staff") >=3 then
		if id and dudas[id] and type(dudas[id][1]) == "string" then
			responderDuda = table.concat({...}, " ")
			idE = getPlayerFromName(id)
			if isElement(idE) then
				staffName = getPlayerName(p)
				if #responderDuda > 0 then
					outputChatBox("#44D858[Soporte]#FFFFFF El staff #FF7800"..staffName.."#FFFFFF respondió tu ticket. \n #FF7800[Respuesta]: #FFFFFF"..responderDuda, idE, 0, 0, 0, true)
					outputChatBox("#44D858[Soporte] Respondiste el ticket de #FF7800"..id.." \n [Respondiste]: #FFFFFF"..responderDuda, p, 0, 0, 0, true)
					remover = table.remove(dudas[id])
					if remover then
						outputDebugString("[Soporte] Se resolvió tu ticket de "..id.." con exito. [INFO] Staff: "..staffName.." Respuesta: "..mensajeduda)
					end
				end
			end
		end
	end
end

function cduda(p, _)
	playerName = getPlayerName(p)
	if dudas[playerName] then
		remover = table.remove(dudas[playerName])
		if remover then
			outputChatBox("#44D858[Soporte] #FFFFFFSe canceló tu soporte correctamente. ", p, 0, 0, 0, true)
			outputDebugString("[Soporte] El ticket de "..playerName.." se canceló.")
		end
	else
		outputChatBox("#D84444[Soporte] #FFFFFFNo tienes un ticket pendiente.", p, 0, 0, 0, true)	
	end
end

function vduda(p, _)
	if getElementData(p, "staff") >=3 then
		outputChatBox("#44D858[Tickets pendientes]", p, 0, 0, 0, true)
		for names, dudas in pairs(dudas) do
			outputChatBox("#FF7800[Personaje]: #FFFFFF"..names.." #FF7800[Soporte]: #FFFFFF"..dudas, p, 0, 0, 0, true)
		end
	end
end

function eliminardudaTabla()
	playerName = getPlayerName(source)
	if dudas[playerName] and type(dudas[playerName][1]) == "string" then
		remover = table.remove(dudas[playerName])
		if remover then
			outputDebugString("[Soporte] El ticket de "..playerName.." fue cancelada [JUGADOR DESCONECTADO]")
		end
	end
end

addEventHandler("onPlayerQuit", getRootElement(), eliminardudaTabla)
addCommandHandler("soporte", duda)
addCommandHandler("csoporte", cduda)
addCommandHandler("versorporte", vduda)
addCommandHandler("rsoporte", rduda)
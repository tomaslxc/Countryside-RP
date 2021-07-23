local connection = exports.mysql:connect()

function enviarAnuncio( player, cmd, ... )
	if getElementData(player, "isLoged") then
		if getElementDimension(player) == 503 then--interior radio
			if ... then
				local money = exports.personajes:getCharMoney(player)
				if money >= 10 then
					local anuncio = table.concat({ ... }, " ")
					exports.personajes:takeCharMoney(player, 10)
					for i,v in ipairs(getElementsByType("player")) do
						if getElementData(v, "staff") and getElementData(v, "staff") >= 3 then
							outputChatBox("[AD] "..anuncio,v,51,255,153)
							outputChatBox("(( Anuncio publicado por "..string.gsub(getPlayerName(player), "_", " ").." ))",v,51,255,153)
						else
							outputChatBox("[AD] "..anuncio,v,51,255,153)
						end
					end
					dbExec( connection, "UPDATE `facciones` SET `presupuesto`=`presupuesto`+10 WHERE `id`=7")
				else
					exports.login:addNotification(player, "No tienes suficiente dinero para publicar un anuncio", "error")
				end
			else
				outputChatBox("Syntax: /ad [anuncio IC]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("ad", enviarAnuncio)

retransmisiones = {}
function iniciarRetransmision( player )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 7 or factions[2] == 7 then
			if retransmisiones[player] ~= nil then
				local amount = retransmisiones[player]
				exports.personajes:addCharMoney(player, amount)
				outputChatBox("Te han dado "..amount.." dólares por tu retransmisión.",player, 0, 200,0)
			else
				retransmisiones[player] = 0
				outputChatBox("Has empezado una retransmisión",player,0,200,0)
			end
		end
	end
end
addCommandHandler("retransmision", iniciarRetransmision)

function retransmitir( player, cmd, ... )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 7 or factions[2] == 7 then
			if retransmisiones[player] ~= nil then
				if ... then
					local mensaje = table.concat({...}, " ")
					for i,v in ipairs(getElementsByType("player")) do
					outputChatBox("[RT] "..string.gsub(getPlayerName(player), "_", " ").." comunica: "..mensaje, v, 0,128,255)
					end
					retransmisiones[player] = retransmisiones[player] + 1
				else
					outputChatBox("Syntax: /rt [mensaje] -- retransmisión en directo",player, 255,255,255)
				end
			else
				outputChatBox("No tienes ninguna retransmisión empezada.",player,200,0,0)
			end
		end
	end
end
addCommandHandler("rt", retransmitir)
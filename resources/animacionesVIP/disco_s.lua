local connection = exports.mysql:connect()


addEvent("onAnimationLoad", true)
addEventHandler("onAnimationLoad", root, 
function (blockName, animationName)
	local players = getElementsByType("player")
	triggerClientEvent(players, "onAnimationLoad", client, blockName, animationName)
end)

function abrirbailes(player)
	-- if getElementData(player,"isLoged") then
	-- local qh2 = dbQuery( connection, "SELECT * FROM personajes WHERE ID=?", exports.guisystem:getCharID(player) )
	-- local result = dbPoll( qh2, -1 )
	-- 	if result[1].dancepack == 1 then
		triggerClientEvent(player, "openBailes",player)
	-- 	end
	-- end
end
addCommandHandler("bailes", abrirbailes)
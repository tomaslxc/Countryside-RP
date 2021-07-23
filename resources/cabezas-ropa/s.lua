
function abrirpanelropa(player)
local data = exports.personajes:getPlayerRopaData(player)
triggerClientEvent(player, "panel:ropa", player, data)
end
addCommandHandler("panelropa", abrirpanelropa)

--[[-------------------------------------------------
Notes:

> This code is using a custom font. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move custom fonts into your local resource and reference them there.
--]]-------------------------------------------------


local scoreboard = false
function openScoreboard()
    if scoreboard then
        scoreboard = false
    else
        scoreboard = true
    end
end



bindKey ( "tab", "down", openScoreboard )

local player_index = 1
local tabplayers = {}

local regular = dxCreateFont(":personajes/fonts/Roboto-Regular.ttf", 10)
local bold = dxCreateFont(":personajes/fonts/Roboto-BoldCondensed.ttf", 10)
local screenW, screenH = guiGetScreenSize()

bindKey( "mouse_wheel_up", "down", function( )
    
    if scoreboard then
        if player_index > 1 then
            player_index = player_index - 1
        end   
    end
end)

bindKey( "mouse_wheel_down", "down", function( )
    if scoreboard then
        if player_index+11 < #tabplayers then
            player_index = player_index+1
        end
    end
end)

function calcularER( pcu )
    if pcu then
        return pcu
    else
        return 0
    end
end

addEventHandler("onClientRender", root,
    function()
        if scoreboard then
            tabplayers = nil
            tabplayers = {}
        for k,player in ipairs(getElementsByType("player")) do
            if not getElementData(player, "isLoged") then
                tabplayers[k] = {name = string.gsub(getPlayerName(player),"_", " "),ping=getPlayerPing(player),id=getElementData(player, "playerid"),er=calcularER(getElementData(player,"pcu")),r=150,g=150,b=150}
            elseif getElementData(player, "adminduty") then
                if getElementData(player, "staff") == 3 then
                    tabplayers[k] = {name = string.gsub(getPlayerName(player),"_", " "),ping=getPlayerPing(player),id=getElementData(player, "playerid"),er=calcularER(getElementData(player,"pcu")),r=105,g=215,b=104}
                elseif getElementData(player, "staff") == 4 then
                    tabplayers[k] = {name = string.gsub(getPlayerName(player),"_", " "),ping=getPlayerPing(player),id=getElementData(player, "playerid"),er=calcularER(getElementData(player,"pcu")),r=186,g=90,b=93}
                elseif getElementData(player, "staff") >= 5 then
                    tabplayers[k] = {name = string.gsub(getPlayerName(player),"_", " "),ping=getPlayerPing(player),id=getElementData(player, "playerid"),er=calcularER(getElementData(player,"pcu")),r=120,g=179,b=191}
                else
                    tabplayers[k] = {name = string.gsub(getPlayerName(player),"_", " "),ping=getPlayerPing(player),id=getElementData(player, "playerid"),er=calcularER(getElementData(player,"pcu")),r=255,g=128,b=0}
                end
            else
                tabplayers[k] = {name = string.gsub(getPlayerName(player),"_", " "),ping=getPlayerPing(player),id=getElementData(player, "playerid"),er=calcularER(getElementData(player,"pcu")),r=255,g=255,b=255}
            end
            
        end
        dxDrawLine((screenW * 0.3456) - 1, (screenH * 0.0889) - 1, (screenW * 0.3456) - 1, screenH * 0.8233, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6481, (screenH * 0.0889) - 1, (screenW * 0.3456) - 1, (screenH * 0.0889) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3456) - 1, screenH * 0.8233, screenW * 0.6481, screenH * 0.8233, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6481, screenH * 0.8233, screenW * 0.6481, (screenH * 0.0889) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3456, screenH * 0.0889, screenW * 0.3025, screenH * 0.7344, tocolor(2,105,156, 162), false)
        dxDrawImage(screenW * 0.3719, screenH * 0.1000, screenW * 0.2000, screenH * 0.1000, ":login/assets/img/countryside.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawLine(screenW * 0.3588, screenH * 0.2856, screenW * 0.6375, screenH * 0.2856, tocolor(255, 255, 255, 255), 1, false)
        dxDrawText("Jugadores conectados: "..#tabplayers.."/200", screenW * 0.3713, screenH * 0.2056, screenW * 0.6212, screenH * 0.2311, tocolor(255, 255, 255, 255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText("Nombre", screenW * 0.3887, screenH * 0.2522, screenW * 0.5188, screenH * 0.2856, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false)
        dxDrawText("ID", screenW * 0.3575, screenH * 0.2522, screenW * 0.3856, screenH * 0.2856, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false)
        dxDrawText("Ping", screenW * 0.5188, screenH * 0.2522, screenW * 0.5781, screenH * 0.2856, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false)
        dxDrawText("E.R", screenW * 0.5781, screenH * 0.2522, screenW * 0.6375, screenH * 0.2856, tocolor(255, 255, 255, 255), 1.00, bold, "center", "center", false, false, false, false, false)
        
        dxDrawText(tabplayers[player_index].id, screenW * 0.3575, screenH * 0.2967, screenW * 0.3856, screenH * 0.3300, tocolor(tabplayers[player_index].r,tabplayers[player_index].g,tabplayers[player_index].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index].name, screenW * 0.3887, screenH * 0.2967, screenW * 0.5188, screenH * 0.3300, tocolor(tabplayers[player_index].r,tabplayers[player_index].g,tabplayers[player_index].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index].ping, screenW * 0.5188, screenH * 0.2967, screenW * 0.5781, screenH * 0.3300, tocolor(tabplayers[player_index].r,tabplayers[player_index].g,tabplayers[player_index].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index].er, screenW * 0.5781, screenH * 0.2967, screenW * 0.6375, screenH * 0.3300, tocolor(tabplayers[player_index].r,tabplayers[player_index].g,tabplayers[player_index].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        
        if tabplayers[player_index+1] ~= nil then
        dxDrawText(tabplayers[player_index+1].id, screenW * 0.3575, screenH * 0.3300, screenW * 0.3856, screenH * 0.3633, tocolor(tabplayers[player_index+1].r,tabplayers[player_index+1].g,tabplayers[player_index].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+1].name, screenW * 0.3887, screenH * 0.3300, screenW * 0.5188, screenH * 0.3633, tocolor(tabplayers[player_index+1].r,tabplayers[player_index+1].g,tabplayers[player_index+1].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+1].ping, screenW * 0.5188, screenH * 0.3300, screenW * 0.5781, screenH * 0.3633, tocolor(tabplayers[player_index+1].r,tabplayers[player_index+1].g,tabplayers[player_index+1].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+1].er, screenW * 0.5781, screenH * 0.3300, screenW * 0.6375, screenH * 0.3633, tocolor(tabplayers[player_index+1].r,tabplayers[player_index+1].g,tabplayers[player_index+1].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        
        if tabplayers[player_index+2] ~= nil then
        dxDrawText(tabplayers[player_index+2].id, screenW * 0.3575, screenH * 0.3633, screenW * 0.3856, screenH * 0.3967, tocolor(tabplayers[player_index+2].r,tabplayers[player_index+2].g,tabplayers[player_index+2].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+2].name, screenW * 0.3887, screenH * 0.3633, screenW * 0.5188, screenH * 0.3967, tocolor(tabplayers[player_index+2].r,tabplayers[player_index+2].g,tabplayers[player_index+2].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+2].ping, screenW * 0.5188, screenH * 0.3633, screenW * 0.5781, screenH * 0.3967, tocolor(tabplayers[player_index+2].r,tabplayers[player_index+2].g,tabplayers[player_index+2].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+2].er, screenW * 0.5781, screenH * 0.3633, screenW * 0.6375, screenH * 0.3967, tocolor(tabplayers[player_index+2].r,tabplayers[player_index+2].g,tabplayers[player_index+2].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+3] ~= nil then
        dxDrawText(tabplayers[player_index+3].id, screenW * 0.3575, screenH * 0.3967, screenW * 0.3856, screenH * 0.4300, tocolor(tabplayers[player_index+3].r,tabplayers[player_index+3].g,tabplayers[player_index+3].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+3].name, screenW * 0.3887, screenH * 0.3967, screenW * 0.5188, screenH * 0.4300, tocolor(tabplayers[player_index+3].r,tabplayers[player_index+3].g,tabplayers[player_index+3].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+3].ping, screenW * 0.5188, screenH * 0.3967, screenW * 0.5781, screenH * 0.4300, tocolor(tabplayers[player_index+3].r,tabplayers[player_index+3].g,tabplayers[player_index+3].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+3].er, screenW * 0.5781, screenH * 0.3967, screenW * 0.6375, screenH * 0.4300, tocolor(tabplayers[player_index+3].r,tabplayers[player_index+3].g,tabplayers[player_index+3].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+4] ~= nil then
        dxDrawText(tabplayers[player_index+4].id, screenW * 0.3575, screenH * 0.4300, screenW * 0.3856, screenH * 0.4633, tocolor(tabplayers[player_index+4].r,tabplayers[player_index+4].g,tabplayers[player_index+4].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+4].name, screenW * 0.3887, screenH * 0.4300, screenW * 0.5188, screenH * 0.4633, tocolor(tabplayers[player_index+4].r,tabplayers[player_index+4].g,tabplayers[player_index+4].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+4].ping, screenW * 0.5188, screenH * 0.4300, screenW * 0.5781, screenH * 0.4633, tocolor(tabplayers[player_index+4].r,tabplayers[player_index+4].g,tabplayers[player_index+4].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+4].er, screenW * 0.5781, screenH * 0.4300, screenW * 0.6375, screenH * 0.4633, tocolor(tabplayers[player_index+4].r,tabplayers[player_index+4].g,tabplayers[player_index+4].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+5] ~= nil then
        dxDrawText(tabplayers[player_index+5].id, screenW * 0.3575, screenH * 0.4633, screenW * 0.3856, screenH * 0.4967, tocolor(tabplayers[player_index+5].r,tabplayers[player_index+5].g,tabplayers[player_index+5].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+5].name, screenW * 0.3887, screenH * 0.4633, screenW * 0.5188, screenH * 0.4967, tocolor(tabplayers[player_index+5].r,tabplayers[player_index+5].g,tabplayers[player_index+5].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+5].ping, screenW * 0.5188, screenH * 0.4633, screenW * 0.5781, screenH * 0.4967, tocolor(tabplayers[player_index+5].r,tabplayers[player_index+5].g,tabplayers[player_index+5].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+5].er, screenW * 0.5781, screenH * 0.4633, screenW * 0.6375, screenH * 0.4967, tocolor(tabplayers[player_index+5].r,tabplayers[player_index+5].g,tabplayers[player_index+5].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+6] ~= nil then
        dxDrawText(tabplayers[player_index+6].id, screenW * 0.3575, screenH * 0.4967, screenW * 0.3856, screenH * 0.5300, tocolor(tabplayers[player_index+6].r,tabplayers[player_index+6].g,tabplayers[player_index+6].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+6].name, screenW * 0.3887, screenH * 0.4967, screenW * 0.5188, screenH * 0.5300, tocolor(tabplayers[player_index+6].r,tabplayers[player_index+6].g,tabplayers[player_index+6].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+6].ping, screenW * 0.5188, screenH * 0.4967, screenW * 0.5781, screenH * 0.5300, tocolor(tabplayers[player_index+6].r,tabplayers[player_index+6].g,tabplayers[player_index+6].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+6].er, screenW * 0.5781, screenH * 0.4967, screenW * 0.6375, screenH * 0.5300, tocolor(tabplayers[player_index+6].r,tabplayers[player_index+6].g,tabplayers[player_index+6].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+7] ~= nil then
        dxDrawText(tabplayers[player_index+7].id, screenW * 0.3575, screenH * 0.5300, screenW * 0.3856, screenH * 0.5633, tocolor(tabplayers[player_index+7].r,tabplayers[player_index+7].g,tabplayers[player_index+7].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+7].name, screenW * 0.3887, screenH * 0.5300, screenW * 0.5188, screenH * 0.5633, tocolor(tabplayers[player_index+7].r,tabplayers[player_index+7].g,tabplayers[player_index+7].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+7].ping, screenW * 0.5188, screenH * 0.5300, screenW * 0.5781, screenH * 0.5633, tocolor(tabplayers[player_index+7].r,tabplayers[player_index+7].g,tabplayers[player_index+7].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+7].er, screenW * 0.5781, screenH * 0.5300, screenW * 0.6375, screenH * 0.5633, tocolor(tabplayers[player_index+7].r,tabplayers[player_index+7].g,tabplayers[player_index+7].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+8] ~= nil then
        dxDrawText(tabplayers[player_index+8].id, screenW * 0.3575, screenH * 0.5633, screenW * 0.3856, screenH * 0.5967, tocolor(tabplayers[player_index+8].r,tabplayers[player_index+8].g,tabplayers[player_index+8].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+8].name, screenW * 0.3887, screenH * 0.5633, screenW * 0.5188, screenH * 0.5967, tocolor(tabplayers[player_index+8].r,tabplayers[player_index+8].g,tabplayers[player_index+8].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+8].ping, screenW * 0.5188, screenH * 0.5633, screenW * 0.5781, screenH * 0.5967, tocolor(tabplayers[player_index+8].r,tabplayers[player_index+8].g,tabplayers[player_index+8].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+8].er, screenW * 0.5781, screenH * 0.5633, screenW * 0.6375, screenH * 0.5967, tocolor(tabplayers[player_index+8].r,tabplayers[player_index+8].g,tabplayers[player_index+8].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+9] ~= nil then
        dxDrawText(tabplayers[player_index+9].id, screenW * 0.3575, screenH * 0.5967, screenW * 0.3856, screenH * 0.6300, tocolor(tabplayers[player_index+9].r,tabplayers[player_index+9].g,tabplayers[player_index+9].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
       
        dxDrawText(tabplayers[player_index+9].name, screenW * 0.3887, screenH * 0.5967, screenW * 0.5188, screenH * 0.6300, tocolor(tabplayers[player_index+9].r,tabplayers[player_index+9].g,tabplayers[player_index+9].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+9].ping, screenW * 0.5188, screenH * 0.5967, screenW * 0.5781, screenH * 0.6300, tocolor(tabplayers[player_index+9].r,tabplayers[player_index+9].g,tabplayers[player_index+9].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+9].er, screenW * 0.5781, screenH * 0.5967, screenW * 0.6375, screenH * 0.6300, tocolor(tabplayers[player_index+9].r,tabplayers[player_index+9].g,tabplayers[player_index+9].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+10] ~= nil then
        dxDrawText(tabplayers[player_index+10].id, screenW * 0.3575, screenH * 0.6300, screenW * 0.3856, screenH * 0.6633, tocolor(tabplayers[player_index+10].r,tabplayers[player_index+10].g,tabplayers[player_index+10].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        
        dxDrawText(tabplayers[player_index+10].name, screenW * 0.3887, screenH * 0.6300, screenW * 0.5188, screenH * 0.6633, tocolor(tabplayers[player_index+10].r,tabplayers[player_index+10].g,tabplayers[player_index+10].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+10].ping, screenW * 0.5188, screenH * 0.6300, screenW * 0.5781, screenH * 0.6633, tocolor(tabplayers[player_index+10].r,tabplayers[player_index+10].g,tabplayers[player_index+10].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+10].er, screenW * 0.5781, screenH * 0.6300, screenW * 0.6375, screenH * 0.6633, tocolor(tabplayers[player_index+10].r,tabplayers[player_index+10].g,tabplayers[player_index+10].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        if tabplayers[player_index+11] ~= nil then
        dxDrawText(tabplayers[player_index+11].id, screenW * 0.3575, screenH * 0.6633, screenW * 0.3856, screenH * 0.6967, tocolor(tabplayers[player_index+11].r,tabplayers[player_index+11].g,tabplayers[player_index+11].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        
        dxDrawText(tabplayers[player_index+11].name, screenW * 0.3887, screenH * 0.6633, screenW * 0.5188, screenH * 0.6967, tocolor(tabplayers[player_index+11].r,tabplayers[player_index+11].g,tabplayers[player_index+11].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+11].ping, screenW * 0.5188, screenH * 0.6633, screenW * 0.5781, screenH * 0.6967, tocolor(tabplayers[player_index+11].r,tabplayers[player_index+11].g,tabplayers[player_index+11].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        dxDrawText(tabplayers[player_index+11].er, screenW * 0.5781, screenH * 0.6633, screenW * 0.6375, screenH * 0.6967, tocolor(tabplayers[player_index+11].r,tabplayers[player_index+11].g,tabplayers[player_index+11].b,255), 1.00, regular, "center", "center", false, false, false, false, false)
        end
        dxDrawLine(screenW * 0.3575, screenH * 0.7078, screenW * 0.6362, screenH * 0.7078, tocolor(255, 255, 255, 255), 1, false)
        end
    end
)

    r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )

local screenW, screenH = guiGetScreenSize()
local factionID = false
local Frights = 0
local i_m = 1
local faccInfo = false
local members = false
local ranks = false
local factionsPlayer = false
local indexFaction = 1
local indexRank = 1
local factionOption = false
local lcharID
function isCursorHover( posX, posY, width, height )
    if isCursorShowing( ) then
        local mouseX, mouseY = getCursorPosition( )
        local clientW, clientH = guiGetScreenSize( )
        local mouseX, mouseY = mouseX * clientW, mouseY * clientH
        if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
            return true
        end
    end
    return false
end

function openFaction(faccID, rights)
    if not factionID then
        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,faccID[1])
        factionsPlayer = faccID
        factionID = faccID[1]
        Frights = rights
        showCursor(true)
        guiSetInputMode("no_binds_when_editing")
    else
        factionID = false
        member_selected = 0
        factionOption = false
        if isElement(facc_option_edit) then
            destroyElement(facc_option_edit)
        end
        showCursor(false)
        guiSetInputMode("allow_binds")
    end
end
addEvent('open:faction',true)
addEventHandler('open:faction', localPlayer, openFaction)
local rank_states = {
    [0] = "Miembro",
    [1] = "Líder",
    [2] = "Encargado",
    [3] = "Dueño"
}
function updateFactionData( miembros, rangos, info, localCharID )
    faccInfo = info
    members = miembros
    ranks = rangos
    lcharID = localCharID
end
addEvent('update_faction',true)
addEventHandler('update_faction',localPlayer,updateFactionData)

function tlc(seconds)
    if seconds == "conectado" then
        return "Conectado"
    elseif seconds < 86400 then
        return "Hoy"
    else
        local horas = seconds/3600
        if horas < 48 then
            return "Ayer"
        else
            local dias = seconds/86400
            return "Hace "..math.floor(dias).." días"
        end
    end
end
function colorflc( tipo )
    local color_lc = {
        [1] = {157, 202, 128, 204},
        [2] = {254, 254, 254, 204}
    }
    if tipo == "Conectado" then
        return color_lc[1]
    else
        return color_lc[2]
    end
end
function getSueldoFromLocalPlayer()
    for i, member in ipairs(members) do
        if member[1] == lcharID then
            return member[5]
        end
    end
    return false
end


bindKey( "mouse_wheel_up", "down", function( )
    
    if factionOption == "Editar rangos" then
        if indexRank > 1 then
            indexRank = indexRank - 1
        end   
    elseif factionID then
        if i_m > 1 then
            i_m = i_m - 1
        end
    end
end)

bindKey( "mouse_wheel_down", "down", function( )
    if factionOption == "Editar rangos" then
        if indexRank+3 < contarPosiciones() then
            indexRank = indexRank+1
        end
    elseif factionID then
        if i_m+4 < #members then
            i_m = i_m+1
        end
    end
end)

local roboto_title = dxCreateFont(":personajes/fonts/Roboto-BoldCondensed.ttf", 20)
local roboto_regular = dxCreateFont(":personajes/fonts/Roboto-Regular.ttf", 11)
local roboto_boldcondensed = dxCreateFont(":personajes/fonts/Roboto-BoldCondensed.ttf", 10)
local roboto_italic = dxCreateFont(":personajes/fonts/Roboto-Italic.ttf", 8)
local roboto_condensed = dxCreateFont(":personajes/fonts/Roboto-Condensed.ttf", 10)

local member_selected = 0
local rank_selected = -1
function contarPosiciones()
    local conteo = 0
    for i,v in pairs(ranks) do
        conteo = conteo +1
    end
    return conteo
end
function getRankFromIndexRank( index )
    for i,v in pairs(ranks) do
        if ranks[i][1] == index then
            return true
        end
    end
    return false
end
function getRankNameFromIndexRank( index )
    for i,v in pairs(ranks) do
        if ranks[i][1] == index then
            return ranks[i][2]
        end
    end
    return false
end
addEventHandler("onClientRender", root,
    function()
        if factionID and faccInfo then
            if isCursorHover(screenW * 0.3212, screenH * 0.4222, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.4222, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 166), false)
            elseif member_selected == i_m then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.4222, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 200), false)
            end
            if isCursorHover(screenW * 0.3212, screenH * 0.4533, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+1 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.4533, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 166), false)
            elseif member_selected == i_m+1 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.4533, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 200), false)
            end
            if isCursorHover(screenW * 0.3212, screenH * 0.4844, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+2 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.4844, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 166), false)
            elseif member_selected == i_m+2 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.4844, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 200), false)
            end
            if isCursorHover(screenW * 0.3212, screenH * 0.5156, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+3 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.5156, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 166), false)
            elseif member_selected == i_m+3 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.5156, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 200), false)
            end
            if isCursorHover(screenW * 0.3212, screenH * 0.5467, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+4 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.5467, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 166), false)
            elseif member_selected == i_m+4 then
                dxDrawRectangle(screenW * 0.3212, screenH * 0.5467, screenW * 0.3675, screenH * 0.0311, tocolor(34,94,122, 200), false)
            end
        dxDrawRectangle(screenW * 0.3181, screenH * 0.3211, screenW * 0.3775, screenH * 0.5011, tocolor(2,105,156, 161), false)
        dxDrawRectangle(screenW * 0.3181, screenH * 0.2456, screenW * 0.3775, screenH * 0.0644, tocolor(2,105,156, 204), false)
        dxDrawText("[ID: "..factionID.."] "..faccInfo.name, screenW * 0.3181, screenH * 0.2456, screenW * 0.6944, screenH * 0.3100, tocolor(255, 255, 255, 255), 1.00, roboto_title, "center", "center", false, false, false, false, false)
        if Frights > 0 then
            if isCursorHover(screenW * 0.3594, screenH * 0.3367, screenW * 0.1037, screenH * 0.0278) then    
                dxDrawText("Presupuesto: $"..faccInfo.presupuesto, screenW * 0.3181, screenH * 0.3267, screenW * 0.5038, screenH * 0.3789, tocolor(1,1,1, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Presupuesto: $"..faccInfo.presupuesto, screenW * 0.3181, screenH * 0.3267, screenW * 0.5038, screenH * 0.3789, tocolor(255, 255, 255, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
            end
        dxDrawText("Subvención: $"..faccInfo.subvencion, screenW * 0.5088, screenH * 0.3267, screenW * 0.6944, screenH * 0.3789, tocolor(255, 255, 255, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
        dxDrawText("Sueldo", screenW * 0.5481, screenH * 0.3900, screenW * 0.6094, screenH * 0.4233, tocolor(255, 255, 255, 255), 1.00, roboto_boldcondensed, "center", "center", false, false, false, false, false)
        end
        dxDrawText("Nombre", screenW * 0.3244, screenH * 0.3911, screenW * 0.4131, screenH * 0.4233, tocolor(255, 255, 255, 255), 1.00, roboto_boldcondensed, "center", "center", false, false, false, false, false)
        dxDrawText("Rango", screenW * 0.4131, screenH * 0.3900, screenW * 0.4931, screenH * 0.4233, tocolor(255, 255, 255, 255), 1.00, roboto_boldcondensed, "center", "center", false, false, false, false, false)
        dxDrawText("Permisos", screenW * 0.4931, screenH * 0.3900, screenW * 0.5481, screenH * 0.4233, tocolor(255, 255, 255, 255), 1.00, roboto_boldcondensed, "center", "center", false, false, false, false, false)
        dxDrawText("Última conexión", screenW * 0.6094, screenH * 0.3900, screenW * 0.6894, screenH * 0.4233, tocolor(255, 255, 255, 255), 1.00, roboto_boldcondensed, "center", "center", false, false, false, false, false)
        if members[i_m] ~= nil then
            dxDrawText(string.gsub(members[i_m][2],"_"," "), screenW * 0.3244, screenH * 0.4233, screenW * 0.4131, screenH * 0.4556, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(ranks[members[i_m][4]][2], screenW * 0.4131, screenH * 0.4233, screenW * 0.4931, screenH * 0.4556, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(rank_states[members[i_m][3]], screenW * 0.4931, screenH * 0.4233, screenW * 0.5481, screenH * 0.4556, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            if Frights > 0 then
            dxDrawText("$ "..members[i_m][5], screenW * 0.5481, screenH * 0.4233, screenW * 0.6094, screenH * 0.4556, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end
            dxDrawText(tlc(members[i_m][6]), screenW * 0.6094, screenH * 0.4233, screenW * 0.6894, screenH * 0.4556, tocolor(unpack(colorflc(tlc(members[i_m][6])))), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
        end
        if members[i_m+1] ~= nil then
            dxDrawText(string.gsub(members[i_m+1][2],"_"," "), screenW * 0.3244, screenH * 0.4556, screenW * 0.4131, screenH * 0.4878, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(ranks[members[i_m+1][4]][2], screenW * 0.4131, screenH * 0.4556, screenW * 0.4931, screenH * 0.4878, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(rank_states[members[i_m+1][3]], screenW * 0.4931, screenH * 0.4556, screenW * 0.5481, screenH * 0.4878, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            if Frights > 0 then
            dxDrawText("$ "..members[i_m+1][5], screenW * 0.5481, screenH * 0.4556, screenW * 0.6094, screenH * 0.4878, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end
            dxDrawText(tlc(members[i_m+1][6]), screenW * 0.6094, screenH * 0.4556, screenW * 0.6894, screenH * 0.4878, tocolor(unpack(colorflc(tlc(members[i_m+1][6])))), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
        end
        if members[i_m+2] ~= nil then
            dxDrawText(string.gsub(members[i_m+2][2],"_"," "), screenW * 0.3244, screenH * 0.4878, screenW * 0.4131, screenH * 0.5200, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(ranks[members[i_m+2][4]][2], screenW * 0.4131, screenH * 0.4878, screenW * 0.4931, screenH * 0.5200, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(rank_states[members[i_m+2][3]], screenW * 0.4931, screenH * 0.4878, screenW * 0.5481, screenH * 0.5200, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            if Frights > 0 then
            dxDrawText("$ "..members[i_m+2][5], screenW * 0.5481, screenH * 0.4878, screenW * 0.6094, screenH * 0.5200, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end
            dxDrawText(tlc(members[i_m+2][6]), screenW * 0.6094, screenH * 0.4878, screenW * 0.6894, screenH * 0.5200, tocolor(unpack(colorflc(tlc(members[i_m+2][6])))), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
        end
        if members[i_m+3] ~= nil then
            dxDrawText(string.gsub(members[i_m+3][2],"_"," "), screenW * 0.3244, screenH * 0.5200, screenW * 0.4131, screenH * 0.5522, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(ranks[members[i_m+3][4]][2], screenW * 0.4131, screenH * 0.5200, screenW * 0.4931, screenH * 0.5522, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(rank_states[members[i_m+3][3]], screenW * 0.4931, screenH * 0.5200, screenW * 0.5481, screenH * 0.5522, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            if Frights > 0 then
            dxDrawText("$ "..members[i_m+3][5], screenW * 0.5481, screenH * 0.5200, screenW * 0.6094, screenH * 0.5522, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end
            dxDrawText(tlc(members[i_m+3][6]), screenW * 0.6094, screenH * 0.5200, screenW * 0.6894, screenH * 0.5522, tocolor(unpack(colorflc(tlc(members[i_m+3][6])))), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
        end
        if members[i_m+4] ~= nil then
            dxDrawText(string.gsub(members[i_m+4][2],"_"," "), screenW * 0.3244, screenH * 0.5522, screenW * 0.4131, screenH * 0.5844, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(ranks[members[i_m+4][4]][2], screenW * 0.4131, screenH * 0.5522, screenW * 0.4931, screenH * 0.5844, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            dxDrawText(rank_states[members[i_m+4][3]], screenW * 0.4931, screenH * 0.5522, screenW * 0.5481, screenH * 0.5844, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            if Frights > 0 then
            dxDrawText("$ "..members[i_m+4][5], screenW * 0.5481, screenH * 0.5522, screenW * 0.6094, screenH * 0.5844, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end
            dxDrawText(tlc(members[i_m+4][6]), screenW * 0.6094, screenH * 0.5522, screenW * 0.6894, screenH * 0.5844, tocolor(unpack(colorflc(tlc(members[i_m+4][6])))), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
        end

        dxDrawLine(screenW * 0.3219, screenH * 0.4178, screenW * 0.6894, screenH * 0.4178, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(screenW * 0.3219, screenH * 0.5900, screenW * 0.6894, screenH * 0.5900, tocolor(255, 255, 255, 255), 1, false)
        if Frights > 0 then
            if isCursorHover(screenW * 0.4206, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) then
                dxDrawText("Invitar", screenW * 0.4144, screenH * 0.7744, screenW * 0.4763, screenH * 0.8111, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Invitar", screenW * 0.4144, screenH * 0.7744, screenW * 0.4763, screenH * 0.8111, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            end
        end
        if Frights == 3 then
            if isCursorHover(screenW * 0.5444, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) then
                dxDrawText("Editar rangos", screenW * 0.5381, screenH * 0.7744, screenW * 0.6000, screenH * 0.8111, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Editar rangos", screenW * 0.5381, screenH * 0.7744, screenW * 0.6000, screenH * 0.8111, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            end
        
            if isCursorHover(screenW * 0.6069, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) then
                dxDrawText("Propiedades", screenW * 0.6000, screenH * 0.7744, screenW * 0.6619, screenH * 0.8111, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Propiedades", screenW * 0.6000, screenH * 0.7744, screenW * 0.6619, screenH * 0.8111, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            end

            if isCursorHover(screenW * 0.3588, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) then
                dxDrawText("Renombrar", screenW * 0.3525, screenH * 0.7744, screenW * 0.4144, screenH * 0.8111, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Renombrar", screenW * 0.3525, screenH * 0.7744, screenW * 0.4144, screenH * 0.8111, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            end
        end
        
        if isCursorHover(screenW * 0.4806, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) then
            dxDrawText("Abandonar", screenW * 0.4763, screenH * 0.7744, screenW * 0.5381, screenH * 0.8111, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
        else
            dxDrawText("Abandonar", screenW * 0.4763, screenH * 0.7744, screenW * 0.5381, screenH * 0.8111, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
        end
        
        if #members > 5 then
            dxDrawText("Usa la rueda del ratón para bajar en la lista de miembros", screenW * 0.3219, screenH * 0.5978, screenW * 0.6894, screenH * 0.6233, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
        end

        if Frights == 0 then
             dxDrawText("Tu sueldo: $"..getSueldoFromLocalPlayer(), screenW * 0.3406, screenH * 0.6789, screenW * 0.6700, screenH * 0.7456, tocolor(255, 255, 255, 255), 1.00, roboto_title, "center", "center", false, false, false, false, false)
        end
        if factionOption == false then
            if member_selected ~= 0 and Frights > 0 then
            dxDrawLine(screenW * 0.3219, screenH * 0.6267, screenW * 0.6900, screenH * 0.6267, tocolor(255, 255, 255, 255), 1, false)
            dxDrawText(string.gsub(members[member_selected][2],"_"," "), screenW * 0.3225, screenH * 0.6378, screenW * 0.6900, screenH * 0.6633, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
        

            if isCursorHover(screenW * 0.4800, screenH * 0.6656, screenW * 0.0563, screenH * 0.0267) then
                dxDrawText("Ascender", screenW * 0.4775, screenH * 0.6700, screenW * 0.5350, screenH * 0.6922, tocolor(1,1,1, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Ascender", screenW * 0.4775, screenH * 0.6700, screenW * 0.5350, screenH * 0.6922, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end
            if Frights == 3 then
                if isCursorHover(screenW * 0.4163, screenH * 0.6656, screenW * 0.0625, screenH * 0.0267) then
                    dxDrawText("Subir permisos", screenW * 0.4163, screenH * 0.6700, screenW * 0.4738, screenH * 0.6922, tocolor(1,1,1, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("Subir permisos", screenW * 0.4163, screenH * 0.6700, screenW * 0.4738, screenH * 0.6922, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.4163, screenH * 0.6989, screenW * 0.0625, screenH * 0.0267) then
                    dxDrawText("Bajar permisos", screenW * 0.4163, screenH * 0.6989, screenW * 0.4738, screenH * 0.7211, tocolor(1,1,1, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("Bajar permisos", screenW * 0.4163, screenH * 0.6989, screenW * 0.4738, screenH * 0.7211, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
                end
            end
            if Frights > 1 then
                if isCursorHover(screenW * 0.5387, screenH * 0.6656, screenW * 0.0625, screenH * 0.0267) then
                    dxDrawText("Cambiar sueldo", screenW * 0.5381, screenH * 0.6700, screenW * 0.5956, screenH * 0.6922, tocolor(1,1,1, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("Cambiar sueldo", screenW * 0.5381, screenH * 0.6700, screenW * 0.5956, screenH * 0.6922, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
                end
            end
            if isCursorHover(screenW * 0.5387, screenH * 0.6989, screenW * 0.0625, screenH * 0.0267) then
                dxDrawText("Expulsar", screenW * 0.5381, screenH * 0.6989, screenW * 0.5956, screenH * 0.7211, tocolor(1,1,1, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Expulsar", screenW * 0.5381, screenH * 0.6989, screenW * 0.5956, screenH * 0.7211, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end
            if isCursorHover(screenW * 0.4800, screenH * 0.6989, screenW * 0.0563, screenH * 0.0267) then
                 dxDrawText("Degradar", screenW * 0.4775, screenH * 0.6989, screenW * 0.5350, screenH * 0.7211, tocolor(1,1,1, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Degradar", screenW * 0.4775, screenH * 0.6989, screenW * 0.5350, screenH * 0.7211, tocolor(255, 255, 255, 255), 1.00, roboto_italic, "center", "center", false, false, false, false, false)
            end

            end

        elseif factionOption == "Editar rangos" then

            dxDrawRectangle(screenW * 0.3306, screenH * 0.6078, screenW * 0.3525, screenH * 0.1678, tocolor(1,1,1, 100), false)
            if getRankFromIndexRank(indexRank) then
                if isCursorHover(screenW * 0.4775, screenH * 0.6267, screenW * 0.0575, screenH * 0.0211) then
                    dxDrawText(getRankNameFromIndexRank(indexRank), screenW * 0.4562, screenH * 0.6211, screenW * 0.5600, screenH * 0.6511, tocolor(1,1,1, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                else
                    dxDrawText(getRankNameFromIndexRank(indexRank), screenW * 0.4562, screenH * 0.6211, screenW * 0.5600, screenH * 0.6511, tocolor(255, 255, 255, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                end
            end
            if getRankFromIndexRank(indexRank+1) then
                if isCursorHover(screenW * 0.4775, screenH * 0.6533, screenW * 0.0575, screenH * 0.0211) then
                    dxDrawText(getRankNameFromIndexRank(indexRank+1), screenW * 0.4562, screenH * 0.6511, screenW * 0.5600, screenH * 0.6811, tocolor(1,1,1, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                else
                    dxDrawText(getRankNameFromIndexRank(indexRank+1), screenW * 0.4562, screenH * 0.6511, screenW * 0.5600, screenH * 0.6811, tocolor(255, 255, 255, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                end
            end
            if getRankFromIndexRank(indexRank+2) then
                if isCursorHover(screenW * 0.4775, screenH * 0.6856, screenW * 0.0575, screenH * 0.0211) then
                    dxDrawText(getRankNameFromIndexRank(indexRank+2), screenW * 0.4562, screenH * 0.6811, screenW * 0.5600, screenH * 0.7111, tocolor(1,1,1, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                else
                    dxDrawText(getRankNameFromIndexRank(indexRank+2), screenW * 0.4562, screenH * 0.6811, screenW * 0.5600, screenH * 0.7111, tocolor(255, 255, 255, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                end
            end
            if getRankFromIndexRank(indexRank+3) then
                if isCursorHover(screenW * 0.4775, screenH * 0.7178, screenW * 0.0575, screenH * 0.0233) then
                    dxDrawText(getRankNameFromIndexRank(indexRank+3), screenW * 0.4562, screenH * 0.7111, screenW * 0.5600, screenH * 0.7411, tocolor(1,1,1, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                else
                    dxDrawText(getRankNameFromIndexRank(indexRank+3), screenW * 0.4562, screenH * 0.7111, screenW * 0.5600, screenH * 0.7411, tocolor(255, 255, 255, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
                end
            end
            if contarPosiciones() > 4 then
                dxDrawText("⇊", screenW * 0.6544, screenH * 0.6244, screenW * 0.6806, screenH * 0.6544, tocolor(0, 0, 0, 255), 1.50, "bankgothic", "center", "center", false, false, false, false, false)
            end
            if isCursorHover(screenW * 0.3475, screenH * 0.7322, screenW * 0.0425, screenH * 0.0322) then
                dxDrawText("Nuevo", screenW * 0.2000, screenH * 0.7411, screenW * 0.5369, screenH * 0.7667, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Nuevo", screenW * 0.2000, screenH * 0.7411, screenW * 0.5369, screenH * 0.7667, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            end
            if isCursorHover(screenW * 0.4075, screenH * 0.7422, screenW * 0.0537, screenH * 0.0267) then
                dxDrawText("Confirmar", screenW * 0.3656, screenH * 0.7411, screenW * 0.5069, screenH * 0.7700, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Confirmar", screenW * 0.3656, screenH * 0.7411, screenW * 0.5069, screenH * 0.7700, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            end
            if isCursorHover(screenW * 0.5519, screenH * 0.7422, screenW * 0.0537, screenH * 0.0267) then
                dxDrawText("Cancelar", screenW * 0.5075, screenH * 0.7411, screenW * 0.6488, screenH * 0.7700, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            else
                dxDrawText("Cancelar", screenW * 0.5075, screenH * 0.7411, screenW * 0.6488, screenH * 0.7700, tocolor(255, 255, 255, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
            end
        else
            dxDrawRectangle(screenW * 0.3656, screenH * 0.6711, screenW * 0.2831, screenH * 0.0989, tocolor(1,1,1, 100), false)
            dxDrawText(factionOption, screenW * 0.3663, screenH * 0.6733, screenW * 0.6488, screenH * 0.7022, tocolor(255, 255, 255, 255), 1.00, roboto_regular, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4075, screenH * 0.7422, screenW * 0.0537, screenH * 0.0267) then
                if factionOption == "Gestionar presupuesto" then
                    dxDrawText("Depositar", screenW * 0.3656, screenH * 0.7411, screenW * 0.5069, screenH * 0.7700, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("Confirmar", screenW * 0.3656, screenH * 0.7411, screenW * 0.5069, screenH * 0.7700, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                end
            else
                if factionOption == "Gestionar presupuesto" then
                    dxDrawText("Depositar", screenW * 0.3656, screenH * 0.7411, screenW * 0.5069, screenH * 0.7700, tocolor(255,255,255,255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("Confirmar", screenW * 0.3656, screenH * 0.7411, screenW * 0.5069, screenH * 0.7700, tocolor(255,255,255,255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                end
            end
            if isCursorHover(screenW * 0.5519, screenH * 0.7422, screenW * 0.0537, screenH * 0.0267) then
                if factionOption == "Gestionar presupuesto" then
                    dxDrawText("Retirar", screenW * 0.5075, screenH * 0.7411, screenW * 0.6488, screenH * 0.7700, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("Cancelar", screenW * 0.5075, screenH * 0.7411, screenW * 0.6488, screenH * 0.7700, tocolor(1,1,1, 255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                end
            else
                if factionOption == "Gestionar presupuesto" then
                    dxDrawText("Retirar", screenW * 0.5075, screenH * 0.7411, screenW * 0.6488, screenH * 0.7700, tocolor(255,255,255,255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("Cancelar", screenW * 0.5075, screenH * 0.7411, screenW * 0.6488, screenH * 0.7700, tocolor(255,255,255,255), 1.00, roboto_condensed, "center", "center", false, false, false, false, false)
                end
            end
        end
        

        end
    end
)
function cambiarRankNameFromIndexRank( index, text )
    for i,v in pairs(ranks) do
        if ranks[i][1] == index then
            ranks[i][2] = text
        end
    end
end
function faccClick ( button, state )
    if button == "left" and state == "down" then
        if factionID then
            if isCursorHover(screenW * 0.3219, screenH * 0.4178, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m and members[i_m] ~= nil then
                member_selected = i_m
            elseif isCursorHover(screenW * 0.3212, screenH * 0.4533, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+1 and members[i_m+1] ~= nil  then
                member_selected = i_m+1
            elseif isCursorHover(screenW * 0.3212, screenH * 0.4844, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+2 and members[i_m+2] ~= nil  then
                member_selected = i_m+2
            elseif isCursorHover(screenW * 0.3212, screenH * 0.5156, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+3 and members[i_m+3] ~= nil  then
                member_selected = i_m+3
            elseif isCursorHover(screenW * 0.3212, screenH * 0.5467, screenW * 0.3675, screenH * 0.0311) and member_selected ~= i_m+4 and members[i_m+4] ~= nil  then
                member_selected = i_m+4
            elseif member_selected ~= 0 and members[member_selected] ~= nil and factionOption == false and isCursorHover(screenW * 0.4800, screenH * 0.6656, screenW * 0.0563, screenH * 0.0267) and Frights > 0 then
                triggerServerEvent("facc:ascender", localPlayer,localPlayer,members[member_selected][1],members[member_selected][4],ranks,factionID)
                triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
            elseif member_selected ~= 0 and members[member_selected] ~= nil and factionOption == false  and isCursorHover(screenW * 0.4163, screenH * 0.6656, screenW * 0.0625, screenH * 0.0267) and Frights == 3 then
                triggerServerEvent("facc:permisos", localPlayer,localPlayer,members[member_selected][1],"subir",factionID)
                triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
            elseif member_selected ~= 0 and members[member_selected] ~= nil and factionOption == false  and isCursorHover(screenW * 0.4163, screenH * 0.6989, screenW * 0.0625, screenH * 0.0267) and Frights == 3 then
                triggerServerEvent("facc:permisos", localPlayer,localPlayer,members[member_selected][1],"bajar",factionID)
                triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
            elseif member_selected ~= 0 and members[member_selected] ~= nil and factionOption == false  and isCursorHover(screenW * 0.5387, screenH * 0.6656, screenW * 0.0625, screenH * 0.0267) and Frights > 1 then
                factionOption = "Cambiar sueldo"
                facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
            elseif member_selected ~= 0 and members[member_selected] ~= nil and factionOption == false  and isCursorHover(screenW * 0.5387, screenH * 0.6989, screenW * 0.0625, screenH * 0.0267) and Frights > 0 then
                triggerServerEvent("facc:expulsar", localPlayer,localPlayer,members[member_selected][1],factionID)
                triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                member_selected = 0
            elseif member_selected ~= 0 and members[member_selected] ~= nil and factionOption == false  and isCursorHover(screenW * 0.4800, screenH * 0.6989, screenW * 0.0563, screenH * 0.0267) and Frights > 0 then
                triggerServerEvent("facc:descender", localPlayer,localPlayer,members[member_selected][1],members[member_selected][4],ranks,factionID)
                triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
            elseif factionOption == false  and isCursorHover(screenW * 0.3588, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) and Frights == 3 then
                factionOption = "Renombrar facción"
                facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
            elseif factionOption == false and isCursorHover(screenW * 0.5444, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) and Frights == 3 then
                factionOption = "Editar rangos"
            elseif factionOption == false  and isCursorHover(screenW * 0.4206, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) and Frights > 0 then
                factionOption = "Nombre/ID a invitar"
                facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
            elseif factionOption == false and isCursorHover(screenW * 0.3594, screenH * 0.3367, screenW * 0.1037, screenH * 0.0278) and Frights == 3 then
                factionOption = "Gestionar presupuesto"
                facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
            elseif isCursorHover(screenW * 0.4806, screenH * 0.7744, screenW * 0.0481, screenH * 0.0356) then
                triggerServerEvent("facc:abandonar",localPlayer, localPlayer, factionID)
                openFaction(factionID, Frights)
            elseif factionOption ~= false and isCursorHover(screenW * 0.3306, screenH * 0.6078, screenW * 0.3525, screenH * 0.1678) then
                if isCursorHover(screenW * 0.4075, screenH * 0.7422, screenW * 0.0537, screenH * 0.0267) then--boton confirmar
                    if factionOption == "Cambiar sueldo" then
                        local text = guiGetText(facc_option_edit)
                        triggerServerEvent("facc:cambiarsueldo",localPlayer, localPlayer, members[member_selected][1],text,factionID)
                        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                    elseif factionOption == "Renombrar facción" then
                        local text = guiGetText(facc_option_edit)
                        triggerServerEvent("facc:renombrar",localPlayer,localPlayer,text,factionID)
                        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                    elseif factionOption == "Nombre/ID a invitar" then
                        local text = guiGetText(facc_option_edit)
                        triggerServerEvent("facc:invitar",localPlayer,localPlayer,text,factionID)
                        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                    elseif factionOption == "Gestionar presupuesto" then
                        local text = guiGetText(facc_option_edit)
                        triggerServerEvent("facc:depositar",localPlayer,localPlayer,text,factionID)
                        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                    elseif factionOption == "Editar rango" then
                        local text = guiGetText(facc_option_edit)
                        if #text > 1 then
                            cambiarRankNameFromIndexRank(indexRank+rank_selected, text)
                            member_selected = 0
                            rank_selected = -1
                            indexRank = 1
                            factionOption = "Editar rangos"
                            if isElement(facc_option_edit) then
                                destroyElement(facc_option_edit)
                            end
                        else
                            exports.login:addNotification("Rango incorrectamente definido", "error")
                        end
                    elseif factionOption == "Editar rangos" then
                        triggerServerEvent("facc:actualizar_rangos",localPlayer,localPlayer,ranks,factionID)
                        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                    elseif factionOption == "Nuevo rango" then
                        local text = guiGetText(facc_option_edit)
                        triggerServerEvent("facc:nuevo_rango",localPlayer,localPlayer,text,factionID,contarPosiciones())
                        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                        member_selected = 0
                        rank_selected = -1
                        indexRank = 1
                        destroyElement(facc_option_edit)
                        factionOption = "Editar rangos"
                    end
                elseif isCursorHover(screenW * 0.5519, screenH * 0.7422, screenW * 0.0537, screenH * 0.0267) then--boton cancelar
                    if factionOption == "Gestionar presupuesto" then
                        local text = guiGetText(facc_option_edit)
                        triggerServerEvent("facc:retirar",localPlayer,localPlayer,text,factionID)
                        triggerServerEvent("trigger_facc_info",localPlayer,localPlayer,factionID)
                    else
                        factionOption = false
                        if isElement(facc_option_edit) then
                            destroyElement(facc_option_edit)
                        end
                    end
                elseif factionOption == "Editar rangos" then
                    if isCursorHover(screenW * 0.4775, screenH * 0.6267, screenW * 0.0575, screenH * 0.0211) and getRankFromIndexRank(indexRank) then
                        factionOption = "Editar rango"
                        facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
                        rank_selected = 0
                    elseif isCursorHover(screenW * 0.4775, screenH * 0.6533, screenW * 0.0575, screenH * 0.0211) and getRankFromIndexRank(indexRank+1) then
                        factionOption = "Editar rango"
                        facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
                        rank_selected = 1
                    elseif isCursorHover(screenW * 0.4775, screenH * 0.6856, screenW * 0.0575, screenH * 0.0211) and getRankFromIndexRank(indexRank+2) then
                        factionOption = "Editar rango"
                        facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
                        rank_selected = 2
                    elseif isCursorHover(screenW * 0.4775, screenH * 0.7178, screenW * 0.0575, screenH * 0.0233) and getRankFromIndexRank(indexRank+3) then
                        factionOption = "Editar rango"
                        facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
                        rank_selected = 3
                    elseif isCursorHover(screenW * 0.3475, screenH * 0.7322, screenW * 0.0425, screenH * 0.0322) then 
                        factionOption = "Nuevo rango"
                        facc_option_edit = guiCreateEdit(0.46, 0.71, 0.09, 0.03, "", true)
                    end
                end
            else
                member_selected = 0
                rank_selected = -1
                indexRank = 1
                factionOption = false
                if isElement(facc_option_edit) then
                    destroyElement(facc_option_edit)
                end
            end
        
        end
    end
end 
addEventHandler ( "onClientClick", getRootElement(), faccClick )


        -- dxDrawRectangle(screenW * 0.4775, screenH * 0.6267, screenW * 0.0575, screenH * 0.0211, tocolor(255, 255, 255, 255), false)
        -- dxDrawRectangle(screenW * 0.4775, screenH * 0.6533, screenW * 0.0575, screenH * 0.0211, tocolor(255, 255, 255, 255), false)
        -- dxDrawRectangle(screenW * 0.4775, screenH * 0.6856, screenW * 0.0575, screenH * 0.0211, tocolor(255, 255, 255, 255), false)
        -- dxDrawRectangle(screenW * 0.4775, screenH * 0.7178, screenW * 0.0575, screenH * 0.0233, tocolor(255, 255, 255, 255), false)
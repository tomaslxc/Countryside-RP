r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  16)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 8 )
r_thin = dxCreateFont( ":fuentes/Roboto-Thin.ttf", 8 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )

local screenW, screenH = guiGetScreenSize()
bank_main_panel = false
tipo_banco = false
tarjetas = false
cuentas = false
indicetarjeta = 1

cuentagestionada = false

function isCajeroAbierto()
    return bank_main_panel
end

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

function cancelPedDamage ( attacker )
    if getElementData(source, "bankArray") then
    cancelEvent()
    end
end
addEventHandler ( "onClientPedDamage", getRootElement(), cancelPedDamage )
sueldoPendiente = false
function openBankPanel(bankArray, cuentas_usuario,sueldoP)
    if not bank_main_panel and not exports.items:isInventoryOpened() and not exports.vehiculos:isMaleteroOpened() then
    tipo_banco = bankArray.tipo
    tarjetas = exports.items:getItemsFromIDC(18)
    bank_main_panel = true
    showCursor(true)
    cuentas = cuentas_usuario
    sueldoPendiente = sueldoP
    end
end
addEvent("bank:open", true)
addEventHandler("bank:open", localPlayer, openBankPanel)

function frac(cuenta)
    local cstring = tostring(cuenta)
    local part1 = string.sub(cstring, 1, 3)
    local part2 = string.sub(cstring, 4, 6)
    local part3 = string.sub(cstring, 7, 10)
    return part1.."-"..part2.."-"..part3
end


addEventHandler("onClientRender", root,
function()
    if bank_main_panel then
        dxDrawRectangle(screenW * 0.3756, screenH * 0.2133, screenW * 0.2575, screenH * 0.5367, tocolor(34,94,122, 166), false)
        dxDrawRectangle(screenW * 0.3756, screenH * 0.1467, screenW * 0.2575, screenH * 0.0611, tocolor(2,105,156, 234), false)
    if tipo_banco == 1 then
        if focus_cuenta == 11 then
            dxDrawText("#"..frac(cuentagestionada.id), screenW * 0.3750, screenH * 0.1467, screenW * 0.6331, screenH * 0.2078, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        else
            dxDrawText("Banco de Idlewood", screenW * 0.3750, screenH * 0.1467, screenW * 0.6331, screenH * 0.2078, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end
        dxDrawText("Tus cuentas bancarias", screenW * 0.3750, screenH * 0.2144, screenW * 0.6331, screenH * 0.2656, tocolor(0, 0, 0, 234), 0.7, r_title, "center", "center", false, false, false, false, false)


        if isCursorHover(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(34,94,122, 255), false)
        else
            dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(34,94,122, 166), false)
        end
        if cuentas[1] ~= nil then
            dxDrawImage(screenW * 0.3812, screenH * 0.2767, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Número de cuenta:", screenW * 0.4431, screenH * 0.2767, screenW * 0.6269, screenH * 0.3211, tocolor(0, 0, 0, 234), 1.00, r_text, "center", "center", false, false, false, false, false)
            dxDrawText("# "..frac(cuentas[1].id), screenW * 0.4431, screenH * 0.3211, screenW * 0.6269, screenH * 0.3656, tocolor(0, 0, 0, 234), 1.00, r_desc, "center", "center", false, false, false, false, false)
        else
            dxDrawImage(screenW * 0.3812, screenH * 0.2767, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Crear nueva cuenta", screenW * 0.4412, screenH * 0.2711, screenW * 0.6319, screenH * 0.3800, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end

        if isCursorHover(screenW * 0.3750, screenH * 0.4067, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then
            dxDrawRectangle(screenW * 0.3750, screenH * 0.4067, screenW * 0.2575, screenH * 0.1100, tocolor(34,94,122, 255), false)
        else
            dxDrawRectangle(screenW * 0.3750, screenH * 0.4067, screenW * 0.2575, screenH * 0.1100, tocolor(34,94,122, 166), false)
        end
        if cuentas[2] ~= nil then
            dxDrawImage(screenW * 0.3812, screenH * 0.4133, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Número de cuenta:", screenW * 0.4431, screenH * 0.5500, screenW * 0.6269, screenH * 0.3211, tocolor(0, 0, 0, 234), 1.00, r_text, "center", "center", false, false, false, false, false)
            dxDrawText("# "..frac(cuentas[2].id), screenW * 0.4431, screenH * 0.5945, screenW * 0.6269, screenH * 0.3656, tocolor(0, 0, 0, 234), 1.00, r_desc, "center", "center", false, false, false, false, false)
        else
            dxDrawImage(screenW * 0.3812, screenH * 0.4133, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Crear nueva cuenta", screenW * 0.4412, screenH * 0.4078, screenW * 0.6319, screenH * 0.5167, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end

        if focus_cuenta == 1 then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(0,0,0,150), false)
            dxDrawText("PIN de 4 números", screenW * 0.4525, screenH * 0.2711, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            dxDrawText("Crear", screenW * 0.4525, screenH * 0.3478, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cancelar", screenW * 0.5088, screenH * 0.3478, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 2 then
            dxDrawRectangle(screenW * 0.3750, screenH * 0.4067, screenW * 0.2569, screenH * 0.1089, tocolor(0, 0, 0, 150), false)
            dxDrawText("PIN de 4 números", screenW * 0.4525, screenH * 0.5500, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            dxDrawText("Crear", screenW * 0.4525, screenH * 0.6200, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cancelar", screenW * 0.5088, screenH * 0.6200, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 3 then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(0,0,0,150), false)
            dxDrawText("PIN de la cuenta", screenW * 0.4525, screenH * 0.2711, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            dxDrawText("Acceder", screenW * 0.4525, screenH * 0.3478, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cancelar", screenW * 0.5088, screenH * 0.3478, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 4 then
            dxDrawRectangle(screenW * 0.3750, screenH * 0.4067, screenW * 0.2569, screenH * 0.1089, tocolor(0, 0, 0, 150), false)
            dxDrawText("PIN de la cuenta", screenW * 0.4525, screenH * 0.5500, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            dxDrawText("Acceder", screenW * 0.4525, screenH * 0.6200, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cancelar", screenW * 0.5088, screenH * 0.6200, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 11 then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.2133, screenW * 0.2575, screenH * 0.5367, tocolor(34,94,122, 166), false)
            dxDrawText("Balance: $"..cuentagestionada.dinero, screenW * 0.3837, screenH * 0.2322, screenW * 0.6244, screenH * 0.2700, tocolor(0, 0, 0, 255), 0.8, r_title, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.3837, screenH * 0.3611, screenW * 0.2431, screenH * 0.0533) then
                dxDrawRectangle(screenW * 0.3837, screenH * 0.3611, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 190), false)
            else
                dxDrawRectangle(screenW * 0.3837, screenH * 0.3611, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 140), false)
            end
            if isCursorHover(screenW * 0.3837, screenH * 0.4256, screenW * 0.2431, screenH * 0.0533) then
                dxDrawRectangle(screenW * 0.3837, screenH * 0.4256, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 190), false)
            else
                dxDrawRectangle(screenW * 0.3837, screenH * 0.4256, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 140), false)
            end
            if isCursorHover(screenW * 0.3837, screenH * 0.4900, screenW * 0.2431, screenH * 0.0533) then
                dxDrawRectangle(screenW * 0.3837, screenH * 0.4900, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 190), false)
            else
                dxDrawRectangle(screenW * 0.3837, screenH * 0.4900, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 140), false)
            end
            if isCursorHover(screenW * 0.3837, screenH * 0.5544, screenW * 0.2431, screenH * 0.0533) then
                dxDrawRectangle(screenW * 0.3837, screenH * 0.5544, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 190), false)
            else
                dxDrawRectangle(screenW * 0.3837, screenH * 0.5544, screenW * 0.2431, screenH * 0.0533, tocolor(2,105,156, 234, 140), false)
            end
            dxDrawText("Cobrar cheque", screenW * 0.3837, screenH * 0.3611, screenW * 0.6269, screenH * 0.4144, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cambiar PIN", screenW * 0.3837, screenH * 0.4256, screenW * 0.6269, screenH * 0.4789, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Pedir tarjeta ($100)", screenW * 0.3837, screenH * 0.4900, screenW * 0.6269, screenH * 0.5433, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Ver movimientos", screenW * 0.3837, screenH * 0.5544, screenW * 0.6269, screenH * 0.6078, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        end
        if sueldoPendiente then
            if isCursorHover(screenW * 0.3850, screenH * 0.5656, screenW * 0.2369, screenH * 0.0700) then
                dxDrawRectangle(screenW * 0.3850, screenH * 0.5656, screenW * 0.2369, screenH * 0.0700, tocolor(34,94,122, 255), false)
            else
                dxDrawRectangle(screenW * 0.3850, screenH * 0.5656, screenW * 0.2369, screenH * 0.0700, tocolor(34,94,122, 255), false)
            end
            dxDrawImage(screenW * 0.3875, screenH * 0.5700, screenW * 0.0344, screenH * 0.0611, ":items/img/19.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("COBRAR SUELDO", screenW * 0.4281, screenH * 0.5711, screenW * 0.6125, screenH * 0.6311, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        end

    elseif tipo_banco == 0 then
        dxDrawText("Cajero automático", screenW * 0.3750, screenH * 0.1467, screenW * 0.6331, screenH * 0.2078, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("Tus tarjetas actuales", screenW * 0.3750, screenH * 0.2144, screenW * 0.6331, screenH * 0.2656, tocolor(0, 0, 0, 234), 0.7, r_title, "center", "center", false, false, false, false, false)
    
        if tarjetas[indicetarjeta] ~= nil then
            if isCursorHover(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then
                dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(2,105,156, 234, 255), false)
            else
                dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(2,105,156, 234, 166), false)
            end
            dxDrawImage(screenW * 0.3812, screenH * 0.2767, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Número de tarjeta:", screenW * 0.4431, screenH * 0.2767, screenW * 0.6269, screenH * 0.3211, tocolor(0, 0, 0, 234), 1.00, r_text, "center", "center", false, false, false, false, false)
            dxDrawText("# "..frac(tarjetas[indicetarjeta][2]), screenW * 0.4431, screenH * 0.3211, screenW * 0.6269, screenH * 0.3656, tocolor(0, 0, 0, 234), 1.00, r_desc, "center", "center", false, false, false, false, false)
        else
            dxDrawImage(screenW * 0.3812, screenH * 0.2767, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("No tienes tarjetas", screenW * 0.4412, screenH * 0.2711, screenW * 0.6319, screenH * 0.3800, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end
        if tarjetas[indicetarjeta+1] ~= nil then
            if isCursorHover(screenW * 0.3756, screenH * 0.4067, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then
                dxDrawRectangle(screenW * 0.3756, screenH * 0.4067, screenW * 0.2575, screenH * 0.1100, tocolor(2,105,156, 234, 255), false)
            else
                dxDrawRectangle(screenW * 0.3756, screenH * 0.4067, screenW * 0.2575, screenH * 0.1100, tocolor(2,105,156, 234, 166), false)
            end
            dxDrawImage(screenW * 0.3812, screenH * 0.4133, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Número de tarjeta:", screenW * 0.4431, screenH * 0.4133, screenW * 0.6269, screenH * 0.4578, tocolor(0, 0, 0, 234), 1.00, r_text, "center", "center", false, false, false, false, false)
            dxDrawText("# "..frac(tarjetas[indicetarjeta+1][2]), screenW * 0.4431, screenH * 0.4578, screenW * 0.6269, screenH * 0.5022, tocolor(0, 0, 0, 234), 1.00, r_desc, "center", "center", false, false, false, false, false)
        end
        if tarjetas[indicetarjeta+2] ~= nil then
            if isCursorHover(screenW * 0.3756, screenH * 0.5400, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then
                dxDrawRectangle(screenW * 0.3756, screenH * 0.5400, screenW * 0.2575, screenH * 0.1100, tocolor(2,105,156, 234, 255), false)
            else
                dxDrawRectangle(screenW * 0.3756, screenH * 0.5400, screenW * 0.2575, screenH * 0.1100, tocolor(2,105,156, 234, 166), false)
            end
            dxDrawImage(screenW * 0.3812, screenH * 0.5466, screenW * 0.0612, screenH * 0.0922, ":items/img/18.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText("Número de tarjeta:", screenW * 0.4431, screenH * 0.6800, screenW * 0.6269, screenH * 0.4578, tocolor(0, 0, 0, 234), 1.00, r_text, "center", "center", false, false, false, false, false)
            dxDrawText("# "..frac(tarjetas[indicetarjeta+2][2]), screenW * 0.4431, screenH * 0.7300, screenW * 0.6269, screenH * 0.5022, tocolor(0, 0, 0, 234), 1.00, r_desc, "center", "center", false, false, false, false, false)
        end

        if focus_cuenta == 5 then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(0,0,0,150), false)
            dxDrawText("PIN de la tarjeta", screenW * 0.4525, screenH * 0.2711, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            dxDrawText("Acceder", screenW * 0.4525, screenH * 0.3478, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cancelar", screenW * 0.5088, screenH * 0.3478, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 6 then
            dxDrawRectangle(screenW * 0.3750, screenH * 0.4067, screenW * 0.2569, screenH * 0.1089, tocolor(0, 0, 0, 150), false)
            dxDrawText("PIN de la tarjeta", screenW * 0.4525, screenH * 0.5500, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            dxDrawText("Acceder", screenW * 0.4525, screenH * 0.6200, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cancelar", screenW * 0.5088, screenH * 0.6200, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 7 then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.5411, screenW * 0.2562, screenH * 0.1089, tocolor(0, 0, 0, 150), false)
            dxDrawText("PIN de la tarjeta", screenW * 0.4525, screenH * 0.8100, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            dxDrawText("Acceder", screenW * 0.4525, screenH * 0.8900, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Cancelar", screenW * 0.5088, screenH * 0.8900, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 8 then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100, tocolor(0,0,0,150), false)
            dxDrawText("Balance: $"..tarjeta_accedida, screenW * 0.4525, screenH * 0.2711, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.6125, screenH * 0.2756, screenW * 0.0175, screenH * 0.0300) then
                dxDrawRectangle(screenW * 0.6125, screenH * 0.2756, screenW * 0.0175, screenH * 0.0300, tocolor(50, 0, 0, 255), false)
            else
                dxDrawRectangle(screenW * 0.6125, screenH * 0.2756, screenW * 0.0175, screenH * 0.0300, tocolor(0, 0, 0, 255), false)
            end
            dxDrawText("X", screenW * 0.6125, screenH * 0.2756, screenW * 0.6300, screenH * 0.3056, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Retirar", screenW * 0.4525, screenH * 0.3478, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Depositar", screenW * 0.5088, screenH * 0.3478, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 9 then
            dxDrawRectangle(screenW * 0.3750, screenH * 0.4067, screenW * 0.2569, screenH * 0.1089, tocolor(0, 0, 0, 150), false)
            dxDrawText("Balance: $"..tarjeta_accedida, screenW * 0.4525, screenH * 0.5500, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.6125, screenH * 0.4111, screenW * 0.0175, screenH * 0.0300) then
                dxDrawRectangle(screenW * 0.6125, screenH * 0.4111, screenW * 0.0175, screenH * 0.0300, tocolor(50, 0, 0, 255), false)
            else
                dxDrawRectangle(screenW * 0.6125, screenH * 0.4111, screenW * 0.0175, screenH * 0.0300, tocolor(0, 0, 0, 255), false)
            end
            dxDrawText("X", screenW * 0.6125, screenH * 0.4111, screenW * 0.6300, screenH * 0.4411, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Retirar", screenW * 0.4525, screenH * 0.6200, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Depositar", screenW * 0.5088, screenH * 0.6200, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        elseif focus_cuenta == 10 then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.5411, screenW * 0.2562, screenH * 0.1089, tocolor(0, 0, 0, 150), false)
            dxDrawText("Balance: $"..tarjeta_accedida, screenW * 0.4525, screenH * 0.8100, screenW * 0.5619, screenH * 0.3044, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.5088, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278) then
                dxDrawRectangle(screenW * 0.5088, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(50, 50, 50, 214), false)
            else
                dxDrawRectangle(screenW * 0.5088, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278, tocolor(0, 0, 0, 214), false)
            end
            if isCursorHover(screenW * 0.6125, screenH * 0.5444, screenW * 0.0175, screenH * 0.0300) then
                dxDrawRectangle(screenW * 0.6125, screenH * 0.5444, screenW * 0.0175, screenH * 0.0300, tocolor(50, 0, 0, 255), false)
            else
                dxDrawRectangle(screenW * 0.6125, screenH * 0.5444, screenW * 0.0175, screenH * 0.0300, tocolor(0, 0, 0, 255), false)
            end
            dxDrawText("X", screenW * 0.6125, screenH * 0.5444, screenW * 0.6300, screenH * 0.5744, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Retirar", screenW * 0.4525, screenH * 0.8900, screenW * 0.5056, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            dxDrawText("Depositar", screenW * 0.5088, screenH * 0.8900, screenW * 0.5619, screenH * 0.3756, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        end

        if #tarjetas > 3 then
        dxDrawText("Usa la rueda del ratón para bajar y usar otras tarjetas", screenW * 0.3744, screenH * 0.7544, screenW * 0.6319, screenH * 0.8033, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        end
    end

        if isCursorHover(screenW * 0.3756, screenH * 0.6778, screenW * 0.2575, screenH * 0.0611) then
            dxDrawRectangle(screenW * 0.3756, screenH * 0.6778, screenW * 0.2575, screenH * 0.0611, tocolor(2,105,156, 234, 190), false)
        else
            dxDrawRectangle(screenW * 0.3756, screenH * 0.6778, screenW * 0.2575, screenH * 0.0611, tocolor(2,105,156, 234, 140), false)
        end
        if focus_cuenta == 11 or panelmovimientos then
            dxDrawText("Volver", screenW * 0.3750, screenH * 0.6778, screenW * 0.6331, screenH * 0.7389, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        else
            dxDrawText("Cerrar", screenW * 0.3750, screenH * 0.6778, screenW * 0.6331, screenH * 0.7389, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        end
    end
end
)

r_title_mov = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 10 )
r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11)
r_desc_mov = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 9 )
r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 )

movimientos = {}
function actualizarMovimientos( data )
    for i, movs in ipairs(data) do
        table.insert(movimientos, {operacion=movs.operacion,cantidad=movs.cantidad,concepto=movs.concepto,fecha=fromJSON(movs.fecha)})
    end
end
addEvent("actualizarC:movs", true)
addEventHandler("actualizarC:movs", localPlayer, actualizarMovimientos)
imov = 1
offset_scroll = 0
panelmovimientos = false
addEventHandler("onClientRender", root,
function()
    if panelmovimientos then
        dxDrawRectangle(screenW * 0.3756, screenH * 0.2133, screenW * 0.2575, screenH * 0.4500, tocolor(2,105,156, 255), false)
        dxDrawText("Movimientos bancarios", screenW * 0.3750, screenH * 0.2144, screenW * 0.6331, screenH * 0.2656, tocolor(0, 0, 0, 234), 0.7, r_title, "center", "center", false, false, false, false, false)

        dxDrawText("Operación", screenW * 0.3837, screenH * 0.2711, screenW * 0.4494, screenH * 0.2967, tocolor(0, 0, 0, 255), 1.00, r_title_mov, "left", "center", false, false, false, false, false)
        dxDrawText("Cantidad", screenW * 0.4494, screenH * 0.2711, screenW * 0.4969, screenH * 0.2967, tocolor(0, 0, 0, 255), 1.00, r_title_mov, "left", "center", false, false, false, false, false)
        dxDrawText("Concepto", screenW * 0.4969, screenH * 0.2711, screenW * 0.5637, screenH * 0.2967, tocolor(0, 0, 0, 255), 1.00, r_title_mov, "left", "center", false, false, false, false, false)
        dxDrawLine(screenW * 0.3856, screenH * 0.3078, screenW * 0.6112, screenH * 0.3078, tocolor(255, 255, 255, 255), 1, false)
        dxDrawText("Fecha", screenW * 0.5637, screenH * 0.2711, screenW * 0.6112, screenH * 0.2967, tocolor(0, 0, 0, 255), 1.00, r_title_mov, "center", "center", false, false, false, false, false)
        
        if movimientos[imov] then
        dxDrawText(movimientos[imov].operacion, screenW * 0.3837, screenH * 0.3189, screenW * 0.4494, screenH * 0.3589, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        if movimientos[imov].cantidad < 0 then
            dxDrawText("-$"..(movimientos[imov].cantidad)*(-1), screenW * 0.4494, screenH * 0.3189, screenW * 0.4969, screenH * 0.3589, tocolor(255, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        else
            dxDrawText("+$"..movimientos[imov].cantidad, screenW * 0.4494, screenH * 0.3189, screenW * 0.4969, screenH * 0.3589, tocolor(0, 100, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        end
        dxDrawText(movimientos[imov].concepto, screenW * 0.4969, screenH * 0.3189, screenW * 0.5625, screenH * 0.3589, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        dxDrawText(movimientos[imov].fecha[1].."/"..movimientos[imov].fecha[2].."/"..movimientos[imov].fecha[3].."\n"..movimientos[imov].fecha[4]..":"..movimientos[imov].fecha[5], screenW * 0.5625, screenH * 0.3189, screenW * 0.6100, screenH * 0.3589, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        else
            dxDrawText("Sin movimientos", screenW * 0.3812, screenH * 0.3133, screenW * 0.6081, screenH * 0.3544, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        end
        if movimientos[imov+1] then
        dxDrawText(movimientos[imov+1].operacion, screenW * 0.3837, screenH * 0.3589, screenW * 0.4494, screenH * 0.3989, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        if movimientos[imov+1].cantidad < 0 then
            dxDrawText("-$"..(movimientos[imov+1].cantidad)*(-1), screenW * 0.4494, screenH * 0.3589, screenW * 0.4969, screenH * 0.3989, tocolor(255, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        else
            dxDrawText("+$"..movimientos[imov+1].cantidad, screenW * 0.4494, screenH * 0.3589, screenW * 0.4969, screenH * 0.3989, tocolor(0, 100, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        end
        dxDrawText(movimientos[imov+1].concepto, screenW * 0.4969, screenH * 0.3589, screenW * 0.5625, screenH * 0.3989, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        dxDrawText(movimientos[imov+1].fecha[1].."/"..movimientos[imov+1].fecha[2].."/"..movimientos[imov+1].fecha[3].."\n"..movimientos[imov+1].fecha[4]..":"..movimientos[imov+1].fecha[5], screenW * 0.5625, screenH * 0.3589, screenW * 0.6100, screenH * 0.3989, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        end
        if movimientos[imov+2] then
        dxDrawText(movimientos[imov+2].operacion, screenW * 0.3837, screenH * 0.3989, screenW * 0.4494, screenH * 0.4389, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        if movimientos[imov+2].cantidad < 0 then
            dxDrawText("-$"..(movimientos[imov+2].cantidad)*(-1), screenW * 0.4494, screenH * 0.3989, screenW * 0.4969, screenH * 0.4389, tocolor(255, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        else
            dxDrawText("+$"..movimientos[imov+2].cantidad, screenW * 0.4494, screenH * 0.3989, screenW * 0.4969, screenH * 0.4389, tocolor(0, 100, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false) 
        end
        dxDrawText(movimientos[imov+2].concepto, screenW * 0.4969, screenH * 0.3989, screenW * 0.5625, screenH * 0.4389, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        dxDrawText(movimientos[imov+2].fecha[1].."/"..movimientos[imov+2].fecha[2].."/"..movimientos[imov+2].fecha[3].."\n"..movimientos[imov+2].fecha[4]..":"..movimientos[imov+2].fecha[5], screenW * 0.5625, screenH * 0.3989, screenW * 0.6100, screenH * 0.4389, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        end
        if movimientos[imov+3] then
        dxDrawText(movimientos[imov+3].operacion, screenW * 0.3837, screenH * 0.4389, screenW * 0.4494, screenH * 0.4789, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        if movimientos[imov+3].cantidad < 0 then
            dxDrawText("-$"..(movimientos[imov+3].cantidad)*(-1), screenW * 0.4494, screenH * 0.4389, screenW * 0.4969, screenH * 0.4789, tocolor(255, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        else
            dxDrawText("+$"..movimientos[imov+3].cantidad, screenW * 0.4494, screenH * 0.4389, screenW * 0.4969, screenH * 0.4789, tocolor(0, 100, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        end
        dxDrawText(movimientos[imov+3].concepto, screenW * 0.4969, screenH * 0.4389, screenW * 0.5625, screenH * 0.4789, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        dxDrawText(movimientos[imov+3].fecha[1].."/"..movimientos[imov+3].fecha[2].."/"..movimientos[imov+3].fecha[3].."\n"..movimientos[imov+3].fecha[4]..":"..movimientos[imov+3].fecha[5], screenW * 0.5625, screenH * 0.4389, screenW * 0.6100, screenH * 0.4789, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        end
        if movimientos[imov+4] then
        dxDrawText(movimientos[imov+4].operacion, screenW * 0.3837, screenH * 0.4789, screenW * 0.4494, screenH * 0.5189, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        if movimientos[imov+4].cantidad < 0 then
            dxDrawText("-$"..(movimientos[imov+4].cantidad)*(-1), screenW * 0.4494, screenH * 0.4789, screenW * 0.4969, screenH * 0.5189, tocolor(255, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        else
            dxDrawText("+$"..movimientos[imov+4].cantidad, screenW * 0.4494, screenH * 0.4789, screenW * 0.4969, screenH * 0.5189, tocolor(0, 100, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        end
        dxDrawText(movimientos[imov+4].concepto, screenW * 0.4969, screenH * 0.4789, screenW * 0.5625, screenH * 0.5189, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        dxDrawText(movimientos[imov+4].fecha[1].."/"..movimientos[imov+4].fecha[2].."/"..movimientos[imov+4].fecha[3].."\n"..movimientos[imov+4].fecha[4]..":"..movimientos[imov+4].fecha[5], screenW * 0.5625, screenH * 0.4789, screenW * 0.6100, screenH * 0.5189, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        end
        if movimientos[imov+5] then
        dxDrawText(movimientos[imov+5].operacion, screenW * 0.3837, screenH * 0.5189, screenW * 0.4494, screenH * 0.5589, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        if movimientos[imov+5].cantidad < 0 then
            dxDrawText("-$"..(movimientos[imov+5].cantidad)*(-1), screenW * 0.4494, screenH * 0.5189, screenW * 0.4969, screenH * 0.5589, tocolor(255, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        else
            dxDrawText("+$"..movimientos[imov+5].cantidad, screenW * 0.4494, screenH * 0.5189, screenW * 0.4969, screenH * 0.5589, tocolor(0, 100, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        end
        dxDrawText(movimientos[imov+5].concepto, screenW * 0.4969, screenH * 0.5189, screenW * 0.5625, screenH * 0.5589, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "left", "center", false, false, false, false, false)
        dxDrawText(movimientos[imov+5].fecha[1].."/"..movimientos[imov+5].fecha[2].."/"..movimientos[imov+5].fecha[3].."\n"..movimientos[imov+5].fecha[4]..":"..movimientos[imov+5].fecha[5], screenW * 0.5625, screenH * 0.5189, screenW * 0.6100, screenH * 0.5589, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        end
        dxDrawLine(screenW * 0.6112, screenH * 0.3078, screenW * 0.6112, screenH * 0.5600, tocolor(255, 255, 255, 255), 1, false)
       
        if #movimientos > 5 then
        dxDrawRectangle(screenW * 0.6131, screenH * 0.3078, screenW * 0.0169, screenH * 0.2533, tocolor(215, 124, 35, 255), false)
        dxDrawLine(screenW * 0.4356, screenH * 0.5956, screenW * 0.5781, screenH * 0.5956, tocolor(0, 0, 0, 67), 1, false)
        dxDrawRectangle(screenW * 0.6131, (screenH * 0.3078)+((screenH * 0.2533)/#movimientos)*offset_scroll, screenW * 0.0169, ((screenH * 0.2533)/#movimientos), tocolor(232, 153, 75, 255), false)
        dxDrawText("Usa la rueda del ratón para mover la lista", screenW * 0.4356, screenH * 0.5956, screenW * 0.5781, screenH * 0.6267, tocolor(0, 0, 0, 255), 1.00, r_desc_mov, "center", "center", false, false, false, false, false)
        end
    end
end)

bindKey( "mouse_wheel_up", "down", function( )
    if bank_main_panel and tipo_banco == 0 and not focus_cuenta then
        if indicetarjeta > 1 then
            indicetarjeta = indicetarjeta - 1
        end
    elseif panelmovimientos and #movimientos > 5 then
        if imov > 1 then
            imov = imov-1
            offset_scroll = offset_scroll-1
        end
    end
end)

bindKey( "mouse_wheel_down", "down", function( )
    if bank_main_panel and tipo_banco == 0 and not focus_cuenta then
        if indicetarjeta+2 < #tarjetas then
            indicetarjeta = indicetarjeta+1
        end
    elseif panelmovimientos and #movimientos > 5 then
        if imov < #movimientos then
            imov = imov+1
            offset_scroll = offset_scroll+1
        end
    end
end)

--functiones--
function cerrarPanel()
    bank_main_panel = false
    tipo_banco = false
    tarjetas = false
    cuentas = false
    focus_cuenta = false
    showCursor(false)
    movimientos = {}
    if isElement(editbox_bank) then
        destroyElement(editbox_bank)
    end
    if isElement(editbox_bank2) then
        destroyElement(editbox_bank2)
    end
end

function gestionarCuenta( cuentai )
    movimientos = {}
    destroyElement(editbox_bank)
    cuentagestionada = cuentas[cuentai]
    setTimer ( function()
        focus_cuenta = 11
        editbox_bank = guiCreateEdit(0.43, 0.28, 0.15, 0.04, "", true) 
    end, 500, 1 )  
end
tarjeta_accedida = 0

function accederTarjeta( focus, dinero )
    focus_cuenta = tonumber(focus)
    tarjeta_accedida = tonumber(dinero)
    destroyElement(editbox_bank)
    if focus == 8 then
        editbox_bank = guiCreateEdit(0.39, 0.31, 0.06, 0.03, "Cantidad", true)
        editbox_bank2 = guiCreateEdit(0.46, 0.31, 0.09, 0.03, "Concepto", true)
    elseif focus == 9 then
        editbox_bank = guiCreateEdit(0.46, 0.45, 0.09, 0.03, "Concepto", true)
        editbox_bank2 = guiCreateEdit(0.39, 0.45, 0.06, 0.03, "Cantidad", true)
    elseif focus == 10 then
        editbox_bank = guiCreateEdit(0.46, 0.58, 0.09, 0.03, "Concepto", true)
        editbox_bank2 = guiCreateEdit(0.39, 0.58, 0.06, 0.03, "Cantidad", true)   
    end

end
addEvent("acceder:tarjeta",true)
addEventHandler("acceder:tarjeta", localPlayer, accederTarjeta)
--tipos de focus_cuenta:
    -- 1 = crear cuenta panel 1
    -- 2 = crear cuenta panel 2
    -- 3 = usar cuenta PIN panel 1
    -- 4 = usar cuenta PIN panel 2
    -- 5 = usar cuenta PIN panel 1 atm
    -- 6 = usar cuenta PIN panel 2 atm
    -- 7 = usar cuenta PIN panel 3 atm
    -- 8 = accion panel 1 atm
    -- 9 = accion panel 2 atm
    -- 10 = accion panel 3 atm
    -- 11 = gestion cuenta
    bloqueoseguridad = false
function bankClick ( button, state )
    if bank_main_panel and button=="left" and state=="down" then
        if isCursorHover(screenW * 0.3850, screenH * 0.5656, screenW * 0.2369, screenH * 0.0700) then
            triggerServerEvent("cobrar:sueldo", localPlayer, localPlayer, sueldoPendiente)
            sueldoPendiente = false
        elseif isCursorHover(screenW * 0.3756, screenH * 0.6778, screenW * 0.2575, screenH * 0.0611) then
            if panelmovimientos then
                panelmovimientos = false
                editbox_bank = guiCreateEdit(0.43, 0.28, 0.15, 0.04, "", true) 
            elseif focus_cuenta == 11 then
                destroyElement(editbox_bank)
                focus_cuenta = false
                cuentagestionada = false
            else
                cerrarPanel()
            end
        elseif isCursorHover(screenW * 0.3756, screenH * 0.2700, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then--option1
            if tipo_banco == 1 then
                if cuentas[1] == nil then
                    focus_cuenta = 1
                    editbox_bank = guiCreateEdit(0.45, 0.30, 0.11, 0.04, "", true)
                else
                    focus_cuenta = 3
                    editbox_bank = guiCreateEdit(0.45, 0.30, 0.11, 0.04, "", true)
                end
            elseif tipo_banco == 0 then
                focus_cuenta = 5
                editbox_bank = guiCreateEdit(0.45, 0.30, 0.11, 0.04, "", true)
            end
        elseif isCursorHover(screenW * 0.3750, screenH * 0.4067, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then--option2
            if tipo_banco == 1 then
                if cuentas[2] == nil then
                    focus_cuenta = 2
                    editbox_bank = guiCreateEdit(0.45, 0.44, 0.11, 0.04, "", true)   
                else
                    focus_cuenta = 4
                    editbox_bank = guiCreateEdit(0.45, 0.44, 0.11, 0.04, "", true)
                end
            elseif tipo_banco == 0 then
                focus_cuenta = 6
                editbox_bank = guiCreateEdit(0.45, 0.44, 0.11, 0.04, "", true)
            end
        elseif isCursorHover(screenW * 0.3756, screenH * 0.5400, screenW * 0.2575, screenH * 0.1100) and not focus_cuenta then--option3
            if tipo_banco == 0 then
                focus_cuenta = 7
                editbox_bank = guiCreateEdit(0.45, 0.57, 0.11, 0.04, "", true)    
            end
        elseif isCursorHover(screenW * 0.4525, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then --boton1 panel1
            if focus_cuenta == 1 then
                triggerServerEvent("crear:bank_account", localPlayer, localPlayer, guiGetText(editbox_bank))
                cerrarPanel()
            elseif focus_cuenta == 3 then
                if validarPIN(guiGetText(editbox_bank)) then
                    if guiGetText(editbox_bank) == tostring(cuentas[1].pin) then
                        gestionarCuenta(1)
                    else
                        exports.login:addNotification("El PIN introducido no corresponde a esta cuenta.", "error")
                    end
                else
                    exports.login:addNotification("Por favor, introduce un PIN válido.", "error")
                end
            elseif focus_cuenta == 5 then
                if validarPIN(guiGetText(editbox_bank)) then
                    triggerServerEvent("check:tarjetapin", localPlayer, localPlayer, tarjetas[indicetarjeta][2], guiGetText(editbox_bank), 8)
                else
                    exports.login:addNotification("Por favor, introduce un PIN válido.", "error")
                end
            elseif focus_cuenta == 8 and not bloqueoseguridad then--retirar p1
                if tonumber(guiGetText(editbox_bank)) and tonumber(guiGetText(editbox_bank)) > 0 then
                    if tonumber(guiGetText(editbox_bank)) <= tarjeta_accedida then
                        if #guiGetText(editbox_bank2) > 20 then
                            exports.login:addNotification("El concepto tiene que tener 20 carácteres máximo.", "error")
                        else
                            bloqueoseguridad = true
                            tarjeta_accedida = tarjeta_accedida-tonumber(guiGetText(editbox_bank))
                            triggerServerEvent("retirar:dinero", localPlayer, localPlayer, tarjetas[indicetarjeta][2], tonumber(guiGetText(editbox_bank)), guiGetText(editbox_bank2) )
                        end
                    else
                        exports.login:addNotification("No hay tanto dinero en esta tarjeta.", "error")
                    end
                else
                    exports.login:addNotification("La cantidad tiene que ser un valor numérico.", "error")
                end
            end
        elseif isCursorHover(screenW * 0.5088, screenH * 0.3478, screenW * 0.0531, screenH * 0.0278) then --boton2 panel1
            if focus_cuenta == 1 or focus_cuenta == 3 or focus_cuenta == 5 then
                focus_cuenta = false
                destroyElement(editbox_bank)
            elseif focus_cuenta == 8 and not bloqueoseguridad then
                if tonumber(guiGetText(editbox_bank)) and tonumber(guiGetText(editbox_bank)) > 0 then
                    if tonumber(guiGetText(editbox_bank)) <= getPlayerMoney(localPlayer) then
                        if #guiGetText(editbox_bank2) > 20 then
                            exports.login:addNotification("El concepto tiene que tener 20 carácteres máximo.", "error")
                        else
                            bloqueoseguridad = true
                            tarjeta_accedida = tarjeta_accedida+tonumber(guiGetText(editbox_bank))
                            triggerServerEvent("depositar:dinero", localPlayer, localPlayer, tarjetas[indicetarjeta][2], tonumber(guiGetText(editbox_bank)), guiGetText(editbox_bank2) )
                        end
                    else
                        exports.login:addNotification("No tienes esa cantidad de dinero.", "error")
                    end
                else
                    exports.login:addNotification("La cantidad tiene que ser un valor numérico.", "error")
                end
            end
        elseif isCursorHover(screenW * 0.4525, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then --boton1 panel2
            if focus_cuenta == 2 then
                triggerServerEvent("crear:bank_account", localPlayer, localPlayer, guiGetText(editbox_bank))
                cerrarPanel()
            elseif focus_cuenta == 4 then
                if validarPIN(guiGetText(editbox_bank)) then
                    if guiGetText(editbox_bank) == tostring(cuentas[2].pin) then
                        gestionarCuenta(2)
                    else
                        exports.login:addNotification("El PIN introducido no corresponde a esta cuenta.", "error")
                    end
                else
                    exports.login:addNotification("Por favor, introduce un PIN válido.", "error")
                end
            elseif focus_cuenta == 6 then
                if validarPIN(guiGetText(editbox_bank)) then
                    triggerServerEvent("check:tarjetapin", localPlayer, localPlayer, tarjetas[indicetarjeta+1][2], guiGetText(editbox_bank), 9)
                else
                    exports.login:addNotification("Por favor, introduce un PIN válido.", "error")
                end
            elseif focus_cuenta == 9 and not bloqueoseguridad then--retirar p2
                if tonumber(guiGetText(editbox_bank2)) then
                    if tonumber(guiGetText(editbox_bank2)) <= tarjeta_accedida then
                        if #guiGetText(editbox_bank) > 20 then
                            exports.login:addNotification("El concepto tiene que tener 20 carácteres máximo.", "error")
                        else
                            bloqueoseguridad = true
                            tarjeta_accedida = tarjeta_accedida-tonumber(guiGetText(editbox_bank2))
                            triggerServerEvent("retirar:dinero", localPlayer, localPlayer, tarjetas[indicetarjeta+1][2], tonumber(guiGetText(editbox_bank2)), guiGetText(editbox_bank) )
                        end
                    else
                        exports.login:addNotification("No hay tanto dinero en esta tarjeta.", "error")
                    end
                else
                    exports.login:addNotification("La cantidad tiene que ser un valor numérico.", "error")
                end
            end
        elseif isCursorHover(screenW * 0.5088, screenH * 0.4845, screenW * 0.0531, screenH * 0.0278) then --boton2 panel2
            if focus_cuenta == 2 or focus_cuenta == 4 or focus_cuenta == 6 then
                focus_cuenta = false
                destroyElement(editbox_bank)
            elseif focus_cuenta == 9 and not bloqueoseguridad then
                if tonumber(guiGetText(editbox_bank2)) then
                    if tonumber(guiGetText(editbox_bank2)) <= getPlayerMoney(localPlayer) then
                        if #guiGetText(editbox_bank) > 20 then
                            exports.login:addNotification("El concepto tiene que tener 20 carácteres máximo.", "error")
                        else
                            bloqueoseguridad = true
                            tarjeta_accedida = tarjeta_accedida+tonumber(guiGetText(editbox_bank2))
                            triggerServerEvent("depositar:dinero", localPlayer, localPlayer, tarjetas[indicetarjeta+1][2], tonumber(guiGetText(editbox_bank2)), guiGetText(editbox_bank) )
                        end
                    else
                        exports.login:addNotification("No tienes esa cantidad de dinero.", "error")
                    end
                else
                    exports.login:addNotification("La cantidad tiene que ser un valor numérico.", "error")
                end
            end
        elseif isCursorHover(screenW * 0.4525, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278) then --boton1 panel3
            if focus_cuenta == 7 then
                if validarPIN(guiGetText(editbox_bank)) then
                    triggerServerEvent("check:tarjetapin", localPlayer, localPlayer, tarjetas[indicetarjeta+2][2], guiGetText(editbox_bank), 10)
                else
                    exports.login:addNotification("Por favor, introduce un PIN válido.", "error")
                end
            elseif focus_cuenta == 10 and not bloqueoseguridad then--retirar p3
                if tonumber(guiGetText(editbox_bank2)) then
                    if tonumber(guiGetText(editbox_bank2)) <= tarjeta_accedida then
                        if #guiGetText(editbox_bank) > 20 then
                            exports.login:addNotification("El concepto tiene que tener 20 carácteres máximo.", "error")
                        else
                            bloqueoseguridad = true
                            tarjeta_accedida = tarjeta_accedida-tonumber(guiGetText(editbox_bank2))
                            triggerServerEvent("retirar:dinero", localPlayer, localPlayer, tarjetas[indicetarjeta+2][2], tonumber(guiGetText(editbox_bank2)), guiGetText(editbox_bank) )
                        end
                    else
                        exports.login:addNotification("No hay tanto dinero en esta tarjeta.", "error")
                    end
                else
                    exports.login:addNotification("La cantidad tiene que ser un valor numérico.", "error")
                end
            end
        elseif isCursorHover(screenW * 0.5088, screenH * 0.6190, screenW * 0.0531, screenH * 0.0278) then --boton2 panel3
            if focus_cuenta == 7 then
                focus_cuenta = false
                destroyElement(editbox_bank)
            elseif focus_cuenta == 10 and not bloqueoseguridad then
                if tonumber(guiGetText(editbox_bank2)) then
                    if tonumber(guiGetText(editbox_bank2)) <= getPlayerMoney(localPlayer) then
                        if #guiGetText(editbox_bank) > 20 then
                            exports.login:addNotification("El concepto tiene que tener 20 carácteres máximo.", "error")
                        else
                            bloqueoseguridad = true
                            tarjeta_accedida = tarjeta_accedida+tonumber(guiGetText(editbox_bank2))
                            triggerServerEvent("depositar:dinero", localPlayer, localPlayer, tarjetas[indicetarjeta+2][2], tonumber(guiGetText(editbox_bank2)), guiGetText(editbox_bank) )
                        end
                    else
                        exports.login:addNotification("No tienes esa cantidad de dinero.", "error")
                    end
                else
                    exports.login:addNotification("La cantidad tiene que ser un valor numérico.", "error")
                end
            end
        elseif isCursorHover(screenW * 0.6125, screenH * 0.2756, screenW * 0.0175, screenH * 0.0300) and focus_cuenta == 8 then
            focus_cuenta = false
            destroyElement(editbox_bank)
            destroyElement(editbox_bank2)
        elseif isCursorHover(screenW * 0.6125, screenH * 0.4111, screenW * 0.0175, screenH * 0.0300) and focus_cuenta == 9 then
            focus_cuenta = false
            destroyElement(editbox_bank)
            destroyElement(editbox_bank2)
        elseif isCursorHover(screenW * 0.6125, screenH * 0.5444, screenW * 0.0175, screenH * 0.0300) and focus_cuenta == 10 then
            focus_cuenta = false
            destroyElement(editbox_bank)
            destroyElement(editbox_bank2)
        end

        if focus_cuenta == 11 and not panelmovimientos then
            if isCursorHover(screenW * 0.3837, screenH * 0.3611, screenW * 0.2431, screenH * 0.0533) then --cobrar cheque
                local num = guiGetText(editbox_bank)
                if #num > 0 and tonumber(num) then
                    triggerServerEvent("cobrar:cheque", localPlayer, localPlayer, num, cuentagestionada.id)
                    cerrarPanel()
                else
                    exports.login:addNotification("Introduce un número de cheque en el campo de texto.", "error")
                end
            elseif isCursorHover(screenW * 0.3837, screenH * 0.4256, screenW * 0.2431, screenH * 0.0533) then --cambiarPIN
                local num = guiGetText(editbox_bank)
                if validarPIN(num) then
                    triggerServerEvent("cambiar:pin", localPlayer, localPlayer, num, cuentagestionada.id)
                    cerrarPanel()
                else
                    exports.login:addNotification("El PIN introducido no cumple con el formato ( 4 números ).", "error")
                end
            elseif isCursorHover(screenW * 0.3837, screenH * 0.4900, screenW * 0.2431, screenH * 0.0533) then --pedirtarjeta 100$
                if exports.items:tienehuecoC(19) then
                    triggerServerEvent("entregar:tarjeta", localPlayer, localPlayer, cuentagestionada.id)
                else
                    exports.login:addNotification("No tienes hueco suficiente en tus bolsillos.", "error")
                end
            elseif isCursorHover(screenW * 0.3837, screenH * 0.5544, screenW * 0.2431, screenH * 0.0533) then --Ver movimientos
                triggerServerEvent("actualizar:movs", localPlayer, localPlayer, cuentagestionada.id)
                panelmovimientos = true
                destroyElement(editbox_bank)
            end
        end
    end
end
addEventHandler ( "onClientClick", getRootElement(), bankClick )

--utilitarias-

function validarPIN( pin )
    if tonumber(pin) then
        if #pin == 4 and tonumber(pin) > 0 and #(tostring(math.floor(pin))) == 4 then
            return true
        else
            return false
        end
    else
        return false
    end
end

function validarOperacion()
    bloqueoseguridad = false
end
addEvent("confirmar:operacion", true)
addEventHandler("confirmar:operacion", localPlayer, validarOperacion)

function isBankTypeOpened( tipo )
    if bank_main_panel and tipo_banco == tipo then
        return true
    else
        return false
    end
end
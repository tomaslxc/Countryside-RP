    r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 20 )
    r_title_big = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 24 )
    r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )
local screenW, screenH = guiGetScreenSize()
local conce_index = 1
function abrirConce( tipo, data )
	if tipo == 1 and not mostrarconce then
		showCursor(true)
        mostrarconce = data
	end
end
addEvent("conce:abrir", true)
addEventHandler("conce:abrir", localPlayer, abrirConce)

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

bindKey( "mouse_wheel_up", "down", function( )
    if mostrarconce then
        if conce_index > 1 then
            conce_index = conce_index - 1
        end
    end
end)

bindKey( "mouse_wheel_down", "down", function( )
    if mostrarconce then
        if conce_index+3 < #mostrarconce then
            conce_index = conce_index+1
        end
    end
end)

addEventHandler("onClientRender", root,
    function()
        if mostrarconce then
        dxDrawRectangle(screenW * 0.3990, screenH * 0.2731, screenW * 0.1870, screenH * 0.4981, tocolor(34,94,122, 178), false)
        dxDrawRectangle(screenW * 0.3990, screenH * 0.2222, screenW * 0.1870, screenH * 0.0417, tocolor(2,105,156, 231), false)
        dxDrawText("Tus pedidos", screenW * 0.3990, screenH * 0.2241, screenW * 0.5859, screenH * 0.2639, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        if mostrarconce[conce_index] ~= nil then
            if isCursorHover(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926) then
                dxDrawRectangle(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 250), false)
            else
                dxDrawRectangle(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 178), false)
            end
        dxDrawText(getVehicleNameFromModel(mostrarconce[conce_index].modelo), screenW * 0.4042, screenH * 0.2870, screenW * 0.5786, screenH * 0.3231, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText("Total a pagar: "..mostrarconce[conce_index].precio.." $", screenW * 0.4042, screenH * 0.3231, screenW * 0.5786, screenH * 0.3796, tocolor(0, 100, 0, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        end
        if mostrarconce[conce_index+1] ~= nil then
            if isCursorHover(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926) then
                dxDrawRectangle(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 250), false)
            else
                dxDrawRectangle(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 178), false)
            end
        dxDrawText(getVehicleNameFromModel(mostrarconce[conce_index+1].modelo), screenW * 0.4042, screenH * 0.3944, screenW * 0.5786, screenH * 0.4306, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText("Total a pagar: "..mostrarconce[conce_index+1].precio.." $", screenW * 0.4042, screenH * 0.4306, screenW * 0.5786, screenH * 0.4870, tocolor(0, 100, 0, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        end
        if mostrarconce[conce_index+2] ~= nil then
            if isCursorHover(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926) then
                dxDrawRectangle(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 250), false)
            else
                dxDrawRectangle(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 178), false)
            end
        dxDrawText(getVehicleNameFromModel(mostrarconce[conce_index+2].modelo), screenW * 0.4042, screenH * 0.5009, screenW * 0.5786, screenH * 0.5370, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText("Total a pagar: "..mostrarconce[conce_index+2].precio.." $", screenW * 0.4042, screenH * 0.5370, screenW * 0.5786, screenH * 0.5935, tocolor(0, 100, 0, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        end
        if mostrarconce[conce_index+3] ~= nil then
            if isCursorHover(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926) then
                dxDrawRectangle(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 250), false)
            else
                dxDrawRectangle(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926, tocolor(34,94,122, 178), false)
            end
        dxDrawText(getVehicleNameFromModel(mostrarconce[conce_index+3].modelo), screenW * 0.4042, screenH * 0.6074, screenW * 0.5786, screenH * 0.6435, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText("Total a pagar: "..mostrarconce[conce_index+3].precio.." $", screenW * 0.4042, screenH * 0.6435, screenW * 0.5786, screenH * 0.7000, tocolor(0, 100, 0, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        end
        if isCursorHover(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481) then
            dxDrawRectangle(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481, tocolor(38,94,122, 255), false)
        else
            dxDrawRectangle(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481, tocolor(34,94,122, 178), false)
        end
        dxDrawText("Cerrar", screenW * 0.4380, screenH * 0.7194, screenW * 0.5464, screenH * 0.7676, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        end
    end
)


function ConceClick ( button, state )
    if mostrarconce and button=="left" and state=="down" then
        if isCursorHover(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481) then
            mostrarconce = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926) and mostrarconce[conce_index] ~= nil then
            triggerServerEvent('comprar:vehiculo', localPlayer, localPlayer, mostrarconce[conce_index].modelo, mostrarconce[conce_index].precio,mostrarconce[conce_index].id)
            mostrarconce = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926) and mostrarconce[conce_index+1] ~= nil then
            triggerServerEvent('comprar:vehiculo', localPlayer, localPlayer, mostrarconce[conce_index+1].modelo, mostrarconce[conce_index+1].precio,mostrarconce[conce_index+1].id)
            mostrarconce = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926) and mostrarconce[conce_index+2] ~= nil then
            triggerServerEvent('comprar:vehiculo', localPlayer, localPlayer, mostrarconce[conce_index+2].modelo, mostrarconce[conce_index+2].precio,mostrarconce[conce_index+2].id)
            mostrarconce = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926) and mostrarconce[conce_index+3] ~= nil then
            triggerServerEvent('comprar:vehiculo', localPlayer, localPlayer, mostrarconce[conce_index+3].modelo, mostrarconce[conce_index+3].precio,mostrarconce[conce_index+3].id)
            mostrarconce = false
            showCursor(false)
        end
    end
end
addEventHandler ( "onClientClick", getRootElement(), ConceClick )


    r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )
local screenW, screenH = guiGetScreenSize()
local rutas_camionero = false
local index_rutas = 1

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

function abrirPanelRutas( data )
	showCursor(true)
	rutas_camionero = data

end
addEvent('open_panel_rutas',true)
addEventHandler('open_panel_rutas', localPlayer, abrirPanelRutas)

bindKey( "mouse_wheel_up", "down", function( )
    if rutas_camionero then
        if index_rutas > 1 then
            index_rutas = index_rutas - 1
        end
    end
end)

bindKey( "mouse_wheel_down", "down", function( )
    if rutas_camionero then
        if index_rutas+4 < #rutas_camionero then
            index_rutas = index_rutas+1
        end
    end
end)

addEventHandler("onClientRender", root,
    function()
        if rutas_camionero then
        dxDrawRectangle(screenW * 0.2833, screenH * 0.3019, screenW * 0.4255, screenH * 0.3509, tocolor(0, 0, 0, 155), false)
        dxDrawRectangle(screenW * 0.2833, screenH * 0.2389, screenW * 0.4255, screenH * 0.0537, tocolor(0, 0, 0, 254), false)
        dxDrawText("RUTAS REGISTRADAS", screenW * 0.2833, screenH * 0.2389, screenW * 0.7089, screenH * 0.2926, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        if rutas_camionero[index_rutas] ~= nil then
        dxDrawText("Ruta número #"..rutas_camionero[index_rutas][1].." - "..rutas_camionero[index_rutas][6], screenW * 0.2859, screenH * 0.3139, screenW * 0.6542, screenH * 0.3481, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.6547, screenH * 0.3157, screenW * 0.0437, screenH * 0.0324) then
                dxDrawRectangle(screenW * 0.6547, screenH * 0.3157, screenW * 0.0437, screenH * 0.0324, tocolor(42, 200, 56, 254), false)
            else
                dxDrawRectangle(screenW * 0.6547, screenH * 0.3157, screenW * 0.0437, screenH * 0.0324, tocolor(42, 140, 56, 254), false)
            end
        if rutas_camionero[index_rutas][6] == "Disponible" then
            dxDrawText("EMPEZAR", screenW * 0.6547, screenH * 0.3148, screenW * 0.6958, screenH * 0.3481, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        else
            dxDrawText("OCUPADA", screenW * 0.6547, screenH * 0.3148, screenW * 0.6958, screenH * 0.3481, tocolor(255, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        end
        dxDrawLine(screenW * 0.2859, screenH * 0.3481, screenW * 0.6984, screenH * 0.3481, tocolor(255, 255, 255, 255), 1, false)
        end
        if rutas_camionero[index_rutas+1] ~= nil then
        dxDrawText("Ruta número #"..rutas_camionero[index_rutas+1][1].." - "..rutas_camionero[index_rutas+1][6], screenW * 0.2859, screenH * 0.3574, screenW * 0.6542, screenH * 0.3917, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.6547, screenH * 0.3574, screenW * 0.0437, screenH * 0.0324) then
                dxDrawRectangle(screenW * 0.6547, screenH * 0.3574, screenW * 0.0437, screenH * 0.0324, tocolor(42, 200, 56, 254), false)
            else
                dxDrawRectangle(screenW * 0.6547, screenH * 0.3574, screenW * 0.0437, screenH * 0.0324, tocolor(42, 140, 56, 254), false)
            end
        if rutas_camionero[index_rutas+1][6] == "Disponible" then
            dxDrawText("EMPEZAR", screenW * 0.6547, screenH * 0.3565, screenW * 0.6958, screenH * 0.3898, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        else
            dxDrawText("OCUPADA", screenW * 0.6547, screenH * 0.3565, screenW * 0.6958, screenH * 0.3898, tocolor(255, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        end
        dxDrawLine(screenW * 0.2859, screenH * 0.3898, screenW * 0.6984, screenH * 0.3898, tocolor(255, 255, 255, 255), 1, false)
        end
        if rutas_camionero[index_rutas+2] ~= nil then
        dxDrawText("Ruta número #"..rutas_camionero[index_rutas+2][1].." - "..rutas_camionero[index_rutas+2][6], screenW * 0.2859, screenH * 0.3954, screenW * 0.6542, screenH * 0.4296, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.6547, screenH * 0.3972, screenW * 0.0437, screenH * 0.0324) then
                dxDrawRectangle(screenW * 0.6547, screenH * 0.3972, screenW * 0.0437, screenH * 0.0324, tocolor(42, 200, 56, 254), false)
            else
                dxDrawRectangle(screenW * 0.6547, screenH * 0.3972, screenW * 0.0437, screenH * 0.0324, tocolor(42, 140, 56, 254), false)
            end
        if rutas_camionero[index_rutas+2][6] == "Disponible" then
            dxDrawText("EMPEZAR", screenW * 0.6547, screenH * 0.3954, screenW * 0.6958, screenH * 0.4287, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        else
            dxDrawText("OCUPADA", screenW * 0.6547, screenH * 0.3954, screenW * 0.6958, screenH * 0.4287, tocolor(255, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        end
        dxDrawLine(screenW * 0.2859, screenH * 0.4296, screenW * 0.6984, screenH * 0.4296, tocolor(255, 255, 255, 255), 1, false)
        end
        if rutas_camionero[index_rutas+3] ~= nil then
        dxDrawText("Ruta número #"..rutas_camionero[index_rutas+3][1].." - "..rutas_camionero[index_rutas+3][6], screenW * 0.2859, screenH * 0.4333, screenW * 0.6542, screenH * 0.4676, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.6547, screenH * 0.4352, screenW * 0.0437, screenH * 0.0324) then
                dxDrawRectangle(screenW * 0.6547, screenH * 0.4352, screenW * 0.0437, screenH * 0.0324, tocolor(42, 200, 56, 254), false)
            else
                dxDrawRectangle(screenW * 0.6547, screenH * 0.4352, screenW * 0.0437, screenH * 0.0324, tocolor(42, 140, 56, 254), false)
            end
        if rutas_camionero[index_rutas+3][6] == "Disponible" then
            dxDrawText("EMPEZAR", screenW * 0.6547, screenH * 0.4352, screenW * 0.6958, screenH * 0.4685, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        else
            dxDrawText("OCUPADA", screenW * 0.6547, screenH * 0.4352, screenW * 0.6958, screenH * 0.4685, tocolor(255, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        end
        dxDrawLine(screenW * 0.2859, screenH * 0.4676, screenW * 0.6984, screenH * 0.4676, tocolor(255, 255, 255, 255), 1, false)
        end
        if rutas_camionero[index_rutas+4] ~= nil then
        dxDrawText("Ruta número #"..rutas_camionero[index_rutas+4][1].." - "..rutas_camionero[index_rutas+4][6], screenW * 0.2859, screenH * 0.4731, screenW * 0.6542, screenH * 0.5074, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
            if isCursorHover(screenW * 0.6542, screenH * 0.4750, screenW * 0.0437, screenH * 0.0324) then
                dxDrawRectangle(screenW * 0.6542, screenH * 0.4750, screenW * 0.0437, screenH * 0.0324, tocolor(42, 200, 56, 254), false)
            else
                dxDrawRectangle(screenW * 0.6542, screenH * 0.4750, screenW * 0.0437, screenH * 0.0324, tocolor(42, 140, 56, 254), false)
            end
        if rutas_camionero[index_rutas+4][6] == "Disponible" then
        dxDrawText("EMPEZAR", screenW * 0.6547, screenH * 0.4741, screenW * 0.6958, screenH * 0.5074, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        else
        end
        dxDrawLine(screenW * 0.2854, screenH * 0.5074, screenW * 0.6979, screenH * 0.5074, tocolor(255, 255, 255, 255), 1, false)
        end
        if isCursorHover(screenW * 0.4370, screenH * 0.6019, screenW * 0.1193, screenH * 0.0417) then
            dxDrawRectangle(screenW * 0.4370, screenH * 0.6019, screenW * 0.1193, screenH * 0.0417, tocolor(242, 36, 36, 255), false)
        else
            dxDrawRectangle(screenW * 0.4370, screenH * 0.6019, screenW * 0.1193, screenH * 0.0417, tocolor(242, 36, 36, 209), false)
        end
        dxDrawText("CERRAR", screenW * 0.4359, screenH * 0.6009, screenW * 0.5563, screenH * 0.6435, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            if #rutas_camionero > 4 then
                dxDrawText("Usa la rueda del raton para bajar en la lista", screenW * 0.3818, screenH * 0.5463, screenW * 0.6109, screenH * 0.5917, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
            end
        end
    end
)

function CamioneroClick ( button, state )
    if rutas_camionero and button=="left" and state=="down" then
        if isCursorHover(screenW * 0.4370, screenH * 0.6019, screenW * 0.1193, screenH * 0.0417) then
            rutas_camionero = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.6547, screenH * 0.3157, screenW * 0.0437, screenH * 0.0324) and rutas_camionero[index_rutas] ~= nil and rutas_camionero[index_rutas][6] == "Disponible" then
            triggerServerEvent("empezar:ruta:camionero", localPlayer, localPlayer, rutas_camionero[index_rutas])
            rutas_camionero = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.6547, screenH * 0.3574, screenW * 0.0437, screenH * 0.0324) and rutas_camionero[index_rutas+1] ~= nil and rutas_camionero[index_rutas+1][6] == "Disponible" then
            triggerServerEvent("empezar:ruta:camionero", localPlayer, localPlayer, rutas_camionero[index_rutas+1])
            rutas_camionero = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.6547, screenH * 0.3972, screenW * 0.0437, screenH * 0.0324) and rutas_camionero[index_rutas+2] ~= nil and rutas_camionero[index_rutas+2][6] == "Disponible" then
            triggerServerEvent("empezar:ruta:camionero", localPlayer, localPlayer, rutas_camionero[index_rutas+2])
            rutas_camionero = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.6547, screenH * 0.4352, screenW * 0.0437, screenH * 0.0324) and rutas_camionero[index_rutas+3] ~= nil and rutas_camionero[index_rutas+3][6] == "Disponible" then
            triggerServerEvent("empezar:ruta:camionero", localPlayer, localPlayer, rutas_camionero[index_rutas+3])
            rutas_camionero = false
            showCursor(false)
        elseif isCursorHover(screenW * 0.6542, screenH * 0.4750, screenW * 0.0437, screenH * 0.0324) and rutas_camionero[index_rutas+4] ~= nil and rutas_camionero[index_rutas+4][6] == "Disponible" then
            triggerServerEvent("empezar:ruta:camionero", localPlayer, localPlayer, rutas_camionero[index_rutas+4])
            rutas_camionero = false
            showCursor(false)
        end
    end
end
addEventHandler ( "onClientClick", getRootElement(), CamioneroClick )


function showRoute( ruta )
    rutamarker = createMarker ( ruta[2], ruta[3], ruta[4], "checkpoint", 4.0, 200,100,0,200)
    rutablip = createBlip ( ruta[2], ruta[3], ruta[4] ,0,4)
end
addEvent("mostrar-ruta", true)
addEventHandler("mostrar-ruta", localPlayer, showRoute)


function endRoute( )
    destroyElement(rutamarker)
    destroyElement(rutablip)
end
addEvent("finalizar:pedido", true)
addEventHandler("finalizar:pedido", localPlayer, endRoute)





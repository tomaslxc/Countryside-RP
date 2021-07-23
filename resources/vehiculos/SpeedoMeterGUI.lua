local screenWidth, screenHeight = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
-- 'Textures'
local speedometerBG = "textures/speedometerBG.png"
local speedometerBGG = "textures/gray.png"
local speedometerBG2 = "textures/speedometerBG2.png"
local speedometerNeedleWhite = "textures/speedometerNeedleWhite.png"
local speedometerNeedleRed = "textures/speedometerNeedleRed.png"
local speedometerOverlay = "textures/speedometerOverlay.png"
local speedometerGlass = "textures/speedometerGlass.png"
local carState = "textures/carState.png"
local nitroState ="textures/nitroState.png"

-- 'fonts'
fontPrototype10 = dxCreateFont("fonts/Prototype.ttf", 10)
fontPrototype40 = dxCreateFont("fonts/Prototype.ttf", 40)
fontLCD22 = dxCreateFont("fonts/lcd.ttf", 22)


function speedoMeterGUI() 
    if (vehicle) and getPedOccupiedVehicleSeat ( localPlayer ) == 0 then 
        local rpm1, rpm2, rpm3, rpm4 = getFormattedRpmRotation()
        -- 'Speedometer'
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerBGG)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerNeedleRed, rpm4)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerNeedleWhite, rpm3)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerNeedleWhite, rpm2)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerNeedleWhite, rpm1)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerBG)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerBG2)

        dxDrawText(getVehicleSpeedString(), screenWidth - 160, screenHeight - 40, screenWidth - 160, screenHeight - 115, tocolor(255, 255, 255, 255), 1, fontLCD22, "left", "top", false, false, false)
        dxDrawText("km/h", screenWidth - 110, screenHeight - 20, screenWidth - 110, screenHeight - 95, tocolor(255, 255, 255, 255), 1, fontPrototype10, "left", "top", false, false, false)

        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerOverlay)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 200), 200, 200, speedometerGlass)
        if isVehicleLocked(vehicle) then
            dxDrawImage(screenW * 0.8962, screenH * 0.8944, screenW * 0.0181, screenH * 0.0322, ":vehiculos/textures/puerta.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
        else
            dxDrawImage(screenW * 0.8962, screenH * 0.8944, screenW * 0.0181, screenH * 0.0322, ":vehiculos/textures/puerta.png", 0, 0, 0, tocolor(0, 255, 0, 255), false)
        end
        if getVehicleOverrideLights ( vehicle ) == 2 then
            dxDrawImage(screenW * 0.9160, screenH * 0.8944, screenW * 0.0151, screenH * 0.0302, ":vehiculos/textures/luces.png", 0, 0, 0, tocolor(0, 255, 0, 255), false)
        end
        if isElementFrozen(vehicle) then
            dxDrawImage(screenW * 0.9325, screenH * 0.8944, screenW * 0.0181, screenH * 0.0322, ":vehiculos/textures/freno.png", 0, 0, 0, tocolor(255, 0, 0, 255), false)
        end

        if getElementData(vehicle, "fuel") then
            dxDrawLine((screenW * 0.9575) - 1, (screenH * 0.8133) - 1, (screenW * 0.9575) - 1, screenH * 1.0000, tocolor(86, 86, 86, 255), 1, false)
            dxDrawLine(screenW * 0.9938, (screenH * 0.8133) - 1, (screenW * 0.9575) - 1, (screenH * 0.8133) - 1, tocolor(86, 86, 86, 255), 1, false)
            dxDrawLine((screenW * 0.9575) - 1, screenH * 1.0000, screenW * 0.9938, screenH * 1.0000, tocolor(86, 86, 86, 255), 1, false)
            dxDrawLine(screenW * 0.9938, screenH * 1.0000, screenW * 0.9938, (screenH * 0.8133) - 1, tocolor(86, 86, 86, 255), 1, false)
            dxDrawRectangle(screenW * 0.9575, screenH * 0.8133, screenW * 0.0362, screenH * 0.1867, tocolor(0, 0, 0, 255), false)
            dxDrawImage(screenW * 0.9650, screenH * 0.8156, screenW * 0.0206, screenH * 0.0400, ":vehiculos/textures/gasolina.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawLine((screenW * 0.9606) - 1, (screenH * 0.8600) - 1, (screenW * 0.9606) - 1, screenH * 0.9889, tocolor(171, 171, 171, 255), 1, false)
            dxDrawLine(screenW * 0.9906, (screenH * 0.8600) - 1, (screenW * 0.9606) - 1, (screenH * 0.8600) - 1, tocolor(171, 171, 171, 255), 1, false)
            dxDrawLine((screenW * 0.9606) - 1, screenH * 0.9889, screenW * 0.9906, screenH * 0.9889, tocolor(171, 171, 171, 255), 1, false)
            dxDrawLine(screenW * 0.9906, screenH * 0.9889, screenW * 0.9906, (screenH * 0.8600) - 1, tocolor(171, 171, 171, 255), 1, false)
            dxDrawRectangle(screenW * 0.9606, screenH * 0.8600, screenW * 0.0300, screenH * 0.1289, tocolor(86, 86, 86, 255), false)
            dxDrawRectangle(screenW * 0.9606, (screenH * 0.8600)+((screenH * 0.1289)*(100-getElementData(vehicle, "fuel"))/100), screenW * 0.0300, (screenH * 0.1289)*getElementData(vehicle, "fuel")/100, tocolor(171, 171, 171, 255), false)
        end
    end
end
addEventHandler("onClientRender", root, speedoMeterGUI)
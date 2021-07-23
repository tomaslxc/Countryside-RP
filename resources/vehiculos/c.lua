local tablapuertas = {}
local tablapanes = {}
local timer = nil

addEventHandler( "onClientResourceStart", resourceRoot,
function()
if not timer then timer = setTimer( function()
    local vehs = getElementsByType('vehicle')
    for v=1, #vehs do 
        tablapanes[vehs[v]] = {}
        for i=0, 6 do 
            local state = getVehiclePanelState( vehs[v], i )
            table.insert( tablapanes[vehs[v]], {i, state} )
        end
        tablapuertas[vehs[v]] = {}
        for i=0, 5 do 
            local state = getVehicleDoorState( vehs[v], i )
            table.insert( tablapuertas[vehs[v]], {i,state} )
        end 
    end
end, 1000, 0 )
end
end
)

function fireproofvehicle(theAttacker, theWeapon)
    if(theWeapon == 0) then
        cancelEvent()
        if tablapanes[source] then
            for i=1, #tablapanes[source] do 
                local p, state = unpack( tablapanes[source][i] )
                setVehiclePanelState( source, p, state )
            end
        end
        if tablapuertas[source] then
            for i=1, #tablapuertas[source] do 
                local p, state = unpack( tablapuertas[source][i] )
                setVehicleDoorState( source, p, state )
            end
        end
    end
end
addEventHandler("onClientVehicleDamage", getRootElement(), fireproofvehicle)

mal_huecos = {
    -- Barcos
    [472]=4,
    [473]=1,
    [493]=4,
    [595]=6,
    [484]=6,
    [430]=4,
    [453]=4,
    [452]=4,
    [446]=6,
    [454]=8,
    -- Motocicletas
    [581]=1,
    [462]=1,
    [521]=1,
    [463]=1,
    [522]=1,
    [461]=1,
    [448]=2,
    [468]=1,
    [586]=2,
    -- Autos 2 puertas
    [602]=4,
    [496]=4,
    [401]=4,
    [518]=4,
    [527]=4,
    [589]=4,
    [419]=4,
    [587]=4,
    [533]=4,
    [526]=4,
    [474]=4,
    [545]=4,
    [517]=4,
    [410]=4,
    [600]=4,
    [436]=4,
    [439]=4,
    [549]=4,
    [491]=4,
    --Autos 4 puertas & luxury
    [445]=6,
    [604]=6,
    [507]=6,
    [585]=6,
    [466]=6,
    [492]=6,
    [546]=6,
    [551]=6,
    [516]=6,
    [467]=6,
    [426]=6,
    [547]=6,
    [405]=6,
    [580]=6,
    [409]=4,
    [550]=6,
    [566]=6,
    [540]=6,
    [421]=6,
    [529]=6,
    -- Civil service
    [438]=6,
    [420]=6,
    [552]=4,
    -- Government vehicles
    [416]=2,
    [433]=0,
    [427]=2,
    [490]=6,
    [523]=2,
    [470]=6,
    [596]=4,
    [598]=4,
    [599]=6,
    [597]=4,
    [428]=0,
    -- Heavy & Utility trucks
    [499]=0,
    [609]=0,
    [498]=0,
    [573]=8,
    [455]=0,
    [588]=4,
    [403]=4,
    [423]=4,
    [412]=0,
    [443]=4,
    [515]=4,
    [514]=4,
    [456]=0,
    -- Light trucks & Vans
    [459]=6,
    [422]=4,
    [482]=6,
    [605]=4,
    [418]=6,
    [582]=2,
    [413]=6,
    [440]=6,
    [543]=4,
    [478]=4,
    [554]=6,
    -- SUVs & Wagons
    [579]=4,
    [400]=4,
    [404]=4,
    [489]=6,
    [505]=6,
    [479]=4,
    [442]=2,
    [458]=4,
    -- Lowriders
    [536]=4,
    [575]=4,
    [534]=4,
    [567]=4,
    [535]=4,
    [576]=4,
    [412]=4,
    -- Muscle cars
    [402]=2,
    [542]=4,
    [603]=2,
    [475]=2,
    -- Street racers
    [429]=2,
    [541]=2,
    [415]=2,
    [480]=4,
    [562]=2,
    [565]=2,
    [434]=2,
    [411]=2,
    [559]=2,
    [561]=4,
    [560]=4,
    [506]=2,
    [451]=2,
    [558]=2,
    [555]=2,
    [477]=2,
    -- Recreational
    [424]=1,
    [483]=4,
    [508]=6,
    [500]=4,
    [471]=1,
    [495]=6,
}

local screenW, screenH = guiGetScreenSize()
function calcular_espacio( vehiculo )
    local max = mal_huecos[getElementModel(vehiculo)]
    local suma = 0
    for i=1, 15 do
        if mal["h"..i..""][1] ~= 0 then
            suma = suma+1
        end
    end
    return suma
end

function calcular_espacio_libre()
    for i=1, 15 do
        if mal["h"..i..""][1] == 0 then
            return i
        end
    end
    return false
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

function isCursorInMaletero()
    if isCursorShowing() and maleteroabierto and isCursorHover(screenW * 0.7275, screenH * 0.3456, screenW * 0.1581, screenH * 0.4467) then
        return true
    else
        return false
    end
end

function updateMaletero()
    triggerServerEvent ( "mal:update", localPlayer, vehicle_element, mal )
end

function ponerItemEnMaletero(itemID, slot, hueco)
    if not hueco then
        if calcular_espacio(vehicle_element) < mal_huecos[getElementModel(vehicle_element)] then
            local hueco = calcular_espacio_libre()
            if hueco then
                mal["h"..hueco..""][1] = itemID
                mal["h"..hueco..""][2] = slot
                updateMaletero()
                return true
            else
                return false
            end
        else
            return false
        end
    else
        if hueco == "rec" then
            if mal.rec1[1] == 0 then
                mal.rec1[1] = itemID
                mal.rec1[2] = slot
            elseif mal.rec2[1] == 0 then
                mal.rec2[1] = itemID
                mal.rec2[2] = slot
            else
                return false
            end
        else
        mal["h"..hueco..""][1] = itemID
        mal["h"..hueco..""][2] = slot
        end
        updateMaletero()
        return true
    end
end
   

    r_title = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11 )
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  8 )

maleteroabierto = false
mal = false
vehicle_element = false
isItemInCursorVeh = false
function openMaletero(element, data)
    --comprobar si hay otro panel abierto
    --else etc..
    vehicle_element = element
    mal = data
    showCursor(true)
    maleteroabierto = true
end
addEvent("maletero:open", true)
addEventHandler("maletero:open", localPlayer, openMaletero)
function closeMaletero()
    mal = false
    maleteroabierto = false
    vehicle_element = false
    showCursor(false)
end
addEvent("maletero:close", true)
addEventHandler("maletero:close", localPlayer, closeMaletero)
function cerrarMaleteroForzado()
    mal = false
    maleteroabierto = false
    triggerServerEvent("maletero:cerrar:forzado", localPlayer, localPlayer, vehicle_element)
    vehicle_element = false
    showCursor(false)
end

addEventHandler("onClientRender", root,
    function()
    if getElementData(localPlayer, "isLoged") then
            --coordenadas raton--
        if isCursorShowing() then
        mmmx,mmmy = getCursorPosition ()
        local fullx,fully = guiGetScreenSize()
        cursorx,cursory = mmmx*fullx,mmmy*fully
        end
        ----
    if maleteroabierto then
        dxDrawRectangle(screenW * 0.7275, screenH * 0.3456, screenW * 0.1581, screenH * 0.4467, tocolor(0, 0, 0, 168), false)
        dxDrawRectangle(screenW * 0.7275, screenH * 0.3156, screenW * 0.1581, screenH * 0.0256, tocolor(0, 0, 0, 255), false)
        dxDrawText("MALETERO  "..calcular_espacio(vehicle_element).."/"..mal_huecos[getElementModel(vehicle_element)], screenW * 0.7275, screenH * 0.3156, screenW * 0.8856, screenH * 0.3411, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        
        if mal.h1[1] ~= 0 then
        dxDrawRectangle(screenW * 0.7306, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h1" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h1[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else
                dxDrawImage(screenW * 0.7306, screenH * 0.3533, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h1[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h2[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.7694, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h2" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h2[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.7694, screenH * 0.3522, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h2[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h3[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.8081, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h3" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h3[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.8081, screenH * 0.3522, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h3[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h4[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.8469, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h4" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h4[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.8469, screenH * 0.3533, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h4[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h5[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.7306, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h5" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h5[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.7306, screenH * 0.4233, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h5[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h6[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.7694, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h6" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h6[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.7694, screenH * 0.4244, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h6[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h7[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.8081, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h7" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h7[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.8081, screenH * 0.4244, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h7[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h8[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.8469, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h8" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h8[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.8469, screenH * 0.4244, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h8[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h9[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.7306, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
            if isItemInCursorVeh == "h9" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h9[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
            else   
                dxDrawImage(screenW * 0.7306, screenH * 0.4956, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h9[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h10[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.7694, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
             if isItemInCursorVeh == "h10" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h10[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
             else   
                dxDrawImage(screenW * 0.7694, screenH * 0.4956, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h10[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h11[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.8081, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
             if isItemInCursorVeh == "h11" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h11[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
             else   
                dxDrawImage(screenW * 0.8081, screenH * 0.4967, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h11[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h12[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.8469, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
             if isItemInCursorVeh == "h12" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h12[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
             else   
                dxDrawImage(screenW * 0.8469, screenH * 0.4956, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h12[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h13[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.7306, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
             if isItemInCursorVeh == "h13" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h13[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
             else   
                dxDrawImage(screenW * 0.7306, screenH * 0.5678, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h13[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h14[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.7694, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
             if isItemInCursorVeh == "h14" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h14[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
             else   
                dxDrawImage(screenW * 0.7694, screenH * 0.5678, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h14[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.h15[1] ~= 0 then        
        dxDrawRectangle(screenW * 0.8081, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
             if isItemInCursorVeh == "h15" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h15[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255),true)
             else   
                dxDrawImage(screenW * 0.8081, screenH * 0.5678, screenW * 0.0350, screenH * 0.0644, ":items/img/"..mal.h15[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end        



        dxDrawRectangle(screenW * 0.7275, screenH * 0.6633, screenW * 0.1581, screenH * 0.0256, tocolor(0, 0, 0, 255), false)
        dxDrawText("TUS COMPLEMENTOS", screenW * 0.7275, screenH * 0.6633, screenW * 0.8856, screenH * 0.6889, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.7494, screenH * 0.7056, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
        dxDrawRectangle(screenW * 0.8269, screenH * 0.7056, screenW * 0.0350, screenH * 0.0656, tocolor(0, 0, 0, 255), false)
        if mal.rec1[1] ~= 0 then
            if isItemInCursorVeh == "rec1" then
                dxDrawImage(cursorx,cursory, screenW * 0.0350, screenH * 0.0644, ":toys/recipientes/img/"..mal.rec1[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(screenW * 0.7494, screenH * 0.7067, screenW * 0.0350, screenH * 0.0644, ":toys/recipientes/img/"..mal.rec1[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
        if mal.rec2[1] ~= 0 then
            if isItemInCursorVeh == "rec2" then
                dxDrawImage(cursorx, cursory, screenW * 0.0350, screenH * 0.0644, ":toys/recipientes/img/"..mal.rec2[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            else
                dxDrawImage(screenW * 0.8269, screenH * 0.7067, screenW * 0.0350, screenH * 0.0644, ":toys/recipientes/img/"..mal.rec2[1]..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            end
        end
    end
    end
    end
)

function getHuecoFromCursorItem( )
    if isItemInCursorVeh == "h1" then
        return 1
    elseif isItemInCursorVeh == "h2" then
        return 2
    elseif isItemInCursorVeh == "h3" then
        return 3
    elseif isItemInCursorVeh == "h4" then
        return 4
    elseif isItemInCursorVeh == "h5" then
        return 5
    elseif isItemInCursorVeh == "h6" then
        return 6
    elseif isItemInCursorVeh == "h7" then
        return 7
    elseif isItemInCursorVeh == "h8" then
        return 8
    elseif isItemInCursorVeh == "h9" then
        return 9
    elseif isItemInCursorVeh == "h10" then
        return 10
    elseif isItemInCursorVeh == "h11" then
        return 11
    elseif isItemInCursorVeh == "h12" then
        return 12
    elseif isItemInCursorVeh == "h13" then
        return 13
    elseif isItemInCursorVeh == "h14" then
        return 14
    elseif isItemInCursorVeh == "h15" then
        return 15
    end
end

function clientClickVeh ( button, state )
if getElementData(localPlayer, 'isLoged') then
    if button == "left" and state == "down" and maleteroabierto then
        if isCursorHover(screenW * 0.7306, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mal.h1[1] ~= 0 then
            isItemInCursorVeh = "h1"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mal.h2[1] ~= 0 then
            isItemInCursorVeh = "h2"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mal.h3[1] ~= 0 then
            isItemInCursorVeh = "h3"
        elseif isCursorHover(screenW * 0.8469, screenH * 0.3522, screenW * 0.0350, screenH * 0.0656) and mal.h4[1] ~= 0 then
            isItemInCursorVeh = "h4"
        elseif isCursorHover(screenW * 0.7306, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mal.h5[1] ~= 0 then
            isItemInCursorVeh = "h5"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mal.h6[1] ~= 0 then
            isItemInCursorVeh = "h6"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mal.h7[1] ~= 0 then
            isItemInCursorVeh = "h7"
        elseif isCursorHover(screenW * 0.8469, screenH * 0.4233, screenW * 0.0350, screenH * 0.0656) and mal.h8[1] ~= 0 then
            isItemInCursorVeh = "h8"
        elseif isCursorHover(screenW * 0.7306, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mal.h9[1] ~= 0 then
            isItemInCursorVeh = "h9"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mal.h10[1] ~= 0 then
            isItemInCursorVeh = "h10"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mal.h11[1] ~= 0 then
            isItemInCursorVeh = "h11"
        elseif isCursorHover(screenW * 0.8469, screenH * 0.4956, screenW * 0.0350, screenH * 0.0656) and mal.h12[1] ~= 0 then
            isItemInCursorVeh = "h12"
        elseif isCursorHover(screenW * 0.7306, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656) and mal.h13[1] ~= 0 then
            isItemInCursorVeh = "h13"
        elseif isCursorHover(screenW * 0.7694, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656) and mal.h14[1] ~= 0 then
            isItemInCursorVeh = "h14"
        elseif isCursorHover(screenW * 0.8081, screenH * 0.5678, screenW * 0.0350, screenH * 0.0656) and mal.h15[1] ~= 0 then
            isItemInCursorVeh = "h15"
        elseif isCursorHover(screenW * 0.7494, screenH * 0.7056, screenW * 0.0350, screenH * 0.0656) and mal.rec1[1] ~= 0 then
            isItemInCursorVeh = "rec1"
        elseif isCursorHover(screenW * 0.8269, screenH * 0.7056, screenW * 0.0350, screenH * 0.0656) and mal.rec2[1] ~= 0 then
            isItemInCursorVeh = "rec2"
        end
    elseif button == "left" and state == "up" and maleteroabierto then
        if isItemInCursorVeh then
            if isItemInCursorVeh == "rec1" or isItemInCursorVeh == "rec2" then
                if exports.items:isCursorInBolsillo() then
                    exports.toys:darRecipienteFromMaletero(mal[isItemInCursorVeh][1], mal[isItemInCursorVeh][2], isItemInCursorVeh)
                end
                isItemInCursorVeh = false
            elseif exports.items:isCursorInBolsillo() then
                local item = mal[isItemInCursorVeh]
                local hueco = getHuecoFromCursorItem()
                exports.items:depositarItemFromMaletero(item[1], item[2], hueco)
                isItemInCursorVeh = false
                updateMaletero()
            end
            isItemInCursorVeh = false
        end
    end
end
end
addEventHandler ( "onClientClick", getRootElement(), clientClickVeh )

function remove_recipiente( pos )
    mal[pos][1] = 0
    mal[pos][2] = 0
    updateMaletero()
end
addEvent("mal:quitar_recipiente",true)
addEventHandler("mal:quitar_recipiente", localPlayer, remove_recipiente)

function isMaleteroOpened( )
    return maleteroabierto
end


-- CAPOT
vehcapot = false
function showCapot( vehID )
    vehcapot = vehID
    showCursor(true)
end
addEvent('capot:open', true)
addEventHandler('capot:open', localPlayer,showCapot)

function showCapotOff( vehID )
    vehcapot = false
    showCursor(false)
end
addEvent('capot:close', true)
addEventHandler('capot:close', localPlayer,showCapotOff)


addEventHandler("onClientRender", root,
    function()
        if vehcapot then
        dxDrawRectangle(screenW * 0.3819, screenH * 0.3256, screenW * 0.2625, screenH * 0.2533, tocolor(0, 0, 0, 109), false)
        dxDrawRectangle(screenW * 0.3819, screenH * 0.2511, screenW * 0.2625, screenH * 0.0700, tocolor(0, 0, 0, 198), false)
        dxDrawRectangle(screenW * 0.3912, screenH * 0.3456, screenW * 0.0563, screenH * 0.1056, tocolor(0, 0, 0, 109), false)
        dxDrawRectangle(screenW * 0.4537, screenH * 0.3456, screenW * 0.0563, screenH * 0.1056, tocolor(0, 0, 0, 109), false)
        dxDrawRectangle(screenW * 0.5162, screenH * 0.3456, screenW * 0.0563, screenH * 0.1056, tocolor(0, 0, 0, 109), false)
        dxDrawRectangle(screenW * 0.5787, screenH * 0.3456, screenW * 0.0563, screenH * 0.1056, tocolor(0, 0, 0, 109), false)
        dxDrawImage(screenW * 0.3912, screenH * 0.3467, screenW * 0.0563, screenH * 0.1044, ":clothes/texturas/Blanco/1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.4537, screenH * 0.3456, screenW * 0.0563, screenH * 0.1044, ":clothes/texturas/Blanco/1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.5162, screenH * 0.3456, screenW * 0.0563, screenH * 0.1044, ":clothes/texturas/Blanco/1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(screenW * 0.5787, screenH * 0.3456, screenW * 0.0563, screenH * 0.1044, ":clothes/texturas/Blanco/1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3906, screenH * 0.4567, screenW * 0.0569, screenH * 0.0211, tocolor(234, 8, 8, 198), false)
        dxDrawRectangle(screenW * 0.4537, screenH * 0.4567, screenW * 0.0569, screenH * 0.0211, tocolor(234, 8, 8, 198), false)
        dxDrawRectangle(screenW * 0.5169, screenH * 0.4567, screenW * 0.0569, screenH * 0.0211, tocolor(234, 8, 8, 198), false)
        dxDrawRectangle(screenW * 0.5787, screenH * 0.4567, screenW * 0.0569, screenH * 0.0211, tocolor(234, 8, 8, 198), false)
        dxDrawText("CAPOT", screenW * 0.3812, screenH * 0.2511, screenW * 0.6444, screenH * 0.3211, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("50%", screenW * 0.3906, screenH * 0.4567, screenW * 0.4475, screenH * 0.4778, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("50%", screenW * 0.4537, screenH * 0.4567, screenW * 0.5106, screenH * 0.4778, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("50%", screenW * 0.5162, screenH * 0.4567, screenW * 0.5731, screenH * 0.4778, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("50%", screenW * 0.5787, screenH * 0.4567, screenW * 0.6356, screenH * 0.4778, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        end
    end
)


local screenW, screenH = guiGetScreenSize()
showPanelGasolinera = false
function panelGasolineraON(veh)
    showPanelGasolinera = true
end
addEvent("panel:gasofa",true)
addEventHandler("panel:gasofa",localPlayer,panelGasolineraON)

function panelGasolineraOFF(veh)
    showPanelGasolinera = false
end
addEvent("panel:gasofaoff",true)
addEventHandler("panel:gasofaoff",localPlayer,panelGasolineraOFF)

addEventHandler("onClientRender", root,
    function()
        if showPanelGasolinera then
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh then
        dxDrawRectangle(screenW * 0.3781, screenH * 0.6489, screenW * 0.2294, screenH * 0.1722, tocolor(0, 0, 0, 158), false)
        dxDrawText("TANQUE: "..getElementData(veh, "fuel").."%", screenW * 0.3819, screenH * 0.6556, screenW * 0.6038, screenH * 0.6978, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.3769, screenH * 0.6022, screenW * 0.2306, screenH * 0.0422, tocolor(0, 0, 0, 255), false)
        dxDrawText("GASOLINERA", screenW * 0.3794, screenH * 0.6022, screenW * 0.6038, screenH * 0.6444, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4525) - 1, (screenH * 0.7067) - 1, (screenW * 0.4525) - 1, screenH * 0.7622, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.5275, (screenH * 0.7067) - 1, (screenW * 0.4525) - 1, (screenH * 0.7067) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4525) - 1, screenH * 0.7622, screenW * 0.5275, screenH * 0.7622, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.5275, screenH * 0.7622, screenW * 0.5275, (screenH * 0.7067) - 1, tocolor(0, 0, 0, 255), 1, false)
            if isCursorHover(screenW * 0.4525, screenH * 0.7067, screenW * 0.0750, screenH * 0.0556) then
                dxDrawRectangle(screenW * 0.4525, screenH * 0.7067, screenW * 0.0750, screenH * 0.0556, tocolor(166, 219, 146, 255), false)
                dxDrawText("RELLENAR", screenW * 0.4525, screenH * 0.7089, screenW * 0.5275, screenH * 0.7578, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
           
            else
                dxDrawRectangle(screenW * 0.4525, screenH * 0.7067, screenW * 0.0750, screenH * 0.0556, tocolor(66, 119, 46, 255), false)
                dxDrawText("RELLENAR", screenW * 0.4525, screenH * 0.7089, screenW * 0.5275, screenH * 0.7578, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
           
            end
        end
        end
    end
)

function gasolineraclick ( button, state )
if showPanelGasolinera then
    if button == "left" and state == "down" then
        if isCursorHover(screenW * 0.4525, screenH * 0.7067, screenW * 0.0750, screenH * 0.0556) then
            local veh = getPedOccupiedVehicle(localPlayer)
            local diferencia = 100-getElementData(veh, "fuel")
            triggerServerEvent("aplicar:gasolina", localPlayer, localPlayer,diferencia)
        end
    end
end
end
addEventHandler ( "onClientClick", getRootElement(), gasolineraclick )
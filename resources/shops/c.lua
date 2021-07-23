    r_title = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 20 ) or 'default-bold'
    r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11) or 'default-bold'
    r_text_final = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  16) or 'default-bold'
    r_desc = dxCreateFont( ":personajes/fonts/Roboto-Italic.ttf", 8 ) or 'default-bold'
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 ) or 'default-bold'
--variables shops--
id_shop = 0
shop_id, id_shop = 0
panel_shop = false
sscrolli = 1
carrito = false
--variables tiendas de ropa --
local tienda_de_ropa = false
local ropa_index = 1


local screenW, screenH = guiGetScreenSize()

function openShop(id,sid)
    if not panel_shop and not tienda_de_ropa then
    panel_shop = true
    shop_id = sid
    id_shop = id
    showCursor(true)
    carrito = {}
    end
end
addEvent('shop:open', true)
addEventHandler('shop:open', localPlayer, openShop)

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

function cm( m )
    local mstring = tostring(m)

    if m > 999 and m <= 999999 then
    mstring = tostring((m-(m%1000))/1000)..","..tostring(m%1000)
    elseif m > 999999 then
    mstring = tostring((m-(m%1000000))/1000000)..","..tostring(((m%1000000)-((m%1000000)%1000))/1000)..","..tostring((m%1000000)%1000)
    end
    return mstring
end

addEventHandler("onClientRender", root,
    function()
    if panel_shop then
        dxDrawRectangle(screenW * 0.3925, screenH * 0.0733, screenW * 0.2000, screenH * 0.0500, tocolor(34,94,122, 166), false)
        id_shop = tonumber(id_shop)
        dxDrawText(shops_names[id_shop][1], screenW * 0.3912, screenH * 0.0733, screenW * 0.5925, screenH * 0.1233, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        
        dxDrawRectangle(screenW * 0.3925, screenH * 0.1289, screenW * 0.2000, screenH * 0.5922, tocolor(34,94,122, 166), false)

        dxDrawRectangle(screenW * 0.3962, screenH * 0.1344, screenW * 0.1931, screenH * 0.1367, tocolor(34,94,122, 166), false)
        dxDrawImage(screenW * 0.3987, screenH * 0.1400, screenW * 0.0675, screenH * 0.1200, (id_shop ~= 13 and ":items/img/"..shops[id_shop][sscrolli].id..".png" or 'files/Skinid'..shops[id_shop][sscrolli].id..'.jpg'), 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(shops[id_shop][sscrolli].title, screenW * 0.4681, screenH * 0.1411, screenW * 0.5863, screenH * 0.1900, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][sscrolli].desc, screenW * 0.4681, screenH * 0.1900, screenW * 0.5863, screenH * 0.2600, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        if shops[id_shop][sscrolli+1] ~= nil then
        dxDrawRectangle(screenW * 0.3962, screenH * 0.2822, screenW * 0.1931, screenH * 0.1367, tocolor(34,94,122, 166), false)
        dxDrawImage(screenW * 0.3987, screenH * 0.2889, screenW * 0.0669, screenH * 0.1189, (id_shop ~= 13 and ":items/img/"..shops[id_shop][sscrolli+1].id..".png" or 'files/Skinid'..shops[id_shop][sscrolli+1].id..'.jpg'), 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(shops[id_shop][sscrolli+1].title, screenW * 0.4681, screenH * 0.2889, screenW * 0.5863, screenH * 0.3378, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][sscrolli+1].desc, screenW * 0.4681, screenH * 0.3378, screenW * 0.5863, screenH * 0.4078, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        end
        if shops[id_shop][sscrolli+2] ~= nil then
        dxDrawRectangle(screenW * 0.3962, screenH * 0.4300, screenW * 0.1931, screenH * 0.1367, tocolor(34,94,122, 166), false)
        dxDrawImage(screenW * 0.3987, screenH * 0.4356, screenW * 0.0669, screenH * 0.1200, (id_shop ~= 13 and ":items/img/"..shops[id_shop][sscrolli+2].id..".png" or 'files/Skinid'..shops[id_shop][sscrolli+2].id..'.jpg'), 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(shops[id_shop][sscrolli+2].title, screenW * 0.4681, screenH * 0.4356, screenW * 0.5863, screenH * 0.4844, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][sscrolli+2].desc, screenW * 0.4681, screenH * 0.4844, screenW * 0.5863, screenH * 0.5544, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        end
        if shops[id_shop][sscrolli+3] ~= nil then
        dxDrawRectangle(screenW * 0.3962, screenH * 0.5778, screenW * 0.1931, screenH * 0.1367, tocolor(34,94,122, 166), false)
        dxDrawImage(screenW * 0.3987, screenH * 0.5844, screenW * 0.0669, screenH * 0.1189, (id_shop ~= 13 and ":items/img/"..shops[id_shop][sscrolli+3].id..".png" or 'files/Skinid'..shops[id_shop][sscrolli+3].id..'.jpg'), 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(shops[id_shop][sscrolli+3].title, screenW * 0.4681, screenH * 0.5844, screenW * 0.5863, screenH * 0.6333, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][sscrolli+3].desc, screenW * 0.4681, screenH * 0.6333, screenW * 0.5863, screenH * 0.7033, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        end

        if isCursorHover(screenW * 0.3962, screenH * 0.1344, screenW * 0.1931, screenH * 0.1367) then
            dxDrawRectangle(screenW * 0.3962, screenH * 0.1344, screenW * 0.1931, screenH * 0.1367, tocolor(0,0,0,100), false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli].price), (screenW * 0.3962) - 1, (screenH * 0.1344) - 1, (screenW * 0.5887) - 1, (screenH * 0.2700) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli].price), (screenW * 0.3962) + 1, (screenH * 0.1344) - 1, (screenW * 0.5887) + 1, (screenH * 0.2700) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli].price), (screenW * 0.3962) - 1, (screenH * 0.1344) + 1, (screenW * 0.5887) - 1, (screenH * 0.2700) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli].price), (screenW * 0.3962) + 1, (screenH * 0.1344) + 1, (screenW * 0.5887) + 1, (screenH * 0.2700) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli].price), screenW * 0.3962, screenH * 0.1344, screenW * 0.5887, screenH * 0.2700, tocolor(140, 198, 98, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end
        if isCursorHover(screenW * 0.3962, screenH * 0.2822, screenW * 0.1931, screenH * 0.1367) and shops[id_shop][sscrolli+1] ~= nil then
            dxDrawRectangle(screenW * 0.3962, screenH * 0.2822, screenW * 0.1931, screenH * 0.1367, tocolor(0,0,0,100), false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+1].price), (screenW * 0.3962) - 1, (screenH * 0.2811) - 1, (screenW * 0.5887) - 1, (screenH * 0.4167) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+1].price), (screenW * 0.3962) + 1, (screenH * 0.2811) - 1, (screenW * 0.5887) + 1, (screenH * 0.4167) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+1].price), (screenW * 0.3962) - 1, (screenH * 0.2811) + 1, (screenW * 0.5887) - 1, (screenH * 0.4167) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+1].price), (screenW * 0.3962) + 1, (screenH * 0.2811) + 1, (screenW * 0.5887) + 1, (screenH * 0.4167) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+1].price), screenW * 0.3962, screenH * 0.2811, screenW * 0.5887, screenH * 0.4167, tocolor(140, 198, 98, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end
        if isCursorHover(screenW * 0.3962, screenH * 0.4300, screenW * 0.1931, screenH * 0.1367) and shops[id_shop][sscrolli+2] ~= nil then
            dxDrawRectangle(screenW * 0.3962, screenH * 0.5778, screenW * 0.1931, screenH * 0.1367, tocolor(0,0,0,100), false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+2].price), (screenW * 0.3962) - 1, (screenH * 0.4322) - 1, (screenW * 0.5887) - 1, (screenH * 0.5678) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+2].price), (screenW * 0.3962) + 1, (screenH * 0.4322) - 1, (screenW * 0.5887) + 1, (screenH * 0.5678) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+2].price), (screenW * 0.3962) - 1, (screenH * 0.4322) + 1, (screenW * 0.5887) - 1, (screenH * 0.5678) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+2].price), (screenW * 0.3962) + 1, (screenH * 0.4322) + 1, (screenW * 0.5887) + 1, (screenH * 0.5678) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+2].price), screenW * 0.3962, screenH * 0.4322, screenW * 0.5887, screenH * 0.5678, tocolor(140, 198, 98, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end
        if isCursorHover(screenW * 0.3962, screenH * 0.5778, screenW * 0.1931, screenH * 0.1367) and shops[id_shop][sscrolli+3] ~= nil then
            dxDrawRectangle(screenW * 0.3962, screenH * 0.5778, screenW * 0.1931, screenH * 0.1367, tocolor(0,0,0,100), false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+3].price), (screenW * 0.3962) - 1, (screenH * 0.5789) - 1, (screenW * 0.5887) - 1, (screenH * 0.7144) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+3].price), (screenW * 0.3962) + 1, (screenH * 0.5789) - 1, (screenW * 0.5887) + 1, (screenH * 0.7144) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+3].price), (screenW * 0.3962) - 1, (screenH * 0.5789) + 1, (screenW * 0.5887) - 1, (screenH * 0.7144) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+3].price), (screenW * 0.3962) + 1, (screenH * 0.5789) + 1, (screenW * 0.5887) + 1, (screenH * 0.7144) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("$ "..cm(shops[id_shop][sscrolli+3].price), screenW * 0.3962, screenH * 0.5789, screenW * 0.5887, screenH * 0.7144, tocolor(140, 198, 98, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        end
        


        dxDrawRectangle(screenW * 0.3925, screenH * 0.7322, screenW * 0.2000, screenH * 0.0600, tocolor(34,94,122, 166), false)
        if isCursorHover(screenW * 0.5375, screenH * 0.7322, screenW * 0.0519, screenH * 0.0600) then
            dxDrawRectangle(screenW * 0.5375, screenH * 0.7322, screenW * 0.0519, screenH * 0.0600, tocolor(2,105,156, 150), false)
        else
            dxDrawRectangle(screenW * 0.5375, screenH * 0.7322, screenW * 0.0519, screenH * 0.0600, tocolor(2,105,156, 109), false)
        end
        dxDrawText("Cerrar", screenW * 0.5375, screenH * 0.7322, screenW * 0.5894, screenH * 0.7922, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        dxDrawText("Usa la rueda del ratón\npara bajar el menú", screenW * 0.3925, screenH * 0.7322, screenW * 0.5375, screenH * 0.7922, tocolor(0, 0, 0, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        
        dxDrawRectangle(screenW * 0.5956, screenH * 0.1289, screenW * 0.0862, screenH * 0.5922, tocolor(34,94,122, 166), false)
        dxDrawRectangle(screenW * 0.5956, screenH * 0.1889, screenW * 0.0862, screenH * 0.4067, tocolor(34,94,122, 166), false)
        dxDrawText("Carrito", screenW * 0.5956, screenH * 0.1289, screenW * 0.6819, screenH * 0.1889, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
        if isCursorHover(screenW * 0.5956, screenH * 0.6500, screenW * 0.0862, screenH * 0.0644) then
            dxDrawRectangle(screenW * 0.5956, screenH * 0.6500, screenW * 0.0862, screenH * 0.0644, tocolor(2,105,156, 150), false)
        else
            dxDrawRectangle(screenW * 0.5956, screenH * 0.6500, screenW * 0.0862, screenH * 0.0644, tocolor(2,105,156, 109), false)
        end
        dxDrawText("Pagar todo", screenW * 0.5956, screenH * 0.6500, screenW * 0.6819, screenH * 0.7144, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        
        if #carrito == 0 then
            dxDrawText("  Vacío", screenW * 0.5956, screenH * 0.1889, screenW * 0.6819, screenH * 0.2189, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
        else
            if carrito[1] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.1889, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[1].name.." X", screenW * 0.5956, screenH * 0.1889, screenW * 0.6819, screenH * 0.2189, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[1].name, screenW * 0.5956, screenH * 0.1889, screenW * 0.6819, screenH * 0.2189, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[2] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.2189, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[2].name.." X", screenW * 0.5956, screenH * 0.2189, screenW * 0.6819, screenH * 0.2489, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[2].name, screenW * 0.5956, screenH * 0.2189, screenW * 0.6819, screenH * 0.2489, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[3] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.2489, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[3].name.." X", screenW * 0.5956, screenH * 0.2489, screenW * 0.6819, screenH * 0.2789, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[3].name, screenW * 0.5956, screenH * 0.2489, screenW * 0.6819, screenH * 0.2789, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[4] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.2789, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[4].name.." X", screenW * 0.5956, screenH * 0.2789, screenW * 0.6819, screenH * 0.3089, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[4].name, screenW * 0.5956, screenH * 0.2789, screenW * 0.6819, screenH * 0.3089, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[5] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.3089, screenW * 0.0844, screenH * 0.0300) then
                     dxDrawText("  "..carrito[5].name.." X", screenW * 0.5956, screenH * 0.3089, screenW * 0.6819, screenH * 0.3389, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[5].name, screenW * 0.5956, screenH * 0.3089, screenW * 0.6819, screenH * 0.3389, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[6] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.3389, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[6].name.." X", screenW * 0.5956, screenH * 0.3389, screenW * 0.6819, screenH * 0.3689, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[6].name, screenW * 0.5956, screenH * 0.3389, screenW * 0.6819, screenH * 0.3689, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[7] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.3689, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[7].name.." X", screenW * 0.5956, screenH * 0.3689, screenW * 0.6819, screenH * 0.3989, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[7].name, screenW * 0.5956, screenH * 0.3689, screenW * 0.6819, screenH * 0.3989, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[8] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.3989, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[8].name.." X", screenW * 0.5956, screenH * 0.3989, screenW * 0.6819, screenH * 0.4289, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[8].name, screenW * 0.5956, screenH * 0.3989, screenW * 0.6819, screenH * 0.4289, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[9] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.4289, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[9].name.." X", screenW * 0.5956, screenH * 0.4289, screenW * 0.6819, screenH * 0.4589, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[9].name, screenW * 0.5956, screenH * 0.4289, screenW * 0.6819, screenH * 0.4589, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            if carrito[10] ~= nil then
                if isCursorHover(screenW * 0.5962, screenH * 0.4589, screenW * 0.0844, screenH * 0.0300) then
                    dxDrawText("  "..carrito[10].name.." X", screenW * 0.5956, screenH * 0.4589, screenW * 0.6819, screenH * 0.4889, tocolor(200, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                else
                    dxDrawText("  "..carrito[10].name, screenW * 0.5956, screenH * 0.4589, screenW * 0.6819, screenH * 0.4889, tocolor(0, 0, 0, 194), 0.80, r_desc, "left", "center", false, false, false, false, false)
                end
            end
            dxDrawText("$ "..contarPrecioFinal(), screenW * 0.5956, screenH * 0.5967, screenW * 0.6819, screenH * 0.6500, tocolor(0, 0, 0, 194), 1.00, r_text_final, "center", "center", false, false, false, false, false)
        end
    end
    end
)

bindKey( "mouse_wheel_up", "down", function( )
    if panel_shop then
        if sscrolli > 1 then
            sscrolli = sscrolli - 1
        end
    end
end)

bindKey( "mouse_wheel_down", "down", function( )
    if panel_shop then
        if sscrolli+3 < #shops[id_shop] then
            sscrolli = sscrolli+1
        end
    end
end)

function cerrarPanel()
    panel_shop = false
    id_shop = 0
    sscrolli = 1
    carrito = nil
    carrito = false
    showCursor(false)
end

function addCart( sdata )
    if #carrito < 10 then
        if sdata ~= nil then
        table.insert(carrito, {id=sdata.id,name=sdata.title,slot=sdata.slot,price=sdata.price})
        end
    else
        exports.login:addNotification("No puedes añadir más de 10 productos al carrito", "error")
    end
end

function contarPrecioFinal( )
    local preciofinal = 0
    for i, cart in pairs(carrito) do
        preciofinal = preciofinal+tonumber(cart.price)
    end
    return tostring(preciofinal)
end

function removeCart( index )
    if carrito[index] ~= nil then
        table.remove(carrito, index)
    end
end

function comprarItems()
    triggerServerEvent("shop:comprar",localPlayer, localPlayer, carrito, shop_id, id_shop)
end
function shopClick ( button, state )
    if panel_shop and button=="left" and state=="down" then
        if isCursorHover(screenW * 0.5375, screenH * 0.7322, screenW * 0.0519, screenH * 0.0600) then
            cerrarPanel()
        elseif isCursorHover(screenW * 0.3962, screenH * 0.1344, screenW * 0.1931, screenH * 0.1367) then--item1
            addCart(shops[id_shop][sscrolli])
        elseif isCursorHover(screenW * 0.3962, screenH * 0.2822, screenW * 0.1931, screenH * 0.1367) then--item2
            addCart(shops[id_shop][sscrolli+1])
        elseif isCursorHover(screenW * 0.3962, screenH * 0.4300, screenW * 0.1931, screenH * 0.1367) then--item3
            addCart(shops[id_shop][sscrolli+2])
        elseif isCursorHover(screenW * 0.3962, screenH * 0.5778, screenW * 0.1931, screenH * 0.1367) then--item4
            addCart(shops[id_shop][sscrolli+3])
        elseif isCursorHover(screenW * 0.5962, screenH * 0.1889, screenW * 0.0844, screenH * 0.0300) then--item_cart_1
            removeCart(1)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.2189, screenW * 0.0844, screenH * 0.0300) then--item_cart_2
            removeCart(2)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.2489, screenW * 0.0844, screenH * 0.0300) then--item_cart_3
            removeCart(3)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.2789, screenW * 0.0844, screenH * 0.0300) then--item_cart_4
            removeCart(4)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.3089, screenW * 0.0844, screenH * 0.0300) then--item_cart_5
            removeCart(5)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.3389, screenW * 0.0844, screenH * 0.0300) then--item_cart_6
            removeCart(6)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.3689, screenW * 0.0844, screenH * 0.0300) then--item_cart_7
            removeCart(7)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.3989, screenW * 0.0844, screenH * 0.0300) then--item_cart_8
            removeCart(8)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.4289, screenW * 0.0844, screenH * 0.0300) then--item_cart_9
            removeCart(9)
        elseif isCursorHover(screenW * 0.5962, screenH * 0.4589, screenW * 0.0844, screenH * 0.0300) then--item_cart_10
            removeCart(10)
        elseif isCursorHover(screenW * 0.5956, screenH * 0.6500, screenW * 0.0862, screenH * 0.0644) then -- PAGAR TODO
            comprarItems()
        end
    end
end
addEventHandler ( "onClientClick", getRootElement(), shopClick )
--PED INMORTAL
function cancelPedDamage ( attacker )
    if getElementData(source, "pedArray") then
    cancelEvent()
    end
end
addEventHandler ( "onClientPedDamage", getRootElement(), cancelPedDamage )
----
function isShopOpened(  )
    return panel_shop
end


-----TIENDAS DE ROPA -----
local ropadata = false
local previsualizado = false



bindKey( "mouse_wheel_up", "down", function( )
    if tienda_de_ropa then
        if ropa_index > 1 then
            ropa_index = ropa_index - 1
        end
    end
end)

bindKey( "mouse_wheel_down", "down", function( )
    if tienda_de_ropa then
        if ropa_index+3 < #shops[id_shop] then
            ropa_index = ropa_index+1
        end
    end
end)

function openShopRopa(id,r,sid)
    if not tienda_de_ropa and not panel_shop then
    tienda_de_ropa = true
    shop_id, id_shop = sid
    id_shop = id
    ropadata = r
    showCursor(true)
    local x,y,z = getElementPosition(localPlayer)
    setCameraMatrix ( x+1,y+3,z, x+1,y,z )
    setElementRotation(localPlayer, 0,0,0)
    end
end
addEvent('shop:open:ropa', true)
addEventHandler('shop:open:ropa', localPlayer, openShopRopa)

addEventHandler("onClientRender", root,
    function()
        if tienda_de_ropa then
        dxDrawRectangle(screenW * 0.3990, screenH * 0.2731, screenW * 0.1870, screenH * 0.4981, tocolor(2,105,156, 161), false)
        dxDrawRectangle(screenW * 0.3990, screenH * 0.2222, screenW * 0.1870, screenH * 0.0417, tocolor(2,105,156, 161), false)
        dxDrawText(shops_names[id_shop][1], screenW * 0.3990, screenH * 0.2241, screenW * 0.5859, screenH * 0.2639, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926, tocolor(2,105,156, 161), false)
        dxDrawText(shops[id_shop][ropa_index][2], screenW * 0.4042, screenH * 0.2870, screenW * 0.5786, screenH * 0.3231, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][ropa_index][3], screenW * 0.4042, screenH * 0.3231, screenW * 0.5786, screenH * 0.3796, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        if isCursorHover(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926) or previsualizado ==  shops[id_shop][ropa_index][1] then
            dxDrawRectangle(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926, tocolor(0, 0, 0, 200), false)
            dxDrawText("$"..shops[id_shop][ropa_index][4], screenW * 0.42, screenH * 0.2981, screenW * 0.5510, screenH * 0.3630, tocolor(57, 179, 51, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            if previsualizado ==  shops[id_shop][ropa_index][1] then
                if isCursorHover(screenW * 0.4370, screenH * 0.3500, screenW * 0.1073, screenH * 0.0222) then
                    dxDrawRectangle(screenW * 0.4370, screenH * 0.3500, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                else
                    dxDrawRectangle(screenW * 0.4370, screenH * 0.3500, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                end
                dxDrawText("COMPRAR", screenW * 0.4359, screenH * 0.3500, screenW * 0.54, screenH * 0.3722, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            end
        end
        dxDrawRectangle(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926, tocolor(2,105,156, 161), false)
        dxDrawText(shops[id_shop][ropa_index+1][2], screenW * 0.4042, screenH * 0.3944, screenW * 0.5786, screenH * 0.4306, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][ropa_index+1][3], screenW * 0.4042, screenH * 0.4306, screenW * 0.5786, screenH * 0.4870, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        if isCursorHover(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926) or previsualizado ==  shops[id_shop][ropa_index+1][1] then
            dxDrawRectangle(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926, tocolor(0, 0, 0, 200), false)
            dxDrawText("$"..shops[id_shop][ropa_index+1][4], screenW * 0.42, screenH * 0.4083, screenW * 0.5510, screenH * 0.4731, tocolor(57, 179, 51, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            if previsualizado ==  shops[id_shop][ropa_index+1][1] then
                if isCursorHover(screenW * 0.4370, screenH * 0.4593, screenW * 0.1073, screenH * 0.0222) then
                    dxDrawRectangle(screenW * 0.4370, screenH * 0.4593, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                else
                    dxDrawRectangle(screenW * 0.4370, screenH * 0.4593, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                end
                dxDrawText("COMPRAR", screenW * 0.4359, screenH * 0.4593, screenW * 0.54, screenH * 0.4815, tocolor(2,105,156, 161), 1.00, r_button, "center", "center", false, false, false, false, false)
            end
        end
        dxDrawRectangle(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926, tocolor(2,105,156, 161), false)
        dxDrawText(shops[id_shop][ropa_index+2][2], screenW * 0.4042, screenH * 0.5009, screenW * 0.5786, screenH * 0.5370, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][ropa_index+2][3], screenW * 0.4042, screenH * 0.5370, screenW * 0.5786, screenH * 0.5935, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        if isCursorHover(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926) or previsualizado ==  shops[id_shop][ropa_index+2][1] then
            dxDrawRectangle(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926, tocolor(0, 0, 0, 200), false)
            dxDrawText("$"..shops[id_shop][ropa_index+2][4], screenW * 0.42, screenH * 0.5130, screenW * 0.5510, screenH * 0.5778, tocolor(57, 179, 51, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            if previsualizado ==  shops[id_shop][ropa_index+2][1] then
                if isCursorHover(screenW * 0.4359, screenH * 0.5657, screenW * 0.1073, screenH * 0.0222) then
                    dxDrawRectangle(screenW * 0.4359, screenH * 0.5657, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                else
                    dxDrawRectangle(screenW * 0.4359, screenH * 0.5657, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                end
                dxDrawText("COMPRAR", screenW * 0.4359, screenH * 0.5657, screenW * 0.54, screenH * 0.5880, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            end
        end
        dxDrawRectangle(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926, tocolor(2,105,156, 161), false)
        dxDrawText(shops[id_shop][ropa_index+3][2], screenW * 0.4042, screenH * 0.6074, screenW * 0.5786, screenH * 0.6435, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
        dxDrawText(shops[id_shop][ropa_index+3][3], screenW * 0.4042, screenH * 0.6435, screenW * 0.5786, screenH * 0.7000, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
        if isCursorHover(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926) or previsualizado ==  shops[id_shop][ropa_index+3][1] then
            dxDrawRectangle(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926, tocolor(0, 0, 0, 200), false)
            dxDrawText("$"..shops[id_shop][ropa_index+3][4], screenW * 0.42, screenH * 0.6213, screenW * 0.5510, screenH * 0.6861, tocolor(57, 179, 51, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            if previsualizado ==  shops[id_shop][ropa_index+3][1] then
                if isCursorHover(screenW * 0.4370, screenH * 0.6750, screenW * 0.1073, screenH * 0.0222) then
                    dxDrawRectangle(screenW * 0.4370, screenH * 0.6750, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                else
                    dxDrawRectangle(screenW * 0.4370, screenH * 0.6750, screenW * 0.1073, screenH * 0.0222, tocolor(2,105,156, 161), false)
                end
                dxDrawText("COMPRAR", screenW * 0.4370, screenH * 0.6750, screenW * 0.5401, screenH * 0.6972, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
            end
        end
        if isCursorHover(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481) then
            dxDrawRectangle(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481, tocolor(2,105,156, 161), false)
        else
            dxDrawRectangle(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481, tocolor(2,105,156, 161), false)
        end
        dxDrawText("Cerrar", screenW * 0.4380, screenH * 0.7194, screenW * 0.5464, screenH * 0.7676, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        end
    end
)


function ropaClick ( button, state )
    if tienda_de_ropa and button=="left" and state=="down" then
        if previsualizado then
            if previsualizado ==  shops[id_shop][ropa_index][1] then
                    if isCursorHover(screenW * 0.4370, screenH * 0.3500, screenW * 0.1073, screenH * 0.0222) then
                        triggerServerEvent("ropa:comprar",localPlayer, localPlayer, shops[id_shop][ropa_index][1], shops[id_shop][ropa_index][4], shop_id, id_shop)
                    end
            elseif previsualizado ==  shops[id_shop][ropa_index+1][1] then
                    if isCursorHover(screenW * 0.4370, screenH * 0.4593, screenW * 0.1073, screenH * 0.0222) then
                        triggerServerEvent("ropa:comprar",localPlayer, localPlayer, shops[id_shop][ropa_index+1][1], shops[id_shop][ropa_index+1][4], shop_id, id_shop)
                    end
            elseif previsualizado ==  shops[id_shop][ropa_index+2][1] then
                    if isCursorHover(screenW * 0.4359, screenH * 0.5657, screenW * 0.1073, screenH * 0.0222) then
                        triggerServerEvent("ropa:comprar",localPlayer, localPlayer, shops[id_shop][ropa_index+2][1], shops[id_shop][ropa_index+2][4], shop_id, id_shop)
                    end
            elseif previsualizado ==  shops[id_shop][ropa_index+3][1] then
                    if isCursorHover(screenW * 0.4370, screenH * 0.6750, screenW * 0.1073, screenH * 0.0222) then
                        triggerServerEvent("ropa:comprar",localPlayer, localPlayer, shops[id_shop][ropa_index+3][1], shops[id_shop][ropa_index+3][4], shop_id, id_shop)
                    end
            end
        end
        
        if isCursorHover(screenW * 0.4380, screenH * 0.7194, screenW * 0.1083, screenH * 0.0481) then
            tienda_de_ropa = false
            showCursor(false)
            id_shop = false
            previsualizado = false
            setCameraTarget ( localPlayer )
            exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,ropadata.ropa3,ropadata.raza)
        elseif isCursorHover(screenW * 0.3990, screenH * 0.2870, screenW * 0.1870, screenH * 0.0926) then
            exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            local data = exports.clothes:getRopaData(shops[id_shop][ropa_index][1])
            if data.tipo == 0 then
                exports.clothes:ponerRopa(localPlayer, shops[id_shop][ropa_index][1],ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 2 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,shops[id_shop][ropa_index][1],ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 3 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,shops[id_shop][ropa_index][1],ropadata.raza)
            end
            previsualizado = false
            setTimer ( function()
                previsualizado = shops[id_shop][ropa_index][1]
            end, 500, 1 )
        elseif isCursorHover(screenW * 0.3990, screenH * 0.3944, screenW * 0.1870, screenH * 0.0926) then
            exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            local data = exports.clothes:getRopaData(shops[id_shop][ropa_index+1][1])
            if data.tipo == 0 then
                exports.clothes:ponerRopa(localPlayer, shops[id_shop][ropa_index+1][1],ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 2 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,shops[id_shop][ropa_index+1][1],ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 3 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,shops[id_shop][ropa_index+1][1],ropadata.raza)
            end
            previsualizado = false
            setTimer ( function()
                previsualizado = shops[id_shop][ropa_index+1][1]
            end, 500, 1 )
        elseif isCursorHover(screenW * 0.3990, screenH * 0.5009, screenW * 0.1870, screenH * 0.0926) then
            exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            local data = exports.clothes:getRopaData(shops[id_shop][ropa_index+2][1])
            if data.tipo == 0 then
                exports.clothes:ponerRopa(localPlayer, shops[id_shop][ropa_index+2][1],ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 2 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,shops[id_shop][ropa_index+2][1],ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 3 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,shops[id_shop][ropa_index+2][1],ropadata.raza)
            end
            previsualizado = false
            setTimer ( function()
                previsualizado = shops[id_shop][ropa_index+2][1]
            end, 500, 1 )
        elseif isCursorHover(screenW * 0.3990, screenH * 0.6074, screenW * 0.1870, screenH * 0.0926) then
            exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            local data = exports.clothes:getRopaData(shops[id_shop][ropa_index+3][1])
            if data.tipo == 0 then
                exports.clothes:ponerRopa(localPlayer, shops[id_shop][ropa_index+3][1],ropadata.ropa2,ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 2 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,shops[id_shop][ropa_index+3][1],ropadata.ropa3,ropadata.raza)
            elseif data.tipo == 3 then
                exports.clothes:ponerRopa(localPlayer, ropadata.ropa1,ropadata.ropa2,shops[id_shop][ropa_index+3][1],ropadata.raza)
            end
            previsualizado = false
            setTimer ( function()
                previsualizado = shops[id_shop][ropa_index+3][1]
            end, 500, 1 )

        end


    end
end
addEventHandler ( "onClientClick", getRootElement(), ropaClick )
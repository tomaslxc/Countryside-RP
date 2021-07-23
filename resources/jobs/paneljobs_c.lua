local sx, sy = guiGetScreenSize()
local x, y = ( sx /1024 ), ( sy/768 ) -- Para multiplicar y tal
local abierto = false 

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", 20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  11)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", 10 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", 11 )

function cancelPedDamage ( attacker )
    cancelEvent()
end
addEventHandler ( "onClientPedDamage", getRootElement(), cancelPedDamage )

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

local w, h = 350, 450 -- Ancho y alto del panel general.
local wDentro, hDentro = 320, 65 -- Ancho y alto de los paneles de dentro.
local tick, tickClick = 0, nil

local listaJobs = {

    {"job.png", "Granjero", "Tienes que cosechar o arar dependiendo\n de la época del año en la granja de Los Santos.", "granjero:introduce"},
    -- {"job.png", "Leñador", "Tienes que cosechar o arar dependiendo\n de la época del año en la granja de Los Santos.", "granjero:introduce"},
    -- {"job.png", "Chófer de bus", "Tienes que recorrer el condado con el bus\n y recoger a la gente que lo necesite.", "bus:introduce"},
    {"job.png", "Pescador", "Ve en busca de peces para vender en el mercado.", "pescador:introduce"},
}

function dibujarPanelJobs()
    tick = getTickCount()
    dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor(34,94,122,150) )
    dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*50, tocolor(2,105,156) )
    dxDrawText( "TRABAJOS", 0, y*(-400), sx, sy, tocolor(255,255,255), y*(1), r_title, "center", "center" )
    dxDrawText( "Aquí tienes la lista de todos los trabajos\ntemporales con los que podrás empezar.", 0, y*(-290), sx, sy, tocolor(255,255,255), y*(1), r_desc, "center", "center" )
    fila = 0
    for i=1, #listaJobs do 
        if listaJobs[i] then
            fila = fila + 1
            dxDrawRectangle( ( sx - x*wDentro )/2, ( sy - y*((hDentro+320)-fila*150) )/2, x*wDentro, y*hDentro, isMouseInPosition(( sx - x*wDentro )/2, ( sy - y*((hDentro+320)-fila*150) )/2, x*wDentro, y*hDentro) and tocolor(34,94,122,255) or tocolor(34,94,122,150) )
            dxDrawImage( ( sx - x*(wDentro-10) )/2, ( sy - y*((hDentro+310)-fila*150) )/2, x*50, y*50, listaJobs[i][1] )
            dxDrawText( listaJobs[i][2], ( sx - x*(wDentro-120) )/2, ( sy - y*((hDentro+305)-fila*150) )/2, 0, 0, tocolor(255,255,255), y*1, r_text )
            dxDrawRectangle( ( sx - x*wDentro )/2, ( sy - y*((hDentro+320)-fila*150) )/2, x*wDentro, y*2, isMouseInPosition(( sx - x*wDentro )/2, ( sy - y*((hDentro+320)-fila*150) )/2, x*wDentro, y*hDentro) and tocolor(34,94,122,150) or tocolor(34,94,122,255) )
            dxDrawText( listaJobs[i][3], ( sx - x*(wDentro-120) )/2, ( sy - y*((hDentro+265)-fila*150) )/2, 0, 0, tocolor(255,255,255), y*0.85, r_desc )
            if isMouseInPosition(( sx - x*wDentro )/2, ( sy - y*((hDentro+320)-fila*150) )/2, x*wDentro, y*hDentro) and getKeyState( "mouse1" ) == true then
                if not tickClick or ( tick - tickClick ) > 500 then
                    tickClick = getTickCount()
                    local trabajoActual = getElementData( getLocalPlayer(), "trabajo" ) or nil
                    if trabajoActual ~= listaJobs[i][2] then
                        setElementData(localPlayer, "trabajo", listaJobs[i][2])
                        triggerEvent( listaJobs[i][4], getLocalPlayer() )
                        removeEventHandler("onClientRender", getRootElement(), dibujarPanelJobs)
                        abierto = false
                    else
                        outputChatBox( "(( Este ya es tu trabajo actual. ))", 255, 150, 0 )
                    end
                end
            elseif isMouseInPosition(( sx - x*w )/2, ( sy - y*(h-820) )/2, x*w, y*40) and getKeyState( "mouse1" ) == true then -- El boton de cerrar
                if not tickClick or ( tick - tickClick ) > 500 then
                    tickClick = getTickCount()
                    removeEventHandler("onClientRender", getRootElement(), dibujarPanelJobs)
                    abierto = false                   
                end
            end
        end
    end
    dxDrawRectangle( ( sx - x*w )/2, ( sy - y*(h-820) )/2, x*w, y*40, isMouseInPosition(( sx - x*w )/2, ( sy - y*(h-820) )/2, x*w, y*40) and tocolor(2,105,156,150) or tocolor(2,105,156) )
    dxDrawText( "Cerrar", 0, y*(410), sx, sy, tocolor(255,255,255), y*(1), r_button, "center", "center" )
end

addEvent( "jobs:abrirPanel", true )
addEventHandler( "jobs:abrirPanel", getRootElement(), 
    function()
        if not abierto then
            tickClick = getTickCount()+200 -- Para que no elija un job cuando recien abres el panel
            addEventHandler("onClientRender", getRootElement(), dibujarPanelJobs)
            abierto = true
        end
    end
)
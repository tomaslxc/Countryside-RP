local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1024 ), ( sy / 768 )

local wbarra, ybarra = 100, 20

local ventana = 1

local w, h = 400, 500

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", y*20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*11)
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*16)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", y*8 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", y*11 )

local wactual = 10

function drawImpuestos()
	if ventana == 1 then
		dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor( 2,105,156, 150 ) )
		dxDrawText( "IMPUESTOS", x*0, y*(-450), sx, sy, tocolor( 255, 255, 255 ), y*1, r_title, "center", "center" )
		dxDrawText( "Regula desde aqui los impuestos actuales de Countryside", x*0, y*(-400), sx, sy, tocolor( 255, 255, 255 ), y*1, r_desc, "center", "center" )
	end
end

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		if getPlayerName( getLocalPlayer() ) == 'Frank_Westwood' then
			addEventHandler( "onClientRender", getRootElement(), drawImpuestos )
		end
	end
)
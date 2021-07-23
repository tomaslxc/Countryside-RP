local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1280 ), ( sy / 720 )

local w,h = 600, 400

local w1, h1 = 300, 70

local barras = {}

local impuestos = {}

local scroll, maxscroll = 1, 3

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", y*20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf", y*11 )
r_text_final = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*11)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", y*9 )
r_thin = dxCreateFont( ":fuentes/Roboto-Thin.ttf", 8 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", y*11 )

function dibujarPanel()
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor( 0, 0, 0, 150 ) )
	dxDrawText( "IMPUESTOS", x*(-280), y*(-350), sx, sy, tocolor( 255, 255, 255 ), y*2, "default-bold", "center", "center" )
	
	if #impuestos > 0 then
		fila = 0
		for i=scroll, scroll + maxscroll do
			if impuestos[i] then
				fila = fila + 1
				dxDrawRectangle( ( sx - x*(w1+280) )/2, ( sy - y*((h1+390)-fila*150) )/2, x*w1, y*h1, tocolor( 160, 100, 50, 150 ) )
				
				dxDrawText( "Sobre "..impuestos[i].sobre, ( sx - x*(w1+270) )/2, ( sy - y*((h1+380)-fila*150) )/2, x*w1, y*h1, tocolor( 255 ,255, 255 ), y*0.7, r_text )
				
				dxDrawImage( ( sx - x*(w1+280) )/2, ( sy - y*((h1+310)-fila*150) )/2, x*30, y*30, "imgs/cerrado.png" )
				
				if impuestos[i].porcentaje == 1 then
					if not barras[i] then
						barras[i] = guiCreateScrollBar(( sx - x*(w1+120) )/2, ( sy - y*((h1+300)-fila*150) )/2, x*200, y*20,true,false)
						guiScrollBarSetScrollPosition( barras[i], ( impuestos[i].cantidad ) )
					end
					dxDrawText( guiScrollBarGetScrollPosition( barras[i] ).."%", ( sx - x*(w1+180) )/2, ( sy - y*((h1+290)-fila*150) )/2, x*w1, y*h1, tocolor( 255 ,255, 255 ), y*0.7, r_text )
				else
				
				end
			end
		end
	else
		dxDrawText( "No hay impuestos", x*(-280), y*(-200), sx, sy, tocolor( 255, 255, 255 ), y*2, "default-bold", "center", "center" )
	end
end

addEvent( "impuestos:topanel", true )
addEventHandler( "impuestos:topanel", getRootElement(),
	function( tabla )
		impuestos = tabla
	end
)

--[[addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		if getPlayerName( getLocalPlayer() ) == "Staff_Blue" then
			triggerServerEvent( "impuestos:getall", getLocalPlayer() )
			addEventHandler( "onClientRender", getRootElement(), dibujarPanel )
		end
	end
)--]]
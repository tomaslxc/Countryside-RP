local screenW, screenH = guiGetScreenSize()
local x, y = ( screenW / 1280 ), ( screenH / 720 )

local abierto = false

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

local tick, ntick = 0, nil

function haceClick( posx, posy, posw, posh )
	if isMouseInPosition( posx, posy, posw, posh ) and getKeyState( "mouse1" ) == true then
		if not ntick or ( tick - ntick ) > 500 then
			ntick = getTickCount()
			return true
		end
	end
end

function dibujarAjustes()
	tick = getTickCount()
	dxDrawRectangle(screenW * 0.3539, screenH * 0.2292, screenW * 0.2930, screenH * 0.5431, tocolor(0, 0, 0, 109), false)
	dxDrawText("AJUSTES", screenW * 0.3531, screenH * 0.2292, screenW * 0.6469, screenH * 0.3153, tocolor(255, 255, 255, 255), y*2.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Optimiza tu experiencia en el servidor.", screenW * 0.3539, screenH * 0.2625, screenW * 0.6477, screenH * 0.3486, tocolor(255, 255, 255, 255), y*1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawLine(screenW * 0.3539, screenH * 0.3292, screenW * 0.6445, screenH * 0.3292, tocolor(255, 255, 255, 255), 1, false)
	dxDrawText("Distancia de visión:", screenW * 0.3617, screenH * 0.3486, screenW * 0.4555, screenH * 0.3722, tocolor(255, 255, 255, 255), y*1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.4555, screenH * 0.3778, screenW * 0.0617, screenH * 0.0264, isMouseInPosition(screenW * 0.4555, screenH * 0.3778, screenW * 0.0617, screenH * 0.0264) and tocolor( 2,115,156, 150 ) or tocolor(2,105,156, 194), false)
	dxDrawText("Aplicar", screenW * 0.4547, screenH * 0.3778, screenW * 0.5172, screenH * 0.4042, tocolor(255, 255, 255, 255), y*1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Activar nubes:", screenW * 0.3625, screenH * 0.4292, screenW * 0.4562, screenH * 0.4528, tocolor(255, 255, 255, 255), y*1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Activar carga asíncrona de mapas.", screenW * 0.3625, screenH * 0.5333, screenW * 0.5219, screenH * 0.5583, tocolor(255, 255, 255, 255), y*1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Puedes ganar FPS activando esta opción.", screenW * 0.3625, screenH * 0.5583, screenW * 0.5398, screenH * 0.5806, tocolor(255, 255, 255, 255), y*1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3641, screenH * 0.5958, screenW * 0.0602, screenH * 0.0306, isMouseInPosition(screenW * 0.3641, screenH * 0.5958, screenW * 0.0602, screenH * 0.0306) and tocolor( 2,115,156, 150 ) or tocolor(2,105,156, 173), false) -- Activar carga asíncrona
	dxDrawRectangle(screenW * 0.4375, screenH * 0.5958, screenW * 0.0602, screenH * 0.0306, isMouseInPosition(screenW * 0.4375, screenH * 0.5958, screenW * 0.0602, screenH * 0.0306) and tocolor( 2,115,156, 150 ) or tocolor(2,105,156, 173), false) -- Desactivar carga asíncrona
	dxDrawText("Activar", screenW * 0.3641, screenH * 0.5944, screenW * 0.4250, screenH * 0.6264, tocolor(255, 255, 255, 255), y*1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Desactivar", screenW * 0.4375, screenH * 0.5944, screenW * 0.4984, screenH * 0.6264, tocolor(255, 255, 255, 255), y*1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3625, screenH * 0.4875, screenW * 0.0602, screenH * 0.0306, isMouseInPosition(screenW * 0.3625, screenH * 0.4875, screenW * 0.0602, screenH * 0.0306) and tocolor( 2,115,156, 150 ) or tocolor(2,105,156, 173), false) -- Activar nubes
	dxDrawRectangle(screenW * 0.4359, screenH * 0.4889, screenW * 0.0602, screenH * 0.0306, isMouseInPosition(screenW * 0.4359, screenH * 0.4889, screenW * 0.0602, screenH * 0.0306) and tocolor( 2,115,156, 150 ) or tocolor(2,105,156, 173), false) -- Desactivar nubes
	dxDrawText("Activar", screenW * 0.3617, screenH * 0.4875, screenW * 0.4227, screenH * 0.5194, tocolor(255, 255, 255, 255), y*1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Desactivar", screenW * 0.4359, screenH * 0.4861, screenW * 0.4969, screenH * 0.5181, tocolor(255, 255, 255, 255), y*1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Desactiva las nubes para más FPS.", screenW * 0.3625, screenH * 0.4528, screenW * 0.6023, screenH * 0.4764, tocolor(255, 255, 255, 255), y*1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawText("Activar lluvia:", screenW * 0.3641, screenH * 0.6403, screenW * 0.5234, screenH * 0.6653, tocolor(255, 255, 255, 255), y*1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3625, screenH * 0.6944, screenW * 0.0602, screenH * 0.0306, isMouseInPosition(screenW * 0.3625, screenH * 0.6944, screenW * 0.0602, screenH * 0.0306) and tocolor( 2,115,156, 150 ) or tocolor(12,105,156, 173), false) -- Activar lluvia
	dxDrawText("Activar", screenW * 0.3617, screenH * 0.6931, screenW * 0.4227, screenH * 0.7250, tocolor(255, 255, 255, 255), y*1.00, "default", "center", "center", false, false, false, false, false)
	dxDrawText("Desactiva o apaga la lluvia para disminuir el lag.", screenW * 0.3641, screenH * 0.6653, screenW * 0.5414, screenH * 0.6875, tocolor(255, 255, 255, 255), y*1.00, "default", "left", "top", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.4375, screenH * 0.6944, screenW * 0.0602, screenH * 0.0306, isMouseInPosition(screenW * 0.4375, screenH * 0.6944, screenW * 0.0602, screenH * 0.0306) and tocolor( 2,115,156, 150 ) or tocolor(2,105,156, 173), false) -- Desactivar lluvia
	dxDrawText("Desactivar", screenW * 0.4367, screenH * 0.6931, screenW * 0.4977, screenH * 0.7250, tocolor(255, 255, 255, 255), y*1.00, "default", "center", "center", false, false, false, false, false)
	
	if haceClick( screenW * 0.4555, screenH * 0.3778, screenW * 0.0617, screenH * 0.0264 ) then -- Aplicar distancia de visión
		local distancia = guiGetText( distancia )
		if distancia and tonumber( distancia ) then
			setFarClipDistance( distancia )
			outputChatBox( "Has cambiado la distancia de visión a "..distancia, 0, 255, 0 )
		else
			outputChatBox( "Introduce un valor de distancia válido.", 255, 0, 0 )
		end
	elseif haceClick( screenW * 0.3641, screenH * 0.5958, screenW * 0.0602, screenH * 0.0306 ) then
		engineSetAsynchronousLoading( true, true )
		outputChatBox( "Carga asíncrona activada. Deberás notar una notable mejora en tus FPS.", 0, 255, 0 )
	elseif haceClick( screenW * 0.4375, screenH * 0.5958, screenW * 0.0602, screenH * 0.0306 ) then
		engineSetAsynchronousLoading( false, true )
		outputChatBox( "Carga asíncrona desactivada. Puede que notes un bajon de FPS en caso de tener PC malo.", 0, 255, 0 )
	elseif haceClick( screenW * 0.3625, screenH * 0.4875, screenW * 0.0602, screenH * 0.0306 ) then
		setCloudsEnabled( true )
		outputChatBox( "Nubes activadas.", 0, 255, 0 )
	elseif haceClick( screenW * 0.4359, screenH * 0.4889, screenW * 0.0602, screenH * 0.0306 ) then
		setCloudsEnabled( false )
		outputChatBox( "Nubes desactivadas.", 0, 255, 0 )
	elseif haceClick( screenW * 0.3625, screenH * 0.6944, screenW * 0.0602, screenH * 0.0306 ) then
		setRainLevel( getRainLevel() )
		outputChatBox( "Has activado la lluvia.", 0, 255, 0 )
	elseif haceClick( screenW * 0.4375, screenH * 0.6944, screenW * 0.0602, screenH * 0.0306 ) then
		setRainLevel( 0 )
		outputChatBox( "Has desactivado la lluvia.", 0, 255, 0 )
	end
end

bindKey( "F10", "down", function()
	if not abierto then
		distancia = guiCreateEdit(0.36, 0.38, 0.09, 0.03, "", true)   
		addEventHandler( "onClientRender", getRootElement(), dibujarAjustes )
		abierto = true
	else
		if isElement( distancia ) then destroyElement( distancia ) distancia = nil end
		removeEventHandler( "onClientRender", getRootElement(), dibujarAjustes )
		abierto = false
	end
end
)

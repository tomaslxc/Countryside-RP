local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1280 ), ( sy / 720 )
local abierto = false

local pos = 1
local tick, ntick = 0, nil

local w, h = 350, 300

local textoColor = {255,255,255}

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function click(...)
	if getKeyState( "mouse1" ) == true and isMouseInPosition( ... ) then
		if not ntick or ( tick - ntick ) > 200 then
			ntick = getTickCount()
			return true
		end
	end
end

local preguntas = {

	{
		"¿A qué velocidad hay que ir en la ciudad?",
		"60km/h",
		"20km/h",
		"100km/h",
		1,
	},
	{
		"¿Quién está obligado en un vehículo a motor a llevar\nel cinturón puesto?",
		"Sólo el conductor.",
		"Conductor y copiloto, atrás no.",
		"Todos los que están en el vehículo.",
		3,
	},
	{
		"¿Por qué carril debo conducir para adelantar?",
		"Por el arcén.",
		"Por la izquierda.",
		"Por la derecha.",
		2,
	},
	{
		"¿Quién debe llevar casco en una moto?",
		"Todos.",
		"Sólo el conductor",
		"Piloto y opcional, el copiloto en interestatal.",
		1,
	},
	{
		"¿A cuánto puedo conducir en una carretera\ninterestatal?",
		"A 160km/h.",
		"Máximo 180km/h",
		"Máximo 120km/h.",
		3,
	},
	{
		"¿Tengo que llevar el carnet siempre conmigo?",
		"No es necesario.",
		"Es obligatorio",
		"Es opcional.",
		2,
	},
	{
		"En caso de niebla o lluvia, ¿qué luces debo\nllevar puestas?",
		"Las largas deben estar encendidas.",
		"Sólo las de posición",
		"Las cortas o las de cruce.",
		3,
	},

}

r_title = dxCreateFont( ":fuentes/Roboto-BoldCondensed.ttf", y*20 )
r_text = dxCreateFont( ":fuentes/Roboto-Regular.ttf",  y*11)
r_desc = dxCreateFont( ":fuentes/Roboto-Italic.ttf", y*10 )
r_button = dxCreateFont( ":fuentes/Roboto-Condensed.ttf", y*11 )

local acertadas = 0
local respuesta = {}
local erradas = 0

function debugTodo()
	respuesta = {}
	acertadas = 0
	erradas = 0
	removeEventHandler( "onClientRender", getRootElement(), dibujarTest )
end

function dibujarTest()
	tick = getTickCount()
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*(h+80) )/2, x*w, y*40, tocolor(34,94,122, 164))
	dxDrawText( "Exámen teórico", 0, y*(-340), sx, sy, tocolor(255,255,255), y*1, r_title, "center", "center" )
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*h )/2, x*w, y*h, tocolor(2,105,156, 162) )
	
	dxDrawText( preguntas[pos][1], 0, y*(-240), sx, sy, tocolor(255,255,255), y*0.7, r_text, "center", "center" )
	
	dxDrawText( "Pregunta "..pos.." de "..#preguntas, 0, y*(-160), sx, sy, tocolor(255,255,255), y*0.5, "bankgothic", "center", "center" )
	--dxDrawText( "Acertadas: "..acertadas.." | Erradas: "..erradas, 0, y*(-130), sx, sy, tocolor(255,255,255), y*0.5, "bankgothic", "center", "center" )
	
	dxDrawText( "Responde correctamente para aprobar.\nMarca tu respuesta con un click y dale a siguiente.", 0, y*(185), sx, sy, tocolor(255,255,255), y*0.8, r_desc, "center", "center" )
	
	dxDrawRectangle( ( sx - x*290 )/2, ( sy - y*(100) )/2, x*290, y*30, isMouseInPosition(( sx - x*290 )/2, ( sy - y*(100) )/2, x*290, y*30) and tocolor(34,94,122,150) or tocolor(0,0,0,150) )
	dxDrawText( preguntas[pos][2], 0, y*(-68), sx, sy, respuesta[pos] == 1 and tocolor(255,150,0) or tocolor(255,255,255), y*1, r_desc, "center", "center" )
	if click(( sx - x*290 )/2, ( sy - y*(100) )/2, x*290, y*30) then
		respuesta[pos] = 1
	end
	
	dxDrawRectangle( ( sx - x*290 )/2, ( sy - y*(10) )/2, x*290, y*30, isMouseInPosition(( sx - x*290 )/2, ( sy - y*(10) )/2, x*290, y*30) and tocolor(34,94,122,150) or tocolor(0,0,0,150) )
	dxDrawText( preguntas[pos][3], 0, y*(20), sx, sy, respuesta[pos] == 2 and tocolor(2,105,156,0) or tocolor(255,255,255), y*1, r_desc, "center", "center" )
	if click(( sx - x*290 )/2, ( sy - y*(10) )/2, x*290, y*30) then
		respuesta[pos] = 2
	end
	
	dxDrawRectangle( ( sx - x*290 )/2, ( sy - y*(-80) )/2, x*290, y*30, isMouseInPosition(( sx - x*290 )/2, ( sy - y*(-80) )/2, x*290, y*30) and tocolor(34,94,122,150) or tocolor(0,0,0,150) )
	dxDrawText( preguntas[pos][4], 0, y*(110), sx, sy, respuesta[pos] == 3 and tocolor(255,150,0) or tocolor(255,255,255), y*1, r_desc, "center", "center" )
	if click(( sx - x*290 )/2, ( sy - y*(-80) )/2, x*290, y*30) then
		respuesta[pos] = 3
	end
	
	dxDrawRectangle( ( sx - x*w )/2, ( sy - y*(h-520) )/2, x*w, y*40, isMouseInPosition(( sx - x*w )/2, ( sy - y*(h-520) )/2, x*w, y*40) and tocolor(2,105,91, 255) or tocolor(2, 105, 156, 164) )
	dxDrawText( pos == #preguntas and "Terminar" or "Siguiente", 0, y*(260), sx, sy, tocolor(255,255,255), y*1, r_text, "center", "center" )
	if click(( sx - x*w )/2, ( sy - y*(h-520) )/2, x*w, y*40) then
		if respuesta[pos] then
			if pos == #preguntas then
				outputChatBox( "Resultado del test ("..( acertadas > erradas and "APTO" or "NO APTO" ).."):", 255, 255, 0 )
				outputChatBox( "    - Acertadas: "..acertadas, 255, 255, 255 )
				outputChatBox( "    - Erradas: "..erradas, 255, 255, 255 )
				triggerServerEvent( "teorico:cederNota", getLocalPlayer(), acertadas > erradas and 1 or 2 )
				debugTodo()
			else
				if respuesta[pos] == preguntas[pos][5] then
					acertadas = acertadas + 1
				else
					erradas = erradas + 1
				end
				pos = math.min( pos + 1, #preguntas )
			end
		else
			outputChatBox( "Debes responder a la pregunta del test.", 255, 0, 0 )
		end
	end
end

addEvent( "teorico:abrir", true )
addEventHandler( "teorico:abrir", getRootElement(),
	function()
		if not abierto then
			abierto = true
			addEventHandler( "onClientRender", getRootElement(), dibujarTest )
		end
	end
)
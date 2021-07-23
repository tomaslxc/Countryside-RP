local sx, sy = guiGetScreenSize()
local x, y = ( sx / 1280 ), ( sy / 768 )

local bloqueos = {

	{1424, "Valla fina"},
	{1423, "Valla azul y roja"},
	{1422, "Dos medios pilares"},
	{1228, "Barrera blanca y roja"},
	{1425, "Cartel naranja de suelo"},
	{978, "Quitamiedos rojo y blanco"},
	{981, "Bloqueo grande con vallas y cartel"},
	{1427, "Pequeña valla con luz"},
	{3091, "Valla grande con flecha"},
	{3578, "Valla larga amarilla"},

}

local actual = 1

local abierto = false

local w, h = 50, 50

local tick, ntick = 0, nil

local obj = nil

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function hudBloqueos()
	tick = getTickCount()
	
	--.dxDrawRectangle( x*10, y*300, x*200, y*200, tocolor( 0, 0, 0, 150 ) )

	dxDrawText( bloqueos[actual][2], x*0, y*351, sx, sy, tocolor(0,0,0), y*2, "default-bold", "center", "center" )
	dxDrawText( bloqueos[actual][2], x*0, y*350, sx, sy, tocolor(255,255,255), y*2, "default-bold", "center", "center" )
	
	dxDrawText( "Usa las flechas, la ruedita, avpag y repag\npara editar la posición, rotación...", x*0, y*521, sx, sy, tocolor(00,0,0), y*1, "default-bold", "center", "center" )
	dxDrawText( "Usa las flechas, la ruedita, avpag y repag\npara editar la posición, rotación...", x*0, y*520, sx, sy, tocolor(255,255,255), y*1, "default-bold", "center", "center" )
	
	dxDrawText( "Espacio para colocar\nSuprimir para salir.", x*0, y*601, sx, sy, tocolor(0,0,0), y*1, "default-bold", "center", "center" )
	dxDrawText( "Espacio para colocar\nSuprimir para salir.", x*0, y*600, sx, sy, tocolor(255,255,255), y*1, "default-bold", "center", "center" )
	
	dxDrawImage( ( sx - x*(w-100) )/2, ( sy - y*(h-450) )/2, x*w, y*h, "flecha.png", 0,0,0, isMouseInPosition(( sx - x*(w-100) )/2, ( sy - y*(h-450) )/2, x*w, y*h) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )
	
	dxDrawImage( ( sx - x*(w+100) )/2, ( sy - y*(h-450) )/2, x*w, y*h, "flecha.png", -180, 0, 0, isMouseInPosition(( sx - x*(w+100) )/2, ( sy - y*(h-450) )/2, x*w, y*h) and tocolor( 255, 255, 255, 100 ) or tocolor( 255, 255, 255 ) )

	local px, py, pz = getElementPosition( getLocalPlayer() )

	if getKeyState( "num_add" ) == true or ( isMouseInPosition(( sx - x*(w-100) )/2, ( sy - y*(h-450) )/2, x*w, y*h) and getKeyState( "mouse1" ) == true ) then
		if not ntick or ( tick - ntick ) > 100 then
			ntick = getTickCount()
			actual = math.min( actual + 1, #bloqueos )
			destroyElement(obj)
			obj = createObject( bloqueos[actual][1], px, py, pz-0.5 )
			setElementCollisionsEnabled( obj, false )
			setElementAlpha( obj, 200 )
		end
	elseif getKeyState( "num_sub" ) == true or ( isMouseInPosition(( sx - x*(w+100) )/2, ( sy - y*(h-450) )/2, x*w, y*h) and getKeyState( "mouse1" ) == true ) then
		if not ntick or ( tick - ntick ) > 100 then
			ntick = getTickCount()
			destroyElement(obj)
			actual = math.max( actual - 1, 1 )
			obj = createObject( bloqueos[actual][1], px, py, pz-0.5 )
			setElementCollisionsEnabled( obj, false )
			setElementAlpha( obj, 200 )
		end	
	elseif getKeyState( "arrow_u" ) == true then
		local vx, vy, vz = getElementPosition( obj )
		setElementPosition( obj, vx, vy+0.05, vz )
	elseif getKeyState( "arrow_d" ) == true then
		local vx, vy, vz = getElementPosition( obj )
		setElementPosition( obj, vx, vy-0.05, vz )	
	elseif getKeyState( "arrow_l" ) == true then
		local vx, vy, vz = getElementPosition( obj )
		setElementPosition( obj, vx-0.05, vy, vz )		
	elseif getKeyState( "arrow_r" ) == true then
		local vx, vy, vz = getElementPosition( obj )
		setElementPosition( obj, vx+0.05, vy, vz )
	elseif getKeyState( "pgup" ) == true then
		local vx, vy, vz = getElementPosition( obj )
		setElementPosition( obj, vx, vy, vz+0.01 )	
	elseif getKeyState( "pgdn" ) == true then
		local vx, vy, vz = getElementPosition( obj )
		setElementPosition( obj, vx, vy, vz-0.01 )
	elseif getKeyState( "space" ) == true then
		if not ntick or ( tick - ntick ) > 100 then
			if not isChatBoxInputActive() then
				ntick = getTickCount()
				local vx, vy, vz = getElementPosition( obj )
				local int, dim = getElementInterior( obj ), getElementDimension( obj )
				local _, _, rz = getElementRotation( obj ) 
				triggerServerEvent( "bloqueos:colocar", getLocalPlayer(), { getElementModel(obj), vx, vy, vz, rz, int, dim } )
			end
		end	
	elseif getKeyState( "delete" ) == true then
		removeEventHandler( "onClientRender", getRootElement(), hudBloqueos )
		abierto = false
		if isElement( obj ) then destroyElement( obj ) end
		obj = nil
		actual = 1
	end
end

addEvent( "panelbloqueos:abrir", true )
addEventHandler( "panelbloqueos:abrir", getRootElement(),
	function()
		if not abierto then
			local int, dim = getElementInterior( getLocalPlayer() ), getElementDimension( getLocalPlayer() )
			addEventHandler( "onClientRender", getRootElement(), hudBloqueos )
			local px, py, pz = getElementPosition( getLocalPlayer() )
			obj = createObject( bloqueos[actual][1], px, py, pz-0.5 )
			setElementCollisionsEnabled( obj, false )
			setElementInterior( obj, int )
			setElementDimension( obj, dim )
			setElementAlpha( obj, 200 )		
		end
	end
)

addEvent( "setValleIndestructible", true )
addEventHandler( "setValleIndestructible", getRootElement(),
	function( valla )
		setObjectBreakable( valla, false )
	end
)

bindKey( "mouse_wheel_down", "down", function()
	if obj then
		local rotx, roty, rotz = getElementRotation( obj )
		setElementRotation( obj, rotx, roty, rotz-1.5 )
	end
end
)

bindKey( "mouse_wheel_up", "down", function()
	if obj then
		local rotx, roty, rotz = getElementRotation( obj )
		setElementRotation( obj, rotx, roty, rotz+1.5 )
	end
end
)
local ruta = 0
local enExamen = false
local blip, col = nil, nil


addEventHandler( "onClientColShapeHit", getRootElement(),
	function()
		if col and source == col then
			if ruta == #rutaCoche then
				ruta = 0
				enExamen = false
				if isElement( blip ) then destroyElement( blip ) blip = nil end
				if isElement( col ) then destroyElement( col ) col = nil end
				triggerServerEvent( "practicoTerminar", getLocalPlayer() )
			else
				if isElement( blip ) then destroyElement( blip ) blip = nil end
				if isElement( col ) then destroyElement( col ) col = nil end
				ruta = ruta + 1
				local x, y, z = unpack(rutaCoche[ruta])
				blip = createBlip( x, y, z, 0, 2, 255, 150, 0, 255, 0, 99999 )
				col = createColSphere( x, y, z, 2 )			
			end
		end
	end
)

addEvent( "startPractico", true )
addEventHandler( "startPractico", getRootElement(),
	function()
		if not enExamen then
			ruta = 0
			enExamen = true
			ruta = ruta + 1
			local x, y, z = unpack(rutaCoche[ruta])
			blip = createBlip( x, y, z, 0, 2, 255, 150, 0, 255, 0, 99999 )
			col = createColSphere( x, y, z, 2 )
		end
	end
)
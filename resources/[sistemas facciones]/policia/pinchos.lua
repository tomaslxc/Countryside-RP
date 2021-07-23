local pinchos = {}

local bloqueos = {}

local pinchosids = {

	{2892, "Pincho largo"},
	{2899, "Pincho corto"},

}

--[[

        if (player) then 
        local x, y, z = getElementPosition(player) 
        local spike = createObject(2892,x+2,y+2,z-0.6) 
        local x2, y2, z2 = getElementPosition(spike) 
        local blow = createColSphere(x2, y2, z2, 3) 
        addEventHandler("onColShapeHit",blow,function (player) 
        if player and getElementType(player) == "player" then 
        if isPedInVehicle(player) then 
                local pveh = getPedOccupiedVehicle(player)       
                setVehicleWheelStates(pveh,1,1,1,1) 
                end 
            end 
        end) 

]]

function getPositionInfrontOfElement(element, meters)
    if (not element or not isElement(element)) then return false end
    local meters = (type(meters) == "number" and meters) or 3
    local posX, posY, posZ = getElementPosition(element)
    local _, _, rotation = getElementRotation(element)
    posX = posX - math.sin(math.rad(rotation)) * meters
    posY = posY + math.cos(math.rad(rotation)) * meters
    rot = rotation + math.cos(math.rad(rotation))
    return posX, posY, posZ , rot
end

function colocarBloqueo( datos )
	local id, x, y, z, rot, int, dim = unpack( datos )
	bloqueos[#bloqueos + 1] = createObject( id, x, y, z, 0, 0, rot )
	outputChatBox( "Has creado un bloqueo con ID: "..#bloqueos, source, 0, 255, 0 )
	setElementInterior( bloqueos[#bloqueos], int )
	setElementDimension( bloqueos[#bloqueos], dim )
	triggerClientEvent( root, "setValleIndestructible", root, bloqueos[#bloqueos] )
end
addEvent( "bloqueos:colocar", true )
addEventHandler( "bloqueos:colocar", getRootElement(), colocarBloqueo)

addCommandHandler( "bloqueos",
	function( player )
		local faccs = exports.facciones:getPlayerFaction( player )
		if faccs[2] == 2 or faccs[2] == 2 then	
			triggerClientEvent( player, "panelbloqueos:abrir", player )
		end
	end
)

function nearbyBloqueos( player )
	local faccs = exports.facciones:getPlayerFaction( player )
	if faccs[2] == 2 or faccs[2] == 2 or getElementData( player, "staff" ) >=3 then
		outputChatBox("---- Bloqueos cercanos ----",player, 255, 255, 0)
		for i,v in ipairs(bloqueos) do
			local x,y,z = getElementPosition(player)
			local x2,y2,z2 = getElementPosition(v)
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 10 then
				outputChatBox( "Bloqueo "..tonumber(i)..". Distancia: "..math.floor(getDistanceBetweenPoints3D(x,y,z,x2,y2,z2))..".", player,0,200,0)
			end
		end
	end
end
addCommandHandler("nearbybloqueos", nearbyBloqueos)

addCommandHandler( "quitarbloqueo",
	function( player, cmd, id )
		local faccs = exports.facciones:getPlayerFaction( player )
		if faccs[2] == 2 or faccs[2] == 2 or getElementData( player, "staff" ) >=3 then
			if tonumber(id) then
				if bloqueos[ tonumber(id) ] then
					if isElement( bloqueos[ tonumber(id) ] ) then destroyElement( bloqueos[ tonumber(id) ] ) bloqueos[ tonumber(id) ] = nil end
					outputChatBox( "Has quitado correctamente el bloqueo con ID "..tonumber(id), player, 0, 255, 0 )
				else
					outputChatBox( "No hay bloqueo con esa ID", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id del bloqueo]", player, 255, 255, 255 )
			end
		end
	end
) 

addCommandHandler( "quitarbloqueos",
	function( player, cmd, id )
		local faccs = exports.facciones:getPlayerFaction( player )
		if faccs[2] == 2 or faccs[2] == 2 or getElementData( player, "staff" ) >=3 then
			outputChatBox( "Has quitado todos los bloqueos creados.", player, 0, 255, 0 )
			for i=1, #bloqueos do 
				local v = bloqueos[i]
				if isElement( v ) then destroyElement( v ) v = nil end
			end
			bloqueos = {}
		end
	end
) 

addCommandHandler( "quitarpinchos",
	function( player, cmd, id )
		local faccs = exports.facciones:getPlayerFaction( player )
		if faccs[1] == 2 or faccs[2] == 2 then
			outputChatBox( "Has quitado todos los pinchos creados.", player, 0, 255, 0 )
			for i=1, #pinchos do 
				local v = pinchos[i]
				
				removeEventHandler("onColShapeHit",v.col,function (puto) 
					if puto and getElementType(puto) == "player" then 
					if isPedInVehicle(puto) then 
							local pveh = getPedOccupiedVehicle(puto)       
							setVehicleWheelStates(pveh,1,1,1,1) 
							end 
						end 
					end)
				if isElement( v.obj ) then destroyElement( v.obj ) v.obj = nil end
				if isElement( v.col ) then destroyElement( v.col ) v.col = nil end
				v = nil
			end
		end
	end
) 

addCommandHandler( "quitarpincho",
	function( player, cmd, id )
		local faccs = exports.facciones:getPlayerFaction( player )
		if faccs[1] == 2 or faccs[2] == 2 then
			local id = tonumber(id)
			if id then
				if pinchos[id] then
					outputChatBox( "Has quitado el pincho con ID "..id, player, 0, 255, 0 )
					removeEventHandler("onColShapeHit",pinchos[id].col,function (puto) 
						if puto and getElementType(puto) == "player" then 
						if isPedInVehicle(puto) then 
								local pveh = getPedOccupiedVehicle(puto)       
								setVehicleWheelStates(pveh,1,1,1,1) 
								end 
							end 
						end)
					if isElement( pinchos[id].obj ) then destroyElement( pinchos[id].obj ) pinchos[id].obj = nil end
					if isElement( pinchos[id].col ) then destroyElement( pinchos[id].col ) pinchos[id].col = nil end
					pinchos[id] = nil
				else
					outputChatBox( "No hay pincho con esa ID", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id]", player, 255, 255, 255 )
			end
		end
	end
) 

addCommandHandler( "pincho",
	function( player, cmd, id )
		local faccs = exports.facciones:getPlayerFaction( player )
		if faccs[1] == 2 or faccs[2] == 2 then
			local id = tonumber( id )
			if id then
				if pinchosids[id] then
					local x, y, z, rot = getPositionInfrontOfElement( player, 1 )

					local spike = createObject(pinchosids[id][1],x,y,z-0.9, 0, 0, rot) 
					local x2, y2, z2 = getElementPosition(spike) 
					local blow = createColSphere(x2, y2, z2, 3) 					

					pinchos[#pinchos+1] = { obj = spike, col = blow }
					
					addEventHandler("onColShapeHit",pinchos[#pinchos].col,function (puto) 
						if puto and getElementType(puto) == "player" then 
						if isPedInVehicle(puto) then 
								local pveh = getPedOccupiedVehicle(puto)       
								setVehicleWheelStates(pveh,1,1,1,1) 
								end 
							end 
						end)
					outputChatBox( "Creado el "..pinchosids[id][2].." con ID "..#pinchos, player, 0, 255, 0 )
				else
					outputChatBox( "La id del pincho no es correcta.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id pincho]", player, 255, 255, 255 )
				for i=1, #pinchosids do 
					outputChatBox( i.." - "..pinchosids[i][2], player, 255, 255, 255 )
				end
			end
		end
	end
)
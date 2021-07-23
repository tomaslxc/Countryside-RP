local connection = exports.mysql:connect()


local jobvehs = { [531] = true, [401] = true }

function isVehicleEmpty( vehicle )
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end
	
	local passengers = getVehicleMaxPassengers( vehicle )
	if type( passengers ) == 'number' then
		for seat = 0, passengers do
			if getVehicleOccupant( vehicle, seat ) then
				return false
			end
		end
	end
	return true
end
local vehiclesWithFuel = { Automobile = true, Bike = true, ["Monster Truck"] = true, Quad = true }
function doesVehicleHaveFuel( vehicle )
	return isElement( vehicle ) and getElementType( vehicle ) == "vehicle" and vehiclesWithFuel[ getVehicleType( vehicle ) ] or false
end

local vehiclesWithEngine = { Automobile = true, Plane = true, Bike = true, Helicopter = true, Boat = true, Train = true, Trailer = false, BMX = false, ["Monster Truck"] = true, Quad = true }
function doesVehicleHaveEngine( vehicle )
	return isElement( vehicle ) and getElementType( vehicle ) == "vehicle" and vehiclesWithEngine[ getVehicleType( vehicle ) ] or false

end


local p = { }

local getPedOccupiedVehicle_ = getPedOccupiedVehicle
      getPedOccupiedVehicle = function( ped )
	local vehicle = isPedInVehicle( ped ) and getPedOccupiedVehicle_( ped )
	if vehicle and ( p[ ped ] and p[ ped ].vehicle == vehicle or getElementParent( vehicle ) ~= getResourceDynamicElementRoot( resource ) ) then
		return vehicle
	end
	return false
end

local function isPedEnteringVehicle( ped )
	return getPedOccupiedVehicle_( ped ) and not getPedOccupiedVehicle( ped )
end

function loadVehicles()
	local query = dbQuery( connection, "SELECT * FROM vehiculos ORDER BY id ASC" )
	local data = dbPoll(query, -1)
	for i, vehiclee in ipairs (data) do
		local query = dbQuery( connection, "SELECT * FROM maleteros WHERE vehid=?", vehiclee.id )
		local maletero = dbPoll(query, -1)
		local query2 = dbQuery( connection, "SELECT * FROM capots WHERE vehid=?", vehiclee.id )
		local capot = dbPoll(query2, -1)
		spawnVehicle(vehiclee, maletero[1], capot[1])
	end



		-- Fuel update
	setTimer(
		function( )
			for id, vehicle in pairs( vehicles ) do
				local data = vehicleData[id]
				if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
				elseif data.motor == 1 and data.gas and not isVehicleEmpty( vehicle ) and doesVehicleHaveEngine( vehicle ) and doesVehicleHaveFuel( vehicle ) and getVehicleEngineState(vehicle) then
					local vx, vy, vz = getElementVelocity( vehicle )
					local speed = math.sqrt( vx * vx + vy * vy )
					local loss = ( speed > 0.65 and 2 * speed or speed ) * 0.1 + 0.005
					
					vehicleData[id].gas = math.max( data.gas - loss, 0 )
					if math.floor( data.gas + 0.5 ) ~= getElementData( vehicle, "fuel" ) then
						setElementData( vehicle, "fuel", math.floor( data.gas + 0.5 ) )
					end
					
					if data.gas == 0 then
						setVehicleEngineState( vehicle, false )
						setVehicleOverrideLights ( vehicle, 1 )
						for seat = 0, getVehicleMaxPassengers( vehicle ) do
							local player = getVehicleOccupant( vehicle, seat )
							if player then
								exports.login:addNotification(player, "El vehículo se ha quedado sin gasolina.", "warning")
							end
						end
					end
				end
			end
		end,
		2000,
		0
	)
end
addEventHandler ( "onResourceStart", resourceRoot, loadVehicles )

vehicles = {}
vehicleData = {}
maleteros = {}
capots={}

function llenarGasolina( vehid )
	if vehicleData[ tonumber( vehid ) ] then
		vehicleData[tonumber(vehid)].gas = 100
	end
end

function cambiarPropietario( vehid, id )
	vehicleData[tonumber(vehid)].owner = id
end

function getPropietario( vehid )
	local datos = dbQuery( connection, "SELECT * FROM vehiculos WHERE id=?", tonumber(vehid) )
	local dq = dbPoll(datos, -1)
	if dq and #dq > 0 then
		if dq[1].facc == 0 then
			local name = exports.personajes:getCharNameFromID( dq[1].owner )
			if name then
				return tostring(name)
			else
				return "?"
			end
		else
			local name = exports.facciones:getFactionNameFromID( dq[1].owner )
			if name then
				return tostring(name)
			else
				return "?"
			end
		end
	end
	return false
end

function getPropietarioFromMatricula( matricula )
	local vehs = getElementsByType( 'vehicle' )
	for i=1, #vehs do 
		if getElementData( vehs[i], "id" ) then
			if getVehiclePlateText( vehs[i] ) == tostring( matricula ) then
				return { vehs[i], getPropietario( getElementData( vehs[i], "id" ) ) }
			end
		end
	end
	return false
end

function getVehiculosFromName( name )
	local vehs = {}
	local consulta_idchar = dbQuery( connection, "SELECT ID FROM personajes WHERE nombre=?", tostring(name) )
	local dq = dbPoll(consulta_idchar, -1)
	if dq and #dq > 0 then
		local datos = dbQuery( connection, "SELECT * FROM vehiculos WHERE facc=0 AND owner=?", tonumber(dq[1].ID) )
		local dq = dbPoll(datos, -1)
		if dq and #dq > 0 then
			vehs = dq
			return vehs
		else
			return {}
		end
	else
		return {}
	end
end

addCommandHandler( "papeles",
	function( player, cmd, otro )
		if getElementData( player, "isLoged" ) then
			local other, name = exports.login:getNID( player, otro )
			if other then
				local veh = getPedOccupiedVehicle( player )
				if veh then
					local id = getElementData( veh, "id" )
					if id then
						local data = vehicleData[ tonumber(id) ]
						if data and not jobvehs[ getElementModel( veh ) ] then
							local idchar = data.owner
							exports.chatsystem:me( player, "le muestra los papeles del vehículo a "..name )
							outputChatBox( "---- Papeles del vehículo ----", player, 255, 255, 0 )
							outputChatBox( "     - Modelo: "..getVehicleNameFromModel( getElementModel( veh ) ), player, 255, 255, 255 )
							outputChatBox( "     - Matrícula: "..getVehiclePlateText( veh ), player, 255, 255, 255 )
							
							
							outputChatBox( "     - Nombre: "..getPropietario( id ), player, 255, 255, 255 )
							--[[if data.facc == 0 then
								local queryname = dbQuery( connection, "SELECT nombre FROM personajes WHERE id=?", idchar )
								local namepj = dbPoll(queryname, -1)
								if namepj and namepj[1].nombre then
									outputChatBox( "     - Nombre: "..namepj[1].nombre, player, 255, 255, 255 )
								end
							else
								local queryname = dbQuery( connection, "SELECT name FROM facciones WHERE id=?", idchar )
								local namepj = dbPoll(queryname, -1)
								if namepj and namepj[1].name then
									outputChatBox( "     - Nombre: "..namepj[1].name, player, 255, 255, 255 )
								end
							end--]]
						else
							outputChatBox( "Fallo con los datos de este vehículo.", player, 255, 0, 0 )
						end
					else
						outputChatBox( "Este vehículo no tiene una ID asignada. No es válido.", player, 255, 0, 0 )
					end
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id]", player, 255, 255, 255 )
			end
		end
	end
)

function quitarID( id )
	if vehicles[ tonumber(id) ] then
		vehicles[tonumber(id)] = nil
		vehicleData[tonumber(id)] = nil
	end
end

function spawnVehicle(data, maletero, capot)
	vehicles[data.id] = createVehicle ( data.modelo, data.x, data.y, data.z, data.rx, data.ry, data.rz, data.matricula )
	vehicleData[data.id] = data
	setElementData(vehicles[data.id], "id", data.id)
	setElementData(vehicles[data.id], "fuel", data.gas)
	setElementData(vehicles[data.id], "cepo",data.cepo)
	if data.cepo == 1 then
		setElementFrozen( vehicles[ data.id ], true )
	end
	setElementDimension(vehicles[data.id], data.dimension)
	setElementInterior(vehicles[data.id], data.interior)
	setVehicleVariant (vehicles[data.id], data.variant1, data.variant2 )
	setVehicleColor(vehicles[data.id], data.r1, data.g1, data.b1, data.r2, data.g2, data.b2)
	local respos = data.respawnpos
	if data.respawnpos and #fromJSON( respos ) > 4 then
		local x, y, z, rx, ry, rz = unpack( fromJSON( respos ) )
		setVehicleRespawnPosition( vehicles[ data.id ], x, y, z, rx, ry, rz )
	end
	if data.locked == 1 then
		setVehicleLocked ( vehicles[data.id], true )
	end
	if data.motor == 0 then
		setVehicleEngineState ( vehicles[data.id], false )
	else
		setVehicleEngineState ( vehicles[data.id], true )
	end
	if data.freno == 1 then
		setElementFrozen(vehicles[data.id], true)
	end
	if data.luces == 1 then
		setVehicleOverrideLights ( vehicles[data.id], 2 )
	else
		setVehicleOverrideLights ( vehicles[data.id], 1 )
	end
	setElementHealth(vehicles[data.id], data.vida )
	--añadir maletero--
	asignarMaletero(maletero,vehicles[data.id])
	--añadir modificaciones--
	asignarCapot(capot, vehicles[data.id])

	if data.vida <= 300 then
		setVehicleDamageProof( vehicles[data.id], true )
	end
end

function asignarMaletero( data,veh )
	local mdata = {
		id = data.vehid,
		h1 = fromJSON(data.h1),
		h2 = fromJSON(data.h2),
		h3 = fromJSON(data.h3),
		h4 = fromJSON(data.h4),
		h5 = fromJSON(data.h5),
		h6 = fromJSON(data.h6),
		h7 = fromJSON(data.h7),
		h8 = fromJSON(data.h8),
		h9 = fromJSON(data.h9),
		h10 = fromJSON(data.h10),
		h11 = fromJSON(data.h11),
		h12 = fromJSON(data.h12),
		h13 = fromJSON(data.h13),
		h14 = fromJSON(data.h14),
		h15 = fromJSON(data.h15),
		rec1 = fromJSON(data.rec1),
		rec2 = fromJSON(data.rec2)
	}
	maleteros[veh] = mdata
end

function asignarCapot( data,veh )
	local cdata = {
		id = data.vehid,
		transmision = data.transmision,
		suspension = data.suspension,
		ruedas = data.ruedas,
		turbo = data.turbo,
		desgaste_transmision = data.desgaste_transmision,
		desgaste_suspension = data.desgaste_suspension,
		desgaste_ruedas = data.desgaste_ruedas,
		desgaste_turbo = data.desgaste_turbo
	}

	setVehicleDoorState ( veh, 0, data.capot )
	setVehicleDoorState ( veh, 1, data.maletero )
	setVehicleDoorState ( veh, 2, data.delantera_izq )
	setVehicleDoorState ( veh, 3, data.delantera_der )
	setVehicleDoorState ( veh, 4, data.trasera_izq )
	setVehicleDoorState ( veh, 5, data.trasera_der )

	setVehicleLightState ( veh, 0, data.faro_d_izq )
	setVehicleLightState ( veh, 1, data.faro_d_der )
	setVehicleLightState ( veh, 2, data.faro_t_der )
	setVehicleLightState ( veh, 3, data.faro_t_izq )

	setVehicleWheelStates ( veh, data.rueda_d_izq, data.rueda_t_izq, data.rueda_d_der, data.rueda_t_der )

	setVehiclePanelState ( veh, 5, data.p_d )
	setVehiclePanelState ( veh, 6, data.p_t )

	capots[veh] = cdata
end


--creación de un nuevo vehiculo--

function crearVehiculo(modelo, r1,g1,b1,r2,g2,b2, x, y, z, owner, faction, interior, dimension,jugador,darllave)
	local matricula = getNewPlate()
	local query = "INSERT INTO vehiculos (owner,facc,modelo,matricula,x,y,z,rx,ry,rz,r1,g1,b1,r2,g2,b2,interior,dimension,respawnpos,cepo) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
	local ins = dbQuery( connection,query,owner,faction,modelo,matricula,x,y,z,0,0,0,r1,g1,b1,r2,g2,b2,interior,dimension,toJSON({}),0)
	local result, num_affected_rows, ID = dbPoll ( ins, -1 )
	local query_maletero = "INSERT INTO maleteros (vehid,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13,h14,h15,rec1,rec2) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
	local ins_maletero = dbQuery( connection,query_maletero,ID,"[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]","[ [ 0, 0 ] ]")
	dbFree(ins_maletero)
	local query_capot = "INSERT INTO capots (vehid) VALUES (?)"
	local ins_capot = dbQuery( connection,query_capot,ID)
	dbFree(ins_capot)
	local query_data_Veh = dbQuery( connection, "SELECT * FROM vehiculos WHERE id=?", ID )
	local data = dbPoll(query_data_Veh, -1)
	local query_data_maletero = dbQuery( connection, "SELECT * FROM maleteros WHERE vehid=?", ID )
	local maletero = dbPoll(query_data_maletero, -1)
	local query_data_capot = dbQuery( connection, "SELECT * FROM capots WHERE vehid=?", ID )
	local capot = dbPoll(query_data_capot, -1)
	spawnVehicle(data[1], maletero[1], capot[1])

	if darllave then
		exports.items:darItem(jugador, 12, ID)
	end
end

---------------------------------
function getNearestVehicle(player,distance)
	local tempTable = {}
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)

	for _,v in pairs(getElementsByType("vehicle")) do
		local vint,vdim = getElementInterior(v),getElementDimension(v)
		if vint == pint and vdim == pdim then
			local vx,vy,vz = getElementPosition(v)
			local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end
-----------------------------------------

function getNearVehicles( player )
	local neartable = {}
	for i, vehs in ipairs (getElementsByType("vehicle")) do
		local x1,y1,z1 = getElementPosition(player)
		local x2,y2,z2 = getElementPosition(vehs)
		local modelo = getElementModel(vehs)
		if getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) < 10 then
			table.insert(neartable, vehs)
		end
	end
	return neartable
end

function asignarBinds( player )
	if isElement(player) then
		bindKey ( player, "1", "down", toggleMotor )
		bindKey ( player, "2", "down", toggleLuces )
		bindKey ( player, "3", "down", toggleLocked )
		bindKey ( player, "0", "down", toggleFreno )
		bindKey ( player, "3", "down", desbloquearFactionVehicle )

	else
		for i, player in ipairs(getElementsByType("player")) do
			bindKey ( player, "1", "down", toggleMotor )
			bindKey ( player, "2", "down", toggleLuces )
			bindKey ( player, "3", "down", toggleLocked )
			bindKey ( player, "0", "down", toggleFreno )
			bindKey ( player, "3", "down", desbloquearFactionVehicle )

			
		end
	end
end
addEventHandler ( "onResourceStart", resourceRoot, asignarBinds )

function onEnter ( player, seat, jacked )
		local vdata = vehicleData[getElementData(source, "id")]
			if vdata then
			if vdata.motor == 0 then
				setVehicleEngineState (source, false )
			end


			if isVehicleLocked(source) then
			removePedFromVehicle(player)
			else
				if not p[player] then
					p[player] = {}
				end
				p[player].vehicle = source
			end


			if isVehicleDamageProof( source ) and math.floor( getElementHealth( source ) + 0.5 ) > 301 then
				setVehicleDamageProof( source, false )
			end
			removeElementData(player, "cinturon")
		end
end
addEventHandler ( "onVehicleEnter", getRootElement(), onEnter )

--[[function intentarEntrar ( player, seat, jacked ) 
	if getElementData( source, "cepo" ) == 1 then
		cancelEvent()
		exports.login:addNotification(player, "El vehículo lleva puesto un cepo.", "warning")
	end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), intentarEntrar )--]]

addEventHandler( "onVehicleStartExit", resourceRoot,
	function( player )
		if isVehicleLocked( source ) then
			cancelEvent( )
			exports.login:addNotification(player, "El vehículo está cerrado.", "error")
		elseif getElementData(player, "cinturon") then
			cancelEvent( )
			exports.login:addNotification(player, "No puedes salir del vehículo con el cinturón puesto.", "error")
		else
			p[ player ].oldVehicle = p[ player ].vehicle
			p[ player ].vehicle = nil
		end
	end
)

addEventHandler( "onVehicleExit", root,
	function( player )
		saveVehicle( source )
		saveMaletero(source)
		saveCapot(source)
	end
)
addEventHandler( "onVehicleDamage", root,
	function( loss )
		if getVehicleOccupant( source ) then
			local o = getVehicleOccupant( source );
			local players = getVehicleOccupants(source)
			for i,player in ipairs(players) do
				if loss >= 50 then
					if getElementData(player, "cinturon") then
						setElementHealth(player, getElementHealth(player)-5)
					else
						setElementHealth(player, getElementHealth(player)-30)
					end
				end
			end
				if loss >= 50 then
					if getElementData(o, "cinturon") then
						setElementHealth(o, getElementHealth(o)-5)
					else
						setElementHealth(o, getElementHealth(o)-30)
					end
				end
		end
		if getElementHealth( source ) <= 301 then
			setElementHealth( source, 300 )
			setVehicleDamageProof( source, true )
			setVehicleEngineState( source, false )
			
			if getVehicleOccupant( source ) then
				outputChatBox( "(( El motor se ha reventado ))", getVehicleOccupant( source ), 255, 204, 0 )
			end
		end
	end
)

function ponerseCinturon( player )
	if getElementData(player, "isLoged") then
		if isPedInVehicle(player) then
			if getElementData(player, "cinturon") then
				removeElementData(player, "cinturon")
				exports.chatsystem:sendame(player, "Se desabrocha el cinturón de seguridad")
			else
				setElementData(player, "cinturon", true)
				exports.chatsystem:sendame(player, "Se abrocha el cinturón de seguridad")
			end
		end
	end
end
addCommandHandler("cinturon",ponerseCinturon)


function toggleMotor( player, key, state )
local veh = getPedOccupiedVehicle(player)
	if veh and getVehicleOccupant(veh) == player and doesVehicleHaveEngine(veh) then
		if exports.items:itemHas(player, 12, getElementData(veh, "id")) or jobvehs[ getElementModel(veh) ]  then
			local vdata = vehicleData[getElementData(veh, "id")]
			if math.floor( getElementHealth( veh ) + 0.5 ) > 301 then
				if doesVehicleHaveFuel(veh) and vdata.gas > 0 then
					if vdata.motor == 1 then
						vehicleData[getElementData(veh, "id")].motor = 0
						setVehicleEngineState (veh, false )
						exports.chatsystem:sendame(player, "Apaga el motor del vehículo")
					else
						vehicleData[getElementData(veh, "id")].motor = 1
						setVehicleEngineState (veh, true )
						exports.chatsystem:sendame(player, "Enciende el motor del vehículo")
					end
				elseif doesVehicleHaveEngine(veh) then
					if vdata.motor == 1 then
						vehicleData[getElementData(veh, "id")].motor = 0
						setVehicleEngineState (veh, false )
						exports.chatsystem:sendame(player, "Apaga el motor del vehículo")
					else
						vehicleData[getElementData(veh, "id")].motor = 1
						setVehicleEngineState (veh, true )
						exports.chatsystem:sendame(player, "Enciende el motor del vehículo")
					end
				end
			else
				exports.login:addNotification(player, "El motor está roto, no puedes arrancarlo.", "warning")
			end
		else
			local vdata = vehicleData[getElementData(veh, "id")]
			if vdata.facc == 1 then
				local factions = exports.facciones:getPlayerFaction(player)
				if factions then
					if vdata.owner == factions[1] or vdata.owner == factions[2] then
						if math.floor( getElementHealth( veh ) + 0.5 ) > 301 then
							if doesVehicleHaveFuel(veh) and vdata.gas > 0 then
								if vdata.motor == 1 then
									vehicleData[getElementData(veh, "id")].motor = 0
									setVehicleEngineState (veh, false )
									exports.chatsystem:sendame(player, "Apaga el motor del vehículo")
								else
									vehicleData[getElementData(veh, "id")].motor = 1
									setVehicleEngineState (veh, true )
									exports.chatsystem:sendame(player, "Enciende el motor del vehículo")
								end
							elseif doesVehicleHaveEngine(veh) then
								if vdata.motor == 1 then
									vehicleData[getElementData(veh, "id")].motor = 0
									setVehicleEngineState (veh, false )
									exports.chatsystem:sendame(player, "Apaga el motor del vehículo")
								else
									vehicleData[getElementData(veh, "id")].motor = 1
									setVehicleEngineState (veh, true )
									exports.chatsystem:sendame(player, "Enciende el motor del vehículo")
								end
							end
						else
							exports.login:addNotification(player, "El motor está roto, no puedes arrancarlo.", "warning")
						end
					end
				end
			end
		end
	end
end
addCommandHandler("motorvehiculo", toggleMotor)

function toggleLuces( player, key, state )
local veh = getPedOccupiedVehicle(player)
	if veh and getVehicleOccupant(veh) == player then
		local vdata = vehicleData[getElementData(veh, "id")]
		if vdata.luces == 1 then
			vehicleData[getElementData(veh, "id")].luces = 0
			setVehicleOverrideLights ( veh, 1 )
			exports.chatsystem:sendame(player, "Apaga las luces del vehículo")
		else
			vehicleData[getElementData(veh, "id")].luces = 1
			setVehicleOverrideLights ( veh, 2 )
			exports.chatsystem:sendame(player, "Enciende las luces del vehículo")
		end
	end
end
addCommandHandler("lucesvehiculo", toggleLuces)

function toggleLocked( player, key, state )
local veh = getPedOccupiedVehicle(player)
	if veh and getVehicleOccupant(veh) == player then
		local vdata = vehicleData[getElementData(veh, "id")]
		if vdata.locked == 1 then
			vehicleData[getElementData(veh, "id")].locked = 0
			setVehicleLocked(veh, false)
			exports.chatsystem:sendame(player, "Abre las puertas del vehículo")
		else
			vehicleData[getElementData(veh, "id")].locked = 1
			setVehicleLocked(veh, true)
			exports.chatsystem:sendame(player, "Cierra las puertas del vehículo")
		end
	end
end
addCommandHandler("puertavehiculo", toggleLocked)

function usarLlaves( player, vehid )
	local vehiculos = getNearVehicles(player)
	for i, veh in pairs(vehiculos) do
		if getElementData(veh, "id") == vehid or getElementData( player, "staff" ) >=3 then
			local vdata = vehicleData[getElementData(veh, "id")]
			if vdata.locked == 1 then
				vehicleData[getElementData(veh, "id")].locked = 0
				setVehicleLocked(veh, false)
				exports.chatsystem:sendame(player, "Toma su llave y presiona un botón para abrir su "..getVehicleNameFromModel(getElementModel(veh)))
			else
				vehicleData[getElementData(veh, "id")].locked = 1
				setVehicleLocked(veh, true)
				exports.chatsystem:sendame(player, "Toma su llave y presiona un botón para cerrar su "..getVehicleNameFromModel(getElementModel(veh)))
			end
			return true
		end
	end
	return false
end

function desbloquearFactionVehicle(player)
	local veh = getNearestVehicle(player,5)
	if isElement(veh) then
	local factions = exports.facciones:getPlayerFaction(player)
	local vehid = getElementData(veh, "id")
	local vdata = vehicleData[vehid]
	if factions and veh then
		if vdata.facc == 1 and (vdata.owner == factions[1] or vdata.owner == factions[2]) then
			if vdata.locked == 1 then
				vehicleData[vehid].locked = 0
				setVehicleLocked(veh, false)
				exports.chatsystem:sendame(player, "Toma su llave y presiona un botón para abrir su "..getVehicleNameFromModel(getElementModel(veh)))
			else
				vehicleData[vehid].locked = 1
				setVehicleLocked(veh, true)
				exports.chatsystem:sendame(player, "Toma su llave y presiona un botón para cerrar su "..getVehicleNameFromModel(getElementModel(veh)))
			end
			return true
		end
	end
	end
end
addCommandHandler("vehiculofaccion", desbloquearFactionVehicle)

function toggleFreno( player, key, state )
local veh = getPedOccupiedVehicle(player)
local speedx, speedy, speedz = getElementVelocity ( getRandomPlayer() )
	if veh and getVehicleOccupant(veh) == player and speedx == 0 and speedy == 0 and speedz == 0 and getElementData( veh, "cepo" ) == 0 then
		local vdata = vehicleData[getElementData(veh, "id")]
		if vdata.freno == 1 then
			vehicleData[getElementData(veh, "id")].freno = 0
			setElementFrozen(veh, false)
			exports.chatsystem:sendame(player, "Quita el freno de mano")
		else
			vehicleData[getElementData(veh, "id")].freno = 1
			setElementFrozen(veh, true)
			exports.chatsystem:sendame(player, "Pone el freno de mano")
		end
	end
end
addCommandHandler("frenodemano", toggleFreno)

--auxiliares--
function existeMatricula( matricula )
	local query = dbQuery( connection, "SELECT * FROM vehiculos WHERE matricula=?", matricula )
	local data = dbPoll(query, -1)
	if #data > 0 then
		return true
	else
		return false
	end
end

function getNewPlate()
	local veh = createVehicle(602, 0,0,0)
	if not existeMatricula(getVehiclePlateText(veh)) then
		local plate = getVehiclePlateText( veh )
		destroyElement(veh)
		return plate
	else
		destroyElement(veh)
		return getNewPlate()
	end
end

--guardados--

function saveMaletero( vehicle )
	if getElementData( vehicle, "id" ) then
		local query2 = "UPDATE `maleteros` SET `h1`=?,`h2`=?,`h3`=?,`h4`=?,`h5`=?,`h6`=?,`h7`=?,`h8`=?,`h9`=?,`h10`=?,`h11`=?,`h12`=?,`h13`=?,`h14`=?,`h15`=?,`rec1`=?,`rec2`=? WHERE `vehid`=?"
		local maleta = maleteros[vehicle]
		dbExec(connection,query2,toJSON(maleta.h1),toJSON(maleta.h2),toJSON(maleta.h3),toJSON(maleta.h4),toJSON(maleta.h5),toJSON(maleta.h6),toJSON(maleta.h7),toJSON(maleta.h8),toJSON(maleta.h9),toJSON(maleta.h10),toJSON(maleta.h11),toJSON(maleta.h12),toJSON(maleta.h13),toJSON(maleta.h14),toJSON(maleta.h15),toJSON(maleta.rec1),toJSON(maleta.rec2),maleta.id)
	end
end

function saveCapot( vehicle )
	if getElementData( vehicle, "id" ) then
		local query3 = "UPDATE `capots` SET `transmision`=?,`suspension`=?,`ruedas`=?,`turbo`=?,`maletero`=?,`capot`=?,`delantera_izq`=?,`delantera_der`=?,`trasera_izq`=?,`trasera_der`=?,`faro_d_izq`=?,`faro_d_der`=?,`faro_t_izq`=?,`faro_t_der`=?,`desgaste_turbo`=?,`desgaste_ruedas`=?,`desgaste_suspension`=?,`desgaste_transmision`=?,`rueda_d_izq`=?,`rueda_d_der`=?,`rueda_t_izq`=?,`rueda_t_der`=?,`p_d`=?,`p_t`=? WHERE `vehid`=?"
		local c = capots[vehicle]
		local r1,r2,r3,r4 = getVehicleWheelStates ( vehicle )
		dbExec(connection,query3,tonumber(c.transmision),tonumber(c.suspension),tonumber(c.ruedas),tonumber(c.turbo),getVehicleDoorState(vehicle, 1),getVehicleDoorState(vehicle, 0),getVehicleDoorState(vehicle, 2),getVehicleDoorState(vehicle, 3),getVehicleDoorState(vehicle, 4),getVehicleDoorState(vehicle, 5),getVehicleLightState(vehicle,0),getVehicleLightState(vehicle,1),getVehicleLightState(vehicle,3),getVehicleLightState(vehicle,2),tonumber(c.desgaste_turbo),tonumber(c.desgaste_ruedas),tonumber(c.desgaste_suspension),tonumber(c.desgaste_transmision),r1,r3,r2,r4,getVehiclePanelState(vehicle,5),getVehiclePanelState(vehicle,6),tonumber(c.id))
	end
end

function saveVehicle( vehicle )
	local data = vehicleData[getElementData(vehicle,"id")]

	local x,y,z = getElementPosition(vehicle)
	local rx,ry,rz = getElementRotation(vehicle)
	local v1,v2 = getVehicleVariant(vehicle)
	local r1,g1,b1,r2,g2,b2,r3,g3,b3,r4,g4,b4 = getVehicleColor(vehicle,true)
	local query = "UPDATE `vehiculos` SET `owner`=?,`facc`=?,`modelo`=?,`vida`=?,`x`=?,`y`=?,`z`=?,`rx`=?,`ry`=?,`rz`=?,`r1`=?,`g1`=?,`b1`=?,`r2`=?,`g2`=?,`b2`=?,`variant1`=?,`variant2`=?,`interior`=?,`dimension`=?,`locked`=?,`freno`=?,`luces`=?,`motor`=?,`gas`=?, `cepo`=? WHERE `id`="..getElementData(vehicle,"id")..""
	dbExec( connection, query, tonumber(data.owner),tonumber(data.facc),getElementModel(vehicle),getElementHealth(vehicle),x,y,z,rx,ry,rz,r1,g1,b1,r2,g2,b2,v1,v2,getElementInterior(vehicle),getElementDimension(vehicle),data.locked,data.freno,data.luces,data.motor,tonumber(getElementData(vehicle, "fuel")), ( getElementData( vehicle, "cepo" ) or 0 ) )
end

addEventHandler( "onPlayerQuit", root,
	function( )
		local vehicle = getPedOccupiedVehicle( source )
		if vehicle then
			saveVehicle( vehicle )
			saveMaletero(vehicle)
			saveCapot(vehicle)
		end
		
		p[ source ] = nil
	end
)

addEventHandler( "onResourceStop", resourceRoot,
	function( )
		local occupiedVehicles = { }
		for _, value in ipairs( getElementsByType( "player" ) ) do
			local vehicle = getPedOccupiedVehicle( value )
			if vehicle then
				occupiedVehicles[ vehicle ] = true
			end
		end
		
		for vehicle in pairs( occupiedVehicles ) do
			if getElementData( vehicle, "id" ) then
				saveVehicle( vehicle )
			end
		end
		for i, veh in ipairs(getElementsByType("vehicle")) do
			if getElementData( veh, "id" ) then
				saveMaletero(veh)
				saveCapot(veh)
			end
		end
		vehicles = {}
		vehicleData = {}
		maleteros = {}
		capots={}
	end
)

addEventHandler( "onVehicleRespawn", resourceRoot,
	function( )
		local data = vehicleData[getElementData(source,"id")]
		setElementPosition(source, data.x, data.y, data.z)
		setElementRotation(source, data.rx,data.ry,data.rz)
		setElementInterior( source, data.interior )
		setElementDimension( source, data.dimension )
		saveVehicle( source )
		saveMaletero(source)
		saveCapot(source)
		setVehicleDamageProof( source, false )
	end
)

setTimer(
	function( )
		for i, vehicle in pairs( vehicles ) do
			saveVehicle( vehicle )
			saveMaletero(vehicle)
			saveCapot(vehicle)
			if jobvehs[ vehicle ] and #getVehicleOccupants( vehicle ) == 0 then
				respawnVehicle( vehicle )
			end
		end
		
	end,
	60000,
	0
)


addCommandHandler( "park",
	function( player, cmd )
		if getElementData( player, "isLoged" ) and getElementData( player, "staff" ) >= 3 then
			local veh = getPedOccupiedVehicle( player )
			if veh then
				local id = getElementData( veh, "id" )
				if id then
					local x, y, z = getElementPosition( veh )
					local rx, ry, rz = getElementRotation( veh )
					local int, dim = getElementInterior( veh ), getElementDimension( veh )
					local a_guardar = toJSON( { x, y, z, rx, ry, rz } )
					if dbExec( connection, "UPDATE vehiculos SET respawnpos=?,interior=?,dimension=? WHERE id=?", a_guardar, tonumber(int), tonumber(dim), tonumber( id )  ) then
						outputChatBox( "Guardada la posición del vehículo en la base de datos.", player, 0, 255, 0 )
						setVehicleRespawnPosition( veh, x, y, z, rx, ry, rz )
					else
						outputChatBox( "Fallo en guardar la posición de park.", player, 255, 0, 0 )
					end
				else
					outputChatBox( "Este vehículo no tiene una ID válida (temporal o creado por mapeo/script) y no se puede parkear.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Debes estar en un vehículo para parkearlo.", player, 255, 0, 0 )
			end
		end
	end
)

addCommandHandler( "qpark",
	function( player, cmd )
		if getElementData( player, "isLoged" ) and getElementData( player, "staff" ) >= 3 then
			local veh = getPedOccupiedVehicle( player )
			if veh then
				local id = getElementData( veh, "id" )
				if id then
					local x, y, z = getElementPosition( veh )
					local rx, ry, rz = getElementRotation( veh )
					local a_guardar = toJSON( { x, y, z, rx, ry, rz } )
					if dbExec( connection, "UPDATE `vehiculos` SET `respawnpos`=? WHERE id=?", toJSON( {} ), tonumber(id) ) then
						outputChatBox( "Eliminada el park del vehículo "..id..".", player, 0, 255, 0 )
					else
						outputChatBox( "Fallo en quitar el park.", player, 255, 0, 0 )
					end
				else
					outputChatBox( "Este vehículo no tiene una ID válida (temporal o creado por mapeo/script) y no se puede parkear.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Debes estar en un vehículo para parkearlo.", player, 255, 0, 0 )
			end
		end
	end
)

--------------------------------------------


function isMaleteroAbierto( vehicle )
	for i, players in ipairs(getElementsByType("player")) do
		if maleteros[players] then
			if maleteros[players] == vehicle then
				return players
			end
		end
	end
	return false
end
function isCapotAbierto( vehicle )
	for i, players in ipairs(getElementsByType("player")) do
		if capots[players] then
			if capots[players] == vehicle then
				return players
			end
		end
	end
	return false
end

function maletero( player )
	if not isPedInVehicle(player) then
		local veh = getNearestVehicle(player, 5)
		if veh then
			if not isVehicleLocked(veh) then
				if not isMaleteroAbierto(veh) then
						abrirMaletero(player,veh)
						exports.chatsystem:sendame(player, "Abre el maletero del vehículo")
				elseif isMaleteroAbierto(veh) == player then
						cerrarMaletero(player,veh)
						exports.chatsystem:sendame(player, "Cierra el maletero del vehículo")
				else
					exports.login:addNotification(player, "Alguien ya está interactuando con este vehículo.", "error")
				end
			else
				exports.login:addNotification(player, "El vehículo está cerrado.", "error")
			end
		else
			exports.login:addNotification(player, "Acércate más al vehículo para abrir el maletero.", "error")
		end
	end
end
addCommandHandler("maletero", maletero)

function capot( player )
	if not isPedInVehicle(player) then
		local veh = getNearestVehicle(player, 5)
		if veh then
			if not isVehicleLocked(veh) then
				if not isCapotAbierto(veh) then
						abrirCapot(player,veh)
						exports.chatsystem:sendame(player, "Abre el capot del vehículo")
				elseif isCapotAbierto(veh) == player then
						cerrarCapot(player,veh)
						exports.chatsystem:sendame(player, "Cierra el capot del vehículo")
				else
					exports.login:addNotification(player, "Alguien ya está interactuando con este vehículo.", "error")
				end
			else
				exports.login:addNotification(player, "El vehículo está cerrado.", "error")
			end
		else
			exports.login:addNotification(player, "Acércate más al vehículo para abrir el capot.", "error")
		end
	end
end
addCommandHandler("capot", capot)

function verVehid( player )
if getElementData(player, "isLoged") then
	local veh = getPedOccupiedVehicle(player)
	if isPedInVehicle(player) and isElement(veh) then
		outputChatBox("(( La ID de este vehículo es "..getElementData(veh, "id").." ))",player,0,200,0)
	end
end
end
addCommandHandler("vehid",verVehid)

function abrirMaletero( player, veh )
	maleteros[player] = veh
	setVehicleDoorOpenRatio ( veh,1,1,2000 )
	triggerClientEvent(player, "maletero:open", player, veh, maleteros[veh])
end

function cerrarMaletero( player, veh )
	maleteros[player] = nil
	setVehicleDoorOpenRatio ( veh,1,0,2000 )
	triggerClientEvent(player, "maletero:close", player)
end
addEvent("maletero:cerrar:forzado", true)
addEventHandler("maletero:cerrar:forzado", root, cerrarMaletero)


function abrirCapot( player, veh )
	capots[player] = veh
	setVehicleDoorOpenRatio ( veh,0,1,2000 )
	triggerClientEvent(player, "capot:open", player, veh, capots[veh])
end

function cerrarCapot( player, veh )
	capots[player] = nil
	setVehicleDoorOpenRatio ( veh,0,0,2000 )
	triggerClientEvent(player, "capot:close", player)
end

function actualizarMaletero( veh, mal )
	maleteros[veh] = mal
end
addEvent("mal:update", true)
addEventHandler("mal:update", root, actualizarMaletero)

function quitarRecipienteMaletero( player, hueco )
	triggerClientEvent(player, "mal:quitar_recipiente", player, hueco)
end




gasolineras = {
	{x=1943.29296875, y=-1773.0908203125, z=13.390598297119},

	{x=655.392578125, y=-565.6005859375, z=16.3359375}
}
function togglepanelgasolinera( player )
if getElementType(player) == "player" then
	local veh = getPedOccupiedVehicle(player)
	if isPedInVehicle(player) and isElement(veh) then
		if doesVehicleHaveFuel(veh) then
			triggerClientEvent(player, "panel:gasofa", player, veh)
		end
	end
end
end
function togglepanelgasolineraOFF( player )
if getElementType(player) == "player" then
	local veh = getPedOccupiedVehicle(player)
	if isPedInVehicle(player) and isElement(veh) then
		if doesVehicleHaveFuel(veh) then
			triggerClientEvent(player, "panel:gasofaoff", player, veh)
		end
	end
end
end
function loadGasolineras()
	for i,gasolinera in ipairs(gasolineras) do
		local marker = createMarker ( gasolinera.x,gasolinera.y,gasolinera.z,"cylinder",10,255,255,255,0)
		addEventHandler( "onMarkerHit", marker, togglepanelgasolinera )
		addEventHandler( "onMarkerLeave", marker, togglepanelgasolineraOFF )
	end
end
addEventHandler ( "onResourceStart", resourceRoot, loadGasolineras )

addCommandHandler( "limitador",
	function(p,cmd,limite)
		if getElementData( p, "isLoged" ) then
			local limite = tonumber(limite)
			local veh = getPedOccupiedVehicle(p)
			if veh then
				if limite then
					if limite > 0 then
						local m_original = getOriginalHandling( getElementModel(veh) )["maxVelocity"]
						if limite <= m_original then
							outputChatBox( "Limite establecido en "..limite.." km/h.", p, 0, 255, 0 )
							setVehicleHandling( veh, "maxVelocity", limite )
						else
							outputChatBox( "Tu vehiculo no llega a esa velocidad. Pon una menor.", p, 255, 150, 0 )
						end
					else
						outputChatBox( "Introduce un valor mayor a 0", p, 255, 150, 0 )
					end
				else
					local m_original = getOriginalHandling( getElementModel(veh) )["maxVelocity"]
					setVehicleHandling( veh, "maxVelocity", m_original )
					outputChatBox( "Le has quitado el limitador al vehículo.", p, 255, 150, 0 )
				end
			else
				outputChatBox( "Debes estar en un vehículo para utilizar su limitador.", p, 255, 0, 0 )
			end
		end
	end
)

function ponerGas( player, amount )
local veh = getPedOccupiedVehicle(player)
if getElementData(veh, "fuel") >= 100 then
	outputChatBox("Este vehículo tiene el tanque lleno.",player,200,0,0)
elseif getVehicleEngineState(veh) == false and getVehicleOverrideLights ( veh ) == 1 then
	local currentCash = exports.personajes:getCharMoney(player)
	if currentCash >= tonumber(amount) then
		exports.personajes:takeCharMoney(player, tonumber(amount))
		outputChatBox("Llenando tanque...",player,255,200,0)
		setTimer ( function()
			if getVehicleEngineState(veh) == false and getVehicleOverrideLights ( veh ) == 1 then
				vehicleData[getElementData(veh, "id")].gas = 100
				setElementData(veh, "fuel", 100)
				outputChatBox("Has llenado el tanque del vehículo por "..amount.." dólares.",player, 0, 200,0)
			else
				outputChatBox("Debes apagar el motor y las luces.",player,200,0,0)
			end
		end, 5000, 1 )
	else
		outputChatBox("No tienes suficiente dinero para llenar el tanque del vehículo.",player,200,0,0)
	end
else
	outputChatBox("Debes apagar el motor y las luces.",player,200,0,0)
end
end
addEvent("aplicar:gasolina",true)
addEventHandler("aplicar:gasolina", root, ponerGas)
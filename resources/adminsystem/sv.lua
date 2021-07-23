local connection = exports.mysql:connect()

--[[
	
	RANGOS ADMINISTRATIVOS
	
		1.- TESTER
		2.- AYUDANTE
		3.- MODERADOR
		4.- GAME OPERATOR
		5.- ADMINISTRADOR
		6.- DESARROLLADOR
	
		staffrang = {"Tester", "Ayudante", "Moderador", "Game Operator", "Administrador", "Desarrollador"}

]]


-- RELACIONADO A VEHÍCULOS

function createVeh(player, cmd, modelo, r,g,b,r1,g1,b1,ownerID, faction )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if tonumber(modelo) and tonumber(r) and tonumber(g) and tonumber(b) and tonumber(r1) and tonumber(g1) and tonumber(b1) and tonumber(ownerID) and tonumber(faction) then
				local x,y,z = getElementPosition(player)
				if tonumber( faction ) == 0 then
					local other, name = exports.login:getNID( player, tonumber( ownerID ) )
					if other then
						local charid = exports.personajes:getCharID( other )
						if charid then
							outputChatBox( "Has creado correctamente el vehículo. Si no es para ti, tienes la llave en el inventario, dásela al dueño.", player, 0, 255, 0 )
							exports.vehiculos:crearVehiculo(tonumber(modelo), r,g,b,r1,g1,b1, x+5,y,z,charid, 0, getElementInterior(player),getElementDimension(player),player,true)
						else
							outputChatBox( "Fallo con el jugador. No se encuentra la ID", player, 255, 0, 0 )
						end
					end
				else
					local name = exports.facciones:getFactionNameFromID( ownerID )
					if name then
						outputChatBox( "Opción no disponible por ahora.", player, 255, 0, 0 )
						exports.vehiculos:crearVehiculo(tonumber(modelo), r,g,b,r1,g1,b1, x+5,y,z,tonumber(ownerID), 1, getElementInterior(player),getElementDimension(player),player,true)
					else
						outputChatBox( "La facción con esa ID no existe.", player, 255, 0, 0 )
					end					
				end
			else
				outputChatBox("Syntax:/"..cmd.." [modelo] [r][g][b] [r2][g2][b2] [ownerID/factionID] [1/0 es faccion?]",player,255,255,255)
			end
		end
	end
end
addCommandHandler("makeveh", createVeh)

addCommandHandler( "delveh",
	function( player, cmd, id )
		if getElementData(player, "isLoged") and getElementData(player, "staff") then
			if getElementData(player, "staff") >= 4 then
				local id = tonumber( id )
				if id then
					local vehs = getElementsByType( 'vehicle' )
					for i=1, #vehs do 
						local v = vehs[i]
						if getElementData( v, "id" ) == id then
							if isElement( v ) then destroyElement( v ) end
							exports.vehiculos:quitarID( tonumber( id ) )
							outputChatBox( "Has borrado el vehículo con éxito.", player, 0, 255, 0 )
							dbExec(connection,"DELETE FROM vehiculos WHERE id=?", tonumber(id))
						end
					end
				else
					outputChatBox( "Syntax: /"..cmd.." [id del coche]", player, 255, 255, 255 )
				end
			end
		end
	end
)

function setVColor(player, cmd, r,g,b,r1,g1,b1 )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			local veh = getPedOccupiedVehicle(player)
			if veh then
			setVehicleColor(veh, r,g,b,r1,g1,b1)
			end
		end
	end
end
addCommandHandler("setcolor", setVColor)

function repostarVeh( player, cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			local other, name = exports.login:getNID( player, id )
			if other then
				local veh = getPedOccupiedVehicle( other )
				if veh then
					setElementData( veh, "fuel", 100 )
					outputChatBox( "** Vehículo de "..name.." repostado. **", player, 0, 255, 140 )
					outputChatBox( "** "..getPlayerName( player ):gsub("_"," ").." te ha llenado el depósito. **", player, 0, 255, 140 )
					exports.vehiculos:llenarGasolina( getElementData( veh, "id" ) or 0 )
					outputDebugString( getPlayerName( player ):gsub("_"," ").." le ha llenado el deposito a "..name )
				else
					outputChatBox( name.." no está en un vehículo.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id]", player, 255, 255, 255 )
			end
		end
	end
end
addCommandHandler( "repostar", repostarVeh )

function getVehicleFromID( id )
	for i,v in ipairs(getElementsByType("vehicle")) do
		if getElementData(v, "id") == tonumber(id) then
			return v
		end
	end
end

function borrarVehiculo( player, cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if tonumber(id) then
				local veh = getVehicleFromID(id)
				if veh then
					outputDebugString( "El staff "..getPlayerName( player ).." ha borrado el "..getVehicleNameFromModel( getElementModel( veh ) ).." con ID "..id )
					if isElement(veh) then destroyElement( veh ) end
					dbExec(connection,"DELETE FROM vehiculos WHERE id=?", tonumber(id))
					outputChatBox("Has borrado el vehículo con ID "..id, player, 0,200,0)
					exports.vehiculos:quitarID( tonumber(id) )
				end
			else
				outputChatBox("Syntax: /"..cmd.." [id]", player, 255,255,255)
			end
		end
	end	
end
addCommandHandler( "borrarveh", borrarVehiculo )

function getVeh(player, cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if tonumber(id) then
				local veh = getVehicleFromID(id)
				if veh then
				local x,y,z = getElementPosition(player)
				local int, dim = getElementInterior( player ), getElementDimension( player )
				setElementPosition(veh, x+5,y,z)
				setElementInterior(veh,int)
				setElementDimension(veh,dim)
				outputChatBox("Has traido el vehículo correctamente hacia tí.", player, 0,200,0)
				end
			else
				outputChatBox("Syntax: /getveh [id]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("getveh", getVeh)

function gotoVeh(player, cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if tonumber(id) then
				local veh = getVehicleFromID(id)
				if veh then
				local x,y,z = getElementPosition(veh)
				local int, dim = getElementInterior(veh), getElementDimension(veh)
				setElementPosition(player, x+5,y,z)
				setElementInterior(player,int)
				setElementDimension(player,dim)
				outputChatBox("Teletransportado al vehículo correctamente.", player, 0,200,0)
				end
			else
				outputChatBox("Syntax: /gotoveh [id]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("gotoveh", gotoVeh)

function fixvvehicle( player )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 3 then
		if isPedInVehicle(player) then
			local veh = getPedOccupiedVehicle(player)
			fixVehicle(veh)
			setVehicleDoorState ( veh, 0, 0 )
			setVehicleDoorState ( veh, 1, 0 )
			setVehicleDoorState ( veh, 2, 0 )
			setVehicleDoorState ( veh, 3, 0 )
			setVehicleDoorState ( veh, 4, 0 )
			setVehicleDoorState ( veh, 5, 0 )
			setVehiclePanelState ( veh, 0, 0 )
			setVehiclePanelState ( veh, 1, 0 )
			setVehiclePanelState ( veh, 2, 0 )
			setVehiclePanelState ( veh, 3, 0 )
			setVehiclePanelState ( veh, 4, 0 )
			setVehiclePanelState ( veh, 5, 0 )
			setVehiclePanelState ( veh, 6, 0 )
			outputChatBox("Has arreglado el vehículo correctamente",player,0,200,0)
			setVehicleDamageProof(veh, false)
		end
	end
end
addCommandHandler("fixveh", fixvvehicle)

local temporales = {}

function isTemporal( veh )
	for i=1, #temporales do
		if temporales[i] == veh then
			return tonumber(i)
		end
	end
end

function nearvehs( player )
	if getElementData(player, "staff") >= 3 then
		outputChatBox("---- Vehículos cercanos ----",player, 255, 255, 0)
		for i,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v, "id") then
				local x,y,z = getElementPosition(player)
				local x2,y2,z2 = getElementPosition(v)
				if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 10 then
					outputChatBox("     . ID de este "..getVehicleNameFromModel(getElementModel(v)).." con matrícula "..getVehiclePlateText(v).." es: "..getElementData(v,"id"),player,0,200,0)
				end
			else
				if isTemporal( v ) then
					outputChatBox( "     - [TEMPORAL] "..getVehicleNameFromModel( getElementModel( v ) ).." con ID "..tonumber(isTemporal(v)).." (/removetempveh "..tonumber(isTemporal(v))..")", player, 0, 150, 0 )
				end
			end
		end
	end
end
addCommandHandler("nearbyvehs", nearvehs)


function respawnVeh( player,cmd,id )
	if getElementData(player, "staff") >= 3 then
		if id then
		for i,v in ipairs(getElementsByType("vehicle")) do
			if getElementData(v, "id") == tonumber(id) then
				local query = dbQuery( connection, "SELECT * FROM vehiculos WHERE id=?", tonumber(id) )
				local data = dbPoll(query, -1)
				if data and #data > 0 then
					respawnVehicle(v)
					setElementDimension( v, data[1].dimension )
					setElementInterior( v, data[1].interior )
					outputChatBox( "Has respawneado correctamente el/la "..getVehicleNameFromModel( getElementModel(v) )..".", player, 0, 255, 0 )
				else
					outputChatBox( "Fallo al respawnear el vehículo.", player, 255, 0, 0 )
				end
			end
		end
		else
			outputChatBox("Syntax: /respawnveh [id]",player,255,255,255)
		end
	end
end
addCommandHandler("respawnveh", respawnVeh)

function tempVeh( player, cmd, ... )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 4 then
		model = table.concat( { ... }, " " )
		model = getVehicleModelFromName( model ) or tonumber( model )
		if model then
			local x, y, z = getElementPosition( player )
			local veh = createVehicle( model, x, y-0.2, z )
			temporales[ #temporales + 1 ] = veh
			outputChatBox( "Vehículo temporal creado con ID "..#temporales, player, 0, 200, 0 )
		else
			outputChatBox( "Syntax: /"..cmd.." [modelo o nombre]", player, 255, 255, 255 )
		end
	end
end
addCommandHandler( "tempveh", tempVeh )

function delTempVeh( player, cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 4 then
		if tonumber(id) then
			if temporales[tonumber(id)] then
				if isElement( temporales[tonumber(id)] ) then destroyElement( temporales[tonumber(id)] ) end
				temporales[tonumber(id)] = nil
				outputChatBox( "Has borrado el vehículo temporal con ID "..id, player, 0, 255, 0 )
			else
				outputChatBox( "No existe un vehículo temporal con esa ID.", player, 255, 0, 0 )
			end
		else
			outputChatBox( "Syntax: /"..cmd.." [id]", player, 255, 255, 255 )
		end
	end
end
addCommandHandler( "removetempveh", delTempVeh )






-- RELACIONADO A JUGADORES





local pueblos = { 
	{ "Los Santos", {1537.173828125, -1724.0234375, 13.546875} }, 
	{ "Dillimore", {634, -577.33984375, 16.3359375} }, 
	{ "Palomino", {2285.7001953125, 32.5546875, 26.484375} },
	{ "Montgomery", {1370.8759765625, 410.7294921875, 19.724763870239} },	
}

addCommandHandler( "infobanco",
	function( player, cmd, id )
		if getElementData(player, "isLoged") and getElementData(player, "staff") then
			if getElementData(player, "staff") >= 3 then
				local id = tonumber( id )
				if id then
					local other, name = exports.login:getNID( player, id )
					if other then
						local charid = exports.personajes:getCharID( other )
						if charid then
							local q = dbQuery( connection, "SELECT * FROM cuentas_bancarias WHERE owner=?", tonumber( charid ) )
							local rec = dbPoll( q, -1 )		
							if rec and #rec > 0 then
								outputChatBox( "Cuentas bancarias de "..name, player, 255, 255, 0 )
								for i=1, #rec do 
									local v = rec[i]
									local pin, dinero = v.pin, v.dinero
									outputChatBox( "     - Pin: "..pin.." | Dinero: "..dinero, player, 255, 255, 255 )
								end	
							else
								outputChatBox( "No hay cuentas bancarias.", player, 255, 0, 0 )
							end
						else
							outputChatBox( "Fallo con la ID del jugador.", player, 255, 0, 0 )
						end
					end
				else
					outputChatBox( "Syntax: /"..cmd.." [id]", player, 255, 255, 255 )
				end
			end
		end
	end
)

addCommandHandler( "fixdim",
	function( player, cmd, idotro )
		if getElementData(player, "isLoged") and getElementData(player, "staff") then
			if getElementData(player, "staff") >= 3 then
				if idotro then
					local other, name = exports.login:getNID( player, idotro )
					if other then
						setElementDimension( other, 0 )
						setElementInterior( other, 0 )
						outputChatBox( "Has colocado a "..name.." en la dimensión 0 (default).", player, 0, 255, 0 )
						outputChatBox( "El staff "..getPlayerName( player ).." te ha fixeado la dimensión.", player, 0, 255, 0 )
					end
				else
					outputChatBox( "Syntax: /"..cmd.." [id jugador]", player, 255, 255, 255 )
				end
			end
		end
	end
)

addCommandHandler( "tppueblo",
	function( player, cmd, idotro, idpueblo )
		if getElementData(player, "isLoged") and getElementData(player, "staff") then
			if getElementData(player, "staff") >= 3 then
				local idpueblo = tonumber( idpueblo )
				if idotro and idpueblo then
					local other, name = exports.login:getNID( player, idotro )
					if other then
						if pueblos[ idpueblo ] then
							local x, y, z = unpack( pueblos[idpueblo][2] )
							setElementPosition( other, x, y, z )
							setElementDimension( other, 0 )
							setElementInterior( other, 0 )
							outputChatBox( "Has tpeado a "..name.." a "..pueblos[idpueblo][1], player, 0, 255, 0 )
							outputChatBox( "El staff "..getPlayerName( player ):gsub("_"," ").." te ha tpeado a "..pueblos[idpueblo][1], other, 0, 255, 0 )
						else
							outputChatBox( "La ID del pueblo es incorrecta.", player, 255, 0, 0 )
						end
					else
						outputChatBox( "Syntax: /"..cmd.." [id jugador] [id pueblo]", player, 255, 255, 255 )
						outputChatBox( "1.- Blueberry, 2.- Dillimore, 3.- Palomino, 4.- Montgomery", player, 255, 255, 255 )					
					end
				else
					outputChatBox( "Syntax: /"..cmd.." [id jugador] [id pueblo]", player, 255, 255, 255 )
					outputChatBox( "1.- Blueberry, 2.- Dillimore, 3.- Palomino, 4.- Montgomery", player, 255, 255, 255 )
				end
			end
		end
	end
)

addCommandHandler( "setcaminar",
	function( player, cmd, otherPlayer, id )
		if getElementData(player, "isLoged") and getElementData(player, "staff") then
			if getElementData(player, "staff") >= 3 then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other and id then
					if setPedWalkingStyle( other, tonumber(id) ) then
						outputChatBox( "Le has puesto el estilo de caminar "..id.." a "..name, player, 0, 255, 0 )
						outputChatBox( "El staff "..getPlayerName( player ):gsub("_"," ").." te ha asignado el estilo de caminar "..id, player, 0, 200, 0 )
						dbExec( connection, "UPDATE `personajes` SET `estilocaminar`=? WHERE `ID`=?",tonumber(id),exports.personajes:getCharID(other))
					else
						outputChatBox( "Fallo en asignar el estilo de caminar.", player, 255, 0, 0 )
					end
				else
					outputChatBox( "Syntax: /"..cmd.." [id] [id estilo caminar]", player, 255, 255, 255 )
				end
			end
		end	
	end
)

addCommandHandler( "seteuritos", -- SOLO PARA PRUEBAS
	function( player, cmd, otherPlayer, dinero )
		if getElementData(player, "isLoged") and getElementData(player, "staff") then
			if getElementData(player, "staff") >= 6 then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other and dinero then
					if exports.personajes:addCharMoney( other, tonumber(dinero) ) then
						outputChatBox( "Has seteado "..dinero.."$ a "..name, player, 0, 255, 0 )
						outputChatBox( "El staff "..getPlayerName( player ).." te ha seteado "..dinero.."$", other, 0, 255, 0 )
					else
						outputChatBox( "Fallo en dar el money.", player, 255, 0, 0 )
					end
				else
					outputChatBox( "Syntax: /"..cmd.." [id] [$]", player, 255, 255, 255 )
				end
			end
		end
	end
)

function ponerSkin(player, cmd, otherPlayer, skin )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 5 then
			local other, name = exports.login:getNID( player, otherPlayer )
			if other and skin then
				if setElementModel( other, tonumber(skin) ) then
					outputChatBox( "Le has cambiado la skin a "..name, player, 0, 255, 0 )
					outputChatBox( "El staff "..getPlayerName(player).." te ha cambiado la skin.", other, 0, 255, 0 )
				else
					outputChatBox( "No se puede cambiar la skin de "..name, player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id] [skin]", player, 255, 255, 255 )
			end
		end
	end
end
addCommandHandler("setskin", ponerSkin)

addCommandHandler( "spec",
	function( player, commandName, other )
		local name
		if other then
			other, name = exports.login:getNID( player, other )
			if not other then
				return
			end
		end
		
		if not exports.freecam:isPlayerFreecamEnabled( player ) then
			if isElementAttached( player ) then
				if getElementType( getElementAttachedTo( player ) ) == "player" then
					if other then
						local interior, dimension = getElementInterior( player ), getElementDimension( player )
						setElementDimension( player, getElementDimension( other ) )
						setElementInterior( player, getElementInterior( other ) )
						if attachElements( player, other, 0, 0, -5 ) then
							outputChatBox( "Estás specteando a " .. name .. ".", player, 0, 255, 0 )
							triggerClientEvent( root, "ocultarCabeza", root, player, 1 )
							for key, value in ipairs( getElementsByType( "player" ) ) do
								if getElementData(value, "staff") and getElementData(value, "staff") >= 3 then
									outputChatBox( getPlayerName( player ):gsub( "_", " " ) .. " esta specteando a " .. name .. ".", value, 0, 255, 153 )
								end
							end
						else
							outputChatBox( "No puedes spectear al jugador.", player, 255, 0, 0 )
							setElementInterior( player, interior )
							setElementDimension( player, dimension )
						end
					elseif type( getElementData( player, "collisionless" ) ) == "table" then
						local x, y, z, dimension, interior = unpack( getElementData( player, "collisionless" ) )
						removeElementData( player, "collisionless" )
						triggerClientEvent( root, "ocultarCabeza", root, player, 0 )
						detachElements( player )
						setElementPosition( player, x, y, z )
						setElementDimension( player, dimension )
						setElementInterior( player, interior )
						setElementAlpha( player, 255 )
						setCameraTarget( player )
						for key, value in ipairs( getElementsByType( "player" ) ) do
							if getElementData(value, "staff") and getElementData(value, "staff") >= 3 then
								outputChatBox( getPlayerName( player ):gsub( "_", " " ) .. " ha dejado de spectear.", value, 0, 255, 130 )
							end
						end						
					else
						outputChatBox( "No estas specteando a nadie.", player, 255, 0, 0 )
					end
				else
					outputChatBox( "Deja de spectear antes.", player, 255, 0, 0 )
				end
			elseif other then
				local x, y, z = getElementPosition( player )
				local interior, dimension = getElementInterior( player ), getElementDimension( player )
				setElementDimension( player, getElementDimension( other ) )
				setElementInterior( player, getElementInterior( other ) )
				if attachElements( player, other, 0, 0, -5 ) then
					setElementData( player, "collisionless", true ) -- synced to have the player collisionless
					setElementData( player, "collisionless", { x, y, z, dimension, interior }, false ) -- our data only
					setElementDimension( player, getElementDimension( other ) )
					setElementInterior( player, getElementInterior( other ) )
					setElementAlpha( player, 0 )
					setCameraTarget( player, other )
					outputChatBox( "Estas specteando a " .. name .. ".", player, 0, 255, 0 )
					triggerClientEvent( root, "ocultarCabeza", root, player, 1 )
					for key, value in ipairs( getElementsByType( "player" ) ) do
						if getElementData(value, "staff") and getElementData(value, "staff") >= 3 then
							outputChatBox( getPlayerName( player ):gsub( "_", " " ) .. " esta specteando a " .. name .. ".", value, 0, 255, 153 )
						end
					end
				else
					outputChatBox( "No puedes spectear a " .. name .. ".", player, 255, 0, 0 )
					setElementInterior( player, interior )
					setElementDimension( player, dimension )
				end
			else
				outputChatBox( "Syntax: /" .. commandName .. " [player]", player, 255, 255, 255 )
			end
		else
			outputChatBox( "Desactiva /freecam antes.", player, 255, 0, 0 )
		end
	end
)

addCommandHandler( "setpuntoscarnet",
	function( player, cmd, id, puntos )
		if getElementData(player, "isLoged") and getElementData(player, "staff") then
			if getElementData(player, "staff") >= 3 then
				local puntos = tonumber(puntos)
				local other, name = exports.login:getNID( player, id )
				if other and puntos then
					setElementData( other, "puntos_coche", puntos )
					outputChatBox( "Le has puesto "..puntos.." a "..name, player, 0, 255, 0 )
					outputChatBox( "El staff "..getPlayerName(player).." te ha puesto "..puntos.." puntos.", other, 0, 255, 0 )
				else
					outputChatBox( "Syntax: /"..cmd.." [id] [puntos]", player, 255, 255, 255 )
				end
			end
		end
	end
)

function setLicencias( player, cmd, otherPlayer, nivel, puntos )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					if tonumber( nivel ) then
						setElementData( other, "licencias", tonumber( nivel ) )
						dbExec( connection, "UPDATE `personajes` SET `licencias`=? WHERE `ID`=?", ""..tonumber(nivel).."", exports.personajes:getCharID(player))
						outputChatBox( "El staff "..getPlayerName( player ).." te ha cambiado las licencias a "..nivel, other, 0, 255, 0 )
						outputChatBox( "Le has cambiado las licencias a "..nivel.." a "..name, player, 0, 255, 0 )
						
						if tonumber( nivel ) > 0 and tonumber( nivel ) ~= 3 then
							local charid = exports.personajes:getCharID( other )
							if charid then
								local query = dbQuery( connection, "SELECT tiempo FROM licencias_retiradas WHERE idchar=?", tonumber( charid ) )
								local data = dbPoll(query, -1)	
								if data and #data > 0 then
									dbExec( connection, "DELETE FROM licencias_retiradas WHERE idchar=?", tonumber( charid ) )
								end
							end
						end
					else
						outputChatBox("Syntax: /"..cmd.." [id]", player, 255,255,255)
					end
				end
			else
				outputChatBox("Syntax: /"..cmd.." [id] [nivel (0 nada, 1 teorico, 2 teorico y practico)]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("setlicencia", setLicencias)

function getPlayer( player, cmd, otherPlayer )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
				local x,y,z = getElementPosition(player)
				if isPedInVehicle(other) then
					removePedFromVehicle ( other )
				end
				setElementPosition(other, x+1,y,z)
				outputChatBox("Teletransportado correctamente hacia tí.", player, 0,200,0)
				setElementDimension(other, getElementDimension(player))
				setElementInterior(other, getElementInterior(player))
				end
			else
				outputChatBox("Syntax: /get [id]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("get", getPlayer)

function gotoPlayer( player, cmd, otherPlayer )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
				local x,y,z = getElementPosition(other)
				setElementPosition(player, x+1,y,z)
				outputChatBox("Teletransportado correctamente.", player, 0,200,0)
				setElementDimension(player, getElementDimension(other))
				setElementInterior(player, getElementInterior(other))
				end
			else
				outputChatBox("Syntax: /goto [id]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("goto", gotoPlayer)

function setItem( player, cmd, otherPlayer, item, value )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					exports.items:darItem( other, tonumber(item), tonumber(value) )
					outputChatBox( "Seteado el item "..item.." con valor "..value.." a "..name, player, 0, 255, 0  )
				end
			else
				outputChatBox("Syntax: /"..cmd.." [id jugador] [id item] [valor]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler( "giveitem", setItem )

function llenarCansancio( player, cmd, otherPlayer, nivel )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					if tonumber(nivel) then
						if setElementData( other, "cansancio", tonumber(nivel) ) then
							outputChatBox( "Has cambiado el nivel de cansancio de "..name.." a "..nivel.."%", player, 0, 255, 0 )
							outputChatBox( "El staff "..getPlayerName(player).." te ha cambiado el nivel de cansancio a "..nivel.."%", player, 0, 255, 0 )
						else
							outputChatBox( "Fallo en cambiar el nivel de cansancio de "..name, player, 255, 0, 0 )
						end
					else
						outputChatBox( "Asigna un nivel de cansancio", player, 255, 0, 0 )
					end
				end
			else
				outputChatBox("Syntax: /"..cmd.." [id jugador] [nivel de cansancio]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler( "setcansancio", llenarCansancio )

function llenarSed( player, cmd, otherPlayer, nivel )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					if tonumber(nivel) then
						if setElementData( other, "sed", tonumber(nivel) ) then
							outputChatBox( "Has cambiado el nivel de sed de "..name.." a "..nivel.."%", player, 0, 255, 0 )
							outputChatBox( "El staff "..getPlayerName(player).." te ha cambiado el nivel de sed a "..nivel.."%", player, 0, 255, 0 )
						else
							outputChatBox( "Fallo en cambiar el nivel de sed de "..name, player, 255, 0, 0 )
						end
					else
						outputChatBox( "Asigna un nivel de sed", player, 255, 0, 0 )
					end
				end
			else
				outputChatBox("Syntax: /"..cmd.." [id jugador] [nivel de sed]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler( "setsed", llenarSed )

function llenarHambre( player, cmd, otherPlayer, nivel )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					if tonumber(nivel) then
						if setElementData( other, "hambre", tonumber(nivel) ) then
							outputChatBox( "Has cambiado el nivel de hambre de "..name.." a "..nivel.."%", player, 0, 255, 0 )
							outputChatBox( "El staff "..getPlayerName(player).." te ha cambiado el nivel de hambre a "..nivel.."%", player, 0, 255, 0 )
						else
							outputChatBox( "Fallo en cambiar el nivel de hambre de "..name, player, 255, 0, 0 )
						end
					else
						outputChatBox( "Asigna un nivel de hambre", player, 255, 0, 0 )
					end
				end
			else
				outputChatBox("Syntax: /"..cmd.." [id jugador] [nivel de hambre]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler( "sethambre", llenarHambre )

function freezePlayer( player, cmd, otherPlayer )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					if isElementFrozen(other) then
						setElementFrozen(other, false)
						outputChatBox("Has descongelado al jugador correctamente.", player, 0,200,0)
						outputChatBox("Has sido descongelado por el staff.", other, 0,200,0)
					else
						setElementFrozen(other, true)
						outputChatBox("Has congelado al jugador correctamente.", player, 0,200,0)
						outputChatBox("Has sido congelado por el staff.", other, 0,200,0)
					end
				end
			else
				outputChatBox("Syntax: /freeze [id]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("freeze", freezePlayer)


function darvida( player, cmd, otherPlayer, amount )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer and tonumber(amount) then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
				setElementHealth(other, tonumber(amount))
				outputChatBox(string.gsub(getPlayerName(player),"_"," ").." te ha puesto la vida al "..amount.."%",other,100,100,200)
				end
			else
				outputChatBox("Syntax: /sethp [idjugador] [vida 0-100]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("sethp", darvida)
function darchaleco( player, cmd, otherPlayer, amount )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer and tonumber(amount) then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
				setPedArmor(other, tonumber(amount))
				outputChatBox(string.gsub(getPlayerName(player),"_"," ").." te ha puesto el chaleco al "..amount.."%",other,100,100,200)
				end
			else
				outputChatBox("Syntax: /setar [idjugador] [chaleco 0-100]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("setar", darchaleco)

function revivirplayer( player, cmd, otherPlayer )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 3 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					local x,y,z = getElementPosition(other)
					if isElement( other ) and getElementData( other, "isLoged" ) and isPedDead( other ) then

						if getElementModel(other) == 0 then
							--1048.9755859375, -313.3125, 76.503540039062
							if getElementData(other, "arrestado") then
								spawnPlayer ( other, x,y,z, 0, 0, 0,0 )
							else
								spawnPlayer ( other, x,y,z, 0, 0, 0,0 )
							end
							setElementData(other, "sed", 100)
							setElementData(other, "cansancio", 100)
							setElementData(other, "hambre", 100)
							setPedHeadless(other, true)
							fadeCamera( other, true )
							setCameraTarget( other, other )
							setCameraInterior( other, 0 )
						else
							if getElementData(other, "arrestado") then
								spawnPlayer ( other, x,y,z, 0, getElementModel(other), 0,0 )
							else
								spawnPlayer ( other, x,y,z, 0, getElementModel(other), 0,0 )
							end
							setElementData(other, "sed", 100)
							setElementData(other, "cansancio", 100)
							setElementData(other, "hambre", 100)
							fadeCamera( other, true )
							setCameraTarget( other, other )
							setCameraInterior( other, 0 )
						end
						
					end
				end
			else
				outputChatBox("Syntax: /revivir [idjugador]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("revivir", revivirplayer)

function kickP (player, cmd, otherPlayer, ...)
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 3 then
		if otherPlayer and ... then
		local other, name = exports.login:getNID( player, otherPlayer )
			if getElementData(other, "staff") < getElementData(player, "staff") then
				if other ~= player then
				local reason = table.concat({...}, " ")
				kickPlayer ( other, player, tostring(reason) )
				else
				outputChatBox("No te puedes echar a ti mismo.",player, 200,0,0)
				end
			else
				outputChatBox("No puedes hacer esto con este jugador.",player, 200,0,0)
			end
		else
		outputChatBox("Syntax: /"..cmd.." [jugador/ID] [razón]",player, 255,255,255)
		end
	end
end
addCommandHandler("kickplayer", kickP)

function cambiarNombre( player, cmd, otherPlayer, nombre, apellido )
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 5 then
		if otherPlayer and nombre and apellido then
		local other, name = exports.login:getNID( player, otherPlayer )
			local fullname = nombre.."_"..apellido
			local q = dbQuery( connection, "SELECT * FROM personajes WHERE nombre=?", fullname )
			local rec = dbPoll( q, -1 )
			if rec[1] == nil then
				outputChatBox("Le has cambiado el nombre a "..getPlayerName(other)..". Nuevo nombre: "..fullname,player,0,200,0)
				if dbExec( connection, "UPDATE `personajes` SET `nombre`=? WHERE `ID`=?",fullname,exports.personajes:getCharID(other)) then
					setPlayerName(other, string.gsub(fullname, "_", " "))
					outputChatBox("Te han cambiado el nombre a "..fullname,other,0,200,0)
				else
					outputChatBox( "Error en cambiar el nombre.", player, 200, 0, 0 )
				end	
			else
				outputChatBox("Ya hay alguien con ese nombre",player,200,0,0)
			end
		else
		outputChatBox("Syntax: /"..cmd.." [jugador/ID] [Nombre] [Apellido]",player, 255,255,255)
		end
	end
end
addCommandHandler("setname",cambiarNombre)

function adminduty( player )
	if getElementData(player, "staff") and getElementData(player, "staff") >= 2 then
		if getElementData(player, "adminduty") then
			removeElementData(player, "adminduty")
			outputChatBox("Ya no estás de servicio administrativo.",player,200,0,0)
		else
			setElementData(player, "adminduty", true)
			outputChatBox("Ahora estás de servicio administrativo.",player,0,200,0)
		end
	end
end
addCommandHandler("adminduty", adminduty)
function showstaffchat( player )
	if getElementData(player, "staff") and getElementData(player, "staff") >= 2 then
		if getElementData(player, "showadmin") then
			removeElementData(player, "showadmin")
			outputChatBox("Ahora ves los mensajes administrativos.",player,0,200,0)
		else
			setElementData(player, "showadmin", true)
			outputChatBox("Ahora no ves los mensajes administrativos.",player,200,0,0)
		end
	end
end
addCommandHandler("showadmin", showstaffchat)
function ocultarstaff( player )
	if getElementData(player, "staff") and getElementData(player, "staff") >= 5 then
		if getElementData(player, "ocultadostaff") then
			removeElementData(player, "ocultadostaff")
			outputChatBox("Vuelves a ser visible en el staff.",player,0,200,0)
		else
			setElementData(player, "ocultadostaff", true)
			outputChatBox("Ya no eres visible en el staff.",player,200,0,0)
			
		end
	end
end
addCommandHandler("ocultarstaff", ocultarstaff)
function banP (player, cmd, otherPlayer, temp, ...)
	if getElementData(player, "isLoged") and getElementData(player, "staff") >= 3 then
		if otherPlayer and tonumber(temp) and ... then
		local other, name = exports.login:getNID( player, otherPlayer )
			if getElementData(other, "staff") < getElementData(player, "staff") then
				if other ~= player then
					local reason = table.concat({...}, " ")
					local tiempoo = temp*60
					if getElementData(other, "isLoged") then
						local qpjs = dbQuery( connection, "SELECT * FROM personajes WHERE ID=?",exports.personajes:getCharID(other) )
						local pj = dbPoll( qpjs, -1 )
						local qcuentas = dbQuery( connection, "SELECT * FROM cuentas WHERE ID=?",pj[1].userID )
						local cuenta = dbPoll( qcuentas, -1 )
						reloadBans()
						outputChatBox(getPlayerName(other).." ha sido baneado "..temp.. " minutos por '"..tostring(reason).."'.", player, 0,200,0)
						addBan ( cuenta[1].ip, cuenta[1].username, cuenta[1].serial, player, tostring(reason), tonumber(tiempoo) )
						kickPlayer ( other, player, "Has sido baneado por: "..tostring(reason) )
						reloadBans()
					end
				else
				outputChatBox("No te puedes banear a ti mismo.",player, 200,0,0)
				end
			else
			outputChatBox("No puedes hacer esto con este jugador.",player, 200,0,0)
			end
		else
		outputChatBox("Syntax: /"..cmd.." [jugador/ID] [tiempo en minutos (0 para permanente)] [razón]",player, 255,255,255)
		end
	end
end
addCommandHandler("banplayer", banP)

function ajail( player, cmd, otherPlayer, tiempo, ... )
if getElementData(player, "isLoged") and getElementData(player, "staff") then
	if getElementData(player, "staff") >= 3 then
			if otherPlayer and tiempo and ... then
			local other, name = exports.login:getNID( player, otherPlayer )
				if not getElementData(other, "ajaileado") then
				local motivo = table.concat({...}, " ")
				local t = getRealTime().timestamp
				local ins = dbQuery( connection, "INSERT INTO jails (personaje_id,tiempo,razon,jaileado_por,created_at,tipo) VALUES (?,?,?,?,?,?)",exports.personajes:getCharID(other), tonumber(tiempo), motivo, exports.personajes:getCharID(player),tonumber(t),1)
				local result, num_affected_rows, ID = dbPoll ( ins, -1 )
				outputChatBox("Has jaileado a "..string.gsub(getPlayerName(other),"_", " "),player,0,200,0)
				outputChatBox("Tiempo:"..tiempo.." minutos. Razón: "..motivo,player,0,200,0)
				outputChatBox("Has sido jaileado administrativamente durante "..tiempo.." minutos. Motivo: "..motivo,other,0,200,0)
				setElementData(other, "ajaileado", {tonumber(t),tonumber(t), tonumber(tiempo)})
				setElementPosition(other,405.30859375, 2462.9736328125, 16.5)
				else
					outputChatBox("Este jugador ya está en jail, sueltalo primero.",player,200,0,0)
				end
			else
				outputChatBox("Syntax: /"..cmd.." [ID/Jugador] [Tiempo en minutos] [Razón]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("ajail", ajail)

function soltarjail( player, cmd, otherPlayer )
if getElementData(player, "isLoged") and getElementData(player, "staff") then
	if getElementData(player, "staff") >= 3 then
			if otherPlayer then
			local other, name = exports.login:getNID( player, otherPlayer )
				if getElementData(other, "ajaileado") then
 					removeElementData(other, "ajaileado")
 					setElementPosition(other, 1015.173828125, -380.435546875, 76.503540039062)
 					setElementDimension(other, 0)
 					setElementInterior(other, 0)
 					outputChatBox("Has sido liberado, espero que hayas aprendido la lección.", other, 0,200,0)
 					dbExec(connection,"DELETE FROM jails WHERE personaje_id=? AND tipo=1", exports.personajes:getCharID(other))
				else
					outputChatBox("Este jugador no está jaileado.",player,200,0,0)
				end
			else
				outputChatBox("Syntax: /"..cmd.." [ID/Jugador]", player, 255,255,255)
			end
		end
	end
end
addCommandHandler("desjail", soltarjail)


function vertiempojail( player )
	if getElementData(player, "ajaileado") then
		local jail = getElementData(player, "ajaileado")
		local minutos = jail[3] + ((jail[1] - jail[2])/60)
		outputChatBox("Te quedan "..minutos.." minutos de jail administrativo.",player,200,0,0)
	end
end
addCommandHandler("verjail",vertiempojail)


function isPlayerJailed( player, cmd, otherPlayer )
	if getElementData(player, "staff") and getElementData(player, "staff") >= 3 then
		if otherPlayer then
			local other, name = exports.login:getNID( player, otherPlayer )
			if getElementData(other, "ajaileado") then
				outputChatBox("Este jugador está en jail",player,0,200,0)
			else
				outputChatBox("Este jugador no está en jail",player,200,0,0)
			end
		else
			outputChatBox("Syntax: /playerjail [ID]",player,255,255,255)
		end

	end
end
addCommandHandler("playerjail",isPlayerJailed)

	setTimer ( function()
		for i,v in ipairs(getElementsByType("player")) do
			local jail = getElementData(v, "ajaileado")
			if jail then
				local current_t = jail[2]
				local needed_t = jail[1]+(jail[3]*60)
 				if current_t >= needed_t then
 					removeElementData(v, "ajaileado")
 					setElementPosition(v, 1015.173828125, -380.435546875, 76.503540039062)
 					setElementDimension(v, 0)
 					setElementInterior(v, 0)
 					outputChatBox("Has sido liberado, espero que hayas aprendido la lección.", v, 0,200,0)
 					dbExec(connection,"DELETE FROM jails WHERE personaje_id=? AND tipo=1", exports.personajes:getCharID(v))
 				else
 					setElementData(v, "ajaileado", {jail[1], jail[2]+1, jail[3]})
 				end
			end
		end
	end, 1000, 0 )
	
addCommandHandler( "reiniciarfarm",
	function( player, cmd )
		if getElementData(player, "staff") and getElementData(player, "staff") >= 4 then
			if dbExec(connection, "UPDATE `personajes` SET `farmeado`=0") then
				outputChatBox( "Farmeo reiniciado con éxito.", player, 0, 255, 0 )
				for i,v in ipairs(getElementsByType("player")) do
					if getElementData( v, "isLoged" ) then
						setElementData( v, "farmeado", 0 )
					end
				end
			else
				outputChatBox( "Fallo al reiniciar el farmeo.", player, 255, 0, 0 )
			end	
		end
	end
)






-- RELACIONADO CON OTROS ASPECTOS DE LA JUGABILIDAD





local climas = {

	[0] = "Muy soleado",
	[1] = "Soleado",
	[2] = "Muy soleado con neblina",
	[3] = "Soleado con neblina",
	[4] = "Nublado",
	[5] = "Soleado despejado",
	[6] = "Muy soleado despejado",
	[7] = "Nublado de SF",
	[8] = "Lluvia con truenos",
	[9] = "Neblina fuerte",
	[10] = "Soleado LV",
	[11] = "Muy soleado LV",
	[12] = "Nublado LV",
	[13] = "Muy soleado Countryside",
	[14] = "Soleado Countryside",
	[15] = "Nublado Countryside",
	[16] = "Lluvia Countryside",
	[17] = "Muy soleado (desértico)",
	[18] = "Soleado (desértico)",
	[19] = "Tormenta de arena",
	[20] = "Bajo del agua (?)",
	[21] = "Colores extra",
	[22] = "Colores extra 2",

}

addCommandHandler( "setclima",
	function( player, cmd, id )
		if getElementData(player, "staff") and getElementData(player, "staff") >= 3 then
			local id = tonumber(id)
			if id then
				if climas[id] then
					outputChatBox( "Has cambiado el clima a "..id..".", player, 0, 255, 0 )
					setWeather( id )
				else
					outputChatBox( "El clima con esa ID no existe o no es válido.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id clima]", player, 255, 255, 255 )
			end
		end
	end
)

addCommandHandler( "nextclima",
	function( player, cmd, id )
		if getElementData(player, "staff") and getElementData(player, "staff") >= 3 then
			local id = tonumber(id)
			if id then
				if climas[id] then
					outputChatBox( "El próximo clima será "..id..".", player, 0, 255, 0 )
					setWeatherBlended ( 9 )
				else
					outputChatBox( "El clima con esa ID no existe o no es válido.", player, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id clima]", player, 255, 255, 255 )
			end
		end
	end
)

addCommandHandler( "gotopos",
	function( player, cmd, x, y, z, int, dim )
		if getElementData(player, "staff") and getElementData(player, "staff") >= 3 then
			if tonumber(x) and tonumber(y) and tonumber(z) and tonumber(int) and tonumber(dim) then
				setElementPosition( player, x, y, z )
				setElementInterior( player, int )
				setElementDimension( player, dim )
				outputChatBox( "Te has cambiado la posición correctamente.", player, 0, 255, 0 )
			else
				outputChatBox( "Syntax: /"..cmd.." [x] [y] [z] [int] [dim]", player, 255, 255, 255 )
			end
		end
	end
)



-- VENTA DE PROPIEDADES Y TAL PARA JUGADORES





addCommandHandler( "venderveh",
	function( player, cmd, idotro )
		if getElementData( player, "isLoged" ) then
			if idotro then
				local other, name = exports.login:getNID( player, idotro )
				if other then
					local x, y, z = getElementPosition( player )
					local px, py, pz = getElementPosition( other )
					if getDistanceBetweenPoints3D( x, y, z, px, py, pz ) < 5 and getElementInterior( player ) == getElementInterior( other ) and getElementDimension( player ) == getElementDimension( other ) then
						local veh = getPedOccupiedVehicle( player )
						local id = tonumber( getElementData( veh, "id" ) )
						if veh and id then
							local query = dbQuery( connection, "SELECT * FROM vehiculos WHERE id=? ORDER BY id ASC", id )
							local data = dbPoll(query, -1)
							if data and #data > 0 then	
								if data[1].owner == exports.personajes:getCharID( player ) and data[1].facc == 0 then
									local charidotro = exports.personajes:getCharID( other )
									if charidotro then
										if dbExec( connection, "UPDATE vehiculos SET owner=? WHERE id=?", tonumber( charidotro ), id ) then
											outputChatBox( "Has vendido correctamente el "..getVehicleNameFromModel( getElementModel( veh ) ).." a "..name, player, 0, 255, 0 )
											outputChatBox( "Felicidades! Has adquirido un "..getVehicleNameFromModel( getElementModel( veh ) ).." de "..getPlayerName( player ), other, 0, 255, 0 )
											exports.vehiculos:cambiarPropietario( id, tonumber( charidotro ) )
										else
											outputChatBox( "Fallo brutal con la base de datos.", player, 255, 0, 0 )
										end
									else
										outputChatBox( "Error en la base de datos con la ID del otro jugador.", player, 255, 0, 0 )
									end
								else
									outputChatBox( "No eres el dueño del vehículo.", player, 255, 0, 0 )
								end
							else
								outputChatBox( "Error con la base de datos.", player, 255, 0, 0 )
							end
						else
							outputChatBox( "Este vehículo es invalido. No tiene ID.", player, 255, 0, 0 )
						end
					else
						outputChatBox( "El jugador no está cerca de ti.", player, 255, 0, 0 )
					end
				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id jugador]", player, 255, 255, 255 )
			end
		end
	end
)

addCommandHandler( "setpasswordserverrp", -- add a command handler for the command
   function( thePlayer, command, password )
   --			if getElementData(player, "staff") and getElementData(player, "staff") >= 5 then
      if #password < 3 then -- check if the password is shorter than 3 letters
         outputChatBox( "¡La contraseña debe tener al menos 3 letras!", thePlayer ) -- tell the player that password was too short
         return -- abort command
      end
      local success = setServerPassword( password ) -- check whether changing password worked
      if success then
         outputChatBox( "Cambio la contraseña del servidor a: " .. password, thePlayer ) -- if it did, tell the player
      else
         outputChatBox( "Fallo al cambiar la contraseña del servdor", thePlayer ) -- if it didn't, tell the player
      end
 -- end
   end
)

addCommandHandler( "removepasswordserverrp", -- add a command handler for the command
   function( thePlayer, command )
   	--		if getElementData(player, "staff") and getElementData(player, "staff") >= 5 then
      local success = setServerPassword( nil ) -- check whether removing password worked
      if success then
         outputChatBox( "Contraseña removida perfectamente", thePlayer ) -- if it did, tell the player
      else
         outputChatBox( "Fallo al remover la contraseña", thePlayer ) -- if it didn't, tell the player
      end
  -- end
   end
)

setGameType ( "Roleplay" )

function fpsFunction( player, command, limit ) -- First define the function
  if hasObjectPermissionTo ( player, "function.setFPSLimit" ) and limit then 
    -- If the player has permission to set FPS limit and limit is submitted...
    setFPSLimit ( limit ) -- Set the fps.
  end
end 

addCommandHandler ( "setfps", fpsFunction ) -- Attach the setfps command to fpsFunction function.



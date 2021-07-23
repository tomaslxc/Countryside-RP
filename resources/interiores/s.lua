local connection = exports.mysql:connect()

interiorPositions =
{
	-- houses -- TODO: should be renamed to [cagegory][num], low1, etc.
	house1  = { x =   235.25, y =  1186.68, z = 1080.26, interior = 3 }, -- two floors
	house2  = { x =   226.79, y =  1240.02, z = 1082.14, interior = 2 },
	house3  = { x =   223.07, y =  1287.09, z = 1082.14, interior = 1 },
	house4  = { x =   327.94, y =  1477.73, z = 1084.44, interior = 15 },
	house5  = { x =  2468.84, y = -1698.29, z = 1013.51, interior = 2 }, -- ryder's house
	house6  = { x =  226.34, y = 1114.23, z = 1080.89, interior = 5 }, -- Awesome House
	--house7  = { x =   387.23, y =  1471.79, z = 1080.19, interior = 15 },
	house8  = { x =   225.79, y =  1021.46, z = 1084.02, interior = 7 }, -- two floors
	house9  = { x =   295.16, y =  1472.26, z = 1080.26, interior = 15 },
	house10 = { x =  2807.58, y = -1174.75, z = 1025.57, interior = 8 },
	house12 = { x =  2270.42, y = -1210.52, z = 1047.56, interior = 10 },
	house13 = { x =  2496.02, y = -1692.08, z = 1014.74, interior = 3 }, -- CJ's house
	house14 = { x =  2259.38, y = -1135.84, z = 1050.64, interior = 10 },
	house15 = { x =  2365.21, y = -1135.60, z = 1050.88, interior = 8 },
	house16 = { x =  1531.36, y = -6.84, z = 1002.01, interior = 3 },
	house16 = { x =  2807.68, y = -1174.57, z = 1025.57, interior = 8 },
	house17 = { x =  2233.8, y = -1115.36, z = 1050.89, interior = 5 },
	house18 = { x =  2282.90, y = -1140.27, z = 1050.9, interior = 11 },
	house19 = { x =  2196.75, y = -1204.34, z = 1048.84, interior = 6 },
	house20 = { x =  2308.78, y = -1212.91, z = 1048.82, interior = 6 },
	house21 = { x =  2217.85, y = -1076.29, z = 1053, interior = 1 },
	house22 = { x =  2237.61, y = -1081.48, z = 1048.91, interior = 2 },
	house23 = { x =  2317.82, y = -1026.75, z = 1049.21, interior = 9 },
	house24 = { x =  260.98, y = 1284.40, z = 1080.08, interior = 4 },
	house25 = { x =  140.18, y = 1366.58, z = 1083.86, interior = 5 },
	house26 = { x =  82.95, y = 1322.38, z = 1083.48, interior = 9 },
	house27 = { x =  -42.56, y = 1405.64, z = 1084.60, interior = 8 },
	house28 = { x =  2333.03, y = -1077.22, z = 1048.86, interior = 6 },
	
	
	room1 = { x = 243.71, y = 304.95, z = 999.14, interior = 1 }, -- Denise
	room2 = { x = 266.50, y = 305.01, z = 999.14, interior = 2 }, -- Katie
	room3 = { x = 322.18, y = 302.35, z = 999.14, interior = 5 }, -- Barbara, some PD stuff
	room4 = { x = 343.71, y = 304.98, z = 999.14, interior = 6 }, -- Millie/Sex room
	
	-- business
	['24/7-1'] =  { x = -25.89, y = -188.24, z = 1003.54, interior = 17 },
	['24/7-2'] =  { x =   6.11, y =  -31.75, z = 1003.54, interior = 10 },
	['24/7-3'] =  { x = -25.89, y = -188.24, z = 1003.54, interior = 17 },
	['24/7-4'] =  { x = -25.77, y = -141.55, z = 1003.55, interior = 16 },
	['24/7-5'] =  { x = -27.30, y =  -31.76, z = 1003.56, interior = 4 },
	['24/7-6'] =  { x = -27.34, y =  -58.26, z = 1003.55, interior = 6 },
	ammunation1 = { x = 285.50, y =  -41.80, z = 1001.52, interior = 1, blip = 6 },
	ammunation2 = { x = 285.87, y =  -86.78, z = 1001.52, interior = 4, blip = 6 }, 
	ammunation3 = { x = 296.84, y = -112.06, z = 1001.52, interior = 6, blip = 6 },
	ammunation4 = { x = 315.70, y = -143.66, z =  999.60, interior = 7, blip = 6 },
	ammunation5 = { x = 316.32, y = -170.30, z =  999.60, interior = 6, blip = 6 },
	atrium =      { x = 1727.04, y = -1637.84, z = 20.22, interior = 18 },
	bar =         { x = 501.99, y =  -67.56, z =  998.75, interior = 11, blip = 49 },
	bar2 =        { x = -229.3, y = 1401.28, z =   27.76, interior = 18, blip = 49 },
	bar3 =        { x = 1212.12, y = -26.14, z =   1000.99, interior = 3, blip = 49 },
	bar4 =        { x = 681.58, y = -450.89, z =   -25.37, interior = 1, blip = 49 },
	burgershot =  { x = 362.84, y =  -75.13, z = 1001.50, interior = 10, blip = 10 },
	clothes1 =    { x = 207.63, y = -111.26, z = 1005.13, interior = 15, blip = 45 }, -- Binco
	clothes2 =    { x = 204.32, y = -168.85, z = 1000.52, interior = 14, blip = 45 }, -- Pro Laps
	clothes3 =    { x = 207.07, y = -140.37, z = 1003.51, interior = 3, blip = 45 }, -- Didier Sachs
	clothes4 =    { x = 203.81, y =  -50.66, z = 1001.80, interior = 1, blip = 45 }, -- Suburban
	clothes5 =    { x = 227.56, y =   -8.06, z = 1002.21, interior = 5, blip = 45 }, -- Victim
	clothes6 =    { x = 161.37, y =  -97.11, z = 1001.80, interior = 18, blip = 45 }, -- Zip
	club =        { x = 493.50, y =  -24.95, z = 1000.67, interior = 17, blip = 48 },
	club2 =       { x =  -2636.66, y =   1402.36, z = 906.50, interior = 3 },
	cluckinbell = { x = 364.98, y = -11.84, z = 1001.85, interior = 9, blip = 14 },
	diner      =  { x = 460.53, y =  -88.62, z =  999.55, interior = 4, blip = 17 },
	diner2      = { x = 441.90, y =  -49.70, z =  999.74, interior = 6, blip = 17 },
	donut      =  { x = 377.08, y = -193.30, z = 1000.63, interior = 17, blip = 17 },
	electronics = { x = -2240.77, y = 137.20, z = 1035.41, interior = 6 }, -- Zero's RC
	meatfactory = { x = 964.93, y = 2160.09, z = 1011.03, interior = 1 },
	office1 =     { x =   390.76, y =   173.79, z = 1008.38, interior = 3 }, -- City Planning Department
	office2 =     { x = -2026.86, y =  -103.60, z = 1035.18, interior = 3 }, -- Driving School
	office3 =     { x =  1494.36, y =  1303.57, z = 1093.28, interior = 3 }, -- Bike School
	pizza =       { x =   372.33, y =  -133.52, z = 1001.49, interior = 5, blip = 29 },
	sexshop =     { x =  -100.34, y =   -25.03, z = 1000.72, interior = 3 },
	reeces =      { x =  412, y =   -23, z = 1002, interior = 2 },
	barber =      { x =  418.6, y =   -84.17, z = 1001.70, interior = 3 },
	tattoo =      { x =  -204.37, y =   -8.90, z = 1002.26, interior = 17 },
	factory =     { x =  2541.71, y =   -1304.07, z = 1025.08, interior = 2 },
	battlefield = { x =  -977.72, y =   1052.96, z = 1345.22, interior = 10 },
	hallway =     { x =  2266.15, y =   1647.42, z = 1084.29, interior = 1 },
	betting =     { x =  834.78, y =   7.42, z = 1003.97, interior = 3 },
	betting2 =    { x =  -2158.58, y =   643.15, z = 1052.33, interior = 1 },
	motel =       { x =  2214.42, y =   -1150.51, z = 1025.41, interior = 15 },
	gym =         { x =  773.57, y =   -78.12, z = 1000.88, interior = 7 },
	gym2 =        { x =  772.11, y =   -5, z = 1000.42, interior = 5 },
	gym3 =        { x =  774.18, y =   -50.42, z = 1000.60, interior = 6 },
	sex =         { x =  -100.33, y =   -24.94, z = 1000.33, interior = 3 },
	stadium =     { x =  -1426.14, y =   928.44, z = 1036.35, interior = 15 },
	stadium2 =    { x =  -1426.13, y =   44.16, z = 1036.23, interior = 1 },
	stadium3 =    { x =  -1464.72, y =   1555.93, z = 1052.68, interior = 14 },

	concels =    { x =  -1434.078125, y =   -526.91796875, z = 14.272255897522, interior = 122 },


	ayuntamiento =    { x =  -1248.5728759766, y =   -531.73944091797, z = 14.924999237061, interior = 4 },
	prision =    { x =  -24.0166015625, y =   -335.2744140625, z = 2522.4172363281, interior = 4 },
	comisaria =    { x =  -1314.3779296875, y = -536.310546875, z = 16.777500152588, interior = 5 },
	hospitalm =    { x =  -1361.171875, y = -595.4951171875, z = 14.207814216614, interior = 10 },
	parkinghp =    { x =  -1402.56458, y =   -598.75867, z =  14.17031, interior = 24 },
	licenciasls =    { x =  -1434.078125, y =   -526.91796875, z = 14.272255897522, interior = 112 },
	bancols =    { x = -1423.681640625, y =   -543.740234375, z = 14.418314933777, interior = 12},

	--complejo judicial--
	judicialvestibulo =    { x =  -1355.521484375, y = -478.4716796875, z = 15.028020858765, interior = 30 },
	salajudicial1 =    { x =  1572.912109375, y = 1181.5703125, z = 12.018750190735, interior = 30 },
	despachojudicial1 =    { x =  1584.59765625, y = 1200.318359375, z = 13.815625190735, interior = 31 },
	despachojudicial2 =    { x =  1580.2626953125, y = 1197.79296875, z = 12.11562538147, interior = 32 },
	salajudicial2 =    { x =  1572.4228515625, y = 1166.630859375, z = 12.15811920166, interior = 33 },
	salajudicial3 =    { x =  1572.8330078125, y = 1201.1923828125, z = 18.815624237061, interior = 34 },
	salajudicialceldas =    { x =  1590.4938964844, y = 1195.9423828125, z = 11.89999961853, interior = 35 },
	despachojudicial3 =    { x =  1580.2841796875, y = 1197.7919921875, z = 12.11562538147, interior = 36 },
	---
---ilegales
	ilegales1 =    { x =  -1450.0419921875, y =  -523.529296875, z = 14.171875, interior = 4 },


	--radio
	radiobb =    { x =  -1354.54296875, y = -463.939453125, z = 14.25, interior = 36 },
	oficinaradiobb =    { x = -1375.5949707031, y = -525.87658691406, z = 14.651561737061, interior = 35 },

	--solaris
	intsolaris = {x = 1579.15234375, y = -2485.2841796875, z = 19.93593788147, interior=8},
	-- police departments
	lspd = { x = 246.75, y =  62.32, z = 1003.64, interior = 6 },
	sfpd = { x = 246.35, y = 107.30, z = 1003.22, interior = 10 },
	lvpd = { x = 238.72, y = 138.62, z = 1003.02, interior = 3 },
	
	-- INT COMISARIA DILLIMORE GARAJE
	
	garajepddillimore = { x= 1491.765625, y= 1622.0986328125, z=22.393749237061, interior = 10 },
	
	-- COMISARIA SEGUNDO PISO
	comisariasegundopiso = { x= 1470.7216796875, y= 1328.99609375, z= 11.403736114502, interior = 1 },

	
	comisariaoficina1 = { x= -1420.32421875, y= -538.09765625, z= 14.291410446167, interior = 1 },
	
	-- INT BOMBEROS
	intbomberos = { x = 1422.6220703125, y= 1402.93359375, z= 16.100189208984, interior = 1 },
	
	-- INT AYUNTA DE MONTGOMERY
	
	ayuntamontgomery = { x=1467.9306640625, y=1298.5029296875, z=26.74843788147, interior = 20 },
	
	-- INT FERRETERIAS
	ferreteriablueberry = { x=-1328.0458984375, y=-552.333984375, z=14.179900169373, interior = 15 },
	ferreteriamontgomery = { x=-1328.0458984375, y=-552.333984375, z=14.179900169373, interior = 15 },
--Gasbi
	bargasbi = { x=-1438.203125, y=-542.423828125, z=14.231250762939, interior = 0 },

	
	-- GARAJES DEFAULT
	
	garage1 =     { x =  608.15,  y = -10.09, z = 1000.91, interior = 1},
	garage2 =     { x =  612.4, y = -76.48, z = 997.99, interior = 2},
	garage3 =     { x =  611.99, y = -125.43, z = 997.99, interior = 3},
	storage =     { x =  301.81, y = 300.38, z = 999.14, interior = 4},
	warehouse =   { x =  1292.62, y = -0.69, z = 1001.01, interior = 18},
	journey =     { x =  2.05, y = -3.11, z = 999.42, interior = 3 },
	
}
-- dbExec( connection, "UPDATE `cheques_bancarios` SET `activo`=0 WHERE `id`="..numero)
-- local ins = dbQuery( connection, "INSERT INTO cuentas_bancarias (owner, pin, dinero) VALUES (?,?,?)",exports.personajes:getCharID(player), tonumber(pin), 0)
-- 		local result, num_affected_rows, ID = dbPoll ( ins, -1 )

local teleports = {}

function loadInteriors()
	local q = dbQuery( connection, "SELECT * FROM interiores ORDER BY id ASC" )
	local ints = dbPoll( q, -1 )
	for i, d in ipairs (ints) do
	teleports[d.id] = {}
		teleports[d.id].ID = d.id
		teleports[d.id].name = d.name
		teleports[d.id].locked = d.locked
		teleports[d.id].tipo = d.tipo
		if d.forsale == 1 then
			teleports[d.id].showtipo = d.tipo
		else
			teleports[d.id].showtipo = 1
		end
		teleports[d.id].forsale = d.forsale
		teleports[d.id].precio = d.precio
		teleports[d.id].own = d.owner
		teleports[d.id].factionable = d.factionable
		teleports[d.id]["col-out"] = createColSphere ( d.x_out, d.y_out, d.z_out, 1 )
		teleports[d.id]["col-in"] = createColSphere ( d.x_in, d.y_in, d.z_in, 1 )
		setElementData(teleports[d.id]["col-out"], "int_type", teleports[d.id].showtipo)
		setElementData(teleports[d.id]["col-in"], "int_type", teleports[d.id].showtipo)
		setElementData( teleports[d.id]["col-out"], "int_nombre", d.name )
		
		setElementInterior(teleports[d.id]["col-out"], d.interior_out)
		setElementDimension(teleports[d.id]["col-out"],d.dimension_out )
		
		setElementInterior(teleports[d.id]["col-in"], d.interior_in)
		setElementDimension(teleports[d.id]["col-in"],d.dimension_in )
	end
	
	for u, players in ipairs (getElementsByType("player")) do
	bindKey ( players, "e", "down", usartp )
	end
	
end
addEventHandler("onResourceStart", resourceRoot, loadInteriors)

posout = {}

function creartp (player,cmd,tipo,nombre,faccID)
	if tipo then
		if tipo == "1" then
			if not posout[player] then
			posout[player] = {}
			end
			local x,y,z = getElementPosition(player)
			local inte = getElementInterior(player)
			local dime = getElementDimension(player)
			posout[player] = {x,y,z,inte,dime}
			outputChatBox("Posición inicial marcada: "..x..", "..y..", "..z.." INT: "..inte..", DIM: "..dime, player, 0, 200, 0)
			outputChatBox("Usa /creartp 2 [nombre] para crear el teleport en la posición final.",player, 0, 200,0)
		elseif tipo == "2" then
			if posout[player] and posout[player][1] ~= nil then
				local x,y,z = getElementPosition(player)
				local inte = getElementInterior(player)
				local dime = getElementDimension(player)
				if nombre then
				local ins = dbQuery( connection, "INSERT INTO interiores (name,x_out,y_out,z_out,x_in,y_in,z_in,interior_out,dimension_out,interior_in,dimension_in,tipo) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",tostring(nombre),posout[player][1],posout[player][2],posout[player][3],x,y,z,posout[player][4],posout[player][5], inte, dime,1 )
				local result, num_affected_rows, last_insert_id = dbPoll ( ins, -1 )
				outputChatBox("Has creado el teleport correctamente. ID: "..last_insert_id,player, 0, 200,0)
				else
				local ins = dbQuery( connection, "INSERT INTO interiores (name,x_out,y_out,z_out,x_in,y_in,z_in,interior_out,dimension_out,interior_in,dimension_in,tipo) VALUES (?,?,?,?,?,?,?,?,?,?,?)",posout[player][1],posout[player][2],posout[player][3],x,y,z,posout[player][4],posout[player][5], inte, dime,1 )
				local result, num_affected_rows, last_insert_id = dbPoll ( ins, -1 )
				outputChatBox("Has creado el teleport correctamente. ID: "..last_insert_id,player, 0, 200,0)
				end
				local i = getMaxIndex(teleports) +1
				--outputChatBox("Has creado el teleport correctamente. ID: "..i,player, 0, 200,0)
				
		teleports[i] = {}
		teleports[i].ID = i
		teleports[i].name = tostring(nombre)
		teleports[i].facc = 0
		teleports[i].locked = 0
		teleports[i].tipo = 1
		teleports[i].showtipo = 1
		teleports[i].forsale = 0
		teleports[i].precio = 0
		if tonumber(faccID) then
			teleports[i].factionable = 1
			teleports[i].own = faccID
		else
			teleports[i].factionable = 0
			teleports[i].own = 0
		end
		teleports[i]["col-out"] = createColSphere ( posout[player][1], posout[player][2], posout[player][3], 1 )
		teleports[i]["col-in"] = createColSphere ( x,y,z, 1 )
		setElementData(teleports[i]["col-out"], "int_type", 1)
		setElementData(teleports[i]["col-in"], "int_type", 1)
		setElementInterior(teleports[i]["col-out"], posout[player][4])
		setElementDimension(teleports[i]["col-out"],posout[player][5] )
		
		setElementInterior(teleports[i]["col-in"], inte)
		setElementDimension(teleports[i]["col-in"],dime )
		
				
				
				
			else
			outputChatBox("No has marcado una posición inicial.", player, 200,0,0)
			end
		end
	else
	outputChatBox("Syntax: /"..cmd.." [tipo (1-out, 2-in)] [nombre]",player, 255,255,255)
	end
end
addCommandHandler("creartp",creartp)

function getCharacterPropiedades( name )
	local idchar = exports.personajes:getCharIDFromName( name )
	if idchar then
		local q = dbQuery( connection, "SELECT * FROM interiores WHERE owner=? ORDER BY id DESC", tonumber( idchar ) )
		local ints = dbPoll( q, -1 )
		if ints and #ints > 0 then
			return ints
		else
			return {}
		end
	else
		return {}
	end
end

function creartpint (player,cmd,tipo,precio,g,nombre)

	if tipo and nombre and tonumber(precio) and tonumber(g) then
		local interio = interiorPositions[ tipo:lower( ) ]
		if interio then
		local x,y,z = getElementPosition(player)
		local inte = getElementInterior(player)
		local dime = getElementDimension(player)
		if tonumber(g) == 3 or tonumber(g) == 4 then
		local ins = dbQuery( connection, "INSERT INTO interiores (x_out,y_out,z_out,x_in,y_in,z_in,interior_out,dimension_out,interior_in,name,tipo,precio,forsale) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",x,y,z,interio.x,interio.y,interio.z,inte,dime, interio.interior,tostring(nombre),g,tonumber(precio),1)
		local result, num_affected_rows, last_insert_id = dbPoll ( ins, -1 )
		dbExec( connection, "UPDATE `interiores` SET `dimension_in`="..last_insert_id.." WHERE `id`="..last_insert_id.."")
		outputChatBox("Has creado el teleport(interior) correctamente. ID: "..last_insert_id,player, 0, 200,0)
		--dimensionin	
		teleports[last_insert_id] = {}
		teleports[last_insert_id].ID = last_insert_id
		teleports[last_insert_id].name = tostring(nombre)
		teleports[last_insert_id].own = 0
		teleports[last_insert_id].own = 0
		teleports[last_insert_id].facc = 0
		teleports[last_insert_id].locked = 0
		teleports[last_insert_id].tipo = tonumber(g)
		teleports[last_insert_id].showtipo = tonumber(g)
		if tonumber(g) == 3 or tonumber(g) == 4 then
		teleports[last_insert_id].forsale = 1
		else
		teleports[last_insert_id].forsale = 0
		end
		teleports[last_insert_id].precio = tonumber(precio)
		teleports[last_insert_id]["col-out"] = createColSphere ( x,y,z, 1 )
		teleports[last_insert_id]["col-in"] = createColSphere ( interio.x,interio.y,interio.z, 1 )
		setElementData(teleports[last_insert_id]["col-out"], "int_type", tonumber(g))
		setElementData(teleports[last_insert_id]["col-in"], "int_type", tonumber(g))
		
		setElementInterior(teleports[last_insert_id]["col-out"], inte)
		setElementDimension(teleports[last_insert_id]["col-out"],dime )
		
		setElementInterior(teleports[last_insert_id]["col-in"], interio.interior)
		setElementDimension(teleports[last_insert_id]["col-in"],last_insert_id )

		else
		local ins = dbQuery( connection, "INSERT INTO interiores (x_out,y_out,z_out,x_in,y_in,z_in,interior_out,dimension_out,interior_in,name,tipo,precio,forsale) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",x,y,z,interio.x,interio.y,interio.z,inte,dime, interio.interior,tostring(nombre),g,tonumber(precio),0)
		local result, num_affected_rows, last_insert_id = dbPoll ( ins, -1 )
		dbExec( connection, "UPDATE `interiores` SET `dimension_in`="..last_insert_id.." WHERE `id`="..last_insert_id.."")
		outputChatBox("Has creado el teleport(interior) correctamente. ID: "..last_insert_id,player, 0, 200,0)
		--dimensionin	
		teleports[last_insert_id] = {}
		teleports[last_insert_id].ID = last_insert_id
		teleports[last_insert_id].name = tostring(nombre)
		teleports[last_insert_id].own = 0
		teleports[last_insert_id].factionable = 0
		teleports[last_insert_id].facc = 0
		teleports[last_insert_id].locked = 0
		teleports[last_insert_id].tipo = tonumber(g)
		teleports[last_insert_id].showtipo = tonumber(g)
		if tonumber(g) == 3 or tonumber(g) == 4 then
		teleports[last_insert_id].forsale = 1
		else
		teleports[last_insert_id].forsale = 0
		end
		teleports[last_insert_id].precio = tonumber(precio)
		teleports[last_insert_id]["col-out"] = createColSphere ( x,y,z, 1 )
		teleports[last_insert_id]["col-in"] = createColSphere ( interio.x,interio.y,interio.z, 1 )
		setElementData(teleports[last_insert_id]["col-out"], "int_type", tonumber(g))
		setElementData(teleports[last_insert_id]["col-in"], "int_type", tonumber(g))
		
		setElementInterior(teleports[last_insert_id]["col-out"], inte)
		setElementDimension(teleports[last_insert_id]["col-out"],dime )
		
		setElementInterior(teleports[last_insert_id]["col-in"], interio.interior)
		setElementDimension(teleports[last_insert_id]["col-in"],last_insert_id )
		end


		else
		outputChatBox("Tipo de 'interior' no válido.",player, 200,0,0)
		end
	else
	outputChatBox("Syntax: /"..cmd.." [tipo] [precio] [2=gob, 3=venta_casa, 4=venta_negocio] [nombre]",player, 255,255,255)
	end
end
addCommandHandler("crearint",creartpint)



function interior_check(player)
	triggerClientEvent(player, "check:collision", player)
end


gtimer = {} -- Para los vehiculos
gtimerp = {}

function usartp (player, key, keyState)
	for i, tps in pairs (teleports) do
		if isElement(teleports[i]["col-out"]) and isElementWithinColShape (player, teleports[i]["col-out"]) and getElementDimension(player) == getElementDimension(teleports[i]["col-out"]) then
		if teleports[i].forsale == 1 then
			triggerClientEvent(player, "interior:onsale", player, teleports[i].precio, teleports[i].ID)
		elseif teleports[i].locked == 0 then
			if not isPedInVehicle(player) then
				local x,y,z = getElementPosition(teleports[i]["col-in"])
				local inte = getElementInterior(teleports[i]["col-in"])
				local dime = getElementDimension(teleports[i]["col-in"])
				setElementPosition(player, x,y,z)
				setElementInterior(player, inte)
				setElementDimension(player, dime)
				setElementFrozen(player, true)
				triggerClientEvent(player, "check:collision", player)
				setTimer ( function()
				setElementFrozen(player, false)
				end, 1000, 1 )
			else
				local veh = getPedOccupiedVehicle( player )
				if veh then
					if not gtimer[veh] then
						setElementFrozen( veh, true )
						setVehicleLocked( veh, false )
						gtimer[veh] = setTimer( function(v)
							setElementFrozen( v, false )
							for ka = 0, getVehicleMaxPassengers(v) do
								local passag = getVehicleOccupant(v, ka)
								if passag then
									local x,y,z = getElementPosition(teleports[i]["col-in"])									
									warpPedIntoVehicle (passag, v, ka)
									triggerClientEvent(getResourceName(getThisResource()) .. ":fixearMotos", passag, passag)
									setElementPosition( v, x, y, z + 0.5 ) -- Por si se rompe
									setElementInterior( v, getElementInterior(teleports[i]["col-in"]) )
									setElementDimension( v, getElementDimension(teleports[i]["col-in"]) )
									
									setElementInterior( passag, getElementInterior(teleports[i]["col-in"]) )
									setElementDimension( passag, getElementDimension(teleports[i]["col-in"]) )
									setCameraInterior(passag, getElementInterior(teleports[i]["col-in"]))
									setElementPosition(passag, x, y, z)
									setCameraTarget(passag, passag)
								end
							end
							gtimer[veh] = nil
						end, 2000, 1, veh)
					end
				end
			end
		else
		exports.login:addNotification(player, "El acceso está bloqueado.", "error")
		end
		elseif isElement(teleports[i]["col-in"]) and isElementWithinColShape (player, teleports[i]["col-in"]) and getElementDimension(player) == getElementDimension(teleports[i]["col-in"])then
		if teleports[i].locked == 0 then
			if not isPedInVehicle(player) then
				local x,y,z = getElementPosition(teleports[i]["col-out"])
				local inte = getElementInterior(teleports[i]["col-out"])
				local dime = getElementDimension(teleports[i]["col-out"])
				setElementPosition(player, x,y,z)
				setElementInterior(player, inte)
				setElementDimension(player, dime)
				setElementFrozen(player, true)
				triggerClientEvent(player, "check:collision", player)
				setTimer ( function()
				setElementFrozen(player, false)
				end, 1000, 1 )
			else
				local veh = getPedOccupiedVehicle( player )
				if veh then
					if not gtimer[veh] then
						setElementFrozen( veh, true )
						setVehicleLocked( veh, false )
						gtimer[veh] = setTimer( function(v)
							setElementFrozen( v, false )
							for ka = 0, getVehicleMaxPassengers(v) do
								local passag = getVehicleOccupant(v, ka)
								if passag then
									local x,y,z = getElementPosition(teleports[i]["col-out"])					
									triggerClientEvent(getResourceName(getThisResource()) .. ":fixearMotos", passag, passag)									
									warpPedIntoVehicle (passag, v, ka)
									setElementPosition( v, x, y, z + 0.5 ) -- Por si se rompe
									setElementInterior( v, getElementInterior(teleports[i]["col-out"]) )
									setElementDimension( v, getElementDimension(teleports[i]["col-out"]) )
									
									setElementInterior( passag, getElementInterior(teleports[i]["col-out"]) )
									setElementDimension( passag, getElementDimension(teleports[i]["col-out"]) )
									setCameraInterior(passag, getElementInterior(teleports[i]["col-out"]))
									setElementPosition(passag, x, y, z)
									setCameraTarget(passag, passag)
								end
							end
							gtimer[veh] = nil
						end, 2000, 1, veh)
					end
				end
			end
		else
		exports.login:addNotification(player, "El acceso está bloqueado.", "error")
		end
		end
	end
end
addEventHandler("onPlayerJoin", root,
  function()
    bindKey ( source, "e", "down", usartp )
  end
)
function getMaxIndex(tabla)
	local maximo = 0
	for i, elementos in pairs (tabla) do
		if i > maximo then
		maximo = i
		end
	end
	return maximo
end

function neartps (player)
if getElementData(player, "isLoged") and getElementData(player, "staff") >= 3 then
	outputChatBox("Teleports cercanos:", player, 200,200,0)
	outputChatBox("-------------------", player, 200,200,0)
	for i, tps in pairs (teleports) do
		if isElement(teleports[i]["col-out"]) then
			local x1,y1,z1 = getElementPosition(player)
			local x2,y2,z2 = getElementPosition(teleports[i]["col-out"])
			local x3,y3,z3 = getElementPosition(teleports[i]["col-in"])
		if getDistanceBetweenPoints3D (x1,y1,z1,x2,y2,z2) <= 5 or getDistanceBetweenPoints3D (x1,y1,z1,x3,y3,z3) <= 5 then
		outputChatBox("ID: "..teleports[i].ID..", Nombre: "..teleports[i].name,player, 200,200,0)
		end
		end
	end
end
end
addCommandHandler("nearbytps", neartps)

function getPFromID(id)
	for i, tps in pairs (teleports) do
			if teleports[i].ID == tonumber(id) then
			return teleports[i]
			end
	end
end

function deletetp (player, cmd, id)
if getElementData(player, "staff") >= 4 then
	if tonumber(id) then
	dbExec( connection, "DELETE FROM interiores WHERE id=?", id )
	outputChatBox("Has eliminado el teleport con ID: "..id, player, 0, 200,0)
	destroyElement(teleports[tonumber(id)]["col-out"])
	destroyElement(teleports[tonumber(id)]["col-in"])
	teleports[tonumber(id)] = nil
	else
	outputChatBox("Syntax: /"..cmd.." [ID]", player, 255,255,255)
	end
end
end
addCommandHandler("borrartp", deletetp)

function buyProperty(player, price, ID )
	local player_money = exports.personajes:getCharMoney(player)
	if teleports[tonumber(ID)].forsale == 1 then
		if player_money >= price then
			if exports.items:tienehueco(player) then
				dbExec( connection, "UPDATE `interiores` SET `owner`="..exports.personajes:getCharID(player)..", `tipo`=1, `forsale`=0 WHERE `id`="..ID.."")
				setElementData(teleports[tonumber(ID)]["col-out"], 'int_type', 1)
				setElementData(teleports[tonumber(ID)]["col-in"], 'int_type', 1)
				teleports[tonumber(ID)].forsale = 0
				teleports[tonumber(ID)].own = exports.personajes:getCharID(player)
				teleports[tonumber(ID)].tipo = 1
				exports.personajes:takeCharMoney(player, tonumber(price))
				outputChatBox("Felicidades, has comprado la propiedad con ID: "..ID, player, 0, 200,0)
				exports.items:darItem(player, 13, tonumber(ID))
			else
				outputChatBox("No tienes espacio para recibir las llaves de la propiedad.", player, 200,0,0)
			end

		else
			outputChatBox("No tienes suficiente dinero para comprar esta propiedad", player, 200,0,0)
		end
	else
		outputChatBox("Alguien ya ha comprado esta propiedad", player, 200,0,0)
	end
end
addEvent("interior:buy", true)
addEventHandler("interior:buy", root, buyProperty)

function usarLlaves( player, ID )
if teleports[ID] ~= nil then
	if isElement(teleports[ID]["col-out"]) and isElementWithinColShape (player, teleports[ID]["col-out"]) and getElementDimension(player) == getElementDimension(teleports[ID]["col-out"]) then
		if teleports[ID].locked == 0 then
			teleports[ID].locked = 1
			dbExec( connection, "UPDATE `interiores` SET `locked`=1 WHERE `id`="..ID.."")
			exports.chatsystem:sendame(player, "Cierra la puerta de la propiedad usando sus llaves")
		else
			teleports[ID].locked = 0
			dbExec( connection, "UPDATE `interiores` SET `locked`=0 WHERE `id`="..ID.."")
			exports.chatsystem:sendame(player, "Abre la puerta de la propiedad usando sus llaves")
		end
	elseif isElement(teleports[ID]["col-in"]) and isElementWithinColShape (player, teleports[ID]["col-in"]) and getElementDimension(player) == getElementDimension(teleports[ID]["col-in"])then
		if teleports[ID].locked == 0 then
			teleports[ID].locked = 1
			dbExec( connection, "UPDATE `interiores` SET `locked`=1 WHERE `id`="..ID.."")
			exports.chatsystem:sendame(player, "Cierra la puerta de la propiedad usando sus llaves")
		else
			teleports[ID].locked = 0
			dbExec( connection, "UPDATE `interiores` SET `locked`=0 WHERE `id`="..ID.."")
			exports.chatsystem:sendame(player, "Abre la puerta de la propiedad usando sus llaves")
		end
	end
end
end

function abrirInterior( player )
	for i, tps in pairs (teleports) do
		if isElement(teleports[i]["col-out"]) and isElementWithinColShape (player, teleports[i]["col-out"]) and getElementDimension(player) == getElementDimension(teleports[i]["col-out"]) then
			if teleports[i].factionable == 1 then
				local factions = exports.facciones:getPlayerFaction(player)
				if teleports[i].own == factions[1] or teleports[i].own == factions[2] then
					if teleports[i].locked == 0 then
						teleports[i].locked = 1
						dbExec( connection, "UPDATE `interiores` SET `locked`=1 WHERE `id`="..i.."")
						exports.chatsystem:sendame(player, "Cierra la puerta de la propiedad usando sus llaves")
					else
						teleports[i].locked = 0
						dbExec( connection, "UPDATE `interiores` SET `locked`=0 WHERE `id`="..i.."")
						exports.chatsystem:sendame(player, "Abre la puerta de la propiedad usando sus llaves")
					end
				end
 			end
 		elseif isElement(teleports[i]["col-in"]) and isElementWithinColShape (player, teleports[i]["col-in"]) and getElementDimension(player) == getElementDimension(teleports[i]["col-in"]) then
			if teleports[i].factionable == 1 then
				local factions = exports.facciones:getPlayerFaction(player)
				if teleports[i].own == factions[1] or teleports[i].own == factions[2] then
					if teleports[i].locked == 0 then
						teleports[i].locked = 1
						dbExec( connection, "UPDATE `interiores` SET `locked`=1 WHERE `id`="..i.."")
						exports.chatsystem:sendame(player, "Cierra la puerta de la propiedad usando sus llaves")
					else
						teleports[i].locked = 0
						dbExec( connection, "UPDATE `interiores` SET `locked`=0 WHERE `id`="..i.."")
						exports.chatsystem:sendame(player, "Abre la puerta de la propiedad usando sus llaves")
					end
				end
 			end
		end
	end
end
addCommandHandler("puertafaccion",abrirInterior)
function getInteriorID( player )
	for i,v in pairs(teleports) do
		if getElementDimension(v["col-in"]) == getElementDimension(player) and getElementInterior(v["col-in"]) == getElementInterior(player) then
			return v
		end
	end
	return false
end

-- muebles

function abrirPanelMuebles( player )
	local v = getInteriorID(player)
	if v then
		if v.own == exports.personajes:getCharID(player) then
			if v.tipo == 1 then
				outputChatBox("amueblando")
			else
				exports.login:addNotification(player, "No puedes amueblar esta propiedad", "error")
			end
		else
			exports.login:addNotification(player, "Esta no es tu propiedad", "error")
		end
	end
end
addCommandHandler('amueblar', abrirPanelMuebles)
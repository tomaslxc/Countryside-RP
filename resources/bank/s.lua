local connection = exports.mysql:connect()

function loadBanks()
	local query = dbQuery( connection, "SELECT * FROM banks ORDER BY id ASC" )
	local data = dbPoll(query, -1)
	for i, bank in ipairs (data) do
		spawnBank(bank)
	end
end
addEventHandler ( "onResourceStart", resourceRoot, loadBanks )

function spawnBank( bank )
	if bank.tipo == 1 then --PED
		local ped = createPed(bank.skin, bank.x, bank.y, bank.z, bank.rotz)
		setElementDimension(ped, bank.dimension)
		setElementInterior(ped, bank.interior)
		addEventHandler( "onElementClicked", ped, openBank )
		local bank_array = {
			id = bank.id,
			name = bank.name,
			tipo = bank.tipo
		}
		setElementData(ped, "bankArray", bank_array)
		setElementFrozen(ped, true)
	else--ATM
		local atm = createObject ( 2942,bank.x,bank.y,bank.z-0.3,bank.rotx,bank.roty,bank.rotz)
		setElementDimension(atm, bank.dimension)
		setElementInterior(atm, bank.interior)
		addEventHandler( "onElementClicked", atm, openBank )
		local bank_array = {
			id = bank.id,
			tipo = bank.tipo,
			obj = atm
		}
		setElementData(atm, "bankArray", bank_array)
	end
end

function crearBank(player, cmd, tipo, nombre, skin )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if nombre and tipo and skin then
				local x,y,z = getElementPosition(player)
				local rx,ry,rz = getElementRotation(player)
				local ins = dbQuery( connection, "INSERT INTO banks (tipo,name,skin,x,y,z,rotx,roty,rotz,interior,dimension) VALUES (?,?,?,?,?,?,?,?,?,?,?)",tonumber(tipo),nombre,skin,x,y,z,rx,ry,rz,getElementInterior(player),getElementDimension(player))
				local result, num_affected_rows, ID = dbPoll ( ins, -1 )
				if tonumber(tipo) == 1 then
					local ped = createPed(skin, x, y, z, rz)
					setElementDimension(ped, getElementDimension(player))
					setElementInterior(ped, getElementInterior(player))
					addEventHandler( "onElementClicked", ped, openBank )
					local bank_array = {
						id = tonumber(ID),
						name = nombre,
						tipo = tonumber(tipo)
					}
					setElementData(ped, "bankArray", bank_array)
					setElementFrozen(ped, true)
					outputChatBox("Has creado un banquero cajero ID "..ID,player,0,200,0)
				elseif tonumber(tipo) == 0 then
					local atm = createObject ( 2942,x,y,z-0.3,rx,ry,rz)
					setElementDimension(atm, getElementDimension(player))
					setElementInterior(atm, getElementInterior(player))
					addEventHandler( "onElementClicked", atm, openBank )
					local bank_array = {
						id = ID,
						tipo = tonumber(tipo),
						obj = atm
					}
					setElementData(atm, "bankArray", bank_array)
					outputChatBox("Has creado un nuevo cajero ID "..ID,player,0,200,0)
				end
				
			else
				outputChatBox("Syntax:/crearbanco [tipo(1 = banco, 0 = atm)] [nombre] [skin]",player,255,255,255)
			end
		end
	end
end
addCommandHandler("crearbanco", crearBank)

function borrarATM( player,cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if tonumber(id) then
			for i,v in ipairs(getElementsByType("object")) do
				if getElementData(v, "bankArray") then
					local d = getElementData(v, "bankArray")
					if d.id == tonumber(id) then
						if tonumber( d.tipo ) == 0 then
							outputChatBox("Has borrado el cajero ID "..id.." correctamente", player, 0, 200,0)
							dbExec(connection,"DELETE FROM banks WHERE id=?", tonumber(id))
							if isElement( v ) then destroyElement( v ) end
						end
					end
				end
			end
			else
				outputChatBox("Syntax: /"..cmd.." [ID]",player,255,255,255)
			end
		end
	end
end
addCommandHandler("borraratm", borrarATM)

function borrarBank( player,cmd, id )
	if getElementData(player, "isLoged") and getElementData(player, "staff") then
		if getElementData(player, "staff") >= 4 then
			if tonumber(id) then
			dbExec(connection,"DELETE FROM banks WHERE id=?", tonumber(id))
			for i,v in ipairs(getElementsByType("ped")) do
				if getElementData(v, "bankArray") then
					local d = getElementData(v, "bankArray")
					if d.id == tonumber(id) then
						if tonumber(d.tipo) == 1 then
						destroyElement(v)
						outputChatBox("Has borrado el banco ID "..id.." correctamente", player, 0, 200,0)
						elseif tonumber(d.tipo) == 0 then
							destroyElement(d.obj)
							outputChatBox("Has borrado el cajero ID "..id.." correctamente", player, 0, 200,0)
						end
					end
				end
			end
			else
				outputChatBox("Syntax: /borrarbanco [ID]",player,255,255,255)
			end
		end
	end
end
addCommandHandler("borrarbanco", borrarBank)

function getCuentasBancarias( player )
	local query = dbQuery( connection, "SELECT * FROM cuentas_bancarias WHERE owner=?", exports.personajes:getCharID(player) )
	local data = dbPoll(query, -1)
	return data
end

function getRegistrosBancarios( cuenta )
	local query = dbQuery( connection, "SELECT * FROM registros_bancarios WHERE id_cuenta_bancaria=?", tonumber(cuenta))
	local data = dbPoll(query, -1)
	return data
end

function tieneSueldoPendiente( player )
	local query = dbQuery( connection, "SELECT * FROM pagos_facciones WHERE character_id=?", exports.personajes:getCharID(player))
	local data = dbPoll(query, -1)
	if data[1] ~= nil then
		local total = 0
		for i,v in ipairs(data) do
			total = total + v.amount
		end
		return total
	else
		return false
	end

end

function openBank( button, state, player )
	if button == "left" and state == "down" then
		local x,y,z = getElementPosition(player)
		local x1,y1,z1 = getElementPosition(source)
		if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 5 then
			local sueldoPendiente = tieneSueldoPendiente(player)
			local cuentas_usuario = getCuentasBancarias(player)
			local bank_array = getElementData(source, "bankArray")
			triggerClientEvent(player, "bank:open", player, bank_array, cuentas_usuario,sueldoPendiente)
		end
	elseif button == "right" and state == "down" then
		if getElementData(player, "staff") >= 3 then
			local bank_array = getElementData(source, "bankArray")
			outputChatBox("ID de este banco/cajero: "..bank_array.id,player,0,200,0)
		end
	end
end

function crearBankAccount( player,  pin )
	if validarPIN(pin) then
		if exports.items:tienehueco(player, 18) then
		local ins = dbQuery( connection, "INSERT INTO cuentas_bancarias (owner, pin, dinero) VALUES (?,?,?)",exports.personajes:getCharID(player), tonumber(pin), 0)
		local result, num_affected_rows, ID = dbPoll ( ins, -1 )
			exports.items:darItem(player, 18, tonumber(ID))
			exports.login:addNotification(player, "Cuenta creada correctamente. Nº: #"..ID..", PIN: "..pin, "success")
		else
			exports.login:addNotification(player, "No tienes hueco en tus bolsillos como para darte tu tarjeta.", "error")
		end
	else
		exports.login:addNotification(player, "El PIN introducido no es válido. Tiene que ser un número de 4 dígitos.", "error")
	end
end
addEvent("crear:bank_account", true)
addEventHandler("crear:bank_account", root, crearBankAccount)

function cobrarCheque( player, numero, cuenta )
	if exports.items:itemHas(player, 19, numero) then
		local query = dbQuery( connection, "SELECT * FROM cheques_bancarios WHERE id=?", numero )
		local data = dbPoll(query, -1)
		if data[1] ~= nil then
			if data[1].activo == 1 then
				dbExec( connection, "UPDATE `cheques_bancarios` SET `activo`=0 WHERE `id`="..numero)
				dbExec( connection, "UPDATE `cuentas_bancarias` SET `dinero`=`dinero`+? WHERE `id`="..cuenta, data[1].cantidad)
				exports.items:deleteItem(player, 19, tonumber(numero))
				exports.login:addNotification(player, "Cheque canjeado correctamente.", "success")
				local date = getRealTime()
				local date = {date.monthday, date.month, 1900+date.year, date.hour, date.minute}
				local ins = dbQuery( connection, "INSERT INTO registros_bancarios (id_cuenta_bancaria, operacion, cantidad, concepto, fecha) VALUES (?,?,?,?,?)", cuenta, "Cheque\n(#"..data[1].cuenta..")", data[1].cantidad, "Cheque cobrado", toJSON(date))
				dbFree(ins)
			else
				exports.login:addNotification(player, "Este cheque ya ha sido canjeado o está desactivado.", "error")
			end
		else
			exports.login:addNotification(player, "Este cheque no es válido.", "error")
		end
	else
		exports.login:addNotification(player, "No tienes este cheque.", "error")
	end
end
addEvent("cobrar:cheque", true)
addEventHandler("cobrar:cheque", root, cobrarCheque)

function retirarDinero( player, cuenta, dinero, concepto )
	local query = dbQuery( connection, "SELECT * FROM cuentas_bancarias WHERE id=?", cuenta )
	local datacuenta = dbPoll(query, -1)
	if tonumber(dinero) and tonumber(dinero) > 0 then
		if datacuenta[1].dinero >= dinero then
			dbExec( connection, "UPDATE `cuentas_bancarias` SET `dinero`=`dinero`-? WHERE `id`="..cuenta, dinero)
			local date = getRealTime()
			local date = {date.monthday, date.month, 1900+date.year, date.hour, date.minute}
			local ins = dbQuery( connection, "INSERT INTO registros_bancarios (id_cuenta_bancaria, operacion, cantidad, concepto, fecha) VALUES (?,?,?,?,?)", cuenta, "Retirada", (dinero)*(-1), concepto, toJSON(date))
			dbFree(ins)
			exports.personajes:addCharMoney(player, dinero)
			triggerClientEvent(player, "confirmar:operacion", player)
			exports.login:addNotification(player, "La retirada se ha efectuado con éxito.", "success")
		else
			exports.login:addNotification(player, "Esta cuenta no tiene suficiente dinero.", "error")
			outputChatBox("No podéis sacar dinero varias personas a la vez.", player, 200,0,0)
			triggerClientEvent(player, "confirmar:operacion", player)
		end
	end
end
addEvent("retirar:dinero", true)
addEventHandler("retirar:dinero", root, retirarDinero)

function depositarDinero( player, cuenta, dinero, concepto )
	local pmoney = exports.personajes:getCharMoney(player)
	if tonumber(dinero) and tonumber(dinero) > 0 then
		if pmoney >= dinero then
			dbExec( connection, "UPDATE `cuentas_bancarias` SET `dinero`=`dinero`+? WHERE `id`="..cuenta, dinero)
			local date = getRealTime()
			local date = {date.monthday, date.month, 1900+date.year, date.hour, date.minute}
			local ins = dbQuery( connection, "INSERT INTO registros_bancarios (id_cuenta_bancaria, operacion, cantidad, concepto, fecha) VALUES (?,?,?,?,?)", cuenta, "Depósito", dinero, concepto, toJSON(date))
			dbFree(ins)
			exports.personajes:takeCharMoney(player, dinero)
			triggerClientEvent(player, "confirmar:operacion", player)
			exports.login:addNotification(player, "El depósito se ha efectuado con éxito.", "success")
		else
			exports.login:addNotification(player, "No tienes esa cantidad de dinero.", "error")
		end
	end
end
addEvent("depositar:dinero", true)
addEventHandler("depositar:dinero", root, depositarDinero)

function cambiarPIN( player, pin, cuenta )
	dbExec( connection, "UPDATE `cuentas_bancarias` SET `pin`=? WHERE `id`="..cuenta, tonumber(pin))
	exports.login:addNotification(player, "PIN cambiado correctamente.", "success")
end
addEvent("cambiar:pin", true)
addEventHandler("cambiar:pin", root, cambiarPIN)

function entregarTarjeta( player, cuenta )
	local money = exports.personajes:getCharMoney(player)
	if money >= 100 then
		exports.items:darItem(player, 18, tonumber(cuenta))
		exports.login:addNotification(player, "Tarjeta entregada correctamente.", "success")
		exports.personajes:takeCharMoney(player, 100)
	else
		exports.login:addNotification(player, "No tiene suficiente dinero en efectivo como para recibir una tarjeta nueva.", "error")
	end
end
addEvent("entregar:tarjeta", true)
addEventHandler("entregar:tarjeta", root, entregarTarjeta)

function actualizarMovs( player, cuenta )
	local data = getRegistrosBancarios(tonumber(cuenta))
	triggerClientEvent(player, "actualizarC:movs", player, data)
end
addEvent("actualizar:movs", true)
addEventHandler("actualizar:movs", root, actualizarMovs)
--auxiliares--

function validarPIN( pin )
	if tonumber(pin) then
		if #pin == 4 and tonumber(pin) > 0 and #(tostring(math.floor(pin))) == 4 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function validarPINTarjeta( player, cuenta, pin, focus )
	local query = dbQuery( connection, "SELECT * FROM cuentas_bancarias WHERE id=?", tonumber(cuenta) )
	local data = dbPoll(query, -1)
	if #data > 0 then
		if data[1].pin == tonumber(pin) then
			triggerClientEvent(player, "acceder:tarjeta", player, focus, data[1].dinero )
		else
			exports.login:addNotification(player, "El PIN introducido no corresponde con el PIN de esta tarjeta.", "error")
		end
	else
		exports.login:addNotification(player, "La cuenta bancaria vinculada a esta tarjeta no está disponible.", "error")
	end
end
addEvent("check:tarjetapin", true)
addEventHandler("check:tarjetapin", root, validarPINTarjeta)

function cobrarSueldoFaccion( player, amount )
	if tonumber(amount) then
		exports.personajes:addCharMoney(player, tonumber(amount))
		exports.login:addNotification(player,"Has cobrado el sueldo de tus facciones", "success")
		dbExec(connection, "DELETE FROM pagos_facciones WHERE character_id=?", exports.personajes:getCharID(player))
	end
end
addEvent("cobrar:sueldo",true)
addEventHandler("cobrar:sueldo", root, cobrarSueldoFaccion)
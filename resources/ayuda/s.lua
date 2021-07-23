local connection = exports.mysql:connect()
function posicion(p)
	local x,y,z = getElementPosition(p)
	local int, dim = getElementInterior(p), getElementDimension(p)
	outputChatBox(x..", "..y..", "..z, p, 255,255,255)
	outputChatBox( "Interior: "..int, p, 255, 255, 255 )
	outputChatBox( "Dimension: "..dim, p, 255, 255, 255 )
end
addCommandHandler("getpos", posicion)

function vertiemporeal( p )
	local time = getRealTime()
	outputChatBox(time.hour..":"..time.minute..":"..time.second,p,255,255,255)
end
addCommandHandler("realtime", vertiemporeal)

--- PAYDAY --

function getImpuestos()
	local imps = exports.gobierno:getImpuestosSobre('sueldos')
	if imps then
		return imps
	else
		return false
	end
end

	setTimer ( function()
		local time = getRealTime()
		if tonumber(time.hour) == 18 and tonumber(time.minute) == 0 and tonumber(time.second) == 0 then
			exports.facciones:pagarSueldos()
			dbExec(connection, "UPDATE `personajes` SET `farmeado`=0")
			for i,v in ipairs(getElementsByType("player")) do
				local impuestos = getImpuestos()
				setElementData(v, "farmeado", 0)
				outputChatBox("---- PAYDAY ----",v,74,145,140)
				outputChatBox("     - Ganado en trabajos: $"..getElementData(v, "farmeado"),v,255,255,255)
				outputChatBox("     - Sueldo faccionario enviado al banco.",v,255,255,255)
				if impuestos then
					outputChatBox( "    - Impuestos cobrados: ", v, 255, 255, 255 )
					for k=1, #impuestos do 
						local imp = impuestos[k]
						if imp.porcentaje == 1 then
							outputChatBox( "       - "..imp.cantidad.."% sobre el sueldo.", v,  255, 255, 255 )
						else
							outputChatBox( "       - "..imp.cantidad.."$ sobre el sueldo.", v,  255, 255, 255 )
						end
					end
				end
				outputChatBox("------------",v,74,145,140)
			end
		end
	end, 1000, 0 )

	function verfarmeo( player )
		outputChatBox("(( Has farmeado un total de "..getElementData(player,"farmeado").."$ ))",player,200,200,50)
	end
	addCommandHandler("verfarmeado",verfarmeo)

	function verjob( player )
		outputChatBox(getElementData(player,"trabajo"),player,200,0,0)
	end
	addCommandHandler("verjob",verjob)

	function pasd( player )
	if getElementData(player, "staff") == 6 then
	
	outputChatBox("Se han pagado los sueldos",player,0,200,0)
	end
	end
	addCommandHandler("pasd", pasd)



-- local objtoremove = {9934,9933,9932,9886,6196,6195,6194,6193,6192,5059,5058,5057,4222,4221,4220,4219,4218,4217,
-- 4216,4215,4214,4213,4212,13493,13485,13484,13461,10147,10146,10058,10057,4715,4716,4717,4720,4721,4722,4723,4725,4739,
-- 4740,4741,4742,4743,4744,4745,4746,4747,4748,4749,4750,4751,4752,5661,5662,5665,5990,5991,5992,
-- 7206,7207,7208,7221,7222,7280,7333,9088,9089,9125,9154,9277,9278,9279,9280,9281,9282,9283,9885,
--  8502,9159,7233,8981,14628,3437,8371,8370,17957,17956,17955,17954,9129,9128,9127,9126,
-- 9124,9123,9122,9121,8372,7944,7943,7942,7892,7332,7331,7226,7097,14561,14811,7268,9094,9095,11412,11411,11410,11324,14605,
-- 14473,14470,14460,14406,7290,7314,7289,7266,7264,7220,7072,8395,9104,9175,8982,7666,7230,9100,9101,8840,7232}

-- for _,obj in ipairs (objtoremove) do
-- removeWorldModel (obj, 10000, 0, 0, 0)
-- end

--Luz de Palomino Creek
removeWorldModel (13461,100000,0,0,0)

--Luz del taller de Dillimore
removeWorldModel (13484,100000,0,0,0)

--Luz del edificio quemado en frente del ayuntamiento Montgomery
removeWorldModel (13485,100000,0,0,0)
removeWorldModel (13009,100000,0,0,0)


--for i=13000,13001 do
--  removeWorldModel(i,200,1317.6497802734,392.69580078125,25.143299102783)
--end




-- function consoleSetFightingStyle ( thePlayer, commandName, id )
-- 	if thePlayer and id then                                                     -- If player and ID are specified
-- 		local status = setPedFightingStyle ( thePlayer, tonumber(id) )       -- set the fighting style
-- 		if not status then                                                   -- if that failed
-- 			outputConsole ( "Failed to set fighting style.", thePlayer ) -- show a message
-- 		end
-- 	end
-- end
-- addCommandHandler ( "setstyle",  consoleSetFightingStyle )
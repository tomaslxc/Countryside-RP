local localPlayer = getLocalPlayer()
local drugMessages = { "¡Que te follen tio!", "Tio, ¡Estas volando!", "Eh tio, ¿Quieres mas drogas?", "¡Gilipolllas!", "Tio, ¿Estas bien?, pareces un poco restrasado", "¡Es impresentable ver a tipos como tú!", "¿Que haces tio?, ¡Estas loco!", "¡Voy a llamar a la policia!" }
 
function doRandomMessage()
	local x, y, z = getElementPosition(localPlayer)
	local colSphere = createColSphere(x, y, z, 10)
	for key, value in ipairs(getElementsByType("player")) do
		if (value~=localPlayer) then
			local px, py , pz = getElementPosition(value)
			if (getDistanceBetweenPoints3D(x, y, z, px, py, pz)<15) then
				local rand2 = math.random(1, #drugMessages)
				local charname = getPlayerName(value)
				charname = string.gsub(tostring(charname), "_", " ")
				outputChatBox("[Inglés] " .. charname .. " dice: " .. drugMessages[rand2], 255, 255, 255)
				break
			end
		end   
	end
end

count = 0
function createRandomPeds()
	if count < 8 then
		local x, y, z = getElementPosition(localPlayer)
		local rand1 = math.random(10, 40)
		local rand2 = math.random(10, 40)
		peds[count] = createPed(264, x+rand1, y+rand2, z)
		count = count + 1
		setTimer(function (count) givePedWeapon ( peds[count], 31, 500, true ) setPedControlState(peds[count], "fire", true) end, 2000, 1, peds[count])	
	end
end

drug1effect = false
drug1timer = nil
function doDrug1Effect()
		drug1effect = true
		weather = getWeather()
		setSkyGradient(0, 255, 245, 0, 0, 255)
		drug1timer = setTimer(resetDrug1Effect, 180000, 1)
		soundDrug1 = playSound ( "https://dl.dropbox.com/s/l5nb41i6wh506iq/Martin%20Jensen%20-%20S%C3%AD.mp3?dl=0", false )
		menosvida = setTimer(function () setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer())-5) end, 5000, 7)
		masvida = setTimer(function() setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer())+3) end, 7500, 7)
		masvelocidad = setTimer(function () setGameSpeed(1.2) end, 5000, 0)
		menosvelocidad = setTimer(function () setGameSpeed(0.8) end, 7500, 0)
		triggerServerEvent("onAme", getLocalPlayer(), getLocalPlayer(), getPlayerName(getLocalPlayer()):gsub("_", " "), "Te notas algo agobiado, bastante nervioso, impulsivo y agresivo")
		outputChatBox ("Esta droga dura 3 minutos, recuerda tener algo de comida para recuperar tu vida. Corres peligro de muerte.")
end

addEvent ("droga.extasis", true)
addEventHandler("droga.extasis", getRootElement(), doDrug1Effect)

function resetDrug1Effect()
	drug1effect = false
	killTimer ( masvelocidad )
	killTimer ( menosvelocidad )
	setGameSpeed(1)
	resetSkyGradient()
end

drug2effect = false
drug2timer = nil
function doDrug2Effect()
		drug2effect = true
		color1 = setTimer(function () setSkyGradient( 64, 64, 64, 255, 128, 0 ) end, 1000, 0)
		color2 = setTimer(function () setSkyGradient( 255, 128, 0, 64, 64, 64 ) end, 2000, 0)
		drug2timer = setTimer(resetDrug2Effect, 240000, 1)
		soundDrug2 = playSound ( "https://dl.dropbox.com/s/wg0qpe2c59rqply/System%20Of%20A%20Down%20-%20Chop%20Suey%21.mp3?dl=0", false )
		setGameSpeed(1.1)
		setGravity (0.005)
		setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer())-5)
		triggerServerEvent("onAme", getLocalPlayer(), getLocalPlayer(), getPlayerName(getLocalPlayer()):gsub("_", " "), "Puedes sentirte bastante violento, nervioso, impulsivo y bastante ansioso")
		outputChatBox ( "Esta droga dura 4 minutos", 255, 0, 0 )
end
addEvent ("droga.metanfetamina", true)
addEventHandler("droga.metanfetamina", getRootElement(), doDrug2Effect)

function resetDrug2Effect()
	drug2effect = false
	killTimer ( color1 )
	killTimer ( color2 )	
	stopSound ( soundDrug2 )
	resetSkyGradient()
	setGameSpeed(1)
	setGravity (0.008)
end

drug3effect = false
drug3timer = nil
function doDrug3Effect()
		drug3effect = true
		weather = getWeather(21)
		setSkyGradient(255, 0, 0, 0, 255, 0)
		drug3timer = setTimer(resetDrug3Effect, 60, 1)
		soundDrug3 = playSound ( "https://dl.dropbox.com/s/6dvl7akrw0yiz1m/Ziggy%20Marley%20Video-%20Love%20is%20My%20Religion.mp3?dl=0", false )
		setGameSpeed(0.8)
		outputChatBox ( "Puedes sentirte adormilado, con la boca seca y pastosa junto a un ligero apetito.", 0, 77, 5  )
		masvida = setTimer(function() setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer())+10) end, 7500, 7)

end
addEvent ("droga.marihuana", true)
addEventHandler("droga.marihuana", getRootElement(), doDrug3Effect)

function resetDrug3Effect()
	drug3effect = false
	killTimer ( drug3timer )
	stopSound ( soundDrug3 )
	resetSkyGradient()
	setGameSpeed(1)
	triggerServerEvent("onAme", getLocalPlayer(), getLocalPlayer(), getPlayerName(getLocalPlayer()):gsub("_", " "), "Puedes sentirte con dolor de cabeza y algo mas cansado")
	setElementData(getLocalPlayer(), "cansancio", tonumber(getElementData(getLocalPlayer(), "cansancio")-40))
end
drug4effect = false
drug4timer = nil

function doDrug4Effect()
		peds = { }
		drug4effect = true
		setSkyGradient(255, 128, 255, 255, 128, 255)
		drug4timer = setTimer(resetDrug4Effect, 180000, 1)
		setGameSpeed(0.8)
		soundDrug2 = playSound ( "https://dl.dropbox.com/s/6b3hlyc8tjwf8ce/Circus%20Theme%20music.mp3?dl=0" )		
		addEventHandler("onClientRender", getRootElement(), createRandomPeds)
end
addEvent ("droga.seta", true)
addEventHandler("droga.seta", getRootElement(), doDrug4Effect)

 
function resetDrug4Effect()
	drug4effect = false
	resetSkyGradient()
	setTimer(setWeather, 100, 1, getWeather())
	setGameSpeed(1)
	removeEventHandler("onClientRender", getRootElement(), createRandomPeds)
	if peds then
		for key, value in ipairs(peds) do
			destroyElement(value)
		end
	end
	peds = nil
end
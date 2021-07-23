function curar( player, cmd, otherPlayer )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 1 or factions[2] == 1 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other then
					local x,y,z = getElementPosition(player)
					local x1,y1,z1 = getElementPosition(other)
					if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) <= 3 then
						setElementHealth(other, 100)
						outputChatBox("Has curado correctamente a "..string.gsub( getPlayerName(other),"_"," " ),player, 0,200,0)
						outputChatBox(string.gsub( getPlayerName(player),"_"," " ).." te ha curado correctamente",other, 0,200,0)
					end
				end
			else
				outputChatBox("Syntax:/"..cmd.." [ID/Jugador] -- recuerda hacer una factura",player, 255,255,255)
			end
		end
	end
end
addCommandHandler("curar", curar)

function uniforme( player )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 1 or factions[2] == 1 then
				local ropadata = exports.personajes:getPlayerRopaData(player)
					exports.personajes:actualizarRopa(player, 120, 0)
					exports.personajes:actualizarRopa(player, 27, 2)
					exports.personajes:actualizarRopa(player, 95, 3)
		end
	end
end
addCommandHandler("uniforme", uniforme)


function reanimar( player, cmd, otherPlayer )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 1 or factions[2] == 1 then
			if otherPlayer then
				local other, name = exports.login:getNID( player, otherPlayer )
				if other  then
					local x,y,z = getElementPosition(player)
					local x1,y1,z1 = getElementPosition(other)
					if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) <= 3 then
						if isElement( other ) and getElementData( other, "isLoged" ) and isPedDead( other ) then
							if getElementModel(other) == 0 then
								--1048.9755859375, -313.3125, 76.503540039062
								if getElementData(other, "arrestado") then
									spawnPlayer ( other, x1,y1,z1, 0, 0, 0,0 )
								else
									spawnPlayer ( other, x1,y1,z1, 0, 0, 0,0 )
								end
								setElementData(other, "sed", 100)
								setElementData(other, "cansancio", 100)
								setElementData(other, "hambre", 100)
								setPedHeadless(other, true)
								fadeCamera( other, true )
								setCameraTarget( other, other )
								setCameraInterior( other, 0 )
								setElementHealth(other, 5)
							else
								if getElementData(other, "arrestado") then
									spawnPlayer ( other, x1,y1,z1, 0, getElementModel(other), 0,0 )
								else
									spawnPlayer ( other, x1,y1,z1, 0, getElementModel(other), 0,0 )
								end
								setElementData(other, "sed", 100)
								setElementData(other, "cansancio", 100)
								setElementData(other, "hambre", 100)
								fadeCamera( other, true )
								setCameraTarget( other, other )
								setCameraInterior( other, 0 )
								setElementHealth(other, 5)
							end
						setPedAnimation(other, "crack", "crckidle2", -1, false, true, true)
						outputChatBox("Has reanimado correctamente a "..string.gsub( getPlayerName(other),"_"," " ),player, 0,200,0)
						outputChatBox(string.gsub( getPlayerName(player),"_"," " ).." te ha reanimado. Pero estás muy débil.",other, 0,200,0)
						end
					end
				end
			else
				outputChatBox("Syntax:/"..cmd.." [ID/Jugador]",player, 255,255,255)
			end
		end
	end
end
addCommandHandler("reanimar", reanimar)

camillas={}
function quitarcamilla(player)
	if not isPedInVehicle ( player ) then
	local nombreplayer = getPlayerName(player)
	local factions = exports.facciones:getPlayerFaction(player)
		if factions then
			if factions[1] == 1 or factions[2] == 1 then
				if isElement(camillas[player]) then
				destroyElement(camillas[player])
				setPedAnimation (player)
				exports.chatsystem:sendame(player, "Pliega la camilla y la guarda en la ambulancia.")
				end
			end
		end
	end
end
addCommandHandler('quitarcamilla',quitarcamilla)

function togglePersonaSubida( mouseButton, buttonState, player )
if mouseButton == "left" and buttonState == "down" then
	if getElementData(source, "paciente") and not isElement(camillas[player]) then
		local paciente = getElementData(source, "paciente")
		if paciente == player then
			-- outputChatBox("Te has bajado de la camilla.",player, 250,200,0)
			removeElementData(source, "paciente")
			detachElements ( player, source)
			setPedAnimation(player)
		end
	elseif not isElement(camillas[player]) then
		setElementData(source, "paciente", player)
		-- outputChatBox("Te has subido a la camilla.",player, 250,200,0)
		local rx,ry,rz = getElementRotation(source)
		setElementRotation(player, rx,ry,rz+90)
		attachElements ( player, source,0,0,1.8,0,0,0)
		setPedAnimation(player, "crack", "crckidle4", -1, true, true, false,true)
	end
end
end

function camilla(player)
	if not isPedInVehicle ( player ) then
	local nombreplayer = getPlayerName(player)
	local factions = exports.facciones:getPlayerFaction(player)
		if factions then
			if factions[1] == 1 or factions[2] == 1 then
				if not isElement(camillas[player]) then
					local x,y,z = getElementPosition(player)
					local rx,ry,rz = getElementRotation(player)
					camillas[player] = createObject(1997,x+2,y,z-1,0,0,rz)
					setElementData(camillas[player], "camilla", true)
					setElementDimension(camillas[player], getElementDimension(player))
					setElementInterior(camillas[player], getElementInterior(player))
					attachElements ( camillas[player], player,0,1.3,-1,0,0,180 )
					setPedAnimation (player, "carry", "crry_prtial", 0, true, true, false, true)
					setElementCollisionsEnabled(camillas[player], true)
					exports.chatsystem:sendame(player, "Saca una camilla de la ambulancia y la desplega.")
					addEventHandler( "onElementClicked", camillas[player], togglePersonaSubida)
				else
					outputChatBox("Ya estás llevando una camilla.",player,200,0,0)
				end				
			end
		end
	end
end
addCommandHandler('camilla',camilla)

function soltarcamilla(player)
	if not isPedInVehicle ( player ) then
	local nombreplayer = getPlayerName(player)
	local factions = exports.facciones:getPlayerFaction(player)
		if factions then
			if factions[1] == 1 or factions[2] == 1 then
				if isElement(camillas[player]) then
					detachElements ( camillas[player], player )
					setPedAnimation(player)
					setElementCollisionsEnabled(camillas[player], true)
				end				
			end
		end
	end
end
addCommandHandler('soltarcamilla',soltarcamilla)

function cogercamilla(player)
	if not isPedInVehicle ( player ) then
	local nombreplayer = getPlayerName(player)
	local factions = exports.facciones:getPlayerFaction(player)
		if factions then
			if factions[1] == 1 or factions[2] == 1 then
				if isElement(camillas[player]) then
					local x,y,z = getElementPosition(player)
					local x1,y1,z1 = getElementPosition(camillas[player])
					if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) <= 5 then
						attachElements ( camillas[player], player,0,1.3,-1,0,0,180 )
						setPedAnimation (player, "carry", "crry_prtial", 0, true, true, false, true)
						setElementCollisionsEnabled(camillas[player], true)
					else
						outputChatBox("Estás muy lejos de tu camilla.",player,200,0,0)
					end
				end				
			end
		end
	end
end
addCommandHandler('cogercamilla',cogercamilla)


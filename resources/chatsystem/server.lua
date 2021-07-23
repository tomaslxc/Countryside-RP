local chatRadius = 20 
chatmode = {}
function sendMessageToNearbyPlayers( message, messageType )
if getElementData(source, "isLoged") and not isPedDead(source) then
    if messageType == 0 then
        local posX, posY, posZ = getElementPosition( source )
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        destroyElement( chatSphere )
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			if getElementDimension(source) == getElementDimension(nearbyPlayer) and getElementInterior(source) == getElementInterior(nearbyPlayer) then
				local x1,y1,z1 = getElementPosition(nearbyPlayer)
				local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
				if distance <= 5 then
				outputChatBox( string.gsub(getPlayerName(source),"_"," ").." dice: "..message.."", nearbyPlayer, 200,200,200,false )
				elseif distance <= 10 and distance > 5 then
				outputChatBox( string.gsub(getPlayerName(source),"_"," ").." dice: "..message.."", nearbyPlayer, 150,150,150,false )
				elseif distance <= 15 and distance > 10 then
				outputChatBox( string.gsub(getPlayerName(source),"_"," ").." dice: "..message.."", nearbyPlayer, 100,100,100,false )
				elseif distance <=20 and distance > 15 then
				outputChatBox( string.gsub(getPlayerName(source),"_"," ").." dice: "..message.."", nearbyPlayer, 50,50,50,false )
				end
			end
        end
		outputServerLog ( "[SAY]:"..string.gsub(getPlayerName(source),"_"," ").." dice: "..message.."" )   
	elseif messageType == 1 then
	    local posX, posY, posZ = getElementPosition( source )
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius+5 )
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        destroyElement( chatSphere )
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			if getElementDimension(source) == getElementDimension(nearbyPlayer) and getElementInterior(source) == getElementInterior(nearbyPlayer) then
            outputChatBox( "* "..string.gsub(getPlayerName(source),"_"," ").." "..message.."", nearbyPlayer, 194,162,218,false )
			end
        end
		outputServerLog ( "[ME]:* "..string.gsub(getPlayerName(source),"_"," ").." "..message.."" ) 
	end
end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )

function sendMegafono( player, cmd, ... )
	if getElementData(player, "isLoged") and not isPedDead(player) then
		local factions = exports.facciones:getPlayerFaction(player)
		local message = table.concat( { ... }, " " )
		if factions[1] == 2 or factions[2] == 2 then
			local posX, posY, posZ = getElementPosition( player )
			local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
				if getElementDimension(player) == getElementDimension(nearbyPlayer) and getElementInterior(player) == getElementInterior(nearbyPlayer) then
					local x1,y1,z1 = getElementPosition(nearbyPlayer)
					local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
					if distance <= 20 then
						outputChatBox( "[MEGÁFONO] "..string.gsub(getPlayerName(player),"_"," ").." dice por megáfono: "..message.."", nearbyPlayer, 255,255,0,false )
					end
				end
			end
			outputServerLog ( "[MEGAFONO]:"..string.gsub(getPlayerName(player),"_"," ").." dice: "..message.."" )   			
		end
	end
end
addCommandHandler( "meg", sendMegafono )

function blockChatMessage()
    cancelEvent()
end
addEventHandler( "onPlayerChat", getRootElement(), blockChatMessage )

function me(thePlayer, mensaje)
	local x1, y1, z1 = getElementPosition(thePlayer)
    for i, jugadores in ipairs (getElementsByType("player")) do
        local x2, y2, z2 = getElementPosition(jugadores)
        if #mensaje > 0 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <=20 and getElementDimension(thePlayer) == getElementDimension(jugadores) and getElementInterior(thePlayer) == getElementInterior(jugadores) then
            outputChatBox( "* "..string.gsub(getPlayerName(thePlayer),"_"," ").." "..mensaje.."", jugadores, 194,162,218,false )
			outputServerLog ( "[ME]:* "..string.gsub(getPlayerName(thePlayer),"_"," ").." "..mensaje.."" ) 
        end
    end
end

ametimers = {}
function ame (thePlayer, cmd, ...)
if getElementData(thePlayer, "isLoged") and not isPedDead(thePlayer) then
	if ... then
    local mensaje = table.concat({ ... }, " ")
    local x1, y1, z1 = getElementPosition(thePlayer)
    for i, jugadores in ipairs (getElementsByType("player")) do
        local x2, y2, z2 = getElementPosition(jugadores)
        if #mensaje > 0 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <= 20 and getElementDimension(thePlayer) == getElementDimension(jugadores) and getElementInterior(thePlayer) == getElementInterior(jugadores) then
			setElementData(thePlayer, "AMECHAT", mensaje)
			outputConsole ( "> "..string.gsub(getPlayerName(thePlayer),"_"," ").." "..mensaje, jugadores)
			outputServerLog ( "[AME]:* "..string.gsub(getPlayerName(thePlayer),"_"," ").." "..mensaje.."" )
			if not ametimers[thePlayer] then 
				ametimers[thePlayer] = {}
				ametimers[thePlayer] = setTimer ( function()
					if isElement(thePlayer) then
						removeElementData( thePlayer, "AMECHAT" )
					end
				ametimers[thePlayer] = nil
				end, 5000, 1 )
			else
				killTimer(ametimers[thePlayer])
				ametimers[thePlayer] = setTimer ( function()
					if isElement(thePlayer) then
						removeElementData( thePlayer, "AMECHAT" )
					end
				ametimers[thePlayer] = nil
				end, 5000, 1 )
			end
        end
    end
	else
	outputChatBox( "Comando: /" .. cmd .. " [texto IC]", thePlayer, 255, 255, 255 )
	end
end
end
addCommandHandler("ame", ame)

function sendame(thePlayer, mensaje)
if not isPedDead(thePlayer) then
    local x1, y1, z1 = getElementPosition(thePlayer)
    for i, jugadores in ipairs (getElementsByType("player")) do
        local x2, y2, z2 = getElementPosition(jugadores)
        if #mensaje > 0 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) < 30 and getElementDimension(thePlayer) == getElementDimension(jugadores) and getElementInterior(thePlayer) == getElementInterior(jugadores) then
			setElementData(thePlayer, "AMECHAT", mensaje)
			outputConsole ( "> "..string.gsub(getPlayerName(thePlayer),"_"," ").." "..mensaje, jugadores)
			outputServerLog ( "[AME]:* "..string.gsub(getPlayerName(thePlayer),"_"," ").." "..mensaje.."" ) 
			if not ametimers[thePlayer] then
				ametimers[thePlayer] = {}
				ametimers[thePlayer] = setTimer ( function()
					if isElement(thePlayer) then
						removeElementData( thePlayer, "AMECHAT" )
					end
				ametimers[thePlayer] = nil
				end, 5000, 1 )
			else
				killTimer(ametimers[thePlayer])
				ametimers[thePlayer] = setTimer ( function()
					if isElement(thePlayer) then
						removeElementData( thePlayer, "AMECHAT" )
					end
				ametimers[thePlayer] = nil
				end, 5000, 1 )
			end
        end
    end
end
end

local function pm( player, target, message )
	outputChatBox( "(( MP enviado a "..string.gsub(getPlayerName(target),"_"," ").." (ID: ".. getElementData(target,"playerid").."): " .. message.." ))", player, 238, 232, 84 )
	outputChatBox( "(( MP enviado por "..string.gsub(getPlayerName(player),"_"," ").." (ID: ".. getElementData(player,"playerid").."): " .. message.." ))", target, 236, 205, 45 )
	outputServerLog( "(( MP enviado a "..string.gsub(getPlayerName(target),"_"," ").." (ID: ".. getElementData(target,"playerid").."): " .. message.." ))")
	outputServerLog( "(( MP enviado por "..string.gsub(getPlayerName(player),"_"," ").." (ID: ".. getElementData(player,"playerid").."): " .. message.." ))")
end

function togglepm (player)
	if getElementData(player, "togglepm") then
		setElementData(player, "togglepm", false)
		outputChatBox("Te has activado los mensajes privados.", player, 0, 200,0)
	else
		setElementData(player, "togglepm", true)
		outputChatBox("Te has desactivado los mensajes privados.", player, 200,0,0)
	end
end
addCommandHandler("pms", togglepm)

addCommandHandler( "pm",
	function( player, commandName, otherPlayer, ... )
		if getElementData(player, "isLoged") then
			if otherPlayer and ( ... ) then
				local message = table.concat( { ... }, " " )
				local other, name = exports.login:getNID( player, otherPlayer )
					if other and getElementData(other, "togglepm") == false then
						pm( player, other, message )
						triggerClientEvent( other, "ventanita", other )
					elseif other and getElementData(player, "staff") >= 2  then
						pm( player, other, message )
						triggerClientEvent( other, "ventanita", other )
					else
						outputChatBox("Jugador no encontrado o tiene los mensajes privados desactivados.", player, 200,0,0)
					end
			else
				outputChatBox( "Comando: /" .. commandName .. " [Jugador/ID] [texto OOC]", player, 255, 255, 255 )
			end
		end
	end
)

function entorno (thePlayer, cmd, ...)
if getElementData(thePlayer, "isLoged") then
	if ... then
    local mensaje = table.concat({ ... }, " ")
    local x1, y1, z1 = getElementPosition(thePlayer)
    for i, jugadores in ipairs (getElementsByType("player")) do
        local x2, y2, z2 = getElementPosition(jugadores)
        if #mensaje > 0 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <=25 then
			if getElementDimension(thePlayer) == getElementDimension(jugadores) and getElementInterior(thePlayer) == getElementInterior(jugadores) then
            outputChatBox("* "..mensaje.." [ "..getPlayerName( thePlayer ):gsub( "_", " " ).." ] ", jugadores, 253,220,4)
			end
        end
    end
	outputServerLog ( "[DO]:** "..string.gsub(getPlayerName(thePlayer),"_"," ").." "..mensaje.."" )
	else
	outputChatBox( "Comando: /" .. cmd .. " [texto IC]", thePlayer, 255, 255, 255 )
	end
end
end
addCommandHandler("do", entorno)

chatlocalooc = true
bloqueolocalooc = {}
function localooc (thePlayer, cmd, ...)
	if getElementData(thePlayer, "isLoged") then
		if ... then
			if not bloqueolocalooc[thePlayer] or getElementData(thePlayer, "staff") >= 3 then
			    local mensaje = table.concat({ ... }, " ")
			    local x1, y1, z1 = getElementPosition(thePlayer)
			    for i, jugadores in ipairs (getElementsByType("player")) do
			        local x2, y2, z2 = getElementPosition(jugadores)
			        if #mensaje > 0 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) < 30 then
						if getElementDimension(thePlayer) == getElementDimension(jugadores) and getElementInterior(thePlayer) == getElementInterior(jugadores) then
							if getElementData(thePlayer, "adminduty") then
							outputChatBox("(( [STAFF][ID: "..getElementData(thePlayer, "playerid").."] "..string.gsub(getPlayerName(thePlayer),"_"," ")..": "..mensaje.." ))", jugadores,204, 229,255)
							else
							outputChatBox("(( [ID: "..getElementData(thePlayer, "playerid").."] "..string.gsub(getPlayerName(thePlayer),"_"," ")..": "..mensaje.." ))", jugadores,153, 255,255)
							end
						end
			        end
			    end
				outputServerLog ( "[LOCALOOC]:* "..string.gsub(getPlayerName(thePlayer),"_"," ").." (( "..mensaje.." ))" )
				bloqueolocalooc[thePlayer] = {true}
					setTimer ( function()
						bloqueolocalooc[thePlayer] = nil
					end, 5000, 1 )
			else
				outputChatBox("(( No puedes usar tan seguido el chat LOCAL OOC, es sancionable. ))",thePlayer,200,0,0)
			end
		else
		outputChatBox( "Comando: /" .. cmd .. " [texto OOC]", thePlayer, 255, 255, 255 )
		end
	end
end
addCommandHandler("b", localooc)
addCommandHandler("LocalOOC", localooc)



function susurro (thePlayer, cmd, ...)
if getElementData(thePlayer, "isLoged") then
	if ... then
    local mensaje = table.concat({ ... }, " ")
    local x1, y1, z1 = getElementPosition(thePlayer)
    for i, jugadores in ipairs (getElementsByType("player")) do
        local x2, y2, z2 = getElementPosition(jugadores)
        if #mensaje > 0 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <= 2 and getElementDimension(thePlayer)==getElementDimension(jugadores) then
			if getElementDimension(thePlayer) == getElementDimension(jugadores) and getElementInterior(thePlayer) == getElementInterior(jugadores) then
				if getElementData(thePlayer, "muerte") == false then
				outputChatBox( string.gsub(getPlayerName(thePlayer),"_"," ").." susurra: "..mensaje, jugadores, 157,157,157,false )
				end
			end
        end
    end
	outputServerLog ( "[Susurro]:"..string.gsub(getPlayerName(thePlayer),"_"," ").." susurra: "..mensaje )
	else
	outputChatBox( "[Susurrar] Comando: /" .. cmd .. " [texto IC]", thePlayer, 255, 255, 255 )
	end
end
end
addCommandHandler("s", susurro)

function grito (thePlayer, cmd, ...)
if getElementData(thePlayer, "isLoged") then
	if ... then
    local mensaje = table.concat({ ... }, " ")
    local x1, y1, z1 = getElementPosition(thePlayer)
    for i, jugadores in ipairs (getElementsByType("player")) do
        local x2, y2, z2 = getElementPosition(jugadores)
        if #mensaje > 0 and getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <= 40 and getElementDimension(thePlayer)==getElementDimension(jugadores) then
			if getElementDimension(thePlayer) == getElementDimension(jugadores) and getElementInterior(thePlayer) == getElementInterior(jugadores) then
				outputChatBox( string.gsub(getPlayerName(thePlayer),"_"," ").." grita: "..mensaje, jugadores, 255,255,255,false )
			end
        end
    end
	outputServerLog ( "[Grito]:"..string.gsub(getPlayerName(thePlayer),"_"," ").." grita: "..mensaje )
	else
	outputChatBox( "[Gritar] Comando: /" .. cmd .. " [texto IC]", thePlayer, 255, 255, 255 )
	end
end
end
addCommandHandler("g", grito)


staffrang	= {"Tester", "Ayudante", "Moderador", "Game Operator", "Administrador", "Desarrollador"}

function modchat (thePlayer, cmd, ...)
	if getElementData(thePlayer, "isLoged") and getElementData(thePlayer,"staff") and getElementData(thePlayer, "staff") >=  3 then
		if ... then
		local mensaje = table.concat({ ... }, " ")
			for i, jugadores in ipairs (getElementsByType("player")) do
				if getElementData(jugadores,"staff") and getElementData(jugadores,"staff") >= 3 then
					triggerClientEvent( jugadores, "ventanita", jugadores )
					if not getElementData(jugadores, "showadmin") then
						outputChatBox( staffrang[tonumber(getElementData(thePlayer, "staff"))].." "..string.gsub(getPlayerName(thePlayer),"_"," ").." [M]: "..mensaje, jugadores, 255,178,102,false )
					else
						outputConsole( staffrang[tonumber(getElementData(thePlayer, "staff"))].." "..string.gsub(getPlayerName(thePlayer),"_"," ").." [M]: "..mensaje, jugadores)
					end
				end
			end
		else
		outputChatBox("Syntax: /m [texto modchat]", thePlayer, 255,255,255)
		end
	end
end
addCommandHandler("m", modchat)


function modchatayudantes (thePlayer, cmd, ...)
	if getElementData(thePlayer, "isLoged") and getElementData(thePlayer,"staff") then
	if getElementData(thePlayer, "staff") >= 2 then
		if ... then
		local mensaje = table.concat({ ... }, " ")
			for i, jugadores in ipairs (getElementsByType("player")) do
				if getElementData(jugadores,"staff") then
					if getElementData(jugadores,"staff") > 0 then
						triggerClientEvent( jugadores, "ventanita", jugadores )
						if not getElementData(jugadores, "showadmin") then
							outputChatBox( staffrang[tonumber(getElementData(thePlayer, "staff"))].." "..string.gsub(getPlayerName(thePlayer),"_"," ").." [AY]: "..mensaje, jugadores, 204,255,255,false )
						else
							outputConsole(staffrang[tonumber(getElementData(thePlayer, "staff"))].." "..string.gsub(getPlayerName(thePlayer),"_"," ").." [AY]: "..mensaje, jugadores)
						end
					end
				end
			end
		else
		outputChatBox("Syntax: /ay [texto ayudantes]", thePlayer, 255,255,255)
		end
	end
	end
end
addCommandHandler("ay", modchatayudantes)


function admchat (thePlayer, cmd, ...)
	if getElementData(thePlayer, "isLoged") and getElementData(thePlayer, "staff") and getElementData(thePlayer, "staff") >= 5 then
		if ... then
		local mensaje = table.concat({ ... }, " ")
			for i, jugadores in ipairs (getElementsByType("player")) do
				if getElementData(jugadores,"staff") and getElementData(jugadores,"staff") >= 5 then
					triggerClientEvent( jugadores, "ventanita", jugadores )
					if not getElementData(jugadores, "showadmin") then
					outputChatBox( staffrang[tonumber(getElementData(thePlayer, "staff"))].." "..string.gsub(getPlayerName(thePlayer),"_"," ").." [A]: "..mensaje, jugadores, 255,128,0,false )
					else
					outputConsole( staffrang[tonumber(getElementData(thePlayer, "staff"))].." "..string.gsub(getPlayerName(thePlayer),"_"," ").." [A]: "..mensaje, jugadores)
					end
				end
			end
		else
		outputChatBox("Syntax: /a [texto adminchat]", thePlayer, 255,255,255)
		end
	end
end
addCommandHandler("a", admchat)

function aaad (thePlayer, cmd, ...)
	if getElementData(thePlayer, "isLoged") and getElementData(thePlayer, "staff") >= 3 then
		if ... then
		local mensaje = table.concat({ ... }, " ")
			for i, jugadores in ipairs (getElementsByType("player")) do
				if getElementData(jugadores,"staff") and getElementData(jugadores,"staff") > 0 then
				outputChatBox("** "..mensaje.." ** ("..string.gsub(getPlayerName(thePlayer),"_"," ")..")",jugadores,0,204,204)
				else
				outputChatBox("** "..mensaje.." **",jugadores,0,204,204)
				end
			end
		else
		outputChatBox("Syntax: /aad [texto anuncio administrativo]", thePlayer, 255,255,255)
		end
	end
end
addCommandHandler("aad", aaad)

function veradmins (player)
if getElementData(player, "isLoged") then
	outputChatBox("Equipo administrativo conectado",player,192,192,192)
	outputChatBox("-------------------------------",player,192,192,192)
	for i, jugadores in ipairs (getElementsByType("player")) do
	
		if getElementData(jugadores,"staff") and getElementData(jugadores,"staff") > 0 and not getElementData(jugadores, "ocultadostaff") then
			if getElementData(jugadores, "adminduty") then
				if getElementData(jugadores, "togglepm") then
				outputChatBox( "["..getElementData( jugadores, "playerid" ).."] "..staffrang[tonumber(getElementData(jugadores, "staff"))].." "..string.gsub(getPlayerName(jugadores),"_"," ").." - Ocupado", player, 255,128,0,false )
				else
				outputChatBox( "["..getElementData( jugadores, "playerid" ).."] "..staffrang[tonumber(getElementData(jugadores, "staff"))].." "..string.gsub(getPlayerName(jugadores),"_"," ").." - Disponible", player, 255,128,0,false )
				end
			else
				if getElementData(jugadores, "togglepm") then
				outputChatBox( "["..getElementData( jugadores, "playerid" ).."] "..staffrang[tonumber(getElementData(jugadores, "staff"))].." "..string.gsub(getPlayerName(jugadores),"_"," ").." - Ocupado", player, 255,255,255,false )
				else
				outputChatBox( "["..getElementData( jugadores, "playerid" ).."] "..staffrang[tonumber(getElementData(jugadores, "staff"))].." "..string.gsub(getPlayerName(jugadores),"_"," ").." - Disponible", player, 255,255,255,false )
				end
			end
		end

	end
	outputChatBox("-------------------------------",player,192,192,192)
end
end
addCommandHandler("staff", veradmins)
addCommandHandler("admins", veradmins)


function messageQuitPlayer(qtype)
	local x,y,z = getElementPosition(source)
	for i,players in ipairs(getElementsByType("player")) do
		local x1,y1,z1 = getElementPosition(players)
		if getDistanceBetweenPoints3D(x,y,z,x1,y1,z1) < 20 and getElementData(source, "isLoged") and getElementData(players, "isLoged") then
			outputChatBox(string.gsub(getPlayerName(source),"_"," ").." se ha desconectado del servidor ["..qtype.."]",players, 255,204,153)
		end
	end
	ametimers[source] = nil
end
addEventHandler("onPlayerQuit", root, messageQuitPlayer)

--STAFF:
-- 1: Tester
-- 2: Ayudante
-- 3: Moderador
-- 4: GameOperator
-- 5: Lead Moderador
-- 6: Lead Game Operator
-- 7: Administrador
-- 8: Director

local tags = { [1] = "LSMD", [2] = "LSPD", [3] = "TAXI", [6] = "RED TRUCKERS" }

function radioFaccion1( player, cmd, ... )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then		
		if ... then
			local mensaje = table.concat( { ... }, " " )
			fplayer = tonumber(factions[1])
			local players = getElementsByType( 'player' )
			for i=1, #players do 
				local v = players[i]
				local factions_otro = exports.facciones:getPlayerFaction( v )
				if factions_otro then
					if factions_otro[1] == fplayer and tags[ fplayer ] then
						outputChatBox("["..tags[fplayer].."] "..string.gsub(getPlayerName(player),"_"," ").." dice: "..mensaje,v,153,153,255)
						
						if getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
							local posX,posY,posZ = getElementPosition(player)
							local x1,y1,z1 = getElementPosition(v)
							local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
							if distance <= 5 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 200,200,200,false )
							elseif distance <= 10 and distance > 5 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 150,150,150,false )
							elseif distance <= 15 and distance > 10 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 100,100,100,false )
							elseif distance <=20 and distance > 15 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 50,50,50,false )
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler( "d", radioFaccion1 )
addCommandHandler( "Radio", radioFaccion1 )

function radioFaccion2( player, cmd, ... )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then		
		if ... then
			local mensaje = table.concat( { ... }, " " )
			fplayer = tonumber(factions[2])
			local players = getElementsByType( 'player' )
			for i=1, #players do 
				local v = players[i]
				local factions_otro = exports.facciones:getPlayerFaction( v )
				if factions_otro then
					if factions_otro[2] == fplayer and tags[ fplayer ] then
						outputChatBox("["..tags[fplayer].."] "..string.gsub(getPlayerName(player),"_"," ").." dice: "..mensaje,v,153,153,255)
						
						if getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
							local posX,posY,posZ = getElementPosition(player)
							local x1,y1,z1 = getElementPosition(v)
							local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
							if distance <= 5 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 200,200,200,false )
							elseif distance <= 10 and distance > 5 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 150,150,150,false )
							elseif distance <= 15 and distance > 10 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 100,100,100,false )
							elseif distance <=20 and distance > 15 then
								outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 50,50,50,false )
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler( "d2", radioFaccion2 )
addCommandHandler( "Radio2", radioFaccion2 )

function radioPM( player, cmd, ... )
local factions = exports.facciones:getPlayerFaction(player)
	if factions then
		if factions[1] == 1 or factions[2] == 1 or factions[1] == 2 or factions[2] == 2 then
			if ... then
				local mensaje = table.concat({...}," ")
				for i,v in ipairs(getElementsByType("player")) do
				local factions2 = exports.facciones:getPlayerFaction(v)
					if factions2 then
						if factions2[1] == 1 or factions2[2] == 1 or factions2[1] == 2 or factions2[2] == 2 then
							if factions[1] == 1 or factions[2] == 1 then
								outputChatBox("[LSMD-GLOBAL] "..string.gsub(getPlayerName(player),"_"," ").." dice: "..mensaje,v,153,153,255)
							elseif factions[1] == 2 or factions[2] == 2 then
								outputChatBox("[LSPD-GLOBAL] "..string.gsub(getPlayerName(player),"_"," ").." dice: "..mensaje,v,153,153,255)
							end
						end
					end

					if getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
						local posX,posY,posZ = getElementPosition(player)
						local x1,y1,z1 = getElementPosition(v)
						local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
						if distance <= 5 then
						outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 200,200,200,false )
						elseif distance <= 10 and distance > 5 then
						outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 150,150,150,false )
						elseif distance <= 15 and distance > 10 then
						outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 100,100,100,false )
						elseif distance <=20 and distance > 15 then
						outputChatBox( string.gsub(getPlayerName(player),"_"," ").." dice por radio: "..mensaje.."", v, 50,50,50,false )
						end
					end
				end
			else
				outputChatBox("Syntax: /"..cmd.." [mensaje]",player,255,255,255)
			end
		end
	end
end
addCommandHandler("dg", radioPM)
addCommandHandler("Departamentos", radioPM)












function chatFaccion1( player, cmd, ... )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then		
		if ... then
			local mensaje = table.concat( { ... }, " " )
			fplayer = tonumber(factions[1])
			local players = getElementsByType( 'player' )
			for i=1, #players do 
				local v = players[i]
				local factions_otro = exports.facciones:getPlayerFaction( v )
				if factions_otro then
					if factions_otro[1] == fplayer and tags[ fplayer ] then
						outputChatBox("["..tags[fplayer].."] "..string.gsub(getPlayerName(player),"_"," ").."[OOC]: "..mensaje,v,133,153,215)
						
						if getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
							local posX,posY,posZ = getElementPosition(player)
							local x1,y1,z1 = getElementPosition(v)
							local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
							if distance <= 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 200,200,200,false )
							elseif distance <= 0 and distance > 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 150,150,150,false )
							elseif distance <= 0 and distance > 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 100,100,100,false )
							elseif distance <=0 and distance > 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 50,50,50,false )
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler( "f",chatFaccion1 )

function chatFaccion2( player, cmd, ... )
	local factions = exports.facciones:getPlayerFaction(player)
	if factions then		
		if ... then
			local mensaje = table.concat( { ... }, " " )
			fplayer = tonumber(factions[2])
			local players = getElementsByType( 'player' )
			for i=1, #players do 
				local v = players[i]
				local factions_otro = exports.facciones:getPlayerFaction( v )
				if factions_otro then
					if factions_otro[2] == fplayer and tags[ fplayer ] then
						outputChatBox("["..tags[fplayer].."] "..string.gsub(getPlayerName(player),"_"," ").."[OOC]: "..mensaje,v,133,153,215)
						
						if getElementDimension(player) == getElementDimension(v) and getElementInterior(player) == getElementInterior(v) then
							local posX,posY,posZ = getElementPosition(player)
							local x1,y1,z1 = getElementPosition(v)
							local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x1,y1,z1)
							if distance <= 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 200,200,200,false )
							elseif distance <= 0 and distance > 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 150,150,150,false )
							elseif distance <= 0 and distance > 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 100,100,100,false )
							elseif distance <=0 and distance > 0 then
								outputServerLog( string.gsub(getPlayerName(player),"_"," ").." [OOC]: "..mensaje.."", v, 50,50,50,false )
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler( "f2", chatFaccion2 )

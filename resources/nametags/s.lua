local connection = exports.mysql:connect()

addCommandHandler( "yo",
	function( player, cmd, ... )
	if ... then
		local yo = table.concat( {...}, " " )
		local yo = string.gsub(tostring(yo), "'", "´")
		if getElementData(player, "isLoged") then
			if yo == "." then
				removeElementData( player, "yo" )
				outputChatBox( "Has borrado tu /yo", player, 0, 200, 100 )
				dbExec( connection, "UPDATE `personajes` SET `yo`=NULL WHERE `ID`="..exports.personajes:getCharID(player).."")
			else
				if #yo <= 80 then
				dbExec( connection, "UPDATE `personajes` SET `yo`='"..tostring(yo).."' WHERE `ID`="..exports.personajes:getCharID(player).."")
				setElementData( player, "yo", yo )
				outputChatBox( "Has actualizado tu /yo. Actual:", player, 0, 255, 0 )
				outputChatBox( yo, player, 0, 255, 0 )
				else
				outputChatBox("El /yo es demasiado largo.", player, 200,0,0)
				end
			end
		else
			outputChatBox( "No estas logueado.", player, 255, 0, 0 )
		end
	else
	outputChatBox("Syntax: /yo [texto] ( pon un . para borrarlo )", player, 255,255,255)
	end
	end
)

addEvent( "setDataHablando", true )
addEventHandler( "setDataHablando", getRootElement(),
	function( state )
		if state == 1 then
			setElementData( source, "hablando", true )
		else
			removeElementData( source, "hablando" )
		end
	end
)

function veryo (p)
	if getElementData(p, "yo") then
	outputChatBox("Tu yo: "..getElementData(p, "yo"),p, 0, 200,0)
	else
	outputChatBox("No tienes definido ningún yo, usa /yo [texto] para poner uno.",p,200,0,0)
	end
end
addCommandHandler("veryo", veryo)


function onResourceStart ( )
    local players = getElementsByType ( "player" ) -- Store all the players in the server into a table
    for key, player in ipairs ( players ) do       -- for all the players in the table
        setPlayerNametagShowing ( player, false )  -- turn off their nametag
    end
end
addEventHandler ( "onResourceStart", resourceRoot, onResourceStart )

function greetPlayer ( )
	setPlayerNametagShowing(source, false)
end
addEventHandler ( "onPlayerJoin", getRootElement(), greetPlayer )
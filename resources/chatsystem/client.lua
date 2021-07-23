bindKey( "b", "down", "chatbox", "LocalOOC" )
bindKey( "y", "down", "chatbox", "Radio" )
bindKey( "u", "down", "chatbox", "Radio2" )
bindKey( "o", "down", "chatbox", "Departamentos" )

local solidchat = false
local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender", root,
    function()
		if solidchat then
			dxDrawRectangle(screenW * 0.0000, screenH * 0.0011, screenW * 0.5050, screenH * 0.9989, tocolor(0, 0, 0, 255), false)
			dxDrawText("SOLIDCHAT ACTIVADO", (screenW * 0.5325) - 1, (screenH * 0.2733) - 1, (screenW * 0.9306) - 1, (screenH * 0.7267) - 1, tocolor(0, 0, 0, 255), 2.00, "sans", "center", "center", false, false, false, false, false)
			dxDrawText("SOLIDCHAT ACTIVADO", (screenW * 0.5325) + 1, (screenH * 0.2733) - 1, (screenW * 0.9306) + 1, (screenH * 0.7267) - 1, tocolor(0, 0, 0, 255), 2.00, "sans", "center", "center", false, false, false, false, false)
			dxDrawText("SOLIDCHAT ACTIVADO", (screenW * 0.5325) - 1, (screenH * 0.2733) + 1, (screenW * 0.9306) - 1, (screenH * 0.7267) + 1, tocolor(0, 0, 0, 255), 2.00, "sans", "center", "center", false, false, false, false, false)
			dxDrawText("SOLIDCHAT ACTIVADO", (screenW * 0.5325) + 1, (screenH * 0.2733) + 1, (screenW * 0.9306) + 1, (screenH * 0.7267) + 1, tocolor(0, 0, 0, 255), 2.00, "sans", "center", "center", false, false, false, false, false)
			dxDrawText("SOLIDCHAT ACTIVADO", screenW * 0.5325, screenH * 0.2733, screenW * 0.9306, screenH * 0.7267, tocolor(18, 134, 2, 255), 2.00, "sans", "center", "center", false, false, false, false, false)
		end
    end
)

addEvent( "ventanita", true )
addEventHandler( "ventanita", getRootElement(),
	function()
		setWindowFlashing( true, 20 )
	end
)

function activarsolidchat()
	if getElementData(localPlayer, "isLoged") then
		if solidchat then
			solidchat = false
		else
			solidchat = true
		end
	end
end
addCommandHandler("solidchat", activarsolidchat)
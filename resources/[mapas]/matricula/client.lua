local color			= 0xff111111
local font			= dxCreateFont("files/font.ttf", 20, true)
local size			= 1.5

local tex_plates    = {}
local raw_shader    = [[
    texture platetex;
    technique TexReplace {
        pass P0 {
            Texture[0] = platetex;
        }
    }
]]


local shader_plateback = dxCreateShader(raw_shader)
dxSetShaderValue(shader_plateback, "platetex", dxCreateTexture("files/placa.png", "dxt5"))
engineApplyShaderToWorldTexture(shader_plateback, "plateback*")


local function getPlateShader(veh)
    if not tex_plates[veh] then
        local rt = dxCreateRenderTarget(350, 60)
        dxSetRenderTarget(rt)
			dxDrawRectangle(0, 0, 350, 60, 0xffd8d8d8)
            dxDrawText(getVehiclePlateText(veh) or "", 0, 0, 350, 60, color, size, font, "center", "center")
        dxSetRenderTarget()
        
        tex_plates[veh] = dxCreateShader(raw_shader)
        dxSetShaderValue(tex_plates[veh], "platetex", rt)
    end
    return tex_plates[veh]
end


local function onStreamIn(vehicle)
	local shader = getPlateShader(vehicle)
	engineApplyShaderToWorldTexture(shader, "custom_car_plate", vehicle)
end

addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "vehicle" then
		onStreamIn(source)
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
    if tex_plates[source] then
        engineRemoveShaderFromWorldTexture(tex_plates[source], "custom_car_plate", source)
        destroyElement(source)
        tex_plates[source] = nil
    end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	local vehicles = getElementsByType("vehicle", root, true)
	for i = 1, #vehicles do
		onStreamIn(vehicles[i])
	end
end)
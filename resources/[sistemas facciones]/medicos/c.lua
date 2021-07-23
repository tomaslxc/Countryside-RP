

function updateCamillaPosition ()
	local camillas = getAttachedElements (localPlayer)
	for i,v in ipairs(camillas) do
		if getElementData(v, "camilla") then
			if getElementDimension(localPlayer) ~= getElementDimension(v) then
				setElementDimension(v,getElementDimension(localPlayer) )
			end

			if getElementInterior(localPlayer) ~= getElementInterior(v) then
				setElementInterior(v,getElementInterior(localPlayer) )
			end
		end
	end
end
addEventHandler ( "onClientPreRender", root, updateCamillaPosition )
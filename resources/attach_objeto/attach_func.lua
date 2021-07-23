attached_ped_fixed = {}
attached_bone_fixed = {}
attached_x_fixed = {}
attached_y_fixed = {}
attached_z_fixed = {}
attached_rx_fixed = {}
attached_ry_fixed = {}
attached_rz_fixed = {}

function attachElementToBone(element,ped,bone,x,y,z,rx,ry,rz)
	if not (isElement(element) and isElement(ped)) then return false end
	if getElementType(ped) ~= "ped" and getElementType(ped) ~= "player" then return false end
	bone = tonumber(bone)
	if not bone or bone < 1 or bone > 20 then return false end
	x,y,z,rx,ry,rz = tonumber(x) or 0,tonumber(y) or 0,tonumber(z) or 0,tonumber(rx) or 0,tonumber(ry) or 0,tonumber(rz) or 0
	attached_ped_fixed[element] = ped
	attached_bone_fixed[element] = bone
	attached_x_fixed[element] = x
	attached_y_fixed[element] = y
	attached_z_fixed[element] = z
	attached_rx_fixed[element] = rx
	attached_ry_fixed[element] = ry
	attached_rz_fixed[element] = rz
	if setElementCollisionsEnabled then
		setElementCollisionsEnabled(element,false)
	end
	if script_serverside_fixed then
		triggerClientEvent("boneAttach_attach",root,element,ped,bone,x,y,z,rx,ry,rz)
	end
	return true
end

function detachElementFromBone(element)
	if not element then return false end
	if not attached_ped_fixed[element] then return false end
	clearAttachmentData(element)
	if setElementCollisionsEnabled then
		setElementCollisionsEnabled(element,true)
	end
	if script_serverside_fixed then
		triggerClientEvent("boneAttach_detach",root,element)
	end
	return true
end

function isElementAttachedToBone(element)
	if not element then return false end
	return isElement(attached_ped_fixed[element])
end

function getElementBoneAttachmentDetails(element)
	if not isElementAttachedToBone(element) then return false end
	return attached_ped_fixed[element],attached_bone_fixed[element],
		attached_x_fixed[element],attached_y_fixed[element],attached_z_fixed[element],
		attached_rx_fixed[element],attached_ry_fixed[element],attached_rz_fixed[element]
end

function setElementBonePositionOffset(element,x,y,z)
	local ped,bone,ox,oy,oz,rx,ry,rz = getElementBoneAttachmentDetails(element)
	if not ped then return false end
	return attachElementToBone(element,ped,bone,x,y,z,rx,ry,rz)
end

function setElementBoneRotationOffset(element,rx,ry,rz)
	local ped,bone,x,y,z,ox,oy,oz = getElementBoneAttachmentDetails(element)
	if not ped then return false end
	return attachElementToBone(element,ped,bone,x,y,z,rx,ry,rz)
end

if not script_serverside_fixed then
	function getBonePositionAndRotation(ped,bone)
		bone = tonumber(bone)
		if not bone or bone < 1 or bone > 20 then return false end
		if not isElement(ped) then return false end
		if getElementType(ped) ~= "player" and getElementType(ped) ~= "ped" then return false end
		if not isElementStreamedIn(ped) then return false end
		local x,y,z = getPedBonePosition(ped,bone_0[bone])
		local rx,ry,rz = getEulerAnglesFromMatrix(getBoneMatrix(ped,bone))
		return x,y,z,rx,ry,rz
	end
end

------------------------------------

function clearAttachmentData(element)
	attached_ped_fixed[element] = nil
	attached_bone_fixed[element] = nil
	attached_x_fixed[element] = nil
	attached_y_fixed[element] = nil
	attached_z_fixed[element] = nil
	attached_rx_fixed[element] = nil
	attached_ry_fixed[element] = nil
	attached_rz_fixed[element] = nil
end

function forgetDestroyedElements()
	if not attached_ped_fixed[source] then return end
	clearAttachmentData(source)
end
addEventHandler(script_serverside_fixed and "onElementDestroy" or "onClientElementDestroy",root,forgetDestroyedElements)

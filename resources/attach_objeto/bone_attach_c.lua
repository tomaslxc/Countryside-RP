function sendReadyMessage()
	triggerServerEvent("boneAttach_requestAttachmentData",root)
end
addEventHandler("onClientResourceStart",resourceRoot,sendReadyMessage)

function getAttachmentData(ped,bone,x,y,z,rx,ry,rz)
	for element,att_ped in pairs(ped) do
		setElementCollisionsEnabled(element,false)
		attached_ped_fixed[element] = att_ped
		attached_bone_fixed[element] = bone[element]
		attached_x_fixed[element] = x[element]
		attached_y_fixed[element] = y[element]
		attached_z_fixed[element] = z[element]
		attached_rx_fixed[element] = rx[element]
		attached_ry_fixed[element] = ry[element]
		attached_rz_fixed[element] = rz[element]
	end
end
addEvent("boneAttach_sendAttachmentData",true)
addEventHandler("boneAttach_sendAttachmentData",root,getAttachmentData)

function initAttach()
	addEvent("boneAttach_attach",true)
	addEvent("boneAttach_detach",true)
	addEventHandler("boneAttach_attach",root,attachElementToBone)
	addEventHandler("boneAttach_detach",root,detachElementFromBone)
end
addEventHandler("onClientResourceStart",resourceRoot,initAttach)

bone_0_fixed,bone_t_fixed,bone_f_fixed = {},{},{}
bone_0_fixed[1],bone_t_fixed[1],bone_f_fixed[1] = 5,nil,6 --head
bone_0_fixed[2],bone_t_fixed[2],bone_f_fixed[2] = 4,5,8 --neck
bone_0_fixed[3],bone_t_fixed[3],bone_f_fixed[3] = 3,nil,32 --spine
bone_0_fixed[4],bone_t_fixed[4],bone_f_fixed[4] = 1,2,3 --pelvis
bone_0_fixed[5],bone_t_fixed[5],bone_f_fixed[5] = 4,32,5 --left clavicle
bone_0_fixed[6],bone_t_fixed[6],bone_f_fixed[6] = 4,22,5 --right clavicle
bone_0_fixed[7],bone_t_fixed[7],bone_f_fixed[7] = 32,33,34 --left shoulder
bone_0_fixed[8],bone_t_fixed[8],bone_f_fixed[8] = 22,23,24 --right shoulder
bone_0_fixed[9],bone_t_fixed[9],bone_f_fixed[9] = 33,34,32 --left elbow
bone_0_fixed[10],bone_t_fixed[10],bone_f_fixed[10] = 23,24,22 --right elbow
bone_0_fixed[11],bone_t_fixed[11],bone_f_fixed[11] = 34,35,36 --left hand
bone_0_fixed[12],bone_t_fixed[12],bone_f_fixed[12] = 24,25,26 --right hand
bone_0_fixed[13],bone_t_fixed[13],bone_f_fixed[13] = 41,42,43 --left hip
bone_0_fixed[14],bone_t_fixed[14],bone_f_fixed[14] = 51,52,53 --right hip
bone_0_fixed[15],bone_t_fixed[15],bone_f_fixed[15] = 42,43,44 --left knee
bone_0_fixed[16],bone_t_fixed[16],bone_f_fixed[16] = 52,53,54 --right knee
bone_0_fixed[17],bone_t_fixed[17],bone_f_fixed[17] = 43,42,44 --left ankle
bone_0_fixed[18],bone_t_fixed[18],bone_f_fixed[18] = 53,52,54 --right angle
bone_0_fixed[19],bone_t_fixed[19],bone_f_fixed[19] = 44,43,42 --left foot
bone_0_fixed[20],bone_t_fixed[20],bone_f_fixed[20] = 54,53,52 --right foot


function putAttachedElementsOnBones()
	for element,ped in pairs(attached_ped_fixed) do
		if not isElement(element) then
			clearAttachmentData(element)
		elseif isElement(ped) and isElementStreamedIn(ped) then
			local bone = attached_bone_fixed[element]
			local x,y,z = getPedBonePosition(ped,bone_0_fixed[bone])
			local xx,xy,xz,yx,yy,yz,zx,zy,zz = getBoneMatrix(ped,bone)
			local offx,offy,offz = attached_x_fixed[element],attached_y_fixed[element],attached_z_fixed[element]
			local offrx,offry,offrz = attached_rx_fixed[element],attached_ry_fixed[element],attached_rz_fixed[element]
			local objx = x+offx*xx+offy*yx+offz*zx
			local objy = y+offx*xy+offy*yy+offz*zy
			local objz = z+offx*xz+offy*yz+offz*zz
			local rxx,rxy,rxz,ryx,ryy,ryz,rzx,rzy,rzz = getMatrixFromEulerAngles(offrx,offry,offrz)
			
			local txx = rxx*xx+rxy*yx+rxz*zx
			local txy = rxx*xy+rxy*yy+rxz*zy
			local txz = rxx*xz+rxy*yz+rxz*zz
			local tyx = ryx*xx+ryy*yx+ryz*zx
			local tyy = ryx*xy+ryy*yy+ryz*zy
			local tyz = ryx*xz+ryy*yz+ryz*zz
			local tzx = rzx*xx+rzy*yx+rzz*zx
			local tzy = rzx*xy+rzy*yy+rzz*zy
			local tzz = rzx*xz+rzy*yz+rzz*zz
			offrx_fixed,offry_fixed,offrz_fixed = getEulerAnglesFromMatrix(txx,txy,txz,tyx,tyy,tyz,tzx,tzy,tzz)
			local alpha=getElementAlpha(ped)
			local alpha2=getElementAlpha(element)
			if alpha~=alpha2 and alpha<255 and alpha2~=0 then
				setElementAlpha(element,alpha)
			end
			local inter=getElementInterior(ped)
			local dim=getElementDimension(ped)
			local inter2=getElementInterior(element)
			local dim2=getElementDimension(element)
			if inter~=inter2 then
				setElementInterior(element,inter)
			end
			if dim~=dim2 then
				setElementDimension(element,dim)
			end
			setElementPosition(element,objx,objy,objz)
			setElementRotation(element,offrx_fixed,offry_fixed,offrz_fixed,"ZXY")
		else
			if isElement(ped) then
				setElementPosition(element,getElementPosition(ped))
			end
		end
	end
end
addEventHandler("onClientPreRender",root,putAttachedElementsOnBones)

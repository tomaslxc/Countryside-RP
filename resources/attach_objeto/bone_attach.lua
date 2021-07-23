script_serverside_fixed = true
data_sent_fixed = {}

function sendAttachmentData()
	if data_sent_fixed[client] then return end
	triggerClientEvent(client,"boneAttach_sendAttachmentData",root,
		attached_ped_fixed,
		attached_bone_fixed,
		attached_x_fixed,
		attached_y_fixed,
		attached_z_fixed,
		attached_rx_fixed,
		attached_ry_fixed,
		attached_rz_fixed
	)
	data_sent_fixed[client] = true
end
addEvent("boneAttach_requestAttachmentData",true)
addEventHandler("boneAttach_requestAttachmentData",root,sendAttachmentData)

function removeDataSentFlag()
	data_sent_fixed[source] = nil
end
addEventHandler("onPlayerQuit",root,removeDataSentFlag)

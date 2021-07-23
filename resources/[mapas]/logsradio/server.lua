function addLogMessage(type, message)
	local type = string.lower(type)
	local r = getRealTime( )
	local fecha = "[" .. ("%04d-%02d-%02d %02d:%02d:%02d"):format(r.year+1900, r.month + 1, r.monthday, r.hour,r.minute, r.second) .. "] "
	if fileExists ( type..".txt" ) then
		local file = fileOpen(type..".txt")
		local size = fileGetSize(file)
		fileSetPos (file, size)
		fileWrite(file, fecha..message.."\n")
		fileClose(file)
	else
		local file = fileCreate(type..".txt")
		fileWrite(file, fecha..message.."\n")
		fileClose(file)
	end
end
function displayLoadedRes ( res )
	setOcclusionsEnabled ( false )
end
addEventHandler ( "onResourceStart", getRootElement(), displayLoadedRes )

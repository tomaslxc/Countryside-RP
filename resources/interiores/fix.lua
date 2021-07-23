function permitirCaida(player)
	setPedCanBeKnockedOffBike(player, true)
end

addEvent(getResourceName(getThisResource()) .. ":fixearMotos", true)
addEventHandler(getResourceName(getThisResource()) .. ":fixearMotos", root,
	function(player)
		setPedCanBeKnockedOffBike (player, false)
		setTimer(permitirCaida, 3000, 1, player)
	end
)
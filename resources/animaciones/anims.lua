
local anims =
{
-- Quite una animacion, seria numero 6
	bar =
	{
		{ block = "bar", anim = "barcustom_loop", time = -1 },
		{ block = "bar", anim = "dnk_stndm_loop", time = -1 },
		{ block = "bar", anim = "dnk_stndf_loop", time = -1 },
		{ block = "bar", anim = "barman_idle", time = -1 },
		{ block = "bar", anim = "barserve_bottle", time = 3000 },
		{ block = "bar", anim = "barserve_in", time = 1000 },
		{ block = "bar", anim = "barserve_loop", time = -1 },
	},
	batear =
	{
		{ block = "baseball", anim = "bat_1", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_2", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_3", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_4", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_1", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_2", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_3", time = -1, updatePosition = true, loop = false },
	},
	bomba =
	{
		{ block = "bomber", anim = "bom_plant", time = 3000 },
	},
	crack =
	{
		{ block = "crack", anim = "crckidle2", time = -1 },
		{ block = "crack", anim = "crckidle3", time = -1 },
		{ block = "crack", anim = "crckidle4", time = -1 },
		{ block = "crack", anim = "crckidle1", time = -1 },
		{ block = "sweet", anim = "sweet_injuredloop", time = -1 },
	},
	rcp =
	{
		{ block = "medic", anim = "cpr", time = 8000 },
	},
	strip =
	{
		{ block = "STRIP", anim = "PLY_CASH", time = -1 },
		{ block = "STRIP", anim = "strip_A", time = -1 },
		{ block = "STRIP", anim = "strip_B", time = -1 },
		{ block = "STRIP", anim = "strip_C", time = -1 },
		{ block = "STRIP", anim = "strip_D", time = -1 },
		{ block = "STRIP", anim = "strip_E", time = -1 },
		{ block = "STRIP", anim = "strip_F", time = -1 },
		{ block = "STRIP", anim = "strip_G", time = -1 },

    },
	bailar =
	{
		{ block = "dancing", anim = "dance_loop", time = -1 },
		{ block = "dancing", anim = "dan_down_a", time = -1 },
		{ block = "dancing", anim = "dan_left_a", time = -1 },
		{ block = "dancing", anim = "dan_loop_a", time = -1 },
		{ block = "dancing", anim = "dan_right_a", time = -1 },
		{ block = "dancing", anim = "dan_up_a", time = -1 },
		{ block = "dancing", anim = "dnce_M_a", time = -1 },
		{ block = "dancing", anim = "dnce_M_b", time = -1 },
		{ block = "dancing", anim = "dnce_M_c", time = -1 },
		{ block = "dancing", anim = "dnce_M_d", time = -1 },
		{ block = "dancing", anim = "dnce_M_e", time = -1 },
	},
	reparar =
	{
		{ block = "car", anim = "fixn_car_loop", time = -1, updatePosition = false },
	},
	manos =
	{
		{ block = "ghands", anim = "gsign1", time = 4000 },
		{ block = "ghands", anim = "gsign1lh", time = 4000 },
		{ block = "ghands", anim = "gsign2", time = 4000 },
		{ block = "ghands", anim = "gsign2lh", time = 4000 },
		{ block = "ghands", anim = "gsign3", time = 4000 },
		{ block = "ghands", anim = "gsign3lh", time = 4000 },
		{ block = "ghands", anim = "gsign4", time = 4000 },
		{ block = "ghands", anim = "gsign4lh", time = 4000 },
		{ block = "ghands", anim = "gsign5", time = 4000 },
		{ block = "ghands", anim = "gsign5lh", time = 4000 },
		{ block = "ghands", anim = "gsign1", time = 4000 },
	},
	hablar =
	{
		{ block = "gangs", anim = "prtial_gngtlka", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkb", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkc", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkd", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlke", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkf", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkg", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkh", time = 4000 },
		{ block = "gangs", anim = "prtial_gngtlkh", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkb", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkc", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkd", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlke", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkf", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkg", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkh", time = 4000 },
		{ block = "lowrider", anim = "prtial_gngtlkh", time = 4000 },
	},
	esperar =
	{
		{ block = "cop_ambient", anim = "coplook_loop", time = -1 },
		{ block = "dealer", anim = "dealer_idle", time = -1 },
		{ block = "dealer", anim = "dealer_idle_02", time = -1 },
		{ block = "dealer", anim = "dealer_idle_02", time = -1 },
		{ block = "dealer", anim = "dealer_idle_03", time = -1 },
		{ block = "fat", anim = "fatidle", time = -1 },
	
	},
	vigilar =
	{
		{ block = "gangs", anim = "dealer_idle", time = -1 },
		{ block = "camera", anim  = "camstnd_lkabt", time = -1, loop = false },
	},
	besar =
	{
		{ block = "kissing", anim = "grlfrd_kiss_01", time = 4000 },
		{ block = "kissing", anim = "grlfrd_kiss_02", time = 5000 },
		{ block = "kissing", anim = "grlfrd_kiss_03", time = 6000 },
		{ block = "kissing", anim = "playa_kiss_01", time = 4000 },
		{ block = "kissing", anim = "playa_kiss_02", time = 5000 },
		{ block = "kissing", anim = "playa_kiss_03", time = 6000 },
	},
	relajarse =
	{
		{ block = "beach", anim = "sitnwait_loop_w", time = -1 },
		{ block = "beach", anim = "lay_bac_loop", time = -1 },
		{ block = "int_house", anim = "bed_loop_l", time = -1 },
		{ block = "int_house", anim = "bed_loop_r", time = -1 },
	},
	apoyarse =
	{
		{ block = "gangs", anim = "leanidle", time = -1 },
	},
	no =
	{
		{ block = "gangs", anim = "invite_no", time = 4000 },
	},
	revisarse =
	{
		{ block = "clothes", anim = "clo_pose_torso", time = -1 },
		{ block = "clothes", anim = "clo_pose_shoes", time = -1 },
		{ block = "clothes", anim = "clo_pose_legs", time = -1 },
		{ block = "clothes", anim = "clo_pose_watch", time = -1 },
	},
	sentarse =
	{
		{ block = "food", anim = "ff_Sit_eat1", time = -1 },
		{ block = "ped", anim = "seat_idle", time = -1 },
		{ block = "beach", anim = "parksit_m_loop", time = -1 },
		{ block = "beach", anim = "parksit_w_loop", time = -1 },
		{ block = "sunbathe", anim = "parksit_m_idlec", time = -1 },
		{ block = "sunbathe", anim = "parksit_w_idlea", time = -1 },
		{ block = "attractors", anim = "stepsit_in", time = 1200 },
		{ block = "attractors", anim = "stepsit_loop", time = -1 },
		{ block = "int_house", anim = "lou_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_drink", time = -1 },
		{ block = "int_office", anim = "off_sit_idle_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_read", time = -1 },
		{ block = "int_office", anim = "off_sit_watch", time = -1 },
		{ block = "jst_buisness", anim = "girl_02", time = -1 },
	},
	fumar =
	{
		{ block = "lowrider", anim = "m_smkstnd_loop", time = -1 },
		{ block = "lowrider", anim = "m_smklean_loop", time = -1 },
		{ block = "lowrider", anim = "f_smklean_loop", time = -1 },
		{ block = "gangs", anim = "smkcig_prtl", time = -1 },
	},
	pensar =
	{
		{ block = "cop_ambient", anim = "coplook_think", time = -1 },
	},
	vomitar =
	{
		{ block = "food", anim = "eat_vomit_p", time = 7000 },
	},
	cansado =
	{
		{ block = "fat", anim = "idle_tired", time = -1 },
		{ block = "ped", anim = "idle_tired", time = -1 },
	},
	saludar =
	{
		{ block = "kissing", anim = "gfwave2", time = 2500 },
	},
	si =
	{
		{ block = "gangs", anim = "invite_yes", time = 4000 },
	},
	mover = 
	{
		{block = "airport", anim = "thrw_barl_thrw", updatePosition = false, loop = false, time = -1 },
	},
	bloquear =
	{
		{block = "bsktball", anim = "bball_def_loop", updatePosition = false, time = -1 },
	},
	agacharse = 
	{
		{ block = "camera", anim = "camcrch_idleloop", time = -1},
	},
	acercate =
	{
		{ block = "camera", anim = "camcrch_cmon", time = -1 },
		{ block = "camera", anim = "camstnd_cmon", time = -1 },
	},
	buscar =
	{
		{ block = "cop_ambient", anim = "copbrowse_loop", time = -1 },
	},
	dedo =
	{
		{ block = "misc", anim = "hiker_pose", updatePosition = false, time = -1},
		{ block = "misc", anim = "hiker_pose_L", updatePosition = false, time = -1},
	},
	mear =
	{
		{ block = "paulnmac", anim = "piss_loop", updatePosition = false, time = -1},
	},
	panico =
	{
		{ block = "ped", anim = "duck_cower", time = -1, loop = true},
	},
	alerta = 
	{
		{ block = "ped", anim = "fightidle", updatePosition = false, time = -1 },
		{ block = "ped", anim = "gun_stand", time = -1},
	},
	fuck =
	{
		{ block = "ped", anim = "fucku", loop = false, time = -1},
	},
	enojarse =
	{
		{ block = "riot", anim = "riot_angry", time = -1 },
		{ block = "riot", anim = "riot_chant", time = -1, loop = false},
		{ block = "riot", anim = "riot_fuku", time = -1, loop = false },	
	},
	gritar = 
	{
		{ block = "riot", anim = "riot_shout", time = -1, loop = false},
	},
	patada = 
	{
		{ block = "police", anim = "door_kick", time = -1},
	},
	levantarmanos = 
	{
		{ block = "ped", anim = "handsup", time = -1, updatePosition = false, loop = false },
	},
	caminar = 
	{
		{ block = "ped", anim = "walk_civi", time = -1, updatePosition = true, loop = true },
	},
}

function vanims (player)
outputChatBox("/bar [1-7], /batear [1-7], /bomba, /crack [1-5], /levantarmanos, /patada, /gritar, /enojarse [1-3]", player, 255,255,255)
outputChatBox("/fuck, /alerta [1-2], /panico, /mear, /dedo [1-2], /buscar, /acercate [1-2], /agacharse, /bloquear, /mover", player, 255,255,255)
outputChatBox("/si, /saludar, /cansado [1-2], /vomitar, /pensar, /fumar [1-4], /sentarse [1-14], /revisarse [1-4], /no", player, 255,255,255)
outputChatBox("/apoyarse, /relajarse [1-4], /besar [1-6], /vigilar [1-2], /esperar [1-6], /hablar [1-17], /manos [1-11]", player, 255,255,255)
outputChatBox("/reparar, /bailar [1-11], /rcp, /caminar", player, 255,255,255)
end
addCommandHandler("veranims", vanims)

local function setAnim( player, anim )
	if isElement( player ) and anim and not isPedInVehicle( player ) then
		setPedAnimation( player, anim.block, anim.anim, anim.time or -1, anim.loop == nil and anim.time == -1 or anim.loop or false, anim.updatePosition or false, true )
	end
end

-- play an animation sequence
local function playAnim( player, anim )
	-- time spent on all anims till now
	local time = 0
	
	for key, value in ipairs( anim ) do
		if time == 0 then
			-- first anim, set it directly
			setAnim( player, value )
		else
			-- set the anim delayed
			setTimer( setAnim, time, 1, player, value )
		end
		
		if value.time == -1 then
			-- we got an infinite running anim, no point to check any further
			time = 0
			break
		else
			time = time + value.time
		end
	end
end

--

for key, value in pairs( anims ) do
	addCommandHandler( key,
		function( player, commandName, num )
			if getElementData(player, "isLoged") then
				local anim = tonumber( num ) and value[ tonumber( num ) ] or value[ anim ] or #value == 0 and value or value[ 1 ]
				
				if #anim == 0 then
					anim = { anim }
				end
				
				playAnim( player, anim )
			end
		end
	)
end

--

local function stopAnim( player )
	if getElementData(player, "isLoged") then
		if getElementData(player, "muerte") == false then
		setPedAnimation( player )
		end
	end
end
addCommandHandler( "pararanim", stopAnim )

addEvent( "anims:reset", true )
addEventHandler( "anims:reset", root,
	function( )
		if client == source then
			stopAnim( source )
		end
	end
)

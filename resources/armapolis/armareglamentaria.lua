for _, skill in ipairs({"poor", "std", "pro"}) do 
    setWeaponProperty(24, skill, "weapon_range", 75)
	setWeaponProperty(24, skill, "accuracy", 100)	
	setWeaponProperty(24, skill, "flags", 0x000020)
	setWeaponProperty(24, skill, "flags", 0x000010)
	setWeaponProperty(24, skill, "anim_loop_stop", 0.65)
    setWeaponProperty(24, skill, "anim2_loop_stop", 0.65)
	setWeaponProperty(24, skill, "maximum_clip_ammo", 17)
	setWeaponProperty(24, skill, "move_speed", 1.3)
	setWeaponProperty(24, skill, "damage", 40)
end

addEventHandler ("onClientResourceStart", resourceRoot,
function() 
   arma = engineLoadTXD ( "Models/deagle.txd" )
        engineImportTXD ( arma, 348)
   armaDFF = engineLoadDFF ( "Models/deagle.dff")
        engineReplaceModel ( armaDFF, 348)
end)

--addEventHandler("onClientPlayerWeaponFire", root, 
--function(weapon, ammo, ammoInClip) 
    --setWorldSoundEnabled(5, 24, false, true)
	--setWorldSoundEnabled(5, 77, false, true)
	--setWorldSoundEnabled(5, 76, false, true)
    --local x, y, z = getElementPosition(localPlayer) 
    --if weapon == 24 then 
       --local sound = playSound3D("glocksound.wav", x, y, z) 
       --setSoundMaxDistance(sound, 120) 
    --end 
--end) 


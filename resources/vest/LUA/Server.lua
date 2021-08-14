addEventHandler( "onResourceStart", resourceRoot,
	function()
		db = dbConnect('sqlite', 'sql.db')
	end
)

addEvent('Usar:SkinF', true)
addEventHandler('Usar:SkinF', root,
	function(id)
		client:setModel(id)	
	end
)

addEventHandler('onPlayerSpawn', root,
	function()
		setTimer(function(player)
			local idchar = player:getData('idUnique:')
			if tonumber(idchar) then

				local qhq = db:query('select * from save where id=?', idchar)
				local qh = dbPoll(qhq, -1)

				if qh and #qh == 1 then
					player:setData('Skins:Save', fromJSON(qh[1].skin))
				end
				
				dbFree(qhq)
			end
		end,1000,1, source)
	end, true, 'low-10'
)

addEventHandler('onPlayerQuit', root,
	function()
		local idchar = source:getData('idUnique:')
		if tonumber(idchar) then

			local cache = source:getData('Skins:Save') or {}
			local qhq = db:query('select * from save where id=?', idchar)
			local resp = dbPoll(qhq, -1)
			
			if resp and #resp == 1 then
				db:exec('update save set skin=? where id=?', toJSON(cache), idchar)
			else
				db:exec('insert into save values(?,?)', idchar, toJSON(cache))
			end

			dbFree(qhq)
		end
	end
)

shader = {}
objeto = {}

shaderb = {}
objetob = {}

local carteles = {
	-- ID, X, Y, Z, RX, RY, RZ, IMAGEN
	{11455, 50.253, -198.964, 2.6, 0, 0, 357.495, "tribunal.png", "des_nwmed" },
	{11611, 329, -62.8, 3.8, 0, 0, 304.5, "zexen.png", "des_sheriffsign" },
	{11455, 2304.1298828125, -12.199999809265, 29.10000038147, 0, 0, 90, "bancopalomino.png", "des_nwmed" },

	---{11455, 268.60000610352, -145.60000610352, 3.2999999523163, 0, 0, 90, "visispublicas.png", "des_nwmed" },
	{11611, 345, -80.5, 3, 0, 0, 45, "oficinaempleo.png", "des_sheriffsign" },
	


}

local texglobales = { -- USAR EN CASO DE QUE NO HAYA OBJETO EN EL MAP

	-- EAGLE SECURITY
	{"dt_ammu_sign1", "eagle1.png"},
	{"dt_ammu_sign2", "eagle2.png"},
	{"sffront5_256", "pared.png"},

}

addEventHandler( "onClientResourceStart", resourceRoot,
	function( )
		for i=1, #carteles do 
			local v =  carteles[i]
			local id, x, y, z, rx, ry, rz, img, texrep = unpack( v )
			
			objeto[i] = createObject( id, x, y, z, rx, ry, rz )
			shader[i] = dxCreateShader( "texreplace.fx" )
			engineApplyShaderToWorldTexture( shader[i], texrep, objeto[i] )
			dxSetShaderValue( shader[i], "gTexture", dxCreateTexture( img ) )
		end
		
		for i=1, #texglobales do 
			local v =  texglobales[i]
			local texrep, img = unpack( v )
			
			shaderb[i] = dxCreateShader( "texreplace.fx" )
			engineApplyShaderToWorldTexture( shaderb[i], texrep )
			dxSetShaderValue( shaderb[i], "gTexture", dxCreateTexture( img ) )
		end
	end
)

-- des_nwmed el de medicos, des_sheriffsign pacos, dt_ammu_sign1 ammoputa,
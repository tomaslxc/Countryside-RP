    r_title = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":personajes/fonts/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 )
    shadersw = {}
    textw = {}
function setItemShader(player, itid)
    if itid == "tazer" then
    shadersw[player] = {}
    textw[player] = {}
    shadersw[player] = dxCreateShader("shader.fx", 0, 0, true, "ped")
    textw[player] = dxCreateTexture(""..itid..".png" or "img/plantilla.png")
    engineApplyShaderToWorldTexture( shadersw[player], "desert_eagle2", player)
    dxSetShaderValue(shadersw[player],"gTexture",textw[player])
    end
end
addEvent("aplyShader", true)
addEventHandler("aplyShader", localPlayer, setItemShader)
function desetItemShader(player, itid)
    if itid == "tazer" then
        if shadersw[player] ~= nil then
        engineRemoveShaderFromWorldTexture(shadersw[player], "desert_eagle2", player)
        end
    end
end
addEvent("removeShader", true)
addEventHandler("removeShader", localPlayer, desetItemShader)
function remotePlayerJoin()
    for i,v in ipairs(getElementsByType("player")) do
        if getElementData(v, "tazer") then
            setItemShader(v, "tazer")
        end
    end
end
addEventHandler("onClientPlayerJoin", getRootElement(), remotePlayerJoin)

local screenW, screenH = guiGetScreenSize()

local inv = {}
function openInv()
	if isBolsillosShowing then
		isBolsillosShowing = false
		showCursor(false)
		itemOptions = false
	else
		isBolsillosShowing = true
		isPanelRapidoShowing = true
		showCursor(true)
	end
end
addEvent("open:inve", true)
addEventHandler("open:inve", localPlayer, openInv)
function actualizarInv(datai)
	inv = datai
	isPanelRapidoShowing = true
end
addEvent('pasar:inv',true)
addEventHandler('pasar:inv', localPlayer, actualizarInv)

----------------ITEMS SELECCIONADOS--
lastSelectedItem = 0
selectedItem = 0
disparando = false

function getSelectedItem()
	if selectedItem == 0 then
		return {0,0}
	else
	return inv[selectedItem]
	end
end

function dxDrawSelectedItemMark(item)
	if isPanelRapidoShowing then
		if item == 2 then
			dxDrawLine(screenW * 0.9506, screenH * 0.3578, screenW * 0.9506, screenH * 0.4167, tocolor(255, 255, 255, 255), 1.5, false)
		elseif item == 3 then
			dxDrawLine(screenW * 0.9506, screenH * 0.4244, screenW * 0.9506, screenH * 0.4833, tocolor(255, 255, 255, 255), 1.5, false)
		elseif item == 4 then
			dxDrawLine(screenW * 0.9506, screenH * 0.4911, screenW * 0.9506, screenH * 0.5500, tocolor(255, 255, 255, 255), 1.5, false)
		elseif item == 5 then
			dxDrawLine(screenW * 0.9506, screenH * 0.5611, screenW * 0.9506, screenH * 0.6200, tocolor(255, 255, 255, 255), 1.5, false)
		elseif item == 6 then
			dxDrawLine(screenW * 0.9506, screenH * 0.6500, screenW * 0.9506, screenH * 0.7089, tocolor(255, 255, 255, 255), 1.5, false)
		elseif item == 7 then
			dxDrawLine(screenW * 0.9506, screenH * 0.7211, screenW * 0.9506, screenH * 0.7800, tocolor(255, 255, 255, 255), 1.5, false)
		end
	end
end



if not isCursorShowing() and getElementData(localPlayer, "isLoged") and not disparando then
	if selectedItem == 0 or selectedItem == 2 then
		for i = 7,2,-1 do 
		   if inv[i][1] ~= 0 then
		   		local pitem = getSelectedItem()
		   		lastSelectedItem = selectedItem
		   		selectedItem = i
		   		local newitem = getSelectedItem()
			   	asignarItem(newitem, pitem)
		   		break
		   end
		end
	else
		for i = (selectedItem-1),2,-1 do 
		   if inv[i][1] ~= 0 then
		   		local pitem = getSelectedItem()
		   		lastSelectedItem = selectedItem
		   		selectedItem = i
		   		local newitem = getSelectedItem()
			   	asignarItem(newitem, pitem)
		   		break
		   end
		   if i == 2 and inv[i][1] == 0 then
		   	local pitem = getSelectedItem()
		   	lastSelectedItem = selectedItem
		   	selectedItem = 0
		   	asignarItem(0, pitem)
		   	break
		   end
		end
	end
end
end)

bindKey( "",  "", function( )
if not isCursorShowing() and getElementData(localPlayer, "isLoged") and not disparando then
	if selectedItem == 0 or selectedItem == 7 then
		for i = 2, 7, 1 do 
		   if inv[i][1] ~= 0 then
		   		local pitem = getSelectedItem()
		   		lastSelectedItem = selectedItem
		   		selectedItem = i
		   		local newitem = getSelectedItem()
			   	asignarItem(newitem, pitem)
		   		break
		   end
		end
	else
		for i = (selectedItem+1), 7, 1 do 
		   if inv[i][1] ~= 0 then
		   		local pitem = getSelectedItem()
		   		lastSelectedItem = selectedItem
		   		selectedItem = i
		   		local newitem = getSelectedItem()
			   	asignarItem(newitem, pitem)
		   		break
		   end
		   if i == 7 and inv[i][1] == 0 then
		   	local pitem = getSelectedItem()
		   	lastSelectedItem = selectedItem
		   	selectedItem = 0
		   	asignarItem(0, pitem)
		   	break
		   end
		end
	end
end
end)

bindKey( "q", "down", function( )
if not isCursorShowing() and getElementData(localPlayer, "isLoged") and not disparando then
	local pitem = getSelectedItem()
	lastSelectedItem = selectedItem
   	selectedItem = 0
   	asignarItem(0, pitem)
end
end)

---------paneles y items ( mostrando )
isPanelRapidoShowing = false
isBolsillosShowing = false



items = {
    [1] = {name="Patatas fritas",isStackeable=true, itype="comida", value=0},
    [2] = {name="Pizza",isStackeable=true, itype="comida", value=0},
    [3] = {name="Ensalada",isStackeable=true, itype="comida", value=0},
    [4] = {name="Agua",isStackeable=true, itype="bebida", value=0},
    [5] = {name="Vino",isStackeable=true, itype="bebida", value=0},
    [6] = {name="Cerveza",isStackeable=true, itype="bebida", value=0},
    [7] = {name="Whisky",isStackeable=true, itype="bebida", value=0},
    [8] = {name="Sprunk",isStackeable=true, itype="bebida", value=0},
    [9] = {name="Perrito caliente",isStackeable=true, itype="comida", value=0},
    [10] = {name="Helado",isStackeable=true, itype="comida", value=0},
    [11] = {name="Vodka",isStackeable=true, itype="bebida", value=0},
    [12] = {name="Llave de vehículo",isStackeable=false, itype="llave", value=0},
    [13] = {name="Llave de propiedad",isStackeable=false, itype="llave", value=0},
    [14] = {name="Colt 45",isStackeable=false, itype="arma", value=22},
    [15] = {name="Granada de mano",isStackeable=false, itype="arma", value=16},
    [16] = {name="iPhone",isStackeable=false, itype="telefono", value=0},
    [17] = {name="Samsung",isStackeable=false, itype="telefono", value=0},
    [18] = {name="Tarjeta de crédito",isStackeable=false, itype="tarjeta", value=0},
    [19] = {name="Cheque bancario",isStackeable=false, itype="cheque", value=0},
    [20] =  {name="DNI",isStackeable=false, itype="documento", value=0},
    [21] =  {name="Licencia de Conducir",isStackeable=false, itype="documento", value=0},
    [22] =  {name="Licencia de Arma",isStackeable=false, itype="documento", value=0},
    [23] =  {name="WalkieTalkie",isStackeable=false, itype="misc", value=0},
    [24] =  {name="GPS",isStackeable=false, itype="misc", value=0},
    [25] =  {name="Reloj",isStackeable=false, itype="misc", value=0},
    [26] =  {name="CD",isStackeable=false, itype="misc", value=0},
    [27] =  {name="Pendrive",isStackeable=false, itype="misc", value=0},
    [28] =  {name="RadioCoche",isStackeable=false, itype="misc", value=0},
    [29] =  {name="Cámara de Fotos",isStackeable=false, itype="arma", value=43},
    [30] =  {name="Hamburguesa",isStackeable=false, itype="comida", value=0},
    [31] =  {name="Lata de sardinas",isStackeable=true, itype="comida", value=0},
    [32] =  {name="Sopa instantánea",isStackeable=false, itype="comida", value=0},
    [33] =  {name="Macarrones",isStackeable=false, itype="comida", value=0},
    [34] =  {name="Manzana",isStackeable=true, itype="comida", value=0},
    [35] =  {name="Banana",isStackeable=true, itype="comida", value=0},
    [36] =  {name="Naranja",isStackeable=true, itype="comida", value=0},
    [37] =  {name="Pera",isStackeable=true, itype="comida", value=0},
    [38] =  {name="Mango",isStackeable=true, itype="comida", value=0},
    [39] =  {name="Tomate",isStackeable=true, itype="comida", value=0},
    [40] =  {name="Lechuga",isStackeable=true, itype="comida", value=0},
    [41] =  {name="Galletas",isStackeable=true, itype="comida", value=0},
    [42] =  {name="Chocolate",isStackeable=true, itype="comida", value=0},
    [43] =  {name="Crack",isStackeable=true, itype="droga", value=0},
    [44] =  {name="Marihuana",isStackeable=true, itype="droga", value=0},
    [45] =  {name="Heroína",isStackeable=true, itype="droga", value=0},
    [46] =  {name="Cocaína",isStackeable=true, itype="droga", value=0},
    [47] =  {name="Alarma coche",isStackeable=false, itype="misc", value=0},
    [48] =  {name="Duplicar llaves",isStackeable=false, itype="misc", value=0},
    [49] =  {name="Mechero",isStackeable=false, itype="misc", value=0},
    [50] =  {name="Papel de liar",isStackeable=false, itype="misc", value=0},
    [51] =  {name="Tabaco",isStackeable=false, itype="misc", value=0},
    [52] =  {name="Ganzúas",isStackeable=false, itype="misc", value=0},
    [53] =  {name="Jeringas",isStackeable=false, itype="misc", value=0},
    [54] =  {name="Bong",isStackeable=false, itype="misc", value=0},
    [55] =  {name="Caja",isStackeable=false, itype="contenedor", value=0},
    [56] =  {name="Mochila pequeña",isStackeable=false, itype="contenedor", value=0},
    [57] =  {name="Mochila mediana",isStackeable=false, itype="contenedor", value=0},
    [58] =  {name="Mochila grande",isStackeable=false, itype="contenedor", value=0},
    [59] =  {name="Maleta",isStackeable=false, itype="contenedor", value=0},
    [60] =  {name="Maletin",isStackeable=false, itype="contenedor", value=0},
    [61] =  {name="Bolsa de deporte",isStackeable=false, itype="contenedor", value=0},
    [62] =  {name="Bolsa de la compra",isStackeable=false, itype="contenedor", value=0},
    [63] =  {name="Palanca",isStackeable=false, itype="mecanico", value=0},
    [64] =  {name="Juego de herramientas",isStackeable=false, itype="mecanico", value=0},
    [65] =  {name="Compresor",isStackeable=false, itype="mecanico", value=0},
    [66] =  {name="Bujía",isStackeable=false, itype="pieza", value=0},
    [67] =  {name="Neumático",isStackeable=false, itype="pieza", value=0},
    [68] =  {name="Correa de distribución",isStackeable=false, itype="pieza", value=0},
    [69] =  {name="Batería",isStackeable=false, itype="pieza", value=0},
    [70] =  {name="Carburador",isStackeable=false, itype="pieza", value=0},
    [71] =  {name="Analgésicos",isStackeable=false, itype="medicina", value=0},
    [72] =  {name="Vendaje",isStackeable=false, itype="medicina", value=0},
    [73] =  {name="Jeringas",isStackeable=false, itype="medicina", value=0},
    [74] =  {name="Agua oxigenada",isStackeable=false, itype="medicina", value=0},
    [75] =  {name="Morfina",isStackeable=false, itype="medicina", value=0},
    [76] =  {name="Desfibrilador",isStackeable=false, itype="medicina", value=0},
    [77] =  {name="Alcohol antiséptico",isStackeable=false, itype="medicina", value=0},
    [78] =  {name="Radio",isStackeable=false, itype="police", value=0},
    [79] =  {name="Esposas",isStackeable=false, itype="police", value=0},
    [80] =  {name="Medidor de alcoholemia",isStackeable=false, itype="police´", value=0},
    [81] =  {name="Taser",isStackeable=false, itype="arma", value="taser"},
    [82] =  {name="Manopla",isStackeable=false, itype="arma", value=1},
    [83] =  {name="Palo de golf",isStackeable=false, itype="arma", value=2},
    [84] =  {name="Bate de baseball",isStackeable=false, itype="arma", value=5},
    [85] =  {name="Porra de policía",isStackeable=false, itype="arma", value=3},
    [86] =  {name="Cuchillo",isStackeable=false, itype="arma", value=4},
    [87] =  {name="Katana",isStackeable=false, itype="arma", value=8},
    [88] =  {name="Pala",isStackeable=false, itype="arma", value=6},
    [89] =  {name="Taco de billar",isStackeable=false, itype="arma", value=7},
    [90] =  {name="Motosierra",isStackeable=false, itype="arma", value=9},
    [91] =  {name="Colt 45",isStackeable=false, itype="arma", value=22},
    [92] =  {name="Colt 45 Silenciada",isStackeable=false, itype="arma", value=23},
    [93] =  {name="Desert Eagle",isStackeable=false, itype="arma", value=24},
    [94] =  {name="Escopeta",isStackeable=false, itype="arma", value=25},
    [95] =  {name="Escopeta recortada",isStackeable=false, itype="arma", value=26},
    [96] =  {name="Escopeta de combate",isStackeable=false, itype="arma", value=27},
    [97] =  {name="Uzi",isStackeable=false, itype="arma", value=28},
    [98] =  {name="MP5",isStackeable=false, itype="arma", value=29},
    [99] =  {name="TEC-9",isStackeable=false, itype="arma", value=32},
    [100] =  {name="Kalashnikov",isStackeable=false, itype="arma", value=30},
    [101] =  {name="M4",isStackeable=false, itype="arma", value=31},
    [102] =  {name="Rifle de caza",isStackeable=false, itype="arma", value=33},
    [103] =  {name="Rifle de francotirador",isStackeable=false, itype="arma", value=34},
    [104] =  {name="RPG",isStackeable=false, itype="arma", value=35},
    [105] =  {name="Lanzador teledirigido",isStackeable=false, itype="arma", value=36},
    [106] =  {name="Lanzallamas",isStackeable=false, itype="arma", value=37},
    [107] =  {name="Minigun",isStackeable=false, itype="arma", value=38},
    [108] =  {name="Gas lacrimógeno",isStackeable=false, itype="arma", value=17},
    [109] =  {name="Molotov",isStackeable=false, itype="arma", value=18},
    [110] =  {name="Tarjeta de credito",isStackeable=false, itype="arma", value=39},
    [111] =  {name="Spray de pintura",isStackeable=false, itype="arma", value=41},
    [112] =  {name="Extintor",isStackeable=false, itype="arma", value=42},
    [113] =  {name="Dildo violeta",isStackeable=false, itype="arma", value=10},
    [114] =  {name="Dildo",isStackeable=false, itype="arma", value=11},
    [115] =  {name="Vibrador",isStackeable=false, itype="arma", value=12},
    [116] =  {name="Ramo de flores",isStackeable=false, itype="arma", value=14},
    [117] =  {name="Bastón",isStackeable=false, itype="arma", value=15},
    [118] =  {name="Vision nocturna",isStackeable=false, itype="arma", value=44},
    [119] =  {name="Infrarojos",isStackeable=false, itype="arma", value=45},
    [120] =  {name="Paracaidas",isStackeable=false, itype="arma", value=46},
    [121] =  {name="Detonador",isStackeable=false, itype="arma", value=40},
    [122] =  {name="Cargador de Pistola",isStackeable=false, itype="cargador", value=0},
    [123] =  {name="Cargador de Escopeta",isStackeable=false, itype="cargador", value=0},
    [124] =  {name="Cargador de Rifle",isStackeable=false, itype="cargador", value=0},
    [125] =  {name="Cargador de Sniper",isStackeable=false, itype="cargador", value=0}
   
   
}
		
function isCursorHover( posX, posY, width, height )
	if isCursorShowing( ) then
		local mouseX, mouseY = getCursorPosition( )
		local clientW, clientH = guiGetScreenSize( )
		local mouseX, mouseY = mouseX * clientW, mouseY * clientH
		if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
			return true
		end
	end
	return false
end


isItemInCursor = false
itemOptions = false
optionsSelected = false
absoluteXPanel = 0
absoluteYPanel = 0

addEventHandler("onClientRender", root,
function()
	if getElementData(localPlayer, 'isLoged') and exports.hud:isHud() then
	--coordenadas raton--
		if isCursorShowing() then
		mmmx,mmmy = getCursorPosition ()
		local fullx,fully = guiGetScreenSize()
		cursorx,cursory = mmmx*fullx,mmmy*fully
		end
	----
	if isPanelRapidoShowing or isBolsillosShowing then
		-- ACCESO RÁPIDO --
        dxDrawRectangle(screenW * 0.9487, screenH * 0.3456, screenW * 0.0488, screenH * 0.4478, tocolor(0, 0, 0, 135), false)
        dxDrawRectangle(screenW * 0.9550, screenH * 0.3567, screenW * 0.0362, screenH * 0.0611, tocolor(0, 0, 0, 255), false)--rap1
        dxDrawRectangle(screenW * 0.9550, screenH * 0.4244, screenW * 0.0362, screenH * 0.0611, tocolor(0, 0, 0, 255), false)--rap2
        dxDrawRectangle(screenW * 0.9550, screenH * 0.4922, screenW * 0.0362, screenH * 0.0611, tocolor(0, 0, 0, 255), false)--rap3
        dxDrawRectangle(screenW * 0.9550, screenH * 0.5600, screenW * 0.0362, screenH * 0.0611, tocolor(0, 0, 0, 255), false)--rap4
        dxDrawRectangle(screenW * 0.9550, screenH * 0.6489, screenW * 0.0362, screenH * 0.0611, tocolor(0, 0, 0, 255), false)--pecho
        dxDrawRectangle(screenW * 0.9550, screenH * 0.7211, screenW * 0.0362, screenH * 0.0611, tocolor(0, 0, 0, 255), false)--espalda
        dxDrawRectangle(screenW * 0.9775, screenH * 0.3133, screenW * 0.0200, screenH * 0.0322, tocolor(0, 0, 0, 135), false)--cierre
        dxDrawLine(screenW * 0.9481, screenH * 0.6344, screenW * 0.9962, screenH * 0.6344, tocolor(255, 255, 255, 255), 1, false)
		if isBolsillosShowing then
		dxDrawRectangle(screenW * 0.8938, screenH * 0.3456, screenW * 0.0488, screenH * 0.4478, tocolor(0, 0, 0, 135), false)
        dxDrawRectangle(screenW * 0.8938, screenH * 0.3144, screenW * 0.0800, screenH * 0.0267, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(screenW * 0.8944, screenH * 0.3656, screenW * 0.0475, screenH * 0.0744, tocolor(0, 0, 0, 255), false)--bols1
        dxDrawRectangle(screenW * 0.8944, screenH * 0.4767, screenW * 0.0475, screenH * 0.0744, tocolor(0, 0, 0, 255), false)--bols2
        dxDrawRectangle(screenW * 0.8944, screenH * 0.5856, screenW * 0.0475, screenH * 0.0744, tocolor(0, 0, 0, 255), false)--bols3
        dxDrawRectangle(screenW * 0.8944, screenH * 0.6944, screenW * 0.0475, screenH * 0.0744, tocolor(0, 0, 0, 255), false)--bols4
    	end
		if inv[2][1] ~= 0 then
			if isItemInCursor == "rap1" then
			dxDrawImage(cursorx, cursory,screenW * 0.0362, screenH * 0.0600,":items/img/"..inv[2][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itemrap1
			else
			dxDrawImage(screenW * 0.9550, screenH * 0.3578, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[2][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itemrap1
			end
		end
        if inv[3][1] ~= 0 then
	        if isItemInCursor == "rap2" then
			dxDrawImage(cursorx, cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[3][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itemrap2
			else
			dxDrawImage(screenW * 0.9550, screenH * 0.4244, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[3][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itemrap2
			end
		end
		if inv[4][1] ~= 0 then
			if isItemInCursor == "rap3" then
			dxDrawImage(cursorx, cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[4][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itemrap3
			else
			dxDrawImage(screenW * 0.9550, screenH * 0.4922, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[4][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itemrap3
			end
        end
        if inv[5][1] ~= 0 then
	        if isItemInCursor == "rap4" then
			dxDrawImage(cursorx, cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[5][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itemrap4
			else
			dxDrawImage(screenW * 0.9550, screenH * 0.5600, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[5][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itemrap4
			end
		end
		if inv[6][1] ~= 0 then
			if isItemInCursor == "pecho" then
			dxDrawImage(cursorx, cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[6][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--pecho
			else
			dxDrawImage(screenW * 0.9550, screenH * 0.6489, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[6][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--pecho
			end
		end
        if inv[7][1] ~= 0 then
	        if isItemInCursor == "espalda" then
			dxDrawImage(cursorx, cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[7][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--espalda
			else
			dxDrawImage(screenW * 0.9550, screenH * 0.7222, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[7][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--espalda
			end
        end

        if isBolsillosShowing then
        	dxDrawText("X", screenW * 0.9775, screenH * 0.3133, screenW * 0.9975, screenH * 0.3456, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        else
        	dxDrawText(">", screenW * 0.9775, screenH * 0.3133, screenW * 0.9975, screenH * 0.3456, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
        end
        

    else
    	dxDrawRectangle(screenW * 0.9775, screenH * 0.3133, screenW * 0.0200, screenH * 0.0322, tocolor(0, 0, 0, 135), false)
    	dxDrawText("<", screenW * 0.9775, screenH * 0.3133, screenW * 0.9975, screenH * 0.3456, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
   	end
		
		--- BOLSILLOS ---
	if isBolsillosShowing then
        dxDrawText("BOLSILLOS", screenW * 0.8931, screenH * 0.3144, screenW * 0.9738, screenH * 0.3411, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
   
        if inv[8][1] ~= 0 then
        	if isItemInCursor == "bols1" then
        		dxDrawImage(cursorx,cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[8][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itembolsillo1
        	else
        		dxDrawImage(screenW * 0.8994, screenH * 0.3689, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[8][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itembolsillo1
        	end
        end
        if inv[9][1] ~= 0 then
        	if isItemInCursor == "bols2" then
        		dxDrawImage(cursorx,cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[9][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itembolsillo2
        	else
        		dxDrawImage(screenW * 0.9000, screenH * 0.4811, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[9][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itembolsillo2
        	end
        end
        if inv[10][1] ~= 0 then
        	if isItemInCursor == "bols3" then
        		dxDrawImage(cursorx,cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[10][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itembolsillo3
        	else
        		dxDrawImage(screenW * 0.9000, screenH * 0.5933, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[10][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itembolsillo3
        	end
        end
        if inv[11][1] ~= 0 then
        	if isItemInCursor == "bols4" then
        		dxDrawImage(cursorx,cursory, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[11][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 150), true)--itembolsillo4
        	else
        		dxDrawImage(screenW * 0.9000, screenH * 0.7044, screenW * 0.0362, screenH * 0.0600, ":items/img/"..inv[11][1]..".png" or "img/plantilla.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)--itembolsillo4
        	end
        end

   --      if itemOptions then
   --      	dxDrawRectangle(screenW * absoluteXPanel, screenH * absoluteYPanel, screenW * 0.0325, screenH * 0.1389, tocolor(100, 100, 100, 200), true)
   --      	if isCursorHover(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0045), screenW * 0.0325, screenH * 0.0278) then
   --      		dxDrawRectangle(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0045), screenW * 0.0325, screenH * 0.0278, tocolor(70, 70, 70, 255), true)
   --      	else
   --      		dxDrawRectangle(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0045), screenW * 0.0325, screenH * 0.0278, tocolor(31, 31, 31, 255), true)
   --      	end
		 --    if isCursorHover(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0511), screenW * 0.0325, screenH * 0.0278) then
		 --    	dxDrawRectangle(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0511), screenW * 0.0325, screenH * 0.0278, tocolor(70, 70, 70, 255), true)
			-- else
			-- 	dxDrawRectangle(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0511), screenW * 0.0325, screenH * 0.0278, tocolor(31, 31, 31, 255), true)
			-- end
			-- if isCursorHover(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0978), screenW * 0.0325, screenH * 0.0278) then
		 --    	dxDrawRectangle(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0978), screenW * 0.0325, screenH * 0.0278, tocolor(70, 70, 70, 255), true)
			-- else
			-- 	dxDrawRectangle(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0978), screenW * 0.0325, screenH * 0.0278, tocolor(31, 31, 31, 255), true)
			-- end
		    
		 --    dxDrawTextOnRectangle("Usar", screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0045), screenW * 0.0325, screenH * 0.0278,tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", true )
		 --    dxDrawTextOnRectangle("Tirar", screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0511), screenW * 0.0325, screenH * 0.0278,tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", true )
		 --    dxDrawTextOnRectangle("Borrar",screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0978), screenW * 0.0325, screenH * 0.0278,tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", true )
   --      end
    end
        
        
    end --end isLoged

    --scroll line--
    if getElementData(localPlayer, 'isLoged') and not isBolsillosShowing then
		dxDrawSelectedItemMark(selectedItem)
	end
end
)
function dxDrawTextOnRectangle(texto, posX, posY, whidth, height, color,scale, fuente, cite1, cite2, posGui)
	dxDrawText(texto, posX, posY, whidth+posX, height+posY, color, scale, fuente or "arial", cite1 or "center", cite2 or "center", false, true, posGui or false, false, false)
end
function mostrarpanelopciones(x, y, cual)
	optionsSelected = cual
	local dataitem = getItemDataFromPicked(cual)
	if inv[dataitem][1] ~= 0 then
		absoluteYPanel = y
		absoluteXPanel = x
		itemOptions = true
		isItemInCursor = false
	end
end

function clientClick ( button, state, absX, absY, WX, WY, WZ, entity )
if getElementData(localPlayer, 'isLoged') then
	if button == "left" and state == "down" then
		--botones sueltos--
		if isCursorHover(screenW * 0.9775, screenH * 0.3133, screenW * 0.0200, screenH * 0.0322) then --botón de cierre acceso rápido
			if isPanelRapidoShowing and not isBolsillosShowing then
			isPanelRapidoShowing = false
			else
			isPanelRapidoShowing = true
			end
			if isBolsillosShowing then
				openInv()
			end
		end
		-- acceso rápido--
		if isPanelRapidoShowing or isBolsillosShowing then
		if not itemOptions then
			if isCursorHover(screenW * 0.9550, screenH * 0.3567, screenW * 0.0362, screenH * 0.0611) then--rap1
				isItemInCursor = "rap1"
			end
			if isCursorHover(screenW * 0.9550, screenH * 0.4244, screenW * 0.0362, screenH * 0.0611) then -- rap2
				isItemInCursor = "rap2"
			end
			if isCursorHover(screenW * 0.9550, screenH * 0.4922, screenW * 0.0362, screenH * 0.0611) then -- rap3
				isItemInCursor = "rap3"
			end
			if isCursorHover(screenW * 0.9550, screenH * 0.5600, screenW * 0.0362, screenH * 0.0611) then -- rap4
				isItemInCursor = "rap4"
			end
			if isCursorHover(screenW * 0.9550, screenH * 0.6489, screenW * 0.0362, screenH * 0.0611) then -- pecho
				isItemInCursor = "pecho"
			end
			if isCursorHover(screenW * 0.9550, screenH * 0.7211, screenW * 0.0362, screenH * 0.0611) then -- espalda
				isItemInCursor = "espalda"
			end

			local pitem = getSelectedItem()
			lastSelectedItem = getItemDataFromPicked(isItemInCursor)
			selectedItem = 0
			asignarItem(0, pitem)
		end
		end
		--bolsillo--
		if isBolsillosShowing and not itemOptions then
			if isCursorHover(screenW * 0.8944, screenH * 0.3656, screenW * 0.0475, screenH * 0.0744) then--bols1
				isItemInCursor = "bols1"
			end
			if isCursorHover(screenW * 0.8944, screenH * 0.4767, screenW * 0.0475, screenH * 0.0744) then -- bols2
				isItemInCursor = "bols2"
			end
			if isCursorHover(screenW * 0.8944, screenH * 0.5856, screenW * 0.0475, screenH * 0.0744) then -- bols3
				isItemInCursor = "bols3"
			end
			if isCursorHover(screenW * 0.8944, screenH * 0.6944, screenW * 0.0475, screenH * 0.0744) then -- bols4
				isItemInCursor = "bols4"
			end
		end
		--opciones del panel de opciones de click derecho--
		if itemOptions then
			if isCursorHover(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0045), screenW * 0.0325, screenH * 0.0278) then --USAR
				itemOptions = false
				outputChatBox("FUNCTION ACTIVE: use")
				optionsSelected = false
				
			end
			if isCursorHover(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0511), screenW * 0.0325, screenH * 0.0278) then--TIRAR
				itemOptions = false
				outputChatBox("FUNCTION ACTIVE: drop")
				optionsSelected = false
				
			end
			if isCursorHover(screenW * absoluteXPanel, screenH * (absoluteYPanel+0.0978), screenW * 0.0325, screenH * 0.0278) then--BORRAR
				itemOptions = false
				outputChatBox("FUNCTION ACTIVE: delete")
				optionsSelected = false
				
			end
		end
	elseif button == "left" and state == "up" then
		if not showConfirmationDrop then
		local datatable = getItemDataFromPicked(isItemInCursor)
		depositarItem(datatable, entity)
		end
		
		--detectar donde cae el item
	elseif button == "right" and state == "down" then
		--panel de opciones
		if isBolsillosShowing and isCursorShowing() and not itemOptions then
			if isCursorHover(screenW * 0.8994, screenH * 0.3689, screenW * 0.0362, screenH * 0.0600) then --bols1
  				mostrarpanelopciones( 0.8994,0.3689, "bols1")
  			elseif isCursorHover(screenW *0.9000, screenH * 0.4811, screenW * 0.0362, screenH * 0.0600) then--bols2?
  				mostrarpanelopciones(0.9000, 0.4811, "bols2")
			elseif isCursorHover(screenW *0.9000, screenH * 0.5933, screenW * 0.0362, screenH * 0.0600) then--bols3?
				mostrarpanelopciones(0.9000, 0.5933, "bols3")
			elseif isCursorHover(screenW *0.9000, screenH * 0.7044, screenW * 0.0362, screenH * 0.0600) then--bols4?
				mostrarpanelopciones(0.9000,  0.7044, "bols4")
			elseif isCursorHover(screenW * 0.9550, screenH * 0.3567, screenW * 0.0362, screenH * 0.0611) then--rap1?
				mostrarpanelopciones(0.9550, 0.3567, "rap1")
			elseif isCursorHover(screenW * 0.9550, screenH * 0.4244, screenW * 0.0362, screenH * 0.0611) then--rap2?
				mostrarpanelopciones(0.9550,0.4244, "rap2")
			elseif isCursorHover(screenW * 0.9550, screenH * 0.4922, screenW * 0.0362, screenH * 0.0611) then--rap3?
				mostrarpanelopciones(0.9550, 0.4922, "rap3")
			elseif isCursorHover(screenW * 0.9550, screenH * 0.5600, screenW * 0.0362, screenH * 0.0611) then--rap4?
				mostrarpanelopciones(0.9550, 0.5600, "rap4")
			elseif isCursorHover(screenW * 0.9550, screenH * 0.6489, screenW * 0.0362, screenH * 0.0611) then--pecho?
				mostrarpanelopciones(0.9550,0.6489, "pecho")
			elseif isCursorHover(screenW * 0.9550, screenH * 0.7211, screenW * 0.0362, screenH * 0.0611) then--espalda?
				mostrarpanelopciones(0.9550, 0.7211, "espalda")
			end
		elseif itemOptions then
			itemOptions = false
			optionsSelected = false
		end
	end
end
end
addEventHandler ( "onClientClick", getRootElement(), clientClick )

function mostrardatos()
	outputChatBox(toJSON(inv))
end
addCommandHandler("mostraritems", mostrardatos)

--Obtener el item según el item que tenga en el cursor
function getItemDataFromPicked( cursoritem )
	if cursoritem == "rap1" then
		return 2
	elseif cursoritem == "rap2" then
		return 3
	elseif cursoritem == "rap3" then
		return 4
	elseif cursoritem == "rap4" then
		return 5
	elseif cursoritem == "pecho" then
		return 6
	elseif cursoritem == "espalda" then
		return 7
	elseif cursoritem == "bols1" then
		return 8
	elseif cursoritem == "bols2" then
		return 9
	elseif cursoritem == "bols3" then
		return 10
	elseif cursoritem == "bols4" then
		return 11
	else
		return false
	end
end

--Depositar el item según el contenedor donde esté el cursor--
function isCursorInBolsillo()
	if isCursorHover(screenW * 0.8938, screenH * 0.3456, screenW * 0.0488, screenH * 0.4478) and isBolsillosShowing then
		return true
	else
		return false
	end
end
function depositarItem(itemindex, entity)
	--Primero comprobamos inventario--
if itemindex then
	if isCursorHover(screenW * 0.8994, screenH * 0.3689, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols1?
		if inv[8][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[8]
			inv[8] = aux
		else
		inv[8] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.4811, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols2?
		if inv[9][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[9]
			inv[9] = aux
		else
		inv[9] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.5933, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols3?
		if inv[10][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[10]
			inv[10] = aux
		else
		inv[10] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.7044, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols4?
		if inv[11][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[11]
			inv[11] = aux
		else
		inv[11] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.3567, screenW * 0.0362, screenH * 0.0611) then--rap1?
		if inv[2][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[2]
			inv[2] = aux
		else
		inv[2] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.4244, screenW * 0.0362, screenH * 0.0611) then--rap2?
		if inv[3][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[3]
			inv[3] = aux
		else
		inv[3] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.4922, screenW * 0.0362, screenH * 0.0611) then--rap3?
		if inv[4][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[4]
			inv[4] = aux
		else
		inv[4] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.5600, screenW * 0.0362, screenH * 0.0611) then--rap4?
		if inv[5][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[5]
			inv[5] = aux
		else
		inv[5] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.6489, screenW * 0.0362, screenH * 0.0611) then--pecho?
		if inv[6][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[6]
			inv[6] = aux
		else
		inv[6] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.7211, screenW * 0.0362, screenH * 0.0611) then--espalda?
		if inv[7][1] ~= 0 then
			local aux = inv[itemindex]
			inv[itemindex] = inv[7]
			inv[7] = aux
		else
		inv[7] = inv[itemindex]
		inv[itemindex] = {0,0}
		end
	elseif exports.vehiculos:isCursorInMaletero() and isBolsillosShowing then -- comprobamos maletero
		local item = inv[itemindex]
		if exports.vehiculos:ponerItemEnMaletero(item[1], item[2]) then
			inv[itemindex] = {0,0}
			exports.login:addNotification("Has depositado el objeto en el maletero.", "success")
		else
			exports.login:addNotification("No se puede poner este objeto en el maletero.", "error")
		end
	elseif exports.toys:isCursorInRecipiente() and isBolsillosShowing then -- comprobamos recipientes
		local item = inv[itemindex]
		if exports.toys:ponerItemEnRecipiente(item[1], item[2]) then
			inv[itemindex] = {0,0}
			exports.login:addNotification("Has depositado el objeto en el recipiente.", "success")
		else
			exports.login:addNotification("No se puede poner este objeto en el recipiente.", "error")
		end
	elseif entity then
		if isElement(entity) and getElementType(entity) == "player" then
			if entity ~= localPlayer then
				local item = inv[itemindex]
				triggerServerEvent("entregar:item", localPlayer, localPlayer, entity, item)
			end
		end
	else 
		showConfirmationDrop = itemindex
	end
	isItemInCursor = false
	updateInvTable()
end
end
showConfirmationDrop = false

function renderConfirmPanel()
	if showConfirmationDrop then
        dxDrawRectangle(screenW * 0.4306, screenH * 0.3289, screenW * 0.1344, screenH * 0.1489, tocolor(1, 0, 0, 158), false)
        dxDrawText("¿De verdad quieres tirar\neste objeto?", screenW * 0.4306, screenH * 0.3322, screenW * 0.5650, screenH * 0.3667, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        if isCursorHover(screenW * 0.4394, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311) then
        dxDrawRectangle(screenW * 0.4394, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311, tocolor(50, 50, 50, 255), false)
        else
        dxDrawRectangle(screenW * 0.4394, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311, tocolor(1, 0, 0, 255), false)
    	end
    	if isCursorHover(screenW * 0.5088, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311) then
    	dxDrawRectangle(screenW * 0.5088, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311, tocolor(50, 50, 50, 255), false)
    	else
        dxDrawRectangle(screenW * 0.5088, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311, tocolor(1, 0, 0, 255), false)
    	end
        dxDrawText("Sí", screenW * 0.4394, screenH * 0.4356, screenW * 0.4869, screenH * 0.4667, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("No", screenW * 0.5088, screenH * 0.4356, screenW * 0.5563, screenH * 0.4667, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
    end
end
addEventHandler("onClientRender", root, renderConfirmPanel)

function confirmationClick(button,state)
	if button == "left" and state == "down" then
		if showConfirmationDrop then
			if isCursorHover(screenW * 0.4394, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311) then
				exports.login:addNotification("Has tirado el objeto correctamente", "success")
				inv[showConfirmationDrop] = {0,0}
				updateInvTable()
				showConfirmationDrop = false
			elseif isCursorHover(screenW * 0.5088, screenH * 0.4356, screenW * 0.0475, screenH * 0.0311) then
				showConfirmationDrop = false
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), confirmationClick)
--Actualizar la tabla en server-side
function updateInvTable()
	triggerServerEvent ( "inv:update", localPlayer, localPlayer, inv )
end
--funciones utiles--

function asignarItem( ni, pi )
	if ni == 0 and pi[1] == 0 then
		triggerServerEvent("asignar:item", localPlayer, localPlayer, 0, 0, 0, 0)
	elseif ni == 0 then
		triggerServerEvent("asignar:item", localPlayer, localPlayer, 0, pi, 0, items[pi[1]])
	elseif pi[1] == 0 then
		triggerServerEvent("asignar:item", localPlayer, localPlayer, ni, 0, items[ni[1]], 0)
	else
		triggerServerEvent("asignar:item", localPlayer, localPlayer, ni, pi, items[ni[1]], items[pi[1]])
	end
end
--Actualizar balas de armas--

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if items[disparando[1]].itype == "arma" then
	inv[selectedItem] = {disparando[1], ammo}
	updateInvTable()
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )


gunkeys = {"mouse1", "tab", "lctrl", "rctrl"}
guntimer = false

function checkDisparos ()
	if not isCursorShowing() and getElementData(localPlayer, "isLoged") then
		for i=1, #gunkeys do
			if (getKeyState(gunkeys[i]) == true) then
				local ite = getSelectedItem()
				if ite[1] > 0 and items[ite[1]].itype == "arma" and getPedWeapon(localPlayer) ~= 0 then
		        	disparando = ite
		        	if not guntimer then
			        	guntimer = setTimer ( function()
			        			guntimer = false
						end, 1500, 1 )
		        	end
		        end
	    	elseif not guntimer then
	    	disparando = false
	    	end
		end
	end
end
addEventHandler ( "onClientRender", root, checkDisparos )


function projectileCreation(player)
	if player == localPlayer then
		local ite = getSelectedItem()
		if ite[2] == 1 then
			asignarItem(0, ite)
			inv[selectedItem] = {0, 0}
		else
			inv[selectedItem] = {ite[1], ite[2]-1}
		end
		updateInvTable()
	end
end
addEventHandler("onClientProjectileCreation", getRootElement(), projectileCreation)

armaspesadasC = {30}
---usefull functions---
function isArmaPesada( itemID )
	for i=1, #armaspesadasC do
		if armaspesadasC[i] == itemID then
			return true
		end
	end
	return false
end
function tienehuecoC(itemID)
	if isArmaPesada(itemID) then -- armas pesadas que van solo en pecho y espalda
		if inv[6][1] == 0 then
			return 6
		elseif inv[7][1] == 0 then
			return 7
		else
			return false
		end
	else
		for i=2, 11 do
			if inv[i][1] == 0 then
				return i
			end
		end
		return false
	end
end

function getItemsFromIDC(itemID)
	local itemArray = {}
	for i, hueco in pairs(inv) do
		if hueco[1] == itemID then
			table.insert(itemArray, hueco)
		end
	end
	return itemArray
end

function itemHasC(itemID, slot)
	if slot then
		for i, hueco in pairs(inv) do
			if hueco[1] == itemID and hueco[2] == slot then
				return i
			end
		end
		return false
	else
		for i, hueco in pairs(inv) do
			if hueco[1] == itemID then
				return i
			end
		end
		return false
	end
end
function deleteItemC( itemID, slot )
	if slot then
		local huecoi = itemHasC(itemID, slot)
		if huecoi then
			inv[huecoi][1] = 0
			inv[huecoi][2] = 0
			updateInvTable()
		end
	else
		local huecoi = itemHasC(itemID)
		if huecoi then
			inv[huecoi][1] = 0
			inv[huecoi][2] = 0
			updateInvTable()
		end
	end
    if items[itemID].itype == "arma" then
        triggerServerEvent("quitar:arma",localPlayer, localPlayer, items[itemID].value)
    end
end
addEvent('inv:delete', true)
addEventHandler('inv:delete', localPlayer, deleteItemC)

function darItemC( itemID, slot )
	local huecolibre = tienehuecoC(itemID)
	local tieneitem = itemHasC(itemID)
	if items[itemID].isStackeable then
		if tieneitem then
			inv[tieneitem][2] = inv[tieneitem][2] + slot
			updateInvTable()
			return true
		else
			if huecolibre then
				inv[huecolibre][1] = itemID
				inv[huecolibre][2] = slot
				updateInvTable()
				return true
			else
				return false
			end
		end
	else
		if huecolibre then
			inv[huecolibre][1] = itemID
			inv[huecolibre][2] = slot
			updateInvTable()
			return true
		else
			return false
		end
	end
end
addEvent('inv:give', true)
addEventHandler('inv:give', localPlayer, darItemC)
--funciones item seleccionado--
usandoitem = false
function usarItem()
	if getElementData(localPlayer, "isLoged") and not isCursorShowing() and not usandoitem then
		local dataitem = selectedItem

		if selectedItem ~= 0 and inv[selectedItem][1] ~= 0 then
			local itemtipo = items[inv[selectedItem][1]].itype
			if items[inv[selectedItem][1]].itype ~= "arma" then
				if items[inv[selectedItem][1]].isStackeable then
					if inv[selectedItem][2] == 1 then
						inv[selectedItem][1] = 0
						inv[selectedItem][2] = 0
					else
						inv[selectedItem][2] = inv[selectedItem][2]-1
						
					end
					updateInvTable()
					usandoitem = true
					triggerServerEvent("usar:item", localPlayer, localPlayer,inv[selectedItem][1],inv[selectedItem][2], itemtipo )
				else
					usandoitem = true
					triggerServerEvent("usar:item", localPlayer, localPlayer,inv[selectedItem][1],inv[selectedItem][2], itemtipo)
				end
			end
		end
	end
end
addCommandHandler("usar", usarItem)
function itemUsadoConExito()
	usandoitem = false
end
addEvent("item:usado", true)
addEventHandler("item:usado", localPlayer, itemUsadoConExito)
function tirarItem()
	if getElementData(localPlayer, "isLoged") and not isCursorShowing() and not usandoitem then
		local dataitem = selectedItem
		if selectedItem ~= 0 and inv[selectedItem][1] ~= 0 then
		outputChatBox("FUNCTION ACTIVE: drop")
		end
	end
end
addCommandHandler("tirar", tirarItem)


bindKey("mouse2", "down", usarItem)

function sonidoItem(itemid,x,y,z,interior,dimension)
	if itemid == 12 then
		if getElementInterior(localPlayer) == interior and getElementDimension(localPlayer) == dimension then
		playSound3D (":items/sonidos/llaves.mp3", x,y,z)
		end
	end
end
addEvent("item:sonido", true)
addEventHandler("item:sonido", localPlayer, sonidoItem)


--AYUDAS MALETERO--

function depositarItemFromMaletero( itemID, slot, hueco )
	if isCursorHover(screenW * 0.8994, screenH * 0.3689, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols1?
		if inv[8][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[8][1], inv[8][2],hueco)
			inv[8] = {itemID,slot}
		else
		inv[8] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.4811, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols2?
		if inv[9][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[9][1], inv[9][2],hueco)
			inv[9] = {itemID,slot}
		else
		inv[9] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.5933, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols3?
		if inv[10][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[10][1], inv[10][2],hueco)
			inv[10] = {itemID,slot}
		else
		inv[10] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.7044, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols4?
		if inv[11][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[11][1], inv[11][2],hueco)
			inv[11] = {itemID,slot}
		else
		inv[11] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.3567, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap1?
		if inv[2][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[2][1], inv[2][2],hueco)
			inv[2] = {itemID,slot}
		else
		inv[2] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.4244, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap2?
		if inv[3][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[3][1], inv[3][2],hueco)
			inv[3] = {itemID,slot}
		else
		inv[3] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.4922, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap3?
		if inv[4][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[4][1], inv[4][2],hueco)
			inv[4] = {itemID,slot}
		else
		inv[4] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.5600, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap4?
		if inv[5][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[5][1], inv[5][2],hueco)
			inv[5] = {itemID,slot}
		else
		inv[5] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.6489, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--pecho?
		if inv[6][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[6][1], inv[6][2],hueco)
			inv[6] = {itemID,slot}
		else
		inv[6] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.7211, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--espalda?
		if inv[7][1] ~= 0 then
			exports.vehiculos:ponerItemEnMaletero(inv[7][1], inv[7][2],hueco)
			inv[7] = {itemID,slot}
		else
		inv[7] = {itemID,slot}
		exports.vehiculos:ponerItemEnMaletero(0,0,hueco)
		end
	end
	isItemInCursor = false
	updateInvTable()
end

function depositarItemFromRecipiente( itemID, slot, hueco )
	if isCursorHover(screenW * 0.8994, screenH * 0.3689, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols1?
		if inv[8][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[8][1], inv[8][2],hueco)
			inv[8] = {itemID,slot}
		else
		inv[8] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.4811, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols2?
		if inv[9][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[9][1], inv[9][2],hueco)
			inv[9] = {itemID,slot}
		else
		inv[9] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.5933, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols3?
		if inv[10][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[10][1], inv[10][2],hueco)
			inv[10] = {itemID,slot}
		else
		inv[10] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9000, screenH * 0.7044, screenW * 0.0362, screenH * 0.0600) and isBolsillosShowing then--bols4?
		if inv[11][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[11][1], inv[11][2],hueco)
			inv[11] = {itemID,slot}
		else
		inv[11] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.3567, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap1?
		if inv[2][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[2][1], inv[2][2],hueco)
			inv[2] = {itemID,slot}
		else
		inv[2] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.4244, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap2?
		if inv[3][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[3][1], inv[3][2],hueco)
			inv[3] = {itemID,slot}
		else
		inv[3] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.4922, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap3?
		if inv[4][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[4][1], inv[4][2],hueco)
			inv[4] = {itemID,slot}
		else
		inv[4] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.5600, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--rap4?
		if inv[5][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[5][1], inv[5][2],hueco)
			inv[5] = {itemID,slot}
		else
		inv[5] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.6489, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--pecho?
		if inv[6][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[6][1], inv[6][2],hueco)
			inv[6] = {itemID,slot}
		else
		inv[6] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	elseif isCursorHover(screenW * 0.9550, screenH * 0.7211, screenW * 0.0362, screenH * 0.0611) and (isPanelRapidoShowing or isBolsillosShowing) then--espalda?
		if inv[7][1] ~= 0 then
			exports.toys:ponerItemEnRecipiente(inv[7][1], inv[7][2],hueco)
			inv[7] = {itemID,slot}
		else
		inv[7] = {itemID,slot}
		exports.toys:ponerItemEnRecipiente(0,0,hueco)
		end
	end
	isItemInCursor = false
	updateInvTable()
end

function isInventoryOpened()
	if isCursorShowing() and isBolsillosShowing then
		return true
	else
		return false
	end
end
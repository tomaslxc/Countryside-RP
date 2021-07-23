


panelon = false
function ajustecabeza()
exports.cabezas:ponerCabeza(localPlayer, 1)
cabezaplayer = exports.cabezas:getCabezaPlayer(localPlayer)
cabezadata = exports.cabezas:getCabezaData(1)
panelcabezastest()
panelon = true
end
addCommandHandler("panelcabezas",ajustecabeza)

GUIEditor = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
    function panelcabezastest ()
        GUIEditor.window[1] = guiCreateWindow(0.78, 0.27, 0.20, 0.48, "Panel de ajuste de cabezas", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        GUIEditor.label[1] = guiCreateLabel(0.10, 0.07, 0.28, 0.04, "ID Cabeza", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.edit[1] = guiCreateEdit(0.09, 0.12, 0.28, 0.06, "1", true, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(0.45, 0.12, 0.18, 0.06, "Cambiar", true, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(0.10, 0.22, 0.28, 0.04, "Coordenadas X", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
        GUIEditor.edit[2] = guiCreateEdit(0.09, 0.28, 0.28, 0.06, cabezadata.cx, true, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(0.54, 0.22, 0.28, 0.04, "Coordenadas Y", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
        GUIEditor.edit[3] = guiCreateEdit(0.54, 0.28, 0.28, 0.06, cabezadata.cy, true, GUIEditor.window[1])
        GUIEditor.label[4] = guiCreateLabel(0.10, 0.36, 0.28, 0.04, "Coordenadas Z", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
        GUIEditor.edit[4] = guiCreateEdit(0.09, 0.41, 0.28, 0.06, cabezadata.cz, true, GUIEditor.window[1])
        GUIEditor.label[5] = guiCreateLabel(0.09, 0.51, 0.28, 0.04, "Rotación X", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
        GUIEditor.edit[5] = guiCreateEdit(0.09, 0.55, 0.28, 0.06, cabezadata.rcx, true, GUIEditor.window[1])
        GUIEditor.label[6] = guiCreateLabel(0.40, 0.51, 0.28, 0.04, "Rotación Y", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")
        GUIEditor.edit[6] = guiCreateEdit(0.40, 0.55, 0.28, 0.06, cabezadata.rcy, true, GUIEditor.window[1])
        GUIEditor.label[7] = guiCreateLabel(0.68, 0.51, 0.28, 0.04, "Rotación Z", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[7], "center")
        GUIEditor.edit[7] = guiCreateEdit(0.69, 0.55, 0.28, 0.06, cabezadata.rcz, true, GUIEditor.window[1])
        GUIEditor.label[8] = guiCreateLabel(0.09, 0.66, 0.28, 0.04, "Scale", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[8], "center")
        GUIEditor.edit[8] = guiCreateEdit(0.09, 0.70, 0.28, 0.06, cabezadata.scalec, true, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(0.09, 0.85, 0.87, 0.08, "Extraer tabla en consola", true, GUIEditor.window[1])
		addEventHandler ( "onClientGUIClick",GUIEditor.button[1] , cambiarcabezapanel, false )
		addEventHandler ( "onClientGUIClick",GUIEditor.button[2] , sacartabla, false )
    end
	
	
	function cambiarcabezapanel()
	local nuevacabeza = guiGetText(GUIEditor.edit[1])
	cabezadata = exports.cabezas:getCabezaData(nuevacabeza)
	exports.cabezas:ponerCabeza(localPlayer, nuevacabeza)
	cabezaplayer = exports.cabezas:getCabezaPlayer(localPlayer)
	guiSetText(GUIEditor.edit[2], cabezadata.cx)
	guiSetText(GUIEditor.edit[3], cabezadata.cy)
	guiSetText(GUIEditor.edit[4], cabezadata.cz)
	guiSetText(GUIEditor.edit[5], cabezadata.rcx)
	guiSetText(GUIEditor.edit[6], cabezadata.rcy)
	guiSetText(GUIEditor.edit[7], cabezadata.rcz)
	guiSetText(GUIEditor.edit[8], cabezadata.scalec)
	end

	
	addEventHandler("onClientRender", root, function()
		if panelon then
			local x,y,z,rx,ry,rz,scale = tonumber(guiGetText(GUIEditor.edit[2])),tonumber(guiGetText(GUIEditor.edit[3])),tonumber(guiGetText(GUIEditor.edit[4])),tonumber(guiGetText(GUIEditor.edit[5])),tonumber(guiGetText(GUIEditor.edit[6])),tonumber(guiGetText(GUIEditor.edit[7])),tonumber(guiGetText(GUIEditor.edit[8]))
			exports.bone_attach:attachElementToBone(cabezaplayer, localPlayer, 2,x or 0,y or 0,z or 0,rx or 0,ry or 0,rz or 0 )
			setObjectScale(cabezaplayer, scale or 0)
		end
	end
	)
	
	
	function sacartabla()
	local id = guiGetText(GUIEditor.edit[1])
	local x,y,z,rx,ry,rz,scale = tonumber(guiGetText(GUIEditor.edit[2])),tonumber(guiGetText(GUIEditor.edit[3])),tonumber(guiGetText(GUIEditor.edit[4])),tonumber(guiGetText(GUIEditor.edit[5])),tonumber(guiGetText(GUIEditor.edit[6])),tonumber(guiGetText(GUIEditor.edit[7])),tonumber(guiGetText(GUIEditor.edit[8]))
	outputChatBox("["..id.."] = {modelo = "..cabezadata.modelo..", raza = "..cabezadata.raza..", cx = "..x..", cy = "..y..", cz = "..z..", rcx = "..rx..", rcy = "..ry..", rcz = "..rz..", scalec = "..scale.."},",255,255,255)
	destroyElement(GUIEditor.window[1])
	panelon = false
	end
	

	

raza = 1
data = nil

	prendas_sup = exports.clothes:getTablaTipo(17)
	prendas_mid = exports.clothes:getTablaTipo(2)
	prendas_zap = exports.clothes:getTablaTipo(3)

function getIndex(id, t)
	if t == 0 then
		for i, prendaID in pairs(prendas_sup) do
			if prendaID == id then
			return i
			end
		end
	elseif t == 2 then
		for i, prendaID in pairs(prendas_mid) do
			if prendaID == id then
			return i
			end
		end
	elseif t == 3 then
		for i, prendaID in pairs(prendas_zap) do
			if prendaID == id then
			return i
			end
		end
	end
end

GUIEditor2 = {
    button = {},
    window = {},
    label = {}
}
    function abrirpanelajusteropa (datas)
	data = datas

		raza = data.raza
        GUIEditor2.window[1] = guiCreateWindow(0.81, 0.30, 0.16, 0.42, "Ajuste de ropa", true)
        guiWindowSetSizable(GUIEditor2.window[1], false)
        GUIEditor2.label[1] = guiCreateLabel(0.19, 0.10, 0.59, 0.06, "Parte superior ID: "..data.ropa1, true, GUIEditor2.window[1])
        guiLabelSetHorizontalAlign(GUIEditor2.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor2.label[1], "center")
        GUIEditor2.button[1] = guiCreateButton(0.07, 0.21, 0.36, 0.07, "Anterior", true, GUIEditor2.window[1])
        GUIEditor2.button[2] = guiCreateButton(0.54, 0.21, 0.36, 0.07, "Siguiente", true, GUIEditor2.window[1])
        GUIEditor2.label[2] = guiCreateLabel(0.19, 0.33, 0.59, 0.06, "Parte inferior ID: "..data.ropa2, true, GUIEditor2.window[1])
        guiLabelSetHorizontalAlign(GUIEditor2.label[2], "center", false)
        guiLabelSetVerticalAlign(GUIEditor2.label[2], "center")
        GUIEditor2.button[3] = guiCreateButton(0.07, 0.46, 0.36, 0.07, "Anterior", true, GUIEditor2.window[1])
        GUIEditor2.button[4] = guiCreateButton(0.54, 0.46, 0.36, 0.07, "Siguiente", true, GUIEditor2.window[1])
        GUIEditor2.label[3] = guiCreateLabel(0.19, 0.60, 0.59, 0.06, "Zapatos ID: "..data.ropa3, true, GUIEditor2.window[1])
        guiLabelSetHorizontalAlign(GUIEditor2.label[3], "center", false)
        guiLabelSetVerticalAlign(GUIEditor2.label[3], "center")
        GUIEditor2.button[5] = guiCreateButton(0.04, 0.71, 0.36, 0.07, "Anterior", true, GUIEditor2.window[1])
        GUIEditor2.button[6] = guiCreateButton(0.54, 0.71, 0.36, 0.07, "Siguiente", true, GUIEditor2.window[1])
        GUIEditor2.button[7] = guiCreateButton(0.32, 0.86, 0.36, 0.07, "Cerrar", true, GUIEditor2.window[1])
		addEventHandler ( "onClientGUIClick", GUIEditor2.button[7] , cerrarpanel, false )
		
		addEventHandler ( "onClientGUIClick", GUIEditor2.button[1] , anteriorarriba, false )
		addEventHandler ( "onClientGUIClick", GUIEditor2.button[2] , siguientearriba, false )
		addEventHandler ( "onClientGUIClick", GUIEditor2.button[3] , anteriormid, false )
		addEventHandler ( "onClientGUIClick", GUIEditor2.button[4] , siguientemid, false )
		addEventHandler ( "onClientGUIClick", GUIEditor2.button[5] , anteriorzap, false )
		addEventHandler ( "onClientGUIClick", GUIEditor2.button[6] , siguientezap, false )
		
    end
	addEvent("panel:ropa", true)
	addEventHandler("panel:ropa", localPlayer, abrirpanelajusteropa)

	function cerrarpanel()
	destroyElement(GUIEditor2.window[1])
	end
	
	function siguientearriba()
	i1 = getIndex(data.ropa1, 0)
		if i1 == #prendas_sup then
		i1 = 1
		else
		i1 = i1+1
		end
	data.ropa1 = tonumber(prendas_sup[i1])
	guiSetText(GUIEditor2.label[1], "Parte superior ID: "..(prendas_sup[i1]))
	exports.clothes:ponerRopa(localPlayer, tonumber(prendas_sup[i1]), data.ropa2, data.ropa3, data.raza )
	end
	function anteriorarriba()
	i2 = getIndex(data.ropa1, 0)
		if i2 == 1 then
		i2 = #prendas_sup
		else
		i2 = i2-1
		end
		data.ropa1 = tonumber(prendas_sup[i2])
		guiSetText(GUIEditor2.label[1], "Parte superior ID: "..(prendas_sup[i2]))
	exports.clothes:ponerRopa(localPlayer, tonumber(prendas_sup[i2]), data.ropa2, data.ropa3, data.raza )
	end
	
	function siguientemid()
	i3 = getIndex(data.ropa2, 2)
		if i3 == #prendas_mid then
		i3 = 1
		else
		i3 = i3+1
		end
		data.ropa2 = tonumber(prendas_mid[i3])
		guiSetText(GUIEditor2.label[2], "Parte inferior ID: "..prendas_mid[i3])
	exports.clothes:ponerRopa(localPlayer, data.ropa1, tonumber(prendas_mid[i3]), data.ropa3, data.raza )
	end
	function anteriormid()
	i4 = getIndex(data.ropa2,2)
		if i4 == 1 then
		i4 = #prendas_mid
		else
		i4 = i4-1
		end
		data.ropa2 = tonumber(prendas_mid[i4])
		guiSetText(GUIEditor2.label[2], "Parte inferior ID: "..prendas_mid[i4])
	exports.clothes:ponerRopa(localPlayer, data.ropa1, tonumber(prendas_mid[i4]), data.ropa3, data.raza )
	end

	
	function siguientezap()
	i5 = getIndex(data.ropa3, 3)
		if i5 == #prendas_zap then
		i5 = 1
		else
		i5 = i5+1
		end
		data.ropa3 = tonumber(prendas_zap[i5])
		guiSetText(GUIEditor2.label[3], "Zapatos ID: "..prendas_zap[i5])
	exports.clothes:ponerRopa(localPlayer, data.ropa1, data.ropa2, tonumber(prendas_zap[i5]), data.raza )
	end
	function anteriorzap()
	i = getIndex(data.ropa3,3)
		if i == 1 then
		i = #prendas_zap
		else
		i = i-1
		end
		data.ropa3 = tonumber(prendas_zap[i])
		guiSetText(GUIEditor2.label[3], "Zapatos ID: "..prendas_zap[i])
	exports.clothes:ponerRopa(localPlayer, data.ropa1, data.ropa2, tonumber(prendas_zap[i]), data.raza )
	end
	
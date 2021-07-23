function skins()

	txd = engineLoadTXD("vehiculos/copbike.txd", 523) -- Motocicleta de Policía
	engineImportTXD(txd, 523)
	dff = engineLoadDFF("vehiculos/copbike.dff", 523)
	engineReplaceModel(dff, 523)
	
	txd = engineLoadTXD("vehiculos/copcarla.txd", 596) -- Coche de Policía LS
	engineImportTXD(txd, 596)
	dff = engineLoadDFF("vehiculos/copcarla.dff", 596)
	engineReplaceModel(dff, 596)

	txd = engineLoadTXD("vehiculos/148.txd", 148) -- Policia femenina Policía LS
	engineImportTXD(txd, 148)
	dff = engineLoadDFF("vehiculos/148.dff", 148)
	engineReplaceModel(dff, 148)

	txd = engineLoadTXD("vehiculos/152.txd", 152) -- Policia femenina Policía LS
	engineImportTXD(txd, 152)
	dff = engineLoadDFF("vehiculos/152.dff", 152)
	engineReplaceModel(dff, 152)



	
	txd = engineLoadTXD("vehiculos/copcarsf.txd", 597) -- Coche de Policía SF
	engineImportTXD(txd, 597)
	dff = engineLoadDFF("vehiculos/copcarsf.dff", 597)
	engineReplaceModel(dff, 597)
	
	txd = engineLoadTXD("vehiculos/copcarvg.txd", 598) -- Coche de Policía LV
	engineImportTXD(txd, 598)
	dff = engineLoadDFF("vehiculos/copcarvg.dff", 598)
	engineReplaceModel(dff, 598)
	
	txd = engineLoadTXD("vehiculos/copcarru.txd", 599) -- Coche de Policía Rural
	engineImportTXD(txd, 599)
	dff = engineLoadDFF("vehiculos/copcarru.dff", 599)
	engineReplaceModel(dff, 599)
	

	txd = engineLoadTXD("vehiculos/wfystew.txd", 76) -- Skin mina adidas
	engineImportTXD(txd, 76)
	dff = engineLoadDFF("vehiculos/wfystew.dff", 76)
	engineReplaceModel(dff, 76)

	txd = engineLoadTXD("vehiculos/hmydrug.txd", 30) -- Skin mina milipilli
	engineImportTXD(txd, 30)
	dff = engineLoadDFF("vehiculos/hmydrug.dff", 30)

	engineReplaceModel(dff, 178)
	txd = engineLoadTXD("vehiculos/negra.txd", 178) -- Skin mina negra con buzo de rockstar
	engineImportTXD(txd, 178)
	dff = engineLoadDFF("vehiculos/negra.dff", 178)
	engineReplaceModel(dff, 178)



	
end
addEventHandler ( "onClientResourceStart", resourceRoot, skins)
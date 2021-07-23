-------------------------------FONTS
	r_title = dxCreateFont( "fonts/Roboto-BoldCondensed.ttf", 20 )
	r_text = dxCreateFont( "fonts/Roboto-Regular.ttf",  11)
	r_desc = dxCreateFont( "fonts/Roboto-Italic.ttf", 8 )
	r_button = dxCreateFont( "fonts/Roboto-Condensed.ttf", 11 )
	r_main = dxCreateFont( "fonts/Roboto-Regular.ttf",  30)
addEventHandler ( "onClientPlayerChangeNick", getLocalPlayer(),
    function ( oldNick, newNick )
	cancelEvent()
    end
)

-----smth move camera ------

local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientPreRender",root,camRender)
	end
end

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)--tiempo en milisegundos
	if(sm.moov == 1)then
		destroyElement(sm.object1)
		destroyElement(sm.object2)
		killTimer(timer1)
		killTimer(timer2)
		killTimer(timer3)
		removeEventHandler("onClientPreRender",root,camRender)
	end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	timer1 = setTimer(removeCamHandler,time,1)
	timer2 = setTimer(destroyElement,time,1,sm.object1)
	timer3 = setTimer(destroyElement,time,1,sm.object2)
	addEventHandler("onClientPreRender",root,camRender)
	return true
end





----------------------------
local screenW, screenH = guiGetScreenSize()

------------ PANEL DE CERTIFICACIÓN -----------------------------

preguntas = {
	[1] = {
		[1] = {"¿Cuál es el concepto fundamental del rol?","Interpretación","Fabulación", "Colaboración","Interpretación"},
		[2] = {"¿En qué pueblos está ambientado Countryside Roleplay?","Montgomery, Angel Pine, Blueberry y Dillimore","Fort Carson, Blueberry, Angel Pine y Palomino", "Montgomery, Palomino Creek, Blueberry y Dillimore","Montgomery, Palomino Creek, Blueberry y Dillimore"},
		[3] = {"¿Qué entiende por “Etapas de rol”?","Las etapas de rol son procesos por los cuales pasa un rol en particular","Las etapas de rol es la división de la experiencia de tu personaje por niveles", "Las etapas de rol es la división de las generaciones de tu personaje", "Las etapas de rol es la división de la experiencia de tu personaje por niveles"},
		[4] = {"¿Dos personajes de una misma cuenta pueden rolear entre sí?", "Los personajes pueden tener concepciones entre ellos, pero no pueden interactuar entre sí bajo ningún concepto","No, no pueden tener ningún tipo de conocimiento acerca de la existencia del otro", "Sí, según la normativa se puede rolear con dos personajes dentro de una misma cuenta", "Los personajes pueden tener concepciones entre ellos, pero no pueden interactuar entre sí bajo ningún concepto"},
		[5] = {"¿Está permitido la uso de cuentas ajenas con consentimiento previo?","Sí, está permitido con consentimiento previo y autorización del staff","No, ya que se considera Multicuentas","Sí, está permitido","Sí, está permitido"},
	},
	[2] = {
		[1] = {"Cuando hablamos de CK se puede diferenciar dos tipos, ¿cuáles?","Por circunstancias de rol y por decisión propia","Por etapas de rol y por entorno", "Por entorno y por venganza", "Por circunstancias de rol y por decisión propia"},
		[2] = {"Deseo ingresar a un trabajo que no sean los disponibles por el ayuntamiento, ¿qué hago?","Procedo a dirigirme hacia la empresa en particular y solicitar el ingreso formalmente a través del dialogo","Procedo a rolear mi currículum dentro del juego, lo presento y espero a que se comuniquen conmigo", "Presento mi currículum en el foro del juego, y espero a que la empresa me llame", "Presento mi currículum en el foro del juego, y espero a que la empresa me llame"},
		[3] = {"¿Están permitido los dispositivos de grabación roleadas por entorno? (Ejemplo: GoPro, micrófonos, cámaras, etc.)","No, están totalmente prohibidas","Están permitidas con autorización del staff", "Sí, están permitidas sin autorización del staff, tienen un uso libre", "Están permitidas con autorización del staff"},
		[4] = {"¿Qué entiende por “MC” (Multicuentas)?","Multicuentas es aquel uso desmedido y desregulado de personajes dentro de una cuenta","Multicuentas es la creación desmedida y abusiva de cuentas y personajes para beneficio propio o de terceros", "Multicuentas es la eliminación desmedida y abusiva de cuentas y personajes para beneficio propio o de terceros", "Multicuentas es la creación desmedida y abusiva de cuentas y personajes para beneficio propio o de terceros"},
		[5] = {"En caso de que un usuario cometa alguna infracción mientras un rol se está llevando a cabo, ¿Cuál es su proceder?","Evito el rol en cuestión y procedo a reportar en el foro","Confronto la situación, frenando el rol y realizo una breve tutoría sobre el error del usuario, para que así no vuelva a cometerlo", "Procedo a seguir el rol pese a las consecuencias que éste traiga, y al finalizar procedo a reportar en foro", "Procedo a seguir el rol pese a las consecuencias que éste traiga, y al finalizar procedo a reportar en foro"},
	},
	[3] = {
		[1] = {"¿Qué se entiende por “Entorno”?","El entorno es el ambiente en el que se ve involucrado nuestro personaje dentro del juego y el cual se puede apreciar gráficamente, por ende, no hace falta rolearlo","El entorno es el ambiente en el que se ve involucrado nuestro personaje dentro del juego y el cual no se puede apreciar gráficamente, por este motivo hay que rolearlo", "El entorno se entiende al conjunto de estados y procesos que se verifican en el espacio físico que se extiende desde la piel hacia el exterior, y que son capaces de afectar el psiquismo de una persona", "El entorno es el ambiente en el que se ve involucrado nuestro personaje dentro del juego y el cual no se puede apreciar gráficamente, por este motivo hay que rolearlo"},
		[2] = {"¿Qué entiende usted por “CK” (Character Kill)","Entendemos a CK como la muerte total del personaje dentro del servidor","Entendemos a CK como la totalidad que cubre un entorno para llevar a cabo un rol en particular", "Entendemos al CK como la muerte parcial del personaje dentro del servidor", "Entendemos a CK como la muerte total del personaje dentro del servidor"},
		[3] = {"En el caso de necesitar ayuda, y ningún staff está conectado. ¿Cuál es su proceder?","Procedo a comunicarme por alguna red social del foro, solicitando la ayuda de un staff","Procedo a escribirle personalmente a todos los staffs hasta que uno me conteste", "Espero a que un staff entre al servidor para que me ayude", "Procedo a comunicarme por alguna red social del foro, solicitando la ayuda de un staff"},
		[4] = {"¿Qué entiende por “Forzar el rol”?","Forzar el rol es una consecuencia de un rol previo mal ejecutado en donde se omitió el entorno","Forzar el rol es una falta la cuál denota cómo un usuario ha provocado que dicho rol se incline a su favor a consciencia, lo cual es sancionable", "Forzar el rol es una consecuencia de un rol previo mal ejecutado en donde se omitió el entorno, lo cual es sancionable", "Forzar el rol es una falta la cuál denota cómo un usuario ha provocado que dicho rol se incline a su favor a consciencia, lo cual es sancionable"},
		[5] = {"Veo un vehículo abierto, en funcionamiento y decido robarlo. ¿Cómo procedo a robarlo?","Pido la supervisión de un staff y procedo a rolear el robo, roleando abrirlo por entorno, me subo y me voy","Pido la supervisión de un staff, roleo el robo y antes de irme coloco un “/entorno” avisando a la policía del suceso", "Roleo el robo sin supervisión y antes de marcharme, pongo un “/entorno” avisando a la policía del suceso", "Roleo el robo sin supervisión y antes de marcharme, pongo un “/entorno” avisando a la policía del suceso"},
	},
	[4] = {
		[1] = {"¿Qué entiende por MG (Metagaming)?","Metagaming hace alusión a la confusión de conceptos generales de rol","Metagaming es la falta cometida por realizar correctamente un rol en base a las normativas propuestas por el servidor", "Metagaming es la confusión de los canales los cuales, tanto el personaje como el jugador se comunican dentro del juego", "Metagaming es la confusión de los canales los cuales, tanto el personaje como el jugador se comunican dentro del juego"},
		[2] = {"¿Qué entiende por AB (Admin abuse)?","Admin abuse es un concepto que hace referencia al maltrato entre miembros pertenecientes a la cúpula administrativa","Admin abuse es el poderío que tiene un staff para obtener beneficios propios a costa de usuarios", "Admin abuse hace referencia a los staffs que están esclavizados y los cuales sólo tienen la función de ayudar y no pueden rolear", "Admin abuse es el poderío que tiene un staff para obtener beneficios propios a costa de usuarios"},
		[3] = {"¿Qué entiende por PG (Power gaming)?","Power gaming es la falta cometida por un usuario el cual ha realizado alguna acción ilógica o, así como también un forcejeo de rol","Power gaming es el error de confundir canales IC del OOC", "Power gaming es la incapacidad de ejecutar un rol en específico, y por ende se recurre al entorno para rolearlas", "Power gaming es la falta cometida por un usuario el cual ha realizado alguna acción ilógica o, así como también un forcejeo de rol"},
		[4] = {"¿Cuántos canales generales hay para comunicarse dentro del juego?","Hay tres: Global, IC y OOC","Hay dos: IC y OOC", "Hay dos: IG y OOC", "Hay dos: IC y OOC"},
		[5] = {"¿Qué entiende por IC (In character)?","In character es cuando tú, como usuario, interpreta a su personaje, como si fuese un actor, mediado entre la pantalla y el teclado","In character es cuando tú puedes ser como lo eres en la vida real, sin necesidad de interpretar nada", "In character es la interpretación que los demás personajes le dan al tuyo.", "In character es cuando tú, como usuario, interpreta a su personaje, como si fuese un actor, mediado entre la pantalla y el teclado"},
	},
	[5] = {
		[1] = {"¿Qué entiende por OOC (Out of character)?","Out of character es cuando tú, como usuario, interpreta a su personaje, como si fuese un actor, mediado entre la pantalla y el teclado","Out of character cuando estás interpretando el entorno que hay a tu alrededor", "Out of character es cuando tú puedes ser como lo eres en la vida real, sin necesidad de interpretar nada", "Out of character es cuando tú puedes ser como lo eres en la vida real, sin necesidad de interpretar nada"},
		[2] = {"Si tu personaje muere por ciertas circunstancias y no hay médicos conectados. ¿Qué se debería de hacer?","Cancelar el rol, cancelando la muerte en cuestión","Rolear tu traslado por entorno hacia el hospital y respawnear pasado el tiempo", "Esperar para respawnear", "Rolear tu traslado por entorno hacia el hospital y respawnear pasado el tiempo"},
		[3] = {"¿En qué momento se debe de rolear el entorno?","Sólo cuando personas están involucradas en ciertos momentos","En todo el momento", "No es necesario rolearlo", "En todo el momento"},
		[4] = {"Debido a un bug del juego pierdo objetos. ¿Qué debo de hacer?","Me voy al apartado del foro, relleno el formato para el reporte del bug en  cuestión, presentando pruebas gráficas","Me voy al apartado del foro, escribo un mensaje privado hacia algún miembro del staff explicando mi situación", "Solicito la atención IG de un staff para comentarle mi situación y para que me brinde la ayuda necesaria para recuperar mis objetos", "Me voy al apartado del foro, relleno el formato para el reporte del bug en  cuestión, presentando pruebas gráficas"},
		[5] = {"Veo a un usuario yendo a 180km por zonas urbanas, me atropella y se da a la fuga. ¿Qué se debería de hacer?","Roleo levantarme y llamar a la policía y a un médico","Rolear las consecuencias, como el posible PK hacia tu personaje", "Procedo a sacar screenshots y dirigirme a foro, para reportarlo por Drive By y Hit Car", "Rolear las consecuencias, como el posible PK hacia tu personaje"},

	},
	[6] = {
		[1] = {"¿Qué entiende por “Spam”?","El spam es la repetición de líneas con el mismo significado o la misma oración redactada","El spam es cualquier mensaje enviado a un usuario con fines publicitarios o  comerciales ya sea por redes asociadas al servidor", "El spam es una variedad de carne en lata elaborada por la empresa Hormel Foods Corporation", "El spam es cualquier mensaje enviado a un usuario con fines publicitarios o  comerciales ya sea por redes asociadas al servidor"},
		[2] = {"¿Cómo puedo ser dueño de una empresa?","Presentando mi currículum como aspirante de una empresa","Estar en la etapa 3 de nivel de rol, tener dinero y adquirir una", "Estar en la etapa 2 de nivel de rol, tener dinero y adquirir una", "Estar en la etapa 3 de nivel de rol, tener dinero y adquirir una"},
		[3] = {"¿Qué se entiende por DM (Deathmatch)?","Deathmatch es la acción de agredir a un personaje sin ningún motivo o rol previo","Deathmatch es un evento que se realiza en donde usuarios participan en un Derby", "Deathmatch es un evento que se realiza en dónde el staff autoriza un día en dónde se declara un estado anárquico, y en donde los usuarios hacen lo que quieren", "Deathmatch es la acción de agredir a un personaje sin ningún motivo o rol previo"},
		[4] = {"¿Cómo puedo subir mi etapa de rol?","Comprando monedas virtuales del servidor para levelearlas","Aprobando el test inicial, presentando la ficha del personaje y aprobando la certificación", "Presentando solamente la ficha del personaje para subir al nivel 1, y luego se deberán comprar monedas virtuales para subir la capacidad de tu personaje", "Aprobando el test inicial, presentando la ficha del personaje y aprobando la certificación"},
		[5] = {"¿Cuáles de las siguientes acciones se considera HC (Hit Car)?","Una situación de Hit Car sería un choque de unos vehículos, en un lugar determinado","Se puede considerar como Hit Car el golpear un vehículo sin motivo ni rol", "Se considera Hit Car al momento de tener un choque con algún vehículo robado", "Se puede considerar como Hit Car el golpear un vehículo sin motivo ni rol"},

	},
	[7] = {
		[1] = {"¿Cuál de los siguientes conceptos existen en la terminología de Countryside?","LS: LastHit","CB: CarAbuse", "Las dos son incorrectas", "Las dos son incorrectas"},
		[2] = {"Marque la respuesta correcta para evidenciar un AutoCar","La terminología no existe","En una persecución, se ignora por completo el entorno", "Un sujeto se sube sin rolear a un auto y lo roba sin rol", "La terminología no existe"},
		[3] = {"¿Qué es el 4x4?","En términos matemáticos, 16.","Se entiende al 4x4 como ignorar el rol de entorno e ir manejando por montañas y bosques, como, por ejemplo, en una persecución", "La A y B son correctas", "La A y B son correctas"},
		[4] = {"Marque la respuesta correcta para evidenciar una evasión del rol de entorno","Liar un cigarrillo de marihuana en el departamento policial","Entrar a un quirófano, el cual tiene la puerta cerrada, sin permiso de los médicos", "Ambas respuestas son correctas", "Ambas respuestas son correctas"},
		[5] = {"Marque la respuesta correcta para evidenciar un DeathMatch","Veo a un sujeto de la pandilla enemiga y empiezo a dispararle a quemarropa hasta que lo mato","Ninguna respuesta evidencia un DeathMatch", "Un sujeto me choca, me bajo del coche, empezamos a discutir y empiezo a golpearlo hasta dejarlo inconsciente", "Ninguna respuesta evidencia un DeathMatch"},

	},
	[8] = {
		[1] = {"Veo a unos sujetos en altas horas de la madrugada en una esquina, hablando y pasándose cosas sospechosamente, ¿qué procede a hacer?","Dependería de la psicología de mi personaje, y de lo que él y el rol me pida hacer","Procedo a contactar con un staff para que los vigile en caso de estar haciendo MG", "Llamaría a la policía", "Dependería de la psicología de mi personaje, y de lo que él y el rol me pida hacer"},
		[2] = {"¿Un sujeto en la etapa de rol número dos, puede ejercer una facción legal?","Sí","No", "Dependería no sólo de la etapa de rol, sino a más variables justificables que avalen al sujeto a ejercer dentro de dicha facción", "No"},
		[3] = {"Evidencie entre respuestas, un MG","Utilizar la información que me pasó un socio por Discord para emboscar a una pandilla enemiga","Seguir a un auto de la mafia durante días para trazar su rutina", "Negociar con el alcalde para tener ciertos beneficios", "Utilizar la información que me pasó un socio por Discord para emboscar a una pandilla enemiga"},
		[4] = {"Quiero formar parte del cuerpo administrativo, ¿qué puedo hacer?","Presentar el currículo OOC al apartado de “Anuncios administrativos” del foro","Comunicarme con algún staff y pedirle que me recomiende", "Esperar a las siguientes elecciones", "Esperar a las siguientes elecciones"},
		[5] = {"Quiero usurpar una casa, ¿cuál es el procedimiento?","No está permitido","Me comunico con un staff para que me spectee, realizo el rol y pago un cierto porcentaje", "No roleo nada, y me comunico con un staff diciéndole que ya he roleado la apertura de la casa", "Me comunico con un staff para que me spectee, realizo el rol y pago un cierto porcentaje"},

	},
	[9] = {
		[1] = {"He sido sancionado con un baneo permanente, pero quiero volver a jugar, ¿qué puedo hacer?","Empiezo a mandarle muchos mensajes a los staffs para que me desbaneen","Espero a la siguiente oleada de desbaneos que se realiza cada 3 meses", "Solicitar un desbaneo en el apartado de “Apelaciones de baneo” explicando el motivo por el cual deberían desbanearme", "Solicitar un desbaneo en el apartado de “Apelaciones de baneo” explicando el motivo por el cual deberían desbanearme"},
		[2] = {"He realizado un mapeado y quiero que lo metan, ¿cuál es el procedimiento?","Mandarle el mapeado a un staff y solicitarlo que lo meta","Esperar la aprobación del gobierno y pagar su construcción para que lo meta", "Las dos son incorrectas", "Esperar la aprobación del gobierno y pagar su construcción para que lo meta"},
		[3] = {"IG mi personaje ha fumado marihuana y justo para una patrulla en frente, ¿qué hago?","No mencionar nunca, tanto por /me o por /do de que he fumado","Rolear el estado estupefacto y así como el olor y abstenerme a las consecuencias", "Me desconecto hasta que finalice el rol", "Rolear el estado estupefacto y así como el olor y abstenerme a las consecuencias"},
		[4] = {"Quiero realizar un CK, ¿cuál es el procedimiento necesario?","Tener un arma que no sea por entorno","Tener motivos necesarios para realizarle el CK a la persona", "Ambas respuestas son correctas", "Ambas respuestas son correctas"},
		[5] = {"¿Necesito el consentimiento de la víctima para realizar un CK?","No","Sí", "Sí, aunque este consentimiento se anula al tener motivos de peso.", "Sí, aunque este consentimiento se anula al tener motivos de peso."},

	},
	[10] = {
		[1] = {"¿Puedo utilizar IG nombres de personas famosas OOC?","Sí","Debo solicitar el permiso a un staff", "No", "No"},
		[2] = {"¿Qué entiende por “IG”?","Introduction of the Game","In Game", "Intrageneracional", "In Game"},
		[3] = {"¿Cuáles de estas respuesta considera que es acertada para hablar de la abreviación “IC”?","Mi personaje se fue a tomar una soda","Yo me voy a tomar una soda", "Yo hablo con un staff para que me spectee", "Mi personaje se fue a tomar una soda"},
		[4] = {"Veo a un sujeto en la calle, el cuál se llama Marcos, pero no lo conozco de ningún sitio, observo su tag y procedo a hablar IC, saludándolo por su nombre, ¿qué falta estaría cometiendo?","Estaría forzando el rol","Estaría cometiendo evasión de entorno", "Estaría cometiendo MG", "Estaría cometiendo MG"},
		[5] = {"¿Cuál de estas acciones es motivo de ban permanente?","Publicitar otros servidores en nuestro servidor","Publicitar nuestro servidor en otros servidores", "Ambas son correctas", "Ambas son correctas"},

	}
}

panel1 = false
panel2 = false


-- PREGUNTAS SELECCIONADAS --

selec1 = false
selec2 = false
selec3 = false
selec4 = false
selec5 = false
selec6 = false
selec7 = false
selec8 = false
selec9 = false
selec10 = false

------------------------------




function iniciarCertificacion(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
	preg1 = p1
	preg2 = p2
	preg3 = p3
	preg4 = p4
	preg5 = p5
	preg6 = p6
	preg7 = p7
	preg8 = p8
	preg9 = p9
	preg10 = p10
	panel1 = true
	setCameraMatrix (1285.1767578125, -1455.205078125, 225.78584289551, 1268.3671875, -1574.845703125, 177.36140441895, 0,0 )
	showCursor(true)
	showChat ( false )
	guiSetInputEnabled ( true )
	fadeCamera( true, 5)
	setPlayerHudComponentVisible ( "all", false )
end
addEvent("panel:certificacion", true)
addEventHandler("panel:certificacion", localPlayer, iniciarCertificacion)

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

addEventHandler("onClientRender", root,
    function()
		if panel1 then
			dxDrawRectangle(screenW * 0, screenH * 0.1311, screenW, screenH * 0.7622, tocolor(2,105,156, 161), false)
			dxDrawRectangle(screenW * 0.2681, screenH * 0.0200, screenW * 0.4525, screenH * 0.0878, tocolor(2,105,156, 238), false)
			dxDrawText("Proceso de certificación", screenW * 0.2706, screenH * 0.0256, screenW * 0.7169, screenH * 0.1033, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			dxDrawText(preguntas[1][preg1][1], screenW * 0.1, screenH * 0.1522, screenW * 0.7044, screenH * 0.2000, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec1 and selec1 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.2033, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.2033, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec1 and selec1 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.2322, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.2322, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec1 and selec1 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.2611, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.2611, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			
			dxDrawText(preguntas[1][preg1][2], screenW * 0.12, screenH * 0.2022, screenW * 0.7044, screenH * 0.2211, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[1][preg1][3], screenW * 0.12, screenH * 0.2311, screenW * 0.7044, screenH * 0.2500, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[1][preg1][4], screenW * 0.12, screenH * 0.2600, screenW * 0.7044, screenH * 0.2789, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[2][preg2][1], screenW * 0.1, screenH * 0.2900, screenW * 0.7044, screenH * 0.3378, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			
			if selec2 and selec2 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.3378, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.3378, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec2 and selec2 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.3667, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.3667, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec2 and selec2 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.3956, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.3956, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[2][preg2][2], screenW * 0.12, screenH * 0.3367, screenW * 0.7044, screenH * 0.3556, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[2][preg2][3], screenW * 0.12, screenH * 0.3667, screenW * 0.7044, screenH * 0.3856, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[2][preg2][4], screenW * 0.12, screenH * 0.3967, screenW * 0.7044, screenH * 0.4156, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[3][preg3][1], screenW * 0.1, screenH * 0.4267, screenW * 0.7044, screenH * 0.4744, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec3 and selec3 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.4744, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.4744, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec3 and selec3 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.5033, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.5033, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec3 and selec3 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.5322, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.5322, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[3][preg3][2], screenW * 0.12, screenH * 0.4744, screenW * 0.7044, screenH * 0.4933, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[3][preg3][3], screenW * 0.12, screenH * 0.5044, screenW * 0.7044, screenH * 0.5233, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[3][preg3][4], screenW * 0.12, screenH * 0.5322, screenW * 0.7044, screenH * 0.5511, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[4][preg4][1], screenW * 0.1, screenH * 0.5611, screenW * 0.7044, screenH * 0.6089, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec4 and selec4 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.6089, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.6089, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec4 and selec4 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.6378, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.6378, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec4 and selec4 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.6667, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.6667, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[4][preg4][2], screenW * 0.12, screenH * 0.6089, screenW * 0.7044, screenH * 0.6278, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[4][preg4][3], screenW * 0.12, screenH * 0.6378, screenW * 0.7044, screenH * 0.6567, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[4][preg4][4], screenW * 0.12, screenH * 0.6667, screenW * 0.7044, screenH * 0.6856, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[5][preg5][1], screenW * 0.1, screenH * 0.6967, screenW * 0.7044, screenH * 0.7444, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec5 and selec5 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.7444, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.7444, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec5 and selec5 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.7733, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.7733, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec5 and selec5 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.8022, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.8022, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[5][preg5][2], screenW * 0.12, screenH * 0.7444, screenW * 0.7044, screenH * 0.7633, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[5][preg5][3], screenW * 0.12, screenH * 0.7722, screenW * 0.7044, screenH * 0.7911, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[5][preg5][4], screenW * 0.12, screenH * 0.8022, screenW * 0.7044, screenH * 0.8211, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			if isCursorHover(screenW * 0.4200, screenH * 0.8333, screenW * 0.1494, screenH * 0.0489) then
			dxDrawRectangle(screenW * 0.4200, screenH * 0.8333, screenW * 0.1494, screenH * 0.0489, tocolor(2,105,156, 100), false)
			else
			dxDrawRectangle(screenW * 0.4200, screenH * 0.8333, screenW * 0.1494, screenH * 0.0489, tocolor(2,105,156, 238), false)
			end
			dxDrawText("Siguiente", screenW * 0.4194, screenH * 0.8333, screenW * 0.5694, screenH * 0.8822, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
		end
		
		if panel2 then
			dxDrawRectangle(screenW * 0, screenH * 0.1311, screenW, screenH * 0.7622, tocolor(2,107,156, 161), false)
			dxDrawRectangle(screenW * 0.2681, screenH * 0.0200, screenW * 0.4525, screenH * 0.0878, tocolor(2,107,156, 238), false)
			dxDrawText("Proceso de certificación", screenW * 0.2706, screenH * 0.0256, screenW * 0.7169, screenH * 0.1033, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			dxDrawText(preguntas[6][preg6][1], screenW * 0.1, screenH * 0.1522, screenW * 0.7044, screenH * 0.2000, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec6 and selec6 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.2033, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.2033, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec6 and selec6 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.2322, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.2322, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec6 and selec6 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.2611, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.2611, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			
			dxDrawText(preguntas[6][preg6][2], screenW * 0.12, screenH * 0.2022, screenW * 0.7044, screenH * 0.2211, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[6][preg6][3], screenW * 0.12, screenH * 0.2311, screenW * 0.7044, screenH * 0.2500, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[6][preg6][4], screenW * 0.12, screenH * 0.2600, screenW * 0.7044, screenH * 0.2789, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[7][preg7][1], screenW * 0.1, screenH * 0.2900, screenW * 0.7044, screenH * 0.3378, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			
			if selec7 and selec7 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.3378, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.3378, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec7 and selec7 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.3667, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.3667, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec7 and selec7 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.3956, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.3956, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[7][preg7][2], screenW * 0.12, screenH * 0.3367, screenW * 0.7044, screenH * 0.3556, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[7][preg7][3], screenW * 0.12, screenH * 0.3667, screenW * 0.7044, screenH * 0.3856, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[7][preg7][4], screenW * 0.12, screenH * 0.3967, screenW * 0.7044, screenH * 0.4156, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[8][preg8][1], screenW * 0.1, screenH * 0.4267, screenW * 0.7044, screenH * 0.4744, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec8 and selec8 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.4744, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.4744, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec8 and selec8 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.5033, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.5033, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec8 and selec8 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.5322, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.5322, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[8][preg8][2], screenW * 0.12, screenH * 0.4744, screenW * 0.7044, screenH * 0.4933, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[8][preg8][3], screenW * 0.12, screenH * 0.5044, screenW * 0.7044, screenH * 0.5233, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[8][preg8][4], screenW * 0.12, screenH * 0.5322, screenW * 0.7044, screenH * 0.5511, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[9][preg9][1], screenW * 0.1, screenH * 0.5611, screenW * 0.7044, screenH * 0.6089, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec9 and selec9 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.6089, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.6089, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec9 and selec9 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.6378, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.6378, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec9 and selec9 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.6667, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.6667, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[9][preg9][2], screenW * 0.12, screenH * 0.6089, screenW * 0.7044, screenH * 0.6278, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[9][preg9][3], screenW * 0.12, screenH * 0.6378, screenW * 0.7044, screenH * 0.6567, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[9][preg9][4], screenW * 0.12, screenH * 0.6667, screenW * 0.7044, screenH * 0.6856, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[10][preg10][1], screenW * 0.1, screenH * 0.6967, screenW * 0.7044, screenH * 0.7444, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
			if selec10 and selec10 == 1 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.7444, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.7444, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec10 and selec10 == 2 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.7733, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.7733, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			if selec10 and selec10 == 3 then
			dxDrawRectangle(screenW * 0.1, screenH * 0.8022, screenW * 0.0106, screenH * 0.0178, tocolor(2,107,156, 255), false)
			else
			dxDrawRectangle(screenW * 0.1, screenH * 0.8022, screenW * 0.0106, screenH * 0.0178, tocolor(255, 255, 255, 255), false)
			end
			dxDrawText(preguntas[10][preg10][2], screenW * 0.12, screenH * 0.7444, screenW * 0.7044, screenH * 0.7633, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[10][preg10][3], screenW * 0.12, screenH * 0.7722, screenW * 0.7044, screenH * 0.7911, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			dxDrawText(preguntas[10][preg10][4], screenW * 0.12, screenH * 0.8022, screenW * 0.7044, screenH * 0.8211, tocolor(255, 255, 255, 255), 1.00, r_desc, "left", "top", false, false, false, false, false)
			if isCursorHover(screenW * 0.4200, screenH * 0.8333, screenW * 0.1494, screenH * 0.0489) then
			dxDrawRectangle(screenW * 0.4200, screenH * 0.8333, screenW * 0.1494, screenH * 0.0489, tocolor(2,107,156, 100), false)
			else
			dxDrawRectangle(screenW * 0.4200, screenH * 0.8333, screenW * 0.1494, screenH * 0.0489, tocolor(2,107,156, 238), false)
			end
			dxDrawText("Anterior", screenW * 0.4194, screenH * 0.8333, screenW * 0.5694, screenH * 0.8822, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
			if isCursorHover(screenW * 0.6319, screenH * 0.8333, screenW * 0.0350, screenH * 0.0489) then
			dxDrawRectangle(screenW * 0.6319, screenH * 0.8333, screenW * 0.0350, screenH * 0.0489, tocolor(2,107,156, 255), false)
			dxDrawText("➩", screenW * 0.6319, screenH * 0.8333, screenW * 0.6663, screenH * 0.8811, tocolor(255, 255, 255, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawRectangle(screenW * 0.6319, screenH * 0.8333, screenW * 0.0350, screenH * 0.0489, tocolor(2,107,156, 255), false)
			dxDrawText("➩", screenW * 0.6319, screenH * 0.8333, screenW * 0.6663, screenH * 0.8811, tocolor(0, 0, 0, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
		end
	end
)

function certiclick ( button, state)
	if button == "left" and state == "down" then
		--- 10 preguntas de los paneles ---
			--pregunta1 y pregunta6
			if isCursorHover(screenW * 0.1, screenH * 0.2033, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P1:R1
				selec1 = 1
				elseif panel2 then--P6:R1
				selec6 = 1
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.2322, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P1:R2
				selec1 = 2
				elseif panel2 then
				selec6 = 2
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.2611, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P1:R3
				selec1 = 3
				elseif panel2 then
				selec6 = 3
				end
			end
			--pregunta2 y pregunta7
			if isCursorHover(screenW * 0.1, screenH * 0.3378, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P2:R1
				selec2 = 1
				elseif panel2 then--P7:R1
				selec7 = 1
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.3667, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P2:R2
				selec2 = 2
				elseif panel2 then--P7:R2
				selec7 = 2
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.3956, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P2:R3
				selec2 = 3
				elseif panel2 then--P7:R3
				selec7 = 3
				end
			end
			---pregunta3 y pregunta 8
			if isCursorHover(screenW * 0.1, screenH * 0.4744, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P3:R1
				selec3 = 1
				elseif panel2 then--P8:R1
				selec8 = 1
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.5033, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P3:R2
				selec3 = 2
				elseif panel2 then--P8:R2
				selec8 = 2
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.5322, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P3:R3
				selec3 = 3
				elseif panel2 then--P8:R3
				selec8 = 3
				end
			end
			---pregunta 4 y pregunta 9
			if isCursorHover(screenW * 0.1, screenH * 0.6089, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P4:R1
				selec4 = 1
				elseif panel2 then--P9:R1
				selec9 = 1
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.6378, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P4:R2
				selec4 = 2
				elseif panel2 then--P9:R2
				selec9 = 2
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.6667, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P4:R3
				selec4 = 3
				elseif panel2 then--P9:R3
				selec9 = 3
				end
			end
			--pregunta5 y pregunta10
			if isCursorHover(screenW * 0.1, screenH * 0.7444, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P5:R1
				selec5 = 1
				elseif panel2 then--P10:R1
				selec10 = 1
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.7733, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P5:R2
				selec5 = 2
				elseif panel2 then--P10:R2
				selec10 = 2
				end
			end
			if isCursorHover(screenW * 0.1, screenH * 0.8022, screenW * 0.0106, screenH * 0.0178) then 
				if panel1 then-- P5:R3
				selec5 = 3
				elseif panel2 then--P10:R3
				selec10 = 3
				end
			end
		-----
		
		---boton siguiente--
			if isCursorHover(screenW * 0.4200, screenH * 0.8333, screenW * 0.1494, screenH * 0.0489) then
				if panel1 then
				panel1 = false
				panel2 = true
				elseif panel2 then--boton anterior--
				panel2 = false
				panel1 = true
				end
			end
		-------
		--boton enviar--
			if isCursorHover(screenW * 0.6319, screenH * 0.8333, screenW * 0.0350, screenH * 0.0489) then
				if panel2 then
					if selec1 == false or selec2 == false or selec3 == false or selec4 == false or selec5 == false or selec6 == false or selec7 == false or selec8 == false or selec9 == false or selec10 == false then
					exports.login:addNotification("No has respondido a todas las preguntas, no se puede enviar.", "error")
					else
					exports.login:addNotification("Procesando certificación . . .", "warning")
					local correctas = 0
						if preguntas[1][preg1][getSelectedPreguntaIndex(selec1)] == preguntas[1][preg1][5] then
							correctas = correctas + 1
						end
						if preguntas[2][preg2][getSelectedPreguntaIndex(selec2)] == preguntas[2][preg2][5] then
							correctas = correctas + 1
						end
						if preguntas[3][preg3][getSelectedPreguntaIndex(selec3)] == preguntas[3][preg3][5] then
							correctas = correctas + 1
						end
						if preguntas[4][preg4][getSelectedPreguntaIndex(selec4)] == preguntas[4][preg4][5] then
							correctas = correctas + 1
						end
						if preguntas[5][preg5][getSelectedPreguntaIndex(selec5)] == preguntas[5][preg5][5] then
							correctas = correctas + 1
						end
						if preguntas[6][preg6][getSelectedPreguntaIndex(selec6)] == preguntas[6][preg6][5] then
							correctas = correctas + 1
						end
						if preguntas[7][preg7][getSelectedPreguntaIndex(selec7)] == preguntas[7][preg7][5] then
							correctas = correctas + 1
						end
						if preguntas[8][preg8][getSelectedPreguntaIndex(selec8)] == preguntas[8][preg8][5] then
							correctas = correctas + 1
						end
						if preguntas[9][preg9][getSelectedPreguntaIndex(selec9)] == preguntas[9][preg9][5] then
							correctas = correctas + 1
						end
						if preguntas[10][preg10][getSelectedPreguntaIndex(selec10)] == preguntas[10][preg10][5] then
							correctas = correctas + 1
						end
						panel2 = false
						if correctas >= 8 then
							triggerServerEvent("pj:pcu", localPlayer, localPlayer, true)
						else
							triggerServerEvent("pj:pcu", localPlayer, localPlayer, false)
						end
					end
				end
			end
		--------------
		
	end
end
addEventHandler ( "onClientClick", getRootElement(), certiclick )
function getSelectedPreguntaIndex( selected )
	if selected == 1 then
		return 2
	elseif selected == 2 then
		return 3
	elseif selected == 3 then
		return 4
	end
end

--------------------------------------------------


---------- PROCESO DE CREACIÓN ----------------------



local skins = {7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 24, 25, 28, 51, 66, 67, 79, 80, 83, 84, 102, 103, 104, 105, 106, 107, 134, 136, 142, 143, 144, 156, 163, 166, 168, 176, 180, 182, 183, 185, 220, 221, 222, 249, 253, 260, 262,23, 26, 27, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 52, 57, 58, 59, 60, 61, 62, 68, 70, 71, 72, 73, 78, 81, 82, 94, 95, 96, 97, 98, 99, 100, 101, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117,118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 135, 137, 146, 147, 153, 154, 155, 158, 159, 160, 161, 162, 164, 165, 167, 170, 171, 172, 173, 174, 175, 177, 179, 181, 184, 186, 187, 188, 189, 200, 202, 203,204, 206, 209, 210, 212, 213, 217, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 250, 252, 254, 255, 258, 259, 261, 264, 9, 10, 11, 13, 63, 69, 76, 139, 148, 190, 195, 207, 215, 218, 219, 238, 244,245, 256, 12, 31, 38, 39, 40, 41, 53, 54, 55, 56, 64, 75, 77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 140, 141, 145, 150, 151, 152, 157, 169, 178, 191, 192, 193, 194, 196, 197, 198, 199, 201, 205, 211, 214,216, 224, 225, 226, 231, 232, 233, 237, 243, 246, 251, 257, 263}

function existeskin(id)
	for i, skinid in ipairs(skins) do
		if skinid == id then
			return true
		end
	end
	return false
end

function getSkinIndex(id)
	for i, skinid in ipairs(skins) do
		if skinid == id then
			return i
		end
	end
	return false
end

mostrarseleccion = false
mostrarcreacion = false
pjsdata = false



skinmal = false
nombremal = false
edadmal = false
alturamal = false
dnimal = false

function panelseleccion(data,timestamp)
	current_timestamp = timestamp
	pjsdata = data
	mostrarseleccion = true
	setCameraMatrix (1556.1005859375, -1357.240234375, 331.80621337891, 1285.1767578125, -1455.205078125, 225.78584289551, 0,0 )
	showCursor(true)
	showChat ( false )
	guiSetInputEnabled ( true )
	fadeCamera( true, 5)
	setPlayerHudComponentVisible ( "all", false )
end
addEvent("panel:seleccion",true)
addEventHandler("panel:seleccion",localPlayer, panelseleccion)

function panelseleccion2(data)
	pjsdata = data
	exports.cabezas:ponerCabeza(ped, false)
	unbindKey( "mouse_wheel_up", "down", scrollup)
	unbindKey( "mouse_wheel_down", "down", scrolldown)
	destroyElement(ped)
	toggleControl('chatbox', true)
	guiSetInputMode('no_binds')
		
	
	destroyElement(complexiongrasa)
	destroyElement(complexionmusculo)
	
	mostrarpersonalizacion = false
	
	indiceraza = 2
	cabezasraza = exports.cabezas:getCabezasRaza(indiceraza)
	indicetablacabezas = 1
	cabezaselect = cabezasraza[indicetablacabezas]
	camisa = 1
	pantalon = 1
	sexo = "hombre"
	womanskinindex = 1
	
				smoothMoveCamera(1564.5439453125, -1358.9677734375, 329.91107177734, 1562.0234375, -1346.708984375, 329.90609741211,1298.2099609375, -1334.74609375, 298.45028686523, 1556.1005859375, -1357.240234375, 331.80621337891,5000)
				setTimer ( function()
				smoothMoveCamera(1180.1650390625, -1725.23828125, 200.44729614258, 1562.0234375, -1346.708984375, 329.90609741211, 1161.9990234375, -1483.7392578125, 257.20013427734, 1556.1005859375, -1357.240234375, 331.80621337891,5000)
	end, 5100, 1 )
	
	setTimer ( function()
		mostrarseleccion = true
	end, 10110, 1 )
end
addEvent("creado:exito",true)
addEventHandler("creado:exito", localPlayer, panelseleccion2)


function scrollup()
local rx,ry,rz = getElementRotation(ped)
setElementRotation(ped, rx,ry,rz+5, "default", true)
end

function scrolldown()
local rx,ry,rz = getElementRotation(ped)
setElementRotation(ped, rx,ry,rz-5, "default", true)
end
function personalizarOK()

	destroyElement(editname)
	destroyElement(editedad)
	destroyElement(editaltura)
	destroyElement(editdni)
	mostrarcreacion = false
	
	
	skinmal = false
	nombremal = false
	edadmal = false
	alturamal = false
	dnimal = false
	
	--PED DE CREACION
	ped = createPed (0, 1544.8291015625, -1353.2998046875, 329.4743347168,100)
	setPedHeadless  ( ped ,true )
	setPedWalkingStyle ( ped, 118 )
	exports.cabezas:ponerCabeza(ped, cabezaselect)
	exports.clothes:ponerRopa(ped, 9, 12, 3, indiceraza)
	
	--crear pj 1541.5029296875, -1353.4443359375, 329.46942138672
				smoothMoveCamera(1564.5439453125, -1358.9677734375, 329.91107177734, 1562.0234375, -1346.708984375, 329.90609741211, 1541.5029296875, -1353.4443359375, 329.46942138672, 1701.759765625, -1350.947265625, 344.54837036133,5000)
	setTimer ( function()
		mostrarpersonalizacion = true
		complexionmusculo = guiCreateScrollBar(0.70, 0.32, 0.09, 0.02, true, true)
        guiSetAlpha(complexionmusculo, 0.50)
        complexiongrasa = guiCreateScrollBar(0.70, 0.35, 0.09, 0.02, true, true)
        guiSetAlpha(complexiongrasa, 0.50)
		bindKey( "mouse_wheel_up", "down", scrollup)
		bindKey( "mouse_wheel_down", "down", scrolldown)
		guiSetInputMode('no_binds_when_editing')
		toggleControl('chatbox', false)
	end, 5100, 1 )   
end
addEvent( "pj:personalizacion",true)
addEventHandler( "pj:personalizacion", localPlayer, personalizarOK)



canclicksiguiente = true
mostrarpersonalizacion = false

function certiclick ( button, state)
	if button == "left" and state == "down" then
		if mostrarseleccion then
			if isCursorHover(screenW * 0.2300, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122) then --personaje1  1468.8785400391, -919.25317382813, 100.153465271
				if pjsdata[1] ~= nil then
					if pjsdata[1].timestamp == 0 then
						hacercinematica(pjsdata[1])
					else
						fadeCamera(false, 3)
						mostrarseleccion = false
						setTimer(function()
						showCursor(false)
						showChat(true)
						guiSetInputEnabled ( false )
						triggerServerEvent("pj:spawn", localPlayer, localPlayer, pjsdata[1])
						pjsdata = nil
						fadeCamera(true, 3)
						end,3100,1)
					end
				else--crearpj
					mostrarseleccion = false
				smoothMoveCamera(1564.5439453125, -1358.9677734375, 329.91107177734, 1562.0234375, -1346.708984375, 329.90609741211,1298.2099609375, -1334.74609375, 298.45028686523, 1146.7939453125, -1487.7177734375, 221.64784240723,5000)
				setTimer ( function()
				smoothMoveCamera(1180.1650390625, -1725.23828125, 200.44729614258, 1562.0234375, -1346.708984375, 329.90609741211, 1161.9990234375, -1483.7392578125, 257.20013427734, 1161.9990234375, -1483.7392578125, 257.20013427734,5000)
					end, 5100, 1 )
					
					setTimer ( function()     
					editname = guiCreateEdit(0.55, 0.24, 0.11, 0.03, "", true)
					editedad = guiCreateEdit(0.55, 0.30, 0.11, 0.03, "", true)
					editaltura = guiCreateEdit(0.55, 0.37, 0.11, 0.03, "", true)
					editdni = guiCreateEdit(0.55, 0.44, 0.11, 0.03, "", true) 
					mostrarcreacion = true
					end, 10110, 1 )
					exports.login:addNotification("Vas a ser dirigido al panel de creación del personaje.", "success")
				end
			end
			if isCursorHover(screenW * 0.5469, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122) then--personaje2
				if pjsdata[2] ~= nil then
					if pjsdata[2].timestamp == 0 then
						hacercinematica(pjsdata[2])
					else
						fadeCamera(false, 3)
						mostrarseleccion = false
						setTimer(function()
						showCursor(false)
						showChat(true)
						guiSetInputEnabled ( false )
						triggerServerEvent("pj:spawn", localPlayer, localPlayer, pjsdata[2])
						pjsdata = nil
						fadeCamera(true, 3)
						end,3100,1)
					end
				else--crear pj
					mostrarseleccion = false
				smoothMoveCamera(1564.5439453125, -1358.9677734375, 329.91107177734, 1562.0234375, -1346.708984375, 329.90609741211,1298.2099609375, -1334.74609375, 298.45028686523, 1146.7939453125, -1487.7177734375, 221.64784240723,5000)
				setTimer ( function()
				smoothMoveCamera(1180.1650390625, -1725.23828125, 200.44729614258, 1562.0234375, -1346.708984375, 329.90609741211, 1161.9990234375, -1483.7392578125, 257.20013427734, 1161.9990234375, -1483.7392578125, 257.20013427734,5000)
					end, 5100, 1 )
					
					setTimer ( function()  
					editname = guiCreateEdit(0.55, 0.24, 0.11, 0.03, "", true)
					editedad = guiCreateEdit(0.55, 0.30, 0.11, 0.03, "", true)
					editaltura = guiCreateEdit(0.55, 0.37, 0.11, 0.03, "", true)
					editdni = guiCreateEdit(0.55, 0.44, 0.11, 0.03, "", true) 
					mostrarcreacion = true
					end, 10110, 1 )
					exports.login:addNotification("Vas a ser dirigido al panel de creación del personaje.", "success")
				end
			end
		end
		
		if mostrarcreacion then
			
			
			if isCursorHover(screenW * 0.5531, screenH * 0.6878, screenW * 0.1013, screenH * 0.0456) and canclicksiguiente then---botón cancelar
				
				destroyElement(editname)
				destroyElement(editedad)
				destroyElement(editaltura)
				destroyElement(editdni)
				mostrarcreacion = false
				
				
				skinmal = false
				nombremal = false
				edadmal = false
				alturamal = false
				dnimal = false
				
				smoothMoveCamera(1564.5439453125, -1358.9677734375, 329.91107177734, 1562.0234375, -1346.708984375, 329.90609741211,1298.2099609375, -1334.74609375, 298.45028686523, 1146.7939453125, -1487.7177734375, 221.64784240723,5000)
				setTimer ( function()
				smoothMoveCamera(1180.1650390625, -1725.23828125, 200.44729614258, 1562.0234375, -1346.708984375, 329.90609741211, 1161.9990234375, -1483.7392578125, 257.20013427734, 1161.9990234375, -1483.7392578125, 257.20013427734,5000)
				end, 5100, 1 )
				
				setTimer ( function()
					mostrarseleccion = true
				end, 10110, 1 )
			end
			
			if isCursorHover(screenW * 0.5531, screenH * 0.6322, screenW * 0.1013, screenH * 0.0456) and canclicksiguiente then--Siguiente
			
				nombrec = guiGetText(editname)
				edadc = guiGetText(editedad)
				alturac = guiGetText(editaltura)
				dnic = guiGetText(editdni)
				
				if verifyCharacterName(nombrec) then
					nombremal = verifyCharacterName(nombrec)
					setTimer ( function()
					nombremal = false
					end, 3000, 1 )
				elseif not tonumber(edadc) or tonumber(edadc) > 75 or tonumber(edadc) < 15 then
					edadmal = true
					setTimer ( function()
					edadmal = false
					end, 3000, 1 )
				elseif not tonumber(alturac) or tonumber(alturac) > 210 or tonumber(alturac) < 150 then
					alturamal = true
					setTimer ( function()
					alturamal = false
					end, 3000, 1 )
				elseif verifyDNI(dnic) then
					dnimal = verifyDNI(dnic)
					setTimer ( function()
					dnimal = false
					end, 3000, 1 )
				else
				exports.login:addNotification("Leyendo información...", "warning")
				canclicksiguiente = false
				setTimer ( function()
				triggerServerEvent ( "check:pj", localPlayer, localPlayer, tostring(nombrec), tonumber(edadc), tonumber(alturac), tostring(dnic) )
				canclicksiguiente = true
				end, 3000, 1 )
				
				end
				
			end
			
		end
		
	end
end
addEventHandler ( "onClientClick", getRootElement(), certiclick )

current_timestamp = false
function getTiempo(lastime)
local segundosoff = current_timestamp - lastime
local dias = math.floor(segundosoff/86400)
local horas = math.floor(segundosoff/3600)
segundosoff = segundosoff - (dias*3600)
local minutos = math.floor(segundosoff/60)
segundosoff = segundosoff - (minutos*60)
	if dias == 0 then
	return "- Hoy"
	elseif dias == 1 then
	return "- Ayer"
	else
	return "- Hace "..segundosoff.." días."
	end
end

addEventHandler("onClientRender", root,
    function()
	
	if mostrarseleccion then
		if screenH <= 600 and screenW <= 800 then
		dxDrawText("Hemos detectado que usas una resolución muy baja.\nTe recomendamos subirla para una mejor experiencia.", screenW * 0.4556, screenH * 0.1600, screenW * 0.7194, screenH * 0.2100, tocolor(173, 0, 0, 255), 1.00, r_text, "center", "center", false, false, false, false, false)
		end
		dxDrawRectangle(screenW * 0.2244, screenH * 0.2111, screenW * 0.5050, screenH * 0.0756, tocolor(2,105,156, 238), false)
		dxDrawText("SELECCIONA UN PERSONAJE O CREA UNO NUEVO", screenW * 0.2238, screenH * 0.2100, screenW * 0.7294, screenH * 0.2867, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
       
		if pjsdata[1] ~= nil then
		dxDrawRectangle(screenW * 0.2244, screenH * 0.3089, screenW * 0.1888, screenH * 0.3344, tocolor(2,105,156, 161), false)
		dxDrawImage(screenW * 0.2687, screenH * 0.3222, screenW * 0.0981, screenH * 0.3067, ":personajes/images/skins/creado.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			if isCursorHover(screenW * 0.2300, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122) then
			dxDrawRectangle(screenW * 0.2300, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122, tocolor(50, 50, 50, 200), false)
			dxDrawText(string.gsub(pjsdata[1].nombre, "_", " "), screenW * 0.2325, screenH * 0.3267, screenW * 0.4037, screenH * 0.3644, tocolor(34,94,122, 255), 1.0, r_text, "center", "center", false, false, false, false, false)
			dxDrawLine(screenW * 0.2325, screenH * 0.3600, screenW * 0.4037, screenH * 0.3600, tocolor(255, 255, 255, 255), 2, false)
			dxDrawText("Edad: "..pjsdata[1].edad, screenW * 0.2325, screenH * 0.3689, screenW * 0.4037, screenH * 0.4067, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
			dxDrawText("Altura: "..pjsdata[1].altura.."cm", screenW * 0.2325, screenH * 0.4067, screenW * 0.4037, screenH * 0.4444, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
			dxDrawText("Dinero: $"..pjsdata[1].dinero.."", screenW * 0.2325, screenH * 0.4444, screenW * 0.4037, screenH * 0.4822, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
			dxDrawText("DNI: "..pjsdata[1].dni, screenW * 0.2325, screenH * 0.4822, screenW * 0.4037, screenH * 0.5200, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
				if pjsdata[1].ck == 0 then
				dxDrawText("Estado: #CCFFE5vivo", screenW * 0.2325, screenH * 0.5200, screenW * 0.4037, screenH * 0.5578, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, true, false)
				else
				dxDrawText("Estado: #FFCCCCmuerto", screenW * 0.2325, screenH * 0.5200, screenW * 0.4037, screenH * 0.5578, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, true, false)
				end
				dxDrawText("Última conexión:", screenW * 0.2325, screenH * 0.5578, screenW * 0.4037, screenH * 0.5956, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
				if pjsdata[1].timestamp == 0 then
				dxDrawText("- Nunca", screenW * 0.2325, screenH * 0.5956, screenW * 0.4037, screenH * 0.6289, tocolor(254, 254, 254, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
				else
				dxDrawText(getTiempo(pjsdata[1].timestamp), screenW * 0.2325, screenH * 0.5956, screenW * 0.4037, screenH * 0.6289, tocolor(254, 254, 254, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
				end
			end
		else
		dxDrawRectangle(screenW * 0.2244, screenH * 0.3089, screenW * 0.1888, screenH * 0.3344, tocolor(2,105,156, 161), false)
		dxDrawImage(screenW * 0.2687, screenH * 0.3222, screenW * 0.0981, screenH * 0.3067, ":personajes/images/skins/new.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			if isCursorHover(screenW * 0.2300, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122) then
			dxDrawRectangle(screenW * 0.2300, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122, tocolor(50, 50, 50, 100), false)
			dxDrawText("CREAR PERSONAJE", screenW * 0.2300, screenH * 0.3211, screenW * 0.4069, screenH * 0.6322, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			end
		end
		if pjsdata[2] ~= nil then
		dxDrawRectangle(screenW * 0.5406, screenH * 0.3089, screenW * 0.1888, screenH * 0.3344, tocolor(2,105,156, 161), false)
		dxDrawImage(screenW * 0.5894, screenH * 0.3211, screenW * 0.0981, screenH * 0.3067, ":personajes/images/skins/creado.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			if isCursorHover(screenW * 0.5469, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122) then
			dxDrawRectangle(screenW * 0.5469, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122, tocolor(50, 50, 50, 200), false)
			dxDrawText(string.gsub(pjsdata[2].nombre, "_", " "), screenW * 0.5500, screenH * 0.3267, screenW * 0.7212, screenH * 0.3644, tocolor(34,94,122, 255), 1.0, r_text, "center", "center", false, false, false, false, false)
			dxDrawLine(screenW * 0.5500, screenH * 0.3600, screenW * 0.7212, screenH * 0.3600, tocolor(255, 255, 255, 255), 2, false)
			dxDrawText("Edad: "..pjsdata[2].edad, screenW * 0.5500, screenH * 0.3689, screenW * 0.7212, screenH * 0.4067, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
			dxDrawText("Altura: "..pjsdata[2].altura.."cm", screenW * 0.5500, screenH * 0.4067, screenW * 0.7212, screenH * 0.4444, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
			dxDrawText("Dinero: $"..pjsdata[2].dinero.."", screenW * 0.5500, screenH * 0.4444, screenW * 0.7212, screenH * 0.4822, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
			dxDrawText("DNI: "..pjsdata[2].dni, screenW * 0.5500, screenH * 0.4822, screenW * 0.7212, screenH * 0.5200, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
				if pjsdata[2].ck == 0 then
				dxDrawText("Estado: #CCFFE5vivo", screenW * 0.5500, screenH * 0.5200, screenW * 0.7212, screenH * 0.5578, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, true, false)
				else
				dxDrawText("Estado: #FFCCCCmuerto", screenW * 0.5500, screenH * 0.5200, screenW * 0.7212, screenH * 0.5578, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, true, false)
				end
				dxDrawText("Última conexión:", screenW * 0.5500, screenH * 0.5578, screenW * 0.7212, screenH * 0.5956, tocolor(254, 254, 254, 255), 1.0, r_text, "left", "center", false, false, false, false, false)
				if pjsdata[2].timestamp == 0 then
				dxDrawText("- Nunca", screenW * 0.5500, screenH * 0.5956, screenW * 0.7212, screenH * 0.6289, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
				else
				dxDrawText(getTiempo(pjsdata[2].timestamp), screenW * 0.5500, screenH * 0.5956, screenW * 0.7212, screenH * 0.6289, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "center", false, false, false, false, false)
				end
			end
		else
		dxDrawRectangle(screenW * 0.5406, screenH * 0.3089, screenW * 0.1888, screenH * 0.3344, tocolor(2,105,156, 161), false)
		dxDrawImage(screenW * 0.5894, screenH * 0.3211, screenW * 0.0981, screenH * 0.3067, ":personajes/images/skins/new.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			if isCursorHover(screenW * 0.5469, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122) then
			dxDrawRectangle(screenW * 0.5469, screenH * 0.3200, screenW * 0.1769, screenH * 0.3122, tocolor(50, 50, 50, 100), false)
			dxDrawText("CREAR PERSONAJE", screenW * 0.5469, screenH * 0.3211, screenW * 0.7238, screenH * 0.6322, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			end
		end
       

		dxDrawLine((screenW * 0.2244) - 1, (screenH * 0.6711) - 1, (screenW * 0.2244) - 1, screenH * 0.7978, tocolor(2,105,156, 238), 1, false)
        dxDrawLine(screenW * 0.7300, (screenH * 0.6711) - 1, (screenW * 0.2244) - 1, (screenH * 0.6711) - 1, tocolor(2,105,156, 238), 1, false)
        dxDrawLine((screenW * 0.2244) - 1, screenH * 0.7978, screenW * 0.7300, screenH * 0.7978, tocolor(2,105,156, 238), 1, false)
        dxDrawLine(screenW * 0.7300, screenH * 0.7978, screenW * 0.7300, (screenH * 0.6711) - 1, tocolor(2,105,156, 238), 1, false)
        dxDrawRectangle(screenW * 0.2244, screenH * 0.6711, screenW * 0.5056, screenH * 0.1267, tocolor(2,105,156, 161), false)
        dxDrawText("¿Quieres borrar un personaje?\n\nPara borrar un personaje debes solicitarlo en el PCU.\nRecuerda que solo puedes tener dos personajes en tu cuenta.", screenW * 0.2338, screenH * 0.6878, screenW * 0.7194, screenH * 0.7811, tocolor(255, 255, 255, 255), 1.00, r_text, "left", "top", false, false, false, false, false)
	end
		
	end
)


-----------------------------------------------------
function dxDrawTextOnRectangle(posX, posY, whidth, height, texto, fuente, cite1, cite2, color, posGui)
	dxDrawText(texto, posX, posY, whidth+posX, height+posY, color, 1, fuente or "arial", cite1 or "center", cite2 or "center", false, true, posGui or false, false, false)
end

mensajecreacion = [[Bienvenidos al panel de creación de un nuevo personaje. Tienes que especificar los datos principales y luego personalizar el aspecto de tu personaje.

¡Nos vemos dentro!]]


ropainicial = {}
razas = {"Blanco", "Negro", "Latino", "Asiatico"}
indiceraza = 2
cabezasraza = exports.cabezas:getCabezasRaza(indiceraza)
indicetablacabezas = 1
cabezaselect = cabezasraza[indicetablacabezas]
camisa = 1
pantalon = 1
sexo = "hombre"
partealta = {9,24,33,39,40,42}
partebaja = {12,13}

womanskinindex = 1
femaleSkins = {9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 69, 76, 77, 88, 89, 91, 93, 129, 130, 131, 141, 148, 150, 151, 157, 169, 172, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 207, 211, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 243, 245, 263, 298, 304}

addEventHandler("onClientRender", root,
    function()
		if mostrarcreacion then
        dxDrawRectangle(screenW * 0.2244, screenH * 0.2011, screenW * 0.2019, screenH * 0.5800, tocolor(2,105,156, 200), false)
		dxDrawImage(screenW * 0.2300, screenH * 0.2111, screenW * 0.1888, screenH * 0.1278, ":login/assets/img/countryside.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawTextOnRectangle(screenW * 0.2362, screenH * 0.3544, screenW * 0.1769, screenH * 0.4056,mensajecreacion,r_text,"left","top",tocolor(0,0,0,255),false)
        --[[dxDrawImage(screenW * 0.2537, screenH * 0.2122, screenW * 0.1419, screenH * 0.4689, ":personajes/images/skins/"..skinselected..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("ID: "..skinselected.."", screenW * 0.2875, screenH * 0.6833, screenW * 0.3606, screenH * 0.7044, tocolor(0, 0, 0, 200), 1.00, r_text, "center", "center", false, false, false, false, false)
		if isCursorHover(screenW * 0.3850, screenH * 0.7289, screenW * 0.0187, screenH * 0.0378) then
		dxDrawText("▶", screenW * 0.3750, screenH * 0.7222, screenW * 0.4144, screenH * 0.7700, tocolor(200, 200, 200, 200), 1.50, "bankgothic", "center", "center", false, false, false, false, false)
		else
        dxDrawText("▶", screenW * 0.3750, screenH * 0.7222, screenW * 0.4144, screenH * 0.7700, tocolor(0, 0, 0, 200), 1.50, "bankgothic", "center", "center", false, false, false, false, false)
		end
		if isCursorHover(screenW * 0.2475, screenH * 0.7289, screenW * 0.0187, screenH * 0.0378) then
		dxDrawText("◀", screenW * 0.2356, screenH * 0.7222, screenW * 0.2750, screenH * 0.7700, tocolor(200, 200, 200, 200), 1.50, "bankgothic", "center", "center", false, false, false, false, false)
		else
        dxDrawText("◀", screenW * 0.2356, screenH * 0.7222, screenW * 0.2750, screenH * 0.7700, tocolor(0, 0, 0, 200), 1.50, "bankgothic", "center", "center", false, false, false, false, false)
		end
        dxDrawLine((screenW * 0.2762) - 1, (screenH * 0.7456) - 1, (screenW * 0.2762) - 1, screenH * 0.7700, tocolor(212, 190, 152, 200), 1, false)
        dxDrawLine(screenW * 0.3725, (screenH * 0.7456) - 1, (screenW * 0.2762) - 1, (screenH * 0.7456) - 1, tocolor(212, 190, 152, 200), 1, false)
        dxDrawLine((screenW * 0.2762) - 1, screenH * 0.7700, screenW * 0.3725, screenH * 0.7700, tocolor(212, 190, 152, 200), 1, false)
        dxDrawLine(screenW * 0.3725, screenH * 0.7700, screenW * 0.3725, (screenH * 0.7456) - 1, tocolor(212, 190, 152, 200), 1, false)
		if isCursorHover(screenW * 0.2762, screenH * 0.7456, screenW * 0.0963, screenH * 0.0244) then
		dxDrawRectangle(screenW * 0.2762, screenH * 0.7456, screenW * 0.0963, screenH * 0.0244, tocolor(152,77,27, 200), false)
		else
        dxDrawRectangle(screenW * 0.2762, screenH * 0.7456, screenW * 0.0963, screenH * 0.0244, tocolor(185, 149, 86, 200), false)
		end
        dxDrawText("Cambiar skin", screenW * 0.2756, screenH * 0.7444, screenW * 0.3725, screenH * 0.7689, tocolor(255, 255, 255, 255), 1.00, r_text, "center", "center", false, false, false, false, false)--]]
        dxDrawRectangle(screenW * 0.2244, screenH * 0.1200, screenW * 0.2019, screenH * 0.0656, tocolor(2,105,156, 200), false)
        dxDrawText("Creación del personaje", screenW * 0.2244, screenH * 0.1189, screenW * 0.4250, screenH * 0.1856, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.5019, screenH * 0.2011, screenW * 0.2019, screenH * 0.5800, tocolor(2,105,156, 200), false)
        dxDrawRectangle(screenW * 0.5019, screenH * 0.1200, screenW * 0.2019, screenH * 0.0656, tocolor(2,105,156, 200), false)
        dxDrawText("Información del personaje", screenW * 0.5019, screenH * 0.1189, screenW * 0.7025, screenH * 0.1856, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
        dxDrawText("⇆", screenW * 0.4288, screenH * 0.4022, screenW * 0.4988, screenH * 0.5244, tocolor(2,105,156, 200), 7.00, "sans", "center", "center", false, false, false, false, false)
        dxDrawText("Nombre y apellido", screenW * 0.5194, screenH * 0.2067, screenW * 0.6481, screenH * 0.2300, tocolor(0, 0, 0, 200), 1.00, r_text, "right", "center", false, false, false, false, false)
		if isCursorHover(screenW * 0.6500, screenH * 0.2078, screenW * 0.0112, screenH * 0.0200) then
		dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[INFO]: El nombre tiene que tener el formato Nombre Apellido.El guión bajo NO debe ser incluido.", r_desc, "left", "top", tocolor(255,255,255,255))
		dxDrawText("?", screenW * 0.6481, screenH * 0.2067, screenW * 0.6631, screenH * 0.2300, tocolor(210, 184, 38, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		else
        dxDrawText("?", screenW * 0.6481, screenH * 0.2067, screenW * 0.6631, screenH * 0.2300, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		end
        dxDrawText("Edad", screenW * 0.5194, screenH * 0.2700, screenW * 0.6125, screenH * 0.2933, tocolor(0, 0, 0, 200), 1.00, r_text, "right", "center", false, false, false, false, false)
		if isCursorHover(screenW * 0.6150, screenH * 0.2722, screenW * 0.0112, screenH * 0.0200) then
		dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[INFO]: La edad tiene que ser un valor numérico entre 15 y 75 años.", r_desc, "left", "top", tocolor(255,255,255,255))
		dxDrawText("?", screenW * 0.6125, screenH * 0.2700, screenW * 0.6275, screenH * 0.2933, tocolor(210, 184, 38, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		else
        dxDrawText("?", screenW * 0.6125, screenH * 0.2700, screenW * 0.6275, screenH * 0.2933, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		end
        dxDrawText("Altura", screenW * 0.5194, screenH * 0.3378, screenW * 0.6125, screenH * 0.3611, tocolor(0, 0, 0, 200), 1.00, r_text, "right", "center", false, false, false, false, false)
		if isCursorHover(screenW * 0.6150, screenH * 0.3389, screenW * 0.0112, screenH * 0.0200) then
		dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[INFO]: La altura se indica en centímetros. La altura mínima es de 150 y la máxima de 210", r_desc, "left", "top", tocolor(255,255,255,255))
		dxDrawText("?", screenW * 0.6125, screenH * 0.3378, screenW * 0.6275, screenH * 0.3611, tocolor(210, 184, 38, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		else
        dxDrawText("?", screenW * 0.6125, screenH * 0.3378, screenW * 0.6275, screenH * 0.3611, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		end
        dxDrawText("DNI", screenW * 0.5194, screenH * 0.4100, screenW * 0.6062, screenH * 0.4333, tocolor(0, 0, 0, 200), 1.00, r_text, "right", "center", false, false, false, false, false)
		if isCursorHover(screenW * 0.6088, screenH * 0.4122, screenW * 0.0112, screenH * 0.0200) then
		dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[INFO]: El DNI es el número de identificación personal que te identifica como persona en el condado. Está formado por 8 números seguidos de una letra mayúscula. Por ejemplo: 12345678M", r_desc, "left", "top", tocolor(255,255,255,255))
		dxDrawText("?", screenW * 0.6062, screenH * 0.4100, screenW * 0.6212, screenH * 0.4333, tocolor(210, 184, 38, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		else
        dxDrawText("?", screenW * 0.6062, screenH * 0.4100, screenW * 0.6212, screenH * 0.4333, tocolor(255, 255, 255, 255), 1.50, "default", "center", "center", false, false, false, false, false)
		end
        dxDrawLine((screenW * 0.5531) - 1, (screenH * 0.6322) - 1, (screenW * 0.5531) - 1, screenH * 0.6778, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6544, (screenH * 0.6322) - 1, (screenW * 0.5531) - 1, (screenH * 0.6322) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.5531) - 1, screenH * 0.6778, screenW * 0.6544, screenH * 0.6778, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6544, screenH * 0.6778, screenW * 0.6544, (screenH * 0.6322) - 1, tocolor(0, 0, 0, 255), 1, false)
		if isCursorHover(screenW * 0.5531, screenH * 0.6322, screenW * 0.1013, screenH * 0.0456) then
		dxDrawRectangle(screenW * 0.5531, screenH * 0.6322, screenW * 0.1013, screenH * 0.0456, tocolor(2,105,156, 200), false)
		else
        dxDrawRectangle(screenW * 0.5531, screenH * 0.6322, screenW * 0.1013, screenH * 0.0456, tocolor(2,105,156, 200), false)
		end
        dxDrawText("Siguiente", screenW * 0.5531, screenH * 0.6311, screenW * 0.6544, screenH * 0.6767, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.5531) - 1, (screenH * 0.6878) - 1, (screenW * 0.5531) - 1, screenH * 0.7333, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6544, (screenH * 0.6878) - 1, (screenW * 0.5531) - 1, (screenH * 0.6878) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.5531) - 1, screenH * 0.7333, screenW * 0.6544, screenH * 0.7333, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6544, screenH * 0.7333, screenW * 0.6544, (screenH * 0.6878) - 1, tocolor(0, 0, 0, 255), 1, false)
		if isCursorHover(screenW * 0.5531, screenH * 0.6878, screenW * 0.1013, screenH * 0.0456) then
		dxDrawRectangle(screenW * 0.5531, screenH * 0.6878, screenW * 0.1013, screenH * 0.0456, tocolor(2,105,156, 200), false)
		else
        dxDrawRectangle(screenW * 0.5531, screenH * 0.6878, screenW * 0.1013, screenH * 0.0456, tocolor(2,105,156, 200), false)
		end
        dxDrawText("Cancelar", screenW * 0.5531, screenH * 0.6889, screenW * 0.6544, screenH * 0.7344, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
			if nombremal then
			dxDrawText("❌", screenW * 0.6694, screenH * 0.2433, screenW * 0.6850, screenH * 0.2667, tocolor(2,107,156, 255), 1.00, "default", "center", "center", false, false, false, false, false)
			dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[ERROR]: "..nombremal, r_desc, "left", "top", tocolor(200,0,0,255))
			end
			if edadmal then
			dxDrawText("❌", screenW * 0.6694, screenH * 0.3033, screenW * 0.6850, screenH * 0.3267, tocolor(2,107,156, 255), 1.00, "default", "center", "center", false, false, false, false, false)
			dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[ERROR]: La edad es incorrecta. Debe ser un número entre 15 y 99.", r_desc, "left", "top", tocolor(200,0,0,255))
			end
			if alturamal then
			dxDrawText("❌", screenW * 0.6694, screenH * 0.3733, screenW * 0.6850, screenH * 0.3967, tocolor(2,107,156, 255), 1.00, "default", "center", "center", false, false, false, false, false)
			dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[ERROR]: La altura es incorrecta. Debe ser un número entre 150 y 210.", r_desc, "left", "top", tocolor(200,0,0,255))
			end
			if dnimal then
			dxDrawText("❌", screenW * 0.6694, screenH * 0.4444, screenW * 0.6850, screenH * 0.4678, tocolor(2,107,156, 255), 1.00, "default", "center", "center", false, false, false, false, false)
			dxDrawTextOnRectangle(screenW * 0.5106, screenH * 0.4822, screenW * 0.1831, screenH * 0.1300,"[ERROR]: "..dnimal, r_desc, "left", "top", tocolor(200,0,0,255))
			end
		end
		
		
		
		if mostrarpersonalizacion then
		
		if sexo == "hombre" then
			setPedStat ( ped, 21, guiScrollBarGetScrollPosition ( complexiongrasa )*8)
			setPedStat ( ped, 23, guiScrollBarGetScrollPosition ( complexionmusculo )*8 )
			
			dxDrawText(nombrec, screenW * 0.3425, screenH * 0.0211, screenW * 0.6000, screenH * 0.0889, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			if isCursorHover(screenW * 0.5744, screenH * 0.2089, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("▶", screenW * 0.5713, screenH * 0.1967, screenW * 0.6000, screenH * 0.2556, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("▶", screenW * 0.5713, screenH * 0.1967, screenW * 0.6000, screenH * 0.2556, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			if isCursorHover(screenW * 0.3488, screenH * 0.2111, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("◀", screenW * 0.3425, screenH * 0.1967, screenW * 0.3713, screenH * 0.2556, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("◀", screenW * 0.3425, screenH * 0.1967, screenW * 0.3713, screenH * 0.2556, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			if isCursorHover(screenW * 0.5750, screenH * 0.3678, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("▶", screenW * 0.5713, screenH * 0.3533, screenW * 0.6000, screenH * 0.4122, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("▶", screenW * 0.5713, screenH * 0.3533, screenW * 0.6000, screenH * 0.4122, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			if isCursorHover(screenW * 0.3488, screenH * 0.3667, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("◀", screenW * 0.3425, screenH * 0.3533, screenW * 0.3713, screenH * 0.4122, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("◀", screenW * 0.3425, screenH * 0.3533, screenW * 0.3713, screenH * 0.4122, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			if isCursorHover(screenW * 0.5737, screenH * 0.6100, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("▶", screenW * 0.5713, screenH * 0.5956, screenW * 0.6000, screenH * 0.6544, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("▶", screenW * 0.5713, screenH * 0.5956, screenW * 0.6000, screenH * 0.6544, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			if isCursorHover(screenW * 0.3481, screenH * 0.6078, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("◀", screenW * 0.3425, screenH * 0.5956, screenW * 0.3713, screenH * 0.6544, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("◀", screenW * 0.3425, screenH * 0.5956, screenW * 0.3713, screenH * 0.6544, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			dxDrawRectangle(screenW * 0.6719, screenH * 0.1733, screenW * 0.1475, screenH * 0.4378, tocolor(2,105,156, 200), false)
			dxDrawRectangle(screenW * 0.6719, screenH * 0.0889, screenW * 0.1469, screenH * 0.0678, tocolor(2,105,156, 220), false)
			dxDrawText("Estadísticas", screenW * 0.6719, screenH * 0.0889, screenW * 0.8187, screenH * 0.1567, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			dxDrawText("Raza", screenW * 0.7069, screenH * 0.1944, screenW * 0.7806, screenH * 0.2167, tocolor(0, 0, 0, 220), 1.00, r_text, "center", "center", false, false, false, false, false)
			dxDrawText("Complexión", screenW * 0.7069, screenH * 0.2744, screenW * 0.7806, screenH * 0.2967, tocolor(0, 0, 0, 220), 1.00, r_text, "center", "center", false, false, false, false, false)
			dxDrawRectangle(screenW * 0.7063, screenH * 0.2289, screenW * 0.0744, screenH * 0.0211, tocolor(0, 0, 0, 128), false)
			dxDrawText(razas[indiceraza], screenW * 0.7063, screenH * 0.2289, screenW * 0.7800, screenH * 0.2511, tocolor(2,105,156, 220), 1.00, "arial", "center", "center", false, false, false, false, false)
			if isCursorHover(screenW * 0.7887, screenH * 0.2300, screenW * 0.0100, screenH * 0.0222) then
			dxDrawText("▶", screenW * 0.7800, screenH * 0.2100, screenW * 0.8087, screenH * 0.2689, tocolor(100, 100, 100, 255), 1.50, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("▶", screenW * 0.7800, screenH * 0.2100, screenW * 0.8087, screenH * 0.2689, tocolor(2,107,156, 255), 1.50, "default", "center", "center", false, false, false, false, false)
			end
			if isCursorHover(screenW * 0.6881, screenH * 0.2278, screenW * 0.0100, screenH * 0.0222) then
			dxDrawText("◀", screenW * 0.6775, screenH * 0.2100, screenW * 0.7063, screenH * 0.2689, tocolor(100, 100, 100, 255), 1.50, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("◀", screenW * 0.6775, screenH * 0.2100, screenW * 0.7063, screenH * 0.2689, tocolor(2,107,156, 255), 1.50, "default", "center", "center", false, false, false, false, false)
			end
			dxDrawLine((screenW * 0.7006) - 1, (screenH * 0.4044) - 1, (screenW * 0.7006) - 1, screenH * 0.4489, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, (screenH * 0.4044) - 1, (screenW * 0.7006) - 1, (screenH * 0.4044) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.7006) - 1, screenH * 0.4489, screenW * 0.7919, screenH * 0.4489, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, screenH * 0.4489, screenW * 0.7919, (screenH * 0.4044) - 1, tocolor(0, 0, 0, 255), 1, false)
			if isCursorHover(screenW * 0.7006, screenH * 0.4044, screenW * 0.0912, screenH * 0.0444) then
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4044, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			else
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4044, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			end
			dxDrawLine((screenW * 0.7006) - 1, (screenH * 0.4700) - 1, (screenW * 0.7006) - 1, screenH * 0.5144, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, (screenH * 0.4700) - 1, (screenW * 0.7006) - 1, (screenH * 0.4700) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.7006) - 1, screenH * 0.5144, screenW * 0.7919, screenH * 0.5144, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, screenH * 0.5144, screenW * 0.7919, (screenH * 0.4700) - 1, tocolor(0, 0, 0, 255), 1, false)
			if isCursorHover(screenW * 0.7006, screenH * 0.4700, screenW * 0.0912, screenH * 0.0444) then
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4700, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			else
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4700, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			end
			dxDrawText("Crear personaje", screenW * 0.7006, screenH * 0.4044, screenW * 0.7919, screenH * 0.4489, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
			dxDrawText("Cancelar", screenW * 0.7006, screenH * 0.4700, screenW * 0.7919, screenH * 0.5144, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
			dxDrawText("Usa la rueda del ratón para girar el personaje", screenW * 0.6481, screenH * 0.6156, screenW * 0.8475, screenH * 0.6467, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
			
			dxDrawLine((screenW * 0.6719) - 1, (screenH * 0.0256) - 1, (screenW * 0.6719) - 1, screenH * 0.0811, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.8175, (screenH * 0.0256) - 1, (screenW * 0.6719) - 1, (screenH * 0.0256) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.6719) - 1, screenH * 0.0811, screenW * 0.8175, screenH * 0.0811, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.8175, screenH * 0.0811, screenW * 0.8175, (screenH * 0.0256) - 1, tocolor(0, 0, 0, 255), 1, false)
			if isCursorHover(screenW * 0.6719, screenH * 0.0256, screenW * 0.1456, screenH * 0.0556) then
			dxDrawRectangle(screenW * 0.6719, screenH * 0.0256, screenW * 0.1456, screenH * 0.0556, tocolor(2,105,156, 200), false)
			else
			dxDrawRectangle(screenW * 0.6719, screenH * 0.0256, screenW * 0.1456, screenH * 0.0556, tocolor(2,105,156, 200), false)
			end
			dxDrawText("Cambiar sexo", screenW * 0.6719, screenH * 0.0244, screenW * 0.8175, screenH * 0.0811, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
			-- texto de error dxDrawRectangle(screenW * 0.6775, screenH * 0.5256, screenW * 0.1356, screenH * 0.0744, tocolor(255, 255, 255, 255), false)
		else
			dxDrawText(nombrec, screenW * 0.3425, screenH * 0.0211, screenW * 0.6000, screenH * 0.0889, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			if isCursorHover(screenW * 0.5750, screenH * 0.3678, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("▶", screenW * 0.5713, screenH * 0.3533, screenW * 0.6000, screenH * 0.4122, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("▶", screenW * 0.5713, screenH * 0.3533, screenW * 0.6000, screenH * 0.4122, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			if isCursorHover(screenW * 0.3488, screenH * 0.3667, screenW * 0.0194, screenH * 0.0378) then
			dxDrawText("◀", screenW * 0.3425, screenH * 0.3533, screenW * 0.3713, screenH * 0.4122, tocolor(100, 100, 100, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			else
			dxDrawText("◀", screenW * 0.3425, screenH * 0.3533, screenW * 0.3713, screenH * 0.4122, tocolor(2,107,156, 255), 3.00, "default", "center", "center", false, false, false, false, false)
			end
			dxDrawRectangle(screenW * 0.6719, screenH * 0.1733, screenW * 0.1475, screenH * 0.4378, tocolor(2,105,156, 200), false)
			dxDrawRectangle(screenW * 0.6719, screenH * 0.0889, screenW * 0.1469, screenH * 0.0678, tocolor(2,105,156, 220), false)
			dxDrawText("Estadísticas", screenW * 0.6719, screenH * 0.0889, screenW * 0.8187, screenH * 0.1567, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			dxDrawText("Skin ID:", screenW * 0.7069, screenH * 0.1944, screenW * 0.7806, screenH * 0.2167, tocolor(0, 0, 0, 220), 1.00, r_text, "center", "center", false, false, false, false, false)
			dxDrawText(femaleSkins[womanskinindex], screenW * 0.6887, screenH * 0.2389, screenW * 0.8037, screenH * 0.3344, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
			dxDrawLine((screenW * 0.7006) - 1, (screenH * 0.4044) - 1, (screenW * 0.7006) - 1, screenH * 0.4489, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, (screenH * 0.4044) - 1, (screenW * 0.7006) - 1, (screenH * 0.4044) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.7006) - 1, screenH * 0.4489, screenW * 0.7919, screenH * 0.4489, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, screenH * 0.4489, screenW * 0.7919, (screenH * 0.4044) - 1, tocolor(0, 0, 0, 255), 1, false)
			if isCursorHover(screenW * 0.7006, screenH * 0.4044, screenW * 0.0912, screenH * 0.0444) then
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4044, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			else
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4044, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			end
			dxDrawLine((screenW * 0.7006) - 1, (screenH * 0.4700) - 1, (screenW * 0.7006) - 1, screenH * 0.5144, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, (screenH * 0.4700) - 1, (screenW * 0.7006) - 1, (screenH * 0.4700) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.7006) - 1, screenH * 0.5144, screenW * 0.7919, screenH * 0.5144, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.7919, screenH * 0.5144, screenW * 0.7919, (screenH * 0.4700) - 1, tocolor(0, 0, 0, 255), 1, false)
			if isCursorHover(screenW * 0.7006, screenH * 0.4700, screenW * 0.0912, screenH * 0.0444) then
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4700, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			else
			dxDrawRectangle(screenW * 0.7006, screenH * 0.4700, screenW * 0.0912, screenH * 0.0444, tocolor(2,105,156, 220), false)
			end
			dxDrawText("Crear personaje", screenW * 0.7006, screenH * 0.4044, screenW * 0.7919, screenH * 0.4489, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
			dxDrawText("Cancelar", screenW * 0.7006, screenH * 0.4700, screenW * 0.7919, screenH * 0.5144, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
			dxDrawText("Usa la rueda del ratón para girar el personaje", screenW * 0.6481, screenH * 0.6156, screenW * 0.8475, screenH * 0.6467, tocolor(255, 255, 255, 255), 1.00, r_desc, "center", "center", false, false, false, false, false)
			
			dxDrawLine((screenW * 0.6719) - 1, (screenH * 0.0256) - 1, (screenW * 0.6719) - 1, screenH * 0.0811, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.8175, (screenH * 0.0256) - 1, (screenW * 0.6719) - 1, (screenH * 0.0256) - 1, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine((screenW * 0.6719) - 1, screenH * 0.0811, screenW * 0.8175, screenH * 0.0811, tocolor(0, 0, 0, 255), 1, false)
			dxDrawLine(screenW * 0.8175, screenH * 0.0811, screenW * 0.8175, (screenH * 0.0256) - 1, tocolor(0, 0, 0, 255), 1, false)
			if isCursorHover(screenW * 0.6719, screenH * 0.0256, screenW * 0.1456, screenH * 0.0556) then
			dxDrawRectangle(screenW * 0.6719, screenH * 0.0256, screenW * 0.1456, screenH * 0.0556, tocolor(2,105,156, 200), false)
			else
			dxDrawRectangle(screenW * 0.6719, screenH * 0.0256, screenW * 0.1456, screenH * 0.0556, tocolor(2,105,156, 200), false)
			end
			dxDrawText("Cambiar sexo", screenW * 0.6719, screenH * 0.0244, screenW * 0.8175, screenH * 0.0811, tocolor(255, 255, 255, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
		end
		end
    end
)

function clickmouse( button, state)
	if button == "left" and state == "down" then
		if mostrarpersonalizacion then
			if isCursorHover(screenW * 0.7887, screenH * 0.2300, screenW * 0.0100, screenH * 0.0222) and sexo == "hombre" then--raza +
				if indiceraza < 4 then
					indiceraza = indiceraza+1
				else
					indiceraza = 1
				end
				cabezasraza = exports.cabezas:getCabezasRaza(indiceraza)
				indicetablacabezas = 1
				cabezaselect = cabezasraza[indicetablacabezas]
				exports.cabezas:ponerCabeza(ped, cabezaselect)
				exports.clothes:ponerRopa(ped, partealta[camisa], partebaja[pantalon], 3, indiceraza)
			end
			
			if isCursorHover(screenW * 0.6881, screenH * 0.2278, screenW * 0.0100, screenH * 0.0222) and sexo == "hombre" then--raza -
				if indiceraza > 1 then
					indiceraza = indiceraza-1
				else
					indiceraza = 4
				end
				cabezasraza = exports.cabezas:getCabezasRaza(indiceraza)
				indicetablacabezas = 1
				cabezaselect = cabezasraza[indicetablacabezas]
				exports.cabezas:ponerCabeza(ped, cabezaselect)
				exports.clothes:ponerRopa(ped, partealta[camisa], partebaja[pantalon], 3, indiceraza)
			end
			
			if isCursorHover(screenW * 0.5744, screenH * 0.2089, screenW * 0.0194, screenH * 0.0378) and sexo == "hombre" then--cabeza -
				if indicetablacabezas == 1 then
					indicetablacabezas = #cabezasraza
				else
					indicetablacabezas = indicetablacabezas-1
				end
				cabezaselect = cabezasraza[indicetablacabezas]
				exports.cabezas:ponerCabeza(ped, cabezaselect)
				
			end
			
			if isCursorHover(screenW * 0.3488, screenH * 0.2111, screenW * 0.0194, screenH * 0.0378) and sexo == "hombre" then--cabeza +
				if indicetablacabezas == #cabezasraza then
					indicetablacabezas = 1
				else
					indicetablacabezas = indicetablacabezas+1
				end
				cabezaselect = cabezasraza[indicetablacabezas]
				exports.cabezas:ponerCabeza(ped, cabezaselect)
				
			end
			
			if isCursorHover(screenW * 0.5750, screenH * 0.3678, screenW * 0.0194, screenH * 0.0378) then --camisa +
				if sexo == "hombre" then
					if camisa == #partealta then
					camisa = 1
					else
					camisa = camisa+1
					end
					exports.clothes:ponerRopa(ped, partealta[camisa], partebaja[pantalon], 3, indiceraza)
				else
					if womanskinindex == #femaleSkins then
					womanskinindex = 1
					else
					womanskinindex = womanskinindex +1
					end
					setElementModel(ped, femaleSkins[womanskinindex])
				end
			end
			
			if isCursorHover(screenW * 0.3488, screenH * 0.3667, screenW * 0.0194, screenH * 0.0378) then --camisa -
				if sexo == "hombre" then
					if camisa == 1 then
					camisa = #partealta
					else
					camisa = camisa-1
					end
					exports.clothes:ponerRopa(ped, partealta[camisa], partebaja[pantalon], 3, indiceraza)
				else
					if womanskinindex == 1 then
					womanskinindex = #femaleSkins
					else
					womanskinindex = womanskinindex -1
					end
					setElementModel(ped, femaleSkins[womanskinindex])
				end
			end
			
			if isCursorHover(screenW * 0.5737, screenH * 0.6100, screenW * 0.0194, screenH * 0.0378) and sexo == "hombre" then--pantalon +
				if pantalon == #partebaja then
				pantalon = 1
				else
				pantalon = pantalon+1
				end
				exports.clothes:ponerRopa(ped, partealta[camisa], partebaja[pantalon], 3, indiceraza)
			end
			
			if isCursorHover(screenW * 0.3481, screenH * 0.6078, screenW * 0.0194, screenH * 0.0378) and sexo == "hombre" then--pantalon -
				if pantalon == 1 then
				pantalon = #partebaja
				else
				pantalon = pantalon-1
				end
				exports.clothes:ponerRopa(ped, partealta[camisa], partebaja[pantalon], 3, indiceraza)
			end
			
			if isCursorHover(screenW * 0.6719, screenH * 0.0256, screenW * 0.1456, screenH * 0.0556) then -- cambiarsexo
				if sexo == "hombre" then
				mostrarpersonalizacion = false
				guiSetVisible(complexiongrasa,false)
				guiSetVisible(complexionmusculo,false)
				fadeCamera(false,3)
					setTimer ( function()
					exports.cabezas:ponerCabeza(ped, false)
					setPedHeadless(ped, false)
					setElementModel(ped, femaleSkins[womanskinindex])
					sexo = "mujer"
					mostrarpersonalizacion = true
					fadeCamera(true, 3)
					end, 3100, 1 )
				else
				mostrarpersonalizacion = false
				fadeCamera(false,3)
					setTimer ( function()
					setElementModel(ped, 0)
					setPedHeadless(ped, true)
					exports.cabezas:ponerCabeza(ped, cabezaselect)
					exports.clothes:ponerRopa(ped, partealta[camisa], partebaja[pantalon], 3, indiceraza)
					guiSetVisible(complexiongrasa,true)
					guiSetVisible(complexionmusculo,true)
					mostrarpersonalizacion = true
					sexo = "hombre"
					fadeCamera(true, 3)
					end, 3100, 1 )
				end
			end
			
			if isCursorHover(screenW * 0.7006, screenH * 0.4700, screenW * 0.0912, screenH * 0.0444) then--cancelar
				exports.cabezas:ponerCabeza(ped, false)
				unbindKey( "mouse_wheel_up", "down", scrollup)
				unbindKey( "mouse_wheel_down", "down", scrolldown)
				toggleControl('chatbox', true)
				guiSetInputMode('no_binds')
				
				destroyElement(ped)
				
				destroyElement(complexiongrasa)
				destroyElement(complexionmusculo)
				
				mostrarpersonalizacion = false
				
				indiceraza = 2
				cabezasraza = exports.cabezas:getCabezasRaza(indiceraza)
				indicetablacabezas = 1
				cabezaselect = cabezasraza[indicetablacabezas]
				camisa = 1
				pantalon = 1
				sexo = "hombre"
				womanskinindex = 1
				
				smoothMoveCamera(1564.5439453125, -1358.9677734375, 329.91107177734, 1562.0234375, -1346.708984375, 329.90609741211,1298.2099609375, -1334.74609375, 298.45028686523, 2202.98828125, -1771.822265625, 13.1796875,5000)
				setTimer ( function()
				smoothMoveCamera(1180.1650390625, -1725.23828125, 200.44729614258, 1562.0234375, -1346.708984375, 329.90609741211, 1161.9990234375, -1483.7392578125, 257.20013427734, 2202.98828125, -1771.822265625, 13.1796875,5000)
				end, 5100, 1 )
				
				setTimer ( function()
					mostrarseleccion = true
				end, 10110, 1 )
			end
			
			if isCursorHover(screenW * 0.7006, screenH * 0.4044, screenW * 0.0912, screenH * 0.0444) then -- Crear personaje
				if sexo == "hombre" then
				local fit = guiScrollBarGetScrollPosition ( complexionmusculo )*8
				local fat = guiScrollBarGetScrollPosition ( complexiongrasa )*8
				triggerServerEvent ( "crear:pj", localPlayer, localPlayer, tostring(nombrec), tonumber(edadc), tonumber(alturac), tostring(dnic), "hombre", 0, tonumber(cabezaselect), partealta[camisa], partebaja[pantalon], 3, indiceraza,fit,fat )
				else
				triggerServerEvent ( "crear:pj", localPlayer, localPlayer, tostring(nombrec), tonumber(edadc), tonumber(alturac), tostring(dnic), "mujer", getElementModel(ped) )
				end
			end
		end
	end
end
addEventHandler ( "onClientClick", getRootElement(), clickmouse )






function verifyDNI( dni )
	if not dni then
		return "No has introducido ningún DNI"
	elseif #dni < 9 then
		return "Tu DNI tiene que tener 9 caracteres 8 números y una letra mayúscula."
	elseif #dni > 9 then
		return "Tu DNI tiene que tener 9 caracteres 8 números y una letra mayúscula."
	else
		
		local currentPartD = ''
		
		for i = 1, #dni do
			local currentCharD = dni:sub( i, i )
			if currentCharD == ' ' then
				if i == 1 then
					return "Tu DNI no puede empezar con un espacio, debe seguir el formato 12345678M"
				elseif i == #dni then
					return "Tu DNI no puede terminar con un espacio, debe seguir el formato 12345678M"
				else
					return "Tu DNI no puede tener espacios."
				end
			elseif i == #dni then
				if currentCharD < 'A' or currentCharD > 'Z' then
				return "Tu DNI tiene que terminar con una letra mayúscula."
				end
			elseif not tonumber(currentCharD) then
				return "Tu DNI debe formarse por 8 números y una letra mayúscula."
				
			else
				
			end
		end
	end
end

function verifyCharacterName( name )
	if not name then
		return "No has introducido ningún nombre."
	elseif #name < 5 then
		return "Tu nombre tiene que tener un mínimo de 5 caracteres."
	elseif #name >= 20 then
		return "Tu nombre tiene que tener un máximo de 20 caracteres."
	else
		local foundSpace = false
		
		local lastChar = ' '
		local currentPart = ''
		
		for i = 1, #name do
			local currentChar = name:sub( i, i )
			if currentChar == ' ' then
				if i == 1 then
					return "Tu nombre no puede empezar con un espacio, debe seguir el formato Nombre Apellido."
				elseif i == #name then
					return "Tu nombre no puede terminar con un espacio, debe seguir el formato Nombre Apellido."
				elseif lastChar == ' ' then
					return "Tu nombre tiene dos espacios seguidos debe seguir el formato Nombre Apellido."
				else
					foundSpace = true
					
					if #currentPart < 2 then
						return "El nombre debe dividirse en dos partes, Nombre y Apellido, como mínimo."
					else
						currentPart = ""
					end
				end
			elseif lastChar == ' ' then -- need a capital letter at the start
				if currentChar < 'A' or currentChar > 'Z' then
					return "El formato debe ser el correcto: Nombre Apellido ( sin incluir el guión bajo )"
				end
				currentPart = currentPart .. currentChar
			elseif ( currentChar >= 'a' and currentChar <= 'z' ) or ( currentChar >= 'A' and currentChar <= 'Z' ) then
				currentPart = currentPart .. currentChar
			else
				return "Tu nombre contiene caracteres inválidos. Por favor, ponlo correctamente."
			end
			lastChar = currentChar
		end
		
		if not foundSpace then
			return "El nombre debe dividirse en dos partes, Nombre y Apellido, como mínimo."
		elseif #currentPart < 2 then
			return "Cada parte, Nombre y Apellido, debe contener mínimo dos caracteres."
		end
	end
end
isSceneFirst=false
function hacercinematica(data)
	
	thebus = createVehicle ( 538, 2001.603515625, -1957.7939453125, 13.546875,0,0,84.7) -- 527.2998046875, -139.900390625, 38.099998474121, 353.99597167969, 0, 90.994262695313
	setVehicleColor(thebus, 0,0,0)
	theped = createPed ( data.skin, 2202.98828125, -1771.822265625, 13.1796875,0 )
	warpPedIntoVehicle ( theped,thebus,0 )
	setElementDimension(localPlayer, 1)
	setElementDimension(thebus, 1)
	setElementDimension(theped, 1)
	  
	setPedControlState(theped, "accelerate", true)
	
	mostrarseleccion = false
	pjsdata = nil
	fadeCamera( false, 3)
	setTimer ( function()
	
	-- SONIDO LOGIN 
	--loginsound2 = playSound ( ":login/heartlandss.mp3", true )
	isSceneFirst = true
	smoothMoveCamera(2226.5029296875, -1732.3896484375, 32.290699005127, 2205.990234375, -1813.23828125, 13.1796875, 2207.009765625, -1858.6455078125, 13.489064216614, 2202.78515625, -1810.0693359375, 12.335643768311,7000)
	fadeCamera(true, 3)
		setTimer ( function()
		fadeCamera(false, 3)
		end, 6900, 1 )
		setTimer ( function()
		isSceneFirst=false
		setPedControlState(theped, "accelerate", false)
		destroyElement(thebus)
		thebus2 = createVehicle ( 538, 2080.5185546875, -1968.91796875, 48.378711700439, 2080.5185546875, -1968.91796875, 48.378711700439) 
		setVehicleColor(thebus2, 0,0,0)
		setElementDimension(thebus2, 1)
		warpPedIntoVehicle ( theped,thebus2,0 )
		setPedControlState(theped, "accelerate", true)
		fadeCamera(true, 3)
		smoothMoveCamera(1824.3125, -1964.9482421875, 28.482990264893, 1818.455078125, -1947.5283203125, 14.37922668457, 1778.8193359375, -1949.384765625, 14.109554290771, 1737.1640625, -1950.759765625, 14.1171875,15000)
			setTimer( function()
				setElementRotation(thebus2, 0,0,90.3)
				setPedControlState(theped, "accelerate", false)
				setPedControlState(theped, "brake_reverse", true)
				setTimer( function()
				setPedControlState(theped, "brake_reverse", false)
				end, 2700,1)
			end, 5500,1)
			
			setTimer( function()
				fadeCamera(false, 3)
				setTimer( function()
				fadeCamera(false, 3)
					setTimer( function()
					triggerServerEvent("pj:spawn", localPlayer, localPlayer, data)
					showCursor(false)
					showChat(true)
					guiSetInputEnabled ( false )
					destroyElement(loginsound2)
					end, 3000,1)
				end, 4000,1)
			end, 10000,1)
		end, 11000, 1 )
	end, 4100, 1 )
end
addEventHandler("onClientRender", root,
    function()
		if isSceneFirst then
        dxDrawText("El tren ha llegado a la ciudad\n\nBienvenido/a a\n      Idlewood Roleplay", screenW * 0.2150, screenH * 0.2311, screenW * 0.5663, screenH * 0.3767, tocolor(2,105,156, 255), 1, r_main, "center", "center", false, false, false, false, false)

		end
	end
)


local respawnKeys = { 'enter' }

--

local respawnWait = false
local screenX, screenY = guiGetScreenSize( )

function drawRespawnText( )
	if isPedDead(localPlayer) then
	local text = "Pulsa '" .. respawnKeys[1] .. "' para reaparecer"
	
	-- check if we still need to wait
	if respawnWait and isPedDead(localPlayer) then
		local diff = respawnWait - getTickCount( )
		if diff >= 0 then
			text = ( "Debes esperar %.1f segundos" ):format( diff / 1000 )
		else
			-- check if the player presses a control, wouldn't be caught by SA as the key is down
			for key, value in ipairs( respawnKeys ) do
				if getKeyState( value ) then
					requestRespawn( )
					break
				end
			end
		end
	end
	
	-- draw the text
	dxDrawText( text, 4, 4, screenX, screenY, tocolor( 0, 0, 0, 255 ), 1, r_title, "center", "center" )
	dxDrawText( text, 0, 0, screenX, screenY, tocolor( 255, 255, 255, 255 ), 1, r_title, "center", "center" )
	end
end

function requestRespawn( )
	if isPedDead( localPlayer ) and respawnWait and respawnWait - getTickCount( ) < 0 then
		respawnWait = false
		removeEventHandler( "onClientRender", root, drawRespawnText )
		
		-- let's respawn!
		triggerServerEvent( "onPlayerRespawn", localPlayer )
	end
end

addEventHandler( "onClientPlayerWasted", localPlayer,
	function( )
		-- keep the camera (reset when the player respawns)
		local a, b, c = getCameraMatrix( )
		local d, e, f = getElementPosition( localPlayer )
		setCameraMatrix( a, b, c, d, e, f )
		
		respawnWait = getTickCount( ) + getElementData( resourceRoot, 'respawnDelay' ) * 1000
		addEventHandler( "onClientRender", root, drawRespawnText )
	end
)
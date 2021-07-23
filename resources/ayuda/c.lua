    r_title = dxCreateFont( ":personajes/fonts/Roboto-BoldCondensed.ttf", 20 )
    r_text = dxCreateFont( ":personajes/fonts/Roboto-Regular.ttf",  11)
    r_desc = dxCreateFont( ":personajes/fonts/Roboto-Italic.ttf", 10 )
    r_button = dxCreateFont( ":personajes/fonts/Roboto-Condensed.ttf", 11 )

texto = {
    [0] = [[
    Bienvenidos al panel de ayuda de Countryside Roleplay: Todas vuestras
    dudas se resuelven aquí.

    Haz click en la sección deseada para encontrar información sobre el
    funcionamiento de los diferentes sistemas del servidor.

    ▻ Cualquier bug debe ser reportado al equipo administrativo.
    ▻ Os recordamos que jugar con una resolución muy baja o muy alta puede
    alterar la visualización del juego.
    ]],
    [1] = [[
    El hud que usa el servidor es totalmente personalizado:

    ▻ Puedes ver el significado de las franjas pequeñas pasando el cursor
    por encima.( Se activa pulsando 'm')
    ▻ El resto de barras corresponden a los colores por defecto del GTA:SA.
    ▻ Para ocultar/mostrar el hud usar /togglehud
    ▻ Usar /solidchat para activar/desactivar el SolidChat.
    ▻ Usar /showchat para ocular el chat ( en consola para activarlo )
    ▻ Usar /togglenametags para ocultar los nombres de los jugadores.
    ▻ 2días reales = 1día ingame, como indica la hora del hud.
    ▻ Con la rueda del ratón podéis alternar entre los diferentes objetos
    del panel de objetos de acceso rápido.
    ▻ El icono del objeto seleccionado se mostrará en el hud, acompañado de
    un número que corresponde a los usos/munición/ID.
    ]],
    [2] = [[
    Con la tecla 'i' podéis abrir el inventario. Dando click en la pestaña
    de la derecha se oculta/muestra el panel de acceso rápido.

    ▻ Para interactuar con el objeto seleccionado ( /usar, /tirar)
    ▻ Con click drecho podrás usar el objeto seleccionado rápidamente.
    ▻ Arrastrar el objeto para moverlo por el panel. Click derecho para mostrar
    una ventana con opciones. ( con el bolsillo abierto )
    ▻ Arrastrar el objeto a otro jugador para entregarlo.
    ▻ Arrastrar el objeto al suelo para tirarlo.
    ▻ Los dos huecos inferiores del panel de acceso rápido corresponden a los
    objetos almacenados en el pecho y la espalda.
    ▻ Las armas grandes solo podrán guardarse, de hecho, en los huecos de pecho
    y espalda.
    ▻ Pulsar 'Q' para cambiar a los puños.
    ▻ Pulsar 'R' para recargar un arma ( si tenéis munición en el bolsillo )
    ▻ La ropa solo puede almacenarse en armarios y usarse desde los mismos.
    ]],
    [3] = [[
    Puedes controlar tu vehículo usando los números de Numpad: 1, 2, 3 y 0
	1 ó /motor
	2 ó /luces
	3 ó /puertas
	0 ó /frenomano
	tambien puedes usar /cinturon
    ]],
    [4] = [[
Countryside Roleplay cuenta con un sistema faccionario totalmente innovador, script el cual no está enlazado solamente al modo de juego, sino que también está enlazado al foro, y al PCU, por ende, usted contará con un sistema más inmersivo y coherente al momento de realizar curriculums vitae y realizar contrataciones.
Una vez que nos añadan a una facción, podemos acceder a su información presionando la tecla F3, también si somos líderes u ocupamos un cargo con permisos dentro de ella, podremos modificarla. (Expulsar y agregar miembros, bajar/subir sueldos, etc)

    ]],
    [5] = [[
El banco sirve y se utiliza para resguardar tu dinero mientras estés en la vía pública, de éste modo, el mismo quedará a salvo ante posibles atracos o inconvenientes. 
    Para utilizar el banco, primero que nada hay que solicitar una tarjeta en el mismo banco, acercándote al ped, apretamos la tecla “M” y solicitamos una tarjeta de crédito, la cual le colocaremos un pin de 4 dígitos.
    Una vez teniendo la tarjeta, podemos guardar y retirar dinero las veces que querramos. Para ello es necesario abrir la interfaz del banco, dirigiéndose al ped, apretando la tecla “M”, dandole click al  ped y seguidamente seleccionar la tarjeta, una vez que introducimos el pin de seguridad, accederemos a la cuenta de la tarjeta, donde figura nuestra cantidad de dinero, y dos botones para retirar o depositar
    Para retirar dinero tendremos que pulsar el botón “Retirar”, colocar la cantidad la cual usted desea retirar seguidamente del concepto, es decir, el motivo por el cual retira el dinero.
Todos los movimientos de la tarjeta quedarán registrados en un panel, el cual demostrará los ingresos y egresos de la misma tarjeta.
    Para depositar dinero, pulse el botón “Depositar”, seguidamente coloque el monto que desea depositar y el motivo del mismo.


    ]],
    [6] = [[
Countryside Roleplay cuenta con un sistema de interiores modificable, es decir que usted podrá amueblar su interior a su gusto y comodidad. Todo interior se ingresa y se sale utilizando la tecla “E”
    Si usted desea amueblar su interior post compra. Deberá dirigirse a una mueblería, tienda de informática, ferretería, etc para realizar la compra de los respectivos muebles, una vez que haya los haya comprado, ingresará a su respectivo interior, abrirá el inventario utilizando la tecla “I” y seguidamente empezará a colocar los muebles
    El sistema de muebles de Countryside Roleplay está scripteado totalmente desde 0, como todo el servidor, por lo cual usted gozará de calidad en scripting, facilidad de colocación de los muebles sin bugs.

    ]],
    [7] = [[
    Chat IC: Presionando la tecla T abriremos el chat para comunicarnos de manera IC con otros usuarios, este chat representa lo que nuestro personaje dice.
                 Al utilizar /c (texto) podemos susurrar, y si utilizamos /s (texto) nuestro personaje gritará.

    Entorno: Presionando la tecla T y luego escribiendo /do (texto) podemos expresar el entorno, también podemos utilizar /ame (texto)

    Acciones: Presionando la tecla T y luego /me (texto) podremos relatar las acciones de nuestro personaje dentro del juego.

    /intentar (texto) es un formato parecido al de acción, solo que por azar nos dirá si hemos conseguido lo que queríamos hacer o no.

    Chat OOC: Presionando la tecla B (o en su defecto, T y luego /b seguido del texto) abrimos el chat para comunicarnos de manera OOC con otros usuarios, este chat se utiliza única y exclusivamente para casos administrativos, el mal uso de este canal es sancionable.

    /pm (id del usuario) (texto) sirve para enviar mensajes privados dentro del juego, totalmente OOC.

    ]],
    [8] = [[
Para adquirir un vehículo en el concesionario, hay que dirigirse al foro y registrarse, una vez nuestra cuenta de foro esté vinculada con la del juego, podemos adquirir ahora sí nuestro vehículo desde el foro, para ello presionamos en el inicio la placa que dice “Concesionario”, allí seleccionamos el vehículo deseado, seleccionamos nuestro personaje y hacemos el pedido.
Una vez In Game, nos dirigimos al concesionario, presionamos la tecla “M” y luego click izquierdo al NPC, y ahí estará nuestro pedido, luego continuamos con la compra.
    ]],
    [9] = [[
Para comprar en tiendas tenemos que dirigirnos a las mismas para adquirir el objeto deseado, presionamos la tecla “M” y luego click izquierdo al NPC, se nos abrirá una interfaz, ahí tendremos que elegir los objetos de nuestro interés, se irán apilando en el carrito y finalmente podemos comprar todo lo seleccionado, dándole clic a “comprar”
Al finalizar, todos nuestros items estarán dentro de un recipiente, lo abrimos presionando la tecla “i” para abrir nuestro inventario, y los traspasamos a nuestros bolsillos o donde deseemos.

    ]],
}

local screenW, screenH = guiGetScreenSize()
isPanelAyuda = false
selectedSection = 0

function openPanelAyuda()
if getElementData(localPlayer, "isLoged") then
    if isPanelAyuda then
        isPanelAyuda=false
        showCursor(false)
        selectedSection = 0
    else
        isPanelAyuda=true
        showCursor(true)
    end
end
end

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
function dxDrawTextOnRectangle(texto, posX, posY, whidth, height, color,scale, fuente, cite1, cite2, posGui)
    dxDrawText(texto, posX, posY, whidth+posX, height+posY, color, scale, fuente or "arial", cite1 or "center", cite2 or "center", false, true, posGui or false, false, false)
end

addEventHandler("onClientRender", root,
    function()
        if isPanelAyuda then
            dxDrawRectangle(screenW * 0.2813, screenH * 0.1556, screenW * 0.4094, screenH * 0.6300, tocolor(2,105,156, 164), false)
            dxDrawRectangle(screenW * 0.2813, screenH * 0.0911, screenW * 0.4094, screenH * 0.0533, tocolor(2,105,156, 238), false)
            dxDrawText("PANEL DE AYUDA", (screenW * 0.2813) - 1, (screenH * 0.0922) - 1, (screenW * 0.6906) - 1, (screenH * 0.1444) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("PANEL DE AYUDA", (screenW * 0.2813) + 1, (screenH * 0.0922) - 1, (screenW * 0.6906) + 1, (screenH * 0.1444) - 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("PANEL DE AYUDA", (screenW * 0.2813) - 1, (screenH * 0.0922) + 1, (screenW * 0.6906) - 1, (screenH * 0.1444) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("PANEL DE AYUDA", (screenW * 0.2813) + 1, (screenH * 0.0922) + 1, (screenW * 0.6906) + 1, (screenH * 0.1444) + 1, tocolor(0, 0, 0, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawText("PANEL DE AYUDA", screenW * 0.2813, screenH * 0.0922, screenW * 0.6906, screenH * 0.1444, tocolor(255, 255, 255, 255), 1.00, r_title, "center", "center", false, false, false, false, false)
            dxDrawLine(screenW * 0.3525, screenH * 0.1778, screenW * 0.3531, screenH * 0.7544, tocolor(255, 255, 255, 255), 1, false)
            dxDrawRectangle(screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744, tocolor(34,94,122, 255), false)
            if selectedSection == 0 then
                dxDrawTextOnRectangle(texto[0], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 1 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.1789, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[1], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 2 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.2356, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[2], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 3 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.2956, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[3], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 4 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.3556, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[4], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 5 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.4156, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[5], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 6 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.4756, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[6], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 7 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.5356, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[7], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 8 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.5956, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[8], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end
            if selectedSection == 9 then
                dxDrawRectangle(screenW * 0.2906, screenH * 0.6556, screenW * 0.0688, screenH * 0.0489, tocolor(34,94,122, 255), false)
                dxDrawTextOnRectangle(texto[9], screenW * 0.3594, screenH * 0.1789, screenW * 0.3144, screenH * 0.5744,tocolor(0,0,0,255),0.9,r_desc,'left','top',false)
            end

                if isCursorHover(screenW * 0.2906, screenH * 0.1789, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("HUD", (screenW * 0.2913) + 1, (screenH * 0.1811) + 1, (screenW * 0.3531) + 1, (screenH * 0.2278) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("HUD", screenW * 0.2913, screenH * 0.1811, screenW * 0.3531, screenH * 0.2278, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("HUD", (screenW * 0.2913) + 1, (screenH * 0.1811) + 1, (screenW * 0.3531) + 1, (screenH * 0.2278) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("HUD", screenW * 0.2913, screenH * 0.1811, screenW * 0.3531, screenH * 0.2278, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.2356, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("INVENTARIO", (screenW * 0.2913) + 1, (screenH * 0.2356) + 1, (screenW * 0.3531) + 1, (screenH * 0.2822) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("INVENTARIO", screenW * 0.2913, screenH * 0.2356, screenW * 0.3531, screenH * 0.2822, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("INVENTARIO", (screenW * 0.2913) + 1, (screenH * 0.2356) + 1, (screenW * 0.3531) + 1, (screenH * 0.2822) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("INVENTARIO", screenW * 0.2913, screenH * 0.2356, screenW * 0.3531, screenH * 0.2822, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.2956, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("VEHÍCULOS", (screenW * 0.2906) + 1, (screenH * 0.2956) + 1, (screenW * 0.3525) + 1, (screenH * 0.3422) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("VEHÍCULOS", screenW * 0.2906, screenH * 0.2956, screenW * 0.3525, screenH * 0.3422, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("VEHÍCULOS", (screenW * 0.2906) + 1, (screenH * 0.2956) + 1, (screenW * 0.3525) + 1, (screenH * 0.3422) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("VEHÍCULOS", screenW * 0.2906, screenH * 0.2956, screenW * 0.3525, screenH * 0.3422, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.3556, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("FACCIONES", (screenW * 0.2906) + 1, (screenH * 0.3556) + 1, (screenW * 0.3525) + 1, (screenH * 0.4022) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("FACCIONES", screenW * 0.2906, screenH * 0.3556, screenW * 0.3525, screenH * 0.4022, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("FACCIONES", (screenW * 0.2906) + 1, (screenH * 0.3556) + 1, (screenW * 0.3525) + 1, (screenH * 0.4022) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("FACCIONES", screenW * 0.2906, screenH * 0.3556, screenW * 0.3525, screenH * 0.4022, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.4156, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("BANCO", (screenW * 0.2906) + 1, (screenH * 0.4178) + 1, (screenW * 0.3525) + 1, (screenH * 0.4644) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("BANCO", screenW * 0.2906, screenH * 0.4178, screenW * 0.3525, screenH * 0.4644, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("BANCO", (screenW * 0.2906) + 1, (screenH * 0.4178) + 1, (screenW * 0.3525) + 1, (screenH * 0.4644) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("BANCO", screenW * 0.2906, screenH * 0.4178, screenW * 0.3525, screenH * 0.4644, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.4756, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("INTERIORES", (screenW * 0.2906) + 1, (screenH * 0.4756) + 1, (screenW * 0.3525) + 1, (screenH * 0.5222) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("INTERIORES", screenW * 0.2906, screenH * 0.4756, screenW * 0.3525, screenH * 0.5222, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("INTERIORES", (screenW * 0.2906) + 1, (screenH * 0.4756) + 1, (screenW * 0.3525) + 1, (screenH * 0.5222) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("INTERIORES", screenW * 0.2906, screenH * 0.4756, screenW * 0.3525, screenH * 0.5222, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.5356, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("CHAT", (screenW * 0.2906) + 1, (screenH * 0.5356) + 1, (screenW * 0.3525) + 1, (screenH * 0.5822) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("CHAT", screenW * 0.2906, screenH * 0.5356, screenW * 0.3525, screenH * 0.5822, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("CHAT", (screenW * 0.2906) + 1, (screenH * 0.5356) + 1, (screenW * 0.3525) + 1, (screenH * 0.5822) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("CHAT", screenW * 0.2906, screenH * 0.5356, screenW * 0.3525, screenH * 0.5822, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.5956, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("CONCESIONARIO", (screenW * 0.2906) + 1, (screenH * 0.5956) + 1, (screenW * 0.3525) + 1, (screenH * 0.6422) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("CONCESIONARIO", screenW * 0.2906, screenH * 0.5956, screenW * 0.3525, screenH * 0.6422, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("CONCESIONARIO", (screenW * 0.2906) + 1, (screenH * 0.5956) + 1, (screenW * 0.3525) + 1, (screenH * 0.6422) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("CONCESIONARIO", screenW * 0.2906, screenH * 0.5956, screenW * 0.3525, screenH * 0.6422, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
                if isCursorHover(screenW * 0.2906, screenH * 0.6556, screenW * 0.0688, screenH * 0.0489) then
                    dxDrawText("TIENDAS", (screenW * 0.2906) + 1, (screenH * 0.6556) + 1, (screenW * 0.3525) + 1, (screenH * 0.7022) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("TIENDAS", screenW * 0.2906, screenH * 0.6556, screenW * 0.3525, screenH * 0.7022, tocolor(34,94,122, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                else
                    dxDrawText("TIENDAS", (screenW * 0.2906) + 1, (screenH * 0.6556) + 1, (screenW * 0.3525) + 1, (screenH * 0.7022) + 1, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                    dxDrawText("TIENDAS", screenW * 0.2906, screenH * 0.6556, screenW * 0.3525, screenH * 0.7022, tocolor(0, 0, 0, 255), 1.00, r_button, "center", "center", false, false, false, false, false)
                end
            end
    end
)

function clickPanelAyuda ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
    if isPanelAyuda then
        if isCursorHover(screenW * 0.2906, screenH * 0.1789, screenW * 0.0688, screenH * 0.0489) then--section1
            selectedSection=1
        elseif isCursorHover(screenW * 0.2906, screenH * 0.2356, screenW * 0.0688, screenH * 0.0489) then--section2
            selectedSection=2
        elseif isCursorHover(screenW * 0.2906, screenH * 0.2956, screenW * 0.0688, screenH * 0.0489) then--section3
            selectedSection=3
        elseif isCursorHover(screenW * 0.2906, screenH * 0.3556, screenW * 0.0688, screenH * 0.0489) then--section4
            selectedSection=4
        elseif isCursorHover(screenW * 0.2906, screenH * 0.4156, screenW * 0.0688, screenH * 0.0489) then--section5
            selectedSection=5
        elseif isCursorHover(screenW * 0.2906, screenH * 0.4756, screenW * 0.0688, screenH * 0.0489) then--section6
            selectedSection=6
        elseif isCursorHover(screenW * 0.2906, screenH * 0.5356, screenW * 0.0688, screenH * 0.0489) then--section7
            selectedSection=7
        elseif isCursorHover(screenW * 0.2906, screenH * 0.5956, screenW * 0.0688, screenH * 0.0489) then--section8
            selectedSection=8
        elseif isCursorHover(screenW * 0.2906, screenH * 0.6556, screenW * 0.0688, screenH * 0.0489) then--section9
            selectedSection=9
        end
    end
end
addEventHandler ( "onClientClick", getRootElement(), clickPanelAyuda )

bindKey('f1', 'down', openPanelAyuda)
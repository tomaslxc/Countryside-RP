# Countryside-RP

(**Aleks** no dará soporte de la misma, cualquiera duda solo la responderé yo)

En este repositorio publiqué la gamemode desarrollada de 0 por **ALEKS**, unos usuarios de la comunidad me la robaron y le pedí permiso al dueño para poder libelarla.

Nuestra GM no usa niveles, tenemos algo llamado **Etapa de Rol** (Esto se vé en el tabulador), el primer ER se consigue pasando el test de rol, los demás se dan cuando ese usuario crea su Historia de personaje (Apartir de 2 en adelante los tiene que dar un STAFF, es decir que vos controlas de que forma das los E.R )

-Todos los recursos que se encuentran en esta gamemode fueron desarrollado por **Aleks**.

Sistemas de la GM:

- Sistema de cabezas
- Sistema de ropa (las skins solo se  usan para mujeres)
- Sistema de ajustes (para quitar, lluvia, distancia y etc)
- Sistema de facciones vía F2 y F3 (Facción 1 y 2)
- Sistema de interiores
- Sistema de tiendas
- Sistema de administración
- Sistema de vehículos
- Sistema de realtime (se establece en 12 cuando prendés el servidor)
- Sistema de facción policia
- Sistema de facción camionero (rellena los negocios con NPC)
- Sistema de ER (Etapa de Rol)
- Sistema de puertas/portones (movedoors)
- Muchos otros sistemas...

## ¿Cómo instalo la GM?

- Tenés que descargar los archivos, descomprimirlos e ir a /resources/mysql/sql.lua

-Acá tendrás que agregar tus datos para establecer la conexión mysql
```bash
	connection = dbConnect( "mysql", "dbname=NombreDB;host=127.0.0.1", "usuario", "contraseña", "share=0" )
```

- Importar el archivo **gmrp.sql** y si pusiste los datos; la gamemode estará funcionando.


- Deberás de iniciar los resources manualmente para así evitar bugs con los paneles.

- Descarga el módulo MySQL que necesites desde https://wiki.multitheftauto.com/wiki/Modules/MTA-MySQL y sigue las instrucciones para su instalación.
Básicamente, si descargas la versión de 32 bits, lo único que debes de hacer es crear una carpeta llamada modules (mods/deathmatch/modules) y poner ahí el módulo.

- Igualmente, en el mtaserver.conf deberás especificar qué módulo necesitas (mta_mysql.dll para Windows; mta_mysql.so para Linux)
```bash
    <module src="mta_mysql.dll"/> <!-- Windows -->
    <module src="mta_mysql.so"/> <!-- Linux -->
```

- En el caso de Linux, puede ser necesario algún módulo más. Consúltalo aquí: https://linux.mtasa.com/

- Copia la carpeta resources a mods/deathmatch

- Una vez realizados estos pasos, puedes proceder a abrir el servidor. Todo debería estar funcionando correctamente.

- Algunos sistemas opcionales, cómo **concesionario** necesitan ser vinculados a la PCU; dicha PCU no será públicada. 


Créditos a Aleks como dueño y desarrollador. (https://forum.mtasa.com/profile/40470-mraleks/)

Actualmente se llama **Vest Roleplay** débido a que fué mi último proyecto.

- Aleks y yo decidimos públicar la GAMEMODE debido al robo de la misma; nadie más se encuentra autorizado ni es dueño de dicha gamemode.

Post: https://forum.mtasa.com/topic/131823-gm-countryside-roleplay-de-0/

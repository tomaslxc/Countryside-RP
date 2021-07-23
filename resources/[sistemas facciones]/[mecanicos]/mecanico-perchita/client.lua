-----------------------------------------------------------
--------------------Colores ricousss si quieres cambiar ya sabes modificas el color base en el de abajo y en el evento tambien---------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
colorCerrado = 38
colorPuertaIzquierda = 38
colorPuertaDerecha = 38
ColorPuertaTraseraDerecha = 38
ColorPuertaTraseraIzquierda = 38
colorMaletero = 38
colorCapot = 38
colorLuces = 38
colorParachoquesDelantero = 38
colorParachoqueTrasero = 38
colorParabrisas = 38
colorSuspension = 38
ColorFrenos = 38
ColorRuedas = 38
ColorTransmision = 38
ColorTurbo = 38
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
local screenW, screenH = guiGetScreenSize() 

function tucanoesmarica()

        dxDrawLine((screenW * 0.3236) - 1, (screenH * 0.1146) - 1, (screenW * 0.3236) - 1, screenH * 0.8971, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6523, (screenH * 0.1146) - 1, (screenW * 0.3236) - 1, (screenH * 0.1146) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3236) - 1, screenH * 0.8971, screenW * 0.6523, screenH * 0.8971, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6523, screenH * 0.8971, screenW * 0.6523, (screenH * 0.1146) - 1, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawRectangle(screenW * 0.3192, screenH * 0.2279, screenW * 0.3287, screenH * 0.7826, tocolor(0, 0, 0, 168), false)
        dxDrawLine((screenW * 0.3250) - 1, (screenH * 0.1159) - 1, (screenW * 0.3250) - 1, screenH * 0.1823, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6493, (screenH * 0.1159) - 1, (screenW * 0.3250) - 1, (screenH * 0.1159) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3250) - 1, screenH * 0.1823, screenW * 0.6493, screenH * 0.1823, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6493, screenH * 0.1823, screenW * 0.6493, (screenH * 0.1159) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3250, screenH * 0.1159, screenW * 0.3243, screenH * 0.0664, tocolor(132, 69, 14, 168), false)
        dxDrawText("Panel Mecanico", (screenW * 0.3389) - 1, (screenH * 0.1289) - 1, (screenW * 0.6384) - 1, (screenH * 0.1615) - 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Panel Mecanico", (screenW * 0.3389) + 1, (screenH * 0.1289) - 1, (screenW * 0.6384) + 1, (screenH * 0.1615) - 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Panel Mecanico", (screenW * 0.3389) - 1, (screenH * 0.1289) + 1, (screenW * 0.6384) - 1, (screenH * 0.1615) + 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Panel Mecanico", (screenW * 0.3389) + 1, (screenH * 0.1289) + 1, (screenW * 0.6384) + 1, (screenH * 0.1615) + 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Panel Mecanico", screenW * 0.3389, screenH * 0.1289, screenW * 0.6384, screenH * 0.1615, tocolor(209, 0, 0, 254), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3389) - 1, (screenH * 0.2396) - 1, (screenW * 0.3389) - 1, screenH * 0.2852, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, (screenH * 0.2396) - 1, (screenW * 0.3389) - 1, (screenH * 0.2396) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3389) - 1, screenH * 0.2852, screenW * 0.4656, screenH * 0.2852, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, screenH * 0.2852, screenW * 0.4656, (screenH * 0.2396) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3389, screenH * 0.2396, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorPuertaIzquierda, 38, 254), false)
        dxDrawText("Puerta Izquierda", (screenW * 0.3477) - 1, (screenH * 0.2487) - 1, (screenW * 0.4583) - 1, (screenH * 0.2721) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Izquierda", (screenW * 0.3477) + 1, (screenH * 0.2487) - 1, (screenW * 0.4583) + 1, (screenH * 0.2721) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Izquierda", (screenW * 0.3477) - 1, (screenH * 0.2487) + 1, (screenW * 0.4583) - 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Izquierda", (screenW * 0.3477) + 1, (screenH * 0.2487) + 1, (screenW * 0.4583) + 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Izquierda", screenW * 0.3477, screenH * 0.2487, screenW * 0.4583, screenH * 0.2721, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4963) - 1, (screenH * 0.2396) - 1, (screenW * 0.4963) - 1, screenH * 0.2852, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, (screenH * 0.2396) - 1, (screenW * 0.4963) - 1, (screenH * 0.2396) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4963) - 1, screenH * 0.2852, screenW * 0.6230, screenH * 0.2852, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, screenH * 0.2852, screenW * 0.6230, (screenH * 0.2396) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4963, screenH * 0.2396, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorPuertaDerecha, 38, 254), false)
        dxDrawText("Puerta Derecha", (screenW * 0.5037) - 1, (screenH * 0.2487) - 1, (screenW * 0.6142) - 1, (screenH * 0.2721) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Derecha", (screenW * 0.5037) + 1, (screenH * 0.2487) - 1, (screenW * 0.6142) + 1, (screenH * 0.2721) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Derecha", (screenW * 0.5037) - 1, (screenH * 0.2487) + 1, (screenW * 0.6142) - 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Derecha", (screenW * 0.5037) + 1, (screenH * 0.2487) + 1, (screenW * 0.6142) + 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Derecha", screenW * 0.5037, screenH * 0.2487, screenW * 0.6142, screenH * 0.2721, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3389) - 1, (screenH * 0.3138) - 1, (screenW * 0.3389) - 1, screenH * 0.3594, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, (screenH * 0.3138) - 1, (screenW * 0.3389) - 1, (screenH * 0.3138) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3389) - 1, screenH * 0.3594, screenW * 0.4656, screenH * 0.3594, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, screenH * 0.3594, screenW * 0.4656, (screenH * 0.3138) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3389, screenH * 0.3138, screenW * 0.1266, screenH * 0.0456, tocolor(45, ColorPuertaTraseraDerecha, 38, 254), false)
        dxDrawText("Puerta Trasera(De)", (screenW * 0.3477) - 1, (screenH * 0.3229) - 1, (screenW * 0.4583) - 1, (screenH * 0.3464) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(De)", (screenW * 0.3477) + 1, (screenH * 0.3229) - 1, (screenW * 0.4583) + 1, (screenH * 0.3464) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(De)", (screenW * 0.3477) - 1, (screenH * 0.3229) + 1, (screenW * 0.4583) - 1, (screenH * 0.3464) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(De)", (screenW * 0.3477) + 1, (screenH * 0.3229) + 1, (screenW * 0.4583) + 1, (screenH * 0.3464) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(De)", screenW * 0.3477, screenH * 0.3229, screenW * 0.4583, screenH * 0.3464, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Reparaciones (Click para reparar)", (screenW * 0.4056) - 1, (screenH * 0.1953) - 1, (screenW * 0.5688) - 1, (screenH * 0.2253) - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Reparaciones (Click para reparar)", (screenW * 0.4056) + 1, (screenH * 0.1953) - 1, (screenW * 0.5688) + 1, (screenH * 0.2253) - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Reparaciones (Click para reparar)", (screenW * 0.4056) - 1, (screenH * 0.1953) + 1, (screenW * 0.5688) - 1, (screenH * 0.2253) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Reparaciones (Click para reparar)", (screenW * 0.4056) + 1, (screenH * 0.1953) + 1, (screenW * 0.5688) + 1, (screenH * 0.2253) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Reparaciones (Click para reparar)", screenW * 0.4056, screenH * 0.1953, screenW * 0.5688, screenH * 0.2253, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4963) - 1, (screenH * 0.3138) - 1, (screenW * 0.4963) - 1, screenH * 0.3594, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, (screenH * 0.3138) - 1, (screenW * 0.4963) - 1, (screenH * 0.3138) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4963) - 1, screenH * 0.3594, screenW * 0.6230, screenH * 0.3594, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, screenH * 0.3594, screenW * 0.6230, (screenH * 0.3138) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4963, screenH * 0.3138, screenW * 0.1266, screenH * 0.0456, tocolor(45, ColorPuertaTraseraIzquierda, 38, 254), false)
        dxDrawText("Puerta Trasera(Iz)", (screenW * 0.5037) - 1, (screenH * 0.3229) - 1, (screenW * 0.6142) - 1, (screenH * 0.3464) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(Iz)", (screenW * 0.5037) + 1, (screenH * 0.3229) - 1, (screenW * 0.6142) + 1, (screenH * 0.3464) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(Iz)", (screenW * 0.5037) - 1, (screenH * 0.3229) + 1, (screenW * 0.6142) - 1, (screenH * 0.3464) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(Iz)", (screenW * 0.5037) + 1, (screenH * 0.3229) + 1, (screenW * 0.6142) + 1, (screenH * 0.3464) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Puerta Trasera(Iz)", screenW * 0.5037, screenH * 0.3229, screenW * 0.6142, screenH * 0.3464, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3389) - 1, (screenH * 0.3724) - 1, (screenW * 0.3389) - 1, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, (screenH * 0.3724) - 1, (screenW * 0.3389) - 1, (screenH * 0.3724) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3389) - 1, screenH * 0.4180, screenW * 0.4656, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, screenH * 0.4180, screenW * 0.4656, (screenH * 0.3724) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3389, screenH * 0.3724, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorMaletero, 38, 254), false)
        dxDrawLine((screenW * 0.4963) - 1, (screenH * 0.3724) - 1, (screenW * 0.4963) - 1, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, (screenH * 0.3724) - 1, (screenW * 0.4963) - 1, (screenH * 0.3724) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4963) - 1, screenH * 0.4180, screenW * 0.6230, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, screenH * 0.4180, screenW * 0.6230, (screenH * 0.3724) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4963, screenH * 0.3724, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorCapot, 38, 254), false)
        dxDrawLine((screenW * 0.3389) - 1, (screenH * 0.4310) - 1, (screenW * 0.3389) - 1, screenH * 0.4766, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, (screenH * 0.4310) - 1, (screenW * 0.3389) - 1, (screenH * 0.4310) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3389) - 1, screenH * 0.4766, screenW * 0.4656, screenH * 0.4766, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, screenH * 0.4766, screenW * 0.4656, (screenH * 0.4310) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3389, screenH * 0.4310, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorLuces, 38, 254), false)
        dxDrawLine((screenW * 0.4963) - 1, (screenH * 0.4310) - 1, (screenW * 0.4963) - 1, screenH * 0.4766, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, (screenH * 0.4310) - 1, (screenW * 0.4963) - 1, (screenH * 0.4310) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4963) - 1, screenH * 0.4766, screenW * 0.6230, screenH * 0.4766, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, screenH * 0.4766, screenW * 0.6230, (screenH * 0.4310) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4963, screenH * 0.4310, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorParachoquesDelantero, 39, 254), false)
        dxDrawLine((screenW * 0.3389) - 1, (screenH * 0.4896) - 1, (screenW * 0.3389) - 1, screenH * 0.5352, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, (screenH * 0.4896) - 1, (screenW * 0.3389) - 1, (screenH * 0.4896) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3389) - 1, screenH * 0.5352, screenW * 0.4656, screenH * 0.5352, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4656, screenH * 0.5352, screenW * 0.4656, (screenH * 0.4896) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3389, screenH * 0.4896, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorParachoqueTrasero, 38, 254), false)
        dxDrawText("Maletero", (screenW * 0.3463) - 1, (screenH * 0.3854) - 1, (screenW * 0.4568) - 1, (screenH * 0.4089) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Maletero", (screenW * 0.3463) + 1, (screenH * 0.3854) - 1, (screenW * 0.4568) + 1, (screenH * 0.4089) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Maletero", (screenW * 0.3463) - 1, (screenH * 0.3854) + 1, (screenW * 0.4568) - 1, (screenH * 0.4089) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Maletero", (screenW * 0.3463) + 1, (screenH * 0.3854) + 1, (screenW * 0.4568) + 1, (screenH * 0.4089) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Maletero", screenW * 0.3463, screenH * 0.3854, screenW * 0.4568, screenH * 0.4089, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Capot", (screenW * 0.5037) - 1, (screenH * 0.3854) - 1, (screenW * 0.6142) - 1, (screenH * 0.4089) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Capot", (screenW * 0.5037) + 1, (screenH * 0.3854) - 1, (screenW * 0.6142) + 1, (screenH * 0.4089) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Capot", (screenW * 0.5037) - 1, (screenH * 0.3854) + 1, (screenW * 0.6142) - 1, (screenH * 0.4089) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Capot", (screenW * 0.5037) + 1, (screenH * 0.3854) + 1, (screenW * 0.6142) + 1, (screenH * 0.4089) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Capot", screenW * 0.5037, screenH * 0.3854, screenW * 0.6142, screenH * 0.4089, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Luces", (screenW * 0.3463) - 1, (screenH * 0.4401) - 1, (screenW * 0.4568) - 1, (screenH * 0.4635) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Luces", (screenW * 0.3463) + 1, (screenH * 0.4401) - 1, (screenW * 0.4568) + 1, (screenH * 0.4635) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Luces", (screenW * 0.3463) - 1, (screenH * 0.4401) + 1, (screenW * 0.4568) - 1, (screenH * 0.4635) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Luces", (screenW * 0.3463) + 1, (screenH * 0.4401) + 1, (screenW * 0.4568) + 1, (screenH * 0.4635) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Luces", screenW * 0.3463, screenH * 0.4401, screenW * 0.4568, screenH * 0.4635, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (De)", (screenW * 0.5051) - 1, (screenH * 0.4401) - 1, (screenW * 0.6157) - 1, (screenH * 0.4635) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (De)", (screenW * 0.5051) + 1, (screenH * 0.4401) - 1, (screenW * 0.6157) + 1, (screenH * 0.4635) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (De)", (screenW * 0.5051) - 1, (screenH * 0.4401) + 1, (screenW * 0.6157) - 1, (screenH * 0.4635) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (De)", (screenW * 0.5051) + 1, (screenH * 0.4401) + 1, (screenW * 0.6157) + 1, (screenH * 0.4635) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (De)", screenW * 0.5051, screenH * 0.4401, screenW * 0.6157, screenH * 0.4635, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (Tra)", (screenW * 0.3463) - 1, (screenH * 0.4987) - 1, (screenW * 0.4568) - 1, (screenH * 0.5221) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (Tra)", (screenW * 0.3463) + 1, (screenH * 0.4987) - 1, (screenW * 0.4568) + 1, (screenH * 0.5221) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (Tra)", (screenW * 0.3463) - 1, (screenH * 0.4987) + 1, (screenW * 0.4568) - 1, (screenH * 0.5221) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (Tra)", (screenW * 0.3463) + 1, (screenH * 0.4987) + 1, (screenW * 0.4568) + 1, (screenH * 0.5221) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parachoques (Tra)", screenW * 0.3463, screenH * 0.4987, screenW * 0.4568, screenH * 0.5221, tocolor(217, 0, 0, 254), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine(screenW * 0.3228, screenH * 0.5625, screenW * 0.6515, screenH * 0.5625, tocolor(255, 255, 255, 255), 2, false)
        dxDrawText("Faseos/Tunnings", (screenW * 0.3990) - 1, (screenH * 0.5755) - 1, (screenW * 0.5622) - 1, (screenH * 0.6055) - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Faseos/Tunnings", (screenW * 0.3990) + 1, (screenH * 0.5755) - 1, (screenW * 0.5622) + 1, (screenH * 0.6055) - 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Faseos/Tunnings", (screenW * 0.3990) - 1, (screenH * 0.5755) + 1, (screenW * 0.5622) - 1, (screenH * 0.6055) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Faseos/Tunnings", (screenW * 0.3990) + 1, (screenH * 0.5755) + 1, (screenW * 0.5622) + 1, (screenH * 0.6055) + 1, tocolor(0, 0, 0, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Faseos/Tunnings", screenW * 0.3990, screenH * 0.5755, screenW * 0.5622, screenH * 0.6055, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3463) - 1, (screenH * 0.6354) - 1, (screenW * 0.3463) - 1, screenH * 0.6810, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4729, (screenH * 0.6354) - 1, (screenW * 0.3463) - 1, (screenH * 0.6354) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3463) - 1, screenH * 0.6810, screenW * 0.4729, screenH * 0.6810, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4729, screenH * 0.6810, screenW * 0.4729, (screenH * 0.6354) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3463, screenH * 0.6354, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorSuspension, 38, 254), false)
        -- dxDrawLine((screenW * 0.4890) - 1, (screenH * 0.6354) - 1, (screenW * 0.4890) - 1, screenH * 0.6810, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine(screenW * 0.6157, (screenH * 0.6354) - 1, (screenW * 0.4890) - 1, (screenH * 0.6354) - 1, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine((screenW * 0.4890) - 1, screenH * 0.6810, screenW * 0.6157, screenH * 0.6810, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine(screenW * 0.6157, screenH * 0.6810, screenW * 0.6157, (screenH * 0.6354) - 1, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawRectangle(screenW * 0.4890, screenH * 0.6354, screenW * 0.1266, screenH * 0.0456, tocolor(45, ColorFrenos, 38, 254), false)
        dxDrawLine((screenW * 0.3463) - 1, (screenH * 0.6966) - 1, (screenW * 0.3463) - 1, screenH * 0.7422, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4729, (screenH * 0.6966) - 1, (screenW * 0.3463) - 1, (screenH * 0.6966) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3463) - 1, screenH * 0.7422, screenW * 0.4729, screenH * 0.7422, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4729, screenH * 0.7422, screenW * 0.4729, (screenH * 0.6966) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3463, screenH * 0.6966, screenW * 0.1266, screenH * 0.0456, tocolor(45, ColorRuedas, 38, 254), false)
        -- dxDrawLine((screenW * 0.4890) - 1, (screenH * 0.6966) - 1, (screenW * 0.4890) - 1, screenH * 0.7422, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine(screenW * 0.6157, (screenH * 0.6966) - 1, (screenW * 0.4890) - 1, (screenH * 0.6966) - 1, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine((screenW * 0.4890) - 1, screenH * 0.7422, screenW * 0.6157, screenH * 0.7422, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine(screenW * 0.6157, screenH * 0.7422, screenW * 0.6157, (screenH * 0.6966) - 1, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawRectangle(screenW * 0.4890, screenH * 0.6966, screenW * 0.1266, screenH * 0.0456, tocolor(45, ColorTransmision, 38, 254), false)
        -- dxDrawLine((screenW * 0.3463) - 1, (screenH * 0.7552) - 1, (screenW * 0.3463) - 1, screenH * 0.8008, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine(screenW * 0.4729, (screenH * 0.7552) - 1, (screenW * 0.3463) - 1, (screenH * 0.7552) - 1, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine((screenW * 0.3463) - 1, screenH * 0.8008, screenW * 0.4729, screenH * 0.8008, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawLine(screenW * 0.4729, screenH * 0.8008, screenW * 0.4729, (screenH * 0.7552) - 1, tocolor(0, 0, 0, 255), 1, false)
        -- dxDrawRectangle(screenW * 0.3463, screenH * 0.7552, screenW * 0.1266, screenH * 0.0456, tocolor(45, ColorTurbo, 38, 254), false)
       -- dxDrawLine((screenW * 0.4890) - 1, (screenH * 0.7552) - 1, (screenW * 0.4890) - 1, screenH * 0.8008, tocolor(0, 0, 0, 255), 1, false)
       -- dxDrawLine(screenW * 0.6157, (screenH * 0.7552) - 1, (screenW * 0.4890) - 1, (screenH * 0.7552) - 1, tocolor(0, 0, 0, 255), 1, false)
       -- dxDrawLine((screenW * 0.4890) - 1, screenH * 0.8008, screenW * 0.6157, screenH * 0.8008, tocolor(0, 0, 0, 255), 1, false)
      --  dxDrawLine(screenW * 0.6157, screenH * 0.8008, screenW * 0.6157, (screenH * 0.7552) - 1, tocolor(0, 0, 0, 255), 1, false)
      --  dxDrawRectangle(screenW * 0.4890, screenH * 0.7552, screenW * 0.1266, screenH * 0.0456, tocolor(45, 39, 39, 254), false)
        dxDrawLine((screenW * 0.4180) - 1, (screenH * 0.8138) - 1, (screenW * 0.4180) - 1, screenH * 0.8594, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.5447, (screenH * 0.8138) - 1, (screenW * 0.4180) - 1, (screenH * 0.8138) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4180) - 1, screenH * 0.8594, screenW * 0.5447, screenH * 0.8594, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.5447, screenH * 0.8594, screenW * 0.5447, (screenH * 0.8138) - 1, tocolor(0, 0, 0, 255), 1, false)
		
        dxDrawRectangle(screenW * 0.4180, screenH * 0.8138, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorCerrado, 38, 254), false)
        dxDrawText("Cerrar", (screenW * 0.4268) - 1, (screenH * 0.8229) - 1, (screenW * 0.5373) - 1, (screenH * 0.8464) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", (screenW * 0.4268) + 1, (screenH * 0.8229) - 1, (screenW * 0.5373) + 1, (screenH * 0.8464) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", (screenW * 0.4268) - 1, (screenH * 0.8229) + 1, (screenW * 0.5373) - 1, (screenH * 0.8464) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", (screenW * 0.4268) + 1, (screenH * 0.8229) + 1, (screenW * 0.5373) + 1, (screenH * 0.8464) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", screenW * 0.4268, screenH * 0.8229, screenW * 0.5373, screenH * 0.8464, tocolor(228, 0, 0, 254), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Suspension", (screenW * 0.3551) - 1, (screenH * 0.6445) - 1, (screenW * 0.4656) - 1, (screenH * 0.6680) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Suspension", (screenW * 0.3551) + 1, (screenH * 0.6445) - 1, (screenW * 0.4656) + 1, (screenH * 0.6680) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Suspension", (screenW * 0.3551) - 1, (screenH * 0.6445) + 1, (screenW * 0.4656) - 1, (screenH * 0.6680) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Suspension", (screenW * 0.3551) + 1, (screenH * 0.6445) + 1, (screenW * 0.4656) + 1, (screenH * 0.6680) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Suspension", screenW * 0.3551, screenH * 0.6445, screenW * 0.4656, screenH * 0.6680, tocolor(250, 0, 0, 254), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Freno", (screenW * 0.4963) - 1, (screenH * 0.6445) - 1, (screenW * 0.6069) - 1, (screenH * 0.6680) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Freno", (screenW * 0.4963) + 1, (screenH * 0.6445) - 1, (screenW * 0.6069) + 1, (screenH * 0.6680) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Freno", (screenW * 0.4963) - 1, (screenH * 0.6445) + 1, (screenW * 0.6069) - 1, (screenH * 0.6680) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Freno", (screenW * 0.4963) + 1, (screenH * 0.6445) + 1, (screenW * 0.6069) + 1, (screenH * 0.6680) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Freno", screenW * 0.4963, screenH * 0.6445, screenW * 0.6069, screenH * 0.6680, tocolor(251, 0, 0, 254), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Transmision", (screenW * 0.4963) - 1, (screenH * 0.7057) - 1, (screenW * 0.6069) - 1, (screenH * 0.7292) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Transmision", (screenW * 0.4963) + 1, (screenH * 0.7057) - 1, (screenW * 0.6069) + 1, (screenH * 0.7292) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Transmision", (screenW * 0.4963) - 1, (screenH * 0.7057) + 1, (screenW * 0.6069) - 1, (screenH * 0.7292) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Transmision", (screenW * 0.4963) + 1, (screenH * 0.7057) + 1, (screenW * 0.6069) + 1, (screenH * 0.7292) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Transmision", screenW * 0.4963, screenH * 0.7057, screenW * 0.6069, screenH * 0.7292, tocolor(251, 0, 0, 254), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Turbo", (screenW * 0.3551) - 1, (screenH * 0.7643) - 1, (screenW * 0.4656) - 1, (screenH * 0.7878) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Turbo", (screenW * 0.3551) + 1, (screenH * 0.7643) - 1, (screenW * 0.4656) + 1, (screenH * 0.7878) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Turbo", (screenW * 0.3551) - 1, (screenH * 0.7643) + 1, (screenW * 0.4656) - 1, (screenH * 0.7878) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Turbo", (screenW * 0.3551) + 1, (screenH * 0.7643) + 1, (screenW * 0.4656) + 1, (screenH * 0.7878) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        -- dxDrawText("Turbo", screenW * 0.3551, screenH * 0.7643, screenW * 0.4656, screenH * 0.7878, tocolor(251, 0, 0, 254), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.3551) - 1, (screenH * 0.7057) - 1, (screenW * 0.4656) - 1, (screenH * 0.7292) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.3551) + 1, (screenH * 0.7057) - 1, (screenW * 0.4656) + 1, (screenH * 0.7292) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.3551) - 1, (screenH * 0.7057) + 1, (screenW * 0.4656) - 1, (screenH * 0.7292) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.3551) + 1, (screenH * 0.7057) + 1, (screenW * 0.4656) + 1, (screenH * 0.7292) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", screenW * 0.3551, screenH * 0.7057, screenW * 0.4656, screenH * 0.7292, tocolor(251, 0, 0, 254), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4963) - 1, (screenH * 0.4896) - 1, (screenW * 0.4963) - 1, screenH * 0.5352, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, (screenH * 0.4896) - 1, (screenW * 0.4963) - 1, (screenH * 0.4896) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4963) - 1, screenH * 0.5352, screenW * 0.6230, screenH * 0.5352, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6230, screenH * 0.5352, screenW * 0.6230, (screenH * 0.4896) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4963, screenH * 0.4896, screenW * 0.1266, screenH * 0.0456, tocolor(45, colorParabrisas, 38, 254), false)
        dxDrawText("Parabrisas", (screenW * 0.5037) - 1, (screenH * 0.4987) - 1, (screenW * 0.6142) - 1, (screenH * 0.5221) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parabrisas", (screenW * 0.5037) + 1, (screenH * 0.4987) - 1, (screenW * 0.6142) + 1, (screenH * 0.5221) - 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parabrisas", (screenW * 0.5037) - 1, (screenH * 0.4987) + 1, (screenW * 0.6142) - 1, (screenH * 0.5221) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parabrisas", (screenW * 0.5037) + 1, (screenH * 0.4987) + 1, (screenW * 0.6142) + 1, (screenH * 0.5221) + 1, tocolor(0, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Parabrisas", screenW * 0.5037, screenH * 0.4987, screenW * 0.6142, screenH * 0.5221, tocolor(217, 0, 0, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
  



   end
   

function  abrir( ... )
addEventHandler("onClientRender",root,tucanoesmarica)
showCursor(true)
botones()
end
addEvent("open",true)
addEventHandler("open",getLocalPlayer(),abrir)



function  botones( ... )
    botoncerrar = guiCreateButton(screenW * 0.4180, screenH * 0.8138, screenW * 0.1266, screenH * 0.0456,"",false)
    puertaizquierda = guiCreateButton(screenW * 0.3389, screenH * 0.2396, screenW * 0.1266, screenH * 0.0456,"",false)
    puertaderecha = guiCreateButton (screenW * 0.4963, screenH * 0.2396, screenW * 0.1266, screenH * 0.0456,"",false)
    puertatraseraderecha = guiCreateButton(screenW * 0.3389, screenH * 0.3138, screenW * 0.1266, screenH * 0.0456,"",false)
    puertatraseraizquierda = guiCreateButton(screenW * 0.4963, screenH * 0.3138, screenW * 0.1266, screenH * 0.0456,"",false)
    maletero = guiCreateButton(screenW * 0.3389, screenH * 0.3724, screenW * 0.1266, screenH * 0.0456,"",false)
    capot = guiCreateButton(screenW * 0.4963, screenH * 0.3724, screenW * 0.1266, screenH * 0.0456,"",false)
    luces = guiCreateButton(screenW * 0.3389, screenH * 0.4310, screenW * 0.1266, screenH * 0.0456,"",false)
    parachoqueDe = guiCreateButton(screenW * 0.4963, screenH * 0.4310, screenW * 0.1266, screenH * 0.0456,"",false)
	parachoqueTrasero = guiCreateButton(screenW * 0.3389, screenH * 0.4896, screenW * 0.1266, screenH * 0.0456,"",false)
	parabrisas = guiCreateButton(screenW * 0.4963, screenH * 0.4896, screenW * 0.1266, screenH * 0.0456,"",false)
	--if exports.facciones:getPlayerFactionRights(localPlayer, 2, 7) then
	suspension = guiCreateButton(screenW * 0.3463, screenH * 0.6354, screenW * 0.1266, screenH * 0.0456,"",false)
	-- frenos = guiCreateButton(screenW * 0.4890, screenH * 0.6354, screenW * 0.1266, screenH * 0.0456,"",false)
	ruedas = guiCreateButton(screenW * 0.3463, screenH * 0.6966, screenW * 0.1266, screenH * 0.0456,"",false)
    -- transmisionxd = guiCreateButton(screenW * 0.4890, screenH * 0.6966, screenW * 0.1266, screenH * 0.0456,"",false) 
    -- turbo = guiCreateButton(screenW * 0.3463, screenH * 0.7552, screenW * 0.1266, screenH * 0.0456,"",false)
    -- guiSetAlpha(turbo,0)
    -- guiSetAlpha(transmisionxd,0)
	guiSetAlpha(ruedas,0)
	-- guiSetAlpha(frenos,0)
	guiSetAlpha(suspension,0)
	--end
	guiSetAlpha(parabrisas,0)
	guiSetAlpha(parachoqueTrasero,0)
    guiSetAlpha(parachoqueDe,0)
    guiSetAlpha(luces,0)
    guiSetAlpha(maletero,0)
    guiSetAlpha(capot,0)
    guiSetAlpha(puertatraseraizquierda,0)
    guiSetAlpha(botoncerrar,0)
    guiSetAlpha(puertatraseraderecha,0)
    guiSetAlpha(puertaderecha,0)
    guiSetAlpha(puertaizquierda,0)
	 	 

end

addEventHandler( "onClientMouseEnter", root, 
    function() 
	if source == botoncerrar then colorCerrado = 140
    elseif source == puertaizquierda then colorPuertaIzquierda = 140
    elseif source == puertaderecha then colorPuertaDerecha = 140
    elseif source == puertatraseraderecha then ColorPuertaTraseraDerecha = 140
    elseif source == puertatraseraizquierda then ColorPuertaTraseraIzquierda = 140
    elseif source == maletero then colorMaletero = 140
    elseif source == capot then colorCapot = 140
    elseif source == luces then colorLuces = 140
    elseif source == parachoqueDe then colorParachoquesDelantero = 140
	elseif source == parachoqueTrasero then colorParachoqueTrasero = 140
	elseif source == parabrisas then colorParabrisas = 140
	elseif source == suspension then colorSuspension = 140
	elseif source == frenos then ColorFrenos = 140
	elseif source == ruedas then ColorRuedas = 140
    elseif source == transmisionxd then ColorTransmision = 140 
    elseif source == turbo then ColorTurbo = 140
    elseif source == pintar then colorPintar = 140
    elseif source == cambiarRuedas then colorCambioR = 140
    elseif source == pegatinas then colorPegatinas = 140
    elseif source == tunnin then colorTunnings = 140
    elseif source == cerrarTunning then colorCerrarTunnings = 140
	end
	end
)


addEventHandler( "onClientMouseLeave", root, 
    function()
	if source == botoncerrar then colorCerrado = 38
	 elseif source == puertaizquierda then colorPuertaIzquierda = 38
    elseif source == puertaderecha then colorPuertaDerecha = 38
    elseif source == puertatraseraderecha then ColorPuertaTraseraDerecha = 38
    elseif source == puertatraseraizquierda then ColorPuertaTraseraIzquierda = 38
    elseif source == maletero then colorMaletero = 38
    elseif source == capot then colorCapot = 38
    elseif source == luces then colorLuces = 38
    elseif source == parachoqueDe then colorParachoquesDelantero = 38
	elseif source == parachoqueTrasero then colorParachoqueTrasero = 38
	elseif source == parabrisas then colorParabrisas = 38
	elseif source == suspension then colorSuspension = 38
	elseif source == frenos then ColorFrenos  = 38
	elseif source == ruedas then ColorRuedas = 38
    elseif source == transmisionxd then ColorTransmision = 38 
    elseif source == turbo then ColorTurbo = 38
    elseif source == pintar then colorPintar = 71
    elseif source == cambiarRuedas then colorCambioR = 71
    elseif source == pegatinas then colorPegatinas = 71
    elseif source == tunnin then colorTunnings = 71
    elseif source == cerrarTunning then colorCerrarTunnings = 71
	end
	end
)




function  clicks( ... )
    if source  == botoncerrar then
 cerrarPANEL()
    guiSetVisible(botoncerrar,false)
    showCursor(false)
elseif  source   == puertaizquierda then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado la puerta izquierda",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
    setVehicleDoorState(vehiculo,2,0)
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == puertaderecha then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado la puerta derecha",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
    setVehicleDoorState(vehiculo,3,0)
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == puertatraseraderecha then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado la puerta trasera derecha",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
    setVehicleDoorState(vehiculo,5,0)
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == puertatraseraizquierda then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado la puerta trasera izquierda",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
    setVehicleDoorState(vehiculo,4,0)
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == maletero then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado el maletero",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
    setVehicleDoorState(vehiculo,1,0)
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == capot then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado el capot",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
    setVehicleDoorState(vehiculo,0,0)
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == luces then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado las luces",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
    setVehicleLightState(vehiculo,0,0)
     setVehicleLightState(vehiculo,1,0)
 else

outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == parachoqueDe then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado el parachoques delantero",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
	 setVehiclePanelState ( vehiculo, 5, 0 )
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == parachoqueTrasero then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado el parachoques trasero",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
	 setVehiclePanelState ( vehiculo, 6, 0 )
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == parabrisas then
if isPedInVehicle(localPlayer) then
    outputChatBox("Se ha reparado el parabrisas",255,0,0)
    local vehiculo = getPedOccupiedVehicle(localPlayer)
	 setVehiclePanelState ( vehiculo, 4, 0 )
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == suspension then
if isPedInVehicle(localPlayer) then
cerrarPANEL()
guiSetVisible(asd,true)
showCursor(true)
else
outputChatBox("No estas en vehiculo porfavor sube a uno",0,255,0)
end
elseif source == botonCerrarSuspension then
guiSetVisible(asd,false)
showCursor(false)
elseif source == botonConfirmar then
local cantidad = guiGetText(labelCantidad)
triggerServerEvent("cambiarSuspension",localPlayer,cantidad)
elseif source == botonRestaurar then
triggerServerEvent("restaurarSuspension",localPlayer)
elseif source == frenos then
guiSetVisible(frenosp,true)
showCursor(true)
cerrarPANEL()
elseif source == botonCerrarFrenos then
guiSetVisible(frenosp,false)
showCursor(false)
cerrarPANEL()
elseif source == botonConfirmarFrenos then
local cantidad = guiGetText(editFrenos)
        if tonumber(cantidad) > 15 or tonumber(cantidad) < 5 then
        outputChatBox("La cantidad debe ir entre el valor 5 y el 15",200,0,0)
        else    
        triggerServerEvent("cambiarFrenos",localPlayer,cantidad)
        end
elseif source == ruedas then
cerrarPANEL()
botones2()
addEventHandler("onClientRender",root,tunnings)
elseif source == botonCerrarRuedas then 
guiSetVisible(ruedasp,false)
showCursor(false)
elseif source == transmisionxd then
cerrarPANEL()
guiSetVisible(transmisionP,true) 
showCursor(true)
elseif source == botonConfirmarTransmision then
local cantidad = guiGetText(editTransmision)
triggerServerEvent("faseoTransmision",localPlayer,cantidad)   
elseif source == botonCerrarTransmision then
guiSetVisible(transmisionP,false)
showCursor(false)
elseif source == turbo then
cerrarPANEL()
guiSetVisible(turbop,true)
showCursor(true)
elseif source == botonCerrarxd then
cerrarPANEL()
guiSetVisible(turbop,false)
showCursor(false)
elseif source == botonInstalarTurbo then
triggerServerEvent("faseoTurbo",localPlayer)
elseif source == botonDesinstalarTurbo then
triggerServerEvent("quitarTurbo",localPlayer)
elseif source == botonRestaurarFrenos then
triggerServerEvent("restaurarFrenos",localPlayer)
elseif source == botonRestaurarTransmision then
triggerServerEvent("restaurarTransmision",localPlayer)
elseif source == cerrarTunning then
cerrarTunnin()
cerrarPANEL()
elseif source == pintar then
cerrarTunnin()
cerrarPANEL()
showCursor(true)
setcolorsetcolor()
elseif source == cambiarRuedas then
cerrarTunnin()
cerrarPANEL()
showCursor(true)
ruedasx()
elseif source == pegatinas then
cerrarTunnin()
cerrarPANEL()
pegatina()
showCursor(true)
elseif source == tunnin then
cerrarTunnin()
cerrarPANEL()
showCursor(true)
guiSetVisible(tunning0,true)
end
end

local alerones = {
{"Spoiler 1", 1000},
{"Spoiler 2", 1001 },
{"Spoiler 3", 1002 },
{"Spoiler 4", 1003 },
{"Spoiler 5", 1014},
{"Spoiler 6", 1015 },
{"Spoiler 7", 1016 },
{"Spoiler 8", 1049 },
{"Spoiler 9", 1050 },
{"Spoiler 10", 1023 }
}

 local escapesT = {
{"Escape 1", 1018},
{"Escape 2", 1019 },
{"Escape 3", 1020 },
{"Escape 4", 1021 },
{"Escape 5", 1022},
{"Escape 6", 1028 },
{"Escape 7", 1029 },
{"Escape 8", 1043 },
{"Escape 9", 1044 },
{"Escape 11", 1045 },
{"Escape 12", 1046 }
}
    
    
     local faldonesT = {
{"Faldon 1", 1007},
{"Faldon 2", 1017 },
{"Faldon 3", 1026 },
{"Faldon 4", 1027 },
{"Faldon 5", 1036},
{"Faldon 6", 1037 },
{"Faldon 7", 1042 },
{"Faldon 8", 1047 },
{"Faldon 9", 1048 }
}

     local aireTomas = {
{"T.Aires 1", 1004},
{"T.Aires 2", 1005 },
{"T.Aires 3", 1011 },
{"T.Aires 4", 1012 },
{"T.Aires 5", 1032},
{"T.Aires 6", 1033 },
{"T.Aires 7", 1053 },
{"T.Aires 8", 1054 },
{"T.Aires 9", 1091 }
}

     local bomperDelantero = {
{"Bomper 1", 1117},
{"Bomper 2", 1152 },
{"Bomper 3", 1153 },
{"Bomper 4", 1155 },
{"Bomper 5", 1157},
{"Bomper 6", 1160 },
{"Bomper 7", 1165 },
{"Bomper 8", 1166 },
{"Bomper 9", 1169 },
{"Bomper 10", 1170 },
{"Bomper 11", 1171},
{"Bomper 12", 1172}
}

 local bomperTrasero = {
{"Bomper T. 1", 1140},
{"Bomper T. 2", 1141 },
{"Bomper T. 3", 1148 },
{"Bomper T. 4", 1149 },
{"Bomper T. 5", 1150},
{"Bomper T. 6", 1151 },
{"Bomper T. 7", 1154 },
{"Bomper T. 8", 1156 },
{"Bomper T. 9", 1159 },
{"Bomper T. 10", 1161},
{"Bomper T. 11", 1167},
{"Bomper T. 12", 1168}
}
    




    

        tunning0 = guiCreateWindow(0.28, 0.02, 0.40, 0.94, "Mejoras", true)
        
guiWindowSetSizable(tunning0, false)
        guiSetVisible(tunning0,false)
    

        spoiler = guiCreateButton(0.09, 0.27, 0.21, 0.04, "Colocar Alerones", true, tunning0)
        guiSetProperty(spoiler, "NormalTextColour", "FFAAAAAA")
        escapes = guiCreateButton(0.65, 0.26, 0.26, 0.03, "Colocar Escapes", true, tunning0)
        guiSetProperty(escapes, "NormalTextColour", "FFAAAAAA")
        faldones = guiCreateButton(0.08, 0.53, 0.23, 0.05, "Colocar Faldones", true, tunning0)
        guiSetProperty(faldones, "NormalTextColour", "FFAAAAAA")
        tomasaire = guiCreateButton(0.03, 0.79, 0.35, 0.03, "Colocar Tomas de Aire", true, tunning0)
        guiSetProperty(tomasaire, "NormalTextColour", "FFAAAAAA")
        frontal = guiCreateButton(0.65, 0.54, 0.28, 0.04, "Colocar Paragolpes Frontal", true, tunning0)
        guiSetProperty(frontal, "NormalTextColour", "FFAAAAAA")
        trasero = guiCreateButton(0.62, 0.79, 0.34, 0.04, "Colocar Paragolpes Trasero", true, tunning0)
        guiSetProperty(trasero, "NormalTextColour", "FFAAAAAA")
        salirTun = guiCreateButton(0.08, 0.87, 0.17, 0.06, "Cerrar", true, tunning0)
        guiSetProperty(salirTun, "NormalTextColour", "FFAAAAAA")
        GridAlerones = guiCreateGridList(0.05, 0.07, 0.31, 0.19, true, tunning0)
        guiGridListAddColumn(GridAlerones, "Alerones", 0.5)
        guiGridListAddColumn(GridAlerones, "ID", 0.5)
        GridFaldones = guiCreateGridList(0.05, 0.32, 0.31, 0.19, true, tunning0)
        guiGridListAddColumn(GridFaldones, "Faldones", 0.5)
        guiGridListAddColumn(GridFaldones, "ID", 0.5)
        GridEscapes = guiCreateGridList(0.62, 0.07, 0.31, 0.19, true, tunning0)
        guiGridListAddColumn(GridEscapes, "Escapes", 0.5)
        guiGridListAddColumn(GridEscapes, "ID", 0.5)
        GridParaFrontal = guiCreateGridList(0.64, 0.33, 0.31, 0.19, true, tunning0)
        guiGridListAddColumn(GridParaFrontal, "Paragolpes", 0.5)
        guiGridListAddColumn(GridParaFrontal, "ID", 0.5)
        GridTomasAire = guiCreateGridList(0.05, 0.59, 0.31, 0.19, true, tunning0)
        guiGridListAddColumn(GridTomasAire, "Aires T", 0.5)
        guiGridListAddColumn(GridTomasAire, "ID", 0.5)
        GridParaTrasero = guiCreateGridList(0.64, 0.60, 0.31, 0.19, true, tunning0)
        guiGridListAddColumn(GridParaTrasero, "Paragolpes T. ", 0.5)
        guiGridListAddColumn(GridParaTrasero, "ID", 0.5)
        eliminarAleron = guiCreateButton(0.32, 0.27, 0.10, 0.04, "X", true, tunning0)
        guiSetProperty(eliminarAleron, "NormalTextColour", "FFAAAAAA")
        eliminarFaldon = guiCreateButton(0.33, 0.53, 0.10, 0.04, "X", true, tunning0)
        guiSetProperty(eliminarFaldon, "NormalTextColour", "FFAAAAAA")
        eliminarAire = guiCreateButton(0.40, 0.79, 0.10, 0.04, "X", true, tunning0)
        guiSetProperty(eliminarAire, "NormalTextColour", "FFAAAAAA")
        eliminarParaTrasero = guiCreateButton(0.76, 0.84, 0.10, 0.04, "X", true, tunning0)
        guiSetProperty(eliminarParaTrasero, "NormalTextColour", "FFAAAAAA")
        eliminarParaFrontal = guiCreateButton(0.54, 0.54, 0.10, 0.04, "X", true, tunning0)
        guiSetProperty(eliminarParaFrontal, "NormalTextColour", "FFAAAAAA")
        eliminarEscapes = guiCreateButton(0.54, 0.28, 0.10, 0.04, "X", true, tunning0)
        guiSetProperty(eliminarEscapes, "NormalTextColour", "FFAAAAAA")    
 

 

    for i, v in ipairs(alerones) do
  local row = guiGridListAddRow(GridAlerones)
  guiGridListSetItemText(GridAlerones, row, 1, tostring(v[1]), false, true)
  guiGridListSetItemText(GridAlerones, row, 2, tostring(v[2]), false, true)
end

for i, v in ipairs(escapesT) do
  local row = guiGridListAddRow(GridEscapes)
  guiGridListSetItemText(GridEscapes, row, 1, tostring(v[1]), false, true)
  guiGridListSetItemText(GridEscapes, row, 2, tostring(v[2]), false, true)
end


for i, v in ipairs(bomperDelantero) do
  local row = guiGridListAddRow(GridParaFrontal)
  guiGridListSetItemText(GridParaFrontal, row, 1, tostring(v[1]), false, true)
  guiGridListSetItemText(GridParaFrontal, row, 2, tostring(v[2]), false, true)
end


for i, v in ipairs(faldonesT) do
  local row = guiGridListAddRow(GridFaldones)
  guiGridListSetItemText(GridFaldones, row, 1, tostring(v[1]), false, true)
  guiGridListSetItemText(GridFaldones, row, 2, tostring(v[2]), false, true)
end


for i, v in ipairs(aireTomas) do
  local row = guiGridListAddRow(GridTomasAire)
  guiGridListSetItemText(GridTomasAire, row, 1, tostring(v[1]), false, true)
  guiGridListSetItemText(GridTomasAire, row, 2, tostring(v[2]), false, true)
end

for i, v in ipairs(bomperTrasero) do
  local row = guiGridListAddRow(GridParaTrasero)
  guiGridListSetItemText(GridParaTrasero, row, 1, tostring(v[1]), false, true)
  guiGridListSetItemText(GridParaTrasero, row, 2, tostring(v[2]), false, true)
end




function tunningsss()
if source == spoiler then
 local ID = guiGridListGetItemText(GridAlerones, guiGridListGetSelectedItem(GridAlerones), 2)
 triggerServerEvent("ponerMejoras",localPlayer,ID)
 elseif source == salirTun then
 guiSetVisible(tunning0,false)
 showCursor(false)
 elseif source == escapes then
 local ID = guiGridListGetItemText(GridEscapes, guiGridListGetSelectedItem(GridEscapes), 2)
 triggerServerEvent("ponerMejoras",localPlayer,ID)
 elseif source == faldones then
 local ID = guiGridListGetItemText(GridFaldones, guiGridListGetSelectedItem(GridFaldones), 2)
 triggerServerEvent("ponerMejoras",localPlayer,ID)
 elseif source == tomasaire then
  local ID = guiGridListGetItemText(GridTomasAire, guiGridListGetSelectedItem(GridTomasAire), 2)
 triggerServerEvent("ponerMejoras",localPlayer,ID)
 elseif source == frontal then
 local ID = guiGridListGetItemText(GridParaFrontal, guiGridListGetSelectedItem(GridParaFrontal), 2)
 triggerServerEvent("ponerMejoras",localPlayer,ID)
 elseif source == trasero then
 local ID = guiGridListGetItemText(GridParaTrasero, guiGridListGetSelectedItem(GridParaTrasero), 2)
 triggerServerEvent("ponerMejoras",localPlayer,ID)
 elseif source == eliminarAire then
 local ID = guiGridListGetItemText(GridTomasAire, guiGridListGetSelectedItem(GridTomasAire), 2)
 triggerServerEvent("qitala",localPlayer,ID)
 elseif source == eliminarAleron then
local ID = guiGridListGetItemText(GridAlerones, guiGridListGetSelectedItem(GridAlerones), 2)
 triggerServerEvent("qitala",localPlayer,ID)
 elseif source == eliminarEscapes then
 local ID = guiGridListGetItemText(GridEscapes, guiGridListGetSelectedItem(GridEscapes), 2)
 triggerServerEvent("qitala",localPlayer,ID)
 elseif source == eliminarFaldon then 
 local ID = guiGridListGetItemText(GridFaldones, guiGridListGetSelectedItem(GridFaldones), 2)
 triggerServerEvent("qitala",localPlayer,ID)
 elseif source == eliminarParaFrontal then 
 local ID = guiGridListGetItemText(GridParaFrontal, guiGridListGetSelectedItem(GridParaFrontal), 2)
 triggerServerEvent("qitala",localPlayer,ID)
 elseif source == eliminarParaTrasero then
 local ID = guiGridListGetItemText(GridParaTrasero, guiGridListGetSelectedItem(GridParaTrasero), 2)
 triggerServerEvent("qitala",localPlayer,ID)
end
end
addEventHandler("onClientGUIClick",root,tunningsss)
-----------------------
addEventHandler("onClientGUIClick",root,clicks)
function pegatina()
pegtin = guiCreateWindow(452, 230, 291, 349, "Pegatinas", false)
guiWindowSetSizable(pegtin, false)
atras2 = guiCreateButton(56, 262, 185, 64, "Cerrar", false, pegtin)
pnormal = guiCreateButton(72, 25, 152, 47, "Normal", false, pegtin)
pegatina1 = guiCreateButton(72, 82, 152, 47, "Pegatina 1", false, pegtin)
pegatina2 = guiCreateButton(72, 142, 152, 47, "Pegatina 2", false, pegtin)
pegatina3 = guiCreateButton(72, 199, 152, 47, "Pegatina 3", false, pegtin)
addEventHandler("onClientGUIClick", atras2, 
function ( ... )
 guiSetVisible(pegtin,false)
 showCursor(false)
    -- body
end)
addEventHandler("onClientGUIClick", pnormal, normalp)
addEventHandler("onClientGUIClick", pegatina1, pegatin1)
addEventHandler("onClientGUIClick", pegatina2, pegatin2)
addEventHandler("onClientGUIClick", pegatina3, pegatin3)
end

function normalp(modo)
triggerServerEvent("onpegas", localPlayer, localPlayer, 2)
playSoundFrontEnd ( 16 )
end

function pegatin1(modo)
triggerServerEvent("onpegas", localPlayer, localPlayer, 1)
playSoundFrontEnd ( 16 )
end

function pegatin2(modo)
triggerServerEvent("onpegas", localPlayer, localPlayer, 3)
playSoundFrontEnd ( 16 )
end

function pegatin3(modo)
triggerServerEvent("onpegas", localPlayer, localPlayer, 4)
playSoundFrontEnd ( 16 )
end



function ruedasx()
rueds = guiCreateWindow(452, 230, 291, 349, "Ruedas", false)
guiWindowSetSizable(rueds, false)
atras3 = guiCreateButton(56, 262, 185, 64, "Cerrar", false, rueds)
listar = guiCreateGridList(44, 50, 209, 140, false, rueds)
guiGridListAddColumn(listar, "Ruedas", 0.5)
guiGridListAddColumn(listar, "", 0.5)
for i = 1, 9 do
    guiGridListAddRow(listar)
end
guiGridListSetItemText(listar, 0, 1, "Rimshine", false, false)
guiGridListSetItemText(listar, 0, 2, "", false, false)
guiGridListSetItemText(listar, 1, 1, "Classic", false, false)
guiGridListSetItemText(listar, 1, 2, "", false, false)
guiGridListSetItemText(listar, 2, 1, "Twist", false, false)
guiGridListSetItemText(listar, 2, 2, "", false, false)
guiGridListSetItemText(listar, 3, 1, "Shadow", false, false)
guiGridListSetItemText(listar, 3, 2, "", false, false)
guiGridListSetItemText(listar, 4, 1, "Mega", false, false)
guiGridListSetItemText(listar, 4, 2, "", false, false)
guiGridListSetItemText(listar, 5, 1, "Wires", false, false)
guiGridListSetItemText(listar, 5, 2, "", false, false)
guiGridListSetItemText(listar, 6, 1, "Cutter", false, false)
guiGridListSetItemText(listar, 6, 2, "", false, false)
guiGridListSetItemText(listar, 7, 1, "Switch", false, false)
guiGridListSetItemText(listar, 7, 2, "", false, false)
guiGridListSetItemText(listar, 8, 1, "Normales", false, false)
guiGridListSetItemText(listar, 8, 2, "", false, false)
instalar = guiCreateButton(73, 210, 144, 42, "Instalar", false, rueds)
addEventHandler("onClientGUIClick", atras3, 
    function ( ... )
        guiSetVisible(rueds,false)
        showCursor(false)
        -- body
    end)
addEventHandler("onClientGUIClick", instalar, Rueda1)
end





function Rueda1 (button, modo)
    if (guiGridListGetSelectedItem (listar)) == 3 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1073)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 4 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1074)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 0 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1075)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 5 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1076)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 1 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1077)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 2 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1078)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 6 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1079)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 7 then
    triggerServerEvent("larueda", localPlayer, localPlayer, 1080)
    playSoundFrontEnd ( 46 )
    elseif (guiGridListGetSelectedItem (listar)) == 8 then
    theVehicle = getPlayerOccupiedVehicle ( getLocalPlayer() )
    if ( theVehicle ) then
        playSoundFrontEnd ( 46 )
        triggerServerEvent("larueda", localPlayer, localPlayer, 0)
    end
    else
        outputChatBox("Debes seleccionar antes una rueda", localPlayer, 255, 0, 0)
    end
end



function setcolorsetcolor()
setcol = guiCreateWindow(452, 230, 291, 349, "Pintura", false)
guiWindowSetSizable(setcol, false)
capa1 = guiCreateButton(92, 37, 107, 49, "Capa 1", false, setcol)
capa2 = guiCreateButton(92, 111, 107, 49, "Capa 2", false, setcol)
atras = guiCreateButton(56, 262, 185, 64, "Atrás", false, setcol)   
destroyElement(panel)
addEventHandler("onClientGUIClick", atras,
    function ( ... )
       guiSetVisible(setcol,false)
       showCursor(false)
    end)
addEventHandler("onClientGUIClick", capa1, pintura1)
addEventHandler("onClientGUIClick", capa2, pintura2)
end

function ColorUpdate(id, hex, r, g, b)
        triggerServerEvent ( "pintar", localPlayer, localPlayer, r,g,b, 1)
        removeEventHandler( "onColorPickerOK", localPlayer, ColorUpdate)
        playSoundFrontEnd ( 16 )
end

function ColorUpdate3(id, hex, r, g, b)
        triggerServerEvent ( "pintar", localPlayer, localPlayer, r,g,b, 3)
        removeEventHandler( "onColorPickerOK", localPlayer, ColorUpdate2)
        playSoundFrontEnd ( 16 )
end



function pintura1()
exports.colorblender:openPicker (1, 0, "Capa 1") addEventHandler( "onColorPickerOK", localPlayer, ColorUpdate)
end

function pintura2()
exports.colorblender:openPicker (1, 0, "Capa2") addEventHandler( "onColorPickerOK", localPlayer, ColorUpdate3)
end


function cerrarPANEL()
removeEventHandler("onClientRender",root,tucanoesmarica)
guiSetVisible(botoncerrar,false)
  guiSetVisible(puertaizquierda,false)
   guiSetVisible(puertaderecha,false) 
   guiSetVisible(puertatraseraderecha,false)
    guiSetVisible(puertatraseraizquierda,false)
    guiSetVisible(maletero,false)
    guiSetVisible(capot,false)
    guiSetVisible(luces ,false)
    guiSetVisible(parachoqueDe,false)
	guiSetVisible(parachoqueTrasero,false)
	guiSetVisible(parabrisas,false)
	-- guiSetVisible(suspension,false)
	-- guiSetVisible(frenos,false)
	guiSetVisible(ruedas,false)
--  guiSetVisible(turbo,false)
-- guiSetVisible(transmisionxd,false)
end

        asd = guiCreateWindow(0.34, 0.30, 0.31, 0.27, "Suspension", true)
		guiSetVisible(asd,false)
		
        guiWindowSetSizable(asd, false)
        scrollball = guiCreateScrollBar(0.13, 0.35, 0.65, 0.09, true, true, asd)
        guiScrollBarSetScrollPosition(scrollball, 100.0)
        xde = guiCreateLabel(0.20, 0.25, 0.27, 0.08, "Nivel de suspension:", true, asd)
        guiSetFont(xde, "default-bold-small")
        labelCantidad = guiCreateLabel(0.47, 0.25, 0.27, 0.08, "0", true, asd)
        guiSetFont(labelCantidad, "default-bold-small")
        guiLabelSetColor(labelCantidad, 255, 0, 0)
        botonConfirmar = guiCreateButton(0.13, 0.58, 0.31, 0.11, "Confirmar", true, asd)
        guiSetFont(botonConfirmar, "default-bold-small")
        guiSetProperty(botonConfirmar, "NormalTextColour", "FFAAAAAA")
        botonRestaurar = guiCreateButton(0.53, 0.58, 0.31, 0.11, "Restaurar", true, asd)
        guiSetFont(botonRestaurar, "default-bold-small")
        guiSetProperty(botonRestaurar, "NormalTextColour", "FFAAAAAA")
        botonCerrarSuspension = guiCreateButton(0.33, 0.74, 0.31, 0.11, "Cerrar", true, asd)
        guiSetFont(botonCerrarSuspension, "default-bold-small")
        guiSetProperty(botonCerrarSuspension, "NormalTextColour", "FFAAAAAA")    
	

   


        frenosp = guiCreateWindow(0.35, 0.33, 0.31, 0.27, "Frenos", true)
        guiWindowSetSizable(frenosp, false)
        guiSetVisible(frenosp,false)
        botonConfirmarFrenos = guiCreateButton(0.13, 0.58, 0.31, 0.11, "Confirmar", true, frenosp)
        guiSetFont(botonConfirmarFrenos, "default-bold-small")
        guiSetProperty(botonConfirmarFrenos, "NormalTextColour", "FFAAAAAA")
        botonRestaurarFrenos = guiCreateButton(0.53, 0.58, 0.31, 0.11, "Restaurar", true, frenosp)
        guiSetFont(botonRestaurarFrenos, "default-bold-small")
        guiSetProperty(botonRestaurarFrenos, "NormalTextColour", "FFAAAAAA")
        botonCerrarFrenos = guiCreateButton(0.33, 0.74, 0.31, 0.11, "Cerrar", true, frenosp)
        guiSetFont(botonCerrarFrenos, "default-bold-small")
        guiSetProperty(botonCerrarFrenos, "NormalTextColour", "FFAAAAAA")
        editFrenos = guiCreateEdit(0.22, 0.37, 0.50, 0.12, "", true, frenosp)
        xdeasd = guiCreateLabel(0.20, 0.27, 0.53, 0.09, "Digite el valor numerico entre 5-15", true, frenosp)
        guiSetFont(xdeasd, "default-bold-small")
        guiLabelSetColor(xdeasd, 255, 0, 0)
        guiLabelSetHorizontalAlign(xdeasd, "center", false)   


       
              transmisionP = guiCreateWindow(0.35, 0.33, 0.31, 0.27, "Transmision", true)
        guiWindowSetSizable(transmisionP, false)
        guiSetVisible(transmisionP,false)
        showCursor(false)
        botonConfirmarTransmision = guiCreateButton(0.13, 0.58, 0.31, 0.11, "Confirmar", true, transmisionP)
        guiSetFont(botonConfirmarTransmision, "default-bold-small")
        guiSetProperty(botonConfirmarTransmision, "NormalTextColour", "FFAAAAAA")
        botonRestaurarTransmision = guiCreateButton(0.53, 0.58, 0.31, 0.11, "Restaurar", true, transmisionP)
        guiSetFont(botonRestaurarTransmision, "default-bold-small")
        guiSetProperty(botonRestaurarTransmision, "NormalTextColour", "FFAAAAAA")
        botonCerrarTransmision = guiCreateButton(0.33, 0.74, 0.31, 0.11, "Cerrar", true, transmisionP)
        guiSetFont(botonCerrarTransmision, "default-bold-small")
        guiSetProperty(botonCerrarTransmision, "NormalTextColour", "FFAAAAAA")
        editTransmision = guiCreateEdit(0.22, 0.37, 0.50, 0.12, "", true, transmisionP)
        xdeasdax = guiCreateLabel(0.20, 0.27, 0.53, 0.09, "Digite el valor numerico entre 100-200", true, transmisionP)
        guiSetFont(xdeasdax, "default-bold-small")
        guiLabelSetColor(xdeasdax, 255, 0, 0)
        guiLabelSetHorizontalAlign(xdeasdax, "center", false)    

 

        turbop = guiCreateWindow(0.35, 0.33, 0.30, 0.35, "Turbo", true)
        guiWindowSetSizable(turbop, false)
        guiSetVisible(turbop,false)
        xde = guiCreateLabel(0.28, 0.19, 0.44, 0.09, "Instalación del turbo", true, turbop)
        guiSetFont(xde, "default-bold-small")
        guiLabelSetColor(xde, 255, 0, 0)
        guiLabelSetHorizontalAlign(xde, "center", false)
        guiLabelSetVerticalAlign(xde, "center")
        botonInstalarTurbo = guiCreateButton(0.31, 0.41, 0.38, 0.10, "Instalar Turbo", true, turbop)
        guiSetFont(botonInstalarTurbo, "default-bold-small")
        guiSetProperty(botonInstalarTurbo, "NormalTextColour", "FFAAAAAA")
        botonDesinstalarTurbo = guiCreateButton(0.31, 0.60, 0.38, 0.10, "Desintalar Turbo", true, turbop)
        guiSetFont(botonDesinstalarTurbo, "default-bold-small")
        guiSetProperty(botonDesinstalarTurbo, "NormalTextColour", "FFAAAAAA")
        botonCerrarxd = guiCreateButton(0.31, 0.79, 0.38, 0.10, "Cerrar", true, turbop)
        guiSetFont(botonCerrarxd, "default-bold-small")
        guiSetProperty(botonCerrarxd, "NormalTextColour", "FFAAAAAA")    
 
  
function  botones2( ... )
 pintar = guiCreateButton(screenW * 0.3302, screenH * 0.3112, screenW * 0.1325, screenH * 0.0469,"",false)
 cambiarRuedas = guiCreateButton(screenW * 0.4817, screenH * 0.3112, screenW * 0.1325, screenH * 0.0469,"",false) 
 pegatinas = guiCreateButton(screenW * 0.3302, screenH * 0.3711, screenW * 0.1325, screenH * 0.0469,"",false)
 tunnin = guiCreateButton(screenW * 0.4817, screenH * 0.3711, screenW * 0.1325, screenH * 0.0469,"",false)
 cerrarTunning = guiCreateButton(screenW * 0.4070, screenH * 0.4310, screenW * 0.1325, screenH * 0.0469,"",false)
 guiSetAlpha(pintar,0)
 guiSetAlpha(cambiarRuedas,0)
 guiSetAlpha(pegatinas,0)
 guiSetAlpha(tunnin,0)
 guiSetAlpha(cerrarTunning,0) 
end

function  cerrarTunnin( ... )
    removeEventHandler("onClientRender",root,tunnings)
    showCursor(false)
    guiSetVisible(pintar,false)
    guiSetVisible(cambiarRuedas,false)
    guiSetVisible(pegatinas,false)
    guiSetVisible(tunnin,false)
    guiSetVisible(cerrarTunning,false)
end

local screenW, screenH = guiGetScreenSize()

colorPintar = 71 
colorCambioR = 71
colorPegatinas = 71
colorTunnings = 71
colorCerrarTunnings = 71
function  tunnings(  )
    -- body

        dxDrawLine((screenW * 0.3192) - 1, (screenH * 0.2279) - 1, (screenW * 0.3192) - 1, screenH * 0.5065, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6303, (screenH * 0.2279) - 1, (screenW * 0.3192) - 1, (screenH * 0.2279) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3192) - 1, screenH * 0.5065, screenW * 0.6303, screenH * 0.5065, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6303, screenH * 0.5065, screenW * 0.6303, (screenH * 0.2279) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3192, screenH * 0.2279, screenW * 0.3111, screenH * 0.2786, tocolor(0, 0, 0, 162), false)
        dxDrawLine((screenW * 0.3184) - 1, (screenH * 0.2279) - 1, (screenW * 0.3184) - 1, screenH * 0.2852, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6303, (screenH * 0.2279) - 1, (screenW * 0.3184) - 1, (screenH * 0.2279) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3184) - 1, screenH * 0.2852, screenW * 0.6303, screenH * 0.2852, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6303, screenH * 0.2852, screenW * 0.6303, (screenH * 0.2279) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3184, screenH * 0.2279, screenW * 0.3119, screenH * 0.0573, tocolor(200, 140, 54, 254), false)
        dxDrawText("Tunnings", (screenW * 0.3272) - 1, (screenH * 0.2383) - 1, (screenW * 0.6179) - 1, (screenH * 0.2721) - 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.3272) + 1, (screenH * 0.2383) - 1, (screenW * 0.6179) + 1, (screenH * 0.2721) - 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.3272) - 1, (screenH * 0.2383) + 1, (screenW * 0.6179) - 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.3272) + 1, (screenH * 0.2383) + 1, (screenW * 0.6179) + 1, (screenH * 0.2721) + 1, tocolor(0, 0, 0, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", screenW * 0.3272, screenH * 0.2383, screenW * 0.6179, screenH * 0.2721, tocolor(254, 0, 0, 254), 1.00, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3302) - 1, (screenH * 0.3112) - 1, (screenW * 0.3302) - 1, screenH * 0.3581, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4627, (screenH * 0.3112) - 1, (screenW * 0.3302) - 1, (screenH * 0.3112) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3302) - 1, screenH * 0.3581, screenW * 0.4627, screenH * 0.3581, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4627, screenH * 0.3581, screenW * 0.4627, (screenH * 0.3112) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3302, screenH * 0.3112, screenW * 0.1325, screenH * 0.0469, tocolor(71, colorPintar, 71, 254), false)
        dxDrawText("Pintar", (screenW * 0.3419) - 1, (screenH * 0.3229) - 1, (screenW * 0.4517) - 1, (screenH * 0.3451) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pintar", (screenW * 0.3419) + 1, (screenH * 0.3229) - 1, (screenW * 0.4517) + 1, (screenH * 0.3451) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pintar", (screenW * 0.3419) - 1, (screenH * 0.3229) + 1, (screenW * 0.4517) - 1, (screenH * 0.3451) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pintar", (screenW * 0.3419) + 1, (screenH * 0.3229) + 1, (screenW * 0.4517) + 1, (screenH * 0.3451) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pintar", screenW * 0.3419, screenH * 0.3229, screenW * 0.4517, screenH * 0.3451, tocolor(142, 0, 0, 254), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4817) - 1, (screenH * 0.3112) - 1, (screenW * 0.4817) - 1, screenH * 0.3581, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6142, (screenH * 0.3112) - 1, (screenW * 0.4817) - 1, (screenH * 0.3112) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4817) - 1, screenH * 0.3581, screenW * 0.6142, screenH * 0.3581, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6142, screenH * 0.3581, screenW * 0.6142, (screenH * 0.3112) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4817, screenH * 0.3112, screenW * 0.1325, screenH * 0.0469, tocolor(71, colorCambioR, 71, 254), false)
        dxDrawText("Cambio de Ruedas", (screenW * 0.4905) - 1, (screenH * 0.3203) - 1, (screenW * 0.6069) - 1, (screenH * 0.3451) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cambio de Ruedas", (screenW * 0.4905) + 1, (screenH * 0.3203) - 1, (screenW * 0.6069) + 1, (screenH * 0.3451) - 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cambio de Ruedas", (screenW * 0.4905) - 1, (screenH * 0.3203) + 1, (screenW * 0.6069) - 1, (screenH * 0.3451) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cambio de Ruedas", (screenW * 0.4905) + 1, (screenH * 0.3203) + 1, (screenW * 0.6069) + 1, (screenH * 0.3451) + 1, tocolor(0, 0, 0, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cambio de Ruedas", screenW * 0.4905, screenH * 0.3203, screenW * 0.6069, screenH * 0.3451, tocolor(142, 0, 0, 254), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.3302) - 1, (screenH * 0.3711) - 1, (screenW * 0.3302) - 1, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4627, (screenH * 0.3711) - 1, (screenW * 0.3302) - 1, (screenH * 0.3711) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.3302) - 1, screenH * 0.4180, screenW * 0.4627, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.4627, screenH * 0.4180, screenW * 0.4627, (screenH * 0.3711) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.3302, screenH * 0.3711, screenW * 0.1325, screenH * 0.0469, tocolor(71, colorPegatinas, 71, 254), false)
        dxDrawText("Pegatinas", (screenW * 0.3397) - 1, (screenH * 0.3815) - 1, (screenW * 0.4517) - 1, (screenH * 0.4049) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pegatinas", (screenW * 0.3397) + 1, (screenH * 0.3815) - 1, (screenW * 0.4517) + 1, (screenH * 0.4049) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pegatinas", (screenW * 0.3397) - 1, (screenH * 0.3815) + 1, (screenW * 0.4517) - 1, (screenH * 0.4049) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pegatinas", (screenW * 0.3397) + 1, (screenH * 0.3815) + 1, (screenW * 0.4517) + 1, (screenH * 0.4049) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pegatinas", screenW * 0.3397, screenH * 0.3815, screenW * 0.4517, screenH * 0.4049, tocolor(142, 0, 0, 254), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4817) - 1, (screenH * 0.3711) - 1, (screenW * 0.4817) - 1, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6142, (screenH * 0.3711) - 1, (screenW * 0.4817) - 1, (screenH * 0.3711) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4817) - 1, screenH * 0.4180, screenW * 0.6142, screenH * 0.4180, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.6142, screenH * 0.4180, screenW * 0.6142, (screenH * 0.3711) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4817, screenH * 0.3711, screenW * 0.1325, screenH * 0.0469, tocolor(71, colorTunnings, 71, 254), false)
        dxDrawText("Tunnings", (screenW * 0.4905) - 1, (screenH * 0.3815) - 1, (screenW * 0.6025) - 1, (screenH * 0.4049) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.4905) + 1, (screenH * 0.3815) - 1, (screenW * 0.6025) + 1, (screenH * 0.4049) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.4905) - 1, (screenH * 0.3815) + 1, (screenW * 0.6025) - 1, (screenH * 0.4049) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", (screenW * 0.4905) + 1, (screenH * 0.3815) + 1, (screenW * 0.6025) + 1, (screenH * 0.4049) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Tunnings", screenW * 0.4905, screenH * 0.3815, screenW * 0.6025, screenH * 0.4049, tocolor(142, 0, 0, 254), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawLine((screenW * 0.4070) - 1, (screenH * 0.4310) - 1, (screenW * 0.4070) - 1, screenH * 0.4779, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.5395, (screenH * 0.4310) - 1, (screenW * 0.4070) - 1, (screenH * 0.4310) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.4070) - 1, screenH * 0.4779, screenW * 0.5395, screenH * 0.4779, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.5395, screenH * 0.4779, screenW * 0.5395, (screenH * 0.4310) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.4070, screenH * 0.4310, screenW * 0.1325, screenH * 0.0469, tocolor(71, colorCerrarTunnings, 71, 254), false)
        dxDrawText("Cerrar", (screenW * 0.4202) - 1, (screenH * 0.4414) - 1, (screenW * 0.5322) - 1, (screenH * 0.4648) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", (screenW * 0.4202) + 1, (screenH * 0.4414) - 1, (screenW * 0.5322) + 1, (screenH * 0.4648) - 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", (screenW * 0.4202) - 1, (screenH * 0.4414) + 1, (screenW * 0.5322) - 1, (screenH * 0.4648) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", (screenW * 0.4202) + 1, (screenH * 0.4414) + 1, (screenW * 0.5322) + 1, (screenH * 0.4648) + 1, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Cerrar", screenW * 0.4202, screenH * 0.4414, screenW * 0.5322, screenH * 0.4648, tocolor(142, 0, 0, 254), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
  end







addEventHandler( "onClientGUIScroll", root,
function()
  if source == scrollball then
  guiSetText(labelCantidad,guiScrollBarGetScrollPosition(source) )
  end
end)
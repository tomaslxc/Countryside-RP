-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 09-02-2021 a las 04:28:43
-- Versión del servidor: 5.7.33-0ubuntu0.18.04.1
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gmrp`
--

-- --------------------------------------------------------



--
-- Estructura de tabla para la tabla `banks`
--

CREATE TABLE `banks` (
  `id` int(100) NOT NULL,
  `tipo` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `skin` int(10) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rotx` float NOT NULL,
  `roty` float NOT NULL,
  `rotz` float NOT NULL,
  `interior` int(10) NOT NULL,
  `dimension` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `banks`
--

INSERT INTO `banks` (`id`, `tipo`, `name`, `skin`, `x`, `y`, `z`, `rotx`, `roty`, `rotz`, `interior`, `dimension`) VALUES
(1, 0, 'ATMGASOLINERA', 0, 1928.58, -1770.48, 13.5469, 0, 0, 91.8224, 0, 0),
(2, 0, 'ATMPIZZERIAIDLEWOOD', 0, 2105.46, -1808.04, 13.5547, 0, 0, 270.699, 0, 0),
(3, 0, 'ATMHOSPITAL|LS', 0, 2043.82, -1411.75, 17.1641, 0, 0, 270.314, 0, 0),
(4, 1, 'BANCOLS', 150, -1432.21, -545.449, 14.4109, 0, 0, 19.8114, 12, 634),
(5, 0, '1', 1, -1426.4, -544.681, 14.4109, 0, 0, 200.116, 12, 634),
(6, 0, 'cajerogrotti', 0, 535.242, -1293.93, 17.2422, 0, 0, 183.065, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capots`
--

CREATE TABLE `capots` (
  `id` int(255) NOT NULL,
  `transmision` int(100) NOT NULL DEFAULT '0',
  `suspension` int(100) NOT NULL DEFAULT '0',
  `ruedas` int(100) NOT NULL DEFAULT '0',
  `turbo` int(100) NOT NULL DEFAULT '0',
  `maletero` int(10) NOT NULL DEFAULT '0',
  `capot` int(10) NOT NULL DEFAULT '0',
  `delantera_izq` int(10) NOT NULL DEFAULT '0',
  `delantera_der` int(10) NOT NULL DEFAULT '0',
  `trasera_izq` int(10) NOT NULL DEFAULT '0',
  `trasera_der` int(10) NOT NULL DEFAULT '0',
  `faro_d_izq` int(10) NOT NULL DEFAULT '0',
  `faro_d_der` int(10) NOT NULL DEFAULT '0',
  `faro_t_izq` int(10) NOT NULL DEFAULT '0',
  `faro_t_der` int(10) NOT NULL DEFAULT '0',
  `desgaste_turbo` int(10) NOT NULL DEFAULT '0',
  `desgaste_transmision` int(10) NOT NULL DEFAULT '0',
  `desgaste_ruedas` int(10) NOT NULL DEFAULT '0',
  `desgaste_suspension` int(10) NOT NULL DEFAULT '0',
  `rueda_d_izq` int(10) NOT NULL DEFAULT '0',
  `rueda_d_der` int(10) NOT NULL DEFAULT '0',
  `rueda_t_izq` int(10) NOT NULL DEFAULT '0',
  `rueda_t_der` int(10) NOT NULL DEFAULT '0',
  `p_d` int(10) NOT NULL DEFAULT '0',
  `p_t` int(10) NOT NULL DEFAULT '0',
  `vehid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `capots`
--

INSERT INTO `capots` (`id`, `transmision`, `suspension`, `ruedas`, `turbo`, `maletero`, `capot`, `delantera_izq`, `delantera_der`, `trasera_izq`, `trasera_der`, `faro_d_izq`, `faro_d_der`, `faro_t_izq`, `faro_t_der`, `desgaste_turbo`, `desgaste_transmision`, `desgaste_ruedas`, `desgaste_suspension`, `rueda_d_izq`, `rueda_d_der`, `rueda_t_izq`, `rueda_t_der`, `p_d`, `p_t`, `vehid`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cheques_bancarios`
--

CREATE TABLE `cheques_bancarios` (
  `id` int(100) NOT NULL,
  `cuenta` int(255) NOT NULL,
  `cantidad` int(255) NOT NULL DEFAULT '0',
  `activo` int(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `concesionario`
--

CREATE TABLE `concesionario` (
  `concesionario` tinyint(10) NOT NULL DEFAULT '1',
  `modelo` int(100) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `precio` int(100) NOT NULL,
  `active` tinyint(10) NOT NULL DEFAULT '1',
  `vehid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `concesionario`
--

INSERT INTO `concesionario` (`concesionario`, `modelo`, `nombre`, `precio`, `active`, `vehid`) VALUES
(1, 581, 'BF-400', 9500, 1, 0),
(1, 521, 'FCR-900', 90000, 1, 0),
(1, 463, 'Freeway', 12000, 1, 0),
(1, 461, 'PCJ-600', 14000, 1, 0),
(1, 468, 'Sanchez', 50000, 1, 0),
(1, 586, 'Wayfarer', 12000, 1, 0),
(1, 496, 'Blista Compact', 14000, 1, 0),
(1, 518, 'Buccaneer', 14000, 1, 0),
(1, 410, 'Manana', 9000, 1, 0),
(1, 549, 'Tampa', 7500, 1, 0),
(1, 491, 'Virgo', 11000, 1, 0),
(1, 600, 'Picador', 12000, 1, 0),
(1, 587, 'Euros', 17000, 1, 0),
(1, 517, 'Majestic', 15000, 1, 0),
(1, 439, 'Stallion', 25000, 1, 0),
(1, 602, 'Alpha', 22000, 1, 0),
(1, 527, 'Cadrona', 19000, 1, 0),
(1, 533, 'Feltzer', 29000, 1, 0),
(1, 475, 'Sabre', 35000, 1, 0),
(1, 542, 'Clover', 18000, 1, 0),
(1, 466, 'Glendale', 18000, 1, 0),
(1, 529, 'Willard', 19000, 1, 0),
(1, 547, 'Primo', 20000, 1, 0),
(1, 492, 'Greenwood', 20000, 1, 0),
(1, 585, 'Emperor', 22000, 1, 0),
(1, 467, 'Oceanic', 22000, 1, 0),
(1, 426, 'Premier', 25000, 1, 0),
(1, 516, 'Nebula', 25000, 1, 0),
(1, 546, 'Intruder', 18000, 1, 0),
(1, 507, 'Elegant', 25000, 1, 0),
(1, 551, 'Merit', 27000, 1, 0),
(1, 405, 'Sentinel', 30000, 1, 0),
(1, 445, 'Admiral', 30000, 1, 0),
(1, 421, 'Washington', 34000, 1, 0),
(1, 540, 'Vincent', 30000, 1, 0),
(1, 566, 'Tahoma', 21000, 1, 0),
(1, 561, 'Stratum', 17000, 1, 0),
(1, 580, 'Stafford', 37000, 1, 0),
(1, 422, 'Bobcat', 25000, 1, 0),
(1, 478, 'Walton', 17000, 1, 0),
(1, 554, 'Yosemite', 30000, 1, 0),
(1, 579, 'Huntley', 70000, 1, 0),
(1, 560, 'Sultan', 100000, 1, 0),
(1, 562, 'Elegy', 300000, 1, 0),
(1, 400, 'Landstalker', 30000, 1, 0),
(1, 404, 'Perennial', 20000, 1, 0),
(1, 458, 'Solair', 22000, 1, 0),
(1, 508, 'Journey', 45000, 1, 0),
(1, 500, 'Mesa', 40000, 1, 0),
(1, 483, 'Camper', 30000, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `ID` int(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `pcu` int(10) NOT NULL,
  `staff` int(10) NOT NULL DEFAULT '0',
  `ip` varchar(100) NOT NULL DEFAULT '0',
  `serial` varchar(100) NOT NULL DEFAULT '0',
  `coins` int(100) NOT NULL DEFAULT '0',
  `ban` int(10) NOT NULL DEFAULT '0',
  `p1` int(10) NOT NULL,
  `p2` int(10) NOT NULL,
  `p3` int(10) NOT NULL,
  `p4` int(10) NOT NULL,
  `p5` int(10) NOT NULL,
  `p6` int(10) NOT NULL,
  `p7` int(10) NOT NULL,
  `p8` int(10) NOT NULL,
  `p9` int(10) NOT NULL,
  `p10` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`ID`, `username`, `password`, `correo`, `pcu`, `staff`, `ip`, `serial`, `coins`, `ban`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `p10`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_bancarias`
--

CREATE TABLE `cuentas_bancarias` (
  `id` int(100) NOT NULL,
  `owner` int(100) NOT NULL,
  `pin` int(10) NOT NULL,
  `dinero` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cuentas_bancarias`
--

INSERT INTO `cuentas_bancarias` (`id`, `owner`, `pin`, `dinero`) VALUES;

-- --------------------------------------------------------



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facciones`
--

CREATE TABLE `facciones` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `short` varchar(100) NOT NULL,
  `tipo` int(100) NOT NULL,
  `subvencion` int(100) NOT NULL DEFAULT '0',
  `presupuesto` int(100) NOT NULL DEFAULT '0',
  `comision` int(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `facciones`
--

INSERT INTO `facciones` (`id`, `name`, `short`, `tipo`, `subvencion`, `presupuesto`, `comision`) VALUES
(1, 'Los Santos Medical Department', 'LSMD', 1, 400, 51150, 30),
(2, 'Los Santos Police Departament', 'LSPD', 1, 400, 45366, 0),
(3, 'Taxi FOX', 'TAXI', 1, 200, 25000, 40),
(4, 'Crazy Wheels', 'Taller', 1, 300, 11066, 40),
(5, 'Gobierno', 'Gobierno', 1, 400, 55100, 0),
(6, 'Red Trucker Union', 'camioneros', 1, 300, 21039, 40),
(7, 'Radio Los Santos', 'radio', 1, 300, 25115, 40),
(8, 'Merryweather Corporation', 'Eagle', 1, 300, 25000, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id` int(255) NOT NULL,
  `hecha_por` int(255) NOT NULL,
  `hecha_para` int(255) NOT NULL,
  `cantidad` int(255) NOT NULL,
  `motivo` varchar(255) NOT NULL,
  `faccion` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id`, `hecha_por`, `hecha_para`, `cantidad`, `motivo`, `faccion`) VALUES
(1, 216, 216, 420, 'aleron y ruedas', 4),
(2, 216, 216, 240, 'luz y parachoques', 4),
(3, 226, 224, 78, 'puto', 4),
(4, 226, 226, 120, 'pintura', 4),
(5, 216, 216, 38, 'g', 4),
(6, 226, 226, 120, 'pintura', 4),
(7, 231, 231, 120, 'Pegatinas', 4),
(8, 231, 223, 240, 'Paragolpes, maletero, puerta.', 4),
(9, 216, 216, 240, 'luz y parachoques', 4);

-- --------------------------------------------------------



--
-- Estructura de tabla para la tabla `infos`
--

CREATE TABLE `infos` (
  `text` text NOT NULL,
  `creador` text NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `z` int(11) NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `infos`
--

INSERT INTO `infos` (`text`, `creador`, `x`, `y`, `z`, `interior`, `dimension`, `id`) VALUES
('Puerta Carcel: 3', 'Servidor', -17, -328, 2522, 4, 252, 10),
('Puerta Carcel: 4', 'Servidor', -17, -313, 2522, 4, 252, 11),
('Puerta Carcel: 5', 'Servidor', -19, -302, 2522, 4, 252, 12),
('Puerta Carcel: 6', 'Servidor', -17, -300, 2522, 4, 252, 13),
('Puerta Carcel: 11', 'Servidor', 48, -318, 2522, 4, 252, 14),
('Puerta Carcel: 20', 'Servidor', 50, -329, 2522, 4, 252, 15),
('Puerta Carcel: 21', 'Servidor', 54, -329, 2522, 4, 252, 16),
('Puerta Carcel: 22', 'Servidor', 58, -329, 2522, 4, 252, 17),
('Puerta Carcel: 23', 'Servidor', 62, -329, 2522, 4, 252, 18),
('Puerta Carcel: 24', 'Servidor', 66, -329, 2522, 4, 252, 19),
('Puerta Carcel: 25', 'Servidor', 69, -329, 2522, 4, 252, 20),
('Puerta Carcel: 26', 'Servidor', 73, -329, 2522, 4, 252, 21),
('Puerta Carcel: 27', 'Servidor', 50, -329, 2526, 4, 252, 22),
('Puerta Carcel: 28', 'Servidor', 54, -329, 2527, 4, 252, 23),
('Puerta Carcel: 29', 'Servidor', 58, -329, 2527, 4, 252, 24),
('Puerta Carcel: 30', 'Servidor', 62, -329, 2527, 4, 252, 25),
('Puerta Carcel: 31', 'Servidor', 66, -329, 2527, 4, 252, 26),
('Puerta Carcel: 32', 'Servidor', 69, -329, 2527, 4, 252, 27),
('Puerta Carcel: 33', 'Servidor', 74, -329, 2527, 4, 252, 28),
('Puerta Carcel: 34', 'Servidor', 75, -306, 2527, 4, 252, 29),
('Puerta Carcel: 35', 'Servidor', 71, -306, 2527, 4, 252, 30),
('Puerta Carcel: 36', 'Servidor', 68, -306, 2527, 4, 252, 31),
('Puerta Carcel: 37', 'Servidor', 63, -306, 2527, 4, 252, 32),
('Puerta Carcel: 38', 'Servidor', 59, -306, 2527, 4, 252, 33),
('Puerta Carcel: 39', 'Servidor', 55, -306, 2527, 4, 252, 34),
('Puerta Carcel: 40', 'Servidor', 51, -306, 2527, 4, 252, 35),
('Puerta Carcel: 41', 'Servidor', 1034, -366, 77, 0, 0, 36),
('Puerta Carcel: 2', 'Servidor', 1011, -379, 77, 0, 0, 37),
('Puerta Carcel: 10', 'Servidor', -7, -333, 2522, 4, 252, 38),
('(( /puertacarcel 7 ))', 'Servidor', -1320, -565, 14, 5, 383, 95),
('(( /puertacarcel 8 ))', 'Servidor', -1321, -563, 14, 5, 383, 96),
('(( /puertacarcel 9 ))', 'Servidor', -1323, -559, 14, 5, 383, 97),
('((/abrirvehiculosjob))', 'Servidor', -105, 78, 3, 0, 0, 118),
('((/abrirvehiculosjob))', 'Servidor', 83, 139, 2, 0, 0, 119),
('Comando: /comisaria 1', 'Servidor', -1307, -544, 17, 5, 383, 121),
('((Ponerse aqui y darle click a los NPC para poder previsualizar bien la ropa))', 'Servidor', 208, -104, 1005, 15, 499, 134),
('((/bpd 1))', 'Tomas_Neus', 1546, -1631, 13, 0, 0, 139),
('((/bmd 1))', 'Tomas_Neus', 2103, -1449, 24, 0, 0, 140),
('((Para la policÃ­a es por la calle ST-MARY))', 'Servidor', 2102, -1446, 24, 0, 0, 142),
('((/bpd 3))', 'Tomas_Neus', 2004, -1351, 24, 0, 0, 144),
('((Acceso policia, mantener cerrado)', 'Tomas_Neus', 1998, -1351, 24, 0, 0, 145),
('((/taxi 1))', 'Tomas_Neus', 1367, -1882, 14, 0, 0, 146),
('Oficina de empleos', 'Tomas_Neus', 1489, -1770, 19, 0, 0, 147),
('Ayuntamiento', 'Tomas_Neus', 1481, -1771, 19, 0, 0, 148),
('Juzgados', 'Tomas_Neus', 1474, -1771, 19, 0, 0, 149),
('((/abrirvehiculosjob))', 'Servidor', 2959, -1513, 2, 0, 0, 150),
('Concesionario', 'Servidor', 539, -1293, 17, 0, 0, 151),
('((Ponerse aqui para y darle click al NPC))', 'Servidor', 208, -104, 1005, 15, 631, 152),
('Oficina de empleo', 'Servidor', 1746, -1863, 14, 0, 0, 153),
('((/abrirvehiculosjob))', 'Servidor', 2340, -815, 127, 0, 0, 154),
('((/ad))', 'Servidor', -1354, -466, 19, 36, 503, 155),
('((/ad))', 'Servidor', -1361, -468, 19, 36, 503, 156);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interiores`
--

CREATE TABLE `interiores` (
  `id` int(100) NOT NULL,
  `tipo` int(100) DEFAULT NULL,
  `precio` int(100) DEFAULT NULL,
  `owner` int(100) NOT NULL DEFAULT '0',
  `x_out` float NOT NULL,
  `y_out` float NOT NULL,
  `z_out` float NOT NULL,
  `x_in` float NOT NULL,
  `y_in` float NOT NULL,
  `z_in` float NOT NULL,
  `dimension_out` int(10) NOT NULL,
  `interior_out` int(10) NOT NULL,
  `dimension_in` int(10) DEFAULT NULL,
  `interior_in` int(10) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `forsale` int(10) NOT NULL DEFAULT '0',
  `locked` int(10) NOT NULL DEFAULT '0',
  `factionable` tinyint(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `interiores`
--

INSERT INTO `interiores` (`id`, `tipo`, `precio`, `owner`, `x_out`, `y_out`, `z_out`, `x_in`, `y_in`, `z_in`, `dimension_out`, `interior_out`, `dimension_in`, `interior_in`, `name`, `forsale`, `locked`, `factionable`) VALUES
(497, 2, 0, 0, 1555.49, -1675.65, 16.1953, -1314.38, -536.311, 16.7775, 0, 0, 383, 5, 'Comisaria', 0, 0, 0),
(498, 2, 0, 0, 2034.09, -1401.67, 17.2941, -1361.17, -595.495, 14.2078, 0, 0, 387, 10, 'Hospital', 0, 0, 0),
(499, 2, 0, 0, 2244.27, -1665.53, 15.4766, 207.63, -111.26, 1005.13, 0, 0, 499, 15, 'Clothes', 0, 0, 0),
(500, 2, 0, 0, 2032.57, -1438.35, 17.2264, -1402.56, -598.759, 14.1703, 0, 0, 500, 24, 'Hospital', 0, 0, 0),
(501, 1, NULL, 0, -1368.78, -594.44, 14.2156, 2042.26, -1396.21, 48.3359, 387, 10, 0, 0, 'azoteals', 0, 0, 0),
(505, 1, NULL, 0, -1246.18, -461.72, 14.2156, -1374.22, -594.44, 14.2156, 387, 10, 387, 10, 'hpls', 0, 0, 0),
(510, 3, 45000, 0, 2257.13, -1643.94, 15.8082, 226.79, 1240.02, 1082.14, 0, 0, 510, 2, 'Casa', 1, 0, 0),
(511, 3, 45000, 0, 2244.38, -1638.03, 15.9074, 226.79, 1240.02, 1082.14, 0, 0, 511, 2, 'Casa', 1, 0, 0),
(512, 3, 45000, 0, 2282.32, -1641.21, 15.8898, 226.79, 1240.02, 1082.14, 0, 0, 512, 2, 'Casa', 1, 0, 0),
(513, 3, 45000, 0, 2306.89, -1679.2, 14.3316, 226.79, 1240.02, 1082.14, 0, 0, 513, 2, 'Casa', 1, 0, 0),
(520, 3, 45000, 0, 2326.88, -1682, 14.9297, 295.16, 1472.26, 1080.26, 0, 0, 520, 15, 'Casa', 1, 0, 0),
(522, 3, 45000, 0, 2326.81, -1716.7, 14.2379, 226.79, 1240.02, 1082.14, 0, 0, 522, 2, 'Casa', 1, 0, 0),
(523, 3, 45000, 0, 2308.95, -1714.33, 14.9801, 295.16, 1472.26, 1080.26, 0, 0, 523, 15, 'Casa', 1, 0, 0),
(524, 3, 45000, 0, 2409.03, -1674.92, 14.375, 226.79, 1240.02, 1082.14, 0, 0, 524, 2, 'Casa', 1, 0, 0),
(525, 3, 45000, 0, 2413.9, -1646.79, 14.0119, 295.16, 1472.26, 1080.26, 0, 0, 525, 15, 'Casa', 1, 0, 0),
(526, 3, 45000, 0, 2393.21, -1646.03, 13.9051, 295.16, 1472.26, 1080.26, 0, 0, 526, 15, 'Casa', 1, 0, 0),
(527, 3, 45000, 0, 2384.71, -1675.83, 15.2457, 226.79, 1240.02, 1082.14, 0, 0, 527, 2, 'Casa', 1, 0, 0),
(528, 3, 45000, 0, 2362.83, -1643.14, 14.3516, 226.79, 1240.02, 1082.14, 0, 0, 528, 2, 'Casa', 1, 0, 0),
(529, 3, 45000, 0, 2451.88, -1641.41, 14.0662, 226.79, 1240.02, 1082.14, 0, 0, 529, 2, 'Casa', 1, 0, 0),
(531, 3, 45000, 0, 2469.46, -1646.35, 13.7801, 226.79, 1240.02, 1082.14, 0, 0, 531, 2, 'Casa', 1, 0, 0),
(534, 3, 15000, 0, 1945.2, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 534, 1, 'Bloques', 1, 0, 0),
(535, 3, 15000, 0, 1945.19, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 535, 1, 'Bloques', 1, 0, 0),
(536, 3, 15000, 0, 1937.78, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 536, 1, 'Bloques', 1, 0, 0),
(537, 3, 15000, 0, 1935.82, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 537, 1, 'Bloques', 1, 0, 0),
(538, 3, 15000, 0, 1928.42, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 538, 1, 'Bloques', 1, 0, 0),
(539, 3, 15000, 0, 1926.59, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 539, 1, 'Bloques', 1, 0, 0),
(540, 3, 15000, 0, 1919.17, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 540, 1, 'Bloques', 1, 0, 0),
(541, 3, 15000, 0, 1917.25, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 541, 1, 'Bloques', 1, 0, 0),
(542, 3, 15000, 0, 1909.77, -1811.71, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 542, 1, 'Bloques', 1, 0, 0),
(543, 1, 15000, 204, 1937.69, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 543, 1, 'Bloques', 0, 0, 0),
(545, 1, 15000, 199, 1935.85, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 545, 1, 'Bloques', 0, 1, 0),
(546, 3, 15000, 0, 1928.43, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 546, 1, 'Bloques', 1, 0, 0),
(547, 3, 15000, 0, 1926.45, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 547, 1, 'Bloques', 1, 0, 0),
(548, 3, 15000, 0, 1919.19, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 548, 1, 'Bloques', 1, 0, 0),
(549, 3, 15000, 0, 1917.12, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 549, 1, 'Bloques', 1, 0, 0),
(551, 3, 15000, 0, 1909.63, -1811.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 551, 1, 'Bloques', 1, 0, 0),
(552, 3, 15000, 0, 1912.64, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 552, 1, 'Bloques', 1, 0, 0),
(553, 3, 15000, 0, 1914.43, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 553, 1, 'Bloques', 1, 0, 0),
(554, 3, 15000, 0, 1921.83, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 554, 1, 'Bloques', 1, 0, 0),
(555, 3, 15000, 0, 1923.85, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 555, 1, 'Bloques', 1, 0, 0),
(556, 3, 15000, 0, 1931.2, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 556, 1, 'Bloques', 1, 0, 0),
(557, 3, 15000, 0, 1933.08, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 557, 1, 'Bloques', 1, 0, 0),
(558, 3, 15000, 0, 1940.34, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 558, 1, 'Bloques', 1, 0, 0),
(559, 3, 15000, 0, 1942.38, -1821.73, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 559, 1, 'Bloques', 1, 0, 0),
(560, 3, 15000, 0, 1942.48, -1821.73, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 560, 1, 'Bloques', 1, 0, 0),
(561, 3, 15000, 0, 1940.49, -1821.73, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 561, 1, 'Bloques', 1, 0, 0),
(563, 3, 15000, 0, 1933.09, -1821.73, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 563, 1, 'Bloques', 1, 0, 0),
(564, 3, 15000, 0, 1931.24, -1821.73, 13.5391, 223.07, 1287.09, 1082.14, 0, 0, 564, 1, 'Bloques', 1, 0, 0),
(565, 3, 15000, 0, 1923.83, -1821.73, 13.5391, 223.07, 1287.09, 1082.14, 0, 0, 565, 1, 'Bloques', 1, 0, 0),
(566, 3, 15000, 0, 1921.84, -1821.73, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 566, 1, 'Bloques', 1, 0, 0),
(567, 3, 15000, 0, 1914.51, -1821.73, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 567, 1, 'Bloques', 1, 0, 0),
(568, 3, 15000, 0, 1912.57, -1821.73, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 568, 1, 'Bloques', 1, 0, 0),
(569, 3, 15000, 0, 1890.65, -1811.81, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 569, 1, 'Bloques', 1, 0, 0),
(570, 3, 15000, 0, 1883.24, -1811.81, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 570, 1, 'Bloques', 1, 0, 0),
(571, 3, 15000, 0, 1881.31, -1811.81, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 571, 1, 'Bloques', 1, 0, 0),
(572, 3, 15000, 0, 1873.94, -1811.81, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 572, 1, 'Bloques', 1, 0, 0),
(573, 1, 15000, 215, 1871.97, -1811.81, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 573, 1, 'Bloques', 0, 0, 0),
(574, 3, 15000, 0, 1864.62, -1811.81, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 574, 1, 'Bloques', 1, 0, 0),
(575, 3, 15000, 0, 1862.7, -1811.81, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 575, 1, 'Bloques', 1, 0, 0),
(576, 3, 15000, 0, 1855.23, -1811.81, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 576, 1, 'Bloques', 1, 0, 0),
(577, 3, 15000, 0, 1855.31, -1811.81, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 577, 1, 'Bloques', 1, 0, 0),
(578, 3, 15000, 0, 1862.7, -1811.76, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 578, 1, 'Bloques', 1, 0, 0),
(579, 3, 15000, 0, 1864.64, -1811.81, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 579, 1, 'Bloques', 1, 0, 0),
(580, 3, 15000, 0, 1872.06, -1811.81, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 580, 1, 'Bloques', 1, 0, 0),
(581, 3, 15000, 0, 1873.97, -1811.81, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 581, 1, 'Bloques', 1, 0, 0),
(582, 3, 15000, 0, 1881.42, -1811.81, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 582, 1, 'Bloques', 1, 0, 0),
(583, 3, 15000, 0, 1883.29, -1811.81, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 583, 1, 'Bloques', 1, 0, 0),
(584, 3, 15000, 0, 1890.79, -1811.81, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 584, 1, 'Bloques', 1, 0, 0),
(585, 3, 15000, 0, 1887.79, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 585, 1, 'Bloques', 1, 0, 0),
(586, 3, 15000, 0, 1885.97, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 586, 1, 'Bloques', 1, 0, 0),
(587, 3, 15000, 0, 1878.56, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 587, 1, 'Bloques', 1, 0, 0),
(588, 3, 15000, 0, 1876.61, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 588, 1, 'Bloques', 1, 0, 0),
(589, 3, 15000, 0, 1869.15, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 589, 1, 'Bloques', 1, 0, 0),
(590, 3, 15000, 0, 1867.37, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 590, 1, 'Bloques', 1, 0, 0),
(591, 3, 15000, 0, 1859.97, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 591, 1, 'Bloques', 1, 0, 0),
(592, 3, 15000, 0, 1858.12, -1821.83, 16.8786, 223.07, 1287.09, 1082.14, 0, 0, 592, 1, 'Bloques', 1, 0, 0),
(593, 3, 15000, 0, 1858.03, -1821.83, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 593, 1, 'Bloques', 1, 0, 0),
(594, 3, 15000, 0, 1859.94, -1821.83, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 594, 1, 'Bloques', 1, 0, 0),
(595, 3, 15000, 0, 1867.29, -1821.83, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 595, 1, 'Bloques', 1, 0, 0),
(596, 3, 15000, 0, 1869.3, -1821.83, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 596, 1, 'Bloques', 1, 0, 0),
(597, 3, 15000, 0, 1876.69, -1821.83, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 597, 1, 'Bloques', 1, 0, 0),
(598, 3, 15000, 0, 1878.67, -1821.84, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 598, 1, 'Bloques', 1, 0, 0),
(599, 3, 15000, 0, 1886.05, -1821.83, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 599, 1, 'Bloques', 1, 0, 0),
(600, 3, 15000, 0, 1887.89, -1821.83, 13.4688, 223.07, 1287.09, 1082.14, 0, 0, 600, 1, 'Bloques', 1, 0, 0),
(601, 1, 45000, 204, 2136.58, -1704.06, 15.4334, 226.79, 1240.02, 1082.14, 0, 0, 601, 2, 'San', 0, 1, 0),
(602, 3, 45000, 0, 2136.68, -1688, 15.6334, 226.79, 1240.02, 1082.14, 0, 0, 602, 2, 'San', 1, 0, 0),
(603, 3, 45000, 0, 2161.22, -1703.64, 15.5332, 226.79, 1240.02, 1082.14, 0, 0, 603, 2, 'San', 1, 0, 0),
(604, 3, 45000, 0, 2162.45, -1687.49, 15.4332, 226.79, 1240.02, 1082.14, 0, 0, 604, 2, 'San', 1, 0, 0),
(605, 3, 45000, 0, 2165.94, -1671.08, 15.8312, 226.79, 1240.02, 1082.14, 0, 0, 605, 2, 'San', 1, 0, 0),
(606, 2, 0, 0, 2105.49, -1806.54, 13.5547, 372.33, -133.52, 1001.49, 0, 0, 606, 5, 'Pizzeria|', 0, 0, 0),
(610, 2, 0, 0, 1928.58, -1776.32, 13.5469, -25.77, -141.55, 1003.55, 0, 0, 610, 16, 'GASOLINERA', 0, 0, 0),
(611, 2, 0, 0, 2001.8, -1761.96, 13.5391, -25.77, -141.55, 1003.55, 0, 0, 611, 16, '24/7', 0, 0, 0),
(612, 3, 45000, 0, 2015.35, -1732.58, 14.2344, 226.79, 1240.02, 1082.14, 0, 0, 612, 2, 'San', 1, 0, 0),
(614, 3, 45000, 0, 2016.2, -1716.97, 14.125, 235.25, 1186.68, 1080.26, 0, 0, 614, 3, 'San', 1, 0, 0),
(615, 3, 45000, 0, 2018.24, -1703.17, 14.2344, 235.25, 1186.68, 1080.26, 0, 0, 615, 3, 'San', 1, 0, 0),
(616, 3, 45000, 0, 2065.1, -1703.53, 14.1484, 226.79, 1240.02, 1082.14, 0, 0, 616, 2, 'San', 1, 0, 0),
(617, 3, 45000, 0, 2066.24, -1717.09, 14.1363, 226.79, 1240.02, 1082.14, 0, 0, 617, 2, 'San', 1, 0, 0),
(618, 3, 45000, 0, 2067.05, -1731.65, 14.2066, 226.79, 1240.02, 1082.14, 0, 0, 618, 2, 'San', 1, 0, 0),
(619, 2, 0, 0, 1833.78, -1842.62, 13.5781, -25.77, -141.55, 1003.55, 0, 0, 619, 16, 'UNITY', 0, 0, 0),
(621, 2, 0, 0, 542.128, -1293.89, 17.2422, -1434.08, -526.918, 14.2723, 0, 0, 621, 122, 'Concesionario', 0, 0, 0),
(622, 2, 0, 0, 1488.58, -1772.31, 18.7958, -1248.57, -531.739, 14.925, 0, 0, 622, 4, 'AYUNTAMIENTO', 0, 0, 0),
(624, 2, 0, 0, 1480.98, -1772.31, 18.7958, 1467.93, 1298.5, 26.7484, 0, 0, 624, 20, 'Gobierno', 0, 0, 0),
(625, 2, 0, 0, 1219.21, -1811.71, 16.5938, -1434.08, -526.918, 14.2723, 0, 0, 625, 112, 'Licencias', 0, 0, 0),
(626, 2, 0, 0, 2309.39, -1644, 14.827, 501.99, -67.56, 998.75, 0, 0, 626, 11, 'The', 0, 0, 0),
(629, 1, NULL, 0, -1359.73, -477.884, 18.75, 732.479, -1342.82, 13.5221, 503, 36, 0, 0, 'radiolssalida', 0, 0, 0),
(630, 2, 0, 0, 1679.91, -1826.67, 13.5469, -2240.77, 137.2, 1035.41, 0, 0, 630, 6, 'ElectronicaUnity', 0, 0, 0),
(631, 2, 0, 0, 1679.91, -1811.37, 13.5391, 207.63, -111.26, 1005.13, 0, 0, 631, 15, 'RopaUnity', 0, 0, 0),
(632, 2, 0, 0, 2091.31, -1905.61, 13.5469, 501.99, -67.56, 998.75, 0, 0, 632, 11, 'LicoleriaIdlewood', 0, 0, 0),
(633, 2, 0, 0, 2440.55, -2103.57, 13.5469, -2026.86, -103.6, 1035.18, 0, 0, 633, 3, 'Oficina|Camioneros', 0, 0, 0),
(634, 2, 0, 0, 1329.22, -984.882, 33.8966, -1423.68, -543.74, 14.4183, 0, 0, 634, 12, 'BANCO|LS', 0, 0, 0),
(635, 1, NULL, 0, -1442.21, -539.92, 14.4109, -1453.89, -552.275, 14.5286, 634, 12, 634, 12, 'cajasfuertes', 0, 0, 0),
(636, 1, NULL, 0, -1354.55, -463.928, 18.75, 649.276, -1357.51, 13.5683, 503, 36, 0, 0, 'radiols', 0, 0, 0),
(637, 2, 0, 0, 1743.02, -1864.46, 13.5738, 1494.36, 1303.57, 1093.28, 0, 0, 637, 3, 'oficina', 0, 0, 0),
(661, 2, 0, 0, -1171.83, -942.099, 129.219, -1426.14, 928.44, 1036.35, 0, 0, 661, 15, 'a', 0, 0, 0),
(662, 2, 0, 0, 2616.8, 2713.42, 36.5386, 773.57, -78.12, 1000.88, 0, 0, 662, 7, 'a', 0, 0, 0),
(663, 1, NULL, 0, 767.195, -72.3555, 1000.66, 764.247, -68.707, 1001.57, 662, 7, 662, 7, 'a', 0, 0, 0),
(664, 1, 15000, 209, 1898.5, -2003.84, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 664, 1, 'Bloques|Corona|1', 0, 0, 0),
(665, 3, 15000, 0, 1900.3, -2003.84, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 665, 1, 'Bloque|Corona2', 1, 0, 0),
(666, 3, 15000, 0, 1913.95, -2019.65, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 666, 1, 'Bloque|Corona3', 1, 0, 0),
(668, 3, 15000, 0, 1901.33, -2021.41, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 668, 1, 'Bloque|Corona5', 1, 0, 0),
(669, 3, 15000, 0, 1907.74, -2035.05, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 669, 1, 'Bloque|Corona4', 1, 0, 0),
(670, 3, 15000, 0, 1898.37, -2028.42, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 670, 1, 'Bloque|Corona5', 1, 0, 0),
(671, 3, 15000, 0, 1895.53, -2021.35, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 671, 1, 'Bloque|Corona6', 1, 0, 0),
(672, 3, 15000, 0, 1895.53, -2019.66, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 672, 1, 'Bloque|Corona7', 1, 0, 0),
(673, 3, 15000, 0, 1870.76, -2021.42, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 673, 1, 'Bloque|Corona8', 1, 0, 0),
(674, 3, 15000, 0, 1870.76, -2019.68, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 674, 1, 'Bloque|Corona9', 1, 0, 0),
(675, 3, 15000, 0, 1868.35, -2037.97, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 675, 1, 'Bloque|Corona10', 1, 0, 0),
(676, 3, 15000, 0, 1858.78, -2035.04, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 676, 1, 'Bloque|Corona11', 1, 0, 0),
(677, 3, 15000, 0, 1849.5, -2028.42, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 677, 1, 'Bloque|Corona12', 1, 0, 0),
(678, 1, 15000, 216, 1852.33, -2021.46, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 678, 1, 'Bloque|Corona13', 0, 0, 0),
(679, 3, 15000, 0, 1864.95, -2019.63, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 679, 1, 'Bloque|Corona14', 1, 0, 0),
(680, 3, 15000, 0, 1849.47, -2010.06, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 680, 1, 'Bloque|Corona15', 1, 0, 0),
(681, 3, 15000, 0, 1838.7, -1995.91, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 681, 1, 'Bloque|Corona16', 1, 0, 0),
(682, 3, 15000, 0, 1838.7, -1994.23, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 682, 1, 'Bloque|Corona17', 1, 0, 0),
(683, 3, 15000, 0, 1835.24, -1977.52, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 683, 1, 'Bloque|Corona18', 1, 0, 0),
(684, 3, 15000, 0, 1835.86, -1987.13, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 684, 1, 'Bloque|Corona19', 1, 0, 0),
(685, 3, 15000, 0, 1832.9, -1994.12, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 685, 1, 'Bloque|Corona20', 1, 0, 0),
(686, 3, 15000, 0, 1820.28, -1995.88, 13.5544, 223.07, 1287.09, 1082.14, 0, 0, 686, 1, 'Bloque|Corona21', 1, 0, 0),
(687, 3, 15000, 0, 1826.47, -1980.5, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 687, 1, 'Bloque|Corona22', 1, 0, 0),
(688, 3, 15000, 0, 1817.37, -1987.13, 13.5544, 223.07, 1287.09, 1082.14, 0, 0, 688, 1, 'Bloque|Corona23', 1, 0, 0),
(689, 3, 15000, 0, 1816.89, -1977.61, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 689, 1, 'Bloque|Corona24', 1, 0, 0),
(690, 3, 15000, 0, 1814.48, -1994.26, 13.5544, 223.07, 1287.09, 1082.14, 0, 0, 690, 1, 'Bloque|Corona25', 1, 0, 0),
(691, 3, 15000, 0, 1814.48, -1995.96, 13.5544, 223.07, 1287.09, 1082.14, 0, 0, 691, 1, 'Bloque|Corona26', 1, 0, 0),
(692, 3, 15000, 0, 1817.38, -2005.49, 13.5544, 223.07, 1287.09, 1082.14, 0, 0, 692, 1, 'Bloque|Corona27', 1, 0, 0),
(693, 3, 15000, 0, 1835.72, -2005.49, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 693, 1, 'Bloque|Corona28', 1, 0, 0),
(694, 3, 15000, 0, 1846.53, -2019.76, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 694, 1, 'Bloque|Corona29', 1, 0, 0),
(695, 3, 15000, 0, 1846.53, -2021.39, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 695, 1, 'Bloque|Corona30', 1, 0, 0),
(696, 3, 15000, 0, 1849.99, -2037.94, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 696, 1, 'Bloque|Corona31', 1, 0, 0),
(697, 3, 15000, 0, 1857.05, -2040.85, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 697, 1, 'Bloque|Corona32', 1, 0, 0),
(698, 3, 15000, 0, 1858.75, -2040.85, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 698, 1, 'Bloque|Corona33', 1, 0, 0),
(699, 3, 15000, 0, 1867.79, -2028.42, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 699, 1, 'Bloque|Corona34', 1, 0, 0),
(700, 3, 15000, 0, 1888.93, -2000.89, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 700, 1, 'Bloque|Corona35', 1, 0, 0),
(701, 3, 15000, 0, 1888.93, -1982.47, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 701, 1, 'Bloque|Corona36', 1, 0, 0),
(702, 3, 15000, 0, 1900.21, -1998.04, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 702, 1, 'Bloque|Corona37', 1, 0, 0),
(703, 3, 15000, 0, 1898.42, -1985.42, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 703, 1, 'Bloque|Corona38', 1, 0, 0),
(704, 3, 15000, 0, 1913.91, -1991.53, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 704, 1, 'Bloque|Corona39', 1, 0, 0),
(705, 3, 15000, 0, 1907.28, -1982.66, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 705, 1, 'Bloque|Corona40', 1, 0, 0),
(706, 3, 15000, 0, 1907.28, -2000.9, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 706, 1, 'Bloque|Corona41', 1, 0, 0),
(707, 3, 15000, 0, 1898.49, -2010.06, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 707, 1, 'Bloque|Corona42', 1, 0, 0),
(708, 3, 15000, 0, 1917.35, -2038.01, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 708, 1, 'Bloque|Corona43', 1, 0, 0),
(709, 3, 15000, 0, 1919.76, -2021.26, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 709, 1, 'Bloque|Corona44', 1, 0, 0),
(710, 3, 15000, 0, 1919.76, -2019.67, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 710, 1, 'Bloque|Corona45', 1, 0, 0),
(711, 3, 15000, 0, 1916.8, -2010.06, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 711, 1, 'Bloque|Corona46', 1, 0, 0),
(712, 3, 15000, 0, 1916.79, -2000.38, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 712, 1, 'Bloque|Corona47', 1, 0, 0),
(713, 3, 15000, 0, 1919.72, -1993.38, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 713, 1, 'Bloque|Corona48', 1, 0, 0),
(714, 3, 15000, 0, 1919.72, -1991.71, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 714, 1, 'Bloque|Corona49', 1, 0, 0),
(715, 3, 15000, 0, 1916.91, -1982.03, 13.5469, 223.07, 1287.09, 1082.14, 0, 0, 715, 1, 'Bloque|Corona50', 1, 0, 0),
(716, 2, 0, 0, 1993.57, -1761.95, 13.5391, -1328.05, -552.334, 14.1799, 0, 0, 716, 15, 'Ferreteria', 0, 0, 0),
(719, 2, 0, 0, 1102.41, -1440.13, 15.7969, 204.32, -168.85, 1000.52, 0, 0, 719, 14, 'Tienda|RopaUnica', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventarios`
--

CREATE TABLE `inventarios` (
  `ID_inventario` int(11) NOT NULL,
  `personajeID` int(11) NOT NULL,
  `rap1` text NOT NULL,
  `rap2` text NOT NULL,
  `rap3` text NOT NULL,
  `rap4` text NOT NULL,
  `pecho` text NOT NULL,
  `espalda` text NOT NULL,
  `bols1` text NOT NULL,
  `bols2` text NOT NULL,
  `bols3` text NOT NULL,
  `bols4` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventarios`
--

INSERT INTO `inventarios` (`ID_inventario`, `personajeID`, `rap1`, `rap2`, `rap3`, `rap4`, `pecho`, `espalda`, `bols1`, `bols2`, `bols3`, `bols4`) VALUES;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jails`
--

CREATE TABLE `jails` (
  `id` int(255) NOT NULL,
  `personaje_id` int(255) NOT NULL,
  `created_at` int(100) DEFAULT NULL,
  `updated_at` int(100) DEFAULT NULL,
  `tiempo` int(100) NOT NULL,
  `razon` varchar(100) NOT NULL,
  `jaileado_por` int(255) NOT NULL,
  `tipo` tinyint(10) NOT NULL DEFAULT '0' COMMENT '1-admin,0-policia'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `jails`
--

INSERT INTO `jails` (`id`, `personaje_id`, `created_at`, `updated_at`, `tiempo`, `razon`, `jaileado_por`, `tipo`) VALUES
(3, 215, 1612827868, 1612827993, 20, 'Descuento.', 204, 1),
(6, 260, 1612831247, 1612831372, 300, 'Troll, evadir rol.', 231, 1),
(8, 246, 1612844282, 1612844429, 100, 'aprende a rolear', 209, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licencias_retiradas`
--

CREATE TABLE `licencias_retiradas` (
  `tiempo` int(11) NOT NULL,
  `idchar` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maleteros`
--

CREATE TABLE `maleteros` (
  `h1` json DEFAULT NULL,
  `h2` json DEFAULT NULL,
  `h3` json DEFAULT NULL,
  `h4` json DEFAULT NULL,
  `h5` json DEFAULT NULL,
  `h6` json DEFAULT NULL,
  `h7` json DEFAULT NULL,
  `h8` json DEFAULT NULL,
  `h9` json DEFAULT NULL,
  `h10` json DEFAULT NULL,
  `h11` json DEFAULT NULL,
  `h12` json DEFAULT NULL,
  `h13` json DEFAULT NULL,
  `h14` json DEFAULT NULL,
  `h15` json DEFAULT NULL,
  `rec1` json DEFAULT NULL,
  `rec2` json DEFAULT NULL,
  `vehid` text DEFAULT NULL,
  `id` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `maleteros`
--

INSERT INTO `maleteros` (`h1`, `h2`, `h3`, `h4`, `h5`, `h6`, `h7`, `h8`, `h9`, `h10`, `h11`, `h12`, `h13`, `h14`, `h15`, `rec1`, `rec2`, `vehid`, `id`) VALUES;

INSERT INTO `maleteros` (`h1`, `h2`, `h3`, `h4`, `h5`, `h6`, `h7`, `h8`, `h9`, `h10`, `h11`, `h12`, `h13`, `h14`, `h15`, `rec1`, `rec2`, `vehid`, `id`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapas`
--

CREATE TABLE `mapas` (
  `mapID` int(10) UNSIGNED NOT NULL,
  `mapName` varchar(255) NOT NULL,
  `mapDimension` int(10) NOT NULL DEFAULT '0',
  `protected` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `map_objects`
--

CREATE TABLE `map_objects` (
  `objectID` int(10) NOT NULL,
  `mapID` int(10) NOT NULL,
  `model` int(10) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `interior` int(10) NOT NULL,
  `alpha` int(10) NOT NULL DEFAULT '255',
  `doublesided` int(10) NOT NULL DEFAULT '0',
  `scale` int(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `multas`
--

CREATE TABLE `multas` (
  `cantidad` int(11) NOT NULL,
  `motivo` text NOT NULL,
  `agente` text NOT NULL,
  `pagada` int(11) NOT NULL,
  `fecha` text NOT NULL,
  `idchar` int(11) NOT NULL,
  `idmulta` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `multas`
--

INSERT INTO `multas` (`cantidad`, `motivo`, `agente`, `pagada`, `fecha`, `idchar`, `idmulta`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_facciones`
--

CREATE TABLE `pagos_facciones` (
  `character_id` int(255) NOT NULL,
  `faction_id` int(255) NOT NULL,
  `amount` int(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pagos_facciones`
--

INSERT INTO `pagos_facciones` (`character_id`, `faction_id`, `amount`, `created_at`) VALUES;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_concesionario`
--

CREATE TABLE `pedidos_concesionario` (
  `id` int(255) NOT NULL,
  `personaje_id` int(255) NOT NULL,
  `modelo` int(10) NOT NULL,
  `precio` int(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pedidos_concesionario`
--

INSERT INTO `pedidos_concesionario` (`id`, `personaje_id`, `modelo`, `precio`, `created_at`, `updated_at`) VALUES
(39, 209, 560, 100000, '2021-02-07 21:23:25', '2021-02-07 21:23:25'),
(40, 209, 560, 100000, '2021-02-07 21:23:25', '2021-02-07 21:23:25'),
(42, 231, 561, 17000, '2021-02-07 21:52:35', '2021-02-07 21:52:35'),
(43, 231, 561, 17000, '2021-02-07 21:52:39', '2021-02-07 21:52:39'),
(44, 231, 561, 17000, '2021-02-07 21:52:39', '2021-02-07 21:52:39'),
(45, 231, 561, 17000, '2021-02-07 21:52:39', '2021-02-07 21:52:39'),
(48, 201, 560, 100000, '2021-02-08 12:29:36', '2021-02-08 12:29:36'),
(49, 201, 560, 100000, '2021-02-08 12:29:40', '2021-02-08 12:29:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personajes`
--

CREATE TABLE `personajes` (
  `ID` int(100) NOT NULL,
  `userID` int(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `skin` int(10) NOT NULL,
  `dni` varchar(10) NOT NULL,
  `edad` int(10) NOT NULL,
  `altura` int(10) NOT NULL,
  `vida` int(10) NOT NULL DEFAULT '100',
  `chaleco` int(10) NOT NULL DEFAULT '0',
  `hambre` int(10) NOT NULL DEFAULT '100',
  `sed` int(10) NOT NULL DEFAULT '100',
  `cansancio` int(10) NOT NULL DEFAULT '100',
  `dinero` int(100) NOT NULL DEFAULT '500',
  `dineroprestamo` int(100) NOT NULL DEFAULT '0',
  `ck` int(10) NOT NULL DEFAULT '0',
  `timestamp` int(100) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '1715.83',
  `y` float NOT NULL DEFAULT '-1928.48',
  `z` float NOT NULL DEFAULT '13.5665',
  `rot` float NOT NULL DEFAULT '180',
  `interior` int(10) NOT NULL DEFAULT '0',
  `dimension` int(10) NOT NULL DEFAULT '0',
  `yo` text,
  `cabeza` int(10) NOT NULL DEFAULT '0',
  `raza` int(10) NOT NULL DEFAULT '0',
  `ropa1` int(10) NOT NULL DEFAULT '0',
  `ropa2` int(10) NOT NULL DEFAULT '0',
  `ropa3` int(10) NOT NULL DEFAULT '0',
  `fitness` int(10) NOT NULL DEFAULT '0',
  `fatness` int(10) NOT NULL DEFAULT '0',
  `EP` int(10) NOT NULL DEFAULT '1',
  `farmeado` int(255) NOT NULL DEFAULT '0',
  `job` varchar(100) DEFAULT NULL,
  `pendiente_borrar` tinyint(10) NOT NULL DEFAULT '0',
  `licencias` int(11) NOT NULL,
  `puntos_coche` int(11) NOT NULL,
  `estilocaminar` int(11) NOT NULL,
  `items:cargarItems` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `personajes`
--

INSERT INTO `personajes` (`ID`, `userID`, `nombre`, `skin`, `dni`, `edad`, `altura`, `vida`, `chaleco`, `hambre`, `sed`, `cansancio`, `dinero`, `dineroprestamo`, `ck`, `timestamp`, `x`, `y`, `z`, `rot`, `interior`, `dimension`, `yo`, `cabeza`, `raza`, `ropa1`, `ropa2`, `ropa3`, `fitness`, `fatness`, `EP`, `farmeado`, `job`, `pendiente_borrar`, `licencias`, `puntos_coche`, `estilocaminar`, `items:cargarItems`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `phones`
--

CREATE TABLE `phones` (
  `phone` int(255) NOT NULL,
  `activo` int(255) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `phones`
--

INSERT INTO `phones` (`phone`, `activo`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pjs_en_facciones`
--

CREATE TABLE `pjs_en_facciones` (
  `id` int(100) NOT NULL,
  `id_personaje` int(100) NOT NULL,
  `id_faccion` int(100) NOT NULL,
  `derecho` int(100) NOT NULL DEFAULT '0',
  `rango` int(100) NOT NULL DEFAULT '0',
  `sueldo` int(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pjs_en_facciones`
--

INSERT INTO `pjs_en_facciones` (`id`, `id_personaje`, `id_faccion`, `derecho`, `rango`, `sueldo`) VALUES;

-- -------------------------------------------------------
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rangos_facciones`
--

CREATE TABLE `rangos_facciones` (
  `id` int(100) NOT NULL,
  `id_faccion` int(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `pos` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rangos_facciones`
--

INSERT INTO `rangos_facciones` (`id`, `id_faccion`, `nombre`, `pos`) VALUES
(10, 2, 'De baja', 1),
(21, 1, 'Conserje', 1),
(29, 1, '(A) Auxiliar', 2),
(30, 1, '(M) Medico', 3),
(31, 1, '(E) Enfermero', 4),
(32, 1, '(G) Tecnico', 5),
(33, 1, '(C) Cabo', 6),
(34, 1, '(Y) Subteniente', 7),
(35, 1, '(T) Teniente', 8),
(36, 1, '(S) Supervisor sanitario', 9),
(37, 1, '(J) Jefe sanitario', 10),
(38, 1, '(D) Subdirector sanitario', 11),
(39, 1, '(D) Director sanitario', 12),
(40, 3, 'De baja', 1),
(41, 4, 'De baja', 2),
(42, 3, 'Taxista', 3),
(43, 3, 'Supervisor', 4),
(44, 3, 'Subdirector', 5),
(45, 3, 'Director', 6),
(47, 4, 'De baja', 2),
(49, 4, 'Auscencia just.', 3),
(50, 3, 'Taxista en prueba', 2),
(51, 4, 'Aprendiz', 4),
(52, 4, 'Mecanico', 5),
(53, 5, 'De baja', 1),
(54, 6, 'De baja', 1),
(55, 7, 'De baja', 1),
(56, 4, 'Mecanico destacado', 6),
(57, 4, 'Mecanico del mes', 7),
(58, 7, 'Ausencia justificada', 2),
(59, 7, 'Estudiante', 3),
(60, 7, 'Locutor', 4),
(61, 7, 'Redactor', 5),
(62, 7, 'Locutor avanzado', 6),
(63, 7, 'Redactor avanzado', 7),
(64, 7, 'Supervisor', 8),
(65, 7, 'Recursos humanos', 9),
(66, 7, 'Sub director', 10),
(67, 7, 'Director', 11),
(68, 6, 'Camionero', 2),
(69, 6, 'Camionero II', 3),
(70, 6, 'Camionero III', 4),
(71, 1, 'Conserje', 13),
(72, 8, 'De baja', 1),
(73, 6, 'Camionero en jefe', 5),
(74, 6, 'Recursos humanos', 6),
(75, 6, 'Sub director', 7),
(76, 6, 'Director', 8),
(77, 4, 'Supervisor', 8),
(78, 8, 'Presidente Ejecutivo', 2),
(79, 8, 'VicePresidente Ejecutivo', 3),
(80, 8, 'Director Ejecutivo', 4),
(81, 8, 'Director General', 5),
(82, 8, 'Director De Seguridad', 6),
(83, 8, 'A.E.C', 7),
(84, 8, 'Agente Especial', 8),
(85, 8, 'Agente', 9),
(86, 8, 'Recluta', 10),
(87, 4, 'Encargado', 9),
(88, 4, 'DueÃ±o', 10),
(89, 6, 'Ausencia injustificada', 9),
(91, 2, 'Cadete | AGP', 2),
(92, 2, 'Oficial I', 3),
(93, 2, 'Oficial II', 4),
(94, 2, 'Oficial III', 5),
(95, 2, 'Oficial III LÃ­der', 6),
(96, 2, 'Sargento I', 7),
(97, 2, 'Sargento II', 8),
(98, 2, 'Sargento III', 9),
(99, 2, 'Teniente I', 10),
(100, 2, 'Teniente II', 11),
(101, 2, 'CapitÃ¡n I', 12),
(102, 2, 'CapitÃ¡n II', 13),
(103, 2, 'CapitÃ¡n III', 14),
(104, 2, 'Comandante', 15),
(105, 2, 'Jefe Adjunto', 16),
(106, 2, 'Jefe de PolicÃ­a', 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recipientes`
--

CREATE TABLE `recipientes` (
  `id` int(100) NOT NULL,
  `owner` int(100) NOT NULL,
  `tipo` int(100) NOT NULL,
  `pos` int(10) NOT NULL,
  `i1` text NOT NULL,
  `i2` text NOT NULL,
  `i3` text NOT NULL,
  `i4` text NOT NULL,
  `i5` text NOT NULL,
  `i6` text NOT NULL,
  `i7` text NOT NULL,
  `i8` text NOT NULL,
  `i9` text NOT NULL,
  `i10` text NOT NULL,
  `i11` text NOT NULL,
  `i12` text NOT NULL,
  `i13` text NOT NULL,
  `i14` text NOT NULL,
  `i15` text NOT NULL,
  `maletero` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `recipientes`
--

INSERT INTO `recipientes` (`id`, `owner`, `tipo`, `pos`, `i1`, `i2`, `i3`, `i4`, `i5`, `i6`, `i7`, `i8`, `i9`, `i10`, `i11`, `i12`, `i13`, `i14`, `i15`, `maletero`) VALUES
(56, 212, 2, 2, '[ [ 4, 2 ] ]', '[ [ 1, 1 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', 1),
(79, 212, 2, 2, '[ [ 2, 1 ] ]', '[ [ 0, 0 ] ]', '[ [ 10, 10 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', 1),
(107, 261, 2, 2, '[ [ 4, 5 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', '[ [ 0, 0 ] ]', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrocepo`
--

CREATE TABLE `registrocepo` (
  `idveh` int(11) NOT NULL,
  `agente` text NOT NULL,
  `fecha` text NOT NULL,
  `tipo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `registrocepo`
--

INSERT INTO `registrocepo` (`idveh`, `agente`, `fecha`, `tipo`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registropresos`
--

CREATE TABLE `registropresos` (
  `idchar` int(255) NOT NULL,
  `tiempo` int(255) NOT NULL,
  `motivo` text NOT NULL,
  `fecha` int(255) NOT NULL,
  `agente` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `registropresos`
--

INSERT INTO `registropresos` (`idchar`, `tiempo`, `motivo`, `fecha`, `agente`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrosfacc`
--

CREATE TABLE `registrosfacc` (
  `tipo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `encargado` text NOT NULL,
  `id_faccion` int(255) NOT NULL,
  `fecha` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `registrosfacc`
--

INSERT INTO `registrosfacc` (`tipo`, `cantidad`, `encargado`, `id_faccion`, `fecha`) VALUES
(2, 1, 'Ethan_Johnson', 1, 1605812727),
(2, 40000, 'Butch_Sullivan', 2, 1605772845),
(1, 100, 'Tomas_Neus', 3, 1605753829),
(2, 4000, 'Anthony_Harris', 4, 1606617431),
(2, 25000, 'Staff_Letiel', 5, 1606686438),
(2, 3400, 'Anthony_Harris', 6, 1611117691),
(2, 2500, 'Alexander_Sulejmani', 7, 1606715642);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrosueldos`
--

CREATE TABLE `registrosueldos` (
  `encargado` text NOT NULL,
  `fecha` int(11) NOT NULL,
  `sueldo` int(11) NOT NULL,
  `id_faccion` int(11) NOT NULL,
  `empleado` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `registrosueldos`
--

INSERT INTO `registrosueldos` (`encargado`, `fecha`, `sueldo`, `id_faccion`, `empleado`) VALUES;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_bancarios`
--

CREATE TABLE `registros_bancarios` (
  `id` int(100) NOT NULL,
  `id_cuenta_bancaria` int(255) NOT NULL DEFAULT '0',
  `operacion` varchar(100) DEFAULT NULL,
  `cantidad` int(100) NOT NULL DEFAULT '0',
  `concepto` text,
  `fecha` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `registros_bancarios`
--

INSERT INTO `registros_bancarios` (`id`, `id_cuenta_bancaria`, `operacion`, `cantidad`, `concepto`, `fecha`) VALUES
(1, 9, 'DepÃ³sito', 1340, 'Concepto', '[ [ 19, 10, 2020, 11, 29 ] ]'),
(2, 2, 'DepÃ³sito', 500, 'Concepto', '[ [ 28, 10, 2020, 18, 52 ] ]'),
(3, 2, 'Retirada', -100, 'Concepto', '[ [ 28, 10, 2020, 18, 56 ] ]'),
(4, 2, 'Retirada', -400, 'Concepto', '[ [ 28, 10, 2020, 19, 7 ] ]'),
(5, 2, 'DepÃ³sito', 3490, 'Concepto', '[ [ 28, 10, 2020, 19, 59 ] ]'),
(6, 5, 'DepÃ³sito', 100, 'Prueba', '[ [ 29, 10, 2020, 21, 37 ] ]'),
(7, 3, 'DepÃ³sito', 6000, 'Ahorro', '[ [ 29, 10, 2020, 21, 37 ] ]'),
(8, 7, 'DepÃ³sito', 1500, 'Ahorro', '[ [ 30, 10, 2020, 16, 17 ] ]'),
(9, 3, 'DepÃ³sito', 300, 'Ahorro', '[ [ 1, 11, 2020, 14, 14 ] ]'),
(10, 3, 'DepÃ³sito', 900, 'Ahorro', '[ [ 2, 11, 2020, 18, 45 ] ]'),
(11, 7, 'DepÃ³sito', 2600, 'Ahorro', '[ [ 2, 11, 2020, 18, 45 ] ]'),
(12, 9, 'DepÃ³sito', 1500, 'padre', '[ [ 2, 11, 2020, 18, 47 ] ]'),
(13, 8, 'DepÃ³sito', 1500, 'ahorros', '[ [ 2, 11, 2020, 18, 47 ] ]'),
(14, 11, 'DepÃ³sito', 4100, 'Paga', '[ [ 9, 11, 2020, 15, 44 ] ]'),
(15, 8, 'DepÃ³sito', 300, 'Deposito', '[ [ 9, 11, 2020, 15, 45 ] ]'),
(16, 12, 'DepÃ³sito', 12200, 'Concepto', '[ [ 9, 11, 2020, 16, 2 ] ]'),
(17, 12, 'Retirada', -300, 'Concepto', '[ [ 9, 11, 2020, 17, 45 ] ]'),
(18, 12, 'Retirada', -10000, 'Concepto', '[ [ 10, 11, 2020, 22, 7 ] ]'),
(19, 12, 'DepÃ³sito', 10000, 'Concepto', '[ [ 10, 11, 2020, 22, 7 ] ]'),
(20, 12, 'Retirada', -10000, 'Concepto', '[ [ 10, 11, 2020, 22, 7 ] ]'),
(21, 8, 'DepÃ³sito', 300, 'Ahorros', '[ [ 11, 11, 2020, 8, 40 ] ]'),
(22, 14, 'DepÃ³sito', 3737, 'a', '[ [ 11, 11, 2020, 9, 2 ] ]'),
(23, 14, 'Retirada', -300, 'Concepto', '[ [ 11, 11, 2020, 9, 23 ] ]'),
(24, 8, 'Retirada', -2100, 'A', '[ [ 11, 11, 2020, 13, 8 ] ]'),
(25, 5, 'DepÃ³sito', 3, '3', '[ [ 13, 11, 2020, 10, 40 ] ]'),
(26, 14, 'DepÃ³sito', 3110, 'a', '[ [ 18, 0, 2021, 15, 20 ] ]'),
(27, 19, 'DepÃ³sito', 1000, 'aho', '[ [ 21, 0, 2021, 13, 1 ] ]'),
(28, 19, 'DepÃ³sito', 78, 'Concepto', '[ [ 21, 0, 2021, 13, 1 ] ]'),
(29, 19, 'Retirada', -200, 'Concepto', '[ [ 21, 0, 2021, 13, 13 ] ]'),
(30, 16, 'DepÃ³sito', 6000, 'Ahorro auto', '[ [ 23, 0, 2021, 10, 55 ] ]'),
(31, 18, 'DepÃ³sito', 3700, 'Concepto', '[ [ 23, 0, 2021, 11, 4 ] ]'),
(32, 16, 'Retirada', -6000, 'a', '[ [ 23, 0, 2021, 11, 11 ] ]'),
(33, 20, 'DepÃ³sito', 1800, 'Concepto', '[ [ 23, 0, 2021, 11, 21 ] ]'),
(34, 16, 'DepÃ³sito', 1670, 'Concepto', '[ [ 23, 0, 2021, 12, 2 ] ]'),
(35, 18, 'Retirada', -150, 'Concepto', '[ [ 23, 0, 2021, 13, 48 ] ]'),
(36, 22, 'DepÃ³sito', 200, 'Concepto', '[ [ 28, 0, 2021, 22, 19 ] ]'),
(37, 23, 'DepÃ³sito', 444, '444', '[ [ 28, 0, 2021, 22, 24 ] ]'),
(38, 25, 'DepÃ³sito', 1000, 'Concepto', '[ [ 7, 1, 2021, 0, 22 ] ]'),
(39, 26, 'DepÃ³sito', 6000, 'sorteo', '[ [ 7, 1, 2021, 0, 44 ] ]'),
(40, 28, 'DepÃ³sito', 200, '', '[ [ 7, 1, 2021, 1, 24 ] ]'),
(41, 28, 'DepÃ³sito', 700, '', '[ [ 7, 1, 2021, 1, 24 ] ]'),
(42, 29, 'DepÃ³sito', 200, '200', '[ [ 7, 1, 2021, 1, 52 ] ]'),
(43, 29, 'DepÃ³sito', 500, '500', '[ [ 7, 1, 2021, 1, 52 ] ]'),
(44, 26, 'DepÃ³sito', 11000, 'bug', '[ [ 7, 1, 2021, 2, 22 ] ]'),
(45, 26, 'Retirada', -17000, 'coche', '[ [ 7, 1, 2021, 3, 18 ] ]'),
(46, 28, 'DepÃ³sito', 5800, 'Concepto', '[ [ 7, 1, 2021, 4, 5 ] ]'),
(47, 29, 'DepÃ³sito', 5706, '5706', '[ [ 7, 1, 2021, 4, 5 ] ]'),
(48, 26, 'DepÃ³sito', 9000, 'sueldo', '[ [ 7, 1, 2021, 6, 41 ] ]'),
(49, 33, 'DepÃ³sito', 6326, 'porque si brot', '[ [ 7, 1, 2021, 6, 41 ] ]'),
(50, 33, 'Retirada', -6326, 'porque si brot', '[ [ 7, 1, 2021, 6, 41 ] ]'),
(51, 33, 'DepÃ³sito', 6326, 'porque si brot', '[ [ 7, 1, 2021, 6, 41 ] ]'),
(52, 32, 'DepÃ³sito', 8000, 'depositar', '[ [ 7, 1, 2021, 6, 41 ] ]'),
(53, 33, 'Retirada', -6326, 'porque si brot', '[ [ 7, 1, 2021, 6, 42 ] ]'),
(54, 33, 'DepÃ³sito', 6326, 'porque si brot', '[ [ 7, 1, 2021, 6, 42 ] ]'),
(55, 28, 'DepÃ³sito', 6346, 'Concepto', '[ [ 7, 1, 2021, 9, 52 ] ]'),
(56, 31, 'DepÃ³sito', 6599, 'Concepto', '[ [ 7, 1, 2021, 18, 41 ] ]'),
(57, 28, 'DepÃ³sito', 6372, 'Concepto', '[ [ 7, 1, 2021, 18, 42 ] ]'),
(58, 34, 'DepÃ³sito', 6000, 'Ahorro.', '[ [ 7, 1, 2021, 19, 3 ] ]'),
(59, 29, 'DepÃ³sito', 6000, '6000', '[ [ 7, 1, 2021, 19, 20 ] ]'),
(60, 34, 'DepÃ³sito', 6800, 'Concepto', '[ [ 7, 1, 2021, 20, 3 ] ]'),
(61, 32, 'DepÃ³sito', 6000, 'Concepto', '[ [ 7, 1, 2021, 20, 5 ] ]'),
(62, 31, 'DepÃ³sito', 6270, 'Concepto', '[ [ 7, 1, 2021, 20, 29 ] ]'),
(63, 36, 'DepÃ³sito', 400, '5', '[ [ 7, 1, 2021, 20, 35 ] ]'),
(64, 28, 'Retirada', -60, 'Concepto', '[ [ 7, 1, 2021, 21, 12 ] ]'),
(65, 28, 'DepÃ³sito', 30, 'Concepto', '[ [ 7, 1, 2021, 21, 15 ] ]'),
(66, 28, 'Retirada', -30, 'Concepto', '[ [ 7, 1, 2021, 21, 15 ] ]'),
(67, 28, 'Retirada', -30, 'Concepto', '[ [ 7, 1, 2021, 21, 15 ] ]'),
(68, 34, 'DepÃ³sito', 1600, 'Concepto', '[ [ 7, 1, 2021, 21, 23 ] ]'),
(69, 26, 'Retirada', -60, 'multa', '[ [ 7, 1, 2021, 21, 36 ] ]'),
(70, 26, 'Retirada', -5000, 'sen', '[ [ 7, 1, 2021, 21, 50 ] ]'),
(71, 31, 'Retirada', -12800, 'Concepto', '[ [ 7, 1, 2021, 21, 54 ] ]'),
(72, 37, 'DepÃ³sito', 1000, 'Ahorro', '[ [ 7, 1, 2021, 22, 6 ] ]'),
(73, 33, 'DepÃ³sito', 6122, 'Po', '[ [ 7, 1, 2021, 23, 14 ] ]'),
(74, 38, 'DepÃ³sito', 50000, 'Ingresar', '[ [ 7, 1, 2021, 23, 39 ] ]'),
(75, 34, 'Retirada', -14000, 'Concepto', '[ [ 7, 1, 2021, 23, 51 ] ]'),
(76, 33, 'Retirada', -130, 'Concepto', '[ [ 8, 1, 2021, 0, 2 ] ]'),
(77, 29, 'Retirada', -500, '500', '[ [ 8, 1, 2021, 0, 35 ] ]'),
(78, 28, 'DepÃ³sito', 6300, 'Concepto', '[ [ 8, 1, 2021, 1, 17 ] ]'),
(79, 28, 'DepÃ³sito', 6369, 'Concepto', '[ [ 8, 1, 2021, 1, 55 ] ]'),
(80, 28, 'Retirada', -20, 'Concepto', '[ [ 8, 1, 2021, 1, 55 ] ]'),
(81, 28, 'DepÃ³sito', 1000, 'Concepto', '[ [ 8, 1, 2021, 1, 56 ] ]'),
(82, 33, 'Retirada', -100, 'Concepto', '[ [ 8, 1, 2021, 2, 57 ] ]'),
(83, 32, 'Retirada', -8000, 'Concepto', '[ [ 8, 1, 2021, 3, 0 ] ]'),
(84, 26, 'Retirada', -3940, 'gg', '[ [ 8, 1, 2021, 3, 10 ] ]'),
(85, 35, 'DepÃ³sito', 500, 'Primera paga', '[ [ 8, 1, 2021, 19, 34 ] ]'),
(86, 28, 'Retirada', -400, 'Concepto', '[ [ 8, 1, 2021, 21, 55 ] ]'),
(87, 28, 'DepÃ³sito', 400, 'Concepto', '[ [ 8, 1, 2021, 21, 55 ] ]'),
(88, 28, 'DepÃ³sito', 400, 'Concepto', '[ [ 8, 1, 2021, 21, 55 ] ]'),
(89, 28, 'Retirada', -1000, 'Concepto', '[ [ 8, 1, 2021, 22, 1 ] ]'),
(90, 37, 'DepÃ³sito', 1300, 'Ahorro', '[ [ 8, 1, 2021, 22, 18 ] ]'),
(91, 34, 'DepÃ³sito', 17240, 'Ahorro', '[ [ 8, 1, 2021, 22, 26 ] ]'),
(92, 34, 'Retirada', -7000, 'Concepto', '[ [ 8, 1, 2021, 22, 47 ] ]'),
(93, 28, 'DepÃ³sito', 50, 'Concepto', '[ [ 9, 1, 2021, 0, 10 ] ]'),
(94, 28, 'Retirada', -50, 'Concepto', '[ [ 9, 1, 2021, 0, 10 ] ]'),
(95, 28, 'Retirada', -50, 'Concepto', '[ [ 9, 1, 2021, 0, 10 ] ]'),
(96, 31, 'DepÃ³sito', 9200, 'Concepto', '[ [ 9, 1, 2021, 1, 30 ] ]'),
(97, 31, 'Retirada', -9200, 'Concepto', '[ [ 9, 1, 2021, 2, 14 ] ]'),
(98, 28, 'Retirada', -50, 'Concepto', '[ [ 9, 1, 2021, 2, 15 ] ]'),
(99, 29, 'DepÃ³sito', 761, '761', '[ [ 9, 1, 2021, 2, 19 ] ]'),
(100, 42, 'DepÃ³sito', 89, 'Concepto', '[ [ 9, 1, 2021, 2, 31 ] ]'),
(101, 42, 'Retirada', -89, 'Concepto', '[ [ 9, 1, 2021, 2, 31 ] ]'),
(102, 41, 'DepÃ³sito', 6700, 'Concepto', '[ [ 9, 1, 2021, 2, 33 ] ]'),
(103, 33, 'Retirada', -100, 'Concepto', '[ [ 9, 1, 2021, 2, 41 ] ]'),
(104, 41, 'Retirada', -100, 'Concepto', '[ [ 9, 1, 2021, 2, 47 ] ]'),
(105, 28, 'Retirada', -30000, 'Concepto', '[ [ 9, 1, 2021, 2, 51 ] ]'),
(106, 26, 'DepÃ³sito', 6500, 'noc', '[ [ 9, 1, 2021, 3, 20 ] ]'),
(107, 33, 'Retirada', -10000, 'Concepto', '[ [ 9, 1, 2021, 3, 29 ] ]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_armeria`
--

CREATE TABLE `registro_armeria` (
  `agente` text NOT NULL,
  `nombre_arma` text NOT NULL,
  `fecha` text NOT NULL,
  `tipo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `registro_armeria`
--

INSERT INTO `registro_armeria` (`agente`, `nombre_arma`, `fecha`, `tipo`) VALUES;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ropas_compradas`
--

CREATE TABLE `ropas_compradas` (
  `personaje_id` int(255) NOT NULL,
  `ropa_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ropas_compradas`
--

INSERT INTO `ropas_compradas` (`personaje_id`, `ropa_id`) VALUES;


-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sms`
--

CREATE TABLE `sms` (
  `id` int(255) NOT NULL,
  `telefono` int(11) NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `destino` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sms`
--

INSERT INTO `sms` (`id`, `telefono`, `mensaje`, `destino`) VALUES;

-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `tiendas`
--

CREATE TABLE `tiendas` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `shop_id` int(100) NOT NULL,
  `skin` int(10) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rot` float NOT NULL,
  `dimension` int(100) NOT NULL,
  `interior` int(100) NOT NULL,
  `linked_int` int(100) NOT NULL DEFAULT '0',
  `materiales` int(11) NOT NULL DEFAULT '150'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tiendas`
--

INSERT INTO `tiendas` (`id`, `name`, `shop_id`, `skin`, `x`, `y`, `z`, `rot`, `dimension`, `interior`, `linked_int`, `materiales`) VALUES
(153, 'electronicaunity', 2, 217, -2237.17, 128.587, 1035.41, 358.838, 630, 6, 0, 49),
(154, 'ropaunity1', 6, 176, 204.021, -101.728, 1005.26, 272.649, 631, 15, 0, 148),
(157, 'ropaunity2', 8, 184, 210.304, -101.71, 1005.26, 91.6631, 631, 15, 0, 149),
(158, 'ropaunity3', 10, 180, 210.436, -105.173, 1005.14, 91.6631, 631, 15, 0, 0),
(159, 'pizzaidlewood', 1, 155, 375.64, -117.278, 1001.49, 181.17, 606, 5, 0, 0),
(160, 'pizzaidlewood2', 1, 155, 377.229, -117.275, 1001.49, 181.758, 606, 5, 0, 135),
(163, 'licoleria1', 1, 179, 496.361, -77.4717, 998.765, 1.17831, 632, 11, 0, 145),
(164, 'ropabinco1', 6, 176, 204.522, -102.06, 1005.26, 269.057, 499, 15, 0, 111),
(165, 'ropabinco2', 8, 184, 210.829, -101.887, 1005.26, 90.4381, 499, 15, 0, 126),
(166, 'ropabinco3', 10, 180, 210.7, -105.524, 1005.14, 98.2275, 499, 15, 0, 129),
(167, 'ropabinco4', 13, 190, 207.769, -98.7051, 1005.26, 179.615, 499, 15, 0, 150),
(168, '24/7', 1, 7, -22.4932, -140.309, 1003.55, 4.36987, 611, 16, 0, 88),
(169, '24/7', 1, 7, -22.1025, -140.315, 1003.55, 358.937, 619, 16, 0, 102),
(170, 'electronica', 2, 2, -22.8027, -140.306, 1003.55, 358.415, 619, 16, 0, 0),
(171, '1', 1, 7, -22.2236, -140.313, 1003.55, 356.685, 610, 16, 0, 138),
(172, '14', 14, 7, 201.529, -159.646, 1000.52, 239.453, 719, 14, 0, 148);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `toys`
--

CREATE TABLE `toys` (
  `CharacterID` int(11) NOT NULL,
  `ToyID` int(11) NOT NULL,
  `ModelID` int(11) NOT NULL,
  `Bone` int(11) NOT NULL,
  `Data` text NOT NULL,
  `Scale` text NOT NULL,
  `Stall` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `toys`
--

INSERT INTO `toys` (`CharacterID`, `ToyID`, `ModelID`, `Bone`, `Data`, `Scale`, `Stall`) VALUES
(197, 1, 1252, 3, '[ [ 0, 0, 0, 0, 0, 0 ] ]', '[ [ 1, 1, 1 ] ]', 1),
(206, 1, 1252, 6, '[ [ 0, -0.2, 0, 0, 0, 0 ] ]', '[ [ 1, 1, 1 ] ]', 1),
(206, 2, 1210, 25, '[ [ 0.2, -0.1, -0.2, 259.2, 360, 154.8 ] ]', '[ [ 1, 1, 1 ] ]', 1),
(209, 1, 18502, 31, '[ [ -0.1, -0.1, 0.2, 0, 0, 255.6 ] ]', '[ [ 1, 1, 1 ] ]', 0),
(204, 1, 18502, 5, '[ [ 0, 0, 0, 0, 0, 0 ] ]', '[ [ 1, 1, 1 ] ]', 0),
(236, 1, 18502, 7, '[ [ 0, -0.1, 0, 0, 82.8, 0 ] ]', '[ [ 1, 1, 1 ] ]', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `remember_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_connection` timestamp NULL DEFAULT NULL,
  `rank` int(10) NOT NULL DEFAULT '1',
  `ban` int(10) NOT NULL DEFAULT '0',
  `avatar` varchar(255) DEFAULT 'avatar.png',
  `mensajes` int(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `remember_token`, `created_at`, `updated_at`, `last_connection`, `rank`, `ban`, `avatar`, `mensajes`) VALUES;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `owner` int(100) NOT NULL,
  `facc` int(10) NOT NULL,
  `modelo` int(10) NOT NULL,
  `vida` int(10) NOT NULL DEFAULT '1000',
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `matricula` varchar(10) NOT NULL,
  `r1` int(10) NOT NULL,
  `g1` int(10) NOT NULL,
  `b1` int(10) NOT NULL,
  `r2` int(10) NOT NULL,
  `g2` int(10) NOT NULL,
  `b2` int(10) NOT NULL,
  `variant1` int(10) NOT NULL DEFAULT '0',
  `variant2` int(10) NOT NULL DEFAULT '0',
  `interior` int(10) NOT NULL,
  `dimension` int(10) NOT NULL,
  `locked` int(10) NOT NULL DEFAULT '1',
  `freno` int(10) NOT NULL DEFAULT '0',
  `luces` int(10) NOT NULL DEFAULT '0',
  `motor` int(10) NOT NULL DEFAULT '0',
  `gas` int(10) NOT NULL DEFAULT '100',
  `cepo` int(11) NOT NULL,
  `id` int(255) NOT NULL,
  `respawnpos` json NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`owner`, `facc`, `modelo`, `vida`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `matricula`, `r1`, `g1`, `b1`, `r2`, `g2`, `b2`, `variant1`, `variant2`, `interior`, `dimension`, `locked`, `freno`, `luces`, `motor`, `gas`, `cepo`, `id`, `respawnpos`) VALUES;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vinculos`
--

--
-- Indices de la tabla `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `capots`
--
ALTER TABLE `capots`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cheques_bancarios`
--
ALTER TABLE `cheques_bancarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `cuentas_bancarias`
--
ALTER TABLE `cuentas_bancarias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facciones`
--
ALTER TABLE `facciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ficha_personajes`
--
--
-- Indices de la tabla `infos`
--
ALTER TABLE `infos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `interiores`
--
ALTER TABLE `interiores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inventarios`
--
ALTER TABLE `inventarios`
  ADD PRIMARY KEY (`ID_inventario`);

--
-- Indices de la tabla `jails`
--
ALTER TABLE `jails`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mapas`
--
ALTER TABLE `mapas`
  ADD PRIMARY KEY (`mapID`);

--
-- Indices de la tabla `map_objects`
--
ALTER TABLE `map_objects`
  ADD PRIMARY KEY (`objectID`);

--
-- Indices de la tabla `multas`
--
ALTER TABLE `multas`
  ADD PRIMARY KEY (`idmulta`);

--
-- Indices de la tabla `pedidos_concesionario`
--
ALTER TABLE `pedidos_concesionario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personajes`
--
ALTER TABLE `personajes`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`phone`);

--
-- Indices de la tabla `pjs_en_facciones`
--
ALTER TABLE `pjs_en_facciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `postulaciones`
--
ALTER TABLE `postulaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indices de la tabla `rangos_facciones`
--
ALTER TABLE `rangos_facciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recipientes`
--
ALTER TABLE `recipientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `registrosfacc`
--
ALTER TABLE `registrosfacc`
  ADD PRIMARY KEY (`id_faccion`);

--
-- Indices de la tabla `registros_bancarios`
--
ALTER TABLE `registros_bancarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `subcategorias`
--
ALTER TABLE `subcategorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tiendas`
--
ALTER TABLE `tiendas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vinculos`
--
ALTER TABLE `vinculos`
  ADD UNIQUE KEY `cuenta_id` (`cuenta_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

 
--
-- AUTO_INCREMENT de la tabla `banks`
--
ALTER TABLE `banks`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `capots`
--
ALTER TABLE `capots`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=671;
 
--
-- AUTO_INCREMENT de la tabla `cheques_bancarios`
--
ALTER TABLE `cheques_bancarios`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=516;
--
-- AUTO_INCREMENT de la tabla `cuentas_bancarias`
--
ALTER TABLE `cuentas_bancarias`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `facciones`
--
ALTER TABLE `facciones`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `infos`
--
ALTER TABLE `infos`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;
--
-- AUTO_INCREMENT de la tabla `interiores`
--
ALTER TABLE `interiores`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=721;
--
-- AUTO_INCREMENT de la tabla `inventarios`
--
ALTER TABLE `inventarios`
  MODIFY `ID_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=292;
--
-- AUTO_INCREMENT de la tabla `jails`
--
ALTER TABLE `jails`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `mapas`
--
ALTER TABLE `mapas`
  MODIFY `mapID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `map_objects`
--
ALTER TABLE `map_objects`
  MODIFY `objectID` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `multas`
--
ALTER TABLE `multas`
  MODIFY `idmulta` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `pedidos_concesionario`
--
ALTER TABLE `pedidos_concesionario`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT de la tabla `personajes`
--
ALTER TABLE `personajes`
  MODIFY `ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=264;
--
-- AUTO_INCREMENT de la tabla `phones`
--
ALTER TABLE `phones`
  MODIFY `phone` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=465843;
--
-- AUTO_INCREMENT de la tabla `pjs_en_facciones`
--
ALTER TABLE `pjs_en_facciones`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;


--
-- AUTO_INCREMENT de la tabla `rangos_facciones`
--
ALTER TABLE `rangos_facciones`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;
--
-- AUTO_INCREMENT de la tabla `recipientes`
--
ALTER TABLE `recipientes`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;
--
-- AUTO_INCREMENT de la tabla `registrosfacc`
--
ALTER TABLE `registrosfacc`
  MODIFY `id_faccion` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `registros_bancarios`
--
ALTER TABLE `registros_bancarios`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT de la tabla `sms`
--
ALTER TABLE `sms`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tiendas`
--
ALTER TABLE `tiendas`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;
--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

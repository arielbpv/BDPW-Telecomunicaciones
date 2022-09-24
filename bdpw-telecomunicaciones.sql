-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-09-2022 a las 01:23:43
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdpw-telecomunicaciones`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `RUTAdmin` varchar(12) NOT NULL COMMENT 'Rut identificador de l administrador',
  `ContraseñaAdmin` varchar(500) NOT NULL COMMENT 'Contraseña identificadora del administrador',
  `IDPlan` tinyint(1) NOT NULL COMMENT 'ID del plan asociado al administrador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla administradores';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administracion`
--

CREATE TABLE `administracion` (
  `IDPlan` tinyint(1) NOT NULL COMMENT 'ID plan asociado',
  `RUTAdmin` varchar(12) NOT NULL COMMENT 'Rut del administrador asociado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla muchos a muchos plan_admin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `RUTCl` varchar(12) NOT NULL COMMENT 'Rut del cliente',
  `Contraseña` varchar(500) NOT NULL COMMENT 'Contraseña de ingreso del cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla clientes';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `IDFactura` int(5) NOT NULL COMMENT 'Identificador de la venta asociada a la factura',
  `Cantidad` int(2) NOT NULL COMMENT 'Cantidad de productos en la venta',
  `Domicilio` varchar(100) NOT NULL COMMENT 'Domicilio del cliente de la venta',
  `Fecha` date NOT NULL COMMENT 'Fecha en la que se efectua la factura',
  `IDVenta` int(5) NOT NULL COMMENT 'ID de la venta asociadoa a la factura'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla de factura de venta';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan`
--

CREATE TABLE `plan` (
  `IDPlan` tinyint(1) NOT NULL COMMENT 'ID asociado al plan',
  `Precio` smallint(5) NOT NULL COMMENT 'Precio del plan',
  `Descripcion` varchar(280) DEFAULT NULL COMMENT 'Descripcion del contenido del plan',
  `Nombre` varchar(12) NOT NULL COMMENT 'Nombre del Plan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla planes';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `IDVenta` int(5) NOT NULL COMMENT 'Numero identificador de la venta',
  `DescripcionV` varchar(280) DEFAULT NULL COMMENT 'Descripcion de la venta',
  `IDPlan` tinyint(1) NOT NULL COMMENT 'Numero identificador del plan asociado a la venta',
  `RUTCl` varchar(12) NOT NULL COMMENT 'Rut del cliente asociado a la venta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='tabla venta de planes';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`RUTAdmin`);

--
-- Indices de la tabla `administracion`
--
ALTER TABLE `administracion`
  ADD KEY `IDPlan` (`IDPlan`),
  ADD KEY `RUTAdmin` (`RUTAdmin`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`RUTCl`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`IDFactura`),
  ADD KEY `IDVenta` (`IDVenta`);

--
-- Indices de la tabla `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`IDPlan`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`IDVenta`),
  ADD KEY `RUTCl` (`RUTCl`),
  ADD KEY `IDPlan` (`IDPlan`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `IDFactura` int(5) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la venta asociada a la factura';

--
-- AUTO_INCREMENT de la tabla `plan`
--
ALTER TABLE `plan`
  MODIFY `IDPlan` tinyint(1) NOT NULL AUTO_INCREMENT COMMENT 'ID asociado al plan';

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `IDVenta` int(5) NOT NULL AUTO_INCREMENT COMMENT 'Numero identificador de la venta';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administracion`
--
ALTER TABLE `administracion`
  ADD CONSTRAINT `administracion_ibfk_1` FOREIGN KEY (`IDPlan`) REFERENCES `plan` (`IDPlan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `administracion_ibfk_2` FOREIGN KEY (`RUTAdmin`) REFERENCES `admin` (`RUTAdmin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`IDVenta`) REFERENCES `venta` (`IDVenta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`RUTCl`) REFERENCES `cliente` (`RUTCl`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`IDPlan`) REFERENCES `plan` (`IDPlan`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-08-2018 a las 21:29:54
-- Versión del servidor: 10.1.32-MariaDB
-- Versión de PHP: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sipe`
--
CREATE DATABASE IF NOT EXISTS `sipe` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `sipe`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `autoCompletar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `autoCompletar` ()  select idCliente from clientes$$

DROP PROCEDURE IF EXISTS `buscarCliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarCliente` (IN `id` VARCHAR(15))  select * from clientes where idCliente=id$$

DROP PROCEDURE IF EXISTS `buscarInventario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarInventario` (IN `identificar` VARCHAR(20), IN `nombre` VARCHAR(20))  select * from productos_marcas where idProductoMarca=identificar or NombreProductoMarca=nombre$$

DROP PROCEDURE IF EXISTS `crearCategoria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearCategoria` (IN `idC` VARCHAR(20), IN `nomC` VARCHAR(20))  insert into categorias values(idC,nomC)$$

DROP PROCEDURE IF EXISTS `crearUbicacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `crearUbicacion` (IN `id` VARCHAR(20), IN `nom` VARCHAR(20), IN `can` VARCHAR(20))  insert into ubicaciones values(id,nom,can)$$

DROP PROCEDURE IF EXISTS `detalleProducto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `detalleProducto` (IN `id` VARCHAR(20))  BEGIN

declare x int (20);
declare y int(20);

select cantidadExistencia into x from productos_marcas  order by pocision desc limit 1;


select idProductoMarca,NombreProductoMarca,idUbicacion,x,precio_unidad,precio_cantidad from productos_marcas where NombreProductoMarca=id and cantidadExistencia=x;


end$$

DROP PROCEDURE IF EXISTS `devoluciones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `devoluciones` (IN `numero` VARCHAR(15), IN `nombre` VARCHAR(20), IN `cantidad` INT(20))  BEGIN

declare a,b,c,d,e,f,g,h varchar(20);

select idUbicacion into a from productos_marcas where idProductoMarca=numero;
select idCategotia into b from productos_marcas where idProductoMarca=numero;
select cantidaProductoMarca into c from productos_marcas where idProductoMarca=numero;
select cantidadExistencia into d from productos_marcas where idProductoMarca=numero;
select valorCompraUnidad into e from productos_marcas where idProductoMarca=numero;
select precio_unidad into f from productos_marcas where idProductoMarca=numero;
select precio_cantidad into g from productos_marcas where idProductoMarca=numero;
select valorCompraMayor into h from productos_marcas where idProductoMarca=numero;

insert into productos_marcas values ((CONCAT(numero,'d')),a,b,nombre,(cantidad),(d-cantidad),(cantidad*f),now(),f,g,(g*cantidad),"Devolucion",default);


end$$

DROP PROCEDURE IF EXISTS `Entradas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Entradas` (IN `id` VARCHAR(20))  select fecha, cantidaProductoMarca,precio_unidad,precio_cantidad,detalles from productos_marcas where NombreProductoMarca=id order by fecha$$

DROP PROCEDURE IF EXISTS `ingresarProductosMarca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresarProductosMarca` (IN `id` VARCHAR(20), IN `idU` VARCHAR(20), IN `idC` VARCHAR(20), IN `nombre` VARCHAR(20), IN `cantidad` INT(20), IN `unidad` INT(20), IN `precio` INT(20))  insert into productos_marcas values(id,idC,idU,nombre,cantidad,(cantidad),(cantidad*unidad),now(),unidad,precio,(cantidad*precio),"Compra",default)$$

DROP PROCEDURE IF EXISTS `insertar_cliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_cliente` (IN `id` VARCHAR(15), IN `nombre` VARCHAR(30), IN `apellido` VARCHAR(30), IN `telefono` VARCHAR(20), IN `direccion` VARCHAR(50))  BEGIN

declare identificacion varchar(15) default "";

select idCliente into identificacion from clientes where id=idCliente;


if(identificacion=id) then 

Select"El cliente a ingresar ya existe ";

ELSE

insert into clientes values(id,nombre,apellido,telefono,direccion);

end if;


END$$

DROP PROCEDURE IF EXISTS `insertar_proveedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_proveedor` (IN `codigo` VARCHAR(15), IN `nombre` VARCHAR(30), IN `razon` VARCHAR(50), IN `nit` VARCHAR(20), IN `direccion` VARCHAR(50), IN `ciudad` VARCHAR(40), IN `postal` VARCHAR(20), IN `pais` VARCHAR(40), IN `email` VARCHAR(50), IN `fax` VARCHAR(20), IN `telefono` VARCHAR(20), IN `contactoVend` VARCHAR(20), IN `pagWeb` VARCHAR(500), IN `diasEntrega` VARCHAR(6), IN `notas` VARCHAR(50))  INSERT INTO proveedores (idProveedor,nombreProveedor,razonSocial,nitProveedor,direccionProveedor,ciudadProveedor,codigoPostal,paisProveedor,correoProveedor,faxProveedor,telefonoProveedor,contactoVendedor,paginaWebProveedor,diaEntrega,observaciones)
VALUES (codigo,nombre,razon,nit,direccion,ciudad,postal,pais,email,fax,telefono,contactoVend,pagWeb,diasEntrega,notas)$$

DROP PROCEDURE IF EXISTS `llamarCategoria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llamarCategoria` (IN `id` VARCHAR(20))  select nombreCategoria from categorias where idCategoria=id$$

DROP PROCEDURE IF EXISTS `llamarUbicacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `llamarUbicacion` (IN `id` VARCHAR(20))  select nombreUbicacion from ubicaciones where idUbicacion=id$$

DROP PROCEDURE IF EXISTS `modificarDatos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarDatos` (IN `idc` VARCHAR(15), IN `nombrec` VARCHAR(30), IN `apellidoc` VARCHAR(30), IN `telefonoc` VARCHAR(20), IN `direccionc` VARCHAR(50))  NO SQL
update clientes set idCliente=idc,nombreCliente=nombrec,apellidoCliente=apellidoc,telefonoCliente=telefonoc,direccionCliente=direccionc where idCliente=idc$$

DROP PROCEDURE IF EXISTS `modificarProducto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarProducto` (IN `nombre` VARCHAR(20), IN `cantidad` INT(20), IN `unidad` VARCHAR(20), IN `precio` VARCHAR(20), IN `recibo` INT(20))  NO SQL
update productos_marcas set NombreProductoMarca=nombre,cantidaProductoMarca=cantidad,precio_unidad=unidad,precio_cantidad=precio,cantidadExistencia=(cantidadExistencia+cantidad),valorCompraUnidad=(unidad*cantidad),valorCompraMayor=(precio*cantidad) where idProductoMarca=recibo$$

DROP PROCEDURE IF EXISTS `mostrarNombreProducto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarNombreProducto` (IN `id` VARCHAR(20))  select NombreProductoMarca from productos_marcas where idProductoMarca=id$$

DROP PROCEDURE IF EXISTS `mostrarProductosMarca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarProductosMarca` ()  select idProductoMarca,idUbicacion,idCategotia,NombreProductoMarca,CantidaProductoMarca,precio_unidad,precio_cantidad from productos_marcas$$

DROP PROCEDURE IF EXISTS `mostrar_clientes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_clientes` ()  Select * from clientes$$

DROP PROCEDURE IF EXISTS `mostrar_vista_proveedores`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_vista_proveedores` ()  SELECT idProveedor as Codigo,nombreProveedor as Nombre, nitProveedor as Nit,direccionProveedor as Direccion FROM proveedores_vista$$

DROP PROCEDURE IF EXISTS `seleccioarFactura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccioarFactura` ()  select idProductoMarca from productos_marcas$$

DROP PROCEDURE IF EXISTS `seleccionarcategoria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccionarcategoria` ()  select idCategoria from categorias$$

DROP PROCEDURE IF EXISTS `seleccionarProducto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccionarProducto` (IN `id` VARCHAR(20))  begin 

declare x varchar (20);

select idUbicacion into x from productos_marcas where idProductoMarca=id; 

if(x>=1) then 


select idProductoMarca,idUbicacion,idCategotia,NombreProductoMarca,cantidaProductoMarca,precio_unidad,precio_cantidad from productos_marcas where idProductoMarca=id;

ELSE

select"0";

end if;

END$$

DROP PROCEDURE IF EXISTS `seleccionarUbicacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccionarUbicacion` ()  select idUbicacion from ubicaciones$$

DROP PROCEDURE IF EXISTS `validarCategoria`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validarCategoria` (IN `idC` VARCHAR(20), IN `nomC` VARCHAR(20))  BEGIN

declare c varchar(20);

select idCategoria into c from categorias where idCategoria=idC or nombreCategoria=nomC;

if(c>=1) THEN

select"1";

else 

select"0";


end if;
END$$

DROP PROCEDURE IF EXISTS `validarSeleccion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validarSeleccion` (IN `id` VARCHAR(20))  begin 

declare c varchar(20);

select idProductoMarca into c from productos_marcas where idProductoMarca=id;

if(c>=1)THEN

select"1";

else  

select"0";

end if;


end$$

DROP PROCEDURE IF EXISTS `validarUbicacion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validarUbicacion` (IN `id` VARCHAR(20), IN `nom` VARCHAR(20), IN `can` VARCHAR(20))  BEGIN

declare c varchar(20);

select idUbicacion into c from ubicaciones where idUbicacion=id or nombreUbicacion=nom or capacidad=can;

if(c>=1) THEN

select "1";

ELSE

select "0";

end if;


END$$

DROP PROCEDURE IF EXISTS `validar_idProveedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validar_idProveedor` (IN `codigo` INT(15))  BEGIN

DECLARE var int;
DECLARE flag int DEFAULT 0;

SELECT idProveedor into var from proveedores WHERE idProveedor=codigo;

IF var=codigo THEN
SELECT flag+1;
ELSE
SELECT flag;
END if;

END$$

DROP PROCEDURE IF EXISTS `valida_cliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_cliente` (IN `id` VARCHAR(15))  BEGIN

declare v varchar(20) default "";

select idCliente into v from clientes where id=idCliente;

if(id=v)THEN

select"1";

ELSE

select"0";

end if;


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `idCategoria` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreCategoria` varchar(30) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`idCategoria`, `nombreCategoria`) VALUES
('1101', 'indeleble'),
('1222', 'frituras'),
('123', 'solido'),
('125', 'liquido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `idCliente` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreCliente` varchar(30) COLLATE utf8_bin NOT NULL,
  `apellidoCliente` varchar(30) COLLATE utf8_bin NOT NULL,
  `telefonoCliente` varchar(20) COLLATE utf8_bin NOT NULL,
  `direccionCliente` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombreCliente`, `apellidoCliente`, `telefonoCliente`, `direccionCliente`) VALUES
('112188477', 'uriel', 'remos', '43524', 'cierto'),
('1121884776', 'fernando', 'parrado', '12345', 'calle38'),
('17334691', 'uriel', 'parrado', '3204131461', 'calle'),
('91112465', 'Robinson', 'solano', '3112945754', 'carrera 18 c #5-18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_compras`
--

DROP TABLE IF EXISTS `detalles_compras`;
CREATE TABLE IF NOT EXISTS `detalles_compras` (
  `idDetalleCompra` int(11) NOT NULL AUTO_INCREMENT,
  `idFacturaCompra` int(11) NOT NULL,
  `idInsumo` varchar(15) COLLATE utf8_bin NOT NULL,
  `IdProductoMarca` varchar(15) COLLATE utf8_bin NOT NULL,
  `idTipoCantidad` varchar(15) COLLATE utf8_bin NOT NULL,
  `cantidad` float NOT NULL,
  `subtotal` float NOT NULL,
  PRIMARY KEY (`idDetalleCompra`),
  KEY `idFacturaCompra` (`idFacturaCompra`),
  KEY `idInsumo` (`idInsumo`),
  KEY `IdProductoMarca` (`IdProductoMarca`),
  KEY `idTipoCantidad` (`idTipoCantidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_compras_insumos`
--

DROP TABLE IF EXISTS `detalles_compras_insumos`;
CREATE TABLE IF NOT EXISTS `detalles_compras_insumos` (
  `idDetalleCompraInsumo` int(11) NOT NULL AUTO_INCREMENT,
  `idInsumo` varchar(15) COLLATE utf8_bin NOT NULL,
  `idFacturaCompra` int(11) NOT NULL,
  `idTipoCantidad` varchar(15) COLLATE utf8_bin NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` float NOT NULL,
  PRIMARY KEY (`idDetalleCompraInsumo`),
  KEY `idInsumo` (`idInsumo`),
  KEY `idFacturaCompra` (`idFacturaCompra`),
  KEY `idTipoCantidad` (`idTipoCantidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_recetas`
--

DROP TABLE IF EXISTS `detalles_recetas`;
CREATE TABLE IF NOT EXISTS `detalles_recetas` (
  `idDetalleReceta` int(11) NOT NULL AUTO_INCREMENT,
  `idInsumo` varchar(15) COLLATE utf8_bin NOT NULL,
  `idReceta` varchar(15) COLLATE utf8_bin NOT NULL,
  `idTipoCantidad` varchar(15) COLLATE utf8_bin NOT NULL,
  `cantidadInsumoUtilizado` varchar(30) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idDetalleReceta`),
  KEY `idInsumo` (`idInsumo`),
  KEY `idReceta` (`idReceta`),
  KEY `idTipoCantidad` (`idTipoCantidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_ventas`
--

DROP TABLE IF EXISTS `detalles_ventas`;
CREATE TABLE IF NOT EXISTS `detalles_ventas` (
  `idDetalleVenta` int(11) NOT NULL AUTO_INCREMENT,
  `idFacturaVenta` int(11) NOT NULL,
  `idTipoProductoVenta` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` float NOT NULL,
  PRIMARY KEY (`idDetalleVenta`),
  KEY `idFacturaVenta` (`idFacturaVenta`),
  KEY `idTipoProductoVenta` (`idTipoProductoVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas_de_compras`
--

DROP TABLE IF EXISTS `facturas_de_compras`;
CREATE TABLE IF NOT EXISTS `facturas_de_compras` (
  `idFacturaCompra` int(11) NOT NULL AUTO_INCREMENT,
  `idProveedor` varchar(15) COLLATE utf8_bin NOT NULL,
  `idTipoCompra` varchar(15) COLLATE utf8_bin NOT NULL,
  `fechaCompra` datetime NOT NULL,
  `valorTotal` float NOT NULL,
  PRIMARY KEY (`idFacturaCompra`),
  KEY `idProveedor` (`idProveedor`),
  KEY `idTipoCompra` (`idTipoCompra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_ventas`
--

DROP TABLE IF EXISTS `factura_ventas`;
CREATE TABLE IF NOT EXISTS `factura_ventas` (
  `idFacturaVenta` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` varchar(15) COLLATE utf8_bin NOT NULL,
  `IdVendedor` varchar(15) COLLATE utf8_bin NOT NULL,
  `idTipoDePago` varchar(15) COLLATE utf8_bin NOT NULL,
  `fechaVenta` datetime NOT NULL,
  `valorVenta` float NOT NULL,
  PRIMARY KEY (`idFacturaVenta`),
  KEY `idCliente` (`idCliente`),
  KEY `IdVendedor` (`IdVendedor`),
  KEY `idTipoDePago` (`idTipoDePago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

DROP TABLE IF EXISTS `insumos`;
CREATE TABLE IF NOT EXISTS `insumos` (
  `idInsumo` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreInsumo` varchar(30) COLLATE utf8_bin NOT NULL,
  `cantidadInsumo` float NOT NULL,
  `descripcionInsumo` varchar(60) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idInsumo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precios`
--

DROP TABLE IF EXISTS `precios`;
CREATE TABLE IF NOT EXISTS `precios` (
  `idPrecio` varchar(11) COLLATE utf8_bin NOT NULL,
  `nombreTiopoPrecio` varchar(30) COLLATE utf8_bin NOT NULL,
  `precioIva` float NOT NULL,
  `descuento` float NOT NULL,
  PRIMARY KEY (`idPrecio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_elaborados`
--

DROP TABLE IF EXISTS `productos_elaborados`;
CREATE TABLE IF NOT EXISTS `productos_elaborados` (
  `idProductoElaborado` varchar(15) COLLATE utf8_bin NOT NULL,
  `idReceta` varchar(15) COLLATE utf8_bin NOT NULL,
  `idCategoria` varchar(15) COLLATE utf8_bin NOT NULL,
  `idUbicacion` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreProducto` varchar(30) COLLATE utf8_bin NOT NULL,
  `cantidaProducto` int(6) NOT NULL,
  PRIMARY KEY (`idProductoElaborado`),
  KEY `idReceta` (`idReceta`),
  KEY `idCategoria` (`idCategoria`),
  KEY `idUbicacion` (`idUbicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_marcas`
--

DROP TABLE IF EXISTS `productos_marcas`;
CREATE TABLE IF NOT EXISTS `productos_marcas` (
  `idProductoMarca` varchar(15) COLLATE utf8_bin NOT NULL,
  `idUbicacion` varchar(15) COLLATE utf8_bin NOT NULL,
  `idCategotia` varchar(15) COLLATE utf8_bin NOT NULL,
  `NombreProductoMarca` varchar(30) COLLATE utf8_bin NOT NULL,
  `cantidaProductoMarca` int(11) NOT NULL,
  `cantidadExistencia` int(20) NOT NULL,
  `valorCompraUnidad` float NOT NULL,
  `fecha` date NOT NULL,
  `precio_unidad` int(11) NOT NULL,
  `precio_cantidad` int(11) NOT NULL,
  `valorCompraMayor` float NOT NULL,
  `detalles` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `pocision` int(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idProductoMarca`),
  KEY `idUbicacion` (`idUbicacion`),
  KEY `idCategotia` (`idCategotia`),
  KEY `pocision` (`pocision`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `productos_marcas`
--

INSERT INTO `productos_marcas` (`idProductoMarca`, `idUbicacion`, `idCategotia`, `NombreProductoMarca`, `cantidaProductoMarca`, `cantidadExistencia`, `valorCompraUnidad`, `fecha`, `precio_unidad`, `precio_cantidad`, `valorCompraMayor`, `detalles`, `pocision`) VALUES
('00001', '5', '1101', 'coca-cola', 777, 777, 1554000, '2018-08-11', 2000, 1800, 1398600, 'Compra', 5),
('1', '2', '123', 'papas', 120, 220, 144000, '2018-07-30', 1200, 1100, 132000, 'Compra', 1),
('146', '2', '125', 'gaseosa', 1234, 1234, 425730, '2018-08-11', 345, 234, 288756, 'Compra', 6),
('1d', '2', '123', 'papas', 120, 208, 144000, '2018-08-01', 1200, 1100, 132000, 'Devolucion', 4),
('1dd', '2', '123', 'papas', 4, 204, 4800, '2018-08-11', 1200, 1100, 4400, 'Devolucion', 7),
('2', '2', '1222', 'papas', 120, 220, 144000, '2018-07-30', 1200, 1100, 132000, 'Compra', 2),
('2d', '2', '1222', 'papas', 12, 208, 14400, '2018-07-30', 1200, 1100, 13200, 'Devolucion', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE IF NOT EXISTS `proveedores` (
  `idProveedor` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreProveedor` varchar(30) COLLATE utf8_bin NOT NULL,
  `razonSocial` varchar(50) COLLATE utf8_bin NOT NULL,
  `nitProveedor` varchar(20) COLLATE utf8_bin NOT NULL,
  `direccionProveedor` varchar(50) COLLATE utf8_bin NOT NULL,
  `ciudadProveedor` varchar(40) COLLATE utf8_bin NOT NULL,
  `codigoPostal` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `paisProveedor` varchar(40) COLLATE utf8_bin NOT NULL,
  `correoProveedor` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `faxProveedor` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `telefonoProveedor` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contactoVendedor` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `paginaWebProveedor` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `diaEntrega` varchar(6) COLLATE utf8_bin DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedor`, `nombreProveedor`, `razonSocial`, `nitProveedor`, `direccionProveedor`, `ciudadProveedor`, `codigoPostal`, `paisProveedor`, `correoProveedor`, `faxProveedor`, `telefonoProveedor`, `contactoVendedor`, `paginaWebProveedor`, `diaEntrega`, `observaciones`) VALUES
('22052', 'Angel Guzman', 'Surtiplast', '2124578', 'calle 1', 'Item 3', '0052', 'Item 1', 'surtiplas@gmail.com', '999999', '000000', '1111111', 'Empresa de Plasticos y desechables ', 'Item 4', 'www.surtiplas.com'),
('32021', 'SAntiago Arias', 'Ajover', '86073880', 'calle 5 ', 'Item 3', '053', 'Item 1', 'ajover@gmail.com', '1111111', '0000000', '99999999', 'www.ajover.com', 'Item 4', 'empresa de plasticos y espumosos de bogota'),
('41288', 'marcela', 'sadsjdkj', '121284', 'calksa', 'Item 1', '', 'Item 1', '', '', '31325', '', '', 'Item 1', NULL),
('45612', 'SaraLuna', 'Papi Dindo', '112845648', 'calle37 a 26-11 Brr San Isidro', 'Item 3', '0052', 'Item 1', 'sdkas@sad.com', '154156', '441518', '321', 'hoy es un buen dia para hacer un codigo', 'Item 4', 'www.pasandolasano.com'),
('4568', 'brian rodriguez', 'jireh del llano', '1121884892', 'calle 52', 'Item 3', '', 'blaksldk@sad.com', '5465145', '3138369712', '', 'calle 52', NULL, '', 'Item 4'),
('7845', 'Andres Escobar', 'El bucetero del Llano', '15647687', 'cll 374521 ', 'Item 1', '', 'Item 1', '', '', '', '', '', 'Item 1', '');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `proveedores_vista`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `proveedores_vista`;
CREATE TABLE IF NOT EXISTS `proveedores_vista` (
`idProveedor` varchar(15)
,`nombreProveedor` varchar(30)
,`nitProveedor` varchar(20)
,`direccionProveedor` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recetas`
--

DROP TABLE IF EXISTS `recetas`;
CREATE TABLE IF NOT EXISTS `recetas` (
  `idReceta` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreReceta` varchar(30) COLLATE utf8_bin NOT NULL,
  `cantidadProductoGenerado` int(6) NOT NULL,
  `fechaElaboracion` date NOT NULL,
  `descripcionReceta` varchar(400) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idReceta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_de_cantidades`
--

DROP TABLE IF EXISTS `tipos_de_cantidades`;
CREATE TABLE IF NOT EXISTS `tipos_de_cantidades` (
  `idTipoCantidad` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreTipoCantidad` varchar(30) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idTipoCantidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_de_compras`
--

DROP TABLE IF EXISTS `tipos_de_compras`;
CREATE TABLE IF NOT EXISTS `tipos_de_compras` (
  `idTipoCompra` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreTipoCompra` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idTipoCompra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_de_pagos`
--

DROP TABLE IF EXISTS `tipos_de_pagos`;
CREATE TABLE IF NOT EXISTS `tipos_de_pagos` (
  `idTipoDePago` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreTipoDePago` varchar(30) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idTipoDePago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_productos_venta`
--

DROP TABLE IF EXISTS `tipo_productos_venta`;
CREATE TABLE IF NOT EXISTS `tipo_productos_venta` (
  `idTipoProductoVenta` int(11) NOT NULL AUTO_INCREMENT,
  `idProductoMarca` varchar(15) COLLATE utf8_bin NOT NULL,
  `idProductoElaborado` varchar(15) COLLATE utf8_bin NOT NULL,
  `idPrecio` varchar(11) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idTipoProductoVenta`),
  KEY `idProductoMarca` (`idProductoMarca`),
  KEY `idProductoElaborado` (`idProductoElaborado`),
  KEY `idPrecio` (`idPrecio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

DROP TABLE IF EXISTS `ubicaciones`;
CREATE TABLE IF NOT EXISTS `ubicaciones` (
  `idUbicacion` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreUbicacion` varchar(30) COLLATE utf8_bin NOT NULL,
  `capacidad` float NOT NULL,
  PRIMARY KEY (`idUbicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`idUbicacion`, `nombreUbicacion`, `capacidad`) VALUES
('12345', 'casa', 34),
('2', 'vitrina', 20),
('4', 'bodega', 50),
('5', 'estanteria', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

DROP TABLE IF EXISTS `vendedores`;
CREATE TABLE IF NOT EXISTS `vendedores` (
  `idVendedor` varchar(15) COLLATE utf8_bin NOT NULL,
  `nombreVendedor` varchar(30) COLLATE utf8_bin NOT NULL,
  `apellidoVendedor` varchar(30) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`idVendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura para la vista `proveedores_vista`
--
DROP TABLE IF EXISTS `proveedores_vista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `proveedores_vista`  AS  select `proveedores`.`idProveedor` AS `idProveedor`,`proveedores`.`nombreProveedor` AS `nombreProveedor`,`proveedores`.`nitProveedor` AS `nitProveedor`,`proveedores`.`direccionProveedor` AS `direccionProveedor` from `proveedores` ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalles_compras`
--
ALTER TABLE `detalles_compras`
  ADD CONSTRAINT `detalles_compras_ibfk_1` FOREIGN KEY (`idFacturaCompra`) REFERENCES `facturas_de_compras` (`idFacturaCompra`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_compras_ibfk_2` FOREIGN KEY (`idTipoCantidad`) REFERENCES `tipos_de_cantidades` (`idTipoCantidad`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_compras_ibfk_3` FOREIGN KEY (`IdProductoMarca`) REFERENCES `productos_marcas` (`idProductoMarca`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalles_compras_insumos`
--
ALTER TABLE `detalles_compras_insumos`
  ADD CONSTRAINT `detalles_compras_insumos_ibfk_1` FOREIGN KEY (`idInsumo`) REFERENCES `insumos` (`idInsumo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_compras_insumos_ibfk_2` FOREIGN KEY (`idFacturaCompra`) REFERENCES `facturas_de_compras` (`idFacturaCompra`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_compras_insumos_ibfk_3` FOREIGN KEY (`idTipoCantidad`) REFERENCES `tipos_de_cantidades` (`idTipoCantidad`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalles_recetas`
--
ALTER TABLE `detalles_recetas`
  ADD CONSTRAINT `detalles_recetas_ibfk_1` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`idReceta`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_recetas_ibfk_2` FOREIGN KEY (`idInsumo`) REFERENCES `insumos` (`idInsumo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_recetas_ibfk_3` FOREIGN KEY (`idTipoCantidad`) REFERENCES `tipos_de_cantidades` (`idTipoCantidad`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalles_ventas`
--
ALTER TABLE `detalles_ventas`
  ADD CONSTRAINT `detalles_ventas_ibfk_1` FOREIGN KEY (`idTipoProductoVenta`) REFERENCES `tipo_productos_venta` (`idTipoProductoVenta`) ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_ventas_ibfk_2` FOREIGN KEY (`idFacturaVenta`) REFERENCES `factura_ventas` (`idFacturaVenta`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `facturas_de_compras`
--
ALTER TABLE `facturas_de_compras`
  ADD CONSTRAINT `facturas_de_compras_ibfk_1` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `facturas_de_compras_ibfk_2` FOREIGN KEY (`idTipoCompra`) REFERENCES `tipos_de_compras` (`idTipoCompra`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura_ventas`
--
ALTER TABLE `factura_ventas`
  ADD CONSTRAINT `factura_ventas_ibfk_1` FOREIGN KEY (`idTipoDePago`) REFERENCES `tipos_de_pagos` (`idTipoDePago`) ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_ventas_ibfk_2` FOREIGN KEY (`IdVendedor`) REFERENCES `vendedores` (`idVendedor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_ventas_ibfk_3` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos_elaborados`
--
ALTER TABLE `productos_elaborados`
  ADD CONSTRAINT `productos_elaborados_ibfk_1` FOREIGN KEY (`idReceta`) REFERENCES `recetas` (`idReceta`) ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_elaborados_ibfk_2` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicaciones` (`idUbicacion`) ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_elaborados_ibfk_3` FOREIGN KEY (`idCategoria`) REFERENCES `categorias` (`idCategoria`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos_marcas`
--
ALTER TABLE `productos_marcas`
  ADD CONSTRAINT `productos_marcas_ibfk_1` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicaciones` (`idUbicacion`) ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_marcas_ibfk_2` FOREIGN KEY (`idCategotia`) REFERENCES `categorias` (`idCategoria`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `tipo_productos_venta`
--
ALTER TABLE `tipo_productos_venta`
  ADD CONSTRAINT `tipo_productos_venta_ibfk_1` FOREIGN KEY (`idProductoElaborado`) REFERENCES `productos_elaborados` (`idProductoElaborado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tipo_productos_venta_ibfk_2` FOREIGN KEY (`idProductoMarca`) REFERENCES `productos_marcas` (`idProductoMarca`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tipo_productos_venta_ibfk_3` FOREIGN KEY (`idPrecio`) REFERENCES `precios` (`idPrecio`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

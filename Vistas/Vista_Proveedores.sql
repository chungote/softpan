DROP VIEW IF EXISTS `softpan`.`proveedores`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `proveedores`
 AS 
select `personas`.`cod_persona` AS `cod_proveedor`,
ifnull(`personas`.`nombre_fantasia`,concat(`personas`.`nombres`,' ',`personas`.`apellidos`)) AS `nombre_proveedor`,
`personas`.`direccion` AS `direccion`,
`personas`.`telefono` AS `telefono`,
`personas`.`e_mail` AS `e_mail`,
`personas`.`nro_documento` AS `ruc` 
from `personas` where (`personas`.`es_proveedor` = 1);
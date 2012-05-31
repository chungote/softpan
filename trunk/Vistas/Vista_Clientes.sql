DROP VIEW IF EXISTS `softpan`.`clientes`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `clientes`
 AS 
select `personas`.`cod_persona` AS `cod_cliente`,
ifnull(`personas`.`nombre_fantasia`,concat(`personas`.`nombres`,' ',`personas`.`apellidos`)) AS `nombre_cliente` 
from `personas` where (`personas`.`es_cliente` = 1);
DELIMITER $$

DROP PROCEDURE IF EXISTS `softpan`.`sp_inserta_cobros_clientes` $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inserta_cobros_clientes`(v_cliente int,v_moneda smallint, v_cod_cajero smallint, v_fecha date,v_nro_factura float, v_importe float, v_tipo_comprobante smallint,v_cuenta smallint,v_condicion smallint)
BEGIN
 declare v_nro_cobro float;
 select ifnull(max(nro_cobro),0) into v_nro_cobro from cobros_clientes;
 /*insertamos en cobros clientes*/
 insert into cobros_clientes(nro_cobro,cod_cliente,total_cobrado,total_detalle,cod_moneda,fecha_cobro)
 values(v_nro_cobro,v_cliente,v_importe,v_importe,v_moneda,v_fecha);

 /*insertamos en los documentos de cobros del cliente*/

 insert into cobros_facturas_doc(nro_cobro,cod_tipo_comprobante, nro_documento,nro_cuota,valor_cobrado)
 values(v_nro_cobro,v_tipo_comprobante,v_nro_factura,1,v_importe);

/*insertamos en el detalle de cobros del cliente*/

 insert into detalle_cobros_clientes(nro_cobro,cod_condicion,nro_cuenta,cod_moneda,cotizacion,nro_cheque,valor,cod_banco)
 values(v_nro_cobro,v_condicion,v_cuenta,v_moneda,1,v_importe,v_importe,1);






END $$

DELIMITER ;


/*after insert */

DROP TRIGGER tai_anticipo_proveedor;
CREATE TRIGGER tai_anticipo_proveedor after insert ON anticipo_proveedor
FOR EACH ROW
BEGIN
  DECLARE v_max float;
  DECLARE my_error CONDITION FOR SQLSTATE '45000';
  DECLARE v_usuario varchar(15);

  INSERT into Ctas_Pagar
  (fecha_emision, cod_proveedor,cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento,  Cod_moneda, valor)
   values
   (new.fecha, new.cod_proveedor, new.cod_tipo_comprobante,new.nro_anticipo, 1 ,1,new.Fecha,new.Cod_moneda,  -1*new.valor);

   select ifnull(max(primario),0)+1 into v_max   from auditorias.auditoria_compras_ventas;

   /*insercion en auditorias*/
   set v_usuario=CURRENT_USER;
   insert into auditorias.auditoria_compras_ventas
   (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
   values(v_max,CURRENT_DATE(),v_usuario, 'ANTICIPOS PROVEEDOR', 'I', new.nro_anticipo, new.valor);



END

/*after update*/

DROP TRIGGER tau_anticipo_proveedor;
DROP TRIGGER tau_anticipo_proveedor
CREATE TRIGGER tau_anticipo_proveedor after update  ON anticipo_proveedor
FOR EACH ROW
BEGIN
  DECLARE v_max float;
  DECLARE my_error CONDITION FOR SQLSTATE '45000';
  DECLARE v_usuario varchar(15);

  /*Borramos la Ctas_Pagar*/
  DELETE FROM Ctas_Pagar
  where cod_tipo_comprobante=old.cod_tipo_comprobante and
        cod_proveedor=old.cod_proveedor and
        nro_factura=rtrim(cast(old.nro_anticipo as char(15)));

  /*Insertamos las Ctas_Pagar*/
  INSERT into Ctas_Pagar
  (fecha_emision, cod_proveedor,cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento,  Cod_moneda, valor)
   values
   (new.fecha, new.cod_proveedor, new.cod_tipo_comprobante,new.nro_anticipo, 1 ,1,new.Fecha,new.Cod_moneda,  -1*new.valor);

   select ifnull(max(primario),0)+1 into v_max   from auditorias.auditoria_compras_ventas;

   /*insercion en auditorias*/
   set v_usuario=CURRENT_USER;
   insert into auditorias.auditoria_compras_ventas
   (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
   values(v_max,CURRENT_DATE(),v_usuario, 'ANTICIPOS PROVEEDOR', 'U', new.nro_anticipo, new.valor);



END



/*after delete*/

CREATE TRIGGER tad_anticipo_proveedor after delete ON anticipo_proveedor
FOR EACH ROW
BEGIN
declare v_max integer;
        /*borrar las cuentas a pagar*/
  DELETE FROM Ctas_Pagar
  where cod_tipo_comprobante=old.cod_tipo_comprobante and
        cod_proveedor=old.cod_proveedor and
        nro_factura=rtrim(cast(old.nro_anticipo as char(15)));

        select ifnull(max(primario),0)+1 into v_max     from auditorias.auditoria_compras_ventas;

         insert into auditorias.auditoria_compras_ventas
         (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
         values(v_max,now(),CURRENT_USER, 'ANTICIPOS PROVEEDOR', 'D',  old.nro_anticipo, old.valor);

  END


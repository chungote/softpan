/*after insert */

CREATE TRIGGER tai_nota_credito_compra after insert ON nota_credito_compra
for each row
BEGIN
 declare v_usuario varchar(25);
 declare v_max float;
 declare v_valor_total float;

        DECLARE my_error CONDITION FOR SQLSTATE '45000';
        if (select count(*) from ctas_pagar where cod_proveedor=new.cod_proveedor and nro_factura=new.nro_nota and cod_tipo_comprobante=new.cod_tipo_nota)>0 then
           begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = 'Ya se registraron ctas a pagar con ese nro de documento, proveedor y tipo de comprobante';
           end;

        end if;

         if (select count(*) from ctas_pagar where cod_proveedor=new.cod_proveedor and nro_factura=new.nro_factura and cod_tipo_comprobante=new.cod_tipo_comprobante_doc and pagado=1)>0 then
           begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = 'Ya se aplico un pago a dicha compra, no se puede registrar la Nota de Credito';
           end;

        end if;

        update factura_proveedor
        set estado=3
        where nro_registro=new.nro_reg_compra;

        set v_valor_total=(new.total_gravadas_5+new.total_gravadas_10+new.total_exentas+new.total_impuesto_5+new.total_impuesto_10);

               INSERT intO Ctas_pagar(fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values( new.Fecha_nc, 0, new.cod_proveedor,new.cod_tipo_nota,new.nro_nota, 1,1,f_calc_vence(new.cod_proveedor,new.Fecha_nc),
                 (new.Fecha_nc),new.Cod_moneda,-1*(((v_valor_total))));

                  select ifnull(max(primario),0)+1 into v_max
                 from auditorias.auditoria_compras_ventas;

                set v_usuario=CURRENT_USER;
                insert into auditorias.auditoria_compras_ventas
                (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
                 values(v_max,CURRENT_DATE(),v_usuario, 'NOTA_CREDITO_COMPRAS', 'I', new.Nro_registro, v_valor_total);

       END



/*after update*/

CREATE TRIGGER tau_nota_credito_compra after update ON nota_credito_compra
for each row
BEGIN
 declare v_usuario varchar(25);
 declare v_max int;
 declare v_valor_total float;

        set v_valor_total =(new.total_gravadas_5+new.total_gravadas_10 + new.total_exentas + new.total_impuesto_5+new.total_impuesto_10);

      /*  DECLARE my_error CONDITION FOR SQLSTATE '45000';
        if (select count(*) from ctas_pagar where cod_proveedor=new.cod_proveedor and nro_factura=new.nro_nota and cod_tipo_comprobante=new.cod_tipo_nota)>0 then
           begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = 'Ya se registraron ctas a pagar con ese nro de documento, proveedor y tipo de comprobante';
           end;

        end if;*/
                /*borrar las ctas a pagar generadas y generarlas nuevamente*/
                delete from ctas_pagar where cod_proveedor=old.cod_proveedor and cod_tipo_comprobante=old.cod_tipo_nota and nro_factura=old.nro_nota;

                /*insertar las ctas a pagar de new*/
               INSERT intO Ctas_pagar(fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values( new.Fecha_nc, 0, new.cod_proveedor,new.cod_tipo_nota,new.nro_nota, 1,1,f_calc_vence(new.cod_proveedor,new.Fecha_nc),
                 (new.Fecha_nc),new.Cod_moneda,-1*(v_valor_total));

         set v_usuario=CURRENT_USER;
        /*nuevos valores*/
          select ifnull(max(primario),0)+1 into v_max
                 from auditorias.auditoria_compras_ventas;
         insert into auditorias.auditoria_compras_ventas
         (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
         values(v_max,CURRENT_DATE(),v_usuario, 'NOTA_CREDITO_COMPRAS', 'MI', new.Nro_registro, v_valor_total);
        /*antiguos valores*/
        select ifnull(max(primario),0)+1 into v_max
        from auditorias.auditoria_compras_ventas;
        insert into auditorias.auditoria_compras_ventas
         (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
         values(v_max,CURRENT_DATE(),v_usuario, 'NOTA_CREDITO_COMPRAS', 'MB', old.Nro_registro, (old.total_gravadas_5+old.total_gravadas_10+old.total_exentas+old.total_impuesto_5+old.total_impuesto_10));

       END

/*after delete*/
drop trigger tad_nota_credito_compra
drop trigger tad_nota_credito_compra
CREATE TRIGGER tad_nota_credito_compra after delete ON nota_credito_compra
for each row
BEGIN
 declare v_usuario varchar(25);
 declare v_max float;

        /*borrar las ctas a pagar generadas y generarlas nuevamente*/
          delete from ctas_pagar where cod_proveedor=old.cod_proveedor and cod_tipo_comprobante=old.cod_tipo_nota and nro_factura=old.nro_nota;

          update factura_proveedor
          set estado=1
          where cod_tipo_comprobante=old.cod_tipo_comprobante_doc
          and nro_factura=old.nro_factura;

        /*insertar las ctas a pagar de new*/
        select ifnull(max(primario),0)+1 into v_max
        from auditorias.auditoria_compras_ventas;

        insert into auditorias.auditoria_compras_ventas
         (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
         values(v_max,CURRENT_DATE(),CURRENT_USER, 'NOTA_CREDITO_COMPRAS', 'MB', old.Nro_registro,  (old.total_gravadas_5+old.total_gravadas_10+old.total_exentas+old.total_impuesto_5+old.total_impuesto_10));

       END
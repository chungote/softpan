
/*before insert */
DROP TRIGGER tbi_factura_proveedor
CREATE TRIGGER tbi_factura_proveedor before insert ON factura_proveedor
FOR EACH ROW
BEGIN

        set new.valor=(new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10);
        set new.fecha_alta=current_date();
END

/*after insert */




DROP TRIGGER tai_factura_proveedor
CREATE TRIGGER tai_factura_proveedor after insert ON factura_proveedor
FOR EACH ROW
BEGIN
        declare v_cant_cuotas int;
        declare v_cant_cuotas_iregular int;
        declare v_tipo_vence int;
        declare v_dias1 int;
        declare v_dias2 int;
        declare v_dias3 int;
        declare v_dias4 int;
        declare v_dias5 int;
        declare v_dias6 int;
        declare counter int;
        declare v_existe int;
        declare v_usuario varchar(25);
        declare v_max float;

        DECLARE my_error CONDITION FOR SQLSTATE '45000';

        set v_tipo_vence = 0;
        set v_dias1 = 0;
        set v_dias2 = 0;
        set v_dias3 = 0;
        set v_dias4 = 0;
        set v_dias5 = 0;
        set v_dias6 = 0;
        set v_cant_cuotas_iregular = 1;
        set v_cant_cuotas = ifnull(new.cant_cuotas, 1);

       select ifnull(tipo_cuotas, 0),
              ifnull(dias_a,0),
              ifnull(dias_b,0),
              ifnull(dias_c,0),
              ifnull(dias_d,0),
              ifnull(dias_e,0),
              ifnull(dias_f,0),
              ifnull(cant_cuotas,1) into
                v_tipo_vence,
                v_dias1,
                v_dias2,
                v_dias3,
                v_dias4,
                v_dias5,
                v_dias6,
                v_cant_cuotas_iregular
          from plazos where cod_plazo = new.cod_plazo ;

        if (select ifnull(tipo_opcion, 0) FROM tipo_comprobante where cod_tipo_comprobante=new.cod_tipo_comprobante) = 0 then /*contado*/
                set v_cant_cuotas = 1;
        end if;

        if (select count(*) from ctas_pagar where cod_proveedor=new.cod_persona and nro_factura=new.nro_factura and cod_tipo_comprobante=new.cod_tipo_comprobante)>0 then
           begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = 'Ya se registraron ctas a pagar con ese nro de documento, proveedor y tipo de comprobante';
           end;

        end if;


        if v_tipo_vence = 0 then /*es regular*/

          set counter = 1;
          WHILE counter <= v_cant_cuotas do
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                (new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, counter,new.cant_cuotas,/*new.fecha*/f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval new.dias*counter day )),
                 (new.fecha+new.dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.entrega_inicial) / v_cant_cuotas));

                set counter=counter +1;

          end while;
        end if;

         if v_tipo_vence = 1 then

          if v_cant_cuotas_iregular>=1 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 1,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias1 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

           if v_cant_cuotas_iregular>=2 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 2,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias2 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=3 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 3,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias3 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=4 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 4,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias4 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=5 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 5,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias5 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=6 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 6,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias6 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;
        end if;

        if (select ifnull(Tipo_opcion, 1) FROM tipo_comprobante where cod_tipo_comprobante=new.cod_tipo_comprobante) = 1 and new.entrega_inicial>0 then /*credito y con entrega inicial*/
                INSERT into Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                 values(new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 900 ,900,f_calc_vence(new.cod_persona,new.Fecha),new.Fecha,new.Cod_moneda,new.entrega_inicial);
        end if;


        if (select estado from ordenes_compra where nro_oc=new.nro_oc) not in('D','F') then
                update ordenes_compra set estado = 'F' where nro_oc = new.nro_oc;
        end if;

        select ifnull(max(primario),0)+1 into v_max
        from auditorias.auditoria_compras_ventas;

                /*insercion en auditorias*/
        set v_usuario=CURRENT_USER;
         insert into auditorias.auditoria_compras_ventas
         (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
         values(v_max,CURRENT_DATE(),v_usuario, 'FACTURA_PROVEEDOR', 'I', new.Nro_registro, (new.total_exentas+new.total_gravadas_10 + new.total_gravadas_5));

      END

/*after update*/



CREATE TRIGGER tau_factura_proveedor after update ON factura_proveedor
FOR EACH ROW
BEGIN
        declare v_cant_cuotas int;
        declare v_cant_cuotas_iregular int;
        declare v_tipo_vence int;
        declare v_dias1 int;
        declare v_dias2 int;
        declare v_dias3 int;
        declare v_dias4 int;
        declare v_dias5 int;
        declare v_dias6 int;
        declare counter int;



        set v_tipo_vence = 0;
        set v_dias1 = 0;
        set v_dias2 = 0;
        set v_dias3 = 0;
        set v_dias4 = 0;
        set v_dias5 = 0;
        set v_dias6 = 0;
        set v_cant_cuotas_iregular = 1;
        set v_cant_cuotas = ifnull(new.cant_cuotas, 1);

        /*borrar las cuentas a pagar*/
        delete from ctas_pagar where cod_proveedor=old.cod_persona and cod_tipo_comprobante=old.cod_tipo_comprobante and nro_factura=old.nro_factura;

        /*reinsertar las ctas a pagar*/

        select ifnull(tipo_cuotas, 0),ifnull(dias_a,0),ifnull(dias_b,0),ifnull(dias_c,0),ifnull(dias_d,0),ifnull(dias_e,0),ifnull(dias_f,0),ifnull(cant_cuotas,1) into
             v_tipo_vence,v_dias1,v_dias2,v_dias3,v_dias4,v_dias5,v_dias6,v_cant_cuotas
          from plazos where cod_plazo = new.cod_plazo ;

        if (select ifnull(tipo_opcion, 0) FROM tipo_comprobante where cod_tipo_comprobante=new.cod_tipo_comprobante) = 0 then /*contado*/
                set v_cant_cuotas = 1;
        end if;

        if v_tipo_vence = 0 then /*es regular*/

          set counter = 1;
          WHILE counter <= v_cant_cuotas do
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                (new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, counter,new.cant_cuotas,/*new.fecha*/f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval new.dias*counter day )),
                 (new.fecha+new.dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.entrega_inicial) / v_cant_cuotas));

                set counter=counter +1;

          end while;
        end if;

         if v_tipo_vence = 1 then

          if v_cant_cuotas_iregular>=1 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 1,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias1 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

           if v_cant_cuotas_iregular>=2 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 2,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias2 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=3 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 3,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias3 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=4 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 4,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias4 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=5 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 5,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias5 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;

          if v_cant_cuotas_iregular>=6 then
                INSERT intO Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                values
                ( new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 6,v_cant_cuotas_iregular,f_calc_vence(new.cod_persona,ADDDATE(new.Fecha, interval v_dias6 day )),
                 (new.Fecha+new.Dias*counter),new.Cod_moneda,(((new.total_gravadas_10+new.total_gravadas_5 + new.total_exentas+new.total_impuesto_5+new.total_impuesto_10)-new.total_descuentos -new.Entrega_inicial) / v_cant_cuotas_iregular));
          end if;
        end if;

        if (select ifnull(Tipo_opcion, 1) FROM tipo_comprobante where cod_tipo_comprobante=new.cod_tipo_comprobante) = 1 and new.entrega_inicial>0 then /*credito y con entrega inicial*/
                INSERT into Ctas_pagar
                (fecha_emision, nro_oc, cod_proveedor, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, vencimiento_original, Cod_moneda, valor)
                 values(new.fecha, new.nro_oc, new.cod_persona, new.cod_tipo_comprobante,new.Nro_factura, 900 ,900,f_calc_vence(new.cod_persona,new.Fecha),new.Fecha,new.Cod_moneda,new.entrega_inicial);
        end if;


        if (select estado from ordenes_compra where nro_oc=new.nro_oc) not in('D','F') then
                update ordenes_compra set estado = 'F' where nro_oc = new.nro_oc;
        end if;
       END


/*borrado de compras*/

CREATE TRIGGER tad_factura_proveedor after delete ON factura_proveedor
FOR EACH ROW
BEGIN
declare v_max integer;
        /*borrar las cuentas a pagar*/
        delete from ctas_pagar where cod_proveedor=old.cod_persona and cod_tipo_comprobante=old.cod_tipo_comprobante and nro_factura=old.nro_factura;
        update ordenes_compra set estado = 'G' where nro_oc = old.nro_oc;

        select ifnull(max(primario),0)+1 into v_max
        from auditorias.auditoria_compras_ventas;

         insert into auditorias.auditoria_compras_ventas
         (primario,Fecha, Usuario, Tabla, Operacion, Nro_reg, importe)
         values(v_max,now(),CURRENT_USER, 'FACTURA_PROVEEDOR', 'D', old.Nro_registro, (old.total_exentas+old.total_gravadas_10 + old.total_gravadas_5));

  END

/*Borrado de factura proveedor*/
CREATE TRIGGER tbd_factura_proveedor before delete ON factura_proveedor
FOR EACH ROW
  BEGIN
    delete from detalle_factura_proveedor where nro_registro=old.nro_registro;
  END
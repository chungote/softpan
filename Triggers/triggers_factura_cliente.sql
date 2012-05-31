
CREATE TRIGGER tai_factura_cliente after insert ON factura_cliente
FOR EACH ROW
 BEGIN
        declare v_nro_registro  float;
        declare v_cant_cuotas integer;
        declare v_tipo_vence integer;
        declare v_fecha_vence date;
        declare v_dias smallint;
        declare v_dias1 smallint;
        declare v_dias2 smallint;
        declare v_dias3 smallint;
        declare v_dias4 smallint;
        declare v_dias5 smallint;
        declare v_dias6 smallint;
        declare contador smallint;
        declare v_estado smallint;
        declare v_valor_cobrador float;
        declare v_cant_cuotas_iregular smallint;

          DECLARE my_error CONDITION FOR SQLSTATE '45000';

          select estado into v_estado from tipo_comprobante
          where cod_tipo_comprobante=new.cod_tipo_comprobante;

            set v_cant_cuotas = ifnull(new.cant_cuotas,1);

            select ifnull(tipo_cuotas, 0),
                   ifnull(dias_a,0),
                   ifnull(dias_b,0),
                   ifnull(dias_c,0),
                   ifnull(dias_d,0),
                   ifnull(dias_e,0),
                   ifnull(dias_f,0),
                   ifnull(cant_cuotas,1)
            into   v_tipo_vence,
                   v_dias1,
                   v_dias2,
                   v_dias3,
                   v_dias4,
                   v_dias5,
                   v_dias6,
                   v_cant_cuotas_iregular
            from plazos_ventas where plazos_ventas.cod_plazo= new.cod_condicion ;

             if exists(select * from ctas_cobrar where cod_cliente=new.cod_persona and nro_factura=new.nro_factura and cod_tipo_comprobante=new.cod_tipo_comprobante and nro_cuota=new.cant_cuotas) then
              begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = 'Ya se registraron ctas a cobrar con ese nro de documento, proveedor y tipo de comprobante';
              end;
            end if;

             if (Select ifnull(Tipo_opcion, 1) FROM tipo_comprobante where cod_tipo_comprobante = new.cod_tipo_comprobante)=0 then /*contado*/
                   set v_cant_cuotas = 1;

                  INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, estado)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 1 , new.cant_cuotas,current_date(), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial))*-1,v_estado);
                 /*insertamos cobro automatico en la ficha de cobros*/
                 if (select ifnull(cobro_automatico,0) from parametros_ventas)=1 then /*parametros de ventas*/
                        call sp_inserta_cobros_clientes(new.cod_persona,new.cod_moneda,1,new.fecha_factura,new.Nro_factura,(new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 ),new.cod_tipo_comprobante,new.nro_cuenta,new.cod_condicion);
                 end if;
                end if;

             if (Select ifnull(Tipo_opcion, 1) FROM tipo_comprobante where cod_tipo_comprobante = new.cod_tipo_comprobante)=1 then /*credito*/
                 set v_dias=new.dias;
             /*es regular*/
               if v_tipo_vence = 0 then
                 set contador = 1;
                WHILE contador <= v_cant_cuotas do
                   INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, estado)
                    values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, contador , new.cant_cuotas,DATE_ADD(ifnull(new.inicio_vence,current_date()), INTERVAL -30 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas)*-1,v_estado);
                        set contador=contador +1;

                end while;
               end if;

             if v_tipo_vence = 1 then
                if v_cant_cuotas_iregular>=1 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 1,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias1 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=2 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 2,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias2 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
                if v_cant_cuotas_iregular>=3 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 3,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias3 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=4 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 4,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias4 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=5 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 5,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias5 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=6 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 6,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias6 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;

           end if;
        end if;
         if (Select Tipo_opcion FROM tipo_comprobante where cod_tipo_comprobante = new.cod_tipo_comprobante) = 1 AND (new.Entrega_inicial ) > 0 then
                INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura, Nro_cuota, Cuotas, Vencimiento, Cod_moneda,  Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 900,900,new.fecha_factura, new.cod_moneda, new.Entrega_inicial,v_estado);
          end if;

                if new.nro_pedido is not null then
                 update pedido_cliente
                 set estado_pedido=2
                 where nro_pedido=new.nro_pedido;
                end if;

 END
/***************Actualizacion de la Factura Cliente*********************/
drop TRIGGER tau_factura_cliente
CREATE TRIGGER tau_factura_cliente after update ON factura_cliente
FOR EACH ROW
 BEGIN
        declare v_nro_registro  float;
        declare v_cant_cuotas integer;
        declare v_tipo_vence integer;
        declare v_fecha_vence date;
        declare v_dias smallint;
        declare v_dias1 smallint;
        declare v_dias2 smallint;
        declare v_dias3 smallint;
        declare v_dias4 smallint;
        declare v_dias5 smallint;
        declare v_dias6 smallint;
        declare contador smallint;
        declare v_estado smallint;
        declare v_valor_cobrador float;
        declare v_cant_cuotas_iregular smallint;

          DECLARE my_error CONDITION FOR SQLSTATE '45000';

          select estado into v_estado from tipo_comprobante
          where cod_tipo_comprobante=new.cod_tipo_comprobante;

            set v_cant_cuotas = ifnull(new.cant_cuotas,1);

            select ifnull(tipo_cuotas, 0),
                   ifnull(dias_a,0),
                   ifnull(dias_b,0),
                   ifnull(dias_c,0),
                   ifnull(dias_d,0),
                   ifnull(dias_e,0),
                   ifnull(dias_f,0),
                   ifnull(cant_cuotas,1)
            into   v_tipo_vence,
                   v_dias1,
                   v_dias2,
                   v_dias3,
                   v_dias4,
                   v_dias5,
                   v_dias6,
                   v_cant_cuotas_iregular
            from plazos_ventas where plazos_ventas.cod_plazo= new.cod_condicion ;

            /* if exists(select * from ctas_cobrar where cod_cliente=new.cod_persona and nro_factura=new.nro_factura and cod_tipo_comprobante=new.cod_tipo_comprobante and nro_cuota=new.cant_cuotas) then
              begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = 'Ya se registraron ctas a cobrar con ese nro de documento, proveedor y tipo de comprobante';
              end;
            end if;*/
            /* Eliminamos las ctas a cobrar a fin de reingresarlas nuevamente*/
            delete from ctas_cobrar where nro_factura=old.nro_factura and cod_tipo_comprobante= old.cod_tipo_comprobante and cod_cliente=old.cod_persona;

             if (Select ifnull(Tipo_opcion, 1) FROM tipo_comprobante where cod_tipo_comprobante = new.cod_tipo_comprobante)=0 then /*contado*/
                   set v_cant_cuotas = 1;

                INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, estado)
                values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 1 , new.cant_cuotas,current_date(), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial))*-1,v_estado);
		if (select ifnull(cobro_automatico,0) from parametros_ventas)=1 then /*parametros de ventas*/
                         call sp_inserta_cobros_clientes(new.cod_persona,new.cod_moneda,1,new.fecha_factura,new.Nro_factura,(new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 ),new.cod_tipo_comprobante,new.nro_cuenta,new.cod_condicion);
                end if;

            end if;

             if (Select ifnull(Tipo_opcion, 1) FROM tipo_comprobante where cod_tipo_comprobante = new.cod_tipo_comprobante)=1 then /*credito*/
                 set v_dias=new.dias;
             /*es regular*/
               if v_tipo_vence = 0 then
                 set contador = 1;
                WHILE contador <= v_cant_cuotas do
                   INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, estado)
                    values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, contador , new.cant_cuotas,DATE_ADD(ifnull(new.inicio_vence,current_date()), INTERVAL -30 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas)*-1,v_estado);
                        set contador=contador +1;

                end while;
               end if;

             if v_tipo_vence = 1 then
                if v_cant_cuotas_iregular>=1 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 1,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias1 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=2 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 2,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias2 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
                if v_cant_cuotas_iregular>=3 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 3,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias3 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=4 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 4,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias4 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=5 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 5,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias5 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;
               if v_cant_cuotas_iregular>=6 then
                 INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura,Nro_cuota, Cuotas, Vencimiento, Cod_moneda, Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 6,v_cant_cuotas_iregular,DATE_ADD(new.inicio_vence, INTERVAL v_dias6 DAY), new.cod_moneda, ((new.Importe_exento + new.Importe_gravado_10 + new.Importe_impuesto_10  + new.Importe_gravado_5 + new.Importe_impuesto_5 - new.Entrega_inicial) / v_cant_cuotas_iregular,v_estado));
               end if;

           end if;
        end if;
         if (Select Tipo_opcion FROM tipo_comprobante where cod_tipo_comprobante = new.cod_tipo_comprobante) = 1 AND (new.Entrega_inicial ) > 0 then
                INSERT INTO Ctas_cobrar (fecha_emision, Cod_cliente, cod_tipo_comprobante, nro_factura, Nro_cuota, Cuotas, Vencimiento, Cod_moneda,  Valor, ESTADO)
                 values (new.fecha_factura, new.cod_persona, new.cod_tipo_comprobante, new.Nro_factura, 900,900,new.fecha_factura, new.cod_moneda, new.Entrega_inicial,v_estado);
          end if;
         update pedido_cliente
         set estado_pedido=2
         where nro_pedido=new.nro_pedido;

 END



/****************Borrado de la Factura Cliente Cabecera********************/
CREATE TRIGGER tad_factura_cliente after delete ON factura_cliente
FOR EACH ROW
 BEGIN
        DECLARE v_nro_registro  float;
        DECLARE my_error CONDITION FOR SQLSTATE '45000';
        IF (SELECT Sum(Ctas_cobrar.valor_cobrado) FROM  Ctas_cobrar where cod_tipo_comprobante = old.cod_tipo_comprobante  AND nro_factura = old.Nro_factura) > 0 then
                begin
                SIGNAL SQLSTATE VALUE '45000'
                        SET MESSAGE_TEXT = '¡Esta venta ya tuvo cobros y no puede borrarse, para poder borrar, borre primero los cobros!';
                end;
                end if;
                update pedido_cliente
                set estado_pedido=1,
                nro_factura=0
                where nro_pedido=old.nro_pedido;

 END

/*******before delete, es decir antes del borrado de la venta de la cabecera**********/
DROP TRIGGER tbd_pedido_cliente
CREATE TRIGGER tbd_pedido_cliente before delete ON factura_cliente
FOR EACH ROW
 BEGIN
        DECLARE v_nro_registro  float;
        DECLARE my_error CONDITION FOR SQLSTATE '45000';
        IF (SELECT Sum(Ctas_cobrar.valor_cobrado) FROM  Ctas_cobrar where cod_tipo_comprobante = old.cod_tipo_comprobante  AND nro_factura = old.Nro_factura) > 0 then
                begin
                SIGNAL SQLSTATE VALUE '45000'
                        SET MESSAGE_TEXT = '¡Esta venta ya tuvo cobros y no puede borrarse, para poder borrar, borre primero los cobros!';
                end;
        END IF;

       IF EXISTS(SELECT * FROM detalle_factura_cliente where nro_registro=old.nro_registro) then
         DELETE  FROM detalle_factura_cliente  where nro_registro = old.nro_registro;
       END IF;

      IF EXISTS(SELECT * FROM  Ctas_cobrar where cod_tipo_comprobante = old.cod_tipo_comprobante  AND nro_factura = old.Nro_factura) then
        DELETE Ctas_cobrar FROM  Ctas_cobrar where cod_tipo_comprobante = old.cod_tipo_comprobante  AND nro_factura = old.Nro_factura;
      END IF;

 END

/***************************************************************************************************************/
drop trigger tbi_factura_cliente
drop trigger tbi_factura_cliente
CREATE TRIGGER tbi_factura_cliente before insert ON factura_cliente
FOR EACH ROW
 BEGIN
   DECLARE v_nro_registro  float;
   DECLARE my_error CONDITION FOR SQLSTATE '45000';
   IF new.cod_persona is null then
      BEGIN
        SIGNAL SQLSTATE VALUE '45000'
        SET MESSAGE_TEXT = 'Persona no puede ser nulo!';
      END;

   END IF;

   set new.fecha_proceso=CURRENT_DATE;
   set new.nombre_cliente=(select nombre_cliente from clientes where cod_cliente=new.cod_persona);
 END

drop trigger tbu_factura_cliente
 CREATE TRIGGER tbu_factura_cliente before update ON factura_cliente
FOR EACH ROW
 BEGIN
   set new.fecha_proceso=CURRENT_DATE;
 END



/*insercion */

/*drop trigger tai_pagos_doc*/
CREATE TRIGGER tai_pagos_doc after insert ON pagos_doc
FOR EACH ROW
BEGIN

        declare v_fecha varchar(200);
	declare v_fecha_pago date;
        declare v_nro_recibo varchar(200);
        declare v_cod_moneda integer;
        declare v_monto_pag float;
        declare v_aux int;
        declare v_proveedor int;
        declare done int;

        declare cursor_pagos cursor for
        select  pagos.fecha_pago as fechapago,
	  concat(cast(day(pagos.fecha_pago) as char(2)),'-',cast(month(pagos.fecha_pago) as char(2)),'-',cast(year(pagos.fecha_pago) as char(4))) as fecha_pago,
          cast(pagos.nro_recibo as char) as nro_recibo,
          pagos.cod_moneda as moneda,
          pagos_doc.valor_pagado as valor
         from pagos, pagos_doc
         where pagos.Nro_pago = pagos_doc.Nro_pago and
          pagos_doc.cod_tipo_comprobante = new.cod_tipo_comprobante and
          pagos_doc.nro_documento =new.nro_documento and
          pagos_doc.nro_cuota = new.nro_cuota and
          pagos.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago) and
          pagos_doc.finiquito != 0;

         DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
    OPEN cursor_pagos;
    REPEAT
        FETCH cursor_pagos
        INTO v_fecha_pago,v_fecha,v_nro_recibo,v_cod_moneda,v_monto_pag;
        if not done then
                set v_fecha = concat(v_fecha, '|' , v_fecha);
                set v_nro_recibo = concat(v_nro_recibo , '-' , v_nro_recibo);
                set v_monto_pag = ifnull(v_monto_pag, 0) + v_monto_pag;
        end if;
    UNTIL done  END REPEAT;
    CLOSE cursor_pagos;

     UPDATE Ctas_pagar
     SET Ctas_pagar.Nros_recibos = ifnull(v_nro_recibo, ''),
         Ctas_pagar.Fechas_pago = ifnull(v_fecha, ''),
	 Ctas_pagar.Fecha_pago =v_fecha_pago,			
         Ctas_pagar.Valor_pagado = ifnull(v_monto_pag,0),
	 Ctas_pagar.nro_pago=new.nro_pago
     where Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
         Ctas_pagar.nro_factura = new.nro_documento and
         Ctas_pagar.Nro_cuota = new.nro_cuota and
         Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1);


          if  ((select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo
          FROM Ctas_pagar
          where Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
                Ctas_pagar.nro_factura = new.nro_documento and
                Ctas_pagar.Nro_cuota = new.nro_cuota and
                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1)) >= 0
                and
                (select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo FROM Ctas_pagar
                where Ctas_pagar.cod_tipo_comprobante =  new.cod_tipo_comprobante AND
                        Ctas_pagar.nro_factura= new.nro_documento and
                        Ctas_pagar.Nro_cuota =  new.nro_cuota and
                        Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1)) <=  0) and (new.finiquito=1) then

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 1
                        where   Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = new.nro_documento and
                                Ctas_pagar.Nro_cuota = new.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1);
          else

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 0
                        where   Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = new.nro_documento and
                                Ctas_pagar.Nro_cuota = new.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1);
          end if;



end

/*actualizacion*/

/*drop trigger tau_pagos_doc*/

CREATE TRIGGER tau_pagos_doc after update ON pagos_doc
FOR EACH ROW
BEGIN
	declare v_fecha_pago date;
        declare v_fecha varchar(200);
        declare v_nro_recibo varchar(200);
        declare v_cod_moneda integer;
        declare v_monto_pag float;
        declare v_aux int;
        declare v_proveedor int;
        declare done int default 0;
        /*declaramos el cursor de old*/
        declare cursor_pagos cursor for
        select  pagos.fecha_pago as fechapago,
	  concat(cast(day(pagos.fecha_pago) as char(2)),'-',cast(month(pagos.fecha_pago) as char(2)),'-',cast(year(pagos.fecha_pago) as char(4))) as fecha_pago,
          cast(pagos.nro_recibo as char) as nro_recibo,
          pagos.cod_moneda as moneda,
          pagos_doc.valor_pagado as valor
         from pagos, pagos_doc
         where pagos.Nro_pago = pagos_doc.Nro_pago and
          pagos_doc.cod_tipo_comprobante = old.cod_tipo_comprobante and
          pagos_doc.nro_documento =old.nro_documento and
          pagos_doc.nro_cuota = old.nro_cuota and
          pagos.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago) and
          pagos_doc.Nro_pago=old.nro_pago and
          pagos_doc.finiquito != 0;
        /*declaramos el cursor de new*/
        declare cursor_pagos1 cursor for
        select  concat(cast(day(pagos.fecha_pago) as char(2)),'-',cast(month(pagos.fecha_pago) as char(2)),'-',cast(year(pagos.fecha_pago) as char(4))) as fecha_pago,
          cast(pagos.nro_recibo as char) as nro_recibo,
          pagos.cod_moneda as moneda,
          pagos_doc.valor_pagado as valor
         from pagos, pagos_doc
         where pagos.Nro_pago = pagos_doc.Nro_pago and
          pagos_doc.cod_tipo_comprobante = new.cod_tipo_comprobante and
          pagos_doc.nro_documento =new.nro_documento and
          pagos_doc.nro_cuota = new.nro_cuota and
          pagos.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago) and
          pagos_doc.Nro_pago=new.nro_pago and
          pagos_doc.finiquito != 0;

         DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
         OPEN cursor_pagos;
                REPEAT
                        FETCH cursor_pagos
                        INTO v_fecha_pago, v_fecha,v_nro_recibo,v_cod_moneda,v_monto_pag;
                        if not done then
                                set v_fecha = concat(v_fecha, '|' , v_fecha);
                                set v_nro_recibo = concat(v_nro_recibo , '-' , v_nro_recibo);
                                set v_monto_pag = ifnull(v_monto_pag, 0) + v_monto_pag;
                        end if;
        UNTIL done  END REPEAT;
        CLOSE cursor_pagos;

     UPDATE Ctas_pagar
     SET Ctas_pagar.Nros_recibos = ifnull(v_nro_recibo, ''),
	 CTAS_PAGAR.fecha_pago=v_fecha_pago,
         Ctas_pagar.Fechas_pago = ifnull(v_fecha, ''),
         Ctas_pagar.Valor_pagado = ifnull(v_monto_pag,0)
     where Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
         Ctas_pagar.nro_factura = old.nro_documento and
         Ctas_pagar.Nro_cuota = old.nro_cuota and
         Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1);


          if  ((select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo
          FROM Ctas_pagar
          where Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
                Ctas_pagar.nro_factura = old.nro_documento and
                Ctas_pagar.Nro_cuota = old.nro_cuota and
                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1)) >= 0
                and
                (select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo FROM Ctas_pagar
                where Ctas_pagar.cod_tipo_comprobante =  old.cod_tipo_comprobante AND
                        Ctas_pagar.nro_factura= old.nro_documento and
                        Ctas_pagar.Nro_cuota =  old.nro_cuota and
                        Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1)) <=  0) and (old.finiquito=1) then

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 1
                        where   Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = old.nro_documento and
                                Ctas_pagar.Nro_cuota = old.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1);
          else

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 0
                        where   Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = old.nro_documento and
                                Ctas_pagar.Nro_cuota = old.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1);
          end if;

        /*ahora con new*/
        set v_fecha='';
        set v_nro_recibo='';
        set v_cod_moneda=0;
        set v_monto_pag=0;

        /* DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_aux = 1;*/

         OPEN cursor_pagos1;
                REPEAT
                        FETCH cursor_pagos1
                        INTO v_fecha,v_nro_recibo,v_cod_moneda,v_monto_pag;
                        if not done then
                                set v_fecha = concat(v_fecha, '|' , v_fecha);
                                set v_nro_recibo = concat(v_nro_recibo , '-' , v_nro_recibo);
                                set v_monto_pag = ifnull(v_monto_pag, 0) + v_monto_pag;
                        end if;
        UNTIL done  END REPEAT;
        CLOSE cursor_pagos1;

     UPDATE Ctas_pagar
     SET Ctas_pagar.Nros_recibos = ifnull(v_nro_recibo, ''),
         Ctas_pagar.Fechas_pago = ifnull(v_fecha, ''),
         Ctas_pagar.Valor_pagado = ifnull(v_monto_pag,0)
     where Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
         Ctas_pagar.nro_factura = new.nro_documento and
         Ctas_pagar.Nro_cuota = new.nro_cuota and
         Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1);


          if  ((select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo
          FROM Ctas_pagar
          where Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
                Ctas_pagar.nro_factura = new.nro_documento and
                Ctas_pagar.Nro_cuota = new.nro_cuota and
                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1)) >= 0
                and
                (select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo FROM Ctas_pagar
                where Ctas_pagar.cod_tipo_comprobante =  new.cod_tipo_comprobante AND
                        Ctas_pagar.nro_factura= new.nro_documento and
                        Ctas_pagar.Nro_cuota =  new.nro_cuota and
                        Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1)) <=  0) and (new.finiquito=1) then

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 1
                        where   Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = new.nro_documento and
                                Ctas_pagar.Nro_cuota = new.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1);
          else

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 0
                        where   Ctas_pagar.cod_tipo_comprobante = new.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = new.nro_documento and
                                Ctas_pagar.Nro_cuota = new.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=new.nro_pago limit 1);
          end if;
end



/*drop trigger tad_pagos_doc*/

CREATE TRIGGER tad_pagos_doc after delete ON pagos_doc
FOR EACH ROW
BEGIN

        declare v_fecha varchar(200);
        declare v_nro_recibo varchar(200);
        declare v_cod_moneda integer;
        declare v_monto_pag float;
        declare v_aux int;
        declare v_proveedor int;
        declare done int default 0;
        /*declaramos el cursor de old*/
        declare cursor_pagos cursor for
        select  concat(cast(day(pagos.fecha_pago) as char(2)),'-',cast(month(pagos.fecha_pago) as char(2)),'-',cast(year(pagos.fecha_pago) as char(4))) as fecha_pago,
          cast(pagos.nro_recibo as char) as nro_recibo,
          pagos.cod_moneda as moneda,
          pagos_doc.valor_pagado as valor
         from pagos, pagos_doc
         where pagos.Nro_pago = pagos_doc.Nro_pago and
          pagos_doc.cod_tipo_comprobante = old.cod_tipo_comprobante and
          pagos_doc.nro_documento =old.nro_documento and
          pagos_doc.nro_cuota = old.nro_cuota and
          pagos.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago) and
          pagos_doc.Nro_pago=old.nro_pago and
          pagos_doc.finiquito != 0;


         DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
         OPEN cursor_pagos;
                REPEAT
                        FETCH cursor_pagos
                        INTO v_fecha,v_nro_recibo,v_cod_moneda,v_monto_pag;
                        if not done then
                                set v_fecha = concat(v_fecha, '|' , v_fecha);
                                set v_nro_recibo = concat(v_nro_recibo , '-' , v_nro_recibo);
                                set v_monto_pag = ifnull(v_monto_pag, 0) + v_monto_pag;
                        end if;
        UNTIL done  END REPEAT;
        CLOSE cursor_pagos;

     UPDATE Ctas_pagar
     SET Ctas_pagar.Nros_recibos = ifnull(v_nro_recibo, ''),
         Ctas_pagar.Fechas_pago = ifnull(v_fecha, ''),
         Ctas_pagar.Valor_pagado = ifnull(v_monto_pag,0)
     where Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
         Ctas_pagar.nro_factura = old.nro_documento and
         Ctas_pagar.Nro_cuota = old.nro_cuota and
         Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1);


          if  ((select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo
          FROM Ctas_pagar
          where Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
                Ctas_pagar.nro_factura = old.nro_documento and
                Ctas_pagar.Nro_cuota = old.nro_cuota and
                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1)) >= 0
                and
                (select (Ctas_pagar.Valor - Ctas_pagar.Valor_pagado) as saldo FROM Ctas_pagar
                where Ctas_pagar.cod_tipo_comprobante =  old.cod_tipo_comprobante AND
                        Ctas_pagar.nro_factura= old.nro_documento and
                        Ctas_pagar.Nro_cuota =  old.nro_cuota and
                        Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1)) <=  0) and (old.finiquito=1) then

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 1
                        where   Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = old.nro_documento and
                                Ctas_pagar.Nro_cuota = old.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1);
          else

                        UPDATE Ctas_pagar
                        SET Ctas_pagar.pagado = 0
                        where   Ctas_pagar.cod_tipo_comprobante = old.cod_tipo_comprobante AND
                                Ctas_pagar.nro_factura = old.nro_documento and
                                Ctas_pagar.Nro_cuota = old.nro_cuota and
                                Ctas_pagar.cod_proveedor = (select cod_proveedor from pagos where nro_pago=old.nro_pago limit 1);
          end if;




end


DROP TRIGGER tai_pagos_det
CREATE TRIGGER tai_pagos_det after insert ON pagos_det
FOR EACH ROW
BEGIN
        if new.cod_condicion=2 then
                update cheques
                set op=1,
                    nro_op=new.nro_pago
                where nro_cheque=new.nro_cheque
                and nro_cta=new.nro_cuenta;
        end if;

end


DROP TRIGGER tad_pagos_det
CREATE TRIGGER tad_pagos_det after delete ON pagos_det
FOR EACH ROW
BEGIN
        if old.cod_condicion=2 then
                if (select impreso from cheques where  cheques.nro_cta = old.nro_cuenta and cheques.nro_cheque = old.nro_cheque) = 1 then

                    update cheques
                    set anulado = 1, importe_anulado = importe, importe = 0
                    where nro_cta = old.nro_cuenta
                     and nro_cheque = old.nro_cheque;
                end if;

        else
                 delete from cheques where nro_cta = old.nro_cuenta and nro_cheque =old.nro_cheque;

           end if;

end
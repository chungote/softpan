

CREATE FUNCTION f_costo(v_codigo numeric(6), v_tipo_costeo smallint, v_fecha date)
 RETURNS float
  BEGIN
        declare v_cod_moneda_producto integer;
        declare v_compuesto integer;
        declare v_cod_moneda integer;
        declare v_costo float;
        declare v_cantidad float;
        declare v_cantidad_original float;
        declare v_cant_bonif float;
        declare v_cant_desc float;
        declare v_precio float;
        declare v_tipo float;
        declare v_fecha_oper date;
        declare v_stock float;
        declare v_fecha_ini date;
        declare v_done integer;
        declare v_precio_new float;
        declare v_precio_new2 float;
        declare v_costo_tota float;


    select  v_compuesto = es_compuesto,
          v_tipo_costeo = ifnull(calculo_costo,0) from productos where cod_producto =v_codigo;

    set  v_costo = 0;
   /* set  v_fecha_ini='31-12-2009';*/

        declare cursor_costos cursor for
        SELECT  factura_proveedor.cod_moneda,
                factura_proveedor.fecha,
                sum(detalle_factura_proveedor.cantidad),
                sum(detalle_factura_proveedor.cantidad_bonif),
                sum(detalle_factura_proveedor.cantidad * detalle_factura_proveedor.precio),
                sum(detalle_factura_proveedor.cantidad * ( detalle_factura_proveedor.precio + (detalle_factura_proveedor.precio * detalle_factura_proveedor.COSTO_BRUTO_ADD / 100)+ detalle_factura_proveedor.Importe_costo_adicional_bruto) /*+ (cant_desc * precio)*/) ,
                1 as tipo
      from      factura_proveedor,
                detalle_factura_proveedor
      where     factura_proveedor.nro_registro = detalle_factura_proveedor.nro_registro and
                detalle_factura_proveedor.cod_producto = v_codigo and
                ( (factura_proveedor.fecha > v_fecha_ini or v_fecha_ini is null) and factura_proveedor.fecha <= v_fecha )
      group by  cod_moneda,
                fecha,
                cod_tipo_comprobante,
                nro_factura
 UNION ALL
  SELECT         cod_moneda,
                fecha_nc,
                sum(cantidad),
                0,
                sum(cantidad * precio),
                sum(cantidad * ( precio + Importe_costo_adicional_bruto) ) ,
                1 as tipo
      from      nota_credito_compra,
                detalle_nota_credito_compra
      where     nota_credito_compra.nro_registro = detalle_nota_credito_compra.nro_registro and
                detalle_nota_credito_compra.cod_producto = v_codigo and
                ( (nota_credito_compra.fecha_nc >v_fecha_ini or v_fecha_ini is null) and nota_credito_compra.fecha_nc <= v_fecha )
      group by  cod_moneda,
                fecha_nc,
                cod_tipo_nota,
                nro_nota

 UNION ALL
   SELECT        1,
                fecha_proceso,
                sum(cantidad * -1),
                0,
                0 ,
                0,
                2 as tipo
      from      factura_cliente,
                detalle_factura_cliente
      where     factura_cliente.nro_registro=detalle_factura_cliente.nro_registro and
                detalle_factura_cliente.cod_producto = v_codigo and
                ((factura_cliente.fecha_proceso > v_fecha_ini or v_fecha_ini is null) and factura_cliente.fecha_proceso <=v_fecha)
      group by fecha_proceso
 UNION ALL

      SELECT    productos.precio_costo,
                orden_realizada.fecha_registro,
                sum(detalle_orden_realizada.cantidad_producida),
                0,
                0,
                sum(recetas.costo_total_producto),
                1 as tipo
      from      orden_realizada,
                detalle_orden_realizada,
                productos,
                recetas
      where     orden_realizada.nro_registro=detalle_orden_realizada.nro_registro and
                detalle_orden_realizada.cod_producto = v_codigo and
                detalle_orden_realizada.cod_producto = productos.cod_producto and
                recetas.cod_producto=productos.cod_producto and
                ((orden_realizada.fecha_registro > v_fecha_ini or v_fecha_ini is null)  and orden_realizada.fecha_registro <= v_fecha)
      group by productos.precio_costo,
               orden_realizada.fecha_registro;
      DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_done = 1;
    OPEN cursor_costos;
    REPEAT
        FETCH cursor_costos
        INTO v_cod_moneda,v_fecha_oper,v_cantidad,v_cant_bonif,v_precio,v_precio_new,v_tipo;
                if not v_done then
                  if v_cantidad+v_cant_bonif<>0 then
                                set v_precio = v_precio / (v_cant_bonif + v_cantidad );
                   end if;
                        set v_cantidad = v_cantidad + v_cant_bonif;
                        set v_cantidad_original = v_cantidad;
                         if v_tipo = 1
                                if v_cantidad < 0 then
                                        set v_cantidad = v_cantidad * -1;
                                end if;
                                set v_precio = Cambiar_moneda1( v_cod_moneda, v_cod_moneda_producto, v_fecha_oper, v_precio);
                                 if v_stock + v_cantidad > 0 then
                                         if v_stock < 0 then
                                            set v_costo =v_precio;
                                         else
                                           set v_costo = ((v_costo * v_stock) + ((v_precio * v_cantidad)+v_cant_desc)) / (v_stock + v_cantidad);
                                         end if;
                                 end if;
                        else
                                 if v_precio > 0 then
                                        set v_costo = v_precio;
                                 end if;
                        end if;
                    end if;
        UNTIL v_done  END REPEAT;
        CLOSE cursor_costos;

       return v_costo;
 ENDfecha_proceso > @v_fecha_ini or @v_fecha_ini is null) and factura_cliente.fecha_proceso <= @v_fecha)
      group by fecha_proceso
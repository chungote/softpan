
--drop trigger tai_detalle_factura_proveedor
create trigger tai_detalle_factura_proveedor after insert on detalle_factura_proveedor
for each row
BEGIN

  declare v_cod_producto int;
  declare v_deposito int;
  declare v_fecha date;
  declare v_cantidad decimal(8,3);
  declare v_fecha_ult_comp date;
  declare v_proveedor int;
  declare v_valor_bruto_porc decimal(16,3);
  declare v_valor decimal(12,3);
  declare v_usuario varchar(15);
  declare v_valor_cif float;
  declare v_precio_costo float;


  select f.cod_deposito  into   v_deposito
  from factura_proveedor f
  where f.nro_registro =new.nro_registro;

  set v_cod_producto=new.cod_producto;
  set v_cantidad=(new.cantidad+new.cantidad_bonif);



  call Stock (v_cod_producto, v_deposito, v_cantidad , 1);

  /*actualizamos el costo en la ficha de productos */
        if(select calcula_costo from productos where cod_producto=new.cod_producto)=1 then
                select precio into v_precio_costo 
                                from pedido_proveedor,
                                     detalle_pedido_proveedor,
                                     ordenes_compra,
                                     detalle_ordenes_compra,
                                     factura_proveedor
                                where pedido_proveedor.nro_pedido=detalle_pedido_proveedor.nro_pedido
                                and      pedido_proveedor.nro_pedido  =detalle_ordenes_compra.nro_pedido
                                and  detalle_ordenes_compra.nro_oc=ordenes_compra.nro_oc
                                and   ordenes_compra.nro_oc=factura_proveedor.nro_oc
                                and factura_proveedor.nro_registro=new.nro_registro and cod_producto=new.cod_producto limit 1;

                /*precio costo anterior*/

                update productos
                set precio_costo_ant=ifnull(precio_costo,0)
                where cod_producto=new.cod_producto;

                /*nuevo precio costo*/
                update productos
                set precio_costo=v_precio_costo
                where cod_producto=new.cod_producto;
        end if;


                if ((new.cantidad + new.cantidad_bonif) * new.precio) > 0 then
                        select cod_persona into v_proveedor from factura_proveedor where nro_registro = new.nro_registro;
                        select fecha into v_fecha_ult_comp from factura_proveedor  where factura_proveedor.nro_registro=new.nro_registro;

                        set v_cantidad = new.cantidad;

                        select COSTO_BRUTO_ADD into v_valor_bruto_porc
                        from factura_proveedor where nro_registro=new.nro_registro;

                        set v_valor_cif = new.precio + new.Importe_costo_adicional_bruto;
                                        if v_valor_bruto_porc> 0 then
                                                        set v_valor_cif = v_valor_cif  + (v_valor_cif  * v_valor_bruto_porc / 100);
                                        end if;
                                                        update productos set Precio_compra = v_valor,
                                                                         Precio_compra_cif = v_valor_cif,
                                                                         fecha_ult_compra =  v_fecha
                                                        where cod_producto = new.cod_producto;

                                                              set v_valor=new.precio;
                                                                update proveedores_productos
                                                                set fec_ult_compra =v_fecha_ult_comp ,
                                                                precio_ult_compra= v_valor,
                                                                cant_ult_compra = v_cantidad
                                                                where cod_proveedor = v_proveedor  and cod_producto=new.cod_producto;

                end if;



         set v_usuario=CURRENT_USER;
         insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(now(),v_usuario, 'DETALLE_FACT_PROVEEDOR', 'I', new.Nro_registro, new.cod_producto, new.Cantidad, new.Precio);


end

/*******Borrado del detalle*/

create trigger tad_detalle_factura_proveedor after delete on detalle_factura_proveedor
for each row
BEGIN

  declare v_cod_producto int;
  declare v_deposito int;
  declare v_fecha date;
  declare v_cantidad decimal(8,3);
  declare v_fecha_ult_comp date;
  declare v_proveedor int;
  declare v_valor_bruto_porc decimal(16,3);
  declare v_valor decimal(12,3);
  declare v_usuario varchar(15);
  declare v_valor_cif float;


  select f.cod_deposito  into   v_deposito
  from factura_proveedor f
  where f.nro_registro =old.nro_registro;

  set v_cod_producto=old.cod_producto;
  set v_cantidad=(old.cantidad+old.cantidad_bonif);



  call Stock (v_cod_producto, v_deposito, v_cantidad , 0);
  set v_usuario=CURRENT_USER;
  insert into auditorias.auditoria_detalle_compras_ventas
  (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
  values(CURRENT_DATE(),v_usuario, 'DETALLE_FACT_PROVEEDOR', 'B', old.Nro_registro, old.cod_producto, old.Cantidad, old.Precio);


end
 /*********Actualizacion del detalle de factura proveedor*/
create trigger tau_detalle_factura_proveedor after update on detalle_factura_proveedor
for each row
BEGIN

  declare v_cod_producto int;
  declare v_deposito int;
  declare v_fecha date;
  declare v_cantidad decimal(8,3);
  declare v_cantidad_old decimal(8,3);
  declare v_fecha_ult_comp date;
  declare v_proveedor int;
  declare v_valor_bruto_porc decimal(16,3);
  declare v_valor decimal(12,3);
  declare v_valor_old decimal(12,3);
  declare v_usuario varchar(15);
  declare v_valor_cif float;
  declare v_valor_cif_old float;


  select f.cod_deposito  into   v_deposito
  from factura_proveedor f
  where f.nro_registro =new.nro_registro;

  set v_cod_producto=new.cod_producto;
  set v_cantidad=(new.cantidad+new.cantidad_bonif);
  set v_cantidad_old =(old.cantidad+old.cantidad_bonif);


   /*descontamos stock de old value*/
   call Stock (v_cod_producto, v_deposito, v_cantidad_old, 0);

   /*sumamos al stock el new value*/
   call Stock (v_cod_producto, v_deposito, v_cantidad , 1);

                if ((new.cantidad + new.cantidad_bonif) * new.precio) > 0 then
                        select cod_persona into v_proveedor from factura_proveedor where nro_registro = new.nro_registro;
                        select fecha into v_fecha_ult_comp from factura_proveedor  where factura_proveedor.nro_registro=new.nro_registro;

                        set v_cantidad = new.cantidad;

                        select COSTO_BRUTO_ADD into v_valor_bruto_porc
                        from factura_proveedor where nro_registro=new.nro_registro;

                        set v_valor_cif = new.precio + new.Importe_costo_adicional_bruto;
                        set v_valor_cif_old = old.precio + old.Importe_costo_adicional_bruto;
                                        if v_valor_bruto_porc> 0 then
                                                        set v_valor_cif = v_valor_cif  + (v_valor_cif  * v_valor_bruto_porc / 100);
                                                        set v_valor_cif_old = v_valor_cif_old +( v_valor_cif_old * v_valor_bruto_porc / 100);
                                        end if;
                                                        update productos set Precio_compra =Precio_compra+ v_valor,
                                                                         Precio_compra_cif = Precio_compra_cif-v_valor_cif+v_valor_cif_old ,
                                                                         fecha_ult_compra =  v_fecha
                                                        where cod_producto = new.cod_producto;

                                                              set v_valor=new.precio+(new.precio-old.precio);

                                                                update proveedores_productos
                                                                set precio_ult_compra= precio_ult_compra+v_valor,
                                                                cant_ult_compra = cant_ult_compra+(v_cantidad-v_cantidad_old)
                                                                where cod_proveedor = v_proveedor  and cod_producto=new.cod_producto;

                end if;



         set v_usuario=CURRENT_USER;
         insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),v_usuario, 'DETALLE_FACT_PROVEEDOR', 'MI', new.Nro_registro, new.cod_producto, new.Cantidad, new.Precio);

          insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),v_usuario, 'DETALLE_FACT_PROVEEDOR', 'MD', old.Nro_registro, old.cod_producto, old.Cantidad, old.Precio);


end
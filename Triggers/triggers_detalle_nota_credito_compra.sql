/*********************** after insert********************************************/
create trigger tai_detalle_nota_credito_compra after insert on detalle_nota_credito_compra
for each row
BEGIN

  declare v_cod_producto int;
  declare v_deposito int;
  declare v_cantidad decimal(8,3);
  declare v_proveedor int;
  declare v_valor decimal(12,3);
  declare v_usuario varchar(15);



  select f.cod_deposito  into   v_deposito
  from factura_proveedor f
  where f.nro_registro =new.nro_registro;

  set v_cod_producto=new.cod_producto;
  set v_cantidad=(new.cantidad_dev);



  call Stock (v_cod_producto, v_deposito, v_cantidad , 0);


  /*       set v_usuario=CURRENT_USER;
         insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),v_usuario, 'DETALLE_NC_COMPRA', 'I', new.Nro_registro, new.cod_producto, new.Cantidad_dev, new.Precio);*/


end



/*********************** after update********************************************/
create trigger tau_detalle_nota_credito_compra after update on detalle_nota_credito_compra
for each row
BEGIN

  declare v_cod_producto int;
  declare v_deposito int;
  declare v_cantidad decimal(8,3);
  declare v_proveedor int;
  declare v_valor decimal(12,3);
  declare v_usuario varchar(15);



  select f.cod_deposito  into   v_deposito
  from factura_proveedor f
  where f.nro_registro =new.nro_registro;

      /*los antiguos valores de la nc compra son ingresados*/

       call Stock (old.cod_producto, v_deposito, old.cantidad_dev , 1);
      /*los nuevos valores de la nc compra son restados*/
       call Stock (new.cod_producto, v_deposito, new.cod_producto , 0);

         /*auditamos nuevo valores*/

         set v_usuario=CURRENT_USER;
         insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),v_usuario, 'DETALLE_NC_COMPRA', 'MI', new.Nro_registro, new.cod_producto, new.Cantidad_dev, new.Precio);

        /*auditamos viejo valores*/
        insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),v_usuario, 'DETALLE_NC_COMPRA', 'MB', old.Nro_registro, old.cod_producto, old.Cantidad_dev, old.Precio);



end

/*********************** after delete********************************************/
create trigger tad_detalle_nota_credito_compra after delete on detalle_nota_credito_compra
for each row
BEGIN


  declare v_deposito int;



  select f.cod_deposito  into   v_deposito
  from factura_proveedor f
  where f.nro_registro =old.nro_registro;

      /*los antiguos valores de la nc compra son ingresados*/

       call Stock (old.cod_producto, v_deposito, old.cantidad_dev , 1);

        /*auditamos viejo valores*/
        insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),CURRENT_USER, 'DETALLE_NC_COMPRA', 'B', old.Nro_registro, old.cod_producto, old.Cantidad_dev, old.Precio);



end
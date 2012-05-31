/**BEFORE INSERT**/
drop trigger tbi_detalle_factura_cliente
create trigger tbi_detalle_factura_cliente before insert on detalle_factura_cliente
for each row
BEGIN
 declare v_porc_iva float;
 if (select porcentage_iva from tipo_iva where cod_tipo_iva=(select cod_tipo_iva from productos where cod_producto=new.cod_producto))=0 then
      set  new.tipo_fiscal=1;
 else
      set  new.tipo_fiscal=0;
 end if;
end

/**BEFORE UPDATE**/
drop trigger tbu_detalle_factura_cliente
create trigger tbu_detalle_factura_cliente before update on detalle_factura_cliente
for each row
BEGIN
 declare v_porc_iva float;
 if (select porcentage_iva from tipo_iva where cod_tipo_iva=(select cod_tipo_iva from productos where cod_producto=new.cod_producto))=0 then
      set  new.tipo_fiscal=1;
 else
      set  new.tipo_fiscal=0;
 end if;
end


/**AFTER INSERT **/
drop trigger tai_detalle_factura_cliente
create trigger tai_detalle_factura_cliente after insert on detalle_factura_cliente
for each row
BEGIN


  declare v_cod_producto int;
  declare v_deposito int;
  declare v_fecha date;
  declare v_cantidad decimal(8,3);
  declare v_fecha_ult_comp date;
  declare v_proveedor int;
  declare v_valor decimal(12,3);
  declare v_usuario varchar(15);
  declare v_precio_costo float;
  DECLARE my_error CONDITION FOR SQLSTATE '45000';

  IF NOT EXISTS(SELECT * FROM Productos where cod_producto=new.cod_producto ) then
    begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = 'Producto no encontrado en la ficha de Productos';
    end;
  END IF;
  if new.precio=0 and new.cantidad > 0 then

    begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = '¡Producto no tiene precio de lista o no puede ser (0)!';
    end;
  end if;

  select f.cod_deposito  into   v_deposito
  from factura_cliente f
  where f.nro_registro =new.nro_registro;

  set v_cod_producto=new.cod_producto;
  set v_cantidad=(new.cantidad);



  call Stock (v_cod_producto, v_deposito, v_cantidad , 0);
      set v_usuario=CURRENT_USER;

         insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(now(),v_usuario, 'DETALLE_FACT_CLIENTE', 'I', new.Nro_registro, new.cod_producto, new.Cantidad, new.Precio);


end



/*******Borrado del detalle*/
drop trigger tad_detalle_factura_cliente
create trigger tad_detalle_factura_cliente after delete on detalle_factura_cliente
for each row
BEGIN

  declare v_cod_producto int;
  declare v_deposito int;
  declare v_cantidad decimal(8,3);
  declare v_cliente int;
  declare v_valor decimal(12,3);
  declare v_usuario varchar(15);



  select f.cod_deposito  into   v_deposito
  from factura_cliente f
  where f.nro_registro =old.nro_registro;

  set v_cod_producto=old.cod_producto;
  set v_cantidad=old.cantidad;



  call Stock (v_cod_producto, v_deposito, v_cantidad , 1);
  set v_usuario=CURRENT_USER;
  insert into auditorias.auditoria_detalle_compras_ventas
  (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
  values(CURRENT_DATE(),v_usuario, 'DETALLE_FACT_CLIENTE', 'B', old.Nro_registro, old.cod_producto, old.Cantidad, old.Precio);


end

 /*********Actualizacion del detalle de factura proveedor*/
drop trigger tau_detalle_factura_cliente
create trigger tau_detalle_factura_cliente after update on detalle_factura_cliente
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
  set v_cantidad=(new.cantidad);
  set v_cantidad_old =(old.cantidad);


   /*sumamos al stock el old value*/
   call Stock (v_cod_producto, v_deposito, v_cantidad_old, 1);



   /*descontamos stock de new value*/
   call Stock (v_cod_producto, v_deposito, v_cantidad , 0);



         set v_usuario=CURRENT_USER;
         insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),v_usuario, 'DETALLE_FACT_CLIENTE', 'MI', new.Nro_registro, new.cod_producto, new.Cantidad, new.Precio);

          insert into auditorias.auditoria_detalle_compras_ventas
         (Fecha, Usuario, Tabla, Operacion, Nro_reg, cod_producto,cantidad,precio)
         values(CURRENT_DATE(),v_usuario, 'DETALLE_FACT_CLIENTE', 'MD', old.Nro_registro, old.cod_producto, old.Cantidad, old.Precio);


end
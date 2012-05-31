
CREATE  PROCEDURE sp_precio_cliente(v_cod_cliente numeric(6),v_condicion numeric(6),v_cod_producto numeric(6), OUT v_precio float)
Begin
        declare v_lista_precio integer;
        declare v_impuesto integer;
        declare v_imp_imp integer;
        declare v_tipo_precio integer;
        declare v_impuesto_inc integer;

        select v_tipo_precio = (SELECT ifnull(Clientes.tipo_precio,1) FROM Clientes   WHERE Clientes.Cod_cliente = v_cod_cliente);
        if v_tipo_precio = 1 then
                set v_lista_precio = (SELECT ifnull(Clientes.nro_lista,0) FROM Clientes  WHERE Clientes.Cod_cliente = v_cod_cliente);

        else
                set v_lista_precio = 1;
        End if;

        select v_precio = (SELECT precio_venta from lista_precios_det WHERE cod_producto=v_cod_producto and nro_lista = v_lista_precio);
        select v_impuesto_inc = (SELECT iva_inc from precios_det WHERE cod_producto=v_cod_producto and nro_lista = v_lista_precio);
        select v_imp_imp = (SELECT tipo_iva.porcentage_iva FROM Productos, Tipo_iva  where productos.cod_tipo_iva=tipo_iva.cod_tipo_iva and cod_producto = v_cod_producto)*10 ;
        if v_impuesto_inc <> 0 then
                set v_precio = v_precio /(v_imp_imp / 100 + 1);
        end if;


End


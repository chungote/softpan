/*after insert */

DROP TRIGGER tai_proveedores_productos;
CREATE TRIGGER tai_proveedores_productos after insert ON proveedores_productos
FOR EACH ROW
BEGIN
 DECLARE v_msg CHAR(100);
 DECLARE v_proveedor varchar(50);
 DECLARE my_error CONDITION FOR SQLSTATE '45000';

    SELECT concat(nombre_proveedor,'-',cast(cod_proveedor as char(3))) into v_proveedor
                        FROM proveedores    WHERE cod_proveedor=new.cod_proveedor;
    SET v_msg=concat('Ya existe proveedor principal para dicho producto',v_proveedor);

     if (select count(*) from proveedores_productos where cod_producto=new.cod_producto and  principal=1 )>0 then
           begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = v_msg;
           end;

      end if;
END;


DROP TRIGGER tau_proveedores_productos;
CREATE TRIGGER tau_proveedores_productos after update ON proveedores_productos
FOR EACH ROW
BEGIN
 DECLARE v_msg CHAR(100);
 DECLARE v_proveedor varchar(50);
 DECLARE my_error CONDITION FOR SQLSTATE '45000';

    SELECT concat(nombre_proveedor,'-',cast(cod_proveedor as char(3))) into v_proveedor
                        FROM proveedores    WHERE cod_proveedor=new.cod_proveedor;
    SET v_msg=concat('Ya existe proveedor principal para dicho producto',v_proveedor);

     if (select count(*) from proveedores_productos where cod_producto=new.cod_producto and  principal=1 )>0 then
           begin
                SIGNAL SQLSTATE VALUE '45000'
                SET MESSAGE_TEXT = v_msg;
           end;

      end if;
END;
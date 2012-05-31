DELIMITER $$

DROP FUNCTION IF EXISTS `softpan`.`f_stock_actual` $$
CREATE FUNCTION `softpan`.`f_stock_actual` (v_cod numeric(6), v_dep SMALLINT) RETURNS float
BEGIN
declare v_stock float;
declare v_tiene_stock int;

select tiene_stock into v_tiene_stock from productos where cod_producto =v_cod;

if v_tiene_stock= 1 then

     select sum(cantidad) into v_stock
     from movimiento_producto,
          deposito
    where     movimiento_producto.cod_deposito= deposito.cod_deposito and
        (movimiento_producto.cod_deposito= v_dep or v_dep = 0) and
        (cod_producto = v_cod);
end if;

return v_stock;

END $$

DELIMITER ;
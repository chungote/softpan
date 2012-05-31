/*******************BEFORE*************************/
drop trigger tbi_orden_produccion 
CREATE TRIGGER tbi_orden_produccion before insert on Orden_produccion
for each row
begin
	SET NEW.fecha_alta=now();	
end


drop trigger tbu_orden_produccion 
CREATE TRIGGER tbu_orden_produccion before insert on Orden_produccion
for each row
begin
	SET NEW.fecha_ult_mod=now();	
end




drop trigger tbi_detalle_orden_produccion
CREATE TRIGGER tbi_detalle_orden_produccion before insert ON detalle_orden_produccion
FOR EACH ROW
BEGIN
  if new.cod_medida=0 or isnull(new.cod_medida) then
              set  new.cod_medida=(select cod_medida from productos where cod_producto=new.cod_producto);
  end if;

END





drop trigger tbu_detalle_orden_produccion
CREATE TRIGGER tbu_detalle_orden_produccion before update ON detalle_orden_produccion
FOR EACH ROW
BEGIN
  if new.cod_medida=0 or isnull(new.cod_medida) then
              set  new.cod_medida=(select cod_medida from productos where cod_producto=new.cod_producto);
  end if;

END

/*******************AFTER*************************/

drop trigger tai_detalle_orden_produccion
CREATE TRIGGER tai_detalle_orden_produccion after insert ON detalle_orden_produccion
FOR EACH ROW
BEGIN

declare v_receta decimal(6);
declare v_cant float;
declare v_costo float;
declare v_deposito integer;
declare v_estado integer;

  /*if new.aprobado=1 then*/

        declare c_recetas cursor for
        select detalle_recetas.cod_producto,detalle_recetas.cantidad,detalle_recetas.precio_costo
        from detalle_recetas,recetas
        where detalle_recetas.cod_receta=recetas.cod_receta
        and recetas.cod_producto=new.cod_producto
        and new.aprobado=1;

        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_estado = 1;
        OPEN c_recetas;
         REPEAT
        FETCH c_recetas
        INTO v_receta,v_cant,v_costo;

        if not v_estado then

               select cod_deposito into v_deposito from movimiento_producto
               where cod_producto=v_receta and cantidad=(select max(cantidad) from movimiento_producto where cod_producto=v_receta);

                 call Stock (v_receta, v_deposito, (v_cantidad*new.cantidad_kgs) , 1);
        end if;
    UNTIL v_estado  END REPEAT;
    CLOSE c_recetas;

   /*end if;*/
end



drop trigger tad_detalle_orden_produccion
CREATE TRIGGER tad_detalle_orden_produccion after delete ON detalle_orden_produccion
FOR EACH ROW
BEGIN

declare v_receta decimal(6);
declare v_cant float;
declare v_costo float;
declare v_deposito integer;
declare v_estado integer;

  /*if new.aprobado=1 then*/

	

        declare c_recetas cursor for
        select detalle_recetas.cod_producto,detalle_recetas.cantidad,detalle_recetas.precio_costo
        from detalle_recetas,recetas
        where detalle_recetas.cod_receta=recetas.cod_receta
        and recetas.cod_producto=old.cod_producto
        and old.aprobado=1;

        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET v_estado = 1;
        OPEN c_recetas;
         REPEAT
        FETCH c_recetas
        INTO v_receta,v_cant,v_costo;

    if not v_estado then


	/*  select cod_deposito into v_deposito from orden_produccion   where orden_nro=old.orden_nro;*/

	
             select cod_deposito into v_deposito from movimiento_producto
               where cod_producto=v_receta and cantidad=(select max(cantidad) from movimiento_producto where cod_producto=v_receta);

                 call Stock (v_receta, v_deposito, (v_cantidad*old.cantidad_kgs) , 0);
    end if;
    UNTIL v_estado  END REPEAT;
    CLOSE c_recetas;

   /*end if;*/
end
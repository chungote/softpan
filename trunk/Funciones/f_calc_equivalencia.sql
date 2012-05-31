CREATE FUNCTION f_calc_equivalencia (vmed1 int, vmed2 int, vcant float)
RETURNS float
BEGIN
 declare v_equiv, v_valor, v_cantidad float;
 declare v_tipo_operacion int;

   set vcant=ifnull(vcant,0);


 if vcant=0 then
    return 0;
 end if;

 select operacion,ifnull(equivalencia,0) into v_tipo_operacion, v_equiv from equivalencias
 where cod_medida=vmed1 and cod_medida_1=vmed2;

 if vmed1=vmed2 then
   set v_equiv =1;
 end if;

 if v_equiv=0 then
    return 0;
 end if;

 if v_tipo_operacion=1 then
   set v_cantidad=vcant*v_equiv;
 end if;

 if v_tipo_operacion=0 then
   set v_cantidad=vcant/v_equiv;
 end if;


        return round(v_cantidad,3);
END

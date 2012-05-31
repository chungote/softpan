CREATE FUNCTION f_calc_vence (v_cod_proveedor int, v_fecha date)
RETURNS date
BEGIN
 declare v_fecha_vence date;
 declare v_dia_pago, v_dia_vence int;


 select dias_pago into v_dia_pago from personas where cod_persona=v_cod_proveedor;
 set v_dia_vence=DAYOFWEEK(v_fecha);

 if ifnull(v_dia_pago,0)=0 then
   return v_fecha;
 end if;

 if v_dia_vence=7 then
   set v_fecha_vence=ADDDATE(v_fecha, v_dia_pago +7);
   return v_fecha_vence;
 end if;

 if (v_Dia_Vence < v_dia_Pago) then
   set v_fecha_vence=ADDDATE(v_fecha, (v_dia_pago-v_dia_vence) +7);
   return v_fecha_vence;
 end if;

 if v_dia_vence=v_dia_Pago then
   set v_fecha_vence=ADDDATE(v_fecha, 14);
   return v_fecha_vence;
 end if;

 if v_dia_vence>v_dia_pago then
    set v_fecha_vence=ADDDATE(v_fecha, (14-v_dia_vence-v_dia_pago));
    return v_fecha_vence;
 end if;
        return v_fecha_vence;
END
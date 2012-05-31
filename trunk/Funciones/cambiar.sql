DELIMITER $$
DROP FUNCTION IF EXISTS `SOFTPAN`.`cambiar` $$
CREATE FUNCTION `SOFTPAN`.`cambiar` (Origen INT, Destino INT, v_Fecha date, Valor decimal(13,3))
RETURNS decimal(13,3)
BEGIN
DECLARE VCotizacion decimal(13,3);
DECLARE VMul_div decimal(13,3);
declare v_decimales int;
declare new_valor decimal(13,3);

select cant_dec into v_decimales from monedas where cod_moneda = Destino;

if v_decimales is null then
     set v_decimales = 5;
end if;
If (Origen = Destino) then
   if (v_decimales >= 5) then
   select new_valor = round(new_valor,5);
end if;
if (v_decimales = 4)then
     set new_valor = round(round(Valor,5),4);
end if;
if (v_decimales = 3)then

     set new_valor = round(round(round(Valor,5),4),3);
end if;
if (v_decimales = 2)then

     set new_valor = round(round(round(round(Valor,5),4),3),2);
end if;
if (v_decimales = 1)then

     set new_valor = round(round(round(round(round(Valor,5),4),3),2),1);
end if;
  if (v_decimales = 0)then

     set new_valor = round(round(round(round(round(round(Valor,5),4),3),2),1),0);
  end if;
  if (v_decimales < 0)then

     set new_valor = round(round(round(round(round(round(round(Valor,5),4),3),2),1),0),v_decimales);
  end if;
end if;

If (Origen = 0) then
   if (v_decimales >= 5) then
     set new_valor = round(Valor,5);
end if;
if (v_decimales = 4)then
     set new_valor = round(round(Valor,5),4);
end if;
if (v_decimales = 3)then
     set new_valor = round(round(round(Valor,5),4),3);
end if;
if (v_decimales = 2)then
     set new_valor = round(round(round(round(Valor,5),4),3),2);
end if;
if (v_decimales = 1)then
     set new_valor = round(round(round(round(round(Valor,5),4),3),2),1);
end if;
if (v_decimales = 0)then
     set new_valor = round(round(round(round(round(round(Valor,5),4),3),2),1),0);
end if;
if (v_decimales < 0)then
     set new_valor = round(round(round(round(round(round(round(Valor,5),4),3),2),1),0),v_decimales);
end if;
end if;

If (Destino = 0) then
   if (v_decimales >= 5) then
   set Valor = round(Valor,5);
end if;
if (v_decimales = 4)then
     set Valor = round(round(Valor,5),4);
end if;
if (v_decimales = 3)then

     set Valor = round(round(round(Valor,5),4),3);
end if;
if (v_decimales = 2)then

     set Valor = round(round(round(round(Valor,5),4),3),2);
end if;
if (v_decimales = 1)then

     set Valor = round(round(round(round(round(Valor,5),4),3),2),1);
end if;
if (v_decimales = 0)then

     set Valor = round(round(round(round(round(round(Valor,5),4),3),2),1),0);
end if;
if (v_decimales < 0)then

     set Valor = round(round(round(round(round(round(round(Valor,5),4),3),2),1),0),v_decimales);
end if;
end if;

SELECT valor_cotizacion into VCotizacion FROM cotizaciones_monedas
where fecha_cotizacion = v_Fecha and Cod_moneda_origen = Origen and Cod_moneda_destino = Destino;

SELECT operacion into VMul_div FROM cotizaciones_monedas
where fecha_cotizacion = v_Fecha and Cod_moneda_origen = Origen and Cod_moneda_destino = Destino;

If (VCotizacion <> 0) then
     If (VMul_div = 0) then
     set new_valor = (Valor * VCotizacion);
	    if (v_decimales >= 5) then
       set new_valor = round(Valor,5);
end if;
if (v_decimales = 4)then
     set new_valor = round(round(Valor,5),4);
end if;
if (v_decimales = 3)then

     set new_valor = round(round(round(Valor,5),4),3);
end if;
if (v_decimales = 2)then

     set new_valor = round(round(round(round(Valor,5),4),3),2);
end if;
if (v_decimales = 1)then

     set new_valor = round(round(round(round(round(Valor,5),4),3),2),1);
end if;
if (v_decimales = 0)then

     set new_valor = round(round(round(round(round(round(Valor,5),4),3),2),1),0);
end if;
if (v_decimales < 0)then

     set new_valor = round(round(round(round(round(round(round(Valor,5),4),3),2),1),0),v_decimales);
end if;
 	  END if;
     If (VMul_div = 1) then
         set new_valor = (Valor / VCotizacion);
    	  if (v_decimales >= 5) then
   set new_valor = round(Valor,5);
end if;
if (v_decimales = 4)then
     set new_valor = round(round(Valor,5),4);
end if;
if (v_decimales = 3)then

     set new_valor = round(round(round(Valor,5),4),3);
end if;
if (v_decimales = 2)then

     set new_valor = round(round(round(round(Valor,5),4),3),2);
end if;
if (v_decimales = 1)then

     set new_valor = round(round(round(round(round(Valor,5),4),3),2),1);
end if;
if (v_decimales = 0)then

     set new_valor = round(round(round(round(round(round(Valor,5),4),3),2),1),0);
end if;
if (v_decimales < 0)then

     set new_valor = round(round(round(round(round(round(round(Valor,5),4),3),2),1),0),v_decimales);
end if;
 	  END if;
END  if;

If (VCotizacion = 0) then
    if (v_decimales >= 5) then
   set new_valor = round(Valor,5);
end if;
if (v_decimales = 4)then
     set new_valor = round(round(Valor,5),4);
end if;
if (v_decimales = 3)then

     set new_valor = round(round(round(Valor,5),4),3);
end if;
if (v_decimales = 2)then

     set new_valor = round(round(round(round(Valor,5),4),3),2);
end if;
  if (v_decimales = 1)then

     set new_valor = round(round(round(round(round(Valor,5),4),3),2),1);
end if;
  if (v_decimales = 0)then

     set new_valor = round(round(round(round(round(round(Valor,5),4),3),2),1),0);
  end if;
  if (v_decimales < 0)then

     set new_valor = round(round(round(round(round(round(round(Valor,5),4),3),2),1),0),v_decimales);
  end if;
end if;

return 0;

END $$

DELIMITER ;
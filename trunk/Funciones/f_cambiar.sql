CREATE FUNcTION f_cambiar(v_valor decimal(13), v_fecha datetime,v_origen integer,v_destino integer ,v_cotiz smallint) RETURNS float
BEGIN

        declare v_Cotizacion decimal(13,3);
        declare v_operacion integer;
        declare v_decimales integer;
  /*declare v_o varchar, v_d varchar*/
        set v_fecha = cast(v_fecha as datetime);
        select decimales into v_decimales from monedas where cod_moneda = v_destino;
        if ifnull(v_decimales,0)=0 then
               set v_decimales = 5;
        end if;
        If v_origen = v_destino Then
                 return round(v_valor, v_decimales);
        End If;
        If v_origen = 0 Then
                return round(v_valor, v_decimales);
        End If;
        If v_destino=0 Then
                return round(v_valor, v_decimales);
        End If;

        If ifnull(v_origen,0)=0  Then
                return round(v_valor, v_decimales);
        End If;
        If ifnull(v_destino,0)=0 Then
                return round(v_valor, v_decimales);
        End If;

        SELECT valor_cotizacion, operacion into v_Cotizacion, v_operacion FROM cotizaciones_monedas
        where fecha_cotizacion = v_fecha and Cod_moneda_origen = v_origen and Cod_moneda_destino = v_destino;

        If valor_cotizacion <> 0 Then
                If v_operacion = 0 Then
                 If v_cotiz = 0 Then
                        return round((v_valor * valor_cotizacion), v_decimales);
                 Else
                        return round((v_valor * v_Cotiz), v_decimales);
                 End If;
                Else
                If v_Cotiz = 0 Then
                 return round((v_valor / valor_cotizacion), v_decimales);
                Else
                        return round((v_valor / v_Cotiz), v_decimales);
                 End If;
                End If;
           Else

                return round(v_valor, v_decimales);
        End If;



END

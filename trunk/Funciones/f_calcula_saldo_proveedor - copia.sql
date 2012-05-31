DROP FUNCTION `softpan`.`f_calcula_saldo_proveedor`
Create FUNCTION Saldo_Proveedor_cta(v_cod_prov SMALLINT,v_fecha date)
returns real
BEGIN
DECLARE v_saldo double;
select (
/*CTAS PAG*/                + ifnull((select sum(f_cambiar3 ( Ctas_pagar.Cod_moneda, Par_sys.cod_moneda, Ctas_pagar.Vencimiento, Ctas_pagar.Valor,0 ) ) as valor From Ctas_pagar,Proveedores,Par_sys where Ctas_pagar.Cod_proveedor = Proveedores.Cod_proveedor and (Ctas_pagar.Vencimiento < v_fecha ) AND (Ctas_pagar.Cod_proveedor =  v_cod_prov)) ,0)
/*NC - COMPRAS*/            - ifnull((select sum(f_cambiar4( nota_credito_compra.Cod_moneda, Par_sys.cod_moneda, nota_credito_compra.Fecha_nc, ((nota_credito_compra.total_exentas + nota_credito_compra.total_gravadas_5+ nota_credito_compra.total_gravadas_10 + nota_credito_compra.total_impuesto_5+ nota_credito_compra.total_impuesto_10) * -1) ) ) as valor From nota_credito_compra, Proveedores, tipo_comprobante, Par_sys where nota_credito_compra.Cod_proveedor = Proveedores.Cod_proveedor and nota_credito_compra.cod_tipo_nota = tipo_comprobante.cod_tipo_comprobante  AND ( nota_credito_compra.Cod_proveedor =  v_cod_prov) AND ( nota_credito_compra.Fecha_nc < v_fecha )) ,0)
/*PAGOS*/                   - ifnull((select sum(f_cambiar5 ( Pagos_det.Cod_moneda, Par_sys.cod_moneda, Pagos.Fecha_pago, Pagos_det.Valor )) as valor From Pagos, Pagos_det,Proveedores, condiciones_pagos, Par_sys where Pagos.Nro_pago = Pagos_det.Nro_pago and Pagos_det.Cod_condicion = condiciones_pagos.Cod_condicion  and Pagos.Cod_proveedor = Proveedores.Cod_proveedor  and ( condiciones_pagos.Tipo_condicion <>  4 ) and ( Pagos.Cod_proveedor = v_cod_prov) and ( Pagos.Fecha_pago <v_fecha ) ) ,0)
/*ANTICIPOS*/               - ifnull((select sum(f_cambiar6 ( anticipo_proveedor.Cod_moneda,Par_sys.cod_moneda, anticipo_proveedor.Fecha, anticipo_proveedor.VALOR )) as valor From anticipo_proveedor, Proveedores, Par_sys WHERE anticipo_proveedor.COD_PROVEEDOR = Proveedores.COD_PROVEEDOR and ( anticipo_proveedor.COD_PROVEEDOR =  v_cod_prov) AND ( anticipo_proveedor.Fecha < v_fecha )) ,0)

) AS SALDO into v_saldo from par_sys;

return v_saldo;

end
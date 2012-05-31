DROP FUNCTION `softpan`.`f_calcula_saldo_proveedor`
CREATE FUNCTION `softpan`.`f_calcula_saldo_proveedor` (v_cod_prov float, v_fecha date) RETURNS float
BEGIN
declare v_saldo float;

set v_saldo = (select  (
               + ifnull((select sum(f_Cambiar3( Ctas_pagar.Cod_moneda, Par_sys.cod_moneda, Ctas_pagar.Vencimiento, Ctas_pagar.Valor ) ) as valor From Ctas_pagar,Proveedores,Par_sys where Ctas_pagar.Cod_proveedor = Proveedores.Cod_proveedor and (Ctas_pagar.Vencimiento < v_fecha  ) AND (Ctas_pagar.Cod_proveedor =  v_cod_prov )) ,0)
               - ifnull((select sum(f_Cambiar3( factura_proveedor.Cod_moneda, Par_sys.cod_moneda, factura_proveedor.Fecha, ((factura_proveedor.total_exentas + factura_proveedor.total_gravadas_5 + factura_proveedor.total_gravadas_10+factura_proveedor.total_impuesto_5+factura_proveedor.total_impuesto_10) * -1) ) ) as valor From factura_proveedor, Proveedores, Tipo_Comprobante, Par_sys where factura_proveedor.cod_persona = Proveedores.Cod_proveedor and factura_proveedor.cod_tipo_comprobante = Tipo_Comprobante.cod_tipo_comprobante and ( Tipo_Comprobante.NC = 1 ) AND ( factura_proveedor.Cod_persona =  v_cod_prov ) AND ( factura_proveedor.Fecha < v_fecha  )) ,0)
               + ifnull((select sum(f_Cambiar3( nota_credito_compra.Cod_moneda, Par_sys.cod_moneda, nota_credito_compra.fecha_nc, ((nota_credito_compra.total_exentas + nota_credito_compra.total_gravadas_5 + nota_credito_compra.total_gravadas_10+nota_credito_compra.total_impuesto_5+nota_credito_compra.total_impuesto_10) * -1) ) ) as valor From nota_credito_compra, Proveedores, Tipo_Comprobante, Par_sys where Nota_credito_compra.cod_proveedor = Proveedores.Cod_proveedor and Nota_credito_compra.cod_tipo_comprobante_doc = Tipo_Comprobante.cod_tipo_comprobante and ( Tipo_Comprobante.ND = 1 ) AND ( Nota_credito_compra.Cod_proveedor =  v_cod_prov ) AND ( Nota_credito_compra.Fecha_nc < v_fecha  )) ,0)
               - ifnull((select sum(f_Cambiar3( Pagos_det.Cod_moneda, Par_sys.cod_moneda, Pagos.Fecha_pago, Pagos_det.Valor )) as valor From Pagos, Pagos_det,Proveedores, Condiciones_pagos, Par_sys where Pagos.Nro_pago = Pagos_det.Nro_pago and Pagos_det.Cod_condicion = Condiciones_pagos.Cod_condicion  and Pagos.Cod_proveedor = Proveedores.Cod_proveedor  and ( Condiciones_pagos.Tipo_condicion <>  4 ) and ( Pagos.Cod_proveedor = v_cod_prov ) and ( Pagos.Fecha_pago < v_fecha  ) ) ,0)

) AS SALDO
from par_sys);

return v_saldo;


END
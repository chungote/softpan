  SELECT Ctas_pagar.vencimiento as fecha,
         Ctas_pagar.Cod_proveedor,
         Ctas_pagar.Cod_moneda,
         cast(Ctas_pagar.nro_factura as char(30)) as comp,
         cast('Compra de Productos ' as char(112)) as Observacion,
         0 AS DEBITO,
         f_Cambiar3 (  Ctas_pagar.Cod_moneda, Par_sys.cod_moneda, Ctas_pagar.Vencimiento, Ctas_pagar.Valor,0 ) AS CREDITO,
         Proveedores.Nombre_proveedor,
         'CTAS PAG                                  ' as Tipo,
         1 as ORDEN,
         0.00 AS saldo_anterior,
         0.00 AS saldo_fiscal,
         current_user as usuario,
         tipo_comprobante.calcula_imp
      FROM Ctas_pagar,
          Proveedores,
          Par_sys,
          tipo_comprobante
   WHERE ( Ctas_pagar.Cod_proveedor = Proveedores.Cod_proveedor ) and
         ( Ctas_pagar.cod_tipo_comprobante = tipo_comprobante.cod_tipo_comprobante ) and
         ( tipo_comprobante.calcula_imp= :v_cal_imp or :v_cal_imp=2) and
         ( tipo_comprobante.nc <> 1 ) AND
         (  (Ctas_pagar.Cod_proveedor =  :v_CodCli) AND
         ( Ctas_pagar.vencimiento >= :V_FecIni ) AND
         ( Ctas_pagar.vencimiento <= :V_FecFin ) )

union all

  SELECT Ctas_pagar.vencimiento as fecha,
         Ctas_pagar.Cod_proveedor,
         Ctas_pagar.Cod_moneda,
         cast(Ctas_pagar.nro_factura as char(30)) as comp,
         cast(' ' as char(112)) as Observacion,
         f_Cambiar3 (  Ctas_pagar.Cod_moneda, Par_sys.cod_moneda, Ctas_pagar.Vencimiento, Ctas_pagar.Valor * -1,0) AS debito,
         0 AS CREDITO,
         Proveedores.Nombre_proveedor,
        'NOTA DE CREDITO' as Tipo,
         1 as ORDEN,
         0.00 AS saldo_anterior,
         0.00 AS saldo_fiscal,
         current_user as usuario,
         tipo_comprobante.calcula_imp

      FROM  Ctas_pagar,
            Proveedores,
            Par_sys,
            tipo_comprobante
   WHERE ( Ctas_pagar.Cod_proveedor = Proveedores.Cod_proveedor ) and
         ( Ctas_pagar.cod_tipo_comprobante = tipo_comprobante.cod_tipo_comprobante ) and
         ( tipo_comprobante.calcula_imp= :v_cal_imp or :v_cal_imp=2) and
         ( tipo_comprobante.NC = 1 ) AND
         (  (Ctas_pagar.Cod_proveedor =  :v_CodCli) AND
         ( Ctas_pagar.vencimiento >= :V_FecIni ) AND
         ( Ctas_pagar.vencimiento <= :V_FecFin ) )

 union all

SELECT  Pagos.Fecha_pago  as fecha,
        Pagos.Cod_proveedor,
        Pagos_det.Cod_moneda,
        Cast(Pagos.Nro_pago  as char(30) ) as comp,
        ''  as Observacion,
         f_Cambiar3 (  Pagos_det.Cod_moneda, Par_sys.cod_moneda, Pagos.Fecha_pago, Pagos_doc.Valor_pagado,0 ) AS DEBITO,
         0 AS CREDITO,
         Proveedores.Nombre_proveedor,
         cast( Condiciones_Pagos.descripcion_Condicion as char(25)) as Tipo,
         1 as ORDEN,
         0.00 AS saldo_anterior,
         0.00 AS saldo_fiscal,
         current_user as usuario,
         tipo_comprobante.calcula_imp

    FROM Pagos,
         Pagos_det,
         Condiciones_Pagos,
         Proveedores,
         Par_sys,
         tipo_comprobante,
         pagos_Doc

   WHERE ( Pagos.Nro_pago = Pagos_det.Nro_pago ) and
         ( Pagos_det.Cod_condicion = Condiciones_Pagos.Cod_condicion ) and
         ( Pagos.Cod_proveedor = Proveedores.Cod_proveedor ) and
         ( pagos_doc.cod_tipo_comprobante= tipo_comprobante.cod_tipo_comprobante) and
         ( pagos_doc.nro_pago =pagos.nro_pago) and
         ( tipo_documentos.calcula_imp= :v_cal_imp or :v_cal_imp=2) and
         ( (Condiciones_Pagos.Tipo_condicion <>  4 ) AND
         ( Pagos.Cod_proveedor =  :v_CodCli) AND
         ( Pagos.finiquito = 1) AND
         ( Pagos.Fecha_pago >= :V_FecIni ) AND
         ( Pagos.Fecha_pago <= :V_FecFin ) )

union all

:v_CodCli
SELECT '00/00/00' AS FECHA,
       1 as Cod_proveedor,
       0 as Cod_moneda,
       cast('0' as char(30)) as comp,
       '' as Observacion,
       0 AS DEBITO,
       0 AS CREDITO,
       Proveedores.Nombre_proveedor,
       '' as Tipo,
       0 as ORDEN,
       Saldo_Proveedor_cta( :v_CodCli, CAST(:V_FecIni AS DATETIME)  )  AS saldo_anterior,
       0 AS saldo_fiscal,
       current_user as usuario,
       2 as calc_imp
    FROM PAR_SYS,
         proveedores
    where proveedores.cod_proveedor = :v_CodCli

union all

SELECT '00/00/00' AS FECHA,
         :v_CodCli as Cod_proveedor,
                        0 as Cod_moneda,
/*         0 as comp,*/
                        cast('0' as varchar(30)) as comp,
         '' as Observacion,
         0 AS DEBITO,
                        0 AS CREDITO,
         Proveedores.Nombre_proveedor,
                        '' as Tipo,
                        0 as ORDEN,
                        0 as saldo_anterior,
                        dbo.Saldo_Proveedor_cta_gestion_fiscal( :v_CodCli, CAST(:V_FecIni AS DATETIME), CAST(:V_FecFin AS DATETIME) , 1  )  AS saldo_fiscal,
                        system_user as usuario,
                        2 as calc_imp
    FROM PAR_SYS,
                        proveedores
        where proveedores.cod_proveedor = :v_CodCli

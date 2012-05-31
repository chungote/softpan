$PBExportHeader$w_anular_factura.srw
forward
global type w_anular_factura from w_busca_fac_venta
end type
end forward

global type w_anular_factura from w_busca_fac_venta
boolean TitleBar=true
string Title="Seleccione factura que desea eliminar"
end type
global w_anular_factura w_anular_factura

on w_anular_factura.create
call super::create
end on

on w_anular_factura.destroy
call super::destroy
end on

type cb_buscar from w_busca_fac_venta`cb_buscar within w_anular_factura
int Y=256
end type

event cb_buscar::clicked;	integer v_doc
	long v_factura
	v_doc = dw_doc.getitemnumber(1,1)
	v_factura = long(em_factura.text)
	vg_nro_reg = 0
	if driver() = 2 then
		SELECT nro_reg into :vg_nro_reg FROM ventas
   	where Tipo_documen = :v_doc and Nro_factura = :v_factura ;
	else
		SELECT nro_reg into :vg_nro_reg FROM dbo.ventas
   	where Tipo_documen = :v_doc and Nro_factura = :v_factura ;
	end if
	if vg_nro_reg > 0 then
		vg_nro_reg = vg_nro_reg
	else
		vg_nro_reg = 0
	end if
	if isnull(vg_nro_reg) then
		vg_nro_reg = 0
	end if
	em_factura.setfocus()
	if vg_nro_reg > 0 then
//		opensheet(w_abm_ventas_anuladas,w_menuppal,0,Original!)
		open(w_abm_ventas_anuladas)
	else
		messagebox("Mensage del sistema...", "Factura no existe...")
	end if
	close(w_anular_factura)

end event

type st_1 from w_busca_fac_venta`st_1 within w_anular_factura
int Y=164
end type

type em_factura from w_busca_fac_venta`em_factura within w_anular_factura
int Y=160
end type

type dw_doc from w_busca_fac_venta`dw_doc within w_anular_factura
int Y=60
end type


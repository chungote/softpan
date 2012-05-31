$PBExportHeader$w_anular_fac_auto.srw
forward
global type w_anular_fac_auto from window
end type
type pb_ok from uo_boton within w_anular_fac_auto
end type
type pb_1 from uo_boton_cancel within w_anular_fac_auto
end type
type em_pedido from datawindow within w_anular_fac_auto
end type
type st_1 from statictext within w_anular_fac_auto
end type
end forward

global type w_anular_fac_auto from window
integer x = 494
integer y = 248
integer width = 2528
integer height = 1296
boolean titlebar = true
string title = "Seleccione  la factura a anular"
windowtype windowtype = response!
long backcolor = 12632256
pb_ok pb_ok
pb_1 pb_1
em_pedido em_pedido
st_1 st_1
end type
global w_anular_fac_auto w_anular_fac_auto

on w_anular_fac_auto.create
this.pb_ok=create pb_ok
this.pb_1=create pb_1
this.em_pedido=create em_pedido
this.st_1=create st_1
this.Control[]={this.pb_ok,&
this.pb_1,&
this.em_pedido,&
this.st_1}
end on

on w_anular_fac_auto.destroy
destroy(this.pb_ok)
destroy(this.pb_1)
destroy(this.em_pedido)
destroy(this.st_1)
end on

event open;em_pedido.SetTransObject(sqlca)

timer(10)
em_pedido.retrieve()
em_pedido.SelectRow(0, FALSE)

vg_band_cerrar = 1
em_pedido.SetFocus()


end event

event timer;em_pedido.retrieve()
em_pedido.SelectRow(0, FALSE)

end event

type pb_ok from uo_boton within w_anular_fac_auto
integer x = 731
integer y = 1036
integer taborder = 30
integer textsize = -8
string text = "Procesar"
boolean default = true
end type

event clicked;call super::clicked;
	integer v_doc
	long v_factura
	v_doc = em_pedido.getitemnumber(em_pedido.getrow(),'sol_anulacion_tipo_documen')
	v_factura = em_pedido.getitemnumber(em_pedido.getrow(),'sol_anulacion_nro_factura')
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
	
	if vg_nro_reg > 0 then
		open(w_abm_ventas_anuladas)
	else
		messagebox("Mensage del sistema...", "Factura no existe...")
	end if
	close(parent)


end event

type pb_1 from uo_boton_cancel within w_anular_fac_auto
integer x = 1184
integer y = 1036
integer taborder = 20
end type

type em_pedido from datawindow within w_anular_fac_auto
event ue_tecla_pulsada pbm_dwnkey
integer x = 46
integer y = 120
integer width = 2395
integer height = 860
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_solicitud_anulacion_fac"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;This.SelectRow(0, FALSE)
This.SelectRow(currentrow, TRUE)
end event

event clicked;if row = 0 then return
This.SelectRow(0, FALSE)
This.SelectRow(row, TRUE)
end event

type st_1 from statictext within w_anular_fac_auto
integer x = 55
integer y = 32
integer width = 1504
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Seleccione la factura y pulse procesar..."
boolean focusrectangle = false
end type


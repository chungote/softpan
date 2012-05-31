$PBExportHeader$w_filtra_reportes_fec.srw
forward
global type w_filtra_reportes_fec from w_modelo_filtro
end type
type st_3 from statictext within w_filtra_reportes_fec
end type
type st_4 from statictext within w_filtra_reportes_fec
end type
type v_fech_fin from editmask within w_filtra_reportes_fec
end type
type v_fech_ini from editmask within w_filtra_reportes_fec
end type
end forward

global type w_filtra_reportes_fec from w_modelo_filtro
integer width = 1646
integer height = 512
long backcolor = 12632256
st_3 st_3
st_4 st_4
v_fech_fin v_fech_fin
v_fech_ini v_fech_ini
end type
global w_filtra_reportes_fec w_filtra_reportes_fec

on w_filtra_reportes_fec.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_4=create st_4
this.v_fech_fin=create v_fech_fin
this.v_fech_ini=create v_fech_ini
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.v_fech_fin
this.Control[iCurrent+4]=this.v_fech_ini
end on

on w_filtra_reportes_fec.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_4)
destroy(this.v_fech_fin)
destroy(this.v_fech_ini)
end on

event open;call super::open;if isdate(string(vi_dw_lista.vi_argumentos[1])) then v_fech_ini.text = string(vi_dw_lista.vi_argumentos[1])
if isdate(string(vi_dw_lista.vi_argumentos[2])) then v_fech_fin.text = string(vi_dw_lista.vi_argumentos[2])

end event

event close;call super::close;vi_dw_lista.vi_argumentos[1] = v_fech_ini.text 
vi_dw_lista.vi_argumentos[2] = v_fech_fin.text 
end event

type pb_close from w_modelo_filtro`pb_close within w_filtra_reportes_fec
integer x = 809
integer y = 212
integer taborder = 40
end type

type pb_ok from w_modelo_filtro`pb_ok within w_filtra_reportes_fec
integer x = 416
integer y = 212
integer taborder = 30
end type

event pb_ok::clicked;Date D,E
D = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
	setnull(D)
end if	
E = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
	setnull(E)
end if	
long cant_filas
cant_filas = vi_dw_lista.retrieve(D,E)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)

if cant_filas > 0 then		
	double v_monto, v_monto_iva, v_ret, v_dl, v_gs, v_pen, v_pagado, v_reg, v_che, v_ban
	long v_moneda, v_moneda_des, v_nro_pago, v_tipo
	datetime v_fecha
	string v_concepto, v_factura
	v_moneda_des = parsys_codmoneda()
	for cant_filas = 1 to vi_dw_lista.rowcount()
	    v_monto = vi_dw_lista.getitemnumber(cant_filas, "valor")
		 v_monto_iva = vi_dw_lista.getitemnumber(cant_filas, "compras_imp_iva")
		 v_fecha = vi_dw_lista.getitemdatetime(cant_filas, "compras_fecha")
		 v_moneda = vi_dw_lista.getitemnumber(cant_filas, "compras_cod_moneda")
		 v_pagado = vi_dw_lista.getitemnumber(cant_filas, "pagado")
		 v_reg = vi_dw_lista.getitemnumber(cant_filas, "compras_nro_reg")
		 v_tipo = vi_dw_lista.getitemnumber(cant_filas, "compras_tipo_documen")
		 v_factura = vi_dw_lista.getitemstring(cant_filas, "compras_nro_factura")

		 select top 1 productos.descripcion_producto into :v_concepto from compras_det, productos 
		 where compras_det.nro_reg = :v_reg and productos.codigo = compras_det.codigo;
		 
		 select top 1 pagos_doc.nro_pago into :v_nro_pago from pagos_doc
		 where pagos_doc.tipo_documen = :v_tipo and pagos_doc.nro_documento = :v_factura;

		 select top 1 pagos_det.nro_cheque, pagos_det.nro_cuenta  into :v_che, :v_ban from pagos_det
		 where pagos_det.nro_pago = :v_nro_pago;

		 if cambiar(v_monto_iva, v_fecha,v_moneda,v_moneda_des ,0) > 50000 then
			 v_ret = v_monto_iva
		 else
			v_ret = 0
		 end if
		 if v_moneda <> v_moneda_des then
		 	 v_dl = v_monto - v_ret
		 else
			 v_gs = v_monto - v_ret
		 end if
		 v_pen = v_dl + v_gs - v_pagado
		 vi_dw_lista.setitem(cant_filas, "compras_retencion", v_ret)
		 vi_dw_lista.setitem(cant_filas, "compras_total_gs", v_gs)
		 vi_dw_lista.setitem(cant_filas, "compras_total_dl", v_dl)
		 if v_moneda <> v_moneda_des then
		 	 vi_dw_lista.setitem(cant_filas, "compras_pendiente_dl", v_pen)
		 else
		 	 vi_dw_lista.setitem(cant_filas, "compras_pendiente", v_pen)
		 end if
		 
		 vi_dw_lista.setitem(cant_filas, "compras_concepto", v_concepto)
		 vi_dw_lista.setitem(cant_filas, "compras_cheque", v_che)
		 vi_dw_lista.setitem(cant_filas, "compras_banco", v_ban)

		 v_ret = 0
		 v_gs = 0
		 v_dl = 0
		 v_pen = 0
		 v_che = 0
		 v_ban = 0
		 v_nro_pago = 0
	next
end if

end event

type gb_borde from w_modelo_filtro`gb_borde within w_filtra_reportes_fec
integer x = 384
integer y = 140
integer taborder = 0
long backcolor = 12632256
end type

type st_3 from statictext within w_filtra_reportes_fec
integer x = 37
integer y = 40
integer width = 389
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Inicial:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_filtra_reportes_fec
integer x = 837
integer y = 40
integer width = 389
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha Final:"
boolean focusrectangle = false
end type

type v_fech_fin from editmask within w_filtra_reportes_fec
integer x = 1207
integer y = 40
integer width = 379
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fech_ini from editmask within w_filtra_reportes_fec
integer x = 402
integer y = 40
integer width = 379
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type


$PBExportHeader$w_solicitud_anulacion_factura.srw
forward
global type w_solicitud_anulacion_factura from window
end type
type cdw_2 from datawindow within w_solicitud_anulacion_factura
end type
type dw_busca from datawindow within w_solicitud_anulacion_factura
end type
type pb_export from uo_boton within w_solicitud_anulacion_factura
end type
type pb_filtrar from uo_boton within w_solicitud_anulacion_factura
end type
type pb_order from uo_boton within w_solicitud_anulacion_factura
end type
type pb_recuperar from uo_boton within w_solicitud_anulacion_factura
end type
type pb_print from uo_boton within w_solicitud_anulacion_factura
end type
type pb_eliminar from uo_boton within w_solicitud_anulacion_factura
end type
type pb_incluir from uo_boton within w_solicitud_anulacion_factura
end type
type pb_salvar from uo_boton within w_solicitud_anulacion_factura
end type
type pb_quit from uo_boton_cancel within w_solicitud_anulacion_factura
end type
type dw_data from uo_datawindow within w_solicitud_anulacion_factura
end type
type gb_1 from groupbox within w_solicitud_anulacion_factura
end type
end forward

global type w_solicitud_anulacion_factura from window
integer x = 73
integer y = 24
integer width = 3419
integer height = 2196
boolean titlebar = true
string title = "Solicitud de Anulación de Facturas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
cdw_2 cdw_2
dw_busca dw_busca
pb_export pb_export
pb_filtrar pb_filtrar
pb_order pb_order
pb_recuperar pb_recuperar
pb_print pb_print
pb_eliminar pb_eliminar
pb_incluir pb_incluir
pb_salvar pb_salvar
pb_quit pb_quit
dw_data dw_data
gb_1 gb_1
end type
global w_solicitud_anulacion_factura w_solicitud_anulacion_factura

type variables
long il_finan, il_exp,il_aut
end variables

on w_solicitud_anulacion_factura.create
this.cdw_2=create cdw_2
this.dw_busca=create dw_busca
this.pb_export=create pb_export
this.pb_filtrar=create pb_filtrar
this.pb_order=create pb_order
this.pb_recuperar=create pb_recuperar
this.pb_print=create pb_print
this.pb_eliminar=create pb_eliminar
this.pb_incluir=create pb_incluir
this.pb_salvar=create pb_salvar
this.pb_quit=create pb_quit
this.dw_data=create dw_data
this.gb_1=create gb_1
this.Control[]={this.cdw_2,&
this.dw_busca,&
this.pb_export,&
this.pb_filtrar,&
this.pb_order,&
this.pb_recuperar,&
this.pb_print,&
this.pb_eliminar,&
this.pb_incluir,&
this.pb_salvar,&
this.pb_quit,&
this.dw_data,&
this.gb_1}
end on

on w_solicitud_anulacion_factura.destroy
destroy(this.cdw_2)
destroy(this.dw_busca)
destroy(this.pb_export)
destroy(this.pb_filtrar)
destroy(this.pb_order)
destroy(this.pb_recuperar)
destroy(this.pb_print)
destroy(this.pb_eliminar)
destroy(this.pb_incluir)
destroy(this.pb_salvar)
destroy(this.pb_quit)
destroy(this.dw_data)
destroy(this.gb_1)
end on

event open;dw_data.settransobject(sqlca)
cdw_2.settransobject(sqlca)
date ld_fecha_ini, ld_fecha_fin
setnull(ld_fecha_ini)
setnull(ld_fecha_fin)
dw_data.retrieve(0,0,0,ld_fecha_ini,ld_fecha_fin)

il_finan=0
il_exp=0 
il_aut=0
select count(*) into :il_finan from par_sys_pedidos where tipo = 2 and usuario like :vg_usuario;
select count(*) into :il_exp from par_sys_pedidos where tipo = 4 and usuario like :vg_usuario;
/*tilde de aprobacion de anulacion*/
select count(*) into :il_aut from par_sys_pedidos where usuario = :vg_usuario and tipo =12;


if il_finan = 1 then dw_data.modify('sol_anulacion_aut_fin.Protect = 0')
if il_exp=1 then dw_data.modify('sol_anulacion_aut_exp.Protect = 0')
if il_aut=1 then dw_data.modify('sol_anulacion_aut_dir.protect=0')
timer(20)

end event

event activate;this.move(0,0)

end event

event timer;if vg_numeracion_fac = 2 then return
date ld_fecha_ini, ld_fecha_fin
setnull(ld_fecha_ini)
setnull(ld_fecha_fin)
dw_data.retrieve(0,0,0,ld_fecha_ini,ld_fecha_fin)

end event

type cdw_2 from datawindow within w_solicitud_anulacion_factura
boolean visible = false
integer x = 2048
integer y = 1536
integer width = 562
integer height = 308
integer taborder = 30
string title = "none"
string dataobject = "dw_pedido_cli_sol_anulacion_fac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_busca from datawindow within w_solicitud_anulacion_factura
boolean visible = false
integer x = 3378
integer y = 728
integer width = 279
integer height = 232
integer taborder = 30
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_export from uo_boton within w_solicitud_anulacion_factura
integer x = 1431
integer y = 80
integer width = 329
integer taborder = 60
integer textsize = -8
string text = "&Exportar"
end type

event clicked;call super::clicked;dw_data.SaveAs ("",Excel!, TRUE)
end event

type pb_filtrar from uo_boton within w_solicitud_anulacion_factura
integer x = 1093
integer y = 80
integer width = 329
integer taborder = 50
integer textsize = -8
string text = "&Filtrar"
end type

event clicked;call super::clicked;gdw_datawindow = dw_data
open(w_filtrar)

end event

type pb_order from uo_boton within w_solicitud_anulacion_factura
integer x = 754
integer y = 80
integer width = 329
integer taborder = 40
integer textsize = -8
string text = "&Ordenar"
end type

event clicked;call super::clicked;gdw_datawindow = dw_data
open(w_ordenar)
dw_data.GroupCalc()
end event

type pb_recuperar from uo_boton within w_solicitud_anulacion_factura
integer x = 78
integer y = 80
integer width = 329
integer textsize = -8
string text = "&Recuperar"
end type

event clicked;call super::clicked;if string(dw_data.Describe("cf_paginas.tag")) = '?' or dw_data.Describe("cf_paginas.tag") = '' or isnull(dw_data.Describe("cf_paginas.tag")) or dw_data.Describe("cf_paginas.tag") = '*' then
	long cant_filas
	cant_filas = dw_data.retrieve()
	if cant_filas = 0 then		
		messageBox("Aviso...","No existen datos para recuperar...")
	end if
else
	window lwin_temp
	OpenWithParm(lwin_temp,dw_data, dw_data.Describe("cf_paginas.tag"))
end if
dw_data.setfocus()

end event

type pb_print from uo_boton within w_solicitud_anulacion_factura
integer x = 416
integer y = 80
integer width = 329
integer taborder = 30
integer textsize = -8
string text = "&Imprimir"
end type

event clicked;call super::clicked;gdw_datawindow = dw_data
open(w_print_parametros)


end event

type pb_eliminar from uo_boton within w_solicitud_anulacion_factura
integer x = 1769
integer y = 80
integer width = 329
integer taborder = 70
integer textsize = -8
string text = "&Eliminar"
end type

event clicked;call super::clicked;long ll_mes
ll_mes = MessageBox("Aviso", "Desea eliminar este ítem?", Question!, YesNo!,1)
if ll_mes = 1 then
	if dw_data.getrow() > 0 then dw_data.deleterow(dw_data.getrow())
	dw_data.setfocus()
end if

end event

type pb_incluir from uo_boton within w_solicitud_anulacion_factura
integer x = 2107
integer y = 80
integer width = 329
integer taborder = 80
integer textsize = -8
string text = "&Incluir"
end type

event clicked;call super::clicked;long ll_row
ll_row = dw_data.insertrow(0)
dw_data.setrow(ll_row)
dw_data.ScrollToRow(ll_row)
vg_numeracion_fac = 2

end event

type pb_salvar from uo_boton within w_solicitud_anulacion_factura
integer x = 2446
integer y = 80
integer width = 329
integer height = 104
integer taborder = 90
integer textsize = -8
string text = "&Grabar"
end type

event clicked;call super::clicked;		
dw_data.accepttext()
long ll_mes, ll_estado, v_temp, ll_tipo_doc, ll_nro_fac, ll_com, ll_exp,ll_dir

for v_temp = 1 to dw_data.rowcount()
	dw_data.setitem(v_temp, 'sol_anulacion_autorizado', 0)
	ll_tipo_doc =  dw_data.getitemnumber(v_temp, 'sol_anulacion_tipo_documen')
	ll_nro_fac =  dw_data.getitemnumber(v_temp, 'sol_anulacion_nro_factura')
	ll_com =  dw_data.getitemnumber(v_temp, 'sol_anulacion_aut_fin') 
	ll_exp =  dw_data.getitemnumber(v_temp, 'sol_anulacion_aut_exp') 
	ll_dir=   dw_data.getitemnumber(v_temp, 'sol_anulacion_aut_dir') 
	if ll_com=1 and ll_exp=1 and ll_dir=1 then
		dw_data.setitem(v_temp, 'sol_anulacion_autorizado', 1)		
	end if
	/*aprobacion de los tres tildes*/
	if ll_com = 1 and ll_dir=1 and ll_exp = 0 then
		long ll_ent_camion, ll_nro_reg
		select nro_reg into :ll_nro_reg from ventas where tipo_documen = :ll_tipo_doc and nro_factura = :ll_nro_fac using sqlca;
		select entrega_camion into :ll_ent_camion from Pedidos_clientes where nro_reg = :ll_nro_reg using sqlca;
		if ll_ent_camion = 0 then dw_data.setitem(v_temp, 'sol_anulacion_autorizado', 1)		
	end if
	
next


ll_mes = MessageBox("Aviso", "Desea grabar las modificaciones?", Question!, YesNo!,1)
if ll_mes = 1 then
	if dw_data.update(true,false) > 0 then
		dw_data.ResetUpdate()
		commit using sqlca;	
	else
		Rollback using sqlca;
		MessageBox("Atención !!!","Error al grabar la información." + '~r~r' + sqlca.sqlerrtext , StopSign!)
	end if
end if

date ld_fecha_ini, ld_fecha_fin
setnull(ld_fecha_ini)
setnull(ld_fecha_fin)
dw_data.retrieve(0,0,0,ld_fecha_ini,ld_fecha_fin)
vg_numeracion_fac = 0

end event

type pb_quit from uo_boton_cancel within w_solicitud_anulacion_factura
integer x = 2784
integer y = 80
integer width = 329
integer taborder = 100
string text = "&Salir"
end type

type dw_data from uo_datawindow within w_solicitud_anulacion_factura
event ue_enter pbm_dwnprocessenter
event ue_tecla_pulsada pbm_dwnkey
integer x = 41
integer y = 268
integer width = 3296
integer height = 1652
integer taborder = 20
string dataobject = "dw_solicitud_anulacion"
boolean vscrollbar = true
end type

event ue_enter;	long ll_rows, ll_colcount, ll_colact, ll_rowact
	ll_colcount = long(This.Object.DataWindow.Column.Count)
	ll_colact   = This.getcolumn()
	ll_rowact = this.getrow()
	ll_rows = this.RowCount()
	if ll_rows = ll_rowact and ll_colcount = ll_colact then 
		pb_incluir.TriggerEvent("Clicked!")
	else
		long ll_sec, ll_sec_sal, ll_columnas, n, ll_col
		long ll_row, ll_columnas_con_tab, ll_primera_col
		ll_row = this.getrow()
		ll_col = this.GetColumn()
		ll_sec_sal = long(this.Describe("#" + string(ll_col) + ".TabSequence"))
		ll_columnas = long(this.Object.DataWindow.Column.Count)
		for n = 1 to ll_columnas 
			ll_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
			if (ll_sec_sal + 10) = ll_sec then
				post setfocus(this)
				post setrow(this, ll_rowact)
				post setcolumn(this, n)
				exit
			end if
		next
		ll_columnas_con_tab = 0
		for n = 1 to ll_columnas 
			ll_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
			if ll_sec = 10 then ll_primera_col = n
			if ll_sec <> 0 then ll_columnas_con_tab = ll_columnas_con_tab + 1
		next

		if ll_sec_sal = (ll_columnas_con_tab*10) then //(v_columnas*10) then
			if ll_rowact = ll_rows then
				post setrow(this, ll_rowact)
				post setcolumn(this, ll_primera_col)
			else
				post setrow(this, ll_rowact + 1)
				post setcolumn(this, ll_primera_col)
			end if
		end if
//	  Send(Handle(this), 256, 9, 0)
	end if


end event

event ue_tecla_pulsada;if keydown(keyf3!) then 
	guo_func.of_find_cdw (dw_data )
end if
end event

event itemchanged;call super::itemchanged;string ls_ruc
guo_func.of_find_descrip ( dw_data, dw_busca)

//long ll_cod_proveedor, ll_row
//if this.GetColumnName( ) = 'cod_proveedor' then
//	ll_row = this.getrow()
//	ll_cod_proveedor = this.getitemnumber(ll_row,'cod_proveedor')
//	select ruc into :ls_ruc from proveedores where cod_proveedor = :ll_cod_proveedor;
//	this.setitem(ll_row, 'ruc', ls_ruc)
//end if
//
end event

event clicked;call super::clicked;if row = 0 then return
This.SelectRow(0, FALSE)
This.SelectRow(row, TRUE)
end event

event doubleclicked;call super::doubleclicked;st_pedido_cliente st_ped_cli 
if row = 0 then return

this.setrow(row)

if (il_exp > 0) and (il_finan) = 0 then
	if dw_data.getitemnumber(row, 'sol_anulacion_aut_exp') = 1  and il_exp > 0 then return
	long ll_tipo_doc, ll_nro_fac, ll_nro_reg
	ll_tipo_doc = dw_data.getitemnumber(row,'sol_anulacion_tipo_documen')
	ll_nro_fac = dw_data.getitemnumber(row,'sol_anulacion_nro_factura')
	select nro_reg into :ll_nro_reg from ventas where tipo_documen = :ll_tipo_doc and nro_factura = :ll_nro_fac using sqlca;

	long ll_cant_filas
	ll_cant_filas = cdw_2.retrieve(ll_nro_reg)
	if ll_cant_filas = 0 then
		messagebox('Aviso...','No se encontro pedido para el documento cargado...')
		return
	end if 
	vg_numeracion_fac = 2
	dw_data.accepttext()
	st_ped_cli.dw = cdw_2
	st_ped_cli.expedicion = il_exp
	OpenWithParm ( w_confirmar_pedido_cliente_expedicion, st_ped_cli )
	if vg_numeracion_fac = 2 then 
		dw_data.setitem(row,'sol_anulacion_aut_exp',1)
		//parent.triggerevent('ue_grabar')
		pb_salvar.triggerevent(Clicked!)
	end if
else
	//OpenWithParm ( w_confirmar_pedido_cliente_preview, cdw_2 )
end if
end event

type gb_1 from groupbox within w_solicitud_anulacion_factura
integer x = 46
integer y = 20
integer width = 3104
integer height = 188
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type


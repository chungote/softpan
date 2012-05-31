$PBExportHeader$w_filtra_comparativos.srw
forward
global type w_filtra_comparativos from window
end type
type st_13 from statictext within w_filtra_comparativos
end type
type dw_tip_doc from datawindow within w_filtra_comparativos
end type
type st_12 from statictext within w_filtra_comparativos
end type
type dw_dep1 from datawindow within w_filtra_comparativos
end type
type st_11 from statictext within w_filtra_comparativos
end type
type dw_suc2 from datawindow within w_filtra_comparativos
end type
type dw_busca from datawindow within w_filtra_comparativos
end type
type st_10 from statictext within w_filtra_comparativos
end type
type dw_provee from datawindow within w_filtra_comparativos
end type
type cb_3 from commandbutton within w_filtra_comparativos
end type
type st_9 from statictext within w_filtra_comparativos
end type
type st_8 from statictext within w_filtra_comparativos
end type
type st_7 from statictext within w_filtra_comparativos
end type
type st_6 from statictext within w_filtra_comparativos
end type
type st_5 from statictext within w_filtra_comparativos
end type
type st_4 from statictext within w_filtra_comparativos
end type
type st_3 from statictext within w_filtra_comparativos
end type
type st_2 from statictext within w_filtra_comparativos
end type
type st_1 from statictext within w_filtra_comparativos
end type
type cb_2 from commandbutton within w_filtra_comparativos
end type
type v_fecha22b from editmask within w_filtra_comparativos
end type
type v_fecha22 from editmask within w_filtra_comparativos
end type
type v_fecha1b from editmask within w_filtra_comparativos
end type
type v_fecha1 from editmask within w_filtra_comparativos
end type
type v_fecha5b from editmask within w_filtra_comparativos
end type
type v_fecha5 from editmask within w_filtra_comparativos
end type
type v_fecha4b from editmask within w_filtra_comparativos
end type
type v_fecha4 from editmask within w_filtra_comparativos
end type
type v_fecha3b from editmask within w_filtra_comparativos
end type
type v_fecha3 from editmask within w_filtra_comparativos
end type
type v_fecha2b from editmask within w_filtra_comparativos
end type
type v_fecha2 from editmask within w_filtra_comparativos
end type
type cb_1 from commandbutton within w_filtra_comparativos
end type
type v_fech_fin from editmask within w_filtra_comparativos
end type
type v_fech_ini from editmask within w_filtra_comparativos
end type
type gb_1 from groupbox within w_filtra_comparativos
end type
type gb_2 from groupbox within w_filtra_comparativos
end type
end forward

global type w_filtra_comparativos from window
integer width = 1879
integer height = 1588
boolean titlebar = true
string title = "Filtro del reporte"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
event ue_arg_produc ( )
st_13 st_13
dw_tip_doc dw_tip_doc
st_12 st_12
dw_dep1 dw_dep1
st_11 st_11
dw_suc2 dw_suc2
dw_busca dw_busca
st_10 st_10
dw_provee dw_provee
cb_3 cb_3
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_2 cb_2
v_fecha22b v_fecha22b
v_fecha22 v_fecha22
v_fecha1b v_fecha1b
v_fecha1 v_fecha1
v_fecha5b v_fecha5b
v_fecha5 v_fecha5
v_fecha4b v_fecha4b
v_fecha4 v_fecha4
v_fecha3b v_fecha3b
v_fecha3 v_fecha3
v_fecha2b v_fecha2b
v_fecha2 v_fecha2
cb_1 cb_1
v_fech_fin v_fech_fin
v_fech_ini v_fech_ini
gb_1 gb_1
gb_2 gb_2
end type
global w_filtra_comparativos w_filtra_comparativos

type variables
uo_datawindow vi_dw_lista
long vi_prov
long vi_suc1, vi_dep1 , vi_tip_doc
string vi_suc_text1, vi_prov_text, vi_dep_text1, vi_tip_doc_text

end variables

event ue_arg_produc();if vg_param_1a <> '' then
	vi_dw_lista.Object.filtro1a.Text = filtro_producto(vg_param_1a)
ELSE
	vi_dw_lista.Object.filtro1a.Text = "Todos "
END IF

if vg_param_2a <> 0 then
	vi_dw_lista.Object.filtro2a.Text = filtro_seccion(vg_param_2a)
ELSE
	vi_dw_lista.Object.filtro2a.Text = "Todos "
END IF

if vg_param_3a <> 0 then
	vi_dw_lista.Object.filtro3a.Text = filtro_sub_seccion(vg_param_3a)
ELSE
	vi_dw_lista.Object.filtro3a.Text = "Todos "
END IF

if vg_param_4a <> 0 then
	vi_dw_lista.Object.filtro4a.Text = filtro_grupo(vg_param_4a)
ELSE
	vi_dw_lista.Object.filtro4a.Text = "Todos "
END IF


if vg_param_5a <> 0 then
	vi_dw_lista.Object.filtro5a.Text = filtro_categoria(vg_param_5a)
ELSE
	vi_dw_lista.Object.filtro5a.Text = "Todos "
END IF


if vg_param_6a <> 0 then
	vi_dw_lista.Object.filtro6a.Text = filtro_sub_cate(vg_param_6a)
ELSE
	vi_dw_lista.Object.filtro6a.Text = "Todos "
END IF

if vg_param_7a <> 0 then
	vi_dw_lista.Object.filtro7a.Text = filtro_marcas(vg_param_7a)
ELSE
	vi_dw_lista.Object.filtro7a.Text = "Todos "
END IF

if vi_suc1 <> 0 then
	vi_suc_text1 = filtro_sucursales(vi_suc1)
ELSE
	vi_suc_text1 = "Todos "
END IF

if vi_prov <> 0 then
	vi_prov_text = filtro_proveedores(vi_prov)
ELSE
	vi_prov_text = "Todos "
END IF

if vi_dep1 <> 0 then
	vi_dep_text1 = filtro_depositos(vi_dep1)
ELSE
	vi_dep_text1 = "Todos "
END IF

if vi_tip_doc <> 0 then
	vi_tip_doc_text = filtro_tipo_doc(vi_tip_doc)
ELSE
	vi_tip_doc_text = "Todos "
END IF
end event

event open;if isvalid( message.PowerObjectParm ) then
	vi_dw_lista = message.PowerObjectParm
else
	messagebox('Error...', 'Datawindow no es válida...')
	post close(this)
end if
dw_provee.SetTransObject(vg_server5)
dw_provee.insertrow(0)
dw_busca.SetTransObject(vg_server5)


dw_suc2.SetTransObject(vg_server5)
dw_suc2.insertrow(0)
dw_dep1.SetTransObject(vg_server5)
dw_dep1.insertrow(0)


dw_tip_doc.SetTransObject(vg_server5)
dw_tip_doc.insertrow(0)

if gl_sucursal <> 0 then
	dw_suc2.setcolumn(1)
	dw_suc2.settext(string(gl_sucursal))
	dw_suc2.accepttext()
	dw_suc2.enabled = false
end if


vi_dw_lista.dataobject = "dw_lista_comparativo_5_periodos"	
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

on w_filtra_comparativos.create
this.st_13=create st_13
this.dw_tip_doc=create dw_tip_doc
this.st_12=create st_12
this.dw_dep1=create dw_dep1
this.st_11=create st_11
this.dw_suc2=create dw_suc2
this.dw_busca=create dw_busca
this.st_10=create st_10
this.dw_provee=create dw_provee
this.cb_3=create cb_3
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.v_fecha22b=create v_fecha22b
this.v_fecha22=create v_fecha22
this.v_fecha1b=create v_fecha1b
this.v_fecha1=create v_fecha1
this.v_fecha5b=create v_fecha5b
this.v_fecha5=create v_fecha5
this.v_fecha4b=create v_fecha4b
this.v_fecha4=create v_fecha4
this.v_fecha3b=create v_fecha3b
this.v_fecha3=create v_fecha3
this.v_fecha2b=create v_fecha2b
this.v_fecha2=create v_fecha2
this.cb_1=create cb_1
this.v_fech_fin=create v_fech_fin
this.v_fech_ini=create v_fech_ini
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_13,&
this.dw_tip_doc,&
this.st_12,&
this.dw_dep1,&
this.st_11,&
this.dw_suc2,&
this.dw_busca,&
this.st_10,&
this.dw_provee,&
this.cb_3,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.v_fecha22b,&
this.v_fecha22,&
this.v_fecha1b,&
this.v_fecha1,&
this.v_fecha5b,&
this.v_fecha5,&
this.v_fecha4b,&
this.v_fecha4,&
this.v_fecha3b,&
this.v_fecha3,&
this.v_fecha2b,&
this.v_fecha2,&
this.cb_1,&
this.v_fech_fin,&
this.v_fech_ini,&
this.gb_1,&
this.gb_2}
end on

on w_filtra_comparativos.destroy
destroy(this.st_13)
destroy(this.dw_tip_doc)
destroy(this.st_12)
destroy(this.dw_dep1)
destroy(this.st_11)
destroy(this.dw_suc2)
destroy(this.dw_busca)
destroy(this.st_10)
destroy(this.dw_provee)
destroy(this.cb_3)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.v_fecha22b)
destroy(this.v_fecha22)
destroy(this.v_fecha1b)
destroy(this.v_fecha1)
destroy(this.v_fecha5b)
destroy(this.v_fecha5)
destroy(this.v_fecha4b)
destroy(this.v_fecha4)
destroy(this.v_fecha3b)
destroy(this.v_fecha3)
destroy(this.v_fecha2b)
destroy(this.v_fecha2)
destroy(this.cb_1)
destroy(this.v_fech_fin)
destroy(this.v_fech_ini)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type st_13 from statictext within w_filtra_comparativos
integer x = 37
integer y = 992
integer width = 329
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tip. documen.:"
boolean focusrectangle = false
end type

type dw_tip_doc from datawindow within w_filtra_comparativos
event ue_tecla_pulsada pbm_dwnkey
integer x = 366
integer y = 992
integer width = 1454
integer height = 112
integer taborder = 170
string dataobject = "dw_arg_tipo_doc"
boolean border = false
boolean livescroll = true
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_tip_doc)
end if
end event

event itemchanged;guo_func.of_find_descrip ( dw_tip_doc, dw_busca)

end event

type st_12 from statictext within w_filtra_comparativos
integer x = 37
integer y = 896
integer width = 270
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Deposito"
boolean focusrectangle = false
end type

type dw_dep1 from datawindow within w_filtra_comparativos
event ue_tecla_pulsada pbm_dwnkey
integer x = 366
integer y = 896
integer width = 1454
integer height = 112
integer taborder = 160
string dataobject = "dw_arg_deposito"
boolean border = false
boolean livescroll = true
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_dep1)
end if
end event

event itemchanged;guo_func.of_find_descrip ( dw_dep1, dw_busca)

end event

type st_11 from statictext within w_filtra_comparativos
integer x = 37
integer y = 800
integer width = 270
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sucursal"
boolean focusrectangle = false
end type

type dw_suc2 from datawindow within w_filtra_comparativos
event ue_tecla_pulsada pbm_dwnkey
integer x = 366
integer y = 800
integer width = 1454
integer height = 112
integer taborder = 180
string dataobject = "dw_arg_sucursal"
boolean border = false
boolean livescroll = true
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_suc2)
end if
end event

event itemchanged;guo_func.of_find_descrip ( dw_suc2, dw_busca)
end event

type dw_busca from datawindow within w_filtra_comparativos
boolean visible = false
integer x = 37
integer width = 146
integer height = 64
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within w_filtra_comparativos
integer x = 37
integer y = 704
integer width = 270
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
boolean focusrectangle = false
end type

type dw_provee from datawindow within w_filtra_comparativos
event ue_tecla_pulsada pbm_dwnkey
integer x = 366
integer y = 704
integer width = 1454
integer height = 112
integer taborder = 120
string title = "none"
string dataobject = "dw_arg_proveedor"
boolean border = false
boolean livescroll = true
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_provee)
end if

end event

event itemchanged;guo_func.of_find_descrip ( dw_provee, dw_busca)
end event

type cb_3 from commandbutton within w_filtra_comparativos
integer x = 622
integer y = 1216
integer width = 535
integer height = 80
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtrar &Familias"
end type

event clicked;SetPointer(HourGlass!)
OpenWithParm(w_abm_seleccionar_nivel_reporte, vi_dw_lista )
end event

type st_9 from statictext within w_filtra_comparativos
boolean visible = false
integer x = 183
integer y = 792
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 12632256
string text = "- 1 - Periodo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_filtra_comparativos
boolean visible = false
integer x = 183
integer y = 888
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 12632256
string text = "- 2 - Periodo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_filtra_comparativos
integer x = 293
integer y = 568
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 12632256
string text = "- 5 - Periodo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_filtra_comparativos
integer x = 293
integer y = 376
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 12632256
string text = "- 3 - Periodo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_filtra_comparativos
integer x = 293
integer y = 472
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 12632256
string text = "- 4 - Periodo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_filtra_comparativos
integer x = 293
integer y = 280
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 12632256
string text = "- 2 - Periodo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_filtra_comparativos
integer x = 293
integer y = 184
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 12632256
string text = "- 1 - Periodo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_filtra_comparativos
integer x = 1024
integer y = 32
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha Final"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_filtra_comparativos
integer x = 658
integer y = 32
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha Inicial"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_filtra_comparativos
integer x = 878
integer y = 1312
integer width = 402
integer height = 112
integer taborder = 210
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cerrar"
end type

event clicked;SetPointer(HourGlass!)
close(parent)
end event

type v_fecha22b from editmask within w_filtra_comparativos
boolean visible = false
integer x = 951
integer y = 864
integer width = 329
integer height = 80
integer taborder = 230
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha22 from editmask within w_filtra_comparativos
boolean visible = false
integer x = 585
integer y = 864
integer width = 329
integer height = 80
integer taborder = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha1b from editmask within w_filtra_comparativos
boolean visible = false
integer x = 951
integer y = 768
integer width = 329
integer height = 80
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha1 from editmask within w_filtra_comparativos
boolean visible = false
integer x = 585
integer y = 768
integer width = 329
integer height = 80
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha5b from editmask within w_filtra_comparativos
integer x = 1061
integer y = 544
integer width = 329
integer height = 80
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha5 from editmask within w_filtra_comparativos
integer x = 695
integer y = 544
integer width = 329
integer height = 80
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha4b from editmask within w_filtra_comparativos
integer x = 1061
integer y = 448
integer width = 329
integer height = 80
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha4 from editmask within w_filtra_comparativos
integer x = 695
integer y = 448
integer width = 329
integer height = 80
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha3b from editmask within w_filtra_comparativos
integer x = 1061
integer y = 352
integer width = 329
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha3 from editmask within w_filtra_comparativos
integer x = 695
integer y = 352
integer width = 329
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha2b from editmask within w_filtra_comparativos
integer x = 1061
integer y = 256
integer width = 329
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fecha2 from editmask within w_filtra_comparativos
integer x = 695
integer y = 256
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type cb_1 from commandbutton within w_filtra_comparativos
integer x = 439
integer y = 1312
integer width = 402
integer height = 112
integer taborder = 200
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Recuperar"
end type

event clicked;Date D,E
Date f2, f2b, f3, f3b, f4, f4b, f5, f5b,F1, f1b, F22,  F22b

D = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
	setnull(D)
end if	
E = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
	setnull(E)
end if	

/**/
F2 = Date(v_fecha2.text)
If isnull(v_fecha2.text) or v_fecha2.text = "" then
	setnull(F2)
end if	
F2b = Date(v_fecha2b.text)
If isnull(v_fecha2b.text) or v_fecha2b.text = "" then
	setnull(F2b)
end if	
/**/

/**/
F3= Date(v_fecha3.text)
If isnull(v_fecha3.text) or v_fecha3.text = "" then
	setnull(F3)
end if	
F3b= Date(v_fecha3b.text)
If isnull(v_fecha3b.text) or v_fecha3b.text = "" then
	setnull(F3b)
end if	
/**/

/**/
F4= Date(v_fecha4.text)
If isnull(v_fecha4.text) or v_fecha4.text = "" then
	setnull(F4)
end if	
F4b= Date(v_fecha4b.text)
If isnull(v_fecha4b.text) or v_fecha4b.text = "" then
	setnull(F4b)
end if	
/**/

/**/
F5= Date(v_fecha5.text)
If isnull(v_fecha5.text) or v_fecha5.text = "" then
	setnull(F5)
end if	
F5b= Date(v_fecha5b.text)
If isnull(v_fecha5b.text) or v_fecha5b.text = "" then
	setnull(F5b)
end if	
/**/

/**/
F1= Date(v_fecha1.text)
If isnull(v_fecha1.text) or v_fecha1.text = "" then
	setnull(F1)
end if	
F1b= Date(v_fecha1b.text)
If isnull(v_fecha1b.text) or v_fecha1b.text = "" then
	setnull(F1b)
end if	
/**/

/**/
F22= Date(v_fecha22.text)
If isnull(v_fecha22.text) or v_fecha22.text = "" then
	setnull(F22)
end if	
F22b= Date(v_fecha22b.text)
If isnull(v_fecha22b.text) or v_fecha22b.text = "" then
	setnull(F22b)
end if	

vi_prov = dw_provee.Getitemnumber(1,1)
if isnull(vi_prov) then vi_prov = 0

vi_suc1 = dw_suc2.Getitemnumber(1,1)
if isnull(vi_suc1) then vi_suc1 = 0

vi_dep1 = dw_dep1.Getitemnumber(1,1)
if isnull(vi_dep1) then vi_dep1 = 0

vi_tip_doc = dw_tip_doc.Getitemnumber(1,1)
if isnull(vi_tip_doc) then vi_tip_doc = 0

long cant_filas
cant_filas = vi_dw_lista.retrieve(D,E,f2, f2b, f3, f3b, f4, f4b, f5, f5b,/*F1, f1b, F22,  F22b,*/  vg_param_1a,vg_param_1b,vg_param_2a,vg_param_2b,vg_param_3a,vg_param_3b,vg_param_4a,vg_param_4b,vg_param_5a,vg_param_5b,vg_param_6a,vg_param_6b,vg_param_7a,vg_param_7b,vi_prov,vi_suc1, vi_dep1, vi_tip_doc)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
else
	Parent.TriggerEvent("ue_arg_produc")
	vi_dw_lista.Object.v_suc.Text = vi_suc_text1
	vi_dw_lista.Object.v_prov.Text = vi_prov_text
	vi_dw_lista.Object.v_dep.Text = vi_dep_text1
	vi_dw_lista.Object.v_tip_doc.Text = vi_tip_doc_text
	vi_dw_lista.Object.filtro8a.Text = trim(v_Fech_ini.text)
	vi_dw_lista.Object.filtro8b.Text = trim(v_Fech_fin.text)	
	vi_dw_lista.Object.filtro28a.Text = trim(v_fecha2.text)
	vi_dw_lista.Object.filtro28b.Text = trim(v_fecha2b.text)	
	vi_dw_lista.Object.filtro38a.Text = trim(v_fecha3.text)
	vi_dw_lista.Object.filtro38b.Text = trim(v_fecha3b.text)	
	vi_dw_lista.Object.filtro48a.Text = trim(v_fecha4.text)
	vi_dw_lista.Object.filtro48b.Text = trim(v_fecha4b.text)	
	vi_dw_lista.Object.filtro58a.Text = trim(v_fecha5.text)
	vi_dw_lista.Object.filtro58b.Text = trim(v_fecha5b.text)	
end if


end event

type v_fech_fin from editmask within w_filtra_comparativos
integer x = 1061
integer y = 160
integer width = 329
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type v_fech_ini from editmask within w_filtra_comparativos
integer x = 695
integer y = 160
integer width = 329
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
boolean spin = true
double increment = 1
end type

type gb_1 from groupbox within w_filtra_comparativos
integer x = 256
integer y = 96
integer width = 1216
integer height = 576
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_filtra_comparativos
boolean visible = false
integer x = 146
integer y = 704
integer width = 1216
integer height = 288
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Reporte  2"
end type


$PBExportHeader$w_filtra_reportes_fec_dep_prov_1.srw
forward
global type w_filtra_reportes_fec_dep_prov_1 from w_filtra_reportes_fec_cli_cat
end type
type rb_1 from radiobutton within w_filtra_reportes_fec_dep_prov_1
end type
type rb_2 from radiobutton within w_filtra_reportes_fec_dep_prov_1
end type
type gb_1 from groupbox within w_filtra_reportes_fec_dep_prov_1
end type
type rb_3 from radiobutton within w_filtra_reportes_fec_dep_prov_1
end type
type dw_suc1 from uo_datawindow within w_filtra_reportes_fec_dep_prov_1
end type
type st_12 from statictext within w_filtra_reportes_fec_dep_prov_1
end type
type cbx_1 from checkbox within w_filtra_reportes_fec_dep_prov_1
end type
type st_10 from statictext within w_filtra_reportes_fec_dep_prov_1
end type
type st_11 from statictext within w_filtra_reportes_fec_dep_prov_1
end type
type v_fech_fin1 from editmask within w_filtra_reportes_fec_dep_prov_1
end type
type v_fech_ini1 from editmask within w_filtra_reportes_fec_dep_prov_1
end type
type cdw_param_3 from datawindow within w_filtra_reportes_fec_dep_prov_1
end type
type rb_4 from radiobutton within w_filtra_reportes_fec_dep_prov_1
end type
type rb_5 from radiobutton within w_filtra_reportes_fec_dep_prov_1
end type
type st_1 from statictext within w_filtra_reportes_fec_dep_prov_1
end type
type st_2 from statictext within w_filtra_reportes_fec_dep_prov_1
end type
type v_fech_fin2 from editmask within w_filtra_reportes_fec_dep_prov_1
end type
type v_fech_ini2 from editmask within w_filtra_reportes_fec_dep_prov_1
end type
type dw_busca from uo_datawindow within w_filtra_reportes_fec_dep_prov_1
end type
type rb_6 from radiobutton within w_filtra_reportes_fec_dep_prov_1
end type
type rb_7 from radiobutton within w_filtra_reportes_fec_dep_prov_1
end type
end forward

global type w_filtra_reportes_fec_dep_prov_1 from w_filtra_reportes_fec_cli_cat
integer y = 652
integer width = 1847
integer height = 1704
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
rb_3 rb_3
dw_suc1 dw_suc1
st_12 st_12
cbx_1 cbx_1
st_10 st_10
st_11 st_11
v_fech_fin1 v_fech_fin1
v_fech_ini1 v_fech_ini1
cdw_param_3 cdw_param_3
rb_4 rb_4
rb_5 rb_5
st_1 st_1
st_2 st_2
v_fech_fin2 v_fech_fin2
v_fech_ini2 v_fech_ini2
dw_busca dw_busca
rb_6 rb_6
rb_7 rb_7
end type
global w_filtra_reportes_fec_dep_prov_1 w_filtra_reportes_fec_dep_prov_1

type variables
Integer aviso
end variables

on w_filtra_reportes_fec_dep_prov_1.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.rb_3=create rb_3
this.dw_suc1=create dw_suc1
this.st_12=create st_12
this.cbx_1=create cbx_1
this.st_10=create st_10
this.st_11=create st_11
this.v_fech_fin1=create v_fech_fin1
this.v_fech_ini1=create v_fech_ini1
this.cdw_param_3=create cdw_param_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.st_1=create st_1
this.st_2=create st_2
this.v_fech_fin2=create v_fech_fin2
this.v_fech_ini2=create v_fech_ini2
this.dw_busca=create dw_busca
this.rb_6=create rb_6
this.rb_7=create rb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.dw_suc1
this.Control[iCurrent+6]=this.st_12
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.st_10
this.Control[iCurrent+9]=this.st_11
this.Control[iCurrent+10]=this.v_fech_fin1
this.Control[iCurrent+11]=this.v_fech_ini1
this.Control[iCurrent+12]=this.cdw_param_3
this.Control[iCurrent+13]=this.rb_4
this.Control[iCurrent+14]=this.rb_5
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.v_fech_fin2
this.Control[iCurrent+18]=this.v_fech_ini2
this.Control[iCurrent+19]=this.dw_busca
this.Control[iCurrent+20]=this.rb_6
this.Control[iCurrent+21]=this.rb_7
end on

on w_filtra_reportes_fec_dep_prov_1.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.rb_3)
destroy(this.dw_suc1)
destroy(this.st_12)
destroy(this.cbx_1)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.v_fech_fin1)
destroy(this.v_fech_ini1)
destroy(this.cdw_param_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.v_fech_fin2)
destroy(this.v_fech_ini2)
destroy(this.dw_busca)
destroy(this.rb_6)
destroy(this.rb_7)
end on

event open;call super::open;dw_suc1.SetTransObject(sqlca)
dw_suc1.insertrow(0)
cdw_param_3.SetTransObject(sqlca)
cdw_param_3.insertrow(0)


vi_dw_lista.dataobject = "dw_lista_compras_totales1"
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type pb_close from w_filtra_reportes_fec_cli_cat`pb_close within w_filtra_reportes_fec_dep_prov_1
integer x = 919
integer y = 1444
integer taborder = 140
end type

type pb_ok from w_filtra_reportes_fec_cli_cat`pb_ok within w_filtra_reportes_fec_dep_prov_1
integer x = 526
integer y = 1444
integer taborder = 130
end type

event pb_ok::clicked;long cant_filas
long A,B, ll_nro_concepto
Date C,D, H, I, ldt_fecha_alt_ini, ldt_fecha_alt_fin
LONG F
A = cdw_param_1.GetitemNUMBER(1,1)
IF ISNULL(A) THEN A=0
B = cdw_param_2.GetitemNUMBER(1,1)
IF ISNULL(B) THEN B=0
ll_nro_concepto = cdw_param_3.GetitemNUMBER(1,1)
IF  ll_nro_concepto = 0 THEN setnull(ll_nro_concepto)
C = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then	setnull(C)
D = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then	setnull(D)
H = Date(v_fech_ini1.text)
If isnull(v_fech_ini1.text) or v_fech_ini1.text = "" then	setnull(H)
I = Date(v_fech_fin1.text)
If isnull(v_fech_fin1.text) or v_fech_fin1.text = "" then	setnull(I)

ldt_fecha_alt_ini = Date(v_fech_ini2.text)
If isnull(v_fech_ini2.text) or v_fech_ini2.text = "" then	setnull(ldt_fecha_alt_ini)

ldt_fecha_alt_fin = Date(v_fech_fin2.text)
If isnull(v_fech_fin2.text) or v_fech_fin2.text = "" then	setnull(ldt_fecha_alt_fin)

if rb_1.Checked = TRUE then 
	F = 3
END IF
if rb_2.Checked = TRUE then 
	F = 1
END IF
if rb_3.Checked = TRUE then 
	F = 2
END IF
if rb_4.Checked = TRUE then 
	F = 4
END IF
if rb_5.Checked = TRUE then 
	F = 0
END IF

if rb_6.Checked = TRUE then 
	F = 0
END IF
long v_envios
v_envios = 0
if cbx_1.checked then v_envios = 1
long v_suc
v_suc = dw_suc1.Getitemnumber(1,1)
if isnull(v_suc) then v_suc = 0
cant_filas = vi_dw_lista.retrieve(A,B,C,D,F,v_suc,v_envios, H, I,ll_nro_concepto, ldt_fecha_alt_ini, ldt_fecha_alt_fin)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
	return
end if

if A <> 0 then
	vi_dw_lista.Object.filtro1.Text = filtro_depositos(A)
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF
if B <> 0 then
	vi_dw_lista.Object.filtro2.Text = filtro_PROVEEDORES(B)
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "
END IF

if v_suc <> 0 then
	vi_dw_lista.Object.filtro7.Text = filtro_sucursales(v_suc)
ELSE
	vi_dw_lista.Object.filtro7.Text = "Todas "
END IF

vi_dw_lista.Object.filtro3.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_fin.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_ini2.text)
vi_dw_lista.Object.filtro6.Text = trim(v_Fech_fin2.text)




end event

type gb_borde from w_filtra_reportes_fec_cli_cat`gb_borde within w_filtra_reportes_fec_dep_prov_1
integer x = 494
integer y = 1376
end type

type st_3 from w_filtra_reportes_fec_cli_cat`st_3 within w_filtra_reportes_fec_dep_prov_1
integer y = 60
end type

type st_4 from w_filtra_reportes_fec_cli_cat`st_4 within w_filtra_reportes_fec_dep_prov_1
integer y = 60
end type

type v_fech_fin from w_filtra_reportes_fec_cli_cat`v_fech_fin within w_filtra_reportes_fec_dep_prov_1
integer y = 60
end type

type v_fech_ini from w_filtra_reportes_fec_cli_cat`v_fech_ini within w_filtra_reportes_fec_dep_prov_1
integer y = 60
end type

type cdw_param_1 from w_filtra_reportes_fec_cli_cat`cdw_param_1 within w_filtra_reportes_fec_dep_prov_1
integer y = 380
integer taborder = 70
string dataobject = "dw_param_depositos"
end type

type cdw_param_2 from w_filtra_reportes_fec_cli_cat`cdw_param_2 within w_filtra_reportes_fec_dep_prov_1
integer x = 23
integer y = 468
integer taborder = 80
string dataobject = "dw_param_proveedor"
end type

type rb_1 from radiobutton within w_filtra_reportes_fec_dep_prov_1
integer x = 283
integer y = 884
integer width = 887
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Compras"
boolean checked = true
boolean lefttext = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_compras_totales1"
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_2 from radiobutton within w_filtra_reportes_fec_dep_prov_1
integer x = 283
integer y = 948
integer width = 887
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Gastos"
boolean lefttext = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_compras_totales1"
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type gb_1 from groupbox within w_filtra_reportes_fec_dep_prov_1
integer x = 256
integer y = 832
integer width = 1170
integer height = 544
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_3 from radiobutton within w_filtra_reportes_fec_dep_prov_1
integer x = 283
integer y = 1012
integer width = 887
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Activo Fijo"
boolean lefttext = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_compras_totales1"
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type dw_suc1 from uo_datawindow within w_filtra_reportes_fec_dep_prov_1
integer x = 347
integer y = 644
integer width = 1467
integer height = 100
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_arg_sucursal"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_suc1, dw_busca)
end event

type st_12 from statictext within w_filtra_reportes_fec_dep_prov_1
integer x = 23
integer y = 648
integer width = 320
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
string text = "Sucursal:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_filtra_reportes_fec_dep_prov_1
integer x = 201
integer y = 760
integer width = 1143
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Netear transferencias entre sucursales?"
boolean lefttext = true
end type

type st_10 from statictext within w_filtra_reportes_fec_dep_prov_1
integer x = 37
integer y = 160
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
string text = "Fecha Doc. Ini:"
boolean focusrectangle = false
end type

type st_11 from statictext within w_filtra_reportes_fec_dep_prov_1
integer x = 837
integer y = 160
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
string text = "Fecha Doc. Fin:"
boolean focusrectangle = false
end type

type v_fech_fin1 from editmask within w_filtra_reportes_fec_dep_prov_1
integer x = 1207
integer y = 160
integer width = 379
integer height = 80
integer taborder = 40
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

type v_fech_ini1 from editmask within w_filtra_reportes_fec_dep_prov_1
integer x = 402
integer y = 160
integer width = 379
integer height = 80
integer taborder = 30
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

type cdw_param_3 from datawindow within w_filtra_reportes_fec_dep_prov_1
integer x = 23
integer y = 556
integer width = 1586
integer height = 80
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_param_conceptos"
boolean border = false
boolean livescroll = true
end type

type rb_4 from radiobutton within w_filtra_reportes_fec_dep_prov_1
integer x = 283
integer y = 1076
integer width = 887
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Insumos"
boolean lefttext = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_compras_totales1"
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_5 from radiobutton within w_filtra_reportes_fec_dep_prov_1
integer x = 283
integer y = 1140
integer width = 887
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todos"
boolean lefttext = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_compras_totales1"
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type st_1 from statictext within w_filtra_reportes_fec_dep_prov_1
integer x = 37
integer y = 264
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
string text = "Fecha Alt. Ini:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_filtra_reportes_fec_dep_prov_1
integer x = 837
integer y = 264
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
string text = "Fecha Alt. Fin:"
boolean focusrectangle = false
end type

type v_fech_fin2 from editmask within w_filtra_reportes_fec_dep_prov_1
integer x = 1207
integer y = 264
integer width = 379
integer height = 80
integer taborder = 60
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

type v_fech_ini2 from editmask within w_filtra_reportes_fec_dep_prov_1
integer x = 402
integer y = 264
integer width = 379
integer height = 80
integer taborder = 50
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

type dw_busca from uo_datawindow within w_filtra_reportes_fec_dep_prov_1
boolean visible = false
integer x = 1234
integer y = 920
integer taborder = 20
boolean bringtotop = true
end type

type rb_6 from radiobutton within w_filtra_reportes_fec_dep_prov_1
integer x = 283
integer y = 1204
integer width = 887
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Gastos, Insumos, Activos"
boolean lefttext = true
end type

event clicked;if rb_6.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_compras_totales2"				
else	
	vi_dw_lista.dataobject = "dw_lista_compras_totales1"
end if		
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_7 from radiobutton within w_filtra_reportes_fec_dep_prov_1
integer x = 283
integer y = 1268
integer width = 887
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Totales por fecha de documento"
boolean lefttext = true
end type

event clicked;if rb_7.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_compras_totales_documento"			

end if		
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event


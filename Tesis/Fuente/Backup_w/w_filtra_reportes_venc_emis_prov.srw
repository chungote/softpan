$PBExportHeader$w_filtra_reportes_venc_emis_prov.srw
forward
global type w_filtra_reportes_venc_emis_prov from w_filtra_reportes_fec_cli_cat
end type
type st_5 from statictext within w_filtra_reportes_venc_emis_prov
end type
type st_6 from statictext within w_filtra_reportes_venc_emis_prov
end type
type v_fech_fin_v from editmask within w_filtra_reportes_venc_emis_prov
end type
type v_fech_ini_v from editmask within w_filtra_reportes_venc_emis_prov
end type
type rb_1 from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type rb_2 from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type gb_1_ from groupbox within w_filtra_reportes_venc_emis_prov
end type
type rb_1_ from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type rb_2_ from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type rb_3_ from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type rb_5_ from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type rb_3 from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type gb_1 from groupbox within w_filtra_reportes_venc_emis_prov
end type
type cbx_1 from checkbox within w_filtra_reportes_venc_emis_prov
end type
type st_16 from statictext within w_filtra_reportes_venc_emis_prov
end type
type dw_provee from uo_datawindow within w_filtra_reportes_venc_emis_prov
end type
type dw_busca from uo_datawindow within w_filtra_reportes_venc_emis_prov
end type
type cbx_2 from checkbox within w_filtra_reportes_venc_emis_prov
end type
type em_td from uo_editmask within w_filtra_reportes_venc_emis_prov
end type
type st_9 from statictext within w_filtra_reportes_venc_emis_prov
end type
type rb_4_ from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type st_1 from statictext within w_filtra_reportes_venc_emis_prov
end type
type dw_sucu from uo_datawindow within w_filtra_reportes_venc_emis_prov
end type
type rb_6_ from radiobutton within w_filtra_reportes_venc_emis_prov
end type
type st_2 from statictext within w_filtra_reportes_venc_emis_prov
end type
type st_7 from statictext within w_filtra_reportes_venc_emis_prov
end type
type em_altafin from editmask within w_filtra_reportes_venc_emis_prov
end type
type em_alta from editmask within w_filtra_reportes_venc_emis_prov
end type
end forward

global type w_filtra_reportes_venc_emis_prov from w_filtra_reportes_fec_cli_cat
integer x = 987
integer y = 312
integer width = 1838
integer height = 1736
st_5 st_5
st_6 st_6
v_fech_fin_v v_fech_fin_v
v_fech_ini_v v_fech_ini_v
rb_1 rb_1
rb_2 rb_2
gb_1_ gb_1_
rb_1_ rb_1_
rb_2_ rb_2_
rb_3_ rb_3_
rb_5_ rb_5_
rb_3 rb_3
gb_1 gb_1
cbx_1 cbx_1
st_16 st_16
dw_provee dw_provee
dw_busca dw_busca
cbx_2 cbx_2
em_td em_td
st_9 st_9
rb_4_ rb_4_
st_1 st_1
dw_sucu dw_sucu
rb_6_ rb_6_
st_2 st_2
st_7 st_7
em_altafin em_altafin
em_alta em_alta
end type
global w_filtra_reportes_venc_emis_prov w_filtra_reportes_venc_emis_prov

on w_filtra_reportes_venc_emis_prov.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_6=create st_6
this.v_fech_fin_v=create v_fech_fin_v
this.v_fech_ini_v=create v_fech_ini_v
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1_=create gb_1_
this.rb_1_=create rb_1_
this.rb_2_=create rb_2_
this.rb_3_=create rb_3_
this.rb_5_=create rb_5_
this.rb_3=create rb_3
this.gb_1=create gb_1
this.cbx_1=create cbx_1
this.st_16=create st_16
this.dw_provee=create dw_provee
this.dw_busca=create dw_busca
this.cbx_2=create cbx_2
this.em_td=create em_td
this.st_9=create st_9
this.rb_4_=create rb_4_
this.st_1=create st_1
this.dw_sucu=create dw_sucu
this.rb_6_=create rb_6_
this.st_2=create st_2
this.st_7=create st_7
this.em_altafin=create em_altafin
this.em_alta=create em_alta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.v_fech_fin_v
this.Control[iCurrent+4]=this.v_fech_ini_v
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.gb_1_
this.Control[iCurrent+8]=this.rb_1_
this.Control[iCurrent+9]=this.rb_2_
this.Control[iCurrent+10]=this.rb_3_
this.Control[iCurrent+11]=this.rb_5_
this.Control[iCurrent+12]=this.rb_3
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.cbx_1
this.Control[iCurrent+15]=this.st_16
this.Control[iCurrent+16]=this.dw_provee
this.Control[iCurrent+17]=this.dw_busca
this.Control[iCurrent+18]=this.cbx_2
this.Control[iCurrent+19]=this.em_td
this.Control[iCurrent+20]=this.st_9
this.Control[iCurrent+21]=this.rb_4_
this.Control[iCurrent+22]=this.st_1
this.Control[iCurrent+23]=this.dw_sucu
this.Control[iCurrent+24]=this.rb_6_
this.Control[iCurrent+25]=this.st_2
this.Control[iCurrent+26]=this.st_7
this.Control[iCurrent+27]=this.em_altafin
this.Control[iCurrent+28]=this.em_alta
end on

on w_filtra_reportes_venc_emis_prov.destroy
call super::destroy
destroy(this.st_5)
destroy(this.st_6)
destroy(this.v_fech_fin_v)
destroy(this.v_fech_ini_v)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1_)
destroy(this.rb_1_)
destroy(this.rb_2_)
destroy(this.rb_3_)
destroy(this.rb_5_)
destroy(this.rb_3)
destroy(this.gb_1)
destroy(this.cbx_1)
destroy(this.st_16)
destroy(this.dw_provee)
destroy(this.dw_busca)
destroy(this.cbx_2)
destroy(this.em_td)
destroy(this.st_9)
destroy(this.rb_4_)
destroy(this.st_1)
destroy(this.dw_sucu)
destroy(this.rb_6_)
destroy(this.st_2)
destroy(this.st_7)
destroy(this.em_altafin)
destroy(this.em_alta)
end on

event open;call super::open;vi_dw_lista.settransobject(vg_server_repl)
dw_provee.SetTransObject(sqlca)
dw_provee.insertrow(0)
dw_sucu.SetTransObject(sqlca)
dw_sucu.insertrow(0)

end event

type pb_close from w_filtra_reportes_fec_cli_cat`pb_close within w_filtra_reportes_venc_emis_prov
integer x = 928
integer y = 1304
integer taborder = 200
end type

type pb_ok from w_filtra_reportes_fec_cli_cat`pb_ok within w_filtra_reportes_venc_emis_prov
integer x = 535
integer y = 1304
integer taborder = 180
end type

event pb_ok::clicked;if cbx_2.Checked then   
	vi_dw_lista.dataobject = "dw_lista_ctaspgar_ctas_pag_res"				
else	
	if rb_1.checked then
		vi_dw_lista.dataobject = "dw_lista_ctaspgar_ctas_pag_2"
	else
		vi_dw_lista.dataobject = "dw_lista_ctaspgar_ctas_pag_1"
	end if
end if	

vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

long cant_filas
long A,B
Date C,D
Date E,F, v_alta, v_altafin
long G, ll_cod_sucursal
long v_incl
v_incl = 0
if cbx_1.checked = true then v_incl = 1

A = dw_provee.Getitemnumber(1,1)
ll_cod_sucursal = dw_sucu.Getitemnumber(1,1)

IF ISNULL(A) THEN A=0
IF ISNULL(ll_cod_sucursal) THEN ll_cod_sucursal=0
IF rb_1.checked = TRUE THEN B = 0
IF rb_2.checked = TRUE THEN B = 1
IF rb_3.checked = TRUE THEN B = 2

C = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then setnull(C)
D = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then setnull(D)
E = Date(v_Fech_ini_v.text)
If isnull(v_Fech_ini_v.text) or v_Fech_ini_v.text = "" then setnull(E)
F = Date(v_Fech_fin_v.text)
If isnull(v_Fech_fin_v.text) or v_Fech_fin_v.text = "" then setnull(F)

v_alta = Date(em_alta.text)
If isnull(em_alta.text) or em_alta.text = "" then setnull(v_alta)
v_altafin = Date(em_altafin.text)
If isnull(em_altafin.text) or em_altafin.text = "" then setnull(v_altafin)

IF rb_1_.checked = TRUE THEN	G = 3
IF rb_2_.checked = TRUE THEN G = 1
IF rb_3_.checked = TRUE THEN G = 2
IF rb_4_.checked = TRUE THEN G = 4
IF rb_5_.checked = TRUE THEN G = 5
IF rb_6_.checked = TRUE THEN G = 5

IF rb_6_.checked = TRUE then
	vi_dw_lista.dataobject = "dw_lista_ctaspgar_ctas_pag_grupo"	
	if cbx_2.Checked then   
		vi_dw_lista.dataobject = "dw_lista_ctaspgar_ctas_pag_res_grupo"
	end if
	vi_dw_lista.settransobject(vg_server_repl)
	vi_dw_lista.Modify("datawindow.print.Preview=Yes")
	vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end if	


cant_filas = vi_dw_lista.retrieve(A,B,C,D,E,F,G, v_incl, em_td.text + ',',ll_cod_sucursal, v_alta, v_altafin)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if

if A <> 0 then
	vi_dw_lista.Object.filtro1.Text = filtro_proveedores(A) 
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF

if ll_cod_sucursal <> 0 then
	vi_dw_lista.Object.filtro5.Text = filtro_sucursales(ll_cod_sucursal) 
ELSE
	vi_dw_lista.Object.filtro5.Text = "Todas "
END IF

vi_dw_lista.Object.filtro2.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro3.Text = trim(v_Fech_fin.text)

IF rb_1.checked = TRUE THEN
	vi_dw_lista.Object.filtro4.Text = "Pendientes "
END IF
IF rb_2.checked = TRUE THEN
	vi_dw_lista.Object.filtro4.Text = "Canceladas "
END IF
IF rb_3.checked = TRUE THEN
	vi_dw_lista.Object.filtro4.Text = "Todos "
END IF



end event

type gb_borde from w_filtra_reportes_fec_cli_cat`gb_borde within w_filtra_reportes_venc_emis_prov
integer x = 503
integer y = 1228
end type

type st_3 from w_filtra_reportes_fec_cli_cat`st_3 within w_filtra_reportes_venc_emis_prov
integer x = 41
string text = "Desde Venc:"
end type

type st_4 from w_filtra_reportes_fec_cli_cat`st_4 within w_filtra_reportes_venc_emis_prov
integer x = 1010
string text = "Hasta Venc:"
end type

type v_fech_fin from w_filtra_reportes_fec_cli_cat`v_fech_fin within w_filtra_reportes_venc_emis_prov
integer x = 1390
end type

type v_fech_ini from w_filtra_reportes_fec_cli_cat`v_fech_ini within w_filtra_reportes_venc_emis_prov
integer x = 416
integer y = 32
end type

type cdw_param_1 from w_filtra_reportes_fec_cli_cat`cdw_param_1 within w_filtra_reportes_venc_emis_prov
boolean visible = false
integer x = 46
integer y = 576
integer height = 84
integer taborder = 210
string dataobject = "dw_param_proveedor"
end type

event cdw_param_1::itemchanged;DataWindowChild cdw_Cli_Aso
cdw_param_2.GetChild("cod_cliente", cdw_Cli_Aso)
cdw_Cli_Aso.SetTransObject(SQLCA)
cdw_Cli_Aso.retrieve(long(data))
if cdw_Cli_Aso.rowcount() = 0 then
	cdw_Cli_Aso.InsertRow(0)
end if

end event

type cdw_param_2 from w_filtra_reportes_fec_cli_cat`cdw_param_2 within w_filtra_reportes_venc_emis_prov
boolean visible = false
integer x = 55
integer y = 320
integer taborder = 220
end type

type st_5 from statictext within w_filtra_reportes_venc_emis_prov
integer x = 41
integer y = 132
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
string text = "Desde Emis:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_filtra_reportes_venc_emis_prov
integer x = 1010
integer y = 132
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
string text = "Hasta Emis:"
boolean focusrectangle = false
end type

type v_fech_fin_v from editmask within w_filtra_reportes_venc_emis_prov
integer x = 1390
integer y = 132
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

type v_fech_ini_v from editmask within w_filtra_reportes_venc_emis_prov
integer x = 416
integer y = 124
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

type rb_1 from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 247
integer y = 652
integer width = 407
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pendientes"
boolean checked = true
boolean lefttext = true
boolean righttoleft = true
end type

type rb_2 from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 247
integer y = 740
integer width = 407
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Canceladas"
boolean lefttext = true
boolean righttoleft = true
end type

type gb_1_ from groupbox within w_filtra_reportes_venc_emis_prov
integer x = 809
integer y = 572
integer width = 818
integer height = 460
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_1_ from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 878
integer y = 608
integer width = 699
integer height = 88
integer taborder = 110
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
boolean lefttext = true
end type

type rb_2_ from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 878
integer y = 672
integer width = 699
integer height = 88
integer taborder = 120
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

type rb_3_ from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 878
integer y = 736
integer width = 699
integer height = 88
integer taborder = 130
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

type rb_5_ from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 878
integer y = 936
integer width = 699
integer height = 88
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todas"
boolean checked = true
boolean lefttext = true
end type

type rb_3 from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 247
integer y = 824
integer width = 407
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todas"
boolean lefttext = true
boolean righttoleft = true
end type

type gb_1 from groupbox within w_filtra_reportes_venc_emis_prov
integer x = 183
integer y = 572
integer width = 562
integer height = 392
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cbx_1 from checkbox within w_filtra_reportes_venc_emis_prov
integer x = 393
integer y = 1084
integer width = 1056
integer height = 76
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Incluir OP impresas como finiquitadas?"
boolean lefttext = true
end type

type st_16 from statictext within w_filtra_reportes_venc_emis_prov
integer x = 37
integer y = 244
integer width = 361
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
string text = "Proveedor:"
boolean focusrectangle = false
end type

type dw_provee from uo_datawindow within w_filtra_reportes_venc_emis_prov
event ue_tecla_pulsada pbm_dwnkey
integer x = 338
integer y = 240
integer width = 1467
integer height = 100
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_arg_proveedor"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_provee)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_provee, dw_busca)

end event

type dw_busca from uo_datawindow within w_filtra_reportes_venc_emis_prov
boolean visible = false
integer x = 1463
integer y = 840
integer taborder = 190
boolean bringtotop = true
end type

type cbx_2 from checkbox within w_filtra_reportes_venc_emis_prov
integer x = 608
integer y = 1164
integer width = 690
integer height = 76
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Resumido x proveedor"
end type

type em_td from uo_editmask within w_filtra_reportes_venc_emis_prov
integer x = 608
integer y = 476
integer width = 1134
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
maskdatatype maskdatatype = stringmask!
end type

type st_9 from statictext within w_filtra_reportes_venc_emis_prov
integer x = 46
integer y = 488
integer width = 535
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
string text = "Excluir tipo doc nros:"
boolean focusrectangle = false
end type

type rb_4_ from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 878
integer y = 800
integer width = 699
integer height = 88
integer taborder = 140
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

type st_1 from statictext within w_filtra_reportes_venc_emis_prov
integer x = 37
integer y = 356
integer width = 361
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

type dw_sucu from uo_datawindow within w_filtra_reportes_venc_emis_prov
event ue_tecla_pulsada pbm_dwnkey
integer x = 338
integer y = 352
integer width = 1467
integer height = 100
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_arg_sucursal"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_sucu)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_sucu, dw_busca)

end event

type rb_6_ from radiobutton within w_filtra_reportes_venc_emis_prov
integer x = 878
integer y = 872
integer width = 699
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Gastos,Activo e Insumos"
boolean lefttext = true
end type

type st_2 from statictext within w_filtra_reportes_venc_emis_prov
boolean visible = false
integer x = 41
integer y = 236
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
string text = "Desde Alta:"
boolean focusrectangle = false
end type

type st_7 from statictext within w_filtra_reportes_venc_emis_prov
boolean visible = false
integer x = 1010
integer y = 236
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
string text = "Hasta Alta:"
boolean focusrectangle = false
end type

type em_altafin from editmask within w_filtra_reportes_venc_emis_prov
boolean visible = false
integer x = 1390
integer y = 236
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

type em_alta from editmask within w_filtra_reportes_venc_emis_prov
boolean visible = false
integer x = 416
integer y = 228
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


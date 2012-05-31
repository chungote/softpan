$PBExportHeader$w_filtra_reportes_venc_emis_cli_cat_soc.srw
forward
global type w_filtra_reportes_venc_emis_cli_cat_soc from w_filtra_reportes_fec_cli_cat
end type
type gb_1 from groupbox within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type st_5 from statictext within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type st_6 from statictext within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type v_fech_fin_v from editmask within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type v_fech_ini_v from editmask within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type cdw_param_3 from datawindow within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_3 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_1 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_2 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type gb_2 from groupbox within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_4 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_6 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_5 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_8 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_9 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type cdw_param_4 from datawindow within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_7 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
type rb_10 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
end type
end forward

global type w_filtra_reportes_venc_emis_cli_cat_soc from w_filtra_reportes_fec_cli_cat
integer width = 1673
integer height = 1752
gb_1 gb_1
st_5 st_5
st_6 st_6
v_fech_fin_v v_fech_fin_v
v_fech_ini_v v_fech_ini_v
cdw_param_3 cdw_param_3
rb_3 rb_3
rb_1 rb_1
rb_2 rb_2
gb_2 gb_2
rb_4 rb_4
rb_6 rb_6
rb_5 rb_5
rb_8 rb_8
rb_9 rb_9
cdw_param_4 cdw_param_4
rb_7 rb_7
rb_10 rb_10
end type
global w_filtra_reportes_venc_emis_cli_cat_soc w_filtra_reportes_venc_emis_cli_cat_soc

on w_filtra_reportes_venc_emis_cli_cat_soc.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_5=create st_5
this.st_6=create st_6
this.v_fech_fin_v=create v_fech_fin_v
this.v_fech_ini_v=create v_fech_ini_v
this.cdw_param_3=create cdw_param_3
this.rb_3=create rb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_2=create gb_2
this.rb_4=create rb_4
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_8=create rb_8
this.rb_9=create rb_9
this.cdw_param_4=create cdw_param_4
this.rb_7=create rb_7
this.rb_10=create rb_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.v_fech_fin_v
this.Control[iCurrent+5]=this.v_fech_ini_v
this.Control[iCurrent+6]=this.cdw_param_3
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.rb_4
this.Control[iCurrent+12]=this.rb_6
this.Control[iCurrent+13]=this.rb_5
this.Control[iCurrent+14]=this.rb_8
this.Control[iCurrent+15]=this.rb_9
this.Control[iCurrent+16]=this.cdw_param_4
this.Control[iCurrent+17]=this.rb_7
this.Control[iCurrent+18]=this.rb_10
end on

on w_filtra_reportes_venc_emis_cli_cat_soc.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.v_fech_fin_v)
destroy(this.v_fech_ini_v)
destroy(this.cdw_param_3)
destroy(this.rb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_2)
destroy(this.rb_4)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_8)
destroy(this.rb_9)
destroy(this.cdw_param_4)
destroy(this.rb_7)
destroy(this.rb_10)
end on

event open;call super::open;cdw_param_3.SetTransObject(sqlca)

DataWindowChild cdw_Cli
cdw_param_3.GetChild("cod_cliente", cdw_Cli)
cdw_Cli.SetTransObject(SQLCA)
cdw_Cli.InsertRow(0)

cdw_param_3.insertrow(0)


cdw_param_4.SetTransObject(sqlca)
cdw_param_4.insertrow(0)

if isdate(string(vi_dw_lista.vi_argumentos[4])) then v_fech_ini_v.text = string(vi_dw_lista.vi_argumentos[4])
if isdate(string(vi_dw_lista.vi_argumentos[5])) then v_fech_fin_v.text = string(vi_dw_lista.vi_argumentos[5])

end event

event close;call super::close;vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.vi_argumentos[4] = v_fech_ini_v.text 
vi_dw_lista.vi_argumentos[5] = v_fech_fin_v.text 
end event

type pb_close from w_filtra_reportes_fec_cli_cat`pb_close within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 864
integer y = 1356
integer taborder = 90
end type

type pb_ok from w_filtra_reportes_fec_cli_cat`pb_ok within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 471
integer y = 1356
integer taborder = 80
end type

event pb_ok::clicked;long cant_filas
long A,B,E
Date C,D
long F
Date G,H
long v_suc

A = cdw_param_1.Getitemnumber(1,1)
IF ISNULL(A) THEN
	A=0
END IF
E = cdw_param_2.Getitemnumber(1,1)
IF ISNULL(E) THEN
	E=0
END IF
C = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
	setnull(C)
end if
D = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
	setnull(D)
end if
F = cdw_param_3.Getitemnumber(1,1)
IF ISNULL(F) THEN
	F=0
END IF

v_suc = cdw_param_4.Getitemnumber(1,1)
IF ISNULL(v_suc) THEN
	v_suc=0
END IF

G = Date(v_Fech_ini_v.text)
If isnull(v_Fech_ini_v.text) or v_Fech_ini_v.text = "" then
	setnull(G)
end if
H = Date(v_Fech_fin_v.text)
If isnull(v_Fech_fin_v.text) or v_Fech_fin_v.text = "" then
	setnull(H)
end if

IF rb_1.checked = TRUE THEN
	B = 0
END IF
IF rb_2.checked = TRUE THEN
	B = 1
END IF
IF rb_3.checked = TRUE THEN
	B = 2
END IF
if rb_4.checked = TRUE THEN
	cant_filas = vi_dw_lista.retrieve(v_suc)
else
	cant_filas = vi_dw_lista.retrieve(A,E,C,D,B,F,G,H, v_suc)
end if
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if


if A <> 0 then
	vi_dw_lista.Object.filtro1.Text = filtro_clientes(A)
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF

if E <> 0 then
	vi_dw_lista.Object.filtro5.Text = filtro_clientes_cate(B)
ELSE
	vi_dw_lista.Object.filtro5.Text = "Todos "
END IF

if F <> 0 then
	vi_dw_lista.Object.filtro6.Text = filtro_clientes_aso(F)
ELSE
	vi_dw_lista.Object.filtro6.Text = "Todos "
END IF

if v_suc <> 0 then
	vi_dw_lista.Object.filtrosuc.Text = filtro_sucursales(v_suc)
ELSE
	vi_dw_lista.Object.filtrosuc.Text = "Todos "
END IF

vi_dw_lista.Object.filtro2.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro3.Text = trim(v_Fech_fin.text)

vi_dw_lista.Object.filtro9.Text = trim(v_fech_ini_v.text)
vi_dw_lista.Object.filtro10.Text = trim(v_fech_fin_v.text)

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

type gb_borde from w_filtra_reportes_fec_cli_cat`gb_borde within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 439
integer y = 1280
end type

type st_3 from w_filtra_reportes_fec_cli_cat`st_3 within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 64
string text = "Desde Venc:"
end type

type st_4 from w_filtra_reportes_fec_cli_cat`st_4 within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 791
string text = "Hasta Venc:"
end type

type v_fech_fin from w_filtra_reportes_fec_cli_cat`v_fech_fin within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 1093
end type

type v_fech_ini from w_filtra_reportes_fec_cli_cat`v_fech_ini within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 384
integer y = 32
end type

type cdw_param_1 from w_filtra_reportes_fec_cli_cat`cdw_param_1 within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 55
integer y = 232
integer taborder = 50
end type

event cdw_param_1::itemchanged;DataWindowChild cdw_Cli_Aso
cdw_param_3.GetChild("cod_cliente", cdw_Cli_Aso)
cdw_Cli_Aso.SetTransObject(SQLCA)
cdw_Cli_Aso.retrieve(long(data))
if cdw_Cli_Aso.rowcount() = 0 then
	cdw_Cli_Aso.InsertRow(0)
end if

end event

type cdw_param_2 from w_filtra_reportes_fec_cli_cat`cdw_param_2 within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 55
integer y = 320
integer taborder = 60
end type

type gb_1 from groupbox within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 114
integer y = 896
integer width = 1394
integer height = 344
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_5 from statictext within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 64
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

type st_6 from statictext within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 791
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

type v_fech_fin_v from editmask within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 1093
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

type v_fech_ini_v from editmask within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 384
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

type cdw_param_3 from datawindow within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 55
integer y = 408
integer width = 1586
integer height = 80
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_param_clientes_aso"
boolean border = false
boolean livescroll = true
end type

type rb_3 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 631
integer y = 776
integer width = 407
integer height = 84
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
boolean righttoleft = true
end type

type rb_1 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 631
integer y = 632
integer width = 407
integer height = 88
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pendientes"
boolean lefttext = true
boolean righttoleft = true
end type

type rb_2 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 631
integer y = 704
integer width = 407
integer height = 88
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

type gb_2 from groupbox within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 567
integer y = 576
integer width = 562
integer height = 316
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_4 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 1051
integer y = 944
integer width = 329
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "x Cliente"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cob_res_cli"
vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

end event

type rb_6 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 658
integer y = 944
integer width = 329
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
string text = "Detallado"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cob"				
vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

end event

type rb_5 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 219
integer y = 940
integer width = 357
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
string text = "Resumido"
boolean checked = true
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cob_res_new"
vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

end event

type rb_8 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 165
integer y = 1016
integer width = 672
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
string text = "Detallado sin grupo Cli."
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cob_cli"				
vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

end event

type rb_9 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 873
integer y = 1020
integer width = 558
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
string text = "Saldo por Clientes"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cob__clientes_sald"				
vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

end event

type cdw_param_4 from datawindow within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 55
integer y = 504
integer width = 1586
integer height = 80
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_param_sucursal"
boolean border = false
boolean livescroll = true
end type

type rb_7 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
boolean visible = false
integer x = 1257
integer y = 796
integer width = 343
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
string text = "none"
boolean lefttext = true
end type

event clicked;
vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cob_det_new"
vi_dw_lista.settransobject(sqlca)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

end event

type rb_10 from radiobutton within w_filtra_reportes_venc_emis_cli_cat_soc
integer x = 402
integer y = 1120
integer width = 439
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detallado2"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cob_det3"				
vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

end event


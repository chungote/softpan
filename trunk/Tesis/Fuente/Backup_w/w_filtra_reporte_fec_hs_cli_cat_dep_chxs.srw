$PBExportHeader$w_filtra_reporte_fec_hs_cli_cat_dep_chxs.srw
forward
global type w_filtra_reporte_fec_hs_cli_cat_dep_chxs from w_filtra_reportes_fec_cli_cat
end type
type cdw_param_3 from datawindow within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type v_hora_ini from editmask within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type v_hora_fin from editmask within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type st_10 from statictext within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type st_11 from statictext within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type rb_1 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type rb_2 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type rb_4 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type gb_1 from groupbox within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type rb_3 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type rb_5 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
type rb_6 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type
end forward

global type w_filtra_reporte_fec_hs_cli_cat_dep_chxs from w_filtra_reportes_fec_cli_cat
integer width = 1678
integer height = 1328
cdw_param_3 cdw_param_3
v_hora_ini v_hora_ini
v_hora_fin v_hora_fin
st_10 st_10
st_11 st_11
rb_1 rb_1
rb_2 rb_2
rb_4 rb_4
gb_1 gb_1
rb_3 rb_3
rb_5 rb_5
rb_6 rb_6
end type
global w_filtra_reporte_fec_hs_cli_cat_dep_chxs w_filtra_reporte_fec_hs_cli_cat_dep_chxs

event open;call super::open;cdw_param_3.SetTransObject(sqlca)
cdw_param_3.insertrow(0)

end event

on w_filtra_reporte_fec_hs_cli_cat_dep_chxs.create
int iCurrent
call super::create
this.cdw_param_3=create cdw_param_3
this.v_hora_ini=create v_hora_ini
this.v_hora_fin=create v_hora_fin
this.st_10=create st_10
this.st_11=create st_11
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_4=create rb_4
this.gb_1=create gb_1
this.rb_3=create rb_3
this.rb_5=create rb_5
this.rb_6=create rb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_3
this.Control[iCurrent+2]=this.v_hora_ini
this.Control[iCurrent+3]=this.v_hora_fin
this.Control[iCurrent+4]=this.st_10
this.Control[iCurrent+5]=this.st_11
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.rb_3
this.Control[iCurrent+11]=this.rb_5
this.Control[iCurrent+12]=this.rb_6
end on

on w_filtra_reporte_fec_hs_cli_cat_dep_chxs.destroy
call super::destroy
destroy(this.cdw_param_3)
destroy(this.v_hora_ini)
destroy(this.v_hora_fin)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_4)
destroy(this.gb_1)
destroy(this.rb_3)
destroy(this.rb_5)
destroy(this.rb_6)
end on

type pb_close from w_filtra_reportes_fec_cli_cat`pb_close within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 841
integer y = 1044
integer taborder = 90
end type

type pb_ok from w_filtra_reportes_fec_cli_cat`pb_ok within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 448
integer y = 1044
integer taborder = 80
end type

event pb_ok::clicked;long A,B,C
DATE D,E
long F,G
A = cdw_param_1.Getitemnumber(1,1)
IF ISNULL(A) THEN	A=0
B = cdw_param_2.Getitemnumber(1,1)
IF ISNULL(e) THEN	B=0
C = cdw_param_3.Getitemnumber(1,1)
IF ISNULL(C) THEN	C=0
D = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then setnull(D)
E = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then setnull(E)
F = long(left(Trim(v_Hora_ini.text),2) + right(Trim(v_Hora_ini.text),2))
IF ISNULL(F) THEN	F=0
G = long(left(Trim(v_Hora_fin.text),2) + right(Trim(v_Hora_fin.text),2))
IF ISNULL(G) THEN	G=0


long cant_filas
cant_filas = vi_dw_lista.retrieve(A,B,C,D,E,F,G)
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para el rango definido...")
end if

if A <> 0 then
	vi_dw_lista.Object.filtro1.Text = filtro_clientes(A)
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF
if B <> 0 then
	vi_dw_lista.Object.filtro2.Text = filtro_clientes_cate(B)
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "
END IF
if C <> 0 then
	vi_dw_lista.Object.filtro3.Text = filtro_depositos(C)
ELSE
	vi_dw_lista.Object.filtro3.Text = "Todos "
END IF

vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)

if F <> 0 then
	vi_dw_lista.Object.filtro6.Text = trim(v_Hora_ini.text)
ELSE
	vi_dw_lista.Object.filtro6.Text = "Todos "
END IF

if G <> 0 then
	vi_dw_lista.Object.filtro7.Text = trim(v_Hora_fin.text)
ELSE
	vi_dw_lista.Object.filtro7.Text = "Todos "
END IF

if rb_1.Checked = TRUE then   
	vi_dw_lista.Object.filtro8.Text = "Resumido"	
end if
if rb_2.Checked = TRUE then   
	vi_dw_lista.Object.filtro8.Text = "Detallado"	
end if
if rb_3.Checked = TRUE then   
	vi_dw_lista.Object.filtro8.Text = "Por Doc. Resumido"	
end if
if rb_4.Checked = TRUE then   
	vi_dw_lista.Object.filtro8.Text = "Por Doc. Detallado"	
end if

end event

type gb_borde from w_filtra_reportes_fec_cli_cat`gb_borde within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 416
integer y = 972
end type

type st_3 from w_filtra_reportes_fec_cli_cat`st_3 within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type

type st_4 from w_filtra_reportes_fec_cli_cat`st_4 within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type

type v_fech_fin from w_filtra_reportes_fec_cli_cat`v_fech_fin within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type

type v_fech_ini from w_filtra_reportes_fec_cli_cat`v_fech_ini within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
end type

type cdw_param_1 from w_filtra_reportes_fec_cli_cat`cdw_param_1 within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer y = 220
integer taborder = 50
end type

type cdw_param_2 from w_filtra_reportes_fec_cli_cat`cdw_param_2 within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer y = 308
integer taborder = 60
end type

type cdw_param_3 from datawindow within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 23
integer y = 396
integer width = 1591
integer height = 84
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_param_depositos"
boolean border = false
boolean livescroll = true
end type

type v_hora_ini from editmask within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 398
integer y = 128
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
maskdatatype maskdatatype = datetimemask!
string mask = "hh:mm"
boolean spin = true
double increment = 1
end type

type v_hora_fin from editmask within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 1202
integer y = 124
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
maskdatatype maskdatatype = datetimemask!
string mask = "hh:mm"
boolean spin = true
double increment = 1
end type

type st_10 from statictext within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 27
integer y = 128
integer width = 375
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hora Inicial:"
boolean focusrectangle = false
end type

type st_11 from statictext within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 827
integer y = 128
integer width = 375
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hora Final:"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 553
integer y = 524
integer width = 594
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
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli"				
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det"				
end if
if rb_3.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resutot"				
end if	
if rb_4.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resu"				
end if
if rb_5.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_res2"				
end if
if rb_6.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det_2"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_2 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 553
integer y = 596
integer width = 594
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
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli"				
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det"				
end if
if rb_3.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resutot"				
end if	
if rb_4.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resu"				
end if	
if rb_5.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_res2"				
end if
if rb_6.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det_2"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_4 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 553
integer y = 740
integer width = 594
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
string text = "Por Doc. Detallado"
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli"				
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det"				
end if
if rb_3.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resutot"				
end if	
if rb_4.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resu"				
end if	
if rb_5.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_res2"				
end if

if rb_6.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det_2"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type gb_1 from groupbox within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 489
integer y = 460
integer width = 681
integer height = 532
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_3 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 553
integer y = 668
integer width = 594
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
string text = "Por Doc. Resumido"
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli"				
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det"				
end if
if rb_3.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resutot"				
end if	
if rb_4.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resu"				
end if	
if rb_5.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_res2"				
end if
if rb_6.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det_2"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_5 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 553
integer y = 812
integer width = 594
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
string text = "Resumido 2"
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli"				
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det"				
end if
if rb_3.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resutot"				
end if	
if rb_4.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resu"				
end if

if rb_5.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_res2"				
end if
if rb_6.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det_2"				
end if

vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_6 from radiobutton within w_filtra_reporte_fec_hs_cli_cat_dep_chxs
integer x = 553
integer y = 884
integer width = 594
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
string text = "Detallado 2"
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli"				
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det"				
end if
if rb_3.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resutot"				
end if	
if rb_4.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_resu"				
end if	
if rb_5.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_res2"				
end if
if rb_6.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ventas_tot_ventas_cli_det_2"				
end if

vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event


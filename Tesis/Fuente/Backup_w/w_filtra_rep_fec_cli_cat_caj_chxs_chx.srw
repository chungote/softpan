$PBExportHeader$w_filtra_rep_fec_cli_cat_caj_chxs_chx.srw
forward
global type w_filtra_rep_fec_cli_cat_caj_chxs_chx from w_filtra_reportes_fec_cli_cat
end type
type cdw_param_3 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type
type rb_1 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type
type rb_2 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type
type gb_1 from groupbox within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type
type rb_3 from checkbox within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type
type cdw_param_4 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type
end forward

global type w_filtra_rep_fec_cli_cat_caj_chxs_chx from w_filtra_reportes_fec_cli_cat
integer height = 1132
cdw_param_3 cdw_param_3
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
rb_3 rb_3
cdw_param_4 cdw_param_4
end type
global w_filtra_rep_fec_cli_cat_caj_chxs_chx w_filtra_rep_fec_cli_cat_caj_chxs_chx

event open;call super::open;cdw_param_3.SetTransObject(sqlca)
cdw_param_3.insertrow(0)
cdw_param_4.SetTransObject(sqlca)
cdw_param_4.insertrow(0)

end event

on w_filtra_rep_fec_cli_cat_caj_chxs_chx.create
int iCurrent
call super::create
this.cdw_param_3=create cdw_param_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
this.rb_3=create rb_3
this.cdw_param_4=create cdw_param_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_3
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.rb_3
this.Control[iCurrent+6]=this.cdw_param_4
end on

on w_filtra_rep_fec_cli_cat_caj_chxs_chx.destroy
call super::destroy
destroy(this.cdw_param_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
destroy(this.rb_3)
destroy(this.cdw_param_4)
end on

type pb_close from w_filtra_reportes_fec_cli_cat`pb_close within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer y = 860
integer taborder = 80
end type

type pb_ok from w_filtra_reportes_fec_cli_cat`pb_ok within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer y = 860
integer taborder = 70
end type

event pb_ok::clicked;long cant_filas
long A,B,C, F
Date D,E
long G
A = cdw_param_1.Getitemnumber(1,1) 
IF ISNULL(A) THEN	A=0
B = cdw_param_2.Getitemnumber(1,1)
IF ISNULL(B) THEN	B=0
C = cdw_param_3.Getitemnumber(1,1)
IF ISNULL(C) THEN	C=0

D = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then	setnull(D)
E = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then	setnull(E)

IF rb_3.checked = TRUE THEN
	F = 0
else
	F = 2
END IF

G = cdw_param_4.Getitemnumber(1,1)
IF ISNULL(G) THEN	G=0

cant_filas = vi_dw_lista.retrieve(A,B,C,D,E,F,G)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
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
	vi_dw_lista.Object.filtro3.Text = filtro_cobradores(C)
ELSE
	vi_dw_lista.Object.filtro3.Text = "Todos "
END IF

if G <> 0 then
	vi_dw_lista.Object.filtro6.Text = filtro_cajeros(C)
ELSE
	vi_dw_lista.Object.filtro6.Text = "Todos "
END IF


vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)



end event

type gb_borde from w_filtra_reportes_fec_cli_cat`gb_borde within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer y = 788
end type

type st_3 from w_filtra_reportes_fec_cli_cat`st_3 within w_filtra_rep_fec_cli_cat_caj_chxs_chx
string text = "Desde Venc:"
end type

type st_4 from w_filtra_reportes_fec_cli_cat`st_4 within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer y = 44
integer width = 494
string text = "Hasta Venc:"
end type

type v_fech_fin from w_filtra_reportes_fec_cli_cat`v_fech_fin within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type

type v_fech_ini from w_filtra_reportes_fec_cli_cat`v_fech_ini within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type

type cdw_param_1 from w_filtra_reportes_fec_cli_cat`cdw_param_1 within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type

type cdw_param_2 from w_filtra_reportes_fec_cli_cat`cdw_param_2 within w_filtra_rep_fec_cli_cat_caj_chxs_chx
end type

type cdw_param_3 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer x = 27
integer y = 336
integer width = 1591
integer height = 80
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_param_cobrador"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer x = 411
integer y = 564
integer width = 407
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
string text = "Resumen"
boolean checked = true
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cobradas_res"	
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cobradas"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_2 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer x = 864
integer y = 564
integer width = 407
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

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cobradas_res"	
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ctascob_ctas_cobradas"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type gb_1 from groupbox within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer x = 338
integer y = 512
integer width = 1074
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_3 from checkbox within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer x = 558
integer y = 700
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Solo Créditos ?"
end type

type cdw_param_4 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_chx
integer x = 27
integer y = 420
integer width = 1591
integer height = 80
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_param_cajero"
boolean border = false
boolean livescroll = true
end type


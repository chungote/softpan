$PBExportHeader$w_filtra_rep_fec_cli_cat_caj_chxs_1.srw
forward
global type w_filtra_rep_fec_cli_cat_caj_chxs_1 from w_filtra_reportes_fec_cli_cat
end type
type cdw_param_3 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type
type rb_1 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type
type rb_2 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type
type cdw_param4 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type
type gb_1 from groupbox within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type
end forward

global type w_filtra_rep_fec_cli_cat_caj_chxs_1 from w_filtra_reportes_fec_cli_cat
integer width = 1659
integer height = 1216
cdw_param_3 cdw_param_3
rb_1 rb_1
rb_2 rb_2
cdw_param4 cdw_param4
gb_1 gb_1
end type
global w_filtra_rep_fec_cli_cat_caj_chxs_1 w_filtra_rep_fec_cli_cat_caj_chxs_1

event open;call super::open;cdw_param_3.SetTransObject(sqlca)
cdw_param_3.insertrow(0)
cdw_param4.SetTransObject(sqlca)
cdw_param4.insertrow(0)

end event

on w_filtra_rep_fec_cli_cat_caj_chxs_1.create
int iCurrent
call super::create
this.cdw_param_3=create cdw_param_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cdw_param4=create cdw_param4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_3
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.cdw_param4
this.Control[iCurrent+5]=this.gb_1
end on

on w_filtra_rep_fec_cli_cat_caj_chxs_1.destroy
call super::destroy
destroy(this.cdw_param_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cdw_param4)
destroy(this.gb_1)
end on

type pb_close from w_filtra_reportes_fec_cli_cat`pb_close within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer y = 772
integer taborder = 100
end type

type pb_ok from w_filtra_reportes_fec_cli_cat`pb_ok within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer y = 772
integer taborder = 90
end type

event pb_ok::clicked;long cant_filas
long A,B,C,ll_suc
Date D,E
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
ll_suc = cdw_param4.Getitemnumber(1,1)
IF ISNULL(ll_suc) THEN	ll_suc=0

cant_filas = vi_dw_lista.retrieve(A,B,C,D,E,ll_suc)
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
if ll_suc <> 0 then
	vi_dw_lista.Object.filtro6.Text = filtro_sucursales(ll_suc)
ELSE
	vi_dw_lista.Object.filtro6.Text = "Todas "
END IF

vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)


end event

type gb_borde from w_filtra_reportes_fec_cli_cat`gb_borde within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer y = 700
end type

type st_3 from w_filtra_reportes_fec_cli_cat`st_3 within w_filtra_rep_fec_cli_cat_caj_chxs_1
string text = "Fecha Ini:"
end type

type st_4 from w_filtra_reportes_fec_cli_cat`st_4 within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer y = 44
integer width = 494
string text = "Fecha Fin:"
end type

type v_fech_fin from w_filtra_reportes_fec_cli_cat`v_fech_fin within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type

type v_fech_ini from w_filtra_reportes_fec_cli_cat`v_fech_ini within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type

type cdw_param_1 from w_filtra_reportes_fec_cli_cat`cdw_param_1 within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer x = 23
end type

type cdw_param_2 from w_filtra_reportes_fec_cli_cat`cdw_param_2 within w_filtra_rep_fec_cli_cat_caj_chxs_1
end type

type cdw_param_3 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer x = 23
integer y = 336
integer width = 1591
integer height = 80
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_param_cobrador"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer x = 411
integer y = 576
integer width = 407
integer height = 88
integer taborder = 70
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
	vi_dw_lista.dataobject = "dw_lista_ctascob_anticipo"	
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ctascob_anticipo_det"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_2 from radiobutton within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer x = 864
integer y = 576
integer width = 407
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554430
long backcolor = 12632256
string text = "Detallado"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;if rb_1.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ctascob_anticipo"	
end if		
if rb_2.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_ctascob_anticipo_det"				
end if
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type cdw_param4 from datawindow within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer x = 14
integer y = 424
integer width = 1573
integer height = 80
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_param_sucursal2"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_filtra_rep_fec_cli_cat_caj_chxs_1
integer x = 338
integer y = 524
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


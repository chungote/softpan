$PBExportHeader$w_filtra_reportes_fec_prov_chx_tipo_1_2.srw
forward
global type w_filtra_reportes_fec_prov_chx_tipo_1_2 from w_filtra_reportes_fec
end type
type cdw_param_1 from datawindow within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
type rb_1 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
type rb_2 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
type rb_3 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
type rb_4 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
type rb_5 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
type gb_1 from groupbox within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
type gb_2 from groupbox within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type
end forward

global type w_filtra_reportes_fec_prov_chx_tipo_1_2 from w_filtra_reportes_fec
integer width = 1696
integer height = 804
cdw_param_1 cdw_param_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
gb_1 gb_1
gb_2 gb_2
end type
global w_filtra_reportes_fec_prov_chx_tipo_1_2 w_filtra_reportes_fec_prov_chx_tipo_1_2

event open;call super::open;cdw_param_1.SetTransObject(sqlca)
cdw_param_1.reset()
cdw_param_1.insertrow(0)

end event

on w_filtra_reportes_fec_prov_chx_tipo_1_2.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_5
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
end on

on w_filtra_reportes_fec_prov_chx_tipo_1_2.destroy
call super::destroy
destroy(this.cdw_param_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type pb_close from w_filtra_reportes_fec`pb_close within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 837
integer y = 556
integer taborder = 50
end type

type pb_ok from w_filtra_reportes_fec`pb_ok within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 443
integer y = 556
integer taborder = 40
end type

event pb_ok::clicked;long cant_filas
long A, ll_tipo
Date D,E
A = cdw_param_1.Getitemnumber(1,1)
D = Date(v_Fech_ini.text)
E = Date(v_Fech_fin.text)
IF ISNULL(A) THEN
	A=0
END IF

if rb_4.checked=true then
	ll_tipo=1
end if

if rb_5.checked=true then
	ll_tipo=2
end if

cant_filas = vi_dw_lista.retrieve(A,D,E,ll_tipo)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if
if a <> 0 then
	vi_dw_lista.Object.filtro2.Text = filtro_proveedores(a)
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "
END IF
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)



end event

type gb_borde from w_filtra_reportes_fec`gb_borde within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 411
integer y = 484
end type

type st_3 from w_filtra_reportes_fec`st_3 within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type

type st_4 from w_filtra_reportes_fec`st_4 within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type

type v_fech_fin from w_filtra_reportes_fec`v_fech_fin within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type

type v_fech_ini from w_filtra_reportes_fec`v_fech_ini within w_filtra_reportes_fec_prov_chx_tipo_1_2
end type

type cdw_param_1 from datawindow within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 27
integer y = 156
integer width = 1586
integer height = 80
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_param_proveedor"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 59
integer y = 264
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 12632256
string text = "S/Fecha vencimiento"
boolean checked = true
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctaspgar_extracto_proveedor"				
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_2 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 631
integer y = 264
integer width = 457
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 12632256
string text = "S/Fecha emisión"
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctaspgar_extracto_proveedor_emi"				
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_3 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 1097
integer y = 264
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 12632256
string text = "S/Fecha Documento"
end type

event clicked;vi_dw_lista.dataobject = "dw_lista_ctaspgar_extracto_proveedor_fec"				
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_4 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 562
integer y = 400
integer width = 274
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo 1"
end type

event clicked;if rb_4.checked=true then
	rb_5.checked=false
end if
end event

type rb_5 from radiobutton within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 837
integer y = 400
integer width = 274
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo 2"
boolean checked = true
end type

event clicked;if rb_5.checked=true then
	rb_4.checked=false
end if
end event

type gb_1 from groupbox within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 37
integer y = 208
integer width = 1632
integer height = 160
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_filtra_reportes_fec_prov_chx_tipo_1_2
integer x = 526
integer y = 356
integer width = 594
integer height = 132
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type


$PBExportHeader$w_filtra_reportes_fec_fact.srw
forward
global type w_filtra_reportes_fec_fact from w_modelo_filtro
end type
type cdw_param_1 from editmask within w_filtra_reportes_fec_fact
end type
type st_1 from statictext within w_filtra_reportes_fec_fact
end type
type st_3 from statictext within w_filtra_reportes_fec_fact
end type
type st_4 from statictext within w_filtra_reportes_fec_fact
end type
type v_fech_fin from editmask within w_filtra_reportes_fec_fact
end type
type v_fech_ini from editmask within w_filtra_reportes_fec_fact
end type
end forward

global type w_filtra_reportes_fec_fact from w_modelo_filtro
integer width = 1687
integer height = 572
long backcolor = 12632256
cdw_param_1 cdw_param_1
st_1 st_1
st_3 st_3
st_4 st_4
v_fech_fin v_fech_fin
v_fech_ini v_fech_ini
end type
global w_filtra_reportes_fec_fact w_filtra_reportes_fec_fact

on w_filtra_reportes_fec_fact.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.v_fech_fin=create v_fech_fin
this.v_fech_ini=create v_fech_ini
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.v_fech_fin
this.Control[iCurrent+6]=this.v_fech_ini
end on

on w_filtra_reportes_fec_fact.destroy
call super::destroy
destroy(this.cdw_param_1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.v_fech_fin)
destroy(this.v_fech_ini)
end on

event open;call super::open;vi_dw_lista.dataobject = "dw_lista_compara_pedido_factura_unidades"	
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type pb_close from w_modelo_filtro`pb_close within w_filtra_reportes_fec_fact
integer x = 914
integer y = 296
integer taborder = 50
end type

type pb_ok from w_modelo_filtro`pb_ok within w_filtra_reportes_fec_fact
integer x = 521
integer y = 296
integer taborder = 40
end type

event pb_ok::clicked;long cant_filas

//***
long A
Date B,C
A = Long(cdw_param_1.text)
IF ISNULL(A) THEN
	A=0
END IF
B = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
	setnull(B)
end if	
C = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
	setnull(C)
end if	


cant_filas = vi_dw_lista.retrieve(B,C,A)
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para recuperar...")
end if


//Filtros Establecidos
//if A <> 0 then
//	vi_dw_lista.Object.filtro1.Text = trim(cdw_param_1.text) 
//ELSE
//	vi_dw_lista.Object.filtro1.Text = "Todos "
//END IF

vi_dw_lista.Object.filtro2.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro3.Text = trim(v_Fech_fin.text)
end event

type gb_borde from w_modelo_filtro`gb_borde within w_filtra_reportes_fec_fact
integer x = 489
integer y = 224
integer taborder = 0
long backcolor = 12632256
end type

type cdw_param_1 from editmask within w_filtra_reportes_fec_fact
integer x = 704
integer y = 148
integer width = 599
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###"
end type

type st_1 from statictext within w_filtra_reportes_fec_fact
integer x = 288
integer y = 148
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
string text = "Nro de Factura"
boolean focusrectangle = false
end type

type st_3 from statictext within w_filtra_reportes_fec_fact
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

type st_4 from statictext within w_filtra_reportes_fec_fact
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

type v_fech_fin from editmask within w_filtra_reportes_fec_fact
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

type v_fech_ini from editmask within w_filtra_reportes_fec_fact
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


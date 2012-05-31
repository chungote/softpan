$PBExportHeader$w_filtra_reportes_cruce.srw
forward
global type w_filtra_reportes_cruce from w_modelo_filtro
end type
type cdw_param_1 from editmask within w_filtra_reportes_cruce
end type
type st_1 from statictext within w_filtra_reportes_cruce
end type
type cdw_param_2 from editmask within w_filtra_reportes_cruce
end type
type st_2 from statictext within w_filtra_reportes_cruce
end type
end forward

global type w_filtra_reportes_cruce from w_modelo_filtro
long backcolor = 12632256
cdw_param_1 cdw_param_1
st_1 st_1
cdw_param_2 cdw_param_2
st_2 st_2
end type
global w_filtra_reportes_cruce w_filtra_reportes_cruce

on w_filtra_reportes_cruce.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
this.st_1=create st_1
this.cdw_param_2=create cdw_param_2
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cdw_param_2
this.Control[iCurrent+4]=this.st_2
end on

on w_filtra_reportes_cruce.destroy
call super::destroy
destroy(this.cdw_param_1)
destroy(this.st_1)
destroy(this.cdw_param_2)
destroy(this.st_2)
end on

event open;call super::open;vi_dw_lista.settransobject(sqlca)

end event

type pb_close from w_modelo_filtro`pb_close within w_filtra_reportes_cruce
integer y = 376
integer taborder = 40
end type

type pb_ok from w_modelo_filtro`pb_ok within w_filtra_reportes_cruce
integer y = 376
integer taborder = 30
end type

event pb_ok::clicked;long cant_filas
long A, B
A = Long(cdw_param_1.text)
B = Long(cdw_param_2.text)
IF ISNULL(A) THEN A=0
IF ISNULL(B) THEN B=0
long v_temp
select abierta into :v_temp from oc where nro_oc = :a using sqlca;
if v_temp > 0 then
	if B = 0 or isnull(B) then
		messagebox('Atención..', 'La OC es abierta, debe ingresar el número de rececpión')
		return
	end if
end if


//***Cruce para Inter Uno

if gl_importadora = 1 then
		
		vi_dw_lista.dataobject = "dw_lista_compras_cruce_iu"
else
		vi_dw_lista.dataobject = "dw_lista_compras_cruce"
end if
	
vi_dw_lista.settransobject(sqlca)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'

cant_filas = vi_dw_lista.retrieve(A,B)
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para recuperar...")
end if


end event

type gb_borde from w_modelo_filtro`gb_borde within w_filtra_reportes_cruce
integer y = 304
integer taborder = 0
long backcolor = 12632256
end type

type cdw_param_1 from editmask within w_filtra_reportes_cruce
integer x = 622
integer y = 88
integer width = 379
integer height = 80
integer taborder = 10
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

event modified;long v_temp, v_oc
v_oc = long(cdw_param_1.text)
v_temp = 4
select abierta into :v_temp from oc where nro_oc = :v_oc;
if v_temp = 4 then 
	messagebox('Atención...','No existe esta OC...')
	return
end if
if v_temp <> 0 then
	cdw_param_2.Enabled = true
	cdw_param_2.setfocus()
else
	cdw_param_2.text = '0'
	cdw_param_2.Enabled = false
end if
end event

type st_1 from statictext within w_filtra_reportes_cruce
integer x = 229
integer y = 96
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
string text = "Nro de OC:"
boolean focusrectangle = false
end type

type cdw_param_2 from editmask within w_filtra_reportes_cruce
integer x = 622
integer y = 176
integer width = 379
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###"
end type

type st_2 from statictext within w_filtra_reportes_cruce
integer x = 229
integer y = 184
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
string text = "Nro recepción:"
boolean focusrectangle = false
end type


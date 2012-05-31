$PBExportHeader$w_filtra_reportes_clicate.srw
forward
global type w_filtra_reportes_clicate from w_modelo_filtro
end type
type cdw_param_1 from datawindow within w_filtra_reportes_clicate
end type
type cdw_param_vend from datawindow within w_filtra_reportes_clicate
end type
type cbx_1 from checkbox within w_filtra_reportes_clicate
end type
end forward

global type w_filtra_reportes_clicate from w_modelo_filtro
integer width = 1705
integer height = 592
long backcolor = 12632256
cdw_param_1 cdw_param_1
cdw_param_vend cdw_param_vend
cbx_1 cbx_1
end type
global w_filtra_reportes_clicate w_filtra_reportes_clicate

event open;call super::open;cdw_param_1.SetTransObject(sqlca)
cdw_param_1.reset()
cdw_param_1.insertrow(0)

cdw_param_vend.SetTransObject(sqlca)
cdw_param_vend.reset()
cdw_param_vend.insertrow(0)

end event

on w_filtra_reportes_clicate.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
this.cdw_param_vend=create cdw_param_vend
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
this.Control[iCurrent+2]=this.cdw_param_vend
this.Control[iCurrent+3]=this.cbx_1
end on

on w_filtra_reportes_clicate.destroy
call super::destroy
destroy(this.cdw_param_1)
destroy(this.cdw_param_vend)
destroy(this.cbx_1)
end on

type pb_close from w_modelo_filtro`pb_close within w_filtra_reportes_clicate
integer x = 823
integer y = 324
integer taborder = 30
end type

type pb_ok from w_modelo_filtro`pb_ok within w_filtra_reportes_clicate
integer x = 430
integer y = 324
integer taborder = 20
end type

event pb_ok::clicked;long cant_filas
long A, B


if cbx_1.checked=true then
	vi_dw_lista.dataobject = "dw_lista_maes_clientes_todos"
else
	vi_dw_lista.dataobject = "dw_lista_maes_clientes"
end if

vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'


A = cdw_param_1.Getitemnumber(1,1)
B= cdw_param_vend.Getitemnumber(1,1)
//***
IF ISNULL(A) THEN
	A=0
END IF

IF ISNULL(B) THEN
	B=0
END IF
cant_filas = vi_dw_lista.retrieve(A,B)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if

//Filtros Establecidos
DataWindowChild cdw_Categoria
cdw_param_1.GetChild("cod_categoria", cdw_Categoria)
cdw_Categoria.SetTransObject(vg_server5)

if A <> 0 then
	vi_dw_lista.Object.filtro1.Text = trim( cdw_Categoria.getitemstring(cdw_Categoria.getrow(),2) ) 
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF


end event

type gb_borde from w_modelo_filtro`gb_borde within w_filtra_reportes_clicate
integer x = 398
integer y = 252
integer taborder = 0
long backcolor = 12632256
end type

type cdw_param_1 from datawindow within w_filtra_reportes_clicate
integer x = 46
integer y = 52
integer width = 1586
integer height = 72
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_param_categorias_cli"
boolean border = false
boolean livescroll = true
end type

type cdw_param_vend from datawindow within w_filtra_reportes_clicate
boolean visible = false
integer x = 46
integer y = 164
integer width = 1582
integer height = 68
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_param_vendedor"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_filtra_reportes_clicate
integer x = 599
integer y = 160
integer width = 585
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 12632256
string text = "Activos e Inactivos"
end type


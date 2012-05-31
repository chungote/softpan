$PBExportHeader$w_filtra_reportes_clizona_anho_suc.srw
forward
global type w_filtra_reportes_clizona_anho_suc from w_modelo_filtro
end type
type cdw_cate from datawindow within w_filtra_reportes_clizona_anho_suc
end type
type cdw_vend from datawindow within w_filtra_reportes_clizona_anho_suc
end type
type cbx_1 from checkbox within w_filtra_reportes_clizona_anho_suc
end type
type cdw_zona from datawindow within w_filtra_reportes_clizona_anho_suc
end type
type ddlb_1 from dropdownlistbox within w_filtra_reportes_clizona_anho_suc
end type
type st_1 from statictext within w_filtra_reportes_clizona_anho_suc
end type
type cdw_suc from datawindow within w_filtra_reportes_clizona_anho_suc
end type
type cdw_cli from datawindow within w_filtra_reportes_clizona_anho_suc
end type
end forward

global type w_filtra_reportes_clizona_anho_suc from w_modelo_filtro
integer width = 1723
integer height = 972
long backcolor = 12632256
cdw_cate cdw_cate
cdw_vend cdw_vend
cbx_1 cbx_1
cdw_zona cdw_zona
ddlb_1 ddlb_1
st_1 st_1
cdw_suc cdw_suc
cdw_cli cdw_cli
end type
global w_filtra_reportes_clizona_anho_suc w_filtra_reportes_clizona_anho_suc

type variables
long anho
end variables

event open;call super::open;cdw_cate.SetTransObject(sqlca)
cdw_cate.reset()
cdw_cate.insertrow(0)

cdw_vend.SetTransObject(sqlca)
cdw_vend.reset()
cdw_vend.insertrow(0)

cdw_suc.SetTransObject(sqlca)
cdw_suc.reset()
cdw_suc.insertrow(0)

cdw_cli.SetTransObject(sqlca)
cdw_cli.reset()
cdw_cli.insertrow(0)

cdw_zona.SetTransObject(sqlca)
cdw_zona.reset()
cdw_zona.insertrow(0)
end event

on w_filtra_reportes_clizona_anho_suc.create
int iCurrent
call super::create
this.cdw_cate=create cdw_cate
this.cdw_vend=create cdw_vend
this.cbx_1=create cbx_1
this.cdw_zona=create cdw_zona
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cdw_suc=create cdw_suc
this.cdw_cli=create cdw_cli
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_cate
this.Control[iCurrent+2]=this.cdw_vend
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cdw_zona
this.Control[iCurrent+5]=this.ddlb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cdw_suc
this.Control[iCurrent+8]=this.cdw_cli
end on

on w_filtra_reportes_clizona_anho_suc.destroy
call super::destroy
destroy(this.cdw_cate)
destroy(this.cdw_vend)
destroy(this.cbx_1)
destroy(this.cdw_zona)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cdw_suc)
destroy(this.cdw_cli)
end on

type pb_close from w_modelo_filtro`pb_close within w_filtra_reportes_clizona_anho_suc
integer x = 859
integer y = 696
integer taborder = 30
end type

type pb_ok from w_modelo_filtro`pb_ok within w_filtra_reportes_clizona_anho_suc
integer x = 466
integer y = 696
integer taborder = 20
end type

event pb_ok::clicked;long cant_filas
long A, B, C, D, E, F


/*if cbx_1.checked=true then
	vi_dw_lista.dataobject = "dw_lista_maes_clientes_todos"
else
	vi_dw_lista.dataobject = "dw_lista_maes_clientes"
end if*/

vi_dw_lista.settransobject(sqlca)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'


A = cdw_cate.Getitemnumber(1,1)
B = cdw_vend.Getitemnumber(1,1)
C = cdw_zona.Getitemnumber(1,1)
D = cdw_suc.Getitemnumber(1,1)
E = cdw_cli.Getitemnumber(1,1)
F = anho
if isnull(A) then A=0
if isnull(B) then B=0
if isnull(C) then C=0
if isnull(D) then D=0
if isnull(E) then E=0
if isnull(F) or F < 1 then F=Year(today())

//***
cant_filas = vi_dw_lista.retrieve(A,B,C,D,E,F)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if

//Filtros Establecidos
//DataWindowChild cdw_Categoria
//cdw_param_1.GetChild("cod_categoria", cdw_Categoria)
//cdw_Categoria.SetTransObject(vg_server5)

//if A <> 0 then
//	vi_dw_lista.Object.filtro1.Text = trim( cdw_Categoria.getitemstring(cdw_Categoria.getrow(),2) ) 
//ELSE
//	vi_dw_lista.Object.filtro1.Text = "Todos "
//END IF


end event

type gb_borde from w_modelo_filtro`gb_borde within w_filtra_reportes_clizona_anho_suc
integer x = 434
integer y = 624
integer taborder = 0
long backcolor = 12632256
end type

type cdw_cate from datawindow within w_filtra_reportes_clizona_anho_suc
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

type cdw_vend from datawindow within w_filtra_reportes_clizona_anho_suc
integer x = 46
integer y = 148
integer width = 1586
integer height = 72
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_param_vendedor"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_filtra_reportes_clizona_anho_suc
boolean visible = false
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

type cdw_zona from datawindow within w_filtra_reportes_clizona_anho_suc
integer x = 46
integer y = 240
integer width = 1586
integer height = 72
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_param_zonas"
boolean border = false
boolean livescroll = true
end type

type ddlb_1 from dropdownlistbox within w_filtra_reportes_clizona_anho_suc
integer x = 370
integer y = 516
integer width = 357
integer height = 400
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;anho = long(ddlb_1.text)
end event

type st_1 from statictext within w_filtra_reportes_clizona_anho_suc
integer x = 46
integer y = 528
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Año:"
alignment alignment = Left!
boolean focusrectangle = false
end type

type cdw_suc from datawindow within w_filtra_reportes_clizona_anho_suc
integer x = 37
integer y = 328
integer width = 1586
integer height = 72
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_param_sucursal2"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = StyleBox!
end type

type cdw_cli from datawindow within w_filtra_reportes_clizona_anho_suc
integer x = 46
integer y = 420
integer width = 1586
integer height = 72
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dw_param_clientes"
boolean border = false
boolean livescroll = true
end type


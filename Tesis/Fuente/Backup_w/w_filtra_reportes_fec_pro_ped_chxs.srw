$PBExportHeader$w_filtra_reportes_fec_pro_ped_chxs.srw
forward
global type w_filtra_reportes_fec_pro_ped_chxs from w_filtra_reportes_fec_cli_cat
end type
type gb_3 from groupbox within w_filtra_reportes_fec_pro_ped_chxs
end type
type gb_2 from groupbox within w_filtra_reportes_fec_pro_ped_chxs
end type
type gb_1 from groupbox within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_1 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_2 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_3 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_4 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_5 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_6 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_7 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_8 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
type rb_9 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
end type
end forward

global type w_filtra_reportes_fec_pro_ped_chxs from w_filtra_reportes_fec_cli_cat
integer width = 1678
integer height = 1036
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
rb_7 rb_7
rb_8 rb_8
rb_9 rb_9
end type
global w_filtra_reportes_fec_pro_ped_chxs w_filtra_reportes_fec_pro_ped_chxs

type variables
Integer aviso
end variables

on w_filtra_reportes_fec_pro_ped_chxs.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.rb_7=create rb_7
this.rb_8=create rb_8
this.rb_9=create rb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_4
this.Control[iCurrent+8]=this.rb_5
this.Control[iCurrent+9]=this.rb_6
this.Control[iCurrent+10]=this.rb_7
this.Control[iCurrent+11]=this.rb_8
this.Control[iCurrent+12]=this.rb_9
end on

on w_filtra_reportes_fec_pro_ped_chxs.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.rb_8)
destroy(this.rb_9)
end on

event close;
vi_dw_lista.vi_argumentos[1] = v_fech_ini.text 
vi_dw_lista.vi_argumentos[2] = v_fech_fin.text 
vi_dw_lista.vi_argumentos[3] = cdw_param_1.getitemstring(1, 1)
end event

type pb_close from w_filtra_reportes_fec_cli_cat`pb_close within w_filtra_reportes_fec_pro_ped_chxs
integer x = 882
integer y = 776
end type

type pb_ok from w_filtra_reportes_fec_cli_cat`pb_ok within w_filtra_reportes_fec_pro_ped_chxs
integer x = 489
integer y = 776
end type

event pb_ok::clicked;long cant_filas

//***
string A
long B
long C
long D
date E,F

A = cdw_param_1.GetitemString(1,1)
B = cdw_param_2.Getitemnumber(1,1)

IF rb_1.checked = TRUE THEN
	C = 1
END IF
IF rb_2.checked = TRUE THEN
	C = 0
END IF
IF rb_3.checked = TRUE THEN
	C = 2
END IF

IF rb_4.checked = TRUE THEN
	D = 1
END IF
IF rb_5.checked = TRUE THEN
	D = 0
END IF
IF rb_6.checked = TRUE THEN
	D = 2
END IF

//***
IF ISNULL(A) THEN
	A=''
END IF
IF ISNULL(B) THEN
	B=0
END IF

E = Date(v_Fech_ini.text)
F = Date(v_Fech_fin.text)

If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
	setnull(E)
end if

If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
	setnull(F)
end if

cant_filas = vi_dw_lista.retrieve(A,B,C,D,E,F)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if

//Filtros Establecidos
DataWindowChild cdw_Pedido
cdw_param_1.GetChild("nro_pedido", cdw_Pedido)
cdw_Pedido.SetTransObject(SQLCA)

DataWindowChild cdw_Producto
cdw_param_2.GetChild("codigo", cdw_Producto)
cdw_Producto.SetTransObject(SQLCA)

if A <> '' then
	vi_dw_lista.Object.filtro1.Text =  trim( string(cdw_Producto.getitemString(cdw_Producto.getrow(),1) ) )
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF

if B <> 0 then
	vi_dw_lista.Object.filtro2.Text =  trim( string(cdw_Pedido.getitemnumber(cdw_Pedido.getrow(),1) ) )
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "
END IF

vi_dw_lista.Object.filtro3.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_fin.text)

end event

type gb_borde from w_filtra_reportes_fec_cli_cat`gb_borde within w_filtra_reportes_fec_pro_ped_chxs
integer x = 457
integer y = 704
end type

type st_3 from w_filtra_reportes_fec_cli_cat`st_3 within w_filtra_reportes_fec_pro_ped_chxs
integer y = 68
end type

type st_4 from w_filtra_reportes_fec_cli_cat`st_4 within w_filtra_reportes_fec_pro_ped_chxs
integer y = 68
end type

type v_fech_fin from w_filtra_reportes_fec_cli_cat`v_fech_fin within w_filtra_reportes_fec_pro_ped_chxs
integer y = 68
end type

type v_fech_ini from w_filtra_reportes_fec_cli_cat`v_fech_ini within w_filtra_reportes_fec_pro_ped_chxs
integer y = 68
end type

type cdw_param_1 from w_filtra_reportes_fec_cli_cat`cdw_param_1 within w_filtra_reportes_fec_pro_ped_chxs
integer y = 184
string dataobject = "dw_param_productos"
end type

type cdw_param_2 from w_filtra_reportes_fec_cli_cat`cdw_param_2 within w_filtra_reportes_fec_pro_ped_chxs
integer y = 272
string dataobject = "dw_param_pedidos"
end type

type gb_3 from groupbox within w_filtra_reportes_fec_pro_ped_chxs
integer x = 1024
integer y = 380
integer width = 507
integer height = 316
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tipo"
end type

type gb_2 from groupbox within w_filtra_reportes_fec_pro_ped_chxs
integer x = 594
integer y = 380
integer width = 393
integer height = 316
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Facturado"
end type

type gb_1 from groupbox within w_filtra_reportes_fec_pro_ped_chxs
integer x = 155
integer y = 372
integer width = 389
integer height = 324
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Reservado"
end type

type rb_1 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 215
integer y = 444
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sí"
end type

type rb_2 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 215
integer y = 520
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "No"
end type

type rb_3 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 215
integer y = 592
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todos"
boolean checked = true
end type

type rb_4 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 654
integer y = 452
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sí"
end type

type rb_5 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 654
integer y = 528
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "No"
end type

type rb_6 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 654
integer y = 600
integer width = 256
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todos"
boolean checked = true
end type

type rb_7 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 1083
integer y = 452
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detalle"
end type

event clicked;IF rb_7.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes_det"
END IF
IF rb_8.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes_cab"
END IF
IF rb_9.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes"
END IF
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_8 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 1083
integer y = 528
integer width = 352
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Resumen"
end type

event clicked;IF rb_7.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes_det"
END IF
IF rb_8.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes_cab"
END IF
IF rb_9.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes"
END IF
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_9 from radiobutton within w_filtra_reportes_fec_pro_ped_chxs
integer x = 1083
integer y = 600
integer width = 375
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Completo"
boolean checked = true
end type

event clicked;IF rb_7.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes_det"
END IF
IF rb_8.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes_cab"
END IF
IF rb_9.checked = TRUE THEN
	vi_dw_lista.dataobject = "dw_lista_ventas_pedidos_clientes"
END IF
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event


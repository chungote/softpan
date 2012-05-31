$PBExportHeader$w_clave_vendedor.srw
forward
global type w_clave_vendedor from w_busca_fac_venta
end type
type sle_clave from singlelineedit within w_clave_vendedor
end type
type cb_1 from commandbutton within w_clave_vendedor
end type
end forward

global type w_clave_vendedor from w_busca_fac_venta
integer width = 1390
integer height = 400
string title = "Clave del vendedor"
boolean controlmenu = false
long backcolor = 16777215
sle_clave sle_clave
cb_1 cb_1
end type
global w_clave_vendedor w_clave_vendedor

on w_clave_vendedor.create
int iCurrent
call super::create
this.sle_clave=create sle_clave
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_clave
this.Control[iCurrent+2]=this.cb_1
end on

on w_clave_vendedor.destroy
call super::destroy
destroy(this.sle_clave)
destroy(this.cb_1)
end on

type cb_buscar from w_busca_fac_venta`cb_buscar within w_clave_vendedor
integer x = 251
integer y = 160
integer width = 366
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 700
string facename = "Trebuchet MS"
string text = "&Aceptar"
end type

event cb_buscar::clicked;	integer v_doc
	string v_clave
	v_doc = long(sle_clave.text)
	vg_cajero = 0
	SELECT clave into :v_clave FROM Vendedores
   where clave = :v_doc;
	if isnull(v_clave) or v_clave = "" then
		messagebox("Error...", "Clave incorrecta...")
		return
	end if
	if v_clave = sle_clave.text then
		SELECT cod_vendedor into :vg_vendedor FROM Vendedores
		where clave = :v_doc;
		vg_status=0 /*abre ventana de ventas*/
	   close(w_clave_vendedor)
   end if

end event

type st_1 from w_busca_fac_venta`st_1 within w_clave_vendedor
integer x = 69
integer y = 40
integer taborder = 20
string facename = "Trebuchet MS"
long backcolor = 16777215
string text = "Clave vendedor:"
alignment alignment = center!
end type

type em_factura from w_busca_fac_venta`em_factura within w_clave_vendedor
boolean visible = false
integer x = 910
integer y = 556
integer width = 370
integer taborder = 50
end type

type dw_doc from w_busca_fac_venta`dw_doc within w_clave_vendedor
boolean visible = false
integer x = 1262
integer y = 432
integer width = 741
string dataobject = "dw_param_cobrador"
end type

type sle_clave from singlelineedit within w_clave_vendedor
integer x = 544
integer y = 40
integer width = 718
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_clave_vendedor
integer x = 663
integer y = 160
integer width = 366
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "&Cancelar"
end type

event clicked;vg_status=1 /*cerrar ventana de venta*/
close(w_clave_vendedor)
end event


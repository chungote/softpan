$PBExportHeader$w_modelo_filtro.srw
forward
global type w_modelo_filtro from window
end type
type pb_close from uo_boton within w_modelo_filtro
end type
type pb_ok from uo_boton within w_modelo_filtro
end type
type gb_borde from groupbox within w_modelo_filtro
end type
end forward

global type w_modelo_filtro from window
integer x = 1038
integer y = 716
integer width = 1353
integer height = 656
boolean titlebar = true
string title = "Filtro del reporte"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 81324524
pb_close pb_close
pb_ok pb_ok
gb_borde gb_borde
end type
global w_modelo_filtro w_modelo_filtro

type variables
uo_datawindow vi_dw_lista

end variables

event open;if isvalid( message.PowerObjectParm ) then
	vi_dw_lista = message.PowerObjectParm
else
	messagebox('Error...', 'Datawindow no es válida...')
	post close(this)
end if

end event

on w_modelo_filtro.create
this.pb_close=create pb_close
this.pb_ok=create pb_ok
this.gb_borde=create gb_borde
this.Control[]={this.pb_close,&
this.pb_ok,&
this.gb_borde}
end on

on w_modelo_filtro.destroy
destroy(this.pb_close)
destroy(this.pb_ok)
destroy(this.gb_borde)
end on

type pb_close from uo_boton within w_modelo_filtro
integer x = 663
integer y = 292
integer width = 361
integer taborder = 20
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)
end event

type pb_ok from uo_boton within w_modelo_filtro
integer x = 270
integer y = 292
integer width = 361
string text = "&Recuperar"
end type

event clicked;call super::clicked;long cant_filas
cant_filas = vi_dw_lista.retrieve()
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para recuperar...")
end if

end event

type gb_borde from groupbox within w_modelo_filtro
integer x = 238
integer y = 220
integer width = 832
integer height = 212
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type


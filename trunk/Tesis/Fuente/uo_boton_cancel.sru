$PBExportHeader$uo_boton_cancel.sru
forward
global type uo_boton_cancel from uo_boton
end type
end forward

global type uo_boton_cancel from uo_boton
string Text="&Cancelar"
boolean Cancel=true
int TextSize=-8
end type
global uo_boton_cancel uo_boton_cancel

event clicked;call super::clicked;close(parent)
end event


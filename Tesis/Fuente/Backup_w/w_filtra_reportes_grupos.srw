$PBExportHeader$w_filtra_reportes_grupos.srw
forward
global type w_filtra_reportes_grupos from w_modelo_filtro
end type
type cdw_param_1 from datawindow within w_filtra_reportes_grupos
end type
end forward

global type w_filtra_reportes_grupos from w_modelo_filtro
integer width = 1705
integer height = 568
long backcolor = 12632256
cdw_param_1 cdw_param_1
end type
global w_filtra_reportes_grupos w_filtra_reportes_grupos

event open;call super::open;cdw_param_1.SetTransObject(sqlca)
cdw_param_1.reset()
cdw_param_1.insertrow(0)

end event

on w_filtra_reportes_grupos.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
end on

on w_filtra_reportes_grupos.destroy
call super::destroy
destroy(this.cdw_param_1)
end on

type pb_close from w_modelo_filtro`pb_close within w_filtra_reportes_grupos
integer x = 823
integer y = 260
integer taborder = 30
end type

type pb_ok from w_modelo_filtro`pb_ok within w_filtra_reportes_grupos
integer x = 430
integer y = 260
integer taborder = 20
end type

event pb_ok::clicked;long cant_filas

//***
string A

A = cdw_param_1.Getitemstring(1,1)

//***
IF ISNULL(A) THEN
	A=''
END IF

cant_filas = vi_dw_lista.retrieve(A)
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para recuperar...")
end if



end event

type gb_borde from w_modelo_filtro`gb_borde within w_filtra_reportes_grupos
integer x = 398
integer y = 188
integer taborder = 0
long backcolor = 12632256
end type

type cdw_param_1 from datawindow within w_filtra_reportes_grupos
integer x = 46
integer y = 52
integer width = 1586
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_param_sys_grupos"
boolean border = false
boolean livescroll = true
end type


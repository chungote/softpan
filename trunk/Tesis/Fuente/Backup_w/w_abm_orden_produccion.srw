$PBExportHeader$w_abm_orden_produccion.srw
forward
global type w_abm_orden_produccion from w_abm_cabecera_detalle_ancestor

type btn_buscar_producto from commandbutton within w_abm_orden_produccion
end type
end forward

global type w_abm_orden_produccion from w_abm_cabecera_detalle_ancestor
integer width = 3237
integer height = 2140
string title = "REGISTRAR ORDEN PRODUCCION"

btn_buscar_producto btn_buscar_producto
end type
global w_abm_orden_produccion w_abm_orden_produccion

on w_abm_orden_produccion.create
int iCurrent
call super::create
this.btn_buscar_producto=create btn_buscar_producto
iCurrent=UpperBound(this.Control)

this.Control[iCurrent+2]=this.btn_buscar_producto
end on

on w_abm_orden_produccion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)

destroy(this.btn_buscar_producto)
end on

event ue_buscar_1;open(w_busqueda_ordenes_produccion, this)
end event

type ole_skin from w_abm_cabecera_detalle_ancestor`ole_skin within w_abm_orden_produccion
integer y = 612
end type

type btn_buscar from w_abm_cabecera_detalle_ancestor`btn_buscar within w_abm_orden_produccion
integer x = 2203
integer y = 268
end type

type btn_cancelar from w_abm_cabecera_detalle_ancestor`btn_cancelar within w_abm_orden_produccion
integer x = 1705
integer y = 268
end type

type btn_modificar from w_abm_cabecera_detalle_ancestor`btn_modificar within w_abm_orden_produccion
integer x = 1207
integer y = 268
end type

type btn_guardar from w_abm_cabecera_detalle_ancestor`btn_guardar within w_abm_orden_produccion
integer x = 709
integer y = 268
end type

type btn_agregar from w_abm_cabecera_detalle_ancestor`btn_agregar within w_abm_orden_produccion
integer x = 210
integer y = 268
end type

type st_9 from w_abm_cabecera_detalle_ancestor`st_9 within w_abm_orden_produccion
integer y = 1888
end type

type st_8 from w_abm_cabecera_detalle_ancestor`st_8 within w_abm_orden_produccion
integer y = 1888
end type

type st_7 from w_abm_cabecera_detalle_ancestor`st_7 within w_abm_orden_produccion
integer y = 1784
end type

type st_6 from w_abm_cabecera_detalle_ancestor`st_6 within w_abm_orden_produccion
integer y = 1788
end type

type st_5 from w_abm_cabecera_detalle_ancestor`st_5 within w_abm_orden_produccion
integer y = 1788
end type

type st_4 from w_abm_cabecera_detalle_ancestor`st_4 within w_abm_orden_produccion
integer y = 1888
end type

type btn_imprimir from w_abm_cabecera_detalle_ancestor`btn_imprimir within w_abm_orden_produccion
integer x = 178
integer y = 992
end type

type btn_quitar_detalle from w_abm_cabecera_detalle_ancestor`btn_quitar_detalle within w_abm_orden_produccion
integer x = 2679
integer y = 1000
integer width = 471
end type

type btn_agregar_detalle from w_abm_cabecera_detalle_ancestor`btn_agregar_detalle within w_abm_orden_produccion
integer x = 2185
integer y = 1000
end type

type st_1 from w_abm_cabecera_detalle_ancestor`st_1 within w_abm_orden_produccion
end type

type btn_salir from w_abm_cabecera_detalle_ancestor`btn_salir within w_abm_orden_produccion
integer x = 2793
integer y = 268
end type

type cdw_datos_detalle from w_abm_cabecera_detalle_ancestor`cdw_datos_detalle within w_abm_orden_produccion
integer x = 192
integer y = 1156
integer width = 2990
string dataobject = "dw_abm_det_orden_produccion"
end type

type cdw_datos from w_abm_cabecera_detalle_ancestor`cdw_datos within w_abm_orden_produccion
integer y = 468
integer width = 2935
integer height = 504
string dataobject = "dw_abm_cab_orden_produccion"
end type

type st_2 from w_abm_cabecera_detalle_ancestor`st_2 within w_abm_orden_produccion
integer x = 183
integer y = 216
end type


integer x = 197
integer y = 32
integer width = 1893
integer height = 124
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 16777215
string text = "REGISTRAR ORDEN PRODUCCION"
boolean focusrectangle = false
end type

type btn_buscar_producto from commandbutton within w_abm_orden_produccion
integer x = 658
integer y = 992
integer width = 558
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
string text = "BUSCAR PRODUCTO"
end type

 
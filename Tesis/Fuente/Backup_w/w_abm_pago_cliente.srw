$PBExportHeader$w_abm_pago_cliente.srw
forward
global type w_abm_pago_cliente from w_abm_cabecera_detalle_ancestor
end type
end forward

global type w_abm_pago_cliente from w_abm_cabecera_detalle_ancestor
integer width = 3726
integer height = 2392
end type
global w_abm_pago_cliente w_abm_pago_cliente

on w_abm_pago_cliente.create
call super::create
end on

on w_abm_pago_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type ole_skin from w_abm_cabecera_detalle_ancestor`ole_skin within w_abm_pago_cliente
integer x = 3223
integer y = 300
end type

type btn_buscar from w_abm_cabecera_detalle_ancestor`btn_buscar within w_abm_pago_cliente
end type

type btn_cancelar from w_abm_cabecera_detalle_ancestor`btn_cancelar within w_abm_pago_cliente
end type

type btn_modificar from w_abm_cabecera_detalle_ancestor`btn_modificar within w_abm_pago_cliente
end type

type btn_guardar from w_abm_cabecera_detalle_ancestor`btn_guardar within w_abm_pago_cliente
end type

type btn_agregar from w_abm_cabecera_detalle_ancestor`btn_agregar within w_abm_pago_cliente
end type

type st_9 from w_abm_cabecera_detalle_ancestor`st_9 within w_abm_pago_cliente
integer x = 1490
integer y = 2080
end type

type st_8 from w_abm_cabecera_detalle_ancestor`st_8 within w_abm_pago_cliente
integer x = 905
integer y = 2080
end type

type st_7 from w_abm_cabecera_detalle_ancestor`st_7 within w_abm_pago_cliente
integer x = 1490
integer y = 1976
end type

type st_6 from w_abm_cabecera_detalle_ancestor`st_6 within w_abm_pago_cliente
integer x = 905
integer y = 1980
end type

type st_5 from w_abm_cabecera_detalle_ancestor`st_5 within w_abm_pago_cliente
integer x = 201
integer y = 1980
end type

type st_4 from w_abm_cabecera_detalle_ancestor`st_4 within w_abm_pago_cliente
integer x = 192
integer y = 2080
end type

type btn_imprimir from w_abm_cabecera_detalle_ancestor`btn_imprimir within w_abm_pago_cliente
integer x = 178
integer y = 1192
end type

type btn_quitar_detalle from w_abm_cabecera_detalle_ancestor`btn_quitar_detalle within w_abm_pago_cliente
integer x = 1179
integer y = 1192
string text = "QUITAR "
end type

type btn_agregar_detalle from w_abm_cabecera_detalle_ancestor`btn_agregar_detalle within w_abm_pago_cliente
integer x = 672
integer y = 1192
string text = "AGREGAR "
end type

type st_1 from w_abm_cabecera_detalle_ancestor`st_1 within w_abm_pago_cliente
integer height = 2372
end type

type btn_salir from w_abm_cabecera_detalle_ancestor`btn_salir within w_abm_pago_cliente
end type

type cdw_datos_detalle from w_abm_cabecera_detalle_ancestor`cdw_datos_detalle within w_abm_pago_cliente
integer x = 174
integer y = 1348
integer width = 3314
string dataobject = "dw_abm_det_pago_cliente"
end type

type cdw_datos from w_abm_cabecera_detalle_ancestor`cdw_datos within w_abm_pago_cliente
integer x = 174
integer y = 356
integer width = 3438
integer height = 780
string dataobject = "dw_abm_pago_cliente"
end type

type st_2 from w_abm_cabecera_detalle_ancestor`st_2 within w_abm_pago_cliente
end type


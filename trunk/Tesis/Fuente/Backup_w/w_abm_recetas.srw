$PBExportHeader$w_abm_recetas.srw
forward
global type w_abm_recetas from w_abm_cabecera_detalle_ancestor
end type
end forward

global type w_abm_recetas from w_abm_cabecera_detalle_ancestor
integer width = 3035
string title = "ELABORAR RECETAS"
end type
global w_abm_recetas w_abm_recetas

on w_abm_recetas.create
call super::create
end on

on w_abm_recetas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type ole_skin from w_abm_cabecera_detalle_ancestor`ole_skin within w_abm_recetas
end type

type btn_buscar from w_abm_cabecera_detalle_ancestor`btn_buscar within w_abm_recetas
end type

type btn_cancelar from w_abm_cabecera_detalle_ancestor`btn_cancelar within w_abm_recetas
end type

type btn_modificar from w_abm_cabecera_detalle_ancestor`btn_modificar within w_abm_recetas
end type

type btn_guardar from w_abm_cabecera_detalle_ancestor`btn_guardar within w_abm_recetas
end type

type btn_agregar from w_abm_cabecera_detalle_ancestor`btn_agregar within w_abm_recetas
end type

type st_9 from w_abm_cabecera_detalle_ancestor`st_9 within w_abm_recetas
end type

type st_8 from w_abm_cabecera_detalle_ancestor`st_8 within w_abm_recetas
end type

type st_7 from w_abm_cabecera_detalle_ancestor`st_7 within w_abm_recetas
end type

type st_6 from w_abm_cabecera_detalle_ancestor`st_6 within w_abm_recetas
end type

type st_5 from w_abm_cabecera_detalle_ancestor`st_5 within w_abm_recetas
string text = "F1: Agregar Recetas"
end type

type st_4 from w_abm_cabecera_detalle_ancestor`st_4 within w_abm_recetas
end type

type btn_imprimir from w_abm_cabecera_detalle_ancestor`btn_imprimir within w_abm_recetas
integer x = 215
integer y = 1124
integer width = 613
string text = "I&MPRIMIR RECETAS"
end type

type btn_quitar_detalle from w_abm_cabecera_detalle_ancestor`btn_quitar_detalle within w_abm_recetas
integer x = 2249
integer y = 1380
integer width = 489
end type

type btn_agregar_detalle from w_abm_cabecera_detalle_ancestor`btn_agregar_detalle within w_abm_recetas
integer x = 2249
integer y = 1244
integer width = 485
end type

type st_1 from w_abm_cabecera_detalle_ancestor`st_1 within w_abm_recetas
end type

type btn_salir from w_abm_cabecera_detalle_ancestor`btn_salir within w_abm_recetas
integer x = 2729
end type

type cdw_datos_detalle from w_abm_cabecera_detalle_ancestor`cdw_datos_detalle within w_abm_recetas
integer x = 197
integer y = 1248
integer width = 2030
string dataobject = "dw_abm_det_recetas"
end type

type cdw_datos from w_abm_cabecera_detalle_ancestor`cdw_datos within w_abm_recetas
integer width = 2674
integer height = 700
string dataobject = "dw_abm_cab_receta"
end type

type st_2 from w_abm_cabecera_detalle_ancestor`st_2 within w_abm_recetas
integer width = 2766
end type


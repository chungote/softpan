$PBExportHeader$w_abm_seleccionar_nivel.srw
forward
global type w_abm_seleccionar_nivel from window
end type
type tv_1 from treeview within w_abm_seleccionar_nivel
end type
type pb_ok from uo_boton within w_abm_seleccionar_nivel
end type
type pb_cancel from uo_boton_cancel within w_abm_seleccionar_nivel
end type
type gb_1 from groupbox within w_abm_seleccionar_nivel
end type
end forward

global type w_abm_seleccionar_nivel from window
integer x = 750
integer y = 212
integer width = 2190
integer height = 1660
boolean titlebar = true
string title = "Seleccionar niveles"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
tv_1 tv_1
pb_ok pb_ok
pb_cancel pb_cancel
gb_1 gb_1
end type
global w_abm_seleccionar_nivel w_abm_seleccionar_nivel

type variables
DataStore ids_Source

end variables

on w_abm_seleccionar_nivel.create
this.tv_1=create tv_1
this.pb_ok=create pb_ok
this.pb_cancel=create pb_cancel
this.gb_1=create gb_1
this.Control[]={this.tv_1,&
this.pb_ok,&
this.pb_cancel,&
this.gb_1}
end on

on w_abm_seleccionar_nivel.destroy
destroy(this.tv_1)
destroy(this.pb_ok)
destroy(this.pb_cancel)
destroy(this.gb_1)
end on

event open;//ids_Source = Create DataStore
//Integer				li_Rows, li_Cnt
//TreeViewItem		ltvi_Item
//SetPointer(HourGlass!)
//ids_Source.DataObject = "dw_mercado_seccion"
//ids_Source.SetTransObject(sqlca)
//li_Rows = ids_Source.Retrieve()
//For li_Cnt = 1 To li_Rows
//	ltvi_Item.label = ids_Source.getitemstring(li_Cnt, 2) + ' (' + string(ids_Source.getitemnumber(li_Cnt, 1)) + ')'
//	ltvi_Item.data = ids_Source.getitemnumber(li_Cnt, 1)
//	ltvi_Item.pictureindex = 1
////	ltvi_Item.selectedpictureindex = 7
//	ltvi_Item.children = true
//	tv_1.InsertItemLast(0, ltvi_Item)
//next
//

end event

type tv_1 from treeview within w_abm_seleccionar_nivel
integer x = 37
integer y = 32
integer width = 2089
integer height = 1328
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer indent = 150
boolean linesatroot = true
string picturename[] = {"Globals!","Library!","Project!","DeclareProcedure!","Custom035!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event itempopulate;//
//Integer				li_Rows, li_Cnt
//TreeViewItem		ltvi_temp, ltvi_temp_ant, ltvi_temp_new
//long v_nivel
//If GetItem(handle, ltvi_temp_ant) = -1 Then Return
//If GetItem(handle, ltvi_temp) = -1 Then Return
//SetPointer(HourGlass!)
//v_nivel = ltvi_temp.level
//if v_nivel = 1 then
//	ids_Source.DataObject = "dw_mercado_sub_seccion"
//	ids_Source.SetTransObject(sqlca)
//	ids_Source.Reset()
//	li_Rows = ids_Source.Retrieve(Integer(ltvi_temp.data))
//	For li_Cnt = 1 To li_Rows
//		ltvi_temp_new.label = ids_Source.Object.sub_secciones[li_Cnt] + ' (' + string(ids_Source.Object.cod_sub_seccion[li_Cnt]) + ')'
//		ltvi_temp_new.data = ids_Source.Object.cod_sub_seccion[li_Cnt]
//		ltvi_temp_new.pictureindex = 2
//		ltvi_temp_new.children = true
//		InsertItemlast(handle, ltvi_temp_new)
//	Next
//
//end if
//
//long v_sec, v_sub_secc, v_grupo, v_cate
//
//if v_nivel = 2 then
//	ids_Source.DataObject = "dw_mercado_grupo"
//	ids_Source.SetTransObject(sqlca)
//	ids_Source.Reset()
//	v_sub_secc = long(ltvi_temp.data)
//	
//	select cod_seccion into :v_sec from sub_seccion where cod_sub_seccion = :v_sub_secc;
//	li_Rows = ids_Source.Retrieve(v_sec, v_sub_secc)
//	For li_Cnt = 1 To li_Rows
//		ltvi_temp_new.label = ids_Source.Object.descripcion_grupo[li_Cnt] + ' (' + string(ids_Source.Object.cod_grupo[li_Cnt]) + ')'
//		ltvi_temp_new.data = ids_Source.Object.cod_grupo[li_Cnt]
//		ltvi_temp_new.pictureindex = 3
//		ltvi_temp_new.children = true
//		InsertItemlast(handle, ltvi_temp_new)
//	Next
//
//end if
//
//if v_nivel = 3 then
//	ids_Source.DataObject = "dw_mercado_categoria"
//	ids_Source.SetTransObject(sqlca)
//	ids_Source.Reset()
//	v_grupo = long(ltvi_temp.data)
//	select cod_seccion, cod_sub_seccion into :v_sec, :v_sub_secc from grupo where cod_grupo = :v_grupo;
//	
//
//	
//	li_Rows = ids_Source.Retrieve(v_sec, v_sub_secc, v_grupo)
//
//	For li_Cnt = 1 To li_Rows
//		
//		ltvi_temp_new.label = ids_Source.Object.descripcion_categoria[li_Cnt] + ' (' + string(ids_Source.Object.cod_categoria[li_Cnt]) + ')'
//		ltvi_temp_new.data = ids_Source.Object.cod_categoria[li_Cnt]
//		//messagebox('total',string(ltvi_temp_new.label ))
//		
//		ltvi_temp_new.pictureindex = 4
//		ltvi_temp_new.children = true
//		InsertItemlast(handle, ltvi_temp_new)
//	Next
//
//end if
//
//if v_nivel = 4 then
//	ids_Source.DataObject = "dw_mercado_sub_categoria"
//	ids_Source.SetTransObject(sqlca)
//	ids_Source.Reset()
//	v_cate = long(ltvi_temp.data)
//	select cod_seccion, cod_sub_seccion, cod_grupo into :v_sec, :v_sub_secc, :v_grupo 
//	from categorias where cod_categoria = :v_cate;
//	li_Rows = ids_Source.Retrieve(v_sec, v_sub_secc, v_grupo, v_cate)
//	For li_Cnt = 1 To li_Rows
//		ltvi_temp_new.label = ids_Source.Object.descripcion_sub_categoria[li_Cnt] + ' (' + string(ids_Source.Object.cod_sub_categoria[li_Cnt]) + ')'
//		ltvi_temp_new.data = ids_Source.Object.cod_sub_categoria[li_Cnt]
//		ltvi_temp_new.pictureindex = 5
//		ltvi_temp_new.children = false
//		InsertItemlast(handle, ltvi_temp_new)
//	Next
//	
//end if
//
//tv_1.setitem(handle, ltvi_temp_ant)
end event

type pb_ok from uo_boton within w_abm_seleccionar_nivel
integer x = 631
integer y = 1408
integer taborder = 30
string text = "Procesar"
end type

event clicked;call super::clicked;//long ll_tvi, v_nivel, ll_valor, v_temp
//TreeViewItem ltvi_temp, ltvi_valor
//ll_tvi = tv_1.FindItem(CurrentTreeItem! , 0)
//If tv_1.GetItem(ll_tvi, ltvi_temp) = -1 Then Return
//v_nivel = ltvi_temp.level
//ltvi_valor = ltvi_temp
//ll_valor = ll_tvi
//
//vg_param_6a = 0
//vg_param_6b = 0
//vg_sub_cate_txt = ''
//vg_param_5a = 0
//vg_param_5b = 0
//vg_cate_txt = ''
//vg_param_4a = 0
//vg_param_4b = 0
//vg_grupo_txt = ''
//vg_param_3a = 0
//vg_param_3b = 0
//vg_sub_seccion_txt = ''
//vg_param_2a = 0
//vg_param_2b = 0
//vg_seccion_txt = ''
//
//do while v_nivel > 0
//	if v_nivel = 5 then
//		vg_param_6a = long(ltvi_valor.data)
//		vg_param_6b = long(ltvi_valor.data)
//		vg_sub_cate_txt = string(ltvi_valor.label)
//	end if	
//	if v_nivel = 4 then
//		vg_param_5a = long(ltvi_valor.data)
//		vg_param_5b = long(ltvi_valor.data)
//		vg_cate_txt = string(ltvi_valor.label)
//	end if	
//	if v_nivel = 3 then
//		vg_param_4a = long(ltvi_valor.data)
//		vg_param_4b = long(ltvi_valor.data)
//		vg_grupo_txt = string(ltvi_valor.label)
//	end if	
//	if v_nivel = 2 then
//		vg_param_3a = long(ltvi_valor.data)
//		vg_param_3b = long(ltvi_valor.data)
//		vg_sub_seccion_txt = string(ltvi_valor.label)
//	end if	
//	if v_nivel = 1 then
//		vg_param_2a = long(ltvi_valor.data)
//		vg_param_2b = long(ltvi_valor.data)
//		vg_seccion_txt = string(ltvi_valor.label)
//		exit
//	end if	
//	
//	ll_valor = tv_1.FindItem(ParentTreeItem!, ll_valor)
//	If tv_1.GetItem(ll_valor, ltvi_valor) = -1 Then Return
//	v_nivel = v_nivel - 1	
//loop
//
//close(parent)

end event

type pb_cancel from uo_boton_cancel within w_abm_seleccionar_nivel
integer x = 1051
integer y = 1408
integer taborder = 20
end type

event clicked;vg_param_6a = 0
vg_param_6b = 0
vg_sub_cate_txt = ''
vg_param_5a = 0
vg_param_5b = 0
vg_cate_txt = ''
vg_param_4a = 0
vg_param_4b = 0
vg_grupo_txt = ''
vg_param_3a = 0
vg_param_3b = 0
vg_sub_seccion_txt = ''
vg_param_2a = 0
vg_param_2b = 0
vg_seccion_txt = ''
close(parent)
end event

type gb_1 from groupbox within w_abm_seleccionar_nivel
integer x = 594
integer y = 1348
integer width = 910
integer height = 188
integer taborder = 20
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


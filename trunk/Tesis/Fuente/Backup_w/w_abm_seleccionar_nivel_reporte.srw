$PBExportHeader$w_abm_seleccionar_nivel_reporte.srw
forward
global type w_abm_seleccionar_nivel_reporte from w_abm_seleccionar_nivel
end type
type dw_familias from uo_datawindow within w_abm_seleccionar_nivel_reporte
end type
type dw_busca from uo_datawindow within w_abm_seleccionar_nivel_reporte
end type
end forward

global type w_abm_seleccionar_nivel_reporte from w_abm_seleccionar_nivel
int X=741
int Y=136
int Width=2203
int Height=1820
long BackColor=12632256
dw_familias dw_familias
dw_busca dw_busca
end type
global w_abm_seleccionar_nivel_reporte w_abm_seleccionar_nivel_reporte

on w_abm_seleccionar_nivel_reporte.create
int iCurrent
call super::create
this.dw_familias=create dw_familias
this.dw_busca=create dw_busca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_familias
this.Control[iCurrent+2]=this.dw_busca
end on

on w_abm_seleccionar_nivel_reporte.destroy
call super::destroy
destroy(this.dw_familias)
destroy(this.dw_busca)
end on

event open;call super::open;dw_familias.SetTransObject(sqlca)
dw_familias.insertrow(0)

dw_familias.setfocus()

end event

type tv_1 from w_abm_seleccionar_nivel`tv_1 within w_abm_seleccionar_nivel_reporte
int Width=2112
int Height=1252
end type

type pb_ok from w_abm_seleccionar_nivel`pb_ok within w_abm_seleccionar_nivel_reporte
int X=622
int Y=1568
int TabOrder=50
end type

event pb_ok::clicked;long ll_tvi, v_nivel, ll_valor, v_temp
TreeViewItem ltvi_temp, ltvi_valor

vg_param_6a = 0
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

v_temp = 1
ll_tvi = tv_1.FindItem(CurrentTreeItem! , 0)
If tv_1.GetItem(ll_tvi, ltvi_temp) = -1 Then v_temp = 0

if v_temp = 1 then
	ll_tvi = tv_1.FindItem(CurrentTreeItem! , 0)
	If tv_1.GetItem(ll_tvi, ltvi_temp) = -1 Then Return
	v_nivel = ltvi_temp.level
	ltvi_valor = ltvi_temp
	ll_valor = ll_tvi
	
	do while v_nivel > 0
		if v_nivel = 5 then
			vg_param_6a = long(ltvi_valor.data)
			vg_param_6b = long(ltvi_valor.data)
			vg_sub_cate_txt = string(ltvi_valor.label)
		end if	
		if v_nivel = 4 then
			vg_param_5a = long(ltvi_valor.data)
			vg_param_5b = long(ltvi_valor.data)
			vg_cate_txt = string(ltvi_valor.label)
		end if	
		if v_nivel = 3 then
			vg_param_4a = long(ltvi_valor.data)
			vg_param_4b = long(ltvi_valor.data)
			vg_grupo_txt = string(ltvi_valor.label)
		end if	
		if v_nivel = 2 then
			vg_param_3a = long(ltvi_valor.data)
			vg_param_3b = long(ltvi_valor.data)
			vg_sub_seccion_txt = string(ltvi_valor.label)
		end if	
		if v_nivel = 1 then
			vg_param_2a = long(ltvi_valor.data)
			vg_param_2b = long(ltvi_valor.data)
			vg_seccion_txt = string(ltvi_valor.label)
			exit
		end if	
		
		ll_valor = tv_1.FindItem(ParentTreeItem!, ll_valor)
		If tv_1.GetItem(ll_valor, ltvi_valor) = -1 Then Return
		v_nivel = v_nivel - 1	
	loop
end if



vg_param_7a = dw_familias.Getitemnumber(1,'marcas_cod_marca')
vg_param_7b = dw_familias.Getitemnumber(1,'marcas_cod_marca')
IF ISNULL(vg_param_7a) THEN vg_param_7a =0
IF ISNULL(vg_param_7b) THEN vg_param_7b=0
vg_param_1a = dw_familias.Getitemstring(1,'productos_codigo')
vg_param_1b = dw_familias.Getitemstring(1,'productos_codigo')
IF ISNULL(vg_param_1a) THEN vg_param_1a =''
IF ISNULL(vg_param_1b) THEN vg_param_1b=''

close(parent)

end event

type pb_cancel from w_abm_seleccionar_nivel`pb_cancel within w_abm_seleccionar_nivel_reporte
int X=1042
int Y=1568
end type

event pb_cancel::clicked;vg_param_6a = 0
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
vg_param_7a =0
vg_param_7b=0
vg_param_1a =''
vg_param_1b=''
close(parent)

end event

type gb_1 from w_abm_seleccionar_nivel`gb_1 within w_abm_seleccionar_nivel_reporte
int X=585
int Y=1508
int TabOrder=40
long BackColor=12632256
end type

type dw_familias from uo_datawindow within w_abm_seleccionar_nivel_reporte
event ue_tecla_pulsada pbm_dwnkey
int X=32
int Y=1316
int Width=2167
int Height=216
int TabOrder=30
boolean BringToTop=true
string DataObject="dw_filtra_productos_niveles"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_familias)
end if


end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_familias, dw_busca)

end event

type dw_busca from uo_datawindow within w_abm_seleccionar_nivel_reporte
int X=1801
int Y=1536
int Width=224
int Height=188
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
end type


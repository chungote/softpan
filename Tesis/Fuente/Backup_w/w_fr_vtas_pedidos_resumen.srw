$PBExportHeader$w_fr_vtas_pedidos_resumen.srw
forward
global type w_fr_vtas_pedidos_resumen from w_fr_general
end type
end forward

global type w_fr_vtas_pedidos_resumen from w_fr_general
integer x = 800
integer y = 324
integer width = 1929
integer height = 1188
end type
global w_fr_vtas_pedidos_resumen w_fr_vtas_pedidos_resumen

on w_fr_vtas_pedidos_resumen.create
call super::create
end on

on w_fr_vtas_pedidos_resumen.destroy
call super::destroy
end on

type pb_close from w_fr_general`pb_close within w_fr_vtas_pedidos_resumen
integer x = 914
integer y = 904
integer taborder = 110
end type

type pb_ok from w_fr_general`pb_ok within w_fr_vtas_pedidos_resumen
integer x = 521
integer y = 904
integer taborder = 100
end type

event pb_ok::clicked;call super::clicked;
long cant_filas
cant_filas = vi_dw_lista.retrieve(vg_param_1a,vg_param_1b,vg_param_2a,vg_param_2b,vg_param_3a,vg_param_3b,vg_param_4a,vg_param_4b,vg_param_5a,vg_param_5b,vg_param_6a,vg_param_6b,vg_param_7a,vg_param_7b,vi_fi1,vi_ff1,vi_cliente,vi_cliente_cate,vi_dep1)
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para el rango definido...")
end if

	if vg_param_1a <> '' then
		vi_dw_lista.Object.filtro1a.Text = filtro_producto(vg_param_1a)
	ELSE
		vi_dw_lista.Object.filtro1a.Text = "Todos "
	END IF
	if vg_param_1b <> '' then
		vi_dw_lista.Object.filtro1b.Text = filtro_producto(vg_param_1b)
	ELSE
		vi_dw_lista.Object.filtro1b.Text = "Todos "
	END IF
	if vg_param_2a <> 0 then
		vi_dw_lista.Object.filtro2a.Text = filtro_seccion(vg_param_2a)
	ELSE
		vi_dw_lista.Object.filtro2a.Text = "Todos "
	END IF
	if vg_param_2b <> 0 then
		vi_dw_lista.Object.filtro2b.Text = filtro_seccion(vg_param_2b)
	ELSE
		vi_dw_lista.Object.filtro2b.Text = "Todos "
	END IF

	if vg_param_3a <> 0 then
		vi_dw_lista.Object.filtro3a.Text = filtro_sub_seccion(vg_param_3a)
	ELSE
		vi_dw_lista.Object.filtro3a.Text = "Todos "
	END IF
	if vg_param_3b <> 0 then
		vi_dw_lista.Object.filtro3b.Text = filtro_sub_seccion(vg_param_3b)
	ELSE
		vi_dw_lista.Object.filtro3b.Text = "Todos "
	END IF

	if vg_param_4a <> 0 then
		vi_dw_lista.Object.filtro4a.Text = filtro_grupo(vg_param_4a)
	ELSE
		vi_dw_lista.Object.filtro4a.Text = "Todos "
	END IF
	if vg_param_4b <> 0 then
		vi_dw_lista.Object.filtro4b.Text = filtro_grupo(vg_param_4b)
	ELSE
		vi_dw_lista.Object.filtro4b.Text = "Todos "
	END IF

	if vg_param_5a <> 0 then
		vi_dw_lista.Object.filtro5a.Text = filtro_categoria(vg_param_5a)
	ELSE
		vi_dw_lista.Object.filtro5a.Text = "Todos "
	END IF
	if vg_param_5b <> 0 then
		vi_dw_lista.Object.filtro5b.Text = filtro_categoria(vg_param_5b)
	ELSE
		vi_dw_lista.Object.filtro5b.Text = "Todos "
	END IF

	if vg_param_6a <> 0 then
		vi_dw_lista.Object.filtro6a.Text = filtro_sub_cate(vg_param_6a)
	ELSE
		vi_dw_lista.Object.filtro6a.Text = "Todos "
	END IF
	if vg_param_6b <> 0 then
		vi_dw_lista.Object.filtro6b.Text = filtro_sub_cate(vg_param_6b)
	ELSE
		vi_dw_lista.Object.filtro6b.Text = "Todos "
	END IF

	if vg_param_7a <> 0 then
		vi_dw_lista.Object.filtro7a.Text = filtro_marcas(vg_param_7a)
	ELSE
		vi_dw_lista.Object.filtro7a.Text = "Todos "
	END IF
	if vg_param_7b <> 0 then
		vi_dw_lista.Object.filtro7b.Text = filtro_marcas(vg_param_7b)
	ELSE
		vi_dw_lista.Object.filtro7b.Text = "Todos "
	END IF

	vi_dw_lista.Object.filtro1.Text = vi_cliente_text
	vi_dw_lista.Object.filtro2.Text = vi_cliente_cate_text

	vi_dw_lista.Object.filtro3.Text = vi_dep_text1
vi_dw_lista.Object.filtro4.Text = string(vi_fi1)
vi_dw_lista.Object.filtro5.Text = string(vi_ff1)



end event

type gb_borde from w_fr_general`gb_borde within w_fr_vtas_pedidos_resumen
integer x = 489
integer y = 832
end type

type st_3 from w_fr_general`st_3 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 59
integer width = 338
end type

type v_fi1 from w_fr_general`v_fi1 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 402
end type

type st_4 from w_fr_general`st_4 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 901
end type

type v_ff1 from w_fr_general`v_ff1 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 1161
integer taborder = 20
end type

type st_5 from w_fr_general`st_5 within w_fr_vtas_pedidos_resumen
end type

type v_fi2 from w_fr_general`v_fi2 within w_fr_vtas_pedidos_resumen
integer taborder = 150
end type

type st_6 from w_fr_general`st_6 within w_fr_vtas_pedidos_resumen
end type

type v_ff2 from w_fr_general`v_ff2 within w_fr_vtas_pedidos_resumen
integer taborder = 170
end type

type st_7 from w_fr_general`st_7 within w_fr_vtas_pedidos_resumen
end type

type v_fi3 from w_fr_general`v_fi3 within w_fr_vtas_pedidos_resumen
integer taborder = 180
end type

type st_8 from w_fr_general`st_8 within w_fr_vtas_pedidos_resumen
end type

type v_ff3 from w_fr_general`v_ff3 within w_fr_vtas_pedidos_resumen
integer taborder = 190
end type

type st_9 from w_fr_general`st_9 within w_fr_vtas_pedidos_resumen
end type

type st_10 from w_fr_general`st_10 within w_fr_vtas_pedidos_resumen
end type

type v_ff4 from w_fr_general`v_ff4 within w_fr_vtas_pedidos_resumen
integer taborder = 210
end type

type v_fi4 from w_fr_general`v_fi4 within w_fr_vtas_pedidos_resumen
integer taborder = 200
end type

type dw_suc1 from w_fr_general`dw_suc1 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 402
integer y = 136
integer taborder = 30
end type

type dw_busca from w_fr_general`dw_busca within w_fr_vtas_pedidos_resumen
integer taborder = 220
end type

type dw_suc2 from w_fr_general`dw_suc2 within w_fr_vtas_pedidos_resumen
integer taborder = 230
end type

type st_12 from w_fr_general`st_12 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 59
integer y = 140
integer width = 338
end type

type st_13 from w_fr_general`st_13 within w_fr_vtas_pedidos_resumen
end type

type dw_dep1 from w_fr_general`dw_dep1 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 402
integer y = 248
integer taborder = 40
end type

type st_14 from w_fr_general`st_14 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 59
integer y = 252
integer width = 338
end type

type dw_dep2 from w_fr_general`dw_dep2 within w_fr_vtas_pedidos_resumen
integer taborder = 240
end type

type st_15 from w_fr_general`st_15 within w_fr_vtas_pedidos_resumen
end type

type pb_1 from w_fr_general`pb_1 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 699
integer y = 576
integer taborder = 90
end type

type dw_provee from w_fr_general`dw_provee within w_fr_vtas_pedidos_resumen
integer taborder = 250
end type

type st_16 from w_fr_general`st_16 within w_fr_vtas_pedidos_resumen
end type

type gb_1 from w_fr_general`gb_1 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 210
integer y = 656
integer width = 1454
integer height = 164
integer taborder = 0
end type

type rb_1 from w_fr_general`rb_1 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 270
integer y = 716
integer width = 549
integer taborder = 70
string text = "Resumen de pedidos"
boolean checked = true
end type

event rb_1::clicked;call super::clicked;vi_dw_lista.dataobject = "dw_lista_ventas_resumen_pedidos"	
vi_dw_lista.settransobject(sqlca)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_2 from w_fr_general`rb_2 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 905
integer y = 716
integer width = 667
integer taborder = 80
string text = "Cantidades no entregadas"
end type

event rb_2::clicked;call super::clicked;vi_dw_lista.dataobject = "dw_lista_ventas_resumen_pedidos_pendien"	
vi_dw_lista.settransobject(sqlca)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type rb_3 from w_fr_general`rb_3 within w_fr_vtas_pedidos_resumen
end type

type rb_4 from w_fr_general`rb_4 within w_fr_vtas_pedidos_resumen
end type

type rb_5 from w_fr_general`rb_5 within w_fr_vtas_pedidos_resumen
end type

type st_17 from w_fr_general`st_17 within w_fr_vtas_pedidos_resumen
end type

type dw_tip_doc from w_fr_general`dw_tip_doc within w_fr_vtas_pedidos_resumen
integer taborder = 260
end type

type dw_comp_cond from w_fr_general`dw_comp_cond within w_fr_vtas_pedidos_resumen
integer taborder = 270
end type

type st_18 from w_fr_general`st_18 within w_fr_vtas_pedidos_resumen
end type

type st_19 from w_fr_general`st_19 within w_fr_vtas_pedidos_resumen
end type

type dw_plazo from w_fr_general`dw_plazo within w_fr_vtas_pedidos_resumen
integer taborder = 160
end type

type dw_moneda from w_fr_general`dw_moneda within w_fr_vtas_pedidos_resumen
integer taborder = 120
end type

type dw_comprador from w_fr_general`dw_comprador within w_fr_vtas_pedidos_resumen
integer taborder = 130
end type

type st_20 from w_fr_general`st_20 within w_fr_vtas_pedidos_resumen
end type

type dw_mot_ajuste from w_fr_general`dw_mot_ajuste within w_fr_vtas_pedidos_resumen
integer taborder = 140
end type

type st_121 from w_fr_general`st_121 within w_fr_vtas_pedidos_resumen
end type

type dw_clientes from w_fr_general`dw_clientes within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 402
integer y = 356
integer taborder = 50
end type

type st_30 from w_fr_general`st_30 within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 59
integer y = 360
integer width = 311
end type

type dw_clientes_cate from w_fr_general`dw_clientes_cate within w_fr_vtas_pedidos_resumen
boolean visible = true
integer x = 137
integer y = 472
integer taborder = 60
end type

type st_61 from w_fr_general`st_61 within w_fr_vtas_pedidos_resumen
end type

type dw_ciudad from w_fr_general`dw_ciudad within w_fr_vtas_pedidos_resumen
end type

type st_60 from w_fr_general`st_60 within w_fr_vtas_pedidos_resumen
end type

type dw_pais from w_fr_general`dw_pais within w_fr_vtas_pedidos_resumen
end type


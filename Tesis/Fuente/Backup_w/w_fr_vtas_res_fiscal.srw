$PBExportHeader$w_fr_vtas_res_fiscal.srw
forward
global type w_fr_vtas_res_fiscal from w_fr_general
end type
type gb_2 from groupbox within w_fr_vtas_res_fiscal
end type
end forward

global type w_fr_vtas_res_fiscal from w_fr_general
integer x = 663
integer y = 276
integer width = 1952
integer height = 1092
gb_2 gb_2
end type
global w_fr_vtas_res_fiscal w_fr_vtas_res_fiscal

on w_fr_vtas_res_fiscal.create
int iCurrent
call super::create
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
end on

on w_fr_vtas_res_fiscal.destroy
call super::destroy
destroy(this.gb_2)
end on

event open;call super::open;if gl_importadora=1 then
	vi_dw_lista.dataobject = "dw_lista_ventas_resu_fiscal_orig_new_12"
else
	vi_dw_lista.dataobject = "dw_lista_ventas_resu_fiscal_orig_new_1"
end if
vi_dw_lista.settransobject(vg_server_repl)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type pb_close from w_fr_general`pb_close within w_fr_vtas_res_fiscal
integer x = 891
integer y = 840
integer taborder = 120
end type

type pb_ok from w_fr_general`pb_ok within w_fr_vtas_res_fiscal
integer x = 498
integer y = 840
integer taborder = 110
end type

event pb_ok::clicked;call super::clicked;long cant_filas

cant_filas = vi_dw_lista.retrieve(vi_fi1,vi_ff1, vi_suc1, vi_tip_doc, vi_fi2,vi_ff2, vi_fi3,vi_ff3)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if
vi_dw_lista.Object.filtro4.Text = trim(v_fi1.text)
vi_dw_lista.Object.filtro5.Text = trim(v_ff1.text)
vi_dw_lista.Object.filtro6.Text = trim(v_fi2.text)
vi_dw_lista.Object.filtro7.Text = trim(v_ff2.text)
vi_dw_lista.Object.filtro8.Text = trim(v_fi3.text)
vi_dw_lista.Object.filtro9.Text = trim(v_ff3.text)


end event

type gb_borde from w_fr_general`gb_borde within w_fr_vtas_res_fiscal
integer x = 466
integer y = 768
end type

type st_3 from w_fr_general`st_3 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 128
end type

type v_fi1 from w_fr_general`v_fi1 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 553
end type

type st_4 from w_fr_general`st_4 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 1019
integer width = 430
end type

type v_ff1 from w_fr_general`v_ff1 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 1477
integer taborder = 20
end type

type st_5 from w_fr_general`st_5 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 96
integer y = 264
integer width = 439
string text = "Desde Fech. Alta:"
end type

type v_fi2 from w_fr_general`v_fi2 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 558
integer y = 264
integer taborder = 30
end type

type st_6 from w_fr_general`st_6 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 1001
integer y = 268
string text = "Hasta Fech. Alta:"
end type

type v_ff2 from w_fr_general`v_ff2 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 1477
integer y = 264
integer taborder = 40
end type

type st_7 from w_fr_general`st_7 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 96
integer y = 364
integer width = 466
string text = "Desde Fech. Mod.:"
end type

type v_fi3 from w_fr_general`v_fi3 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 558
integer y = 364
integer taborder = 50
end type

type st_8 from w_fr_general`st_8 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 1001
integer y = 368
string text = "Hasta Fech. Mod.:"
end type

type v_ff3 from w_fr_general`v_ff3 within w_fr_vtas_res_fiscal
boolean visible = true
integer x = 1477
integer y = 364
integer taborder = 60
end type

type st_9 from w_fr_general`st_9 within w_fr_vtas_res_fiscal
end type

type st_10 from w_fr_general`st_10 within w_fr_vtas_res_fiscal
end type

type v_ff4 from w_fr_general`v_ff4 within w_fr_vtas_res_fiscal
integer taborder = 190
end type

type v_fi4 from w_fr_general`v_fi4 within w_fr_vtas_res_fiscal
integer taborder = 180
end type

type dw_suc1 from w_fr_general`dw_suc1 within w_fr_vtas_res_fiscal
boolean visible = true
integer y = 536
integer taborder = 70
end type

type dw_busca from w_fr_general`dw_busca within w_fr_vtas_res_fiscal
integer taborder = 200
end type

type dw_suc2 from w_fr_general`dw_suc2 within w_fr_vtas_res_fiscal
integer taborder = 210
end type

type st_12 from w_fr_general`st_12 within w_fr_vtas_res_fiscal
boolean visible = true
integer y = 540
end type

type st_13 from w_fr_general`st_13 within w_fr_vtas_res_fiscal
end type

type dw_dep1 from w_fr_general`dw_dep1 within w_fr_vtas_res_fiscal
integer taborder = 230
end type

type st_14 from w_fr_general`st_14 within w_fr_vtas_res_fiscal
end type

type dw_dep2 from w_fr_general`dw_dep2 within w_fr_vtas_res_fiscal
integer taborder = 250
end type

type st_15 from w_fr_general`st_15 within w_fr_vtas_res_fiscal
end type

type pb_1 from w_fr_general`pb_1 within w_fr_vtas_res_fiscal
integer taborder = 130
end type

type dw_provee from w_fr_general`dw_provee within w_fr_vtas_res_fiscal
integer taborder = 260
end type

type st_16 from w_fr_general`st_16 within w_fr_vtas_res_fiscal
end type

type gb_1 from w_fr_general`gb_1 within w_fr_vtas_res_fiscal
integer taborder = 240
end type

type rb_1 from w_fr_general`rb_1 within w_fr_vtas_res_fiscal
end type

type rb_2 from w_fr_general`rb_2 within w_fr_vtas_res_fiscal
end type

type rb_3 from w_fr_general`rb_3 within w_fr_vtas_res_fiscal
end type

type rb_4 from w_fr_general`rb_4 within w_fr_vtas_res_fiscal
end type

type rb_5 from w_fr_general`rb_5 within w_fr_vtas_res_fiscal
end type

type st_17 from w_fr_general`st_17 within w_fr_vtas_res_fiscal
boolean visible = true
integer y = 648
end type

type dw_tip_doc from w_fr_general`dw_tip_doc within w_fr_vtas_res_fiscal
boolean visible = true
integer y = 644
integer taborder = 90
end type

type dw_comp_cond from w_fr_general`dw_comp_cond within w_fr_vtas_res_fiscal
integer taborder = 280
end type

type st_18 from w_fr_general`st_18 within w_fr_vtas_res_fiscal
end type

type st_19 from w_fr_general`st_19 within w_fr_vtas_res_fiscal
end type

type dw_plazo from w_fr_general`dw_plazo within w_fr_vtas_res_fiscal
integer taborder = 170
end type

type dw_moneda from w_fr_general`dw_moneda within w_fr_vtas_res_fiscal
integer taborder = 80
end type

type dw_comprador from w_fr_general`dw_comprador within w_fr_vtas_res_fiscal
integer taborder = 140
end type

type st_20 from w_fr_general`st_20 within w_fr_vtas_res_fiscal
end type

type dw_mot_ajuste from w_fr_general`dw_mot_ajuste within w_fr_vtas_res_fiscal
integer taborder = 150
end type

type st_121 from w_fr_general`st_121 within w_fr_vtas_res_fiscal
end type

type dw_clientes from w_fr_general`dw_clientes within w_fr_vtas_res_fiscal
integer taborder = 270
end type

type st_30 from w_fr_general`st_30 within w_fr_vtas_res_fiscal
end type

type dw_clientes_cate from w_fr_general`dw_clientes_cate within w_fr_vtas_res_fiscal
integer taborder = 160
end type

type st_61 from w_fr_general`st_61 within w_fr_vtas_res_fiscal
end type

type dw_ciudad from w_fr_general`dw_ciudad within w_fr_vtas_res_fiscal
integer taborder = 220
end type

type st_60 from w_fr_general`st_60 within w_fr_vtas_res_fiscal
end type

type dw_pais from w_fr_general`dw_pais within w_fr_vtas_res_fiscal
integer taborder = 100
end type

type gb_2 from groupbox within w_fr_vtas_res_fiscal
integer x = 64
integer y = 148
integer width = 1769
integer height = 352
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha de Registro y Modificacion en el Sistema"
end type


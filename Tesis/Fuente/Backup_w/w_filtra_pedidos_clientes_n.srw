$PBExportHeader$w_filtra_pedidos_clientes_n.srw
forward
global type w_filtra_pedidos_clientes_n from w_fr_general
end type
type sle_dep from singlelineedit within w_filtra_pedidos_clientes_n
end type
type sle_prov from singlelineedit within w_filtra_pedidos_clientes_n
end type
type st_25 from statictext within w_filtra_pedidos_clientes_n
end type
type st_26 from statictext within w_filtra_pedidos_clientes_n
end type
type st_1 from statictext within w_filtra_pedidos_clientes_n
end type
type sle_1 from singlelineedit within w_filtra_pedidos_clientes_n
end type
end forward

global type w_filtra_pedidos_clientes_n from w_fr_general
integer x = 640
integer y = 348
integer width = 1906
integer height = 672
sle_dep sle_dep
sle_prov sle_prov
st_25 st_25
st_26 st_26
st_1 st_1
sle_1 sle_1
end type
global w_filtra_pedidos_clientes_n w_filtra_pedidos_clientes_n

on w_filtra_pedidos_clientes_n.create
int iCurrent
call super::create
this.sle_dep=create sle_dep
this.sle_prov=create sle_prov
this.st_25=create st_25
this.st_26=create st_26
this.st_1=create st_1
this.sle_1=create sle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_dep
this.Control[iCurrent+2]=this.sle_prov
this.Control[iCurrent+3]=this.st_25
this.Control[iCurrent+4]=this.st_26
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.sle_1
end on

on w_filtra_pedidos_clientes_n.destroy
call super::destroy
destroy(this.sle_dep)
destroy(this.sle_prov)
destroy(this.st_25)
destroy(this.st_26)
destroy(this.st_1)
destroy(this.sle_1)
end on

type pb_close from w_fr_general`pb_close within w_filtra_pedidos_clientes_n
integer x = 937
integer y = 412
integer taborder = 130
end type

type pb_ok from w_fr_general`pb_ok within w_filtra_pedidos_clientes_n
integer x = 549
integer y = 412
integer taborder = 120
end type

event pb_ok::clicked;vi_dw_lista.settransobject(sqlca)
long filas, ll_ped
long cant_filas, ll_cli
Date ld_fini, ld_ffin

ll_cli  =  dw_suc1.Getitemnumber(1,1)
if isnull(ll_cli) then ll_cli=0

ld_fini = Date(v_fi2.text)
If isnull(v_fi2.text) or v_fi2.text = "" then setnull(ld_fini)

ld_ffin= Date(v_ff2.text)
If isnull(v_ff2.text) or v_ff2.text = "" then setnull(ld_ffin)


cant_filas = vi_dw_lista.retrieve(ll_cli,ld_fini,ld_ffin)
if cant_filas=0 then		
	messageBox("Aviso...","No existen datos para el rango definido...")
else
	vi_dw_lista.Object.filtro3.Text = trim(v_fi2.text)
	vi_dw_lista.Object.filtro4.Text = trim(v_ff2.text)
	
	if ll_cli <> 0 then
		vi_dw_lista.Object.filtro1.Text = filtro_clientes(ll_cli)
	ELSE
		vi_dw_lista.Object.filtro1.Text = "Todos "
	END IF
end if


end event

type gb_borde from w_fr_general`gb_borde within w_filtra_pedidos_clientes_n
integer x = 512
integer y = 340
end type

type st_3 from w_fr_general`st_3 within w_filtra_pedidos_clientes_n
end type

type v_fi1 from w_fr_general`v_fi1 within w_filtra_pedidos_clientes_n
integer taborder = 180
end type

type st_4 from w_fr_general`st_4 within w_filtra_pedidos_clientes_n
integer x = 37
integer y = 48
integer width = 361
string text = "Hasta fecha:"
end type

type v_ff1 from w_fr_general`v_ff1 within w_filtra_pedidos_clientes_n
integer x = 448
integer y = 44
integer taborder = 150
end type

type st_5 from w_fr_general`st_5 within w_filtra_pedidos_clientes_n
boolean visible = true
integer x = 206
integer y = 84
integer width = 210
integer textsize = -9
end type

type v_fi2 from w_fr_general`v_fi2 within w_filtra_pedidos_clientes_n
boolean visible = true
integer y = 84
integer taborder = 10
end type

type st_6 from w_fr_general`st_6 within w_filtra_pedidos_clientes_n
boolean visible = true
integer x = 960
integer y = 84
integer width = 201
integer textsize = -9
end type

type v_ff2 from w_fr_general`v_ff2 within w_filtra_pedidos_clientes_n
boolean visible = true
integer x = 1166
integer y = 84
integer taborder = 20
end type

type st_7 from w_fr_general`st_7 within w_filtra_pedidos_clientes_n
end type

type v_fi3 from w_fr_general`v_fi3 within w_filtra_pedidos_clientes_n
integer taborder = 230
end type

type st_8 from w_fr_general`st_8 within w_filtra_pedidos_clientes_n
end type

type v_ff3 from w_fr_general`v_ff3 within w_filtra_pedidos_clientes_n
integer taborder = 240
end type

type st_9 from w_fr_general`st_9 within w_filtra_pedidos_clientes_n
end type

type st_10 from w_fr_general`st_10 within w_filtra_pedidos_clientes_n
end type

type v_ff4 from w_fr_general`v_ff4 within w_filtra_pedidos_clientes_n
integer taborder = 270
end type

type v_fi4 from w_fr_general`v_fi4 within w_filtra_pedidos_clientes_n
integer taborder = 260
end type

type dw_suc1 from w_fr_general`dw_suc1 within w_filtra_pedidos_clientes_n
boolean visible = true
integer x = 361
integer y = 196
integer taborder = 30
string dataobject = "dw_arg_cliente"
end type

type dw_busca from w_fr_general`dw_busca within w_filtra_pedidos_clientes_n
integer taborder = 280
end type

type dw_suc2 from w_fr_general`dw_suc2 within w_filtra_pedidos_clientes_n
integer taborder = 290
end type

type st_12 from w_fr_general`st_12 within w_filtra_pedidos_clientes_n
boolean visible = true
integer x = 101
integer y = 212
integer width = 219
integer textsize = -9
string text = "Cliente:"
end type

type st_13 from w_fr_general`st_13 within w_filtra_pedidos_clientes_n
end type

type dw_dep1 from w_fr_general`dw_dep1 within w_filtra_pedidos_clientes_n
integer y = 164
integer taborder = 40
end type

type st_14 from w_fr_general`st_14 within w_filtra_pedidos_clientes_n
integer y = 176
end type

type dw_dep2 from w_fr_general`dw_dep2 within w_filtra_pedidos_clientes_n
integer taborder = 310
end type

type st_15 from w_fr_general`st_15 within w_filtra_pedidos_clientes_n
end type

type pb_1 from w_fr_general`pb_1 within w_filtra_pedidos_clientes_n
integer x = 713
integer y = 784
integer taborder = 110
end type

type dw_provee from w_fr_general`dw_provee within w_filtra_pedidos_clientes_n
integer y = 276
integer taborder = 60
end type

type st_16 from w_fr_general`st_16 within w_filtra_pedidos_clientes_n
integer y = 280
end type

type gb_1 from w_fr_general`gb_1 within w_filtra_pedidos_clientes_n
integer taborder = 300
end type

type rb_1 from w_fr_general`rb_1 within w_filtra_pedidos_clientes_n
integer x = 1289
integer y = 500
integer width = 347
integer taborder = 80
string text = "Pendientes"
end type

type rb_2 from w_fr_general`rb_2 within w_filtra_pedidos_clientes_n
integer x = 347
integer y = 504
integer width = 494
integer taborder = 70
string text = "Sin Entrega Camion"
boolean checked = true
end type

type rb_3 from w_fr_general`rb_3 within w_filtra_pedidos_clientes_n
end type

type rb_4 from w_fr_general`rb_4 within w_filtra_pedidos_clientes_n
end type

type rb_5 from w_fr_general`rb_5 within w_filtra_pedidos_clientes_n
end type

type st_17 from w_fr_general`st_17 within w_filtra_pedidos_clientes_n
end type

type dw_tip_doc from w_fr_general`dw_tip_doc within w_filtra_pedidos_clientes_n
integer x = 453
integer y = 172
integer taborder = 330
end type

type dw_comp_cond from w_fr_general`dw_comp_cond within w_filtra_pedidos_clientes_n
integer taborder = 340
end type

type st_18 from w_fr_general`st_18 within w_filtra_pedidos_clientes_n
end type

type st_19 from w_fr_general`st_19 within w_filtra_pedidos_clientes_n
end type

type dw_plazo from w_fr_general`dw_plazo within w_filtra_pedidos_clientes_n
integer taborder = 220
end type

type dw_moneda from w_fr_general`dw_moneda within w_filtra_pedidos_clientes_n
integer taborder = 190
end type

type dw_comprador from w_fr_general`dw_comprador within w_filtra_pedidos_clientes_n
integer taborder = 200
end type

type st_20 from w_fr_general`st_20 within w_filtra_pedidos_clientes_n
end type

type dw_mot_ajuste from w_fr_general`dw_mot_ajuste within w_filtra_pedidos_clientes_n
integer taborder = 210
end type

type st_121 from w_fr_general`st_121 within w_filtra_pedidos_clientes_n
end type

type dw_clientes from w_fr_general`dw_clientes within w_filtra_pedidos_clientes_n
integer taborder = 320
end type

type st_30 from w_fr_general`st_30 within w_filtra_pedidos_clientes_n
end type

type dw_clientes_cate from w_fr_general`dw_clientes_cate within w_filtra_pedidos_clientes_n
integer x = 101
integer y = 276
integer taborder = 170
string dataobject = "dw_param_vendedor"
end type

type st_61 from w_fr_general`st_61 within w_filtra_pedidos_clientes_n
end type

type dw_ciudad from w_fr_general`dw_ciudad within w_filtra_pedidos_clientes_n
integer taborder = 250
end type

type st_60 from w_fr_general`st_60 within w_filtra_pedidos_clientes_n
end type

type dw_pais from w_fr_general`dw_pais within w_filtra_pedidos_clientes_n
integer taborder = 160
end type

type sle_dep from singlelineedit within w_filtra_pedidos_clientes_n
boolean visible = false
integer x = 439
integer y = 384
integer width = 919
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_prov from singlelineedit within w_filtra_pedidos_clientes_n
boolean visible = false
integer x = 439
integer y = 488
integer width = 1449
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_25 from statictext within w_filtra_pedidos_clientes_n
boolean visible = false
integer x = 37
integer y = 392
integer width = 398
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Incl. Depósitos:"
boolean focusrectangle = false
end type

type st_26 from statictext within w_filtra_pedidos_clientes_n
boolean visible = false
integer x = 37
integer y = 496
integer width = 389
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Incl. Proveed.:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_filtra_pedidos_clientes_n
boolean visible = false
integer x = 101
integer y = 328
integer width = 288
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Nro. Ped.:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_filtra_pedidos_clientes_n
boolean visible = false
integer x = 366
integer y = 324
integer width = 402
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type


$PBExportHeader$w_fr_vtas_sol_anulacion.srw
forward
global type w_fr_vtas_sol_anulacion from w_fr_general
end type
type sle_1 from singlelineedit within w_fr_vtas_sol_anulacion
end type
type st_1 from statictext within w_fr_vtas_sol_anulacion
end type
type ddlb_1 from dropdownlistbox within w_fr_vtas_sol_anulacion
end type
end forward

global type w_fr_vtas_sol_anulacion from w_fr_general
integer x = 750
integer y = 400
integer width = 1938
integer height = 828
sle_1 sle_1
st_1 st_1
ddlb_1 ddlb_1
end type
global w_fr_vtas_sol_anulacion w_fr_vtas_sol_anulacion

on w_fr_vtas_sol_anulacion.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_1
end on

on w_fr_vtas_sol_anulacion.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.ddlb_1)
end on

type pb_close from w_fr_general`pb_close within w_fr_vtas_sol_anulacion
integer x = 928
integer y = 568
integer taborder = 60
end type

type pb_ok from w_fr_general`pb_ok within w_fr_vtas_sol_anulacion
integer x = 535
integer y = 568
integer taborder = 50
end type

event pb_ok::clicked;call super::clicked;long cant_filas, ll_nro_factura, ll_estado
vg_numeracion_fac = 0
ll_nro_factura = long(sle_1.text)

if ddlb_1.text = 'No Autorizados' then ll_estado = 0
if ddlb_1.text = 'Autorizados' then 
	ll_estado = 1
	vg_numeracion_fac = 2
end if
if ddlb_1.text = ''  or ddlb_1.text = 'Todos' then 
	ll_estado = 2
	vg_numeracion_fac = 2
end if
if sle_1.text = '' then ll_nro_factura = 0

cant_filas = vi_dw_lista.retrieve(vi_tip_doc,ll_nro_factura,ll_estado,vi_fi1,vi_ff1)
if cant_filas = 0 then messageBox("Aviso...","No existen datos para el rango definido...")

end event

type gb_borde from w_fr_general`gb_borde within w_fr_vtas_sol_anulacion
integer x = 503
integer y = 496
end type

type st_3 from w_fr_general`st_3 within w_fr_vtas_sol_anulacion
boolean visible = true
integer width = 206
end type

type v_fi1 from w_fr_general`v_fi1 within w_fr_vtas_sol_anulacion
boolean visible = true
integer x = 242
end type

type st_4 from w_fr_general`st_4 within w_fr_vtas_sol_anulacion
boolean visible = true
integer x = 654
integer width = 174
end type

type v_ff1 from w_fr_general`v_ff1 within w_fr_vtas_sol_anulacion
boolean visible = true
integer x = 827
integer taborder = 20
end type

type st_5 from w_fr_general`st_5 within w_fr_vtas_sol_anulacion
end type

type v_fi2 from w_fr_general`v_fi2 within w_fr_vtas_sol_anulacion
integer taborder = 120
end type

type st_6 from w_fr_general`st_6 within w_fr_vtas_sol_anulacion
end type

type v_ff2 from w_fr_general`v_ff2 within w_fr_vtas_sol_anulacion
integer taborder = 150
end type

type st_7 from w_fr_general`st_7 within w_fr_vtas_sol_anulacion
end type

type v_fi3 from w_fr_general`v_fi3 within w_fr_vtas_sol_anulacion
integer taborder = 160
end type

type st_8 from w_fr_general`st_8 within w_fr_vtas_sol_anulacion
end type

type v_ff3 from w_fr_general`v_ff3 within w_fr_vtas_sol_anulacion
integer taborder = 170
end type

type st_9 from w_fr_general`st_9 within w_fr_vtas_sol_anulacion
end type

type st_10 from w_fr_general`st_10 within w_fr_vtas_sol_anulacion
end type

type v_ff4 from w_fr_general`v_ff4 within w_fr_vtas_sol_anulacion
integer taborder = 190
end type

type v_fi4 from w_fr_general`v_fi4 within w_fr_vtas_sol_anulacion
integer taborder = 180
end type

type dw_suc1 from w_fr_general`dw_suc1 within w_fr_vtas_sol_anulacion
integer y = 136
integer taborder = 30
end type

type dw_busca from w_fr_general`dw_busca within w_fr_vtas_sol_anulacion
integer taborder = 200
end type

type dw_suc2 from w_fr_general`dw_suc2 within w_fr_vtas_sol_anulacion
integer taborder = 210
end type

type st_12 from w_fr_general`st_12 within w_fr_vtas_sol_anulacion
boolean visible = true
integer y = 280
string text = "Nro Factura:"
end type

type st_13 from w_fr_general`st_13 within w_fr_vtas_sol_anulacion
end type

type dw_dep1 from w_fr_general`dw_dep1 within w_fr_vtas_sol_anulacion
integer taborder = 230
end type

type st_14 from w_fr_general`st_14 within w_fr_vtas_sol_anulacion
end type

type dw_dep2 from w_fr_general`dw_dep2 within w_fr_vtas_sol_anulacion
integer taborder = 250
end type

type st_15 from w_fr_general`st_15 within w_fr_vtas_sol_anulacion
end type

type pb_1 from w_fr_general`pb_1 within w_fr_vtas_sol_anulacion
integer taborder = 90
end type

type dw_provee from w_fr_general`dw_provee within w_fr_vtas_sol_anulacion
integer taborder = 260
end type

type st_16 from w_fr_general`st_16 within w_fr_vtas_sol_anulacion
end type

type gb_1 from w_fr_general`gb_1 within w_fr_vtas_sol_anulacion
integer taborder = 240
end type

type rb_1 from w_fr_general`rb_1 within w_fr_vtas_sol_anulacion
end type

type rb_2 from w_fr_general`rb_2 within w_fr_vtas_sol_anulacion
end type

type rb_3 from w_fr_general`rb_3 within w_fr_vtas_sol_anulacion
end type

type rb_4 from w_fr_general`rb_4 within w_fr_vtas_sol_anulacion
end type

type rb_5 from w_fr_general`rb_5 within w_fr_vtas_sol_anulacion
end type

type st_17 from w_fr_general`st_17 within w_fr_vtas_sol_anulacion
boolean visible = true
integer x = 32
integer y = 160
end type

type dw_tip_doc from w_fr_general`dw_tip_doc within w_fr_vtas_sol_anulacion
boolean visible = true
integer x = 434
integer y = 156
integer taborder = 40
end type

type dw_comp_cond from w_fr_general`dw_comp_cond within w_fr_vtas_sol_anulacion
integer taborder = 280
end type

type st_18 from w_fr_general`st_18 within w_fr_vtas_sol_anulacion
end type

type st_19 from w_fr_general`st_19 within w_fr_vtas_sol_anulacion
end type

type dw_plazo from w_fr_general`dw_plazo within w_fr_vtas_sol_anulacion
integer taborder = 140
end type

type dw_moneda from w_fr_general`dw_moneda within w_fr_vtas_sol_anulacion
integer taborder = 70
end type

type dw_comprador from w_fr_general`dw_comprador within w_fr_vtas_sol_anulacion
integer taborder = 100
end type

type st_20 from w_fr_general`st_20 within w_fr_vtas_sol_anulacion
end type

type dw_mot_ajuste from w_fr_general`dw_mot_ajuste within w_fr_vtas_sol_anulacion
integer taborder = 110
end type

type st_121 from w_fr_general`st_121 within w_fr_vtas_sol_anulacion
end type

type dw_clientes from w_fr_general`dw_clientes within w_fr_vtas_sol_anulacion
integer taborder = 270
end type

type st_30 from w_fr_general`st_30 within w_fr_vtas_sol_anulacion
end type

type dw_clientes_cate from w_fr_general`dw_clientes_cate within w_fr_vtas_sol_anulacion
integer taborder = 130
end type

type st_61 from w_fr_general`st_61 within w_fr_vtas_sol_anulacion
end type

type dw_ciudad from w_fr_general`dw_ciudad within w_fr_vtas_sol_anulacion
integer taborder = 220
end type

type st_60 from w_fr_general`st_60 within w_fr_vtas_sol_anulacion
end type

type dw_pais from w_fr_general`dw_pais within w_fr_vtas_sol_anulacion
integer taborder = 80
end type

type sle_1 from singlelineedit within w_fr_vtas_sol_anulacion
integer x = 439
integer y = 276
integer width = 338
integer height = 80
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_fr_vtas_sol_anulacion
integer x = 37
integer y = 392
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
string text = "Estado:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_fr_vtas_sol_anulacion
integer x = 439
integer y = 384
integer width = 530
integer height = 352
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Autorizados","No Autorizados","Todos"}
borderstyle borderstyle = stylelowered!
end type


$PBExportHeader$w_abm_pedido_reparto.srw
forward
global type w_abm_pedido_reparto from w_abm_cabecera_detalle_ancestor
end type
type cb_buscar_repartidor from commandbutton within w_abm_pedido_reparto
end type
type cb_1 from commandbutton within w_abm_pedido_reparto
end type
end forward

global type w_abm_pedido_reparto from w_abm_cabecera_detalle_ancestor
integer width = 3456
integer height = 1948
string title = "PEDIDOS PARA REPARTO"
string menuname = ""
cb_buscar_repartidor cb_buscar_repartidor
cb_1 cb_1
end type
global w_abm_pedido_reparto w_abm_pedido_reparto

forward prototypes
public function integer fn_generar_id ()
public function integer fn_validar_campos ()
end prototypes

public function integer fn_generar_id ();long ll_max
select isnull(max(nro_pedido),0)+ 1 into:ll_max
from Pedido_reparto;
cdw_datos.setitem( 1, 'nro_pedido', ll_max)

return 0

end function

public function integer fn_validar_campos ();long ll_fila,ll_fila_detalle
ll_fila=cdw_datos.getrow( )
ll_fila_detalle=cdw_datos_detalle.getrow()
long ll_cod_repartidor
ll_cod_repartidor=cdw_datos.getitemnumber( ll_fila,'cod_persona')
if   isnull(ll_cod_repartidor) or trim(string(ll_cod_repartidor))=''  then
	messagebox("SOFTPAN", "FALTA EL REPARTIDOR")
	cdw_datos.setfocus( )
	cdw_datos.setcolumn('cod_persona')
   RETURN(-1)
end if
date ldt_fecha_pedido
ldt_fecha_pedido=cdw_datos.getitemdate ( ll_fila,'fecha_pedido')
if   isnull(ldt_fecha_pedido) or trim(string(ldt_fecha_pedido))='' then
   
	messagebox("SOFTPAN", upper("Falta la Fecha del Pedido"))
	cdw_datos.setfocus( )
	cdw_datos.setcolumn('fecha_pedido')
   RETURN(-1)
end if
date ldt_fecha_entrega
ldt_fecha_entrega=cdw_datos.getitemdate ( ll_fila,'fecha_entrega')
if   isnull(ldt_fecha_entrega) or trim(string(ldt_fecha_entrega))='' then
   
	messagebox("SOFTPAN", upper("Falta la Fecha del Entrega"))
	cdw_datos.setfocus( )
	cdw_datos.setcolumn('fecha_entrega')
   RETURN(-1)
end if
 if ldt_fecha_pedido>ldt_fecha_entrega then
	messagebox("SOFTPAN", "Fecha del Entrega debe ser mayor o igual a la del pedido")
	cdw_datos.setfocus( )
	cdw_datos.setcolumn('fecha_entrega')
   RETURN(-1)
end if
long ll_cod_producto
ll_cod_producto=cdw_datos_detalle.getitemnumber( ll_fila_detalle,'cod_producto')
if   isnull(ll_cod_producto) or trim(string(ll_cod_producto))=''  then
	messagebox("SOFTPAN", upper("Falta el Producto"))
	cdw_datos_detalle.setfocus( )
	cdw_datos_detalle.setcolumn('cod_producto')
   RETURN(-1)
end if

decimal ld_cantidad
ld_cantidad=cdw_datos_detalle.getitemdecimal( ll_fila_detalle,'cantidad')
if   isnull(ld_cantidad) or trim(string(ld_cantidad))=''  then
	messagebox("SOFTPAN", upper("Falta cantidad"))
	cdw_datos_detalle.setfocus( )
	cdw_datos_detalle.setcolumn('cantidad')
   RETURN(-1)
end if
decimal ld_precio
ld_precio=cdw_datos_detalle.getitemdecimal( ll_fila_detalle,'precio')
if   isnull(ld_precio) or trim(string(ld_precio))=''  then
	messagebox("SOFTPAN", "Falta el precio del producto")
	cdw_datos_detalle.setfocus( )
	cdw_datos_detalle.setcolumn('precio')
   RETURN(-1)
end if
return 0
end function

on w_abm_pedido_reparto.create
int iCurrent
call super::create
this.cb_buscar_repartidor=create cb_buscar_repartidor
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_buscar_repartidor
this.Control[iCurrent+2]=this.cb_1
end on

on w_abm_pedido_reparto.destroy
call super::destroy
destroy(this.cb_buscar_repartidor)
destroy(this.cb_1)
end on

event ue_insertar;call super::ue_insertar;btn_agregar_detalle.enabled=true
cb_busca.enabled=true
cdw_datos.setitem( 1, 'estado', 1)
cdw_datos.setitem( 1, 'fecha_pedido', today())
cdw_datos.setitem( 1, 'cod_usuario', g_cod_usuario)
cdw_datos.setitem( 1, 'cod_usuario_1', g_cod_usuario)
end event

type btn_eliminar from w_abm_cabecera_detalle_ancestor`btn_eliminar within w_abm_pedido_reparto
end type

type cb_busca from w_abm_cabecera_detalle_ancestor`cb_busca within w_abm_pedido_reparto
integer width = 626
string text = "&BUSCAR PRODUCTOS"
end type

event cb_busca::clicked;call super::clicked;long ll_cant
select isnull(min(cod_producto),0) into :ll_cant
from Productos;

if ll_cant=0 then 
	messagebox('Aviso','No existen productos definidos~rPrimero debera definir dicho dato',information!)
	open(w_abm_productos,parent)
	parent.triggerevent( 'ue_insertar_valor_detalle')
	return
end if	
open(w_busqueda_avanzada_producto,parent)
if v_criterio =0 then return -1
decimal ld_precio	
	select isnull(precio_venta,0) into :ld_precio
	from Productos
	where cod_producto=:v_criterio;
	
	cdw_datos_detalle.setitem(cdw_datos_detalle.getrow(),'cod_producto', v_criterio)
	cdw_datos_detalle.setitem(cdw_datos_detalle.getrow(),'precio', ld_precio)
	cdw_datos_detalle.setcolumn( 'cantidad')
	cdw_datos_detalle.setfocus( )
end event

type pb_ultimo from w_abm_cabecera_detalle_ancestor`pb_ultimo within w_abm_pedido_reparto
integer x = 2930
integer y = 1472
end type

type pb_siguiente from w_abm_cabecera_detalle_ancestor`pb_siguiente within w_abm_pedido_reparto
integer x = 2743
integer y = 1472
end type

type pb_anterior from w_abm_cabecera_detalle_ancestor`pb_anterior within w_abm_pedido_reparto
integer x = 2555
integer y = 1472
end type

type btn_uttimo from w_abm_cabecera_detalle_ancestor`btn_uttimo within w_abm_pedido_reparto
integer x = 2373
integer y = 1472
end type

type ole_skin from w_abm_cabecera_detalle_ancestor`ole_skin within w_abm_pedido_reparto
end type

type btn_buscar from w_abm_cabecera_detalle_ancestor`btn_buscar within w_abm_pedido_reparto
end type

type btn_cancelar from w_abm_cabecera_detalle_ancestor`btn_cancelar within w_abm_pedido_reparto
end type

type btn_modificar from w_abm_cabecera_detalle_ancestor`btn_modificar within w_abm_pedido_reparto
end type

type btn_guardar from w_abm_cabecera_detalle_ancestor`btn_guardar within w_abm_pedido_reparto
end type

type btn_agregar from w_abm_cabecera_detalle_ancestor`btn_agregar within w_abm_pedido_reparto
end type

type st_9 from w_abm_cabecera_detalle_ancestor`st_9 within w_abm_pedido_reparto
boolean visible = false
boolean enabled = false
end type

type st_8 from w_abm_cabecera_detalle_ancestor`st_8 within w_abm_pedido_reparto
boolean visible = false
boolean enabled = false
end type

type st_7 from w_abm_cabecera_detalle_ancestor`st_7 within w_abm_pedido_reparto
boolean visible = false
boolean enabled = false
end type

type st_6 from w_abm_cabecera_detalle_ancestor`st_6 within w_abm_pedido_reparto
boolean visible = false
boolean enabled = false
end type

type st_5 from w_abm_cabecera_detalle_ancestor`st_5 within w_abm_pedido_reparto
boolean visible = false
boolean enabled = false
end type

type st_4 from w_abm_cabecera_detalle_ancestor`st_4 within w_abm_pedido_reparto
boolean visible = false
boolean enabled = false
end type

type btn_imprimir from w_abm_cabecera_detalle_ancestor`btn_imprimir within w_abm_pedido_reparto
end type

type btn_quitar_detalle from w_abm_cabecera_detalle_ancestor`btn_quitar_detalle within w_abm_pedido_reparto
integer x = 2395
end type

type btn_agregar_detalle from w_abm_cabecera_detalle_ancestor`btn_agregar_detalle within w_abm_pedido_reparto
integer x = 2395
integer width = 475
end type

type st_1 from w_abm_cabecera_detalle_ancestor`st_1 within w_abm_pedido_reparto
end type

type btn_salir from w_abm_cabecera_detalle_ancestor`btn_salir within w_abm_pedido_reparto
end type

type cdw_datos_detalle from w_abm_cabecera_detalle_ancestor`cdw_datos_detalle within w_abm_pedido_reparto
integer width = 2103
string title = "PEDIDO DE REPARTO"
string dataobject = "dw_abm_det_pedido_reparto"
end type

event cdw_datos_detalle::getfocus;call super::getfocus;this.getchild("cod_producto" ,dwc_recupera)
dwc_recupera.settransobject(sqlca)
dwc_recupera.retrieve( )
end event

event cdw_datos_detalle::ue_despues;call super::ue_despues;decimal ld_precio

if is_colname='cod_producto' then
	long ll_cod_producto
	ll_cod_producto=this.getitemnumber( ii_row, 'cod_producto')
	select precio_venta into :ld_precio
	from Productos
	where cod_producto=:ll_cod_producto;
	this.setitem(this.getrow(),'precio', ld_precio)
	this.setcolumn( 'cantidad')
	this.setfocus( )
end if
if is_colname='cantidad' then
	long ll_cantidad
	ll_cod_producto=this.getitemnumber( ii_row, 'cantidad')
	if isnull(ll_cod_producto) or ll_cod_producto=0 then
		messagebox('AVISO','Cantidad no puede ser nulo')
		this.setcolumn( is_colname)
		this.setfocus( )
	end if
	if ll_cod_producto<0 then
		messagebox('AVISO','Cantidad no puede ser negativo')
		this.setcolumn( is_colname)
		this.setfocus( )
	end if
end if
cdw_datos.setitem( cdw_datos.getrow(), 'efectivo_ingresado', this.getitemdecimal( this.getrow() , 'total') )
end event

type cdw_datos from w_abm_cabecera_detalle_ancestor`cdw_datos within w_abm_pedido_reparto
integer width = 3086
integer height = 636
string dataobject = "dw_abm_cab_pedido_reparto"
end type

event cdw_datos::itemchanged;call super::itemchanged;datawindowchild dwc_recupera_cliente

this.getchild('cod_persona',dwc_recupera_cliente)
dwc_recupera_cliente.settransobject(sqlca)
dwc_recupera_cliente.retrieve( )

datawindowchild dwc_recupera_cliente_1
this.getchild('cod_persona_1',dwc_recupera_cliente_1)
dwc_recupera_cliente_1.settransobject(sqlca)
dwc_recupera_cliente_1.retrieve( )
end event

event cdw_datos::ue_despues;call super::ue_despues;choose case is_colname
	case 'fecha_entrega'
		date ld_fecha_pedido,ld_fecha_entrega
		ld_fecha_pedido=this.getitemdate( ii_row, 'fecha_pedido')
		ld_fecha_entrega=this.getitemdate( ii_row, 'fecha_entrega')
	   	setnull(g_date_null)
			
		if isnull(ld_fecha_entrega) then
			messagebox("SOFTPAN","Fecha de entrega no debe ser nulo")
			this.setitem( ii_row,'fecha_entrega', g_date_null)
			this.setcolumn('fecha_entrega')
			this.setfocus( )
			return -1
		end if
		if ld_fecha_entrega<ld_fecha_pedido then
			messagebox("SOFTPAN","Fecha de entrega debe ser mayor o igual a la del Pedido")
			this.setitem( ii_row,'fecha_entrega', g_date_null)
			this.setcolumn('fecha_entrega')
			this.setfocus( )
			return -1
		end if
		
		
end choose 
return 0
end event

event cdw_datos::updatestart;call super::updatestart;if this.rowcount( )=0 then return
long l,ll_nro_pedido
ll_nro_pedido=this.getitemnumber( this.getrow(), 'nro_pedido')
For l =1 To Cdw_Datos_Detalle.RowCount( )
	cdw_datos_detalle.object.nro_detalle[l] = l
	cdw_datos_detalle.object.nro_pedido[l] = ll_nro_pedido
Next


end event

event cdw_datos::getfocus;call super::getfocus;datawindowchild dwc_recupera_repartidor

this.getchild('cod_persona',dwc_recupera_repartidor)
dwc_recupera_repartidor.settransobject(sqlca)
dwc_recupera_repartidor.retrieve( )

end event

type st_2 from w_abm_cabecera_detalle_ancestor`st_2 within w_abm_pedido_reparto
end type

type st_3 from w_abm_cabecera_detalle_ancestor`st_3 within w_abm_pedido_reparto
integer x = 2327
integer y = 1440
end type

type cb_buscar_repartidor from commandbutton within w_abm_pedido_reparto
integer x = 2080
integer y = 548
integer width = 626
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "BUSCAR REPARTIDOR"
end type

event clicked;long ll_cant
select isnull(min(cod_persona),0) into :ll_cant
from Personas
where tipo_persona=3;

if ll_cant=0 then 
	messagebox('Aviso','No existen Repartidores definidos~rPrimero debera definir dicho dato',information!)
	open(w_abm_personas,parent)
	
	return
end if	
ll_flag=4
open(w_busqueda_avanzada_personas)

if v_criterio =0 then return -1
cdw_datos.setitem( cdw_datos.getrow(), 'cod_persona', v_criterio)
end event

type cb_1 from commandbutton within w_abm_pedido_reparto
integer x = 2720
integer y = 548
integer width = 201
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_personas,parent)

cdw_datos.getchild('cod_persona',dwc_recupera)
dwc_recupera.settransobject(sqlca)
dwc_recupera.retrieve( )
end event


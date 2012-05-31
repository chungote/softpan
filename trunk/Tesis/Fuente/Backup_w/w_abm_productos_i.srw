$PBExportHeader$w_abm_productos_i.srw
forward
global type w_abm_productos_i from w_abm_ancestor
end type
type tab_1 from tab within w_abm_productos_i
end type
type tabpage_infor_gral from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_infor_gral
end type
type cb_7 from commandbutton within tabpage_infor_gral
end type
type cb_6 from commandbutton within tabpage_infor_gral
end type
type cb_5 from commandbutton within tabpage_infor_gral
end type
type cb_4 from commandbutton within tabpage_infor_gral
end type
type cb_3 from commandbutton within tabpage_infor_gral
end type
type cb_2 from commandbutton within tabpage_infor_gral
end type
type cdw_datos_01 from datawindow within tabpage_infor_gral
end type
type tabpage_infor_gral from userobject within tab_1
cb_1 cb_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cdw_datos_01 cdw_datos_01
end type
type tabpage_recetas_productos from userobject within tab_1
end type
type cb_8 from commandbutton within tabpage_recetas_productos
end type
type cb_quitar_detalle from commandbutton within tabpage_recetas_productos
end type
type cb_agregar_detalle from commandbutton within tabpage_recetas_productos
end type
type cdw_datos_detalle_02 from datawindow within tabpage_recetas_productos
end type
type cdw_datos_02 from datawindow within tabpage_recetas_productos
end type
type tabpage_recetas_productos from userobject within tab_1
cb_8 cb_8
cb_quitar_detalle cb_quitar_detalle
cb_agregar_detalle cb_agregar_detalle
cdw_datos_detalle_02 cdw_datos_detalle_02
cdw_datos_02 cdw_datos_02
end type
type tab_1 from tab within w_abm_productos_i
tabpage_infor_gral tabpage_infor_gral
tabpage_recetas_productos tabpage_recetas_productos
end type
end forward

global type w_abm_productos_i from w_abm_ancestor
integer width = 3511
integer height = 2180
string title = "MANTENIMIENTO DE PRODUCTOS"
tab_1 tab_1
end type
global w_abm_productos_i w_abm_productos_i

type variables
long ii_max_filas_detalle,ii_prim_fila_detalle
long ii_prim_fila_cab,ii_ult_item_detalle
boolean ib_focus = false,ib_status=false
long ii_borrado
end variables

forward prototypes
public subroutine fn_generar_id ()
public function integer fn_validar_campos_productos (datawindow dw)
public function integer fn_validar_campos_recetas (datawindow dw)
public function integer fn_insertar_datos (datawindow dw)
end prototypes

public subroutine fn_generar_id ();long ll_max_id

select isnull(max(cod_producto),0)+1 into :ll_max_id
from Productos;

this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( this.tab_1.tabpage_infor_gral.cdw_datos_01.getrow(), 'cod_producto', ll_max_id)
this.tab_1.tabpage_recetas_productos.cdw_datos_02.setitem( this.tab_1.tabpage_recetas_productos.cdw_datos_02.getrow(), 'cod_producto', ll_max_id)
end subroutine

public function integer fn_validar_campos_productos (datawindow dw);long ll_fila
ll_fila=dw.getrow( )
long ll_cod_producto
tab_1.SelectTab(1)
ll_cod_producto=dw.getitemnumber( ll_fila,'cod_producto')
if   isnull(ll_cod_producto)  then
	messagebox("SOFTPAN", "Falta el campo codigo de producto")
	
	dw.setfocus( )
	dw.setcolumn('cod_producto')
   RETURN(-1)
end if
string ls_descripcion_producto
ls_descripcion_producto=dw.getitemstring( ll_fila,'descripcion')
if   isnull(ls_descripcion_producto) or trim(ls_descripcion_producto)='' then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo descripcion de producto")
	
	dw.setfocus( )
	dw.setcolumn('descripcion')
   RETURN(-1)
end if

long ll_cod_tipo_producto
ll_cod_tipo_producto=dw.getitemnumber( ll_fila,'cod_tipo_producto')
if   isnull(ll_cod_tipo_producto) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar la categoria del producto")
	dw.setfocus( )
	dw.setcolumn('cod_tipo_producto')
   RETURN(-1)
end if

long ll_grupo
ll_grupo=dw.getitemnumber( ll_fila,'cod_grupo')
if   isnull(ll_grupo) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el grupo producto")
	dw.setfocus( )
	dw.setcolumn('cod_grupo')
   RETURN(-1)
end if
long ll_procedencia
ll_procedencia=dw.getitemnumber( ll_fila, 'cod_procedencia')
if   isnull(ll_procedencia) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo procedencia")
	dw.setfocus( )
	dw.setcolumn('cod_procedencia')
   RETURN(-1)
end if

decimal ll_tipo_iva
ll_tipo_iva=dw.getitemdecimal( ll_fila, 'cod_tipo_iva')
if   isnull(ll_tipo_iva) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo tipo de iva")
	dw.setfocus( )
	dw.setcolumn('cod_tipo_iva')
   RETURN(-1)
end if

long ll_cod_estante
ll_cod_estante=dw.getitemnumber( ll_fila, 'cod_estante')
if   isnull(ll_cod_estante) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo estante")
	dw.setfocus( )
	dw.setcolumn('cod_estante')
   RETURN(-1)
end if
long ll_cod_medida
ll_cod_medida=dw.getitemnumber(ll_fila,'cod_medida')
if   isnull(ll_cod_medida) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Medida")
	dw.setfocus( )
	dw.setcolumn(9)
   RETURN(-1)
end if

decimal ld_porc_desc
ld_porc_desc=dw.getitemdecimal( ll_fila, 'porc_descuento')
if   isnull(ld_porc_desc) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo porcentage de descuento")
	dw.setfocus( )
	dw.setcolumn( 'porc_descuento')
   RETURN(-1)
end if
//
//decimal ld_dias_vigencia
//ld_dias_vigencia=dw.getitemdecimal( ll_fila,'dias_vigencia')
//if   isnull(ld_dias_vigencia) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo dias de vigencia")
//	dw.setfocus( )
//	dw.setcolumn('dias_vigencia')
//   RETURN(-1)
//end if
long ll_estado
ll_estado=dw.getitemnumber( ll_fila, 'estado')
if   isnull(ll_estado) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Estado del Producto")
	dw.setfocus( )
	dw.setcolumn('estado')
   RETURN(-1)
end if
long ll_en_oferta
ll_en_oferta=dw.getitemnumber( ll_fila,'en_oferta')
if   isnull(ll_en_oferta) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo En_oferta")
	dw.setfocus( )
	dw.setcolumn('en_oferta')
   RETURN(-1)
end if


				
long ll_deposito
 ll_deposito=dw.getitemnumber( ll_fila, 'cod_deposito')
if   isnull( ll_deposito) then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Deposito")
	dw.setfocus( )
	dw.setcolumn('cod_deposito')
   RETURN(-1)
end if
//decimal ld_porc_beneficio
//ld_porc_beneficio=dw.getitemdecimal( ll_fila, 'porcentaje_beneficio')
//if   isnull(ld_porc_beneficio) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Porcentaje de Beneficio")
//	dw.setfocus( )
//	dw.setcolumn('porcentaje_beneficio')
//   RETURN(-1)
//end if
////decimal ld_porc_beneficio
//ld_porc_beneficio=dw.getitemdecimal( ll_fila, 'porcentaje_beneficio')
//if  ld_porc_beneficio<0 then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Porcentaje de Beneficio no negativo")
//	dw.setfocus( )
//	dw.setcolumn('porcentaje_beneficio')
//   RETURN(-1)
//end if
//decimal ld_costos_insumos
//ld_costos_insumos=dw.getitemdecimal( ll_fila, 'costo_total_insumos')
//if   isnull(ld_costos_insumos) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Costo en Insumos")
//	dw.setfocus( )
//	dw.setcolumn( 'costo_total_insumos')
//   RETURN(-1)
//end if
////decimal ld_costos_insumos
//ld_costos_insumos=dw.getitemdecimal( ll_fila, 'costo_total_insumos')
//if   ld_costos_insumos<=0 then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Costo en Insumos no menor o igual a cero")
//	dw.setfocus( )
//	dw.setcolumn( 'costo_total_insumos')
//   RETURN(-1)
//end if
//
//decimal ld_costo_mano_obra
//ld_costo_mano_obra=dw.getitemdecimal( ll_fila, 'costo_mano_obra')
//if   isnull(ld_costo_mano_obra) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Costo de Mano de Obra")
//	dw.setfocus( )
//	dw.setcolumn( 'costo_mano_obra')
//   RETURN(-1)
//end if
////decimal ld_costo_mano_obra
//ld_costo_mano_obra=dw.getitemdecimal( ll_fila, 'costo_mano_obra')
//if   ld_costo_mano_obra<=0 then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Costo de Mano de Obra no menor o igual a cero")
//	dw.setfocus( )
//	dw.setcolumn( 'costo_mano_obra')
//   RETURN(-1)
//end if
//decimal ld_costo_instalacion
//ld_costo_instalacion=dw.getitemdecimal( ll_fila, 'costo_instalacion')
//if  isnull(ld_costo_mano_obra) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Costo de Instalacion")
//	dw.setfocus( )
//	dw.setcolumn( 'costo_instalacion')
//   RETURN(-1)
//end if
////decimal ld_costo_instalacion
////ld_costo_instalacion=dw.getitemdecimal( ll_fila, 'costo_instalacion')
////if  ld_costo_mano_obra<=0 then
////	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Costo de Instalacion no menor o igual a cero")
////	dw.setfocus( )
////	dw.setcolumn( 'costo_instalacion')
////	
////   RETURN(-1)
////end if
//
//
//decimal ld_precio_costo
//ld_precio_costo=dw.getitemdecimal( ll_fila, 'precio_costo')
//if   isnull(ld_precio_costo) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo precio de costo")
//	dw.setfocus( )
//	dw.setcolumn('precio_costo')
//   RETURN(-1)
//end if
//
//decimal ld_precio_venta
//ld_precio_venta=dw.getitemdecimal( ll_fila, 'precio_venta')
//if   isnull(ld_precio_venta) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Precio de Venta")
//	dw.setfocus( )
//	dw.setcolumn('precio_venta')
//   RETURN(-1)
//end if
//
//				
//long ll_deposito
// ll_deposito=dw.getitemnumber( ll_fila, 'cod_deposito')
//if   isnull(ld_precio_venta) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Deposito")
//	dw.setfocus( )
//	dw.setcolumn('cod_deposito')
//   RETURN(-1)
//end if
//if ib_status=false then return 0
//long ll_cod_insumo
// ll_cod_insumo=dw_detalle.getitemnumber( dw_detalle.getrow() , 'cod_insumo')
//if   isnull(ll_cod_insumo) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo codigo de Insumo")
//	dw_detalle.setfocus( )
//	dw_detalle.setcolumn( 'cod_insumo')
//   RETURN(-1)
//end if
//
//long ll_cantidad
// ll_cantidad=dw_detalle.getitemnumber( dw_detalle.getrow() , 'cantidad')
//if   isnull(ll_cantidad) then
//	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo cantidad")
//	dw_detalle.setfocus( )
//	dw_detalle.setcolumn( 'cod_insumo')
//   RETURN(-1)
//end if
return 0
end function

public function integer fn_validar_campos_recetas (datawindow dw);if g_flag=0 then return 0
long ll_fila
ll_fila=dw.getrow( )
decimal ld_porc_beneficio
tab_1.SelectTab(2)
ld_porc_beneficio=dw.getitemdecimal( ll_fila, 'porc_beneficio')
if   isnull(ld_porc_beneficio) then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Porcentaje de Beneficio")
	dw.setfocus( )
	dw.setcolumn('porc_beneficio')
   RETURN(-1)
end if
//decimal ld_porc_beneficio
ld_porc_beneficio=dw.getitemdecimal( ll_fila, 'porc_beneficio')
if  ld_porc_beneficio<0 then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Porcentaje de Beneficio no negativo")
	dw.setfocus( )
	dw.setcolumn('porc_beneficio')
   RETURN(-1)
end if

decimal ld_costo_mano_obra
ld_costo_mano_obra=dw.getitemdecimal( ll_fila, 'costo_mano_obra')
if   isnull(ld_costo_mano_obra) then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Costo de Mano de Obra")
	dw.setfocus( )
	dw.setcolumn( 'costo_mano_obra')
   RETURN(-1)
end if

decimal ld_costo_instalacion
ld_costo_instalacion=dw.getitemdecimal( ll_fila, 'costo_instalacion')
if  isnull(ld_costo_instalacion) OR trim(string(ld_costo_instalacion))='' then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Costo de Instalacion")
	dw.setfocus( )
	dw.setcolumn( 'costo_instalacion')
   RETURN(-1)
end if



decimal ld_costos_insumos

ld_costos_insumos=dw.getitemdecimal( ll_fila, 'costo_total_insumos')
if   isnull(ld_costos_insumos) OR trim(string(ld_costos_insumos))=''then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar los insumos para obtener los costos en insumos")
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setcolumn( 'cod_insumo')
   RETURN(-1)
end if

//ld_costos_insumos=dw.getitemdecimal( ll_fila, 'costo_total_insumos')
//if   ld_costos_insumos<=0 then
//	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Costo en Insumos no menor o igual a cero")
//	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setfocus( )
//	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setcolumn( 'cod_insumo')
//   RETURN(-1)
//end if
//


decimal ld_precio_costo
ld_precio_costo=dw.getitemdecimal( ll_fila, 'costo_total_producto')
if   isnull(ld_precio_costo) then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo precio de costo")
	dw.setfocus( )
	dw.setcolumn('costo_total_producto')
   RETURN(-1)
end if

decimal ld_precio_venta
ld_precio_venta=dw.getitemdecimal( ll_fila, 'precio_venta')
if   isnull(ld_precio_venta) then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Precio de Venta")
	dw.setfocus( )
	dw.setcolumn('precio_venta')
   RETURN(-1)
end if

tab_1.tabpage_infor_gral.cdw_datos_01.Accepttext()
tab_1.tabpage_infor_gral.cdw_datos_01.setitem( tab_1.tabpage_infor_gral.cdw_datos_01.getrow( ) ,'precio_venta', dw.getitemdecimal( ll_fila, 'precio_venta'))
if ib_status=false then return 0
long ll_cod_insumo
 ll_cod_insumo=tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getitemnumber( tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getrow() , 'cod_insumo')
if   isnull(ll_cod_insumo) then
	messagebox("SOFTPAN - DETALLE RECETAS", "Debe ingresar el campo codigo de Insumo")
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setcolumn( 'cod_insumo')
   RETURN(-1)
end if

long ll_cantidad
 ll_cantidad=tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getitemnumber( tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getrow() , 'cantidad')
if   isnull(ll_cantidad) then
	messagebox("SOFTPAN - DETALLE RECETAS", "Debe ingresar el campo cantidad")
	tab_1.tabpage_recetas_productos.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setcolumn( 'cod_insumo')
   RETURN(-1)
end if
return 0
end function

public function integer fn_insertar_datos (datawindow dw);
long ll_fila,ll_return, ll_cod_producto,ll_cod_tipo_producto,ll_grupo,ll_procedencia,ll_cod_estante,ll_cod_medida,ll_estado
long ll_en_oferta,ll_deposito,ll_fila_receta
decimal ll_tipo_iva,ld_porc_desc, ld_cantidad_actual,ld_cantidad_minima, ld_cantidad_maxima, ld_precio_venta
decimal ld_porc_beneficio,ld_costo_mano_obra,ld_costo_insumos,ld_costo_instalacion,ld_costo_total_producto
string ls_obs,ls_msg ,ls_descripcion_producto,ls_modo_preparacion,ls_notas
integer ll_tiene_receta
ll_fila=dw.getrow( )
ll_fila_receta=tab_1.tabpage_recetas_productos.cdw_datos_02.getrow( )
//PARAMETROS//
ll_cod_producto=dw.getitemnumber( ll_fila,'cod_producto')
ls_descripcion_producto=dw.getitemstring( ll_fila,'descripcion')
ll_cod_tipo_producto=dw.getitemnumber( ll_fila,'cod_tipo_producto')
ll_grupo=dw.getitemnumber( ll_fila,'cod_grupo')
ll_procedencia=dw.getitemnumber( ll_fila, 'cod_procedencia')
ll_tipo_iva=dw.getitemdecimal( ll_fila, 'cod_tipo_iva')
ll_cod_estante=dw.getitemnumber( ll_fila, 'cod_estante')
ll_cod_medida=dw.getitemnumber(ll_fila,'cod_medida')
ld_porc_desc=dw.getitemdecimal( ll_fila, 'porc_descuento')
ll_estado=dw.getitemnumber( ll_fila, 'estado')
ll_en_oferta=dw.getitemnumber( ll_fila,'en_oferta')
ll_deposito=dw.getitemnumber( ll_fila, 'cod_deposito')
ls_obs=dw.getitemstring(ll_fila,'observaciones')
ld_cantidad_actual=dw.getitemdecimal( ll_fila, 'cantidad_actual')
ld_cantidad_minima=dw.getitemdecimal( ll_fila, 'cantidad_minima')
ld_cantidad_maxima=dw.getitemdecimal( ll_fila, 'cantidad_maxima')
ll_tiene_receta=dw.getitemnumber( ll_fila, 'tiene_receta')
date ldt_fecha_alta
ldt_fecha_alta=dw.getitemdate( ll_fila, 'fecha_alta')
ld_precio_venta=dw.getitemdecimal( ll_fila, 'precio_venta')
ls_modo_preparacion=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemstring( ll_fila_receta, 'modo_preparacion')
ls_notas=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemstring( ll_fila_receta, 'notas')
ld_porc_beneficio=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemdecimal( ll_fila_receta, 'porc_beneficio')
ld_costo_mano_obra=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemdecimal( ll_fila_receta, 'costo_mano_obra')
ld_costo_insumos=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemdecimal( ll_fila_receta, 'costo_total_insumos')
ld_costo_instalacion=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemdecimal( ll_fila_receta, 'costo_instalacion')
ld_costo_total_producto=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemdecimal( ll_fila_receta, 'costo_total_producto')
ld_precio_venta=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemdecimal( ll_fila_receta, 'precio_venta')
//sqlca.sp_insert_productos( real(ll_cod_producto), ls_descripcion_producto, real(ll_grupo), real(ll_cod_estante),real(ll_tipo_iva),  real(ll_procedencia), ld_porc_desc,real(ll_cod_medida), ll_cod_tipo_producto, ll_en_oferta,real(ld_precio_venta), ll_estado, date(ldt_fecha_alta),  ls_obs,  real(ll_deposito), ld_cantidad_actual, ld_cantidad_minima,ld_cantidad_maxima,ll_tiene_receta,ls_modo_preparacion,ls_notas,ld_porc_beneficio,ld_costo_mano_obra,ld_costo_insumos,ld_costo_instalacion,ld_costo_total_producto,ld_precio_venta)
if sqlca.sqlcode=0 then
	messagebox('SOFTPAN','REGISTRO INSERTADO CON EXITO')
   commit using sqlca;
else
	messagebox('SOFTPAN','OCURRIO UN ERROR AL TRATAR DE INSERTAR DATOS')
   rollback using sqlca;
end if
return 0
end function

on w_abm_productos_i.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_abm_productos_i.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_insertar;//para la primera hoja
this.tab_1.tabpage_infor_gral.cdw_datos_01.reset( )
this.tab_1.tabpage_infor_gral.cdw_datos_01.insertrow(0)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()
this.tab_1.tabpage_infor_gral.cdw_datos_01.enabled=true
//para la segunda hoja

this.tab_1.tabpage_recetas_productos.cdw_datos_02.reset( )
this.tab_1.tabpage_recetas_productos.cdw_datos_02.insertrow(0)
this.tab_1.tabpage_recetas_productos.cdw_datos_02.enabled=true
ii_borrado=0
tab_1.enabled=true


fn_generar_id ()
pb_borrar.enabled=false
pb_modificar.enabled=false
pb_agregar.enabled=false
pb_buscar.enabled=true
pb_guardar.enabled=true
pb_cancelar.visible=true

long ll_codigo
select min(cod_categoria) into :ll_codigo
from CATEGORIAS;
if isnull(ll_codigo) or ll_codigo = 0 then
	Messagebox('Aviso','No existen categorias definidas~rPrimero debera definir dicho dato')
    this.tab_1.tabpage_infor_gral.cb_6.postevent( clicked!)
//	return 
end if
//definiendo el grupo
long ll_cod_grupo
select min(cod_grupo) into :ll_cod_grupo
from GRUPO_PRODUCTO;

if isnull(ll_cod_grupo) or ll_cod_grupo=0 then
		Messagebox('Aviso','No existen Grupo de Productos definidos~rPrimero debera definir dicho dato')
		 this.tab_1.tabpage_infor_gral.cb_7.postevent( clicked!)
	//return
end if
//definiendo el pais
long ll_cod_pais
select min(cod_pais) into :ll_cod_pais
from PAISES;

if isnull(ll_cod_pais) or ll_cod_pais=0 then
		Messagebox('Aviso','No existen Paises definidos~rPrimero debera definir dicho dato')
	 
end if

//definiendo el tipo de iva
long ll_tipo_iva
select min(cod_tipo_iva) into :ll_tipo_iva
from TIPO_IVA;

if isnull(ll_tipo_iva) or ll_tipo_iva=0 then
		Messagebox('Aviso','No existen Impuestos definidos~rPrimero debera definir dicho dato')
else
		
end if

//definiendo la medida
long ll_cod_medida
select min(cod_medida) into :ll_cod_medida
from MEDIDAS;

if isnull(ll_cod_medida) or ll_cod_medida=0 then
		Messagebox('Aviso','No existen Medidas definidas~rPrimero debera definir dicho dato')
end if

//seteando automaticamente los valores
long ll_fila_hoja_1
//almacenar en una variable la fila actual del dw de la hoja nro 1
ll_fila_hoja_1=this.tab_1.tabpage_infor_gral.cdw_datos_01.getrow()
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1, 'cod_tipo_iva', 3)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'fecha_alta', today())
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'estado', 1)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'cod_procedencia', 1)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'tiene_receta', 1)
if tab_1.tabpage_infor_gral.cdw_datos_01.getitemnumber(  this.tab_1.tabpage_infor_gral.cdw_datos_01.getrow( ) , 'tiene_receta')=1 then g_flag=1



end event

event open;ii_cant_claves = 1  //Cantidad de Claves

tab_1.tabpage_infor_gral.cdw_datos_01.SetTransObject(sqlca)
tab_1.tabpage_recetas_productos.cdw_datos_02.SetTransObject(sqlca)
tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.SetTransObject(sqlca)

f_centrar (w_abm_productos)
//
Long hWnd
hWnd=Handle(this)

OLE_Skin.object.LoadSkin("winaqua.skn")
OLE_Skin.object.ApplySkin (hWnd)


 Long    W_Color
 Long    T_Color
 String  Aplico_w_color
 String  Aplico_T_Color
 
 W_Color        =ole_skin.object.WindowColor()
 Aplico_w_color = "DataWindow.Color="+"'"+String(W_Color)+"'"
cdw_datos.Modify ( Aplico_W_color )

 T_Color        =ole_skin.object.PanelTextColor()
 Aplico_T_color = "'"+String(T_Color)+"'"
 cdw_datos.Modify ( Aplico_T_color )
 if tab_1.tabpage_infor_gral.cdw_datos_01.retrieve()<=0 then
 	triggerevent("ue_insertar")
 else
	long ll_fila
	ll_fila=tab_1.tabpage_infor_gral.cdw_datos_01.rowcount( )
	tab_1.tabpage_infor_gral.cdw_datos_01.retrieve( )
	tab_1.tabpage_infor_gral.cdw_datos_01.scrolltorow(ll_fila)
	//this.tab_1.enabled  =false
 end if

end event

event ue_guardar;	tab_1.tabpage_infor_gral.cdw_datos_01.Accepttext()
	tab_1.tabpage_recetas_productos.cdw_datos_02.Accepttext()
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.Accepttext()
if fn_validar_campos_productos (tab_1.tabpage_infor_gral.cdw_datos_01  )= -1 then return
 if fn_validar_campos_recetas (tab_1.tabpage_recetas_productos.cdw_datos_02  )= -1 then return
	If messagebox("SOFTPAN","¿Esta seguro que desea actualizar éste registro?", Exclamation!, yesno!, 2)=2 then return

	IF tab_1.tabpage_infor_gral.cdw_datos_01.update (TRUE, FALSE) = 1  THEN
		IF tab_1.tabpage_recetas_productos.cdw_datos_02.Update(TRUE, FALSE) = 1  THEN
			
			IF tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.Update(TRUE, FALSE) = 1  THEN
			
			tab_1.tabpage_infor_gral.cdw_datos_01.ResetUpdate( )
			tab_1.tabpage_recetas_productos.cdw_datos_02.ResetUpdate( )
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.ResetUpdate( )
			Commit using sqlca ;
			pb_borrar.enabled=true
			pb_cancelar.visible=true
			pb_modificar.enabled=true
			pb_agregar.enabled=true
			pb_buscar.enabled=true
			cdw_datos.enabled=false
			tab_1.tabpage_infor_gral.cdw_datos_01.scrolltorow( tab_1.tabpage_infor_gral.cdw_datos_01.rowcount())
			tab_1.SelectTab(1)
			tab_1.enabled=false
	ELSE
			ROLLBACK USING SQLCA;
				if is_mensaje_error <> "" then
				MessageBox("ERROR ",is_mensaje_error)	
				is_mensaje_error = ""
			end if
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.RowsMove (1, tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.deletedcount(), delete!, tab_1.tabpage_infor_gral.cdw_datos_01, tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.RowCount(), primary!)
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.Sort()
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.SetRow (1)
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.SetFocus ()
		End If
	ELSE
		ROLLBACK USING SQLCA;
		
		tab_1.tabpage_recetas_productos.cdw_datos_02.RowsMove(1,1,delete!,tab_1.tabpage_recetas_productos.cdw_datos_02,1,primary!)
		tab_1.tabpage_recetas_productos.cdw_datos_02.SetRow(1)
		tab_1.tabpage_recetas_productos.cdw_datos_02.SetFocus()
		
	END IF
	ROLLBACK USING SQLCA;
		tab_1.tabpage_infor_gral.cdw_datos_01.RowsMove(1,1,delete!,tab_1.tabpage_infor_gral.cdw_datos_01,1,primary!)
		tab_1.tabpage_infor_gral.cdw_datos_01.SetRow(1)
		tab_1.tabpage_infor_gral.cdw_datos_01.SetFocus()
			
		
end if



end event

event ue_guardar_01;
	tab_1.tabpage_infor_gral.cdw_datos_01.Accepttext()
	tab_1.tabpage_recetas_productos.cdw_datos_02.Accepttext()
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.Accepttext()
	IF tab_1.tabpage_infor_gral.cdw_datos_01.update (TRUE, FALSE) = 1  THEN
		IF tab_1.tabpage_recetas_productos.cdw_datos_02.Update(TRUE, FALSE) = 1  THEN
			
			IF tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.Update(TRUE, FALSE) = 1  THEN
				
			tab_1.tabpage_infor_gral.cdw_datos_01.ResetUpdate( )
			tab_1.tabpage_recetas_productos.cdw_datos_02.ResetUpdate( )
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.ResetUpdate( )
			Commit using sqlca ;
			postevent('ue_insertar')
		ELSE
			ROLLBACK USING SQLCA;
				if is_mensaje_error <> "" then
				MessageBox("ERROR ",is_mensaje_error)	
				is_mensaje_error = ""
			end if
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.RowsMove (1, tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.deletedcount(), delete!, tab_1.tabpage_infor_gral.cdw_datos_01, tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.RowCount(), primary!)
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.Sort()
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.SetRow (1)
			tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.SetFocus ()
		End If
	ELSE
		ROLLBACK USING SQLCA;
		
		tab_1.tabpage_recetas_productos.cdw_datos_02.RowsMove(1,1,delete!,tab_1.tabpage_recetas_productos.cdw_datos_02,1,primary!)
		tab_1.tabpage_recetas_productos.cdw_datos_02.SetRow(1)
		tab_1.tabpage_recetas_productos.cdw_datos_02.SetFocus()
		
	END IF
	ROLLBACK USING SQLCA;
		tab_1.tabpage_infor_gral.cdw_datos_01.RowsMove(1,1,delete!,tab_1.tabpage_infor_gral.cdw_datos_01,1,primary!)
		tab_1.tabpage_infor_gral.cdw_datos_01.SetRow(1)
		tab_1.tabpage_infor_gral.cdw_datos_01.SetFocus()
end if

end event

event ue_eliminar;
if messagebox('Desea borrar el siguiente registro', 'Eliminar registro',question!,yesno!,2)=1 then
	ii_borrado=1
	tab_1.tabpage_infor_gral.cdw_datos_01.DeleteRow(0)
	this.postEvent("ue_guardar_01")
	
end if


end event

type p_1 from w_abm_ancestor`p_1 within w_abm_productos_i
integer x = 2647
integer width = 763
end type

type pb_buscar from w_abm_ancestor`pb_buscar within w_abm_productos_i
integer x = 1568
integer y = 1716
integer taborder = 140
end type

event pb_buscar::clicked;open(w_busqueda_avanzada_producto,parent)
if v_criterio =0 then return -1
long ll_busqueda,ll_filas
ll_filas= tab_1.tabpage_infor_gral.cdw_datos_01.rowcount()
tab_1.tabpage_infor_gral.cdw_datos_01.retrieve( )
ll_busqueda=tab_1.tabpage_infor_gral.cdw_datos_01.find( 'cod_producto='+string(v_criterio), 1, ll_filas)
tab_1.tabpage_infor_gral.cdw_datos_01.scrolltorow(ll_busqueda)
tab_1.tabpage_recetas_productos.cdw_datos_02.retrieve(v_criterio )
pb_borrar.enabled=false
pb_modificar.enabled=true
pb_agregar.enabled=false
pb_buscar.enabled=true
pb_guardar.enabled=true
pb_cancelar.visible=true
end event

type pb_cancelar from w_abm_ancestor`pb_cancelar within w_abm_productos_i
integer x = 2103
integer taborder = 170
end type

event pb_cancelar::clicked;if messagebox("CANCELAR",'Quieres cancelar los cambios',question!,okcancel!,2)=1 then
	if tab_1.tabpage_infor_gral.cdw_datos_01.retrieve( )<=0 then
	pb_agregar.triggerevent( clicked!)
	else
		
		tab_1.tabpage_infor_gral.cdw_datos_01.retrieve( )
		//cdw_datos.enabled=true
	end if

	pb_borrar.enabled=true
	pb_cancelar.enabled=false
	pb_modificar.enabled=true
	pb_agregar.enabled=true
	pb_buscar.enabled=true
end if
end event

type pb_modificar from w_abm_ancestor`pb_modificar within w_abm_productos_i
integer x = 1632
integer taborder = 80
end type

event pb_modificar::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.getrow()>0 then
	tab_1.enabled=true
	tab_1.tabpage_infor_gral.cdw_datos_01.enabled=true
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()
	ii_borrado=1
	pb_borrar.enabled=true
	pb_cancelar.visible=false
	pb_modificar.enabled=false
	pb_agregar.enabled=false
	pb_buscar.enabled=false
	pb_guardar.enabled=true
	pb_cancelar.visible=true

	tab_1.tabpage_infor_gral.cdw_datos_01.enabled=true
ELSE
	MESSAGEBOX(PARENT.TITLE,"No existe registro para modificar",information!)
END IF
end event

type pb_borrar from w_abm_ancestor`pb_borrar within w_abm_productos_i
integer x = 1170
integer taborder = 160
end type

type pb_guardar from w_abm_ancestor`pb_guardar within w_abm_productos_i
integer x = 713
integer taborder = 40
end type

type pb_agregar from w_abm_ancestor`pb_agregar within w_abm_productos_i
integer x = 256
integer taborder = 150
end type

type ole_skin from w_abm_ancestor`ole_skin within w_abm_productos_i
end type

type st_4 from w_abm_ancestor`st_4 within w_abm_productos_i
integer x = 2624
integer y = 1880
end type

type st_3 from w_abm_ancestor`st_3 within w_abm_productos_i
integer x = 2258
integer y = 1880
end type

type st_2 from w_abm_ancestor`st_2 within w_abm_productos_i
integer x = 1897
integer y = 1880
end type

type st_1 from w_abm_ancestor`st_1 within w_abm_productos_i
integer x = 1531
integer y = 1880
end type

type pb_cerrar from w_abm_ancestor`pb_cerrar within w_abm_productos_i
integer x = 2080
integer y = 1716
integer taborder = 130
end type

type btn_ultimo from w_abm_ancestor`btn_ultimo within w_abm_productos_i
integer x = 1161
integer y = 1824
integer height = 100
integer taborder = 90
end type

event btn_ultimo::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.rowcount()>0 then
	tab_1.tabpage_infor_gral.cdw_datos_01.scrolltorow(tab_1.tabpage_infor_gral.cdw_datos_01.rowcount())
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()
end if
	
end event

type btn_siguente from w_abm_ancestor`btn_siguente within w_abm_productos_i
integer x = 896
integer y = 1824
integer height = 100
integer taborder = 110
end type

event btn_siguente::clicked;if  tab_1.tabpage_infor_gral.cdw_datos_01.getrow()<> tab_1.tabpage_infor_gral.cdw_datos_01.rowcount() then
	 tab_1.tabpage_infor_gral.cdw_datos_01.scrollnextrow()
	 tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()

end if
end event

type btn_anterior from w_abm_ancestor`btn_anterior within w_abm_productos_i
integer x = 631
integer y = 1824
integer height = 104
integer taborder = 50
end type

event btn_anterior::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.getrow()>1 then
	tab_1.tabpage_infor_gral.cdw_datos_01.scrollpriorrow()
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()

end if
end event

type btn_primero from w_abm_ancestor`btn_primero within w_abm_productos_i
integer x = 366
integer y = 1824
integer height = 100
integer taborder = 60
end type

event btn_primero::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.rowcount()>0 then
	tab_1.tabpage_infor_gral.cdw_datos_01.scrolltorow(1)
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()

end if
end event

type st_barra from w_abm_ancestor`st_barra within w_abm_productos_i
end type

type cdw_datos from w_abm_ancestor`cdw_datos within w_abm_productos_i
boolean visible = false
integer x = 3063
integer width = 91
integer height = 140
end type

event cdw_datos::constructor;//
end event

type gb_1 from w_abm_ancestor`gb_1 within w_abm_productos_i
integer x = 219
integer taborder = 30
end type

type gb_3 from w_abm_ancestor`gb_3 within w_abm_productos_i
integer x = 311
integer y = 1724
integer width = 1129
integer height = 256
integer taborder = 120
end type

type ln_1 from w_abm_ancestor`ln_1 within w_abm_productos_i
integer beginx = 3186
integer beginy = 1700
integer endx = 306
integer endy = 1696
end type

type tab_1 from tab within w_abm_productos_i
integer x = 311
integer y = 320
integer width = 3022
integer height = 1328
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_infor_gral tabpage_infor_gral
tabpage_recetas_productos tabpage_recetas_productos
end type

on tab_1.create
this.tabpage_infor_gral=create tabpage_infor_gral
this.tabpage_recetas_productos=create tabpage_recetas_productos
this.Control[]={this.tabpage_infor_gral,&
this.tabpage_recetas_productos}
end on

on tab_1.destroy
destroy(this.tabpage_infor_gral)
destroy(this.tabpage_recetas_productos)
end on

type tabpage_infor_gral from userobject within tab_1
integer x = 18
integer y = 120
integer width = 2985
integer height = 1192
long backcolor = 16777215
string text = "INFORMACION"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "Custom026!"
long picturemaskcolor = 536870912
cb_1 cb_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cdw_datos_01 cdw_datos_01
end type

on tabpage_infor_gral.create
this.cb_1=create cb_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cdw_datos_01=create cdw_datos_01
this.Control[]={this.cb_1,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cdw_datos_01}
end on

on tabpage_infor_gral.destroy
destroy(this.cb_1)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cdw_datos_01)
end on

type cb_1 from commandbutton within tabpage_infor_gral
integer x = 2743
integer y = 728
integer width = 160
integer height = 96
integer taborder = 120
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_depositos,w_abm_productos)
end event

type cb_7 from commandbutton within tabpage_infor_gral
integer x = 2752
integer y = 188
integer width = 160
integer height = 96
integer taborder = 180
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_grupo_producto,w_abm_productos)
end event

type cb_6 from commandbutton within tabpage_infor_gral
integer x = 2752
integer y = 84
integer width = 160
integer height = 96
integer taborder = 170
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_categorias_productos,w_abm_productos)
end event

type cb_5 from commandbutton within tabpage_infor_gral
integer x = 1321
integer y = 636
integer width = 174
integer height = 100
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_paises,w_abm_productos)
end event

type cb_4 from commandbutton within tabpage_infor_gral
integer x = 1321
integer y = 524
integer width = 174
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_medidas,w_abm_productos)
end event

type cb_3 from commandbutton within tabpage_infor_gral
integer x = 1321
integer y = 412
integer width = 174
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_tipo_iva,w_abm_productos)
end event

type cb_2 from commandbutton within tabpage_infor_gral
integer x = 1321
integer y = 300
integer width = 174
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "..."
end type

event clicked;open(w_abm_estantes,w_abm_productos)
end event

type cdw_datos_01 from datawindow within tabpage_infor_gral
event ue_despues ( )
event ue_enter pbm_dwnprocessenter
integer x = 55
integer y = 44
integer width = 2889
integer height = 1128
integer taborder = 20
string dataobject = "dw_abm_productos_cab"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_despues();

long ll_null
	choose case is_colname
	case 'cod_tipo_producto' 
		long ll_cod_tipo_producto
		ll_cod_tipo_producto=this.getitemnumber( ii_row,is_colname)
		if ll_cod_tipo_producto =1 then ib_status=true
			datawindowchild dw_filtra_tipo_producto
			this.getchild( 'cod_grupo', dw_filtra_tipo_producto)
			dw_filtra_tipo_producto.settransobject( sqlca)
			dw_filtra_tipo_producto.setfilter( 'cod_categoria='+string(ll_cod_tipo_producto))
			dw_filtra_tipo_producto.filter( )
			dw_filtra_tipo_producto.retrieve( )
	case 'cantidad_maxima' 
		decimal ld_cantidad_max
		ld_cantidad_max=this.getitemdecimal( this.getrow(), is_colname)
		if ld_cantidad_max<0 then
			messagebox('Aviso','Valor no puede ser negativo')
			this.setcolumn( is_colname)
			this.setitem( ii_row, is_colname, 1)
		end if
	case 'cantidad_minima'
			decimal ld_cantidad_min
		ld_cantidad_max=this.getitemdecimal( this.getrow(), 'cantidad_maxima' )
		ld_cantidad_min=this.getitemdecimal( this.getrow(), is_colname )
		if isnull(ld_cantidad_max) or ld_cantidad_max=0 then
			messagebox('Aviso','Primero ingrese la cantidad maxima permitida')
			this.setcolumn('cantidad_maxima')
			this.setitem( ii_row, is_colname, 0)
		end if
		if ld_cantidad_min<0 then
			messagebox('Aviso','Valor  no puede ser negativo')
			this.setcolumn( is_colname)
			this.setitem( ii_row, is_colname, 1)
		end if
		
		if ld_cantidad_min >=ld_cantidad_max then
			messagebox('Aviso','Cantidad minima debe ser menor a la maxima')
			this.setcolumn( is_colname)
			this.setitem( ii_row, is_colname, 1)
		end if
	case 'tiene_receta'
		long bl_tiene_receta
		bl_tiene_receta=this.getitemnumber(ii_row, is_colname)
		if bl_tiene_receta=1 then g_flag=1
		if bl_tiene_receta=0 then g_flag=0
end choose
end event

event ue_enter;Send(Handle(this),256,9,Long(0,0)) 
end event

event getfocus;if this.rowcount() = 0 then return
//Tipo de producto
		datawindowchild dwc_recupera_tipo_producto
		this.getchild('cod_tipo_producto',dwc_recupera_tipo_producto)
		dwc_recupera_tipo_producto.settransobject(sqlca)
   	dwc_recupera_tipo_producto.retrieve( )
//Grupo de producto
		long ll_cod_grupo
		ll_cod_grupo=this.getitemnumber(this.getrow(),'cod_tipo_producto')
	
		this.getchild('cod_grupo',dwc_recupera)
		dwc_recupera.settransobject(sqlca)
		dwc_recupera.retrieve( )

//Procedencia
		this.getchild('cod_procedencia',dwc_recupera)
		dwc_recupera.settransobject(sqlca)
		dwc_recupera.retrieve( )
//Medida
		this.getchild('cod_medida',dwc_recupera)
		dwc_recupera.settransobject(sqlca)
		dwc_recupera.retrieve( )
//Tipo de Iva
		this.getchild('cod_tipo_iva',dwc_recupera)
		dwc_recupera.settransobject(sqlca)
		dwc_recupera.reset( )
		dwc_recupera.retrieve( )
//Estantes
		this.getchild('cod_estante',dwc_recupera)
		dwc_recupera.settransobject(sqlca)
		dwc_recupera.retrieve( )
//Depositos
		this.getchild('cod_deposito',dwc_recupera)
		dwc_recupera.settransobject(sqlca)
		dwc_recupera.retrieve( )


end event

event rowfocuschanged;long ll_clave,ll_clave_02
if this.getrow()>0 then
	
	ll_clave=this.getitemnumber( this.getrow(),'cod_producto')

	if tab_1.tabpage_recetas_productos.cdw_datos_02.retrieve(ll_clave)<=0 then
		tab_1.tabpage_recetas_productos.cdw_datos_02.insertrow( 0)
	else
		ll_clave_02=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemnumber( tab_1.tabpage_recetas_productos.cdw_datos_02.getrow(), 'cod_receta')
		if tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.retrieve(ll_clave_02)<=0 then
				   tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.insertrow( 0)
		end if
	end if
end if

end event

event itemchanged;
ii_row =row
is_colname=dwo.name
this.postevent("ue_despues")
end event

event updateend;string ls_msg
setnull(ls_msg)
If rowsinserted > 0 then
	ls_msg = 'Datos registrados con éxito.'
Elseif rowsupdated > 0 then
	ls_msg = 'Cambios registrados con éxito.'
	
Elseif rowsdeleted > 0 then
	ls_msg = 'Registro eliminado.'
end if
if not isnull(ls_msg) then
	messagebox("Atención !!",ls_msg,none!)
end if
end event

type tabpage_recetas_productos from userobject within tab_1
integer x = 18
integer y = 120
integer width = 2985
integer height = 1192
long backcolor = 16777215
string text = "RECETAS"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "MoveMode!"
long picturemaskcolor = 536870912
cb_8 cb_8
cb_quitar_detalle cb_quitar_detalle
cb_agregar_detalle cb_agregar_detalle
cdw_datos_detalle_02 cdw_datos_detalle_02
cdw_datos_02 cdw_datos_02
end type

on tabpage_recetas_productos.create
this.cb_8=create cb_8
this.cb_quitar_detalle=create cb_quitar_detalle
this.cb_agregar_detalle=create cb_agregar_detalle
this.cdw_datos_detalle_02=create cdw_datos_detalle_02
this.cdw_datos_02=create cdw_datos_02
this.Control[]={this.cb_8,&
this.cb_quitar_detalle,&
this.cb_agregar_detalle,&
this.cdw_datos_detalle_02,&
this.cdw_datos_02}
end on

on tabpage_recetas_productos.destroy
destroy(this.cb_8)
destroy(this.cb_quitar_detalle)
destroy(this.cb_agregar_detalle)
destroy(this.cdw_datos_detalle_02)
destroy(this.cdw_datos_02)
end on

type cb_8 from commandbutton within tabpage_recetas_productos
integer x = 2222
integer y = 732
integer width = 539
integer height = 128
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean italic = true
string text = "Nuevo Insumo"
end type

event clicked;open(w_abm_insumos,w_abm_productos)
end event

type cb_quitar_detalle from commandbutton within tabpage_recetas_productos
integer x = 2222
integer y = 988
integer width = 443
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
boolean italic = true
string text = "Quitar Detalle"
end type

event clicked;If cdw_datos_detalle_02.getrow() <> 0 Then
	cdw_datos_detalle_02.DeleteRow (cdw_datos_detalle_02.getrow() )
End If
if cdw_datos_detalle_02.RowCount() = 0 then
	
	cb_agregar_detalle.triggerevent(clicked!)
	messagebox("SOFTPAN",upper("Intenta quitar ultimo item"),none!)
end if
end event

type cb_agregar_detalle from commandbutton within tabpage_recetas_productos
integer x = 2222
integer y = 876
integer width = 443
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
boolean italic = true
string text = "Agregar Detalle"
end type

event clicked;long valor1
integer fila                   

fila    = RowCount(cdw_datos_detalle_02)
if ii_max_filas_detalle = 0 or fila < ii_max_filas_detalle then
	valor1 = cdw_datos_02.GetItemNumber(1,1) 
	fila = cdw_datos_detalle_02.Insertrow (0)

	cdw_datos_detalle_02.setitem (fila, 1, valor1)  
	cdw_datos_detalle_02.setrow (fila)
	cdw_datos_detalle_02.setColumn (ii_prim_fila_detalle)
	cdw_datos_detalle_02.scrolltorow(fila)
	if ib_focus = true then setfocus (cdw_datos_detalle_02)
else
	SetMicroHelp("La máxima cantidad de filas del detalle es " + string(ii_max_filas_detalle))
end if
end event

type cdw_datos_detalle_02 from datawindow within tabpage_recetas_productos
event ue_despues ( )
event ue_enter pbm_dwnprocessenter
integer x = 59
integer y = 740
integer width = 2103
integer height = 364
integer taborder = 80
string title = "DETALLE DE INGREDIENTES"
string dataobject = "dw_abm_det_recetas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_despues();long ll_cod_insumo
	
	if is_colname='cod_insumo' then
		decimal ld_precio_compra
		ll_cod_insumo=this.getitemnumber( ii_row, 'cod_insumo')
		select precio_compra
		into :ld_precio_compra
		from Insumos
		where cod_insumo=:ll_cod_insumo;
		
		this.setitem( ii_row, 'precio_insumo', ld_precio_compra)
		
	end if
	
	
	cdw_datos_02.setitem( cdw_datos_02.getrow(), 'costo_total_insumos',this.getitemdecimal(this.getrow(), 'total_insumos'))
	cdw_datos_02.setitem( cdw_datos_02.getrow(), 'costo_total_producto', cdw_datos_02.getitemdecimal( cdw_datos_02.getrow(), 'precio_costo_aux') )
	cdw_datos_02.setitem( cdw_datos_02.getrow(), 'precio_venta', cdw_datos_02.getitemdecimal( cdw_datos_02.getrow(), 'precio_venta_aux') )

end event

event ue_enter;Send(Handle(this),256,9,Long(0,0)) 
end event

event itemchanged;
	ii_row =row
   is_colname=dwo.name
	this.postevent("ue_despues")
end event

event getfocus;if this.rowcount() = 0 then return
//Tipo de producto
		datawindowchild dwc_recupera_insumos
		this.getchild('cod_insumo',dwc_recupera_insumos)
		dwc_recupera_insumos.settransobject(sqlca)
   	dwc_recupera_insumos.retrieve( )
end event

type cdw_datos_02 from datawindow within tabpage_recetas_productos
event type long ue_despues ( )
event ue_enter pbm_dwnprocessenter
integer x = 69
integer y = 24
integer width = 2903
integer height = 692
integer taborder = 80
string title = "COSTOS PRODUCTO"
string dataobject = "dw_abm_productos_costos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_despues();

long ll_null
	choose case is_colname
		case 'porc_beneficio'
	long ld_porc_beneficio
		ld_porc_beneficio=this.getitemdecimal( ii_row, 'porc_beneficio')
		if ld_porc_beneficio<0 then
			messagebox("SOFTPAN","Campo porcentage beneficio no puede ser negativo")
			this.setitem( ii_row,'porcentaje_beneficio', g_long_null)
			this.setcolumn('porc_beneficio')
			this.setfocus( )
			return -1
	  end if
	  case 'costo_total_insumos'
	  long ld_costo_insumos
		ld_costo_insumos=this.getitemdecimal( ii_row, 'costo_total_insumos')
		if ld_costo_insumos<=0 then
			messagebox("SOFTPAN","Campo costo total en insumos no menor o igual a cero")
			this.setitem( ii_row,'costo_total_insumos', g_long_null)
			this.setcolumn('costo_total_insumos')
			this.setfocus( )
			return -1
	  end if

	  this.setitem( this.getrow(), 'costo_total_producto', this.getitemdecimal( ii_row, 'precio_costo_aux') )
	  this.setitem(  this.getrow(), 'precio_venta',  this.getitemdecimal( ii_row, 'precio_venta_aux') )
	  return 0
	  case 'costo_mano_obra'
	  long ld_costo_mano_obra
		ld_costo_mano_obra=this.getitemdecimal( ii_row, 'costo_mano_obra')
		if ld_costo_mano_obra<=0 then
			messagebox("SOFTPAN","Campo costo mano de obra no menor o igual a cero")
			this.setitem( ii_row,'costo_mano_obra', 1)
			this.setcolumn('costo_mano_obra')
			this.setfocus( )
			return -1
	  end if
	  
	  this.setitem( this.getrow(), 'costo_total_producto', this.getitemdecimal( ii_row, 'precio_costo_aux') )
	  this.setitem(  this.getrow(), 'precio_venta',  this.getitemdecimal( ii_row, 'precio_venta_aux') )
	  
	  return 0
	
	case 'costo_instalacion'
	  long ld_costo_instalacion
		ld_costo_instalacion=this.getitemdecimal( ii_row, 'costo_instalacion')
		if ld_costo_instalacion<=0 then
			messagebox("SOFTPAN","Campo costo en instalacion no menor o igual a cero")
			this.setitem( ii_row,'costo_instalacion', 1)
			this.setcolumn('costo_instalacion')
			this.setfocus( )
			return -1
	  end if
	  
	  this.setitem( this.getrow(), 'costo_total_producto', this.getitemdecimal( ii_row, 'precio_costo_aux') )
	  this.setitem(  this.getrow(), 'precio_venta',  this.getitemdecimal( ii_row, 'precio_venta_aux') )
	  case 'costo_total_insumos'
	  long ld_precio_costo
		ld_precio_costo=this.getitemdecimal( ii_row,'costo_total_insumos')
		if ld_precio_costo<=0 then
			messagebox("SOFTPAN","Campo precio costo no menor o igual a cero")
			this.setitem( ii_row,'costo_total_insumos', 1)
			this.setcolumn('costo_total_insumos')
			this.setfocus( )
			return -1
	  end if
	   cdw_datos_02.setitem( cdw_datos_02.getrow(), 'precio_venta', cdw_datos_02.getitemdecimal( ii_row, 'precio_venta_aux') )
	   case 'precio_venta'
	   long ld_precio_venta
		ld_precio_venta=this.getitemdecimal( ii_row,'precio_venta')
		if ld_precio_venta<=0 then
			messagebox("SOFTPAN","Campo precio venta no menor o igual a cero")
			this.setitem( ii_row,'precio_venta', 1)
			this.setcolumn('precio_venta')
			this.setfocus( )
			return -1
	  end if
	  ld_precio_costo=this.getitemdecimal( cdw_datos_02.getrow(),'costo_total_insumos')
	   if ld_precio_venta<ld_precio_costo then
			if messagebox("SOFTPAN","Desea establecer el precio venta menor al costo?",Question!,yesno!,1)=1 then return -1
			this.setitem( cdw_datos_02.getrow(), 'precio_venta', cdw_datos_02.getitemdecimal( ii_row, 'precio_venta_aux') )
		   this.setcolumn('precio_venta')
			this.setfocus( )
	end if

end choose
return 0
end event

event ue_enter();Send(Handle(this),256,9,Long(0,0)) 
end event

event rowfocuschanged;long ll_clave
if this.getrow()>0 then
	ll_clave=this.getitemnumber( 1, 'cod_receta')
	
	if cdw_datos_detalle_02.retrieve(ll_clave)<=0 then
		cdw_datos_detalle_02.insertrow( 0)
	end if
end if

end event

event itemchanged;ii_row =row
is_colname=dwo.name
this.postevent("ue_despues")

  
  
end event

event updatestart;
if this.rowcount( )=0 or ii_borrado=1 then return
long ll_max,i
select isnull(max(cod_receta),0)+1 
into :ll_max
from Recetas;

this.setitem( this.getrow(), 'cod_receta', ll_max)

for i=1 to cdw_datos_detalle_02.rowcount( )
	cdw_datos_detalle_02.setitem(i,'cod_receta',ll_max)

next 



end event

event retrieverow;//long ll_clave
//if this.getrow()>0 then
//	ll_clave=this.getitemnumber( this.getrow(), 'cod_receta')
//	if cdw_datos_detalle_02.retrieve(ll_clave)<=0 then
//		cdw_datos_detalle_02.insertrow( 0)
//	end if
//end if
end event


$PBExportHeader$w_abm_productos.srw
forward
global type w_abm_productos from w_abm_ancestor
end type
type tab_1 from tab within w_abm_productos
end type
type tabpage_infor_gral from userobject within tab_1
end type
type cdw_deposito_productos from datawindow within tabpage_infor_gral
end type
type cdw_datos_01 from datawindow within tabpage_infor_gral
end type
type tabpage_infor_gral from userobject within tab_1
cdw_deposito_productos cdw_deposito_productos
cdw_datos_01 cdw_datos_01
end type
type tabpage_recetas_productos from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_recetas_productos
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
cb_1 cb_1
cb_quitar_detalle cb_quitar_detalle
cb_agregar_detalle cb_agregar_detalle
cdw_datos_detalle_02 cdw_datos_detalle_02
cdw_datos_02 cdw_datos_02
end type
type tabpage_historicos from userobject within tab_1
end type
type st_5 from statictext within tabpage_historicos
end type
type dw_1 from datawindow within tabpage_historicos
end type
type tabpage_historicos from userobject within tab_1
st_5 st_5
dw_1 dw_1
end type
type tab_1 from tab within w_abm_productos
tabpage_infor_gral tabpage_infor_gral
tabpage_recetas_productos tabpage_recetas_productos
tabpage_historicos tabpage_historicos
end type
type cdw_imprimir from datawindow within w_abm_productos
end type
end forward

global type w_abm_productos from w_abm_ancestor
integer width = 3493
integer height = 2400
string title = "MANTENIMIENTO DE PRODUCTOS"
tab_1 tab_1
cdw_imprimir cdw_imprimir
end type
global w_abm_productos w_abm_productos

type variables
long ii_max_filas_detalle,ii_prim_fila_detalle
long ii_prim_fila_cab,ii_ult_item_detalle
boolean ib_focus = false,ib_status=false
long ii_borrado,il_operacion /* 1 alta   2 modifica	3 borrado */
/*Operaciones de ABMC sobre la tabla productos*/
/*Se declara variables de instacias para ello*/
long il_cod_producto,il_cod_tipo_producto,il_cod_grupo,il_cod_tipo_iva,il_cod_estante
long il_cod_deposito,il_cod_medida,il_cod_pais,il_estado,il_tiene_receta,il_en_oferta
long il_activo_prod,il_activo_compra,il_activo_venta
long il_cod_insumo,il_cod_receta,il_cod_marca,il_tiene_stock
long ll_es_compuesto,ll_es_servicio
decimal id_precio_venta,id_porc_descuento,id_cantidad_actual,id_cantidad_max,id_cantidad_min
string is_descripcion,is_observaciones
datetime idt_fecha_alta
decimal id_cantidad_x_medida,id_precio_costo
/*Operaciones de ABMC sobre la tabla Insumos*/
/*Declaramos variables de instancias para ello*/
decimal id_costo_mano_obra,id_costo_total_insumos,id_costo_instalacion,id_costo_total/*,id_precio_venta*/,id_porc_beneficio
string is_notas,is_modo_preparacion,ls_descripcion_receta

end variables

forward prototypes
public subroutine fn_generar_id ()
public function integer fn_validar_campos_productos (datawindow dw)
public function integer fn_validar_campos_recetas (datawindow dw)
public function integer fn_tomar_valores_campos (datawindow v_dw_recetas, datawindow v_dw)
public function integer fn_insertar_fk_detalle_receta ()
public function integer fn_inserta_detalle (datawindow dw_receta)
public function integer fn_insertar_depositos (datawindow dw_dep)
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

long ll_cod_marca
ll_cod_marca=dw.getitemnumber(ll_fila,'cod_marca')
if   isnull(ll_cod_marca) then
	messagebox("SOFTPAN-PRODUCTOS", "Debe ingresar el campo Marca")
	dw.setfocus( )
	dw.setcolumn('cod_marca')
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


	
return 0
end function

public function integer fn_validar_campos_recetas (datawindow dw);

if g_flag=0 then return 0
long ll_fila
ll_fila=dw.getrow( )
decimal ld_porc_beneficio

ld_porc_beneficio=dw.getitemdecimal( ll_fila, 'porc_beneficio')
if   isnull(ld_porc_beneficio) then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Porcentaje de Beneficio")
	tab_1.SelectTab(2)
	dw.setfocus( )
	dw.setcolumn('porc_beneficio')
   RETURN(-1)
end if
//decimal ld_porc_beneficio
ld_porc_beneficio=dw.getitemdecimal( ll_fila, 'porc_beneficio')
if  ld_porc_beneficio<0 then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Porcentaje de Beneficio no negativo")
	tab_1.SelectTab(2)
	dw.setfocus( )
	dw.setcolumn('porc_beneficio')
   RETURN(-1)
end if

decimal ld_costo_mano_obra
ld_costo_mano_obra=dw.getitemdecimal( ll_fila, 'costo_mano_obra')
if   isnull(ld_costo_mano_obra) then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Costo de Mano de Obra")
	tab_1.SelectTab(2)
	dw.setfocus( )
	dw.setcolumn( 'costo_mano_obra')
   RETURN(-1)
end if

decimal ld_costo_instalacion
ld_costo_instalacion=dw.getitemdecimal( ll_fila, 'costo_instalacion')
if  isnull(ld_costo_instalacion) OR trim(string(ld_costo_instalacion))='' then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Costo de Instalacion")
	tab_1.SelectTab(2)
	dw.setfocus( )
	dw.setcolumn( 'costo_instalacion')
   RETURN(-1)
end if



decimal ld_costos_insumos

ld_costos_insumos=dw.getitemdecimal( ll_fila, 'costo_total_insumos')
if   isnull(ld_costos_insumos) OR trim(string(ld_costos_insumos))=''then
	messagebox("SOFTPAN - RECETAS", "Debe ingresar los insumos para obtener los costos en insumos")
	tab_1.SelectTab(2)
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setcolumn( 'costo_total_insumos')
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


//decimal ld_precio_costo
//ld_precio_costo=dw.getitemdecimal( ll_fila, 'costo_total_producto')
//if   isnull(ld_precio_costo) then
//	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo precio de costo")
//	tab_1.SelectTab(2)
//	dw.setfocus( )
//	dw.setcolumn('costo_total_producto')
//   RETURN(-1)
//end if

//decimal ld_precio_venta
//ld_precio_venta=dw.getitemdecimal( ll_fila, 'precio_costo')
//if   isnull(ld_precio_venta) then
//	messagebox("SOFTPAN - RECETAS", "Debe ingresar el campo Precio de Venta")
//	tab_1.SelectTab(2)
//	dw.setfocus( )
//	dw.setcolumn('precio_costo')
//   RETURN(-1)
//end if

tab_1.tabpage_infor_gral.cdw_datos_01.Accepttext()
tab_1.tabpage_infor_gral.cdw_datos_01.setitem( tab_1.tabpage_infor_gral.cdw_datos_01.getrow( ) ,'precio_venta', dw.getitemdecimal( ll_fila, 'precio_venta'))
if ib_status=false then return 0
long ll_cod_insumo
 ll_cod_insumo=tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getitemnumber( tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getrow() , 'cod_producto')
if   isnull(ll_cod_insumo) then
	messagebox("SOFTPAN - DETALLE RECETAS", "Debe ingresar el campo codigo de Insumo")
	tab_1.SelectTab(2)
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setcolumn( 'cod_producto')
   RETURN(-1)
end if

long ll_cantidad
 ll_cantidad=tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getitemnumber( tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.getrow() , 'cantidad')
if   isnull(ll_cantidad) then
	messagebox("SOFTPAN - DETALLE RECETAS", "Debe ingresar el campo cantidad")
	tab_1.SelectTab(2)
	tab_1.tabpage_recetas_productos.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setfocus( )
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setcolumn( 'cantidad')
   RETURN(-1)
end if
return 0
end function

public function integer fn_tomar_valores_campos (datawindow v_dw_recetas, datawindow v_dw);long ll_fila,ll_fila_i
ll_fila=v_dw.getrow( )
ll_fila_i=v_dw_recetas.getrow()
v_dw_recetas.accepttext( )
v_dw.accepttext( )

/*tomando los valores de los productos*/
il_cod_producto=v_dw.getitemnumber( ll_fila,'cod_producto')
is_descripcion=v_dw.getitemstring( ll_fila,'descripcion')
il_cod_deposito=v_dw.getitemnumber( ll_fila,'cod_deposito')
il_cod_tipo_producto=v_dw.getitemnumber( ll_fila,'cod_tipo_producto')
il_cod_grupo=v_dw.getitemnumber( ll_fila,'cod_grupo')
il_tiene_stock=v_dw.getitemnumber( ll_fila,'tiene_stock')
il_cod_pais=v_dw.getitemnumber( ll_fila, 'cod_procedencia')
il_cod_tipo_iva=v_dw.getitemdecimal( ll_fila, 'cod_tipo_iva')
il_cod_estante=v_dw.getitemnumber( ll_fila, 'cod_estante')
il_cod_medida=v_dw.getitemnumber(ll_fila,'cod_medida')
il_cod_marca=v_dw.getitemnumber(ll_fila,'cod_marca')
id_porc_descuento=v_dw.getitemdecimal( ll_fila, 'porc_descuento')
idt_fecha_alta=v_dw.getitemdatetime(ll_fila, 'fecha_alta')
id_cantidad_actual=v_dw.getitemdecimal(ll_fila, 'cantidad_actual')
id_cantidad_max=v_dw.getitemdecimal(ll_fila, 'cantidad_maxima')
id_cantidad_min=v_dw.getitemdecimal(ll_fila, 'cantidad_minima')
il_en_oferta=v_dw.getitemnumber(ll_fila, 'en_oferta')
is_observaciones=v_dw.getitemstring(ll_fila, 'observaciones')
id_precio_venta=v_dw.getitemdecimal(ll_fila,'precio_venta')
il_tiene_receta=v_dw.getitemnumber(ll_fila,'tiene_receta')
il_estado=v_dw.getitemnumber(ll_fila,'estado')
il_activo_prod=v_dw.getitemnumber(ll_fila,'activo_produccion')
il_activo_compra=v_dw.getitemnumber(ll_fila,'activo_compra')
il_activo_venta=v_dw.getitemnumber(ll_fila,'activo_venta')
/*tomando los valores de las recetas*/
il_cod_receta=v_dw_recetas.getitemnumber( ll_fila_i,'cod_receta')
if isnull(il_cod_receta) or il_cod_receta=0 then il_cod_receta=0
is_modo_preparacion=v_dw_recetas.getitemstring( ll_fila_i,'modo_preparacion')
ls_descripcion_receta=v_dw_recetas.getitemstring( ll_fila_i,'descripcion_receta')
is_notas=v_dw_recetas.getitemstring( ll_fila_i,'notas')
id_porc_beneficio=v_dw_recetas.getitemdecimal( ll_fila_i,'porc_beneficio')
id_costo_mano_obra=v_dw_recetas.getitemdecimal( ll_fila_i,'costo_mano_obra')
id_costo_instalacion=v_dw_recetas.getitemdecimal( ll_fila_i,'costo_instalacion')
id_costo_total_insumos=v_dw_recetas.getitemdecimal( ll_fila_i,'costo_total_insumos')
id_costo_total=v_dw_recetas.getitemdecimal(ll_fila_i,'costo_total_producto')
id_precio_venta=v_dw_recetas.getitemdecimal(ll_fila_i,'precio_venta')
//id_precio_costo=v_dw_recetas.getitemdecimal(ll_fila_i,'precio_costo')


return 0
end function

public function integer fn_insertar_fk_detalle_receta ();long ll_filas_det,i
ll_filas_det=tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.rowcount( )
for i=1 to ll_filas_det
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.setitem(i, 'cod_receta', il_cod_receta)
next



return 0
end function

public function integer fn_inserta_detalle (datawindow dw_receta);long ll_filas_detalle,i,ll_cantidad_receta,ll_cod_producto_comp
decimal ld_precio_insumo
dw_receta.accepttext()
ll_filas_detalle=dw_receta.rowcount( )
//il_cod_receta=this.tab_1.tabpage_recetas_productos.cdw_datos_02.getitemnumber(tab_1.tabpage_recetas_productos.cdw_datos_02.getrow(), 'cod_receta')
/*Borra el detalle de las recetas para luego actualizar*/
//delete from detalle_recetas 
//where cod_receta=:il_cod_receta;
//
///*Procede a recargar el detalle de recetas*/
//ll_cod_producto_comp=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemnumber(tab_1.tabpage_recetas_productos.cdw_datos_02.getrow( ) ,'cod_producto')
//for i=1 to ll_filas_detalle
//	
//	ll_cantidad_receta=dw_receta.getitemnumber(i,'cantidad')
//	messagebox('',string(ll_cantidad_receta))
//	ld_precio_insumo=dw_receta.getitemdecimal(i,'precio_costo')
//	  INSERT INTO DETALLE_RECETAS  
//         ( cod_producto,   
//           cod_receta,   
//           cantidad,   
//           precio_costo )  
//  		VALUES ( :ll_cod_producto_comp,   
//           :il_cod_receta,   
//           :ll_cantidad_receta,   
//           :ld_precio_insumo )  ;
//			  
//	  if sqlca.sqlcode<>0 then
//		   rollback using sqlca;
//			return -1
//			messagebox('AAA','AAAA')
//	  end if
//	 
//	commit using sqlca;

long ll_cant
long ll_filas

messagebox('Codigo de receta',string(il_cod_receta))
for i=1 to ll_filas 
  dw_receta.setitem(i,'cod_receta',il_cod_receta)
next 
	
if dw_receta.update(True, False) = 1 then
						dw_receta.Resetupdate()
									commit using sqlca;	
						else
		
						rollback using sqlca;
//						if is_mensaje_error <> "" then
////						
//						end if
						dw_receta.RowsMove(1,1,delete!,dw_receta,1,primary!)
						dw_receta.SetRow(1)
						dw_receta.SetFocus()
						return -1
					end if


//		
	
//next
return 0
end function

public function integer fn_insertar_depositos (datawindow dw_dep);long i, ll_filas,ll_cod_deposito
ll_filas=dw_dep.rowcount()
decimal ld_stk_act,ld_stk_min
//delete from deposito_productos where cod_producto=:il_cod_producto;

//for i=1 to ll_filas 
//	ld_stk_act=dw_dep.getitemdecimal(i,'cantidad_actual')
//	ld_stk_min=dw_dep.getitemdecimal(i,'cantidad_minima')
//	ll_cod_deposito=dw_dep.getitemnumber(i,'cod_deposito')
//	
//	INSERT INTO DEPOSITO_PRODUCTOS  
//         ( cod_deposito,   
//           cod_producto,   
//           cantidad_actual,   
//           cantidad_minima,   
//           cantidad_maxima )  
// 	 VALUES ( :ll_cod_deposito,   
//             :il_cod_producto,   
//           	 :ld_stk_act,   
//           	 :ld_stk_min,   
//           null )  ;
//
//	if sqlca.sqlcode<>0 then
//		   rollback using sqlca;
//			return -1
//	  end if
//	next
long ll_cant
ll_cant=dw_dep.getitemnumber(dw_dep.getrow(),'cantidad_minima')
if ll_cant<0  or isnull(ll_cant) or trim(string(ll_cant))='' then
	messagebox('Aviso','Cantidad no puede ser negativa')
	dw_dep.setcolumn('cantidad_minima')
	dw_dep.setfocus()
	return -1
end if
for i=1 to ll_filas 
  dw_dep.setitem(i,'cod_producto',il_cod_producto)
next 
	
if dw_dep.update(True, False) = 1 then
						dw_dep.Resetupdate()
									commit using sqlca;	
						else
		
						rollback using sqlca;
						if is_mensaje_error <> "" then
//						
						end if
						dw_dep.RowsMove(1,1,delete!,dw_dep,1,primary!)
						dw_dep.SetRow(1)
						dw_dep.SetFocus()
						return -1
					end if




return 0

end function

on w_abm_productos.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cdw_imprimir=create cdw_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cdw_imprimir
end on

on w_abm_productos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.cdw_imprimir)
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
pb_cancelar.enabled=true

long ll_codigo
select min(cod_categoria) into :ll_codigo
from CATEGORIAS;
if isnull(ll_codigo) or ll_codigo = 0 then
	Messagebox('Aviso','No existen categorias definidas~rPrimero debera definir dicho dato')
//    this.tab_1.tabpage_infor_gral.cb_6.postevent( clicked!)
	return 
end if
//definiendo el grupo
long ll_cod_grupo
select min(cod_grupo) into :ll_cod_grupo
from GRUPO_PRODUCTO;

if isnull(ll_cod_grupo) or ll_cod_grupo=0 then
		Messagebox('Aviso','No existen Grupo de Productos definidos~rPrimero debera definir dicho dato')
//		 this.tab_1.tabpage_infor_gral.cb_7.postevent( clicked!)
	return
end if
//definiendo el pais
long ll_cod_pais
select min(cod_pais) into :ll_cod_pais
from PAISES;

if isnull(ll_cod_pais) or ll_cod_pais=0 then
		Messagebox('Aviso','No existen Paises definidos~rPrimero debera definir dicho dato')
//			 this.tab_1.tabpage_infor_gral.cb_5.postevent( clicked!)
	return
	 
end if

//definiendo el tipo de iva
long ll_tipo_iva
select min(cod_tipo_iva) into :ll_tipo_iva
from TIPO_IVA;

if isnull(ll_tipo_iva) or ll_tipo_iva=0 then
		Messagebox('Aviso','No existen Impuestos definidos~rPrimero debera definir dicho dato')
//		 this.tab_1.tabpage_infor_gral.cb_3.postevent( clicked!)
		return
	
end if

//definiendo la medida
long ll_cod_medida
select min(cod_medida) into :ll_cod_medida
from MEDIDAS;

if isnull(ll_cod_medida) or ll_cod_medida=0 then
		Messagebox('Aviso','No existen Medidas definidas~rPrimero debera definir dicho dato')
//		 this.tab_1.tabpage_infor_gral.cb_4.postevent( clicked!)
		return
end if
il_operacion=1

//seteando automaticamente los valores
long ll_fila_hoja_1
//almacenar en una variable la fila actual del dw de la hoja nro 1
ll_fila_hoja_1=this.tab_1.tabpage_infor_gral.cdw_datos_01.getrow()
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1, 'cod_tipo_iva', 3)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'fecha_alta', today())
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'estado', 0)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'cod_procedencia', 1)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'tiene_receta', 1)
this.tab_1.tabpage_infor_gral.cdw_datos_01.setitem( ll_fila_hoja_1,'tiene_stock', 1)
long ll_tiene_stock,ll_tiene_receta
ll_tiene_receta=this.tab_1.tabpage_infor_gral.cdw_datos_01.getitemnumber( ll_fila_hoja_1,'tiene_receta')
if ll_tiene_receta=1 then tab_1.tabpage_recetas_productos.enabled=true
ll_tiene_stock=tab_1.tabpage_infor_gral.cdw_datos_01.getitemnumber(  this.tab_1.tabpage_infor_gral.cdw_datos_01.getrow( ) , 'tiene_stock')
if ll_tiene_stock=1 then
	if tab_1.tabpage_infor_gral.cdw_deposito_productos.rowcount()=0 then
			tab_1.tabpage_infor_gral.cdw_deposito_productos.insertrow(0)
	end if
end if
if tab_1.tabpage_infor_gral.cdw_datos_01.getitemnumber(  this.tab_1.tabpage_infor_gral.cdw_datos_01.getrow( ) , 'tiene_receta')=1 then g_flag=1 else g_flag=0



end event

event open;ii_cant_claves = 1  //Cantidad de Claves

tab_1.tabpage_infor_gral.cdw_datos_01.SetTransObject(sqlca)
tab_1.tabpage_recetas_productos.cdw_datos_02.SetTransObject(sqlca)
tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.SetTransObject(sqlca)

tab_1.tabpage_infor_gral.cdw_deposito_productos.settransobject( sqlca)
tab_1.tabpage_infor_gral.cdw_deposito_productos.insertrow( 0)
tab_1.tabpage_infor_gral.cdw_deposito_productos.SetRowFocusIndicator(Hand!)

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
	tab_1.tabpage_infor_gral.cdw_deposito_productos.accepttext( )
	tab_1.tabpage_recetas_productos.cdw_datos_02.Accepttext()
	tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.Accepttext()
if fn_validar_campos_productos (tab_1.tabpage_infor_gral.cdw_datos_01  )= -1 then return
 if fn_validar_campos_recetas (tab_1.tabpage_recetas_productos.cdw_datos_02  )= -1 then return
	If messagebox("SOFTPAN","¿Esta seguro que desea actualizar éste registro?", Exclamation!, yesno!, 2)=2 then return
	if fn_tomar_valores_campos (tab_1.tabpage_recetas_productos.cdw_datos_02,tab_1.tabpage_infor_gral.cdw_datos_01)<>0 then return
		tab_1.tabpage_infor_gral.cdw_datos_01.accepttext( )
		g_flag=tab_1.tabpage_infor_gral.cdw_datos_01.getitemnumber(tab_1.tabpage_infor_gral.cdw_datos_01.getrow( ) , 'tiene_receta')
		//messagebox('',string(g_flag))
		choose case il_operacion
			case 1 /* alta*/
				/*long il_activo_prod,il_activo_compra,il_activo_venta*/
  		INSERT INTO PRODUCTOS  
         ( cod_producto,   
           descripcion,   
           cod_grupo,   
           cod_estante,   
           cod_tipo_iva,   
           cod_procedencia,   
           porc_descuento,   
           cod_medida,   
           cod_tipo_producto,   
           en_oferta,   
           precio_venta, 
			  precio_costo,
           inactivo,   
           fecha_alta,   
           dias_vigencia,   
           observaciones,   
           cod_marca,
           cantidad_actual,   
           cantidad_maxima,   
           cantidad_minima,   
           modo_preparacion,   
           notas,   
           tiene_receta,   
           cantidad_x_medida,
			  activo_produccion,
			  activo_compra,
			  activo_venta,
			  es_compuesto,
			  es_servicio,
			  tiene_stock)  
  			VALUES
  			( :il_cod_producto,   
           :is_descripcion,   
           :il_cod_grupo,   
           :il_cod_estante,   
           :il_cod_tipo_iva,   
           :il_cod_pais,   
           :id_porc_descuento,   
           :il_cod_medida,   
           :il_cod_tipo_producto,   
           :il_en_oferta,   
           :id_precio_venta, 
			  :id_precio_costo,
           :il_estado,   
           :idt_fecha_alta,   
           0,   
           :is_observaciones,   
           :il_cod_marca,
           :id_cantidad_actual,   
           :id_cantidad_max,   
           :id_cantidad_min,   
           null,   
           null,   
           :il_tiene_receta,   
           :id_cantidad_x_medida,
			  :il_activo_prod,
			  :il_activo_compra,
			  :il_activo_venta,
			  :ll_es_compuesto,
			  :ll_es_servicio,
			  :il_tiene_stock)  ;
			  
	if fn_insertar_depositos (tab_1.tabpage_infor_gral.cdw_deposito_productos)=-1 then return 
							  

						
//comiteando	
if g_flag=0 then
	if sqlca.sqlcode=0 then
			messagebox("AVISO","REGISTRO GUARDADO CON EXITO")
			commit using sqlca;
				pb_borrar.enabled=true
				pb_cancelar.visible=true
				pb_modificar.enabled=true
				pb_agregar.enabled=true
				pb_buscar.enabled=true
						
		else
			messagebox("AVISO",string(sqlca.sqlerrtext) )
			rollback using sqlca;
		end if
	
		return
	end if
	
	select isnull(max(cod_receta),0)+1 into :il_cod_receta
	from Recetas;

	INSERT INTO RECETAS  
         ( cod_receta, 
			  descripcion_receta,
           cod_producto,   
           modo_preparacion,   
           notas,   
           porc_beneficio,   
           costo_mano_obra,   
           costo_total_insumos,   
           costo_instalacion,   
           costo_total_producto,   
           precio_venta			 )  
 	 VALUES ( :il_cod_receta,
	  		  :ls_descripcion_receta,   
           :il_cod_producto, 
			  :is_modo_preparacion,   
           :is_notas,   
           :id_porc_beneficio,   
           :id_costo_mano_obra,   
           :id_costo_total_insumos,   
           :id_costo_instalacion,   
           :id_costo_total,   
           :id_precio_venta)  ;
			  
		
			  
		if sqlca.sqlcode=0 then
			
			commit using sqlca;
			if fn_inserta_detalle (tab_1.tabpage_recetas_productos.cdw_datos_detalle_02)=-1 then return
				messagebox("AVISO","REGISTRO GUARDADO CON EXITO")
				pb_borrar.enabled=true
				pb_cancelar.visible=true
				pb_modificar.enabled=true
				pb_agregar.enabled=true
				pb_buscar.enabled=true
						
		else
			messagebox("AVISO",string(sqlca.sqlerrtext) )
			rollback using sqlca;
		end if
		/*DANDO ALTA AL DETALLE DE RECETAS*/
		
	case 2 /*ACTUALIZACIONES*/
		
	tab_1.tabpage_recetas_productos.cdw_datos_02.accepttext( )
	il_cod_receta=this.tab_1.tabpage_recetas_productos.cdw_datos_02.getitemnumber(tab_1.tabpage_recetas_productos.cdw_datos_02.getrow(), 'cod_receta')
	
	
	
  	UPDATE PRODUCTOS  
     SET descripcion = : is_descripcion,   
         cod_grupo = : il_cod_grupo,   
         cod_estante = : il_cod_estante,   
         cod_tipo_iva = : il_cod_tipo_iva,   
         cod_procedencia = : il_cod_pais,   
         porc_descuento = : id_porc_descuento,   
         cod_medida = : il_cod_medida,   
         cod_tipo_producto = : il_cod_tipo_producto,   
         en_oferta = : il_en_oferta,   
         precio_venta = : id_precio_venta, 
			precio_costo=:id_precio_costo,
         inactivo = : il_estado,   
         fecha_alta = : idt_fecha_alta,   
         observaciones = : is_observaciones,
			cod_deposito=:il_cod_deposito,
         cantidad_actual = : id_cantidad_actual,   
         cantidad_maxima = : id_cantidad_max,   
         cantidad_minima = : id_cantidad_min,   
         tiene_receta = : il_tiene_receta,   
         cantidad_x_medida = : id_cantidad_x_medida,
			activo_produccion=:il_activo_prod,
			activo_compra=:il_activo_compra,
			activo_venta=:il_activo_venta,
			es_compuesto=:ll_es_compuesto,
			es_servicio=:ll_es_servicio,
			tiene_stock=:il_tiene_stock
	WHERE  cod_producto=:il_cod_producto;

//	if fn_insertar_depositos (tab_1.tabpage_infor_gral.cdw_deposito_productos)=-1 then return
	if g_flag=0 then 
					messagebox("Aviso",upper("Registro actualizado con exito"))
					commit using sqlca;
					pb_borrar.enabled=true
					pb_cancelar.visible=true
					pb_modificar.enabled=true
					pb_agregar.enabled=true
					pb_buscar.enabled=true
					return
					
		end if
		
//	
//	  UPDATE RECETAS  
//	   SET cod_receta=:il_cod_receta,  
//         cod_producto = :il_cod_producto, 
//			descripcion_receta=:ls_descripcion_receta,
//         modo_preparacion = :is_modo_preparacion,   
//         notas = :is_notas,   
//         porc_beneficio = :id_porc_beneficio,   
//         costo_mano_obra = :id_costo_mano_obra,   
//         costo_total_insumos = :id_costo_total_insumos,   
//         costo_instalacion = :id_costo_instalacion,   
//         costo_total_producto = :id_costo_total,   
//         precio_venta = :id_precio_venta
//	 WHERE cod_producto = :il_cod_producto ;
	
	//borrando las recetas del producto a modificar, cabecera y detalle
	//detalle
	delete from detalle_recetas where cod_receta=:il_cod_receta;
	delete from recetas  where cod_receta=:il_cod_receta;
	
	long ll_min
	select max(cod_receta) into:ll_min from recetas	where cod_producto=:il_cod_producto;
	messagebox('lmin',string(il_cod_producto))
	if isnull(ll_min) or ll_min=0 then il_cod_receta=il_cod_receta+1
	INSERT INTO RECETAS  
         ( cod_receta, 
			  descripcion_receta,
           cod_producto,   
           modo_preparacion,   
           notas,   
           porc_beneficio,   
           costo_mano_obra,   
           costo_total_insumos,   
           costo_instalacion,   
           costo_total_producto,   
           precio_venta			 )  
 	 VALUES ( :il_cod_receta,   
           :ls_descripcion_receta,
			  :il_cod_producto, 
           :is_modo_preparacion,   
           :is_notas,   
           :id_porc_beneficio,   
           :id_costo_mano_obra,   
           :id_costo_total_insumos,   
           :id_costo_instalacion,   
           :id_costo_total,   
           :id_precio_venta)  ;
			  
		
	messagebox('',string(sqlca.sqlerrtext)+'0002')
	//if fn_insertar_depositos (tab_1.tabpage_infor_gral.cdw_deposito_productos)=-1 then return
	
	  if sqlca.sqlcode=0 then
			messagebox("Aviso",upper("Registro actualizado con exito"))
			commit using sqlca;
			if fn_inserta_detalle (tab_1.tabpage_recetas_productos.cdw_datos_detalle_02)=-1 then return
			pb_borrar.enabled=true
			pb_cancelar.visible=true
			pb_modificar.enabled=true
			pb_agregar.enabled=true
			pb_buscar.enabled=true
		end if
		 if sqlca.sqlcode=1 then
			messagebox("Aviso",'No se pudo actualizar el registro~r'+string(sqlca.sqlerrtext) )
			rollback using sqlca;
		end if

end choose


	
	
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

type p_1 from w_abm_ancestor`p_1 within w_abm_productos
integer x = 2647
integer width = 763
end type

type pb_buscar from w_abm_ancestor`pb_buscar within w_abm_productos
integer x = 1577
integer y = 2028
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

type pb_cancelar from w_abm_ancestor`pb_cancelar within w_abm_productos
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

type pb_modificar from w_abm_ancestor`pb_modificar within w_abm_productos
integer x = 1632
integer taborder = 80
end type

event pb_modificar::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.getrow()>0 then
	tab_1.enabled=true
	tab_1.tabpage_infor_gral.cdw_datos_01.enabled=true
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()
	ii_borrado=1
	il_operacion=2
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

type pb_borrar from w_abm_ancestor`pb_borrar within w_abm_productos
integer x = 1170
integer taborder = 160
end type

type pb_guardar from w_abm_ancestor`pb_guardar within w_abm_productos
integer x = 713
integer taborder = 40
end type

type pb_agregar from w_abm_ancestor`pb_agregar within w_abm_productos
integer x = 256
integer taborder = 150
end type

type ole_skin from w_abm_ancestor`ole_skin within w_abm_productos
end type

type st_4 from w_abm_ancestor`st_4 within w_abm_productos
integer x = 2624
integer y = 2064
end type

type st_3 from w_abm_ancestor`st_3 within w_abm_productos
integer x = 2258
integer y = 2064
end type

type st_2 from w_abm_ancestor`st_2 within w_abm_productos
integer x = 1897
integer y = 2064
end type

type st_1 from w_abm_ancestor`st_1 within w_abm_productos
integer x = 1531
integer y = 2064
end type

type pb_cerrar from w_abm_ancestor`pb_cerrar within w_abm_productos
integer x = 2089
integer y = 2028
integer taborder = 130
end type

type btn_ultimo from w_abm_ancestor`btn_ultimo within w_abm_productos
integer x = 1161
integer y = 2040
integer height = 100
integer taborder = 90
end type

event btn_ultimo::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.rowcount()>0 then
	tab_1.tabpage_infor_gral.cdw_datos_01.scrolltorow(tab_1.tabpage_infor_gral.cdw_datos_01.rowcount())
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()
end if
	
end event

type btn_siguente from w_abm_ancestor`btn_siguente within w_abm_productos
integer x = 896
integer y = 2040
integer height = 100
integer taborder = 110
end type

event btn_siguente::clicked;if  tab_1.tabpage_infor_gral.cdw_datos_01.getrow()<> tab_1.tabpage_infor_gral.cdw_datos_01.rowcount() then
	 tab_1.tabpage_infor_gral.cdw_datos_01.scrollnextrow()
	 tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()

end if
end event

type btn_anterior from w_abm_ancestor`btn_anterior within w_abm_productos
integer x = 631
integer y = 2040
integer height = 104
integer taborder = 50
end type

event btn_anterior::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.getrow()>1 then
	tab_1.tabpage_infor_gral.cdw_datos_01.scrollpriorrow()
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()

end if
end event

type btn_primero from w_abm_ancestor`btn_primero within w_abm_productos
integer x = 366
integer y = 2040
integer height = 100
integer taborder = 60
end type

event btn_primero::clicked;if tab_1.tabpage_infor_gral.cdw_datos_01.rowcount()>0 then
	tab_1.tabpage_infor_gral.cdw_datos_01.scrolltorow(1)
	tab_1.tabpage_infor_gral.cdw_datos_01.setfocus()

end if
end event

type st_barra from w_abm_ancestor`st_barra within w_abm_productos
integer height = 2300
end type

type cdw_datos from w_abm_ancestor`cdw_datos within w_abm_productos
boolean visible = false
integer x = 3063
integer width = 91
integer height = 140
end type

event cdw_datos::constructor;//
end event

type gb_1 from w_abm_ancestor`gb_1 within w_abm_productos
integer x = 219
integer taborder = 30
end type

type gb_3 from w_abm_ancestor`gb_3 within w_abm_productos
integer x = 311
integer y = 1940
integer width = 1129
integer height = 256
integer taborder = 120
end type

type ln_1 from w_abm_ancestor`ln_1 within w_abm_productos
integer beginx = 3378
integer beginy = 1924
integer endx = 293
integer endy = 1920
end type

type tab_1 from tab within w_abm_productos
integer x = 283
integer y = 352
integer width = 3086
integer height = 1512
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
tabpage_historicos tabpage_historicos
end type

on tab_1.create
this.tabpage_infor_gral=create tabpage_infor_gral
this.tabpage_recetas_productos=create tabpage_recetas_productos
this.tabpage_historicos=create tabpage_historicos
this.Control[]={this.tabpage_infor_gral,&
this.tabpage_recetas_productos,&
this.tabpage_historicos}
end on

on tab_1.destroy
destroy(this.tabpage_infor_gral)
destroy(this.tabpage_recetas_productos)
destroy(this.tabpage_historicos)
end on

type tabpage_infor_gral from userobject within tab_1
integer x = 18
integer y = 120
integer width = 3049
integer height = 1376
long backcolor = 16777215
string text = "INFORMACION"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "Custom026!"
long picturemaskcolor = 536870912
string powertiptext = "Informacion sobre productos"
cdw_deposito_productos cdw_deposito_productos
cdw_datos_01 cdw_datos_01
end type

on tabpage_infor_gral.create
this.cdw_deposito_productos=create cdw_deposito_productos
this.cdw_datos_01=create cdw_datos_01
this.Control[]={this.cdw_deposito_productos,&
this.cdw_datos_01}
end on

on tabpage_infor_gral.destroy
destroy(this.cdw_deposito_productos)
destroy(this.cdw_datos_01)
end on

type cdw_deposito_productos from datawindow within tabpage_infor_gral
event ue_enter pbm_dwnprocessenter
event ue_presiona_tecla pbm_keydown
event ue_press_key pbm_dwnkey
event ue_borrar_detalle ( )
event ue_insertar_detalle ( )
integer x = 1481
integer y = 636
integer width = 1472
integer height = 444
integer taborder = 90
string dataobject = "dw_abm_deposito_productos"
boolean vscrollbar = true
end type

event ue_enter;if this.getrow( )=this.rowcount( ) then
		triggerevent('ue_insertar_detalle')
		//this.SetRowFocusIndicator(Hand!)

//else
//	Send(Handle(this),256,9,Long(0,0)) 
end if
end event

event ue_press_key;if keydown(KeyDelete!) then
		this.TriggerEvent("ue_borrar_detalle")
end if
end event

event ue_borrar_detalle();long V_fil_act , V_fil_det, aviso
//********************************************************************************************
aviso = MessageBox("Aviso", "Desea borrar este detalle?", Question!, YesNo!,1)
IF aviso = 1 THEN 
	this.DeleteRow(0)
	this.SetColumn(2) 
	V_fil_act = this.GetRow()
	IF V_fil_act > 0 THEN
		this.SetRow(V_fil_act)
	   this.SetFocus()

	//	this.TriggerEvent("ue_act_totales")
	END IF
	
//	if this.RowCount() < 1 then
//		cdw_datos_01.setitem(cdw_datos_01.getrow(),'tiene_stock',0)
//			this.TriggerEvent("ue_insertar_detalle")
//	end if	
END IF


end event

event ue_insertar_detalle();	this.InsertRow(0)
	this.setrow(this.rowcount( ))
	this.SetColumn(2)
	this.SetFocus()

end event

event constructor;//this.settransobject( sqlca)
//this.insertrow( 0)
//this.SetRowFocusIndicator(Hand!)
end event

event buttonclicked;choose case dwo.name
	case 'b_1'
		open(w_abm_depositos,w_abm_productos)
end choose
end event

event getfocus;if this.rowcount() = 0 then return
//Tipo de producto
	long ll_cod_depo
	
	datawindowchild dwc_recupera_deposito
	this.getchild('cod_deposito',dwc_recupera_deposito)
	dwc_recupera_deposito.settransobject(sqlca)
   dwc_recupera_deposito.retrieve( )
end event

type cdw_datos_01 from datawindow within tabpage_infor_gral
event ue_despues ( )
event ue_enter pbm_dwnprocessenter
integer x = 64
integer width = 2711
integer height = 1344
integer taborder = 20
string dataobject = "dw_abm_productos_cab_new"
boolean border = false
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
		this.accepttext( )
		long bl_tiene_receta
		bl_tiene_receta=this.getitemnumber(ii_row, is_colname)
		if bl_tiene_receta=1 then
			g_flag=1
		else
			g_flag=0
		end if
	
//		if bl_tiene_receta=1 then
//			tab_1.tabpage_recetas_productos.enabled=true
//		end if
//		if bl_tiene_receta=0 then
//			tab_1.tabpage_recetas_productos.enabled=false
//		end if	
		
		
	case 'inactivo'
		long ll_inactivo
		ll_inactivo=this.getitemnumber( ii_row, is_colname)
		if ll_inactivo=1 then
			this.setitem( ii_row, 'activo_compra', 0)
			this.setitem( ii_row, 'activo_venta', 0)
			this.setitem( ii_row, 'activo_produccion', 0)
		else
			this.setitem( ii_row, 'activo_compra', 1)
			this.setitem( ii_row, 'activo_venta', 1)
			this.setitem( ii_row, 'activo_produccion', 1)
		end if
	case 'tiene_stock' 
	long ll_tiene_stock 
	
	ll_tiene_stock=this.getitemnumber(ii_row, 'tiene_stock')
	if ll_tiene_stock=0 then
		cdw_deposito_productos.accepttext()
		//cdw_deposito_productos.enabled=false
		if isnull(cdw_deposito_productos.getitemnumber(cdw_deposito_productos.getrow(), 'cod_deposito')) or cdw_deposito_productos.getitemnumber(cdw_deposito_productos.getrow(), 'cod_deposito') >0 then
			messagebox('Aviso','Primero elimine el detalle y luego desactive el tilde')
			this.setitem( this.getrow(),'tiene_stock', 1)
			//cdw_deposito_productos.enabled=true
			return
		end if
		cdw_deposito_productos.deleterow( cdw_datos.rowcount())
	else
		if cdw_deposito_productos.rowcount()>0 then return
	//	cdw_deposito_productos.enabled=true
		if cdw_deposito_productos.rowcount()=0 then
			cdw_deposito_productos.insertrow(0)
		end if
	end if


			
end choose
end event

event ue_enter;Send(Handle(this),256,9,Long(0,0)) 
end event

event getfocus;if this.rowcount() = 0 then return
//Tipo de producto
	long ll_cod_tipo
	if this.getcolumnname( )='cod_tipo_producto' then ll_cod_tipo=this.getitemnumber( this.getrow(), 'cod_tipo_producto')
		datawindowchild dwc_recupera_tipo_producto
		this.getchild('cod_tipo_producto',dwc_recupera_tipo_producto)
		dwc_recupera_tipo_producto.settransobject(sqlca)
   	dwc_recupera_tipo_producto.retrieve( )
//Grupo de producto
		datawindowchild dwc_recupera_grupo
		long ll_cod_grupo
		string str_filter
		ll_cod_grupo=this.getitemnumber(this.getrow(),'cod_tipo_producto')
		
		this.getchild('cod_grupo',dwc_recupera_grupo)
		dwc_recupera_grupo.settransobject(sqlca)
		//dwc_recupera.setfilter( 'cod_categoria='+string(ll_cod_tipo))
		//dwc_recupera.filter( )
		dwc_recupera_grupo.retrieve( )

//Procedencia
		datawindowchild dwc_recupera_proc
		this.getchild('cod_procedencia',dwc_recupera_proc)
		dwc_recupera_proc.settransobject(sqlca)
		dwc_recupera_proc.retrieve( )
//Medida
			datawindowchild dwc_recupera_med
		this.getchild('cod_medida',dwc_recupera_med)
		dwc_recupera_med.settransobject(sqlca)
		dwc_recupera_med.retrieve( )
//Marcas
		datawindowchild dwc_recupera_mar
		this.getchild( 'cod_marca', dwc_recupera_mar)
		dwc_recupera_mar.settransobject(sqlca)
		dwc_recupera_mar.retrieve( )
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
		tab_1.tabpage_infor_gral.cdw_deposito_productos.retrieve(ll_clave)
	else
		ll_clave_02=tab_1.tabpage_recetas_productos.cdw_datos_02.getitemnumber( tab_1.tabpage_recetas_productos.cdw_datos_02.getrow(), 'cod_receta')
		if tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.retrieve(ll_clave_02)<=0 then
				   tab_1.tabpage_recetas_productos.cdw_datos_detalle_02.insertrow( 0)
		end if
	end if
	
	if tab_1.tabpage_infor_gral.cdw_deposito_productos.retrieve( ll_clave)<0 then return
		
	
end if





end event

event itemchanged;this.accepttext( )
string str_filter
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

event buttonclicked;accepttext()
choose case dwo.name
	case 'b_1'
		open(w_abm_categorias_productos,w_abm_productos)
	case 'b_2'
	   open(w_abm_grupo_producto,w_abm_productos)
	case 'b_3'
	   open(w_abm_estantes,w_abm_productos)
	case 'b_4'
	   open(w_abm_tipo_iva,w_abm_productos)
	case 'b_6'
	   open(w_abm_paises,w_abm_productos)
	case 'b_7'
	   open(w_abm_marcas,w_abm_productos)
 
	case 'b_5'
	   open(w_abm_medidas,w_abm_productos)
//	case else
//		open(w_abm_depositos,w_abm_productos)
end choose

end event

type tabpage_recetas_productos from userobject within tab_1
integer x = 18
integer y = 120
integer width = 3049
integer height = 1376
long backcolor = 16777215
string text = "RECETAS"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "MoveMode!"
long picturemaskcolor = 536870912
string powertiptext = "Recetas"
cb_1 cb_1
cb_quitar_detalle cb_quitar_detalle
cb_agregar_detalle cb_agregar_detalle
cdw_datos_detalle_02 cdw_datos_detalle_02
cdw_datos_02 cdw_datos_02
end type

on tabpage_recetas_productos.create
this.cb_1=create cb_1
this.cb_quitar_detalle=create cb_quitar_detalle
this.cb_agregar_detalle=create cb_agregar_detalle
this.cdw_datos_detalle_02=create cdw_datos_detalle_02
this.cdw_datos_02=create cdw_datos_02
this.Control[]={this.cb_1,&
this.cb_quitar_detalle,&
this.cb_agregar_detalle,&
this.cdw_datos_detalle_02,&
this.cdw_datos_02}
end on

on tabpage_recetas_productos.destroy
destroy(this.cb_1)
destroy(this.cb_quitar_detalle)
destroy(this.cb_agregar_detalle)
destroy(this.cdw_datos_detalle_02)
destroy(this.cdw_datos_02)
end on

type cb_1 from commandbutton within tabpage_recetas_productos
boolean visible = false
integer x = 2231
integer y = 948
integer width = 398
integer height = 96
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
boolean italic = true
string text = "Nuevo Insumo"
end type

event clicked;open(w_abm_insumos,w_abm_productos)
end event

type cb_quitar_detalle from commandbutton within tabpage_recetas_productos
boolean visible = false
integer x = 2222
integer y = 1052
integer width = 398
integer height = 96
integer taborder = 100
integer textsize = -8
integer weight = 400
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
boolean visible = false
integer x = 2217
integer y = 868
integer width = 398
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 400
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
event ue_press_key pbm_dwnkey
integer x = 82
integer y = 808
integer width = 2030
integer height = 560
integer taborder = 80
string title = "DETALLE DE INGREDIENTES"
string dataobject = "dw_abm_det_recetas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_despues();long ll_cod_producto_comp
	
	if is_colname='cod_producto' then
		decimal ld_precio_costo
		ll_cod_producto_comp=this.getitemnumber( ii_row, 'cod_producto')
		select precio_costo
		into :ld_precio_costo
		from Productos
		where cod_producto=:ll_cod_producto_comp;
		
		this.setitem( ii_row, 'precio_costo', ld_precio_costo)
		
	end if
	
	cdw_datos_02.setitem( cdw_datos_02.getrow(), 'costo_total_insumos',this.getitemdecimal(this.getrow(), 'total_insumos'))
	cdw_datos_02.setitem( cdw_datos_02.getrow(), 'costo_total_producto', cdw_datos_02.getitemdecimal( cdw_datos_02.getrow(), 'precio_costo_aux') )
	cdw_datos_02.setitem( cdw_datos_02.getrow(), 'precio_venta', cdw_datos_02.getitemdecimal( cdw_datos_02.getrow(), 'precio_venta_aux') )

end event

event ue_enter;Send(Handle(this),256,9,Long(0,0)) 
if this.getrow( )=this.rowcount( ) then
	long ll_cant
	SELECT count(*) into:ll_cant
    FROM productos,   
         grupo_producto  
   WHERE grupo_producto.cod_grupo = productos.cod_grupo 
			and grupo_producto.es_ingrediente=1;    
		if ll_cant=0 then
			messagebox('Aviso','Aun no existen ingredientes cargados')
			this.reset( )
			this.insertrow(0)
			this.enabled=false
			return 0
		end if
		tab_1.tabpage_recetas_productos.cb_agregar_detalle.triggerevent( clicked!)
		this.SetRowFocusIndicator(Hand!)

end if
end event

event ue_press_key;	if keydown(KeyDelete!) then
		tab_1.tabpage_recetas_productos.cb_quitar_detalle.triggerevent(clicked!)
	end if
	

end event

event itemchanged;this.accepttext( )
long ll_cant
	SELECT count(*) into:ll_cant
    FROM productos,   
         grupo_producto  
   WHERE grupo_producto.cod_grupo = productos.cod_grupo 
			and grupo_producto.es_ingrediente=1;    
		if ll_cant=0 then
			messagebox('Aviso','Aun no existen ingredientes cargados')
			this.reset( )
			this.insertrow(0)
			this.enabled=false
			return 0
		end if


	ii_row =row
   is_colname=dwo.name
	this.postevent("ue_despues")
end event

event getfocus;if this.rowcount() = 0 then return
long ll_cant
	SELECT count(*) into:ll_cant
    FROM productos,   
         grupo_producto  
   WHERE grupo_producto.cod_grupo = productos.cod_grupo 
			and grupo_producto.es_ingrediente=1;    
		if ll_cant=0 then
			messagebox('Aviso','Aun no existen ingredientes cargados')
			this.reset( )
			this.insertrow(0)
			return 0
		end if


end event

type cdw_datos_02 from datawindow within tabpage_recetas_productos
event type long ue_despues ( )
event ue_enter pbm_dwnprocessenter
integer x = 37
integer y = 20
integer width = 2839
integer height = 792
integer taborder = 80
string title = "COSTOS PRODUCTO"
string dataobject = "dw_abm_productos_costos_new"
boolean border = false
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

event buttonclicked;long i
if dwo.name='b_1' then
 for i=1 to 3
	messagebox('Probando','Probando.....')
 next

end if
end event

type tabpage_historicos from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 120
integer width = 3049
integer height = 1376
boolean enabled = false
long backcolor = 16777215
string text = "HISTORICOS"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "DatabaseProfile!"
long picturemaskcolor = 536870912
st_5 st_5
dw_1 dw_1
end type

on tabpage_historicos.create
this.st_5=create st_5
this.dw_1=create dw_1
this.Control[]={this.st_5,&
this.dw_1}
end on

on tabpage_historicos.destroy
destroy(this.st_5)
destroy(this.dw_1)
end on

type st_5 from statictext within tabpage_historicos
integer x = 1623
integer y = 444
integer width = 1326
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
boolean italic = true
boolean underline = true
long textcolor = 33554432
long backcolor = 8421376
string text = "Historico de Ventas"
alignment alignment = center!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within tabpage_historicos
integer x = 1623
integer y = 524
integer width = 1335
integer height = 744
integer taborder = 20
string title = "none"
string dataobject = "dw_historico_ventas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( sqlca)
this.insertrow( 0)
/*this.retrieve(tab_1.tabpage_infor_gral.cdw_datos_01.getitemnumber( 1, 'cod_producto') )*/
end event

type cdw_imprimir from datawindow within w_abm_productos
integer x = 197
integer y = 1292
integer width = 686
integer height = 400
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dw_imprimir_recetas"
boolean border = false
boolean livescroll = true
end type

event constructor;this.hide()
this.settransobject( sqlca)
end event


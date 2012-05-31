$PBExportHeader$w_abm_ventas_caja_nuevo.srw
forward
global type w_abm_ventas_caja_nuevo from window
end type
type st_2 from statictext within w_abm_ventas_caja_nuevo
end type
type pb_agregar from picturebutton within w_abm_ventas_caja_nuevo
end type
type pb_guardar from picturebutton within w_abm_ventas_caja_nuevo
end type
type pb_borrar from picturebutton within w_abm_ventas_caja_nuevo
end type
type pb_cerrar from picturebutton within w_abm_ventas_caja_nuevo
end type
type dw_busca from datawindow within w_abm_ventas_caja_nuevo
end type
type tab_1 from tab within w_abm_ventas_caja_nuevo
end type
type tabpage_1 from userobject within tab_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type cdw_prod_comp from datawindow within tabpage_1
end type
type cdw_pedidos from datawindow within tabpage_1
end type
type cdw_factura from datawindow within tabpage_1
end type
type cdw_serie from datawindow within tabpage_1
end type
type cdw_det from datawindow within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cdw_cab from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_3 cb_3
cdw_prod_comp cdw_prod_comp
cdw_pedidos cdw_pedidos
cdw_factura cdw_factura
cdw_serie cdw_serie
cdw_det cdw_det
cb_1 cb_1
cb_2 cb_2
cdw_cab cdw_cab
end type
type tabpage_2 from userobject within tab_1
end type
type cdw_ctas from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cdw_ctas cdw_ctas
end type
type tab_1 from tab within w_abm_ventas_caja_nuevo
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_cerrar from commandbutton within w_abm_ventas_caja_nuevo
end type
type dw_print from uo_datawindow within w_abm_ventas_caja_nuevo
end type
type st_1 from statictext within w_abm_ventas_caja_nuevo
end type
type st_menu from statictext within w_abm_ventas_caja_nuevo
end type
type gb_1 from groupbox within w_abm_ventas_caja_nuevo
end type
type r_1 from rectangle within w_abm_ventas_caja_nuevo
end type
end forward

global type w_abm_ventas_caja_nuevo from window
integer width = 3200
integer height = 2084
boolean titlebar = true
string title = "Punto de Venta"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = child!
long backcolor = 16777215
event ue_borrar ( )
event ue_parametros ( )
event ue_leer ( )
event ue_insertar ( )
event ue_buscar ( )
event ue_imprimir ( )
event ue_grabar ( )
event ue_recalc_det ( )
st_2 st_2
pb_agregar pb_agregar
pb_guardar pb_guardar
pb_borrar pb_borrar
pb_cerrar pb_cerrar
dw_busca dw_busca
tab_1 tab_1
cb_cerrar cb_cerrar
dw_print dw_print
st_1 st_1
st_menu st_menu
gb_1 gb_1
r_1 r_1
end type
global w_abm_ventas_caja_nuevo w_abm_ventas_caja_nuevo

type variables
Integer aviso
string valor, tipo_valor, grabar
string CodDet
long v_sec
double primer_precio
Integer v_alterando, v_barras
integer v_tecla_pulsada=0
integer v_farmacia
integer v_f3=0
long v_decimales
long vi_situacion=0
long vi_parsys_ventamaxitems
long vi_cant
long vi_fila
string vi_codigo
long vi_produc_pos
long vi_condicion
long v_vend
long vi_tipo_fiscal
string v_columna

uo_print iuo_print_fac
end variables

event ue_borrar;aviso = MessageBox("Aviso", "Desea borrar la transacción?", Question!, YesNo!,1)
IF aviso = 1 THEN 
	long fila_det
	long v_filas
	v_filas =tab_1.tabpage_1.cdw_det.RowCount()
	if tab_1.tabpage_1.cdw_det.RowCount() > 0 then
		for fila_det = 1 to v_filas
			tab_1.tabpage_1.cdw_det.DeleteRow(0)
		next
	end if		

		if tab_1.tabpage_1.cdw_det.update(true,false) > 0 then
			tab_1.tabpage_1.cdw_det.ResetUpdate()
			commit using sqlca;
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al grabar los detalles")
			return
		End IF	
	
		tab_1.tabpage_1.cdw_cab.DeleteRow(0)
		if tab_1.tabpage_1.cdw_cab.update(true,false) = 1 then
			tab_1.tabpage_1.cdw_cab.ResetUpdate()
			commit using sqlca;
			TriggerEvent("ue_insertar")
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al borrar la cabecera")
			return
		end if
End IF

end event

event ue_leer();tab_1.tabpage_1.cdw_det.accepttext()
long v_can_fil_cab, v_can_fil_det,v_can_fil_serie
//*******************************************************************************************
tipo_valor = tab_1.tabpage_1.cdw_cab.describe("#"+string(1)+".coltype") //1= col_clave_cab
valor = tab_1.tabpage_1.cdw_cab.Gettext()
//*******************************************************************************************
// Retrive Cabecera
if tipo_valor = "number" or left(tipo_valor,7)="decimal" then
	v_can_fil_cab = tab_1.tabpage_1.cdw_cab.retrieve(long(valor))
elseif left(tipo_valor,4)="char" then
	v_can_fil_cab = tab_1.tabpage_1.cdw_cab.retrieve(valor)
elseif tipo_valor ="date" then
	v_can_fil_cab = tab_1.tabpage_1.cdw_cab.retrieve(date(valor))
end if

// Si existe Cabecera

if v_can_fil_cab = 1 then
	secuencia_resta("Ventas", "Nro_reg", 0, 1, v_sec)
   v_alterando = 1
	tab_1.tabpage_1.cb_1.Enabled = false

	long v_moneda
	tab_1.tabpage_1.cdw_cab.accepttext()
	v_moneda = tab_1.tabpage_1.cdw_cab.getitemnumber(1, 'cod_moneda')	
	select cant_dec into :v_decimales from monedas where cod_moneda = :v_moneda;
	if isnull(v_decimales) then
		v_decimales = 5
	end if

	tab_1.tabpage_1.cdw_cab.TriggerEvent("ue_columna_12")
	tab_1.tabpage_1.cdw_cab.TriggerEvent("ue_columna_07")
	// Retrive Detalle
	if tipo_valor = "number" or left(tipo_valor,7)="decimal"  then
		v_can_fil_det = tab_1.tabpage_1.cdw_det.retrieve(long(valor))
  	elseif left(tipo_valor,4)="char" then
		v_can_fil_det = tab_1.tabpage_1.cdw_det.retrieve(valor)
	elseif tipo_valor ="date" then
		v_can_fil_det = tab_1.tabpage_1.cdw_det.retrieve(date(valor))
	end if
	
	triggerEvent("ue_recalc_det") 
	
			if v_can_fil_det > 0 then
				vi_situacion = 2
				commit using sqlca;
				//tab_1.tabpage_1.cdw_cab.Modify("cod_deposito.Protect=0") 	
				/*bloqueamos campos a fin de no permitir modificar la factura*/
				tab_1.tabpage_1.cdw_cab.modify( 'fecha.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'tipo_documen.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'ventas_cod_condicion.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_sucursal_cont.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_lugar.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'tipo_venta.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'fecha.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'entrega_inicial.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'cantidad_cuotas.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'inicio_vencimietos.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'dias.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_vendedor.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_cliente.protect=1')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_deposito.protect=1')
				tab_1.tabpage_1.cdw_det.enabled=false
		

			elseif v_can_fil_det = 0 then
				MessageBox("Aviso de Error","El documento no posee detalles!!")
				tab_1.tabpage_1.cdw_det.reset()
				tab_1.tabpage_1.cdw_det.insertrow(0)
				/*desbloqueamos el detalle de la venta*/
				tab_1.tabpage_1.cdw_det.enabled=true
			else
				Rollback using sqlca;
				MessageBox("Aviso","Error en la lectura del detalle")
			end if
	
elseif v_can_fil_cab = 0 then
				secuencia_resta("Ventas", "Nro_reg", 0, 1, v_sec)
				v_alterando = 0
				
				triggerEvent("ue_insertar")
				if tipo_valor="number" or left(tipo_valor,7)="decimal" then
					tab_1.tabpage_1.cdw_cab.SetItem(1,1,long(valor)) // 1= col_clave_cab
				elseif left(tipo_valor,4)="char" then
					tab_1.tabpage_1.cdw_cab.SetItem(1,1,valor) // 1= col_clave_cab
				elseif tipo_valor ="date" then
					tab_1.tabpage_1.cdw_cab.SetItem(1,1,date(valor)) // 1= col_clave_cab
				end if
	
		/*desbloqueamos campos a fin de no permitir modificar la factura*/
				tab_1.tabpage_1.cdw_cab.modify( 'fecha.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'tipo_documen.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'ventas_cod_condicion.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_sucursal_cont.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_lugar.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'tipo_venta.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'fecha.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'entrega_inicial.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'cantidad_cuotas.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'inicio_vencimietos.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'dias.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_vendedor.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_cliente.protect=0')
				tab_1.tabpage_1.cdw_cab.modify( 'cod_deposito.protect=0')
				tab_1.tabpage_1.cdw_det.enabled=true
	
else
	Rollback using sqlca;
	MessageBox("Aviso","Error en la lectura de la cabecera")
end if

tab_1.tabpage_1.cdw_cab.SetFocus()
grabar="0"


end event

event ue_insertar();select Medic into :v_farmacia	from par_sys;



if v_farmacia <> 1 then
	vg_nro_reg = double(ProfileString ( 'Ventas.txt', 'Ultima_venta', 'Nro_reg', '0' ))
	IF ProfileString( 'Ventas.txt', 'Ultima_venta', 'Cobrado', '1' ) = '0' THEN 
		messagebox('Atención...', 'La última venta no se cobró deberá cobrarla ahora, para ese vuelva a grabarla')
		tab_1.tabpage_1.cdw_cab.retrieve(vg_nro_reg)
		tab_1.tabpage_1.cdw_det.retrieve(vg_nro_reg)
		// Repintado Ctas del Cliente
		if tab_1.tabpage_1.cdw_cab.rowcount() > 0 then
			tab_1.tabpage_2.cdw_Ctas.retrieve(long(tab_1.tabpage_1.cdw_cab.Getitemnumber(1,"cod_cliente")))
			tab_1.tabpage_1.cdw_cab.Modify("cod_deposito.Protect=0") 		
		end if
		return
	End if

	IF ProfileString( 'Ventas.txt', 'Ultima_venta', 'Cobrado', '1' ) = '1'  AND ProfileString( 'Ventas.txt', 'Ultima_venta', 'Impreso', '1' ) = '0' THEN 
		aviso = MessageBox("Atención !!!", "La última venta se cobró pero no se imprimió desea imprimirla ahora...(" + string(vg_nro_reg) + ")?", Question!, YesNo!,1)
		IF aviso = 1 THEN 
			tab_1.tabpage_1.cdw_factura.retrieve(vg_nro_reg)
			tab_1.tabpage_1.cdw_factura.print()
			SetProfileString ( 'Ventas.txt', 'Ultima_venta', 'Impreso', '1' )
		end if
	end if
end if

v_farmacia=0

if v_farmacia = 1 then
	open(w_clave_vendedor)
	if vg_status=1 then
		this.hide( )
		cb_cerrar.postevent( clicked!)
		
	end if
end if	

v_alterando = 0
// Inserta Nuevo registro factura
tab_1.tabpage_1.cdw_Factura.reset()
tab_1.tabpage_1.cdw_Factura.insertrow(0)

// Inserta Nuevo registro Cab
tab_1.tabpage_1.cdw_cab.reset()
tab_1.tabpage_1.cdw_cab.insertrow(0)

// Inserta Nuevo registro Prod_Comp
tab_1.tabpage_1.cdw_prod_comp.reset()
tab_1.tabpage_1.cdw_prod_comp.insertrow(0)

//Inserta Nuevo registro Det
tab_1.tabpage_1.cdw_det.reset()
tab_1.tabpage_1.cdw_det.insertrow(0)
// Inserta Nuevo registro Serie
tab_1.tabpage_1.cdw_Serie.reset()
tab_1.tabpage_1.cdw_Serie.insertrow(0)

tab_1.tabpage_1.cdw_cab.SetColumn(1) 
tab_1.tabpage_1.cdw_cab.SetFocus()
grabar= "0"



//****
decimal v_reg

//v_reg = secuencia_suma("Ventas", "Nro_reg", 0, 1)
//v_sec = v_reg
//tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_reg", v_reg)

tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_reg", 0)
tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_factura", 0 )
tab_1.tabpage_1.cdw_cab.SetItem(1,"cod_cliente", 0 )
grabar = '0'

long v_doc, ll_cond,v_dep
v_doc = long( ProfileString("softpan.INI", vg_emp_cab, "CAJA", "1") )
ll_cond = long( ProfileString("softpan.INI", vg_emp_cab, "CONDICION", "1") )
v_dep = long( ProfileString("softpan.INI", vg_emp_cab, "DEPOSITO", "1") )

tab_1.tabpage_1.cdw_cab.setitem(1,"fecha",parsys_fecha_sys() )
tab_1.tabpage_1.cdw_cab.setitem(1,"ventas_Hora_venta", hora_sys() )
tab_1.tabpage_1.cdw_cab.setitem(1,"inicio_vencimietos",parsys_fecha_sys() )
tab_1.tabpage_1.cdw_cab.setitem(1,"iva_incluido",long(STRING(parsys_venivaincl() )) )
tab_1.tabpage_1.cdw_cab.setitem(1,"cod_moneda",long(STRING(parsys_codmoneda() )) )
tab_1.tabpage_1.cdw_cab.setitem(1,"cod_deposito",v_dep/*long(STRING(parsys_ventacoddeposito() ))*/ )
tab_1.tabpage_1.cdw_cab.setitem(1,"cod_lugar",long(STRING(parsys_ventacodlugar() )) )

if v_farmacia = 1 then
	tab_1.tabpage_1.cdw_cab.setitem(1,"cod_vendedor",vg_vendedor)
else
	tab_1.tabpage_1.cdw_cab.setitem(1,"cod_vendedor",long(STRING(parsys_ventacodvendedor() )) )
end if
tab_1.tabpage_1.cdw_cab.setitem(1,"ventas_cod_condicion",parsys_cod_condicion())
tab_1.tabpage_1.cdw_cab.setcolumn("cod_cliente")
tab_1.tabpage_1.cdw_cab.settext(STRING(parsys_ventacodcliente() ))
tab_1.tabpage_1.cdw_cab.setitem(1,"Tipo_documen", v_doc )
tab_1.tabpage_1.cdw_cab.setitem(1,"ventas_cod_condicion", ll_cond )
tab_1.tabpage_1.cdw_cab.TriggerEvent("ue_columna_12")

long v_TipoDoc, V_Topc, VCalImp
//*******************************************************************************************
	v_TipoDoc = long(STRING(parsys_ventatipoventa() ))
// ******************************************************************************************


	SELECT Tipo_Documentos.Tipo_Opcion,
	Tipo_Documentos.calc_imp
	INTO :v_Topc, :VCalImp
	FROM Tipo_Documentos 
	WHERE Tipo_Documentos.Tipo_Documen = :v_TipoDoc ;


If v_Topc = 0 then // Contado-Bloquea Campos
	tab_1.tabpage_1.cdw_cab.setitem(1,"cantidad_cuotas",1)
end if

tab_1.tabpage_1.cdw_cab.Modify("cod_sucursal_cont.Protect=1") 
tab_1.tabpage_1.cdw_cab.Modify("cod_deposito.Protect=1") 

// boton 
tab_1.tabpage_1.cb_1.Enabled = true

tab_1.tabpage_1.cdw_det.SetFocus()
tab_1.tabpage_1.cdw_det.SetColumn(2) 

vi_situacion = 4

v_decimales = 5
long v_moneda
v_moneda = tab_1.tabpage_1.cdw_cab.getitemnumber(1, 'cod_moneda')	
select cant_dec into :v_decimales from monedas where cod_moneda = :v_moneda;
if isnull(v_decimales) then
	v_decimales = 5
end if
long ll_suc, ll_dep
ll_dep = tab_1.tabpage_1.cdw_Cab.getItemNumber(1, "cod_deposito")
select cod_sucursal_contable into :ll_suc from depositos where cod_deposito=:ll_dep;
tab_1.tabpage_1.cdw_Cab.setItem(1, "cod_sucursal_cont", ll_suc)

end event

event ue_buscar();open(w_busca_fac_venta)
if vg_nro_reg > 0 then
   tab_1.tabpage_1.cdw_cab.retrieve(vg_nro_reg)
	tab_1.tabpage_1.cdw_det.retrieve(vg_nro_reg)
	// Repintado Ctas del Cliente
	tab_1.tabpage_2.cdw_Ctas.retrieve(long(tab_1.tabpage_1.cdw_cab.Getitemnumber(1,"cod_cliente")))
	//tab_1.tabpage_1.cdw_cab.Modify("cod_deposito.Protect=1") 		
end if
	
end event

event ue_imprimir;messagebox("nn","IMPRIMIR")
tab_1.tabpage_1.cdw_cab.print()
tab_1.tabpage_1.cdw_det.print()

end event

event ue_grabar();double v_nro_reg

	select Medic
	into :v_farmacia
	from par_sys;

if vi_situacion = 4 then
   if permisos(this.st_menu.text, 4) <> 1 then 
 		messagebox("Error de seguridad...", "No tiene permiso de agregar nuevos registros...")
		return
	end if
end if
if vi_situacion = 2 then
   if permisos(this.st_menu.text, 2) <> 1 then 
 		messagebox("Error de seguridad...", "No tiene permiso de modificar registros...")
		return
	end if
end if


tab_1.tabpage_1.cdw_cab.accepttext() 
tab_1.tabpage_1.cdw_det.accepttext() 

vg_nro_reg = tab_1.tabpage_1.cdw_cab.getitemnumber(1,"nro_reg")

//------ Actualiza Totales de Detalle y Cabecera -------------------------------------------------------
tab_1.tabpage_1.cdw_det.TriggerEvent("ue_elimina_nulos")
tab_1.tabpage_1.cdw_det.TriggerEvent("ue_actualiza_codigo")
this.TriggerEvent("ue_recalc_det")
tab_1.tabpage_1.cdw_det.TriggerEvent("ue_actualiza_totales")
//____________________________________________________________________________________________

//------ Actualiza Pedido a Entregado --------------------------------------------------------
for vg_fil_ped = 1 to tab_1.tabpage_1.cdw_pedidos.RowCount()
	 tab_1.tabpage_1.cdw_Pedidos.SetItem (vg_fil_ped, "pedidos_clientes_det_entregado" , 1)
next
if tab_1.tabpage_1.cdw_pedidos.update(true,false) > 0 then
	tab_1.tabpage_1.cdw_pedidos.ResetUpdate()
	commit using sqlca;	
end if
//____________________________________________________________________________________________
integer v_tipo

	aviso = MessageBox("Aviso", "Desea grabar la transacción?", Question!, YesNo!,1)
	
	IF aviso = 1 THEN 
		//Asigna nro factura	
   	v_tipo = tab_1.tabpage_1.cdw_cab.getitemnumber(1, "Tipo_documen")
	
	   	SELECT Tipo_documentos.Numeracion  into :vg_numeracion
		   FROM Tipo_documentos  
		  	WHERE Tipo_documentos.Tipo_documen = :v_tipo;			
			

/////////////////////// ***Coloca nro de registro**** //////////////////
		long v_cont
		if tab_1.tabpage_1.cdw_cab.getItemnumber(1, "nro_reg") = 0 then
				v_nro_reg=f_cursor('select max(nro_reg) from ventas')
				if isnull(v_nro_reg) then
					v_nro_reg = 0
				end if
				v_nro_reg = v_nro_reg +1
				vg_nro_reg = tab_1.tabpage_1.cdw_cab.getitemnumber(1,"nro_reg")
				tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_reg" , v_nro_reg)
			for v_cont = 1 to tab_1.tabpage_1.cdw_det.rowcount()
				tab_1.tabpage_1.cdw_det.SetItem (v_cont, "nro_reg" , v_nro_reg)
			next
			for v_cont = 1 to tab_1.tabpage_1.cdw_serie.rowcount()
				if not isnull(tab_1.tabpage_1.cdw_serie.getitemstring(v_cont, "nro_serie") ) then
					tab_1.tabpage_1.cdw_serie.SetItem (v_cont, "nro_reg" , v_nro_reg)
				end if
			next
		else
		 	v_nro_reg = tab_1.tabpage_1.cdw_cab.getItemnumber(1, "nro_reg")
		end if
		
		//Calcula nro de ticket************************************//
		long v_doc
		if tab_1.tabpage_1.cdw_cab.getItemnumber(1, "nro_factura") = 0 then

			v_doc = long( ProfileString("softpan.INI", vg_emp_cab, "CAJA", "1") )
			if v_farmacia = 1 then
				vg_factura_pos = v_nro_reg - 1
				tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_factura", (vg_factura_pos + 1) )
			else
				vg_factura_pos=f_cursor('select max(nro_factura) from ventas where Tipo_documen = '+string(v_tipo))
				vg_factura = tab_1.tabpage_1.cdw_cab.getitemnumber(1, "nro_factura")
				IF ISNULL(vg_factura_pos) THEN
					vg_factura_pos = 0 
				END IF	
			
		   	open(w_factura_pos)			
				tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_factura", vg_factura_pos )			
			end if

		end if
/////////////////////// ***Fin de coloca nro de registro**** //////////////////
	vg_nro_reg = tab_1.tabpage_1.cdw_cab.getitemnumber(1,"nro_reg")
		
	v_nro_reg=f_cursor('select max(nro_reg) from ventas')
	if isnull(v_nro_reg) then
			v_nro_reg = 0
	end if
		v_nro_reg = v_nro_reg +1			
		tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_reg" , v_nro_reg)
		for v_cont = 1 to tab_1.tabpage_1.cdw_det.rowcount()
			tab_1.tabpage_1.cdw_det.SetItem (v_cont, "nro_reg" , v_nro_reg)
		next

		if tab_1.tabpage_1.cdw_cab.update(true,false) = 1 then
			f_existe_padre('Nro_reg', 'Ventas' , tab_1.tabpage_1.cdw_cab.getitemnumber(1, 'Nro_reg'))
			if tab_1.tabpage_1.cdw_det.update(true,false) > 0 then
				if tab_1.tabpage_1.cdw_serie.update(true,false) > 0 then				
					if tab_1.tabpage_2.cdw_ctas.update(true,false) > 0 then
						tab_1.tabpage_1.cdw_cab.ResetUpdate()
						tab_1.tabpage_1.cdw_det.ResetUpdate()
						tab_1.tabpage_1.cdw_serie.ResetUpdate()
						tab_1.tabpage_2.cdw_ctas.ResetUpdate()
						commit using sqlca;	
					/*	update numeraciones_det with (ROWLOCK) set estado = 1
						where id_numeracion = :ll_numeracion and numero = :vg_factura_pos;
						if sqlca.sqlcode < 0 then
							messagebox('Atención...', 'Error al actualizar numeración...') 
							return
						end if
					*/							
				//	if v_farmacia = 1 then					
				//**************************************
				//IMPRESION DE fACTURA
				
				if vg_empresa = "PC_TRONIC" then
					string a3
					a3 = ""
					int b3
					SetNull(b3)
					long v_fil3
					tab_1.tabpage_1.cdw_factura.retrieve(tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"Nro_Reg"))
					for v_fil3 = 1 to (16 - tab_1.tabpage_1.cdw_det.rowcount())
						tab_1.tabpage_1.cdw_factura.RowsCopy (1, 1, Primary!, tab_1.tabpage_1.cdw_factura, (tab_1.tabpage_1.cdw_factura.rowcount()+1), Primary! )
						tab_1.tabpage_1.cdw_factura.setitem(tab_1.tabpage_1.cdw_factura.rowcount(),"productos_codigo",a3)
						tab_1.tabpage_1.cdw_factura.setitem(tab_1.tabpage_1.cdw_factura.rowcount(),"productos_descripcion_producto",a3)
						tab_1.tabpage_1.cdw_factura.setitem(tab_1.tabpage_1.cdw_factura.rowcount(),"ventas_det_unidades",b3)
						tab_1.tabpage_1.cdw_factura.setitem(tab_1.tabpage_1.cdw_factura.rowcount(),"ventas_det_precio",b3)
						tab_1.tabpage_1.cdw_factura.setitem(tab_1.tabpage_1.cdw_factura.rowcount(),"par_c",b3)								
					next
					tab_1.tabpage_1.cdw_factura.print()
					
			  	else
					if tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"facturado") = 0 then
						aviso = MessageBox("Atención !!!", "Desea imprimir la factura con número de registro: " + string(v_nro_reg) + "?", Question!, YesNo!,1)
						string ll
						ll= ProfileString("softpan.INI", vg_emp_cab, "IMPRIMIR_VENTA", "1")
							
						IF aviso = 1 and ProfileString("softpan.INI", vg_emp_cab, "IMPRIMIR_VENTA", "1") = '1' THEN 
						string v_archivo,ls_Emp_Input
						integer li_FileNum
						long ll_FLength,v_tip_doc,v_Topc, ll_calc_imp, aviso_desc,v_nro_factura
						v_tip_doc = tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"tipo_documen")
							
						if ProfileString("softpan.INI", vg_emp_cab, "EMPRESA", "1") = 'Interdenim_SACI' THEN
				   		f_printer(950, 10)
							v_nro_factura = 1
						end if					
						v_archivo = 'factura.prn'						
						select calc_imp into :ll_calc_imp from Tipo_documentos 
						where Tipo_documen = :v_tip_doc;	
						
							if lower(right(v_archivo, 3)) = 'prn' then
								if ll_calc_imp = 1 then
									IF v_nro_factura = 1 THEN
									   dw_print.dataobject = "dw_print_factura_ventas_caja"//"dw_print_factura_punto_venta"
									ELSE
										dw_print.dataobject = "dw_print_factura_ventas_caja_sin_pedido"
									END IF
								else
									dw_print.dataobject = "dw_print_factura_otras"
								end if	

									dw_print.SetTransObject(sqlca)
									dw_print.Retrieve(tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"Nro_Reg")/*,g_nombre,g_serie,g_origen,g_tabla*/)
									iuo_print_fac.of_print(v_archivo, dw_print, dw_print)									
							else
									ll_FLength = FileLength(v_archivo)
									li_FileNum = FileOpen(v_archivo, StreamMode!)
											IF ll_FLength < 32767 THEN
												FileRead(li_FileNum, ls_Emp_Input)
											END IF
									FileClose(li_FileNum)
									//RECUPERAR DATOS DE CLIENTE APRA IMPRIMIR
									
									tab_1.tabpage_1.cdw_factura.Create(ls_Emp_Input)
									tab_1.tabpage_1.cdw_factura.SetTransObject(sqlca)
									tab_1.tabpage_1.cdw_factura.Retrieve(tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"Nro_Reg"))
									IF aviso_desc = 1 THEN 	
										tab_1.tabpage_1.cdw_factura.Modify("Tex1.Visible=1") 
										tab_1.tabpage_1.cdw_factura.Modify("Tex2.Visible=1")
									else
										tab_1.tabpage_1.cdw_factura.Modify("Tex1.Visible=0") 
										tab_1.tabpage_1.cdw_factura.Modify("Tex2.Visible=0")
									end if
								tab_1.tabpage_1.cdw_factura.print()
						end if												
				tab_1.tabpage_1.cdw_cab.SetItem (1, "facturado" , 1)				
			/*----------------------------------------------------*/
						end if
					end if
				END IF
				//**************************************
				if ProfileString("softpan.INI", vg_emp_cab, "COBRO_AUTOMATICO", "1") = '1' THEN 
						open(w_abm_cobros_caja_punto)
				end if
						
						post TriggerEvent("ue_insertar")
						st_1.text='Ult.reg: ' + string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"nro_reg"))
					else
						Rollback using sqlca;
						aviso = MessageBox("Atención !!!","No existen detalles a ser Grabados en Ctas.", StopSign!, ok!,1)
					end if
				else
					Rollback using sqlca;
					aviso = MessageBox("Atención !!!","No existen detalles a ser Grabados en Series.", StopSign!, ok!,1)
				end if			
			else
				Rollback using sqlca;
				aviso = MessageBox("Atención !!!","No existen detalles a ser Grabados.", StopSign!, ok!,1)
			end if
	
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al grabar la cabecera")
			v_nro_reg=f_cursor('select max(nro_reg) from ventas')
			if isnull(v_nro_reg) then
				v_nro_reg = 0
			end if
			v_nro_reg = v_nro_reg +1			
			tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_reg" , v_nro_reg)
			for v_cont = 1 to tab_1.tabpage_1.cdw_det.rowcount()
				tab_1.tabpage_1.cdw_det.SetItem (v_cont, "nro_reg" , v_nro_reg)
			next
			open(w_factura_pos)			
			tab_1.tabpage_1.cdw_cab.SetItem(1, "nro_factura", vg_factura_pos )			
			tab_1.tabpage_1.cdw_cab.SetFocus()	
		end if
		grabar="0"
	else
		for vg_fil_ped = 1 to tab_1.tabpage_1.cdw_pedidos.RowCount()
			// Actualiza Pedido Entregado
			tab_1.tabpage_1.cdw_Pedidos.SetItem (vg_fil_ped, "pedidos_clientes_det_entregado" , 0)
		next
		// Graba Pedidos
		if tab_1.tabpage_1.cdw_pedidos.update(true,false) > 0 then
			tab_1.tabpage_1.cdw_pedidos.ResetUpdate()
			commit using sqlca;	
		end if
	end if	
	//tab_1.tabpage_1.cdw_cab.Modify("Cod_moneda.Protect=0") 
	tab_1.tabpage_1.cdw_cab.Modify("Cod_cliente.Protect=0") 
	tab_1.tabpage_1.cdw_cab.SetFocus()

end event

event ue_recalc_det();long V_fil_det
string V_CodProd
double v_iva , v_ivainv
double V_TotCos_b1
double V_TotCos_a,V_TotCos_b
double V_TotUnid, V_TotPrec
long V_CodReg, V_TipFis
double V_TotCos ,V_TotPre, V_TotImp

string v_CodCli, v_Descrip, v_UnidProd 
double v_precio_costo, v_lista_precio
integer v_TipoFiscal

v_CodCli = string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,7))
for V_fil_det = 1 to tab_1.tabpage_1.cdw_det.RowCount()
    V_CodReg = 0
	 V_TipFis = 0
    V_TotCos = 0
    V_TotPre = 0
	 V_TotImp = 0
	 V_CodProd = tab_1.tabpage_1.cdw_det.getitemstring(V_fil_det,"codigo")
			
		 //***	Define Iva de Producto
	SELECT Productos.imp_imp
   INTO :v_iva
	FROM Productos 
   WHERE Productos.Codigo = :V_CodProd;
	

	 v_ivainv = v_iva / 100 + 1

		
		//Define Datos de Productos
	SELECT Productos.Descripcion_producto, 
	Productos.Unidad, 
	productos.Tipo_fiscal,
	productos.precio_costo
	INTO :v_Descrip, 
	:v_UnidProd,	
	:v_TipoFiscal,
	:v_precio_costo
	FROM Productos 
	WHERE Productos.Codigo = :v_CodProd ;
	
	 
    V_CodReg = long(tab_1.tabpage_1.cdw_Cab.getitemNumber(1,1))
	//Actualiza campos con los valores corresp.
   tab_1.tabpage_1.cdw_det.SetItem (V_fil_det, "ventas_det_precio_neto" , cambiar(precio_cliente(long(v_CodCli),vi_condicion, v_CodProd), tab_1.tabpage_1.cdw_cab.getitemdatetime(1,"fecha"), parsys_codmoneda(), tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_moneda"), 0))
   tab_1.tabpage_1.cdw_det.SetItem (V_fil_det, "productos_Tipo_fiscal" , v_Tipofiscal)
   tab_1.tabpage_1.cdw_det.SetItem (V_fil_det, "productos_precio_costo" , v_precio_costo)
	
	
	// Actualiza Campos	
   tab_1.tabpage_1.cdw_det.SetItem(V_fil_det, "nro_reg", V_CodReg) 
   tab_1.tabpage_1.cdw_det.SetItem(V_fil_det, "ventas_det_tipo_fiscal", V_TipFis) 
   tab_1.tabpage_1.cdw_det.SetItem(V_fil_det, "unidades_credito", 0) 
	
	tab_1.tabpage_1.cdw_det.TriggerEvent("ue_actualiza_detalle")
   
next




end event

event open;long v_bloqueo
f_centrar_ventana(this)
v_bloqueo = long( ProfileString("softpan.ini", vg_emp_cab, "BLOQUEO_CLIENTE", "0") )
if v_bloqueo = 1 then
   tab_1.tabpage_1.cdw_cab.dataobject = "dw_abm_ventas_caja_bloqueado_nuevo"//"dw_abm_ventas_caja_bloqueado"
end if
v_alterando = 0


tab_1.tabpage_1.cdw_cab.SetTransObject(sqlca)
tab_1.tabpage_1.cdw_det.SetTransObject(sqlca)
tab_1.tabpage_2.cdw_ctas.SetTransObject(sqlca)
tab_1.tabpage_1.cdw_prod_comp.SetTransObject(sqlca)
tab_1.tabpage_1.cdw_serie.SetTransObject(sqlca)
tab_1.tabpage_1.cdw_Factura.SetTransObject(sqlca)
tab_1.tabpage_1.cdw_Pedidos.SetTransObject(sqlca)

vi_parsys_ventamaxitems = parsys_ventamaxitems()


dw_print.SetTransObject(sqlca)
iuo_print_fac = create uo_print

v_bloqueo = long( ProfileString("softpan.INI", vg_emp_cab, "BLOQUEO", "0") )
if v_bloqueo = 1 then
	tab_1.tabpage_1.cdw_cab.enabled = false
else
	tab_1.tabpage_1.cdw_cab.enabled = True	
end if

// Carga parametro Cliente Asociacion*****

DataWindowChild cdw_CliAso
tab_1.tabpage_1.cdw_Cab.GetChild("cod_aso", cdw_CliAso)
cdw_CliAso.SetTransObject(SQLCA)
cdw_CliAso.InsertRow(0)
tab_1.tabpage_1.cdw_cab.Modify("Cod_aso.Protect=1") 
tab_1.tabpage_1.cdw_cab.Modify("Cod_aso.Background.COLOR='128128128'")    

if parsys_ventamoddesc() = 0 then
	tab_1.tabpage_1.cdw_det.Modify("desc_ven.Protect=1") 
end if
if parsys_ventamodprec() = 0 then
	tab_1.tabpage_1.cdw_det.Modify("precio.Protect=1") 
end if

// Pedidos
tab_1.tabpage_1.cb_1.Enabled = false
tab_1.tabpage_1.cdw_factura.SetTransObject(sqlca)

triggerevent("ue_insertar")
grabar= "0"
v_barras = 0

tab_1.tabpage_1.cdw_det.SetFocus()
tab_1.tabpage_1.cdw_det.SetColumn(2) 
long a
a = parsys_ventarepprod()

select LIMIT_PRODUC_POS into :vi_produc_pos from par_sys;


end event

event close;if grabar = "1" then
	aviso = MessageBox("Aviso", "Desea grabar los cambios?", Question!, YesNoCancel!,1)
	IF aviso = 1 THEN 
		triggerevent("ue_grabar")
	ELSE
		secuencia_resta("Ventas", "Nro_reg", 0, 1, v_sec)
	END IF
else
	secuencia_resta("Ventas", "Nro_reg", 0, 1, v_sec)//tab_1.tabpage_1.cdw_cab.getitemnumber(1,"Nro_reg"))
end if	
	
end event

on w_abm_ventas_caja_nuevo.create
this.st_2=create st_2
this.pb_agregar=create pb_agregar
this.pb_guardar=create pb_guardar
this.pb_borrar=create pb_borrar
this.pb_cerrar=create pb_cerrar
this.dw_busca=create dw_busca
this.tab_1=create tab_1
this.cb_cerrar=create cb_cerrar
this.dw_print=create dw_print
this.st_1=create st_1
this.st_menu=create st_menu
this.gb_1=create gb_1
this.r_1=create r_1
this.Control[]={this.st_2,&
this.pb_agregar,&
this.pb_guardar,&
this.pb_borrar,&
this.pb_cerrar,&
this.dw_busca,&
this.tab_1,&
this.cb_cerrar,&
this.dw_print,&
this.st_1,&
this.st_menu,&
this.gb_1,&
this.r_1}
end on

on w_abm_ventas_caja_nuevo.destroy
destroy(this.st_2)
destroy(this.pb_agregar)
destroy(this.pb_guardar)
destroy(this.pb_borrar)
destroy(this.pb_cerrar)
destroy(this.dw_busca)
destroy(this.tab_1)
destroy(this.cb_cerrar)
destroy(this.dw_print)
destroy(this.st_1)
destroy(this.st_menu)
destroy(this.gb_1)
destroy(this.r_1)
end on

event activate;//if this.st_menu.text = 'none' then
//   this.st_menu.text = vg_menu
//end if
//if permisos(this.st_menu.text, 3) = 1 then 
//	m_menu.m_editar.m_borrar.enabled = true
//	m_menu.m_editar.m_borrar.visible = true
//else
//	m_menu.m_editar.m_borrar.enabled = false
//	m_menu.m_editar.m_borrar.visible = false
//end if
//
//if permisos(this.st_menu.text, 4) = 1 and permisos(this.st_menu.text, 2) = 1 then 
//	m_menu.m_editar.m_grabar.enabled = true
//	m_menu.m_editar.m_grabar.visible = true
//else
//	m_menu.m_editar.m_grabar.enabled = false
//	m_menu.m_editar.m_grabar.visible = false
//end if
//
//if permisos(this.st_menu.text, 4) <> permisos(this.st_menu.text, 2) then 
//	m_menu.m_editar.m_grabar.enabled = true
//	m_menu.m_editar.m_grabar.visible = true
//end if

end event

type st_2 from statictext within w_abm_ventas_caja_nuevo
boolean visible = false
integer x = 1481
integer y = 1988
integer width = 119
integer height = 116
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type pb_agregar from picturebutton within w_abm_ventas_caja_nuevo
integer x = 526
integer y = 1800
integer width = 430
integer height = 140
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "       &INSERTAR"
string picturename = "..\Imagenes\cmd_aceptar_enabled.bmp"
string disabledname = "..\Imagenes\cmd_aceptar_disabled.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;parent.triggerevent( 'ue_insertar')
end event

type pb_guardar from picturebutton within w_abm_ventas_caja_nuevo
integer x = 969
integer y = 1800
integer width = 430
integer height = 140
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "        &GUARDAR"
string picturename = "..\Imagenes\cmd_guardar_enabled.bmp"
string disabledname = "..\Imagenes\cmd_guardar_disabled.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;parent.triggerevent( 'ue_grabar')
end event

type pb_borrar from picturebutton within w_abm_ventas_caja_nuevo
integer x = 1463
integer y = 1800
integer width = 430
integer height = 140
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "        &ELIMINAR"
string picturename = "..\Imagenes\cmd_eliminar_enabled.bmp"
string disabledname = "..\Imagenes\cmd_eliminar_disabled.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;parent.triggerevent( 'ue_borrar')
end event

type pb_cerrar from picturebutton within w_abm_ventas_caja_nuevo
integer x = 1957
integer y = 1800
integer width = 439
integer height = 140
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "     CE&RRAR"
string picturename = "..\Imagenes\cmd_cerrar_enabled.bmp"
string disabledname = "..\Imagenes\cmd_cerrar_disabled.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;if grabar = "1" then
	aviso = MessageBox("Aviso", "Desea salir sin grabar los cambios?", Question!, YesNoCancel!,1)
	IF aviso = 2 THEN 
		return
	END IF
	IF aviso = 3 THEN 
		return
	END IF
	IF aviso = 1 THEN 
		close(parent)
	END IF
else
	close(parent)
end if	


end event

type dw_busca from datawindow within w_abm_ventas_caja_nuevo
boolean visible = false
integer x = 2066
integer y = 1436
integer width = 256
integer height = 236
integer taborder = 20
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tab_1 from tab within w_abm_ventas_caja_nuevo
integer x = 174
integer y = 16
integer width = 2939
integer height = 1752
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2903
integer height = 1632
long backcolor = 16777215
string text = "Punto de Venta-POS"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
cb_3 cb_3
cdw_prod_comp cdw_prod_comp
cdw_pedidos cdw_pedidos
cdw_factura cdw_factura
cdw_serie cdw_serie
cdw_det cdw_det
cb_1 cb_1
cb_2 cb_2
cdw_cab cdw_cab
end type

on tabpage_1.create
this.cb_3=create cb_3
this.cdw_prod_comp=create cdw_prod_comp
this.cdw_pedidos=create cdw_pedidos
this.cdw_factura=create cdw_factura
this.cdw_serie=create cdw_serie
this.cdw_det=create cdw_det
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cdw_cab=create cdw_cab
this.Control[]={this.cb_3,&
this.cdw_prod_comp,&
this.cdw_pedidos,&
this.cdw_factura,&
this.cdw_serie,&
this.cdw_det,&
this.cb_1,&
this.cb_2,&
this.cdw_cab}
end on

on tabpage_1.destroy
destroy(this.cb_3)
destroy(this.cdw_prod_comp)
destroy(this.cdw_pedidos)
destroy(this.cdw_factura)
destroy(this.cdw_serie)
destroy(this.cdw_det)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cdw_cab)
end on

type cb_3 from commandbutton within tabpage_1
integer x = 937
integer y = 752
integer width = 457
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "&Imprimir Factura"
end type

event clicked;long v_reg,v_nro_factura
v_reg =tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"nro_reg")
if v_reg > 0 then
	aviso = MessageBox("Aviso", "Desea Imprimir la Factura ?", Question!, YesNo!,1)
	IF aviso = 1 and ProfileString("softpan.INI", vg_emp_cab, "IMPRIMIR_VENTA", "1") = '1' THEN 

			string v_archivo
			integer li_FileNum
			string ls_Emp_Input
			long ll_FLength		
			long v_tip_doc,v_Topc, ll_calc_imp, aviso_desc
					
					v_tip_doc = tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"tipo_documen")
					if ProfileString("softpan.INI", vg_emp_cab, "EMPRESA", "1") = 'Interdenim_SACI' THEN
				   	f_printer(950, 10)
						v_nro_factura = 1
					end if
					v_archivo = 'factura.prn'						
						select calc_imp into :ll_calc_imp from Tipo_documentos where Tipo_documen = :v_tip_doc;										 	
							if lower(right(v_archivo, 3)) = 'prn' then
								if ll_calc_imp = 1 then
									IF v_nro_factura = 1 THEN
									   dw_print.dataobject = "dw_print_factura_ventas_caja"//"dw_print_factura_punto_venta"
									ELSE
										dw_print.dataobject = "dw_print_factura_ventas_caja_sin_pedido"
									END IF
								else
									dw_print.dataobject = "dw_print_factura_otras"
								end if								
									dw_print.SetTransObject(sqlca)
									dw_print.Retrieve(tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"Nro_Reg"))
									iuo_print_fac.of_print(v_archivo, dw_print, dw_print)
							else
									ll_FLength = FileLength(v_archivo)
									li_FileNum = FileOpen(v_archivo, StreamMode!)
											IF ll_FLength < 32767 THEN
												FileRead(li_FileNum, ls_Emp_Input)
											END IF
									FileClose(li_FileNum)
									tab_1.tabpage_1.cdw_factura.Create(ls_Emp_Input)
									tab_1.tabpage_1.cdw_factura.SetTransObject(sqlca)
									tab_1.tabpage_1.cdw_factura.Retrieve(tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"Nro_Reg"))
									IF aviso_desc = 1 THEN 	
										tab_1.tabpage_1.cdw_factura.Modify("Tex1.Visible=1") 
										tab_1.tabpage_1.cdw_factura.Modify("Tex2.Visible=1")
									else
										tab_1.tabpage_1.cdw_factura.Modify("Tex1.Visible=0") 
										tab_1.tabpage_1.cdw_factura.Modify("Tex2.Visible=0")
									end if
								tab_1.tabpage_1.cdw_factura.print()
						end if											
			
			end if	
	end if
end event

type cdw_prod_comp from datawindow within tabpage_1
boolean visible = false
integer x = 1266
integer y = 1488
integer width = 219
integer height = 112
integer taborder = 60
string dataobject = "dw_abm_productos_compuestos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cdw_pedidos from datawindow within tabpage_1
boolean visible = false
integer x = 494
integer y = 1244
integer width = 2656
integer height = 228
integer taborder = 60
string dataobject = "dw_abm_pedidos_clientes_detalle"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cdw_factura from datawindow within tabpage_1
boolean visible = false
integer x = 1531
integer y = 1416
integer width = 210
integer height = 156
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_print_factura1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cdw_serie from datawindow within tabpage_1
event ue_insertar_serie pbm_dwnprocessenter
event ue_tecla_pulsada pbm_dwnkey
event ue_borrar_detalle ( )
event ue_columna_03 ( )
boolean visible = false
integer x = 1024
integer y = 1492
integer width = 215
integer height = 136
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_abm_prod_series_sal"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_insertar_serie;if this.getcolumn() = 3  then
	cdw_serie.InsertRow(0)
	cdw_serie.SetColumn(3) 
end if

grabar="1"

end event

event ue_tecla_pulsada;if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
elseif keydown(keyf4!) then
	fn_releer_lista(this)
elseif keydown(keyf12!) then
   cdw_serie.triggerEvent("ue_borrar_detalle")
end if
end event

event ue_borrar_detalle;long V_fil_act , V_fil_det
//********************************************************************************************
aviso = MessageBox("Aviso", "Desea borrar este detalle?", Question!, YesNo!,1)
IF aviso = 1 THEN 
	if cdw_serie.RowCount() > 1 then
		cdw_serie.DeleteRow(0)
		cdw_serie.SetColumn(3) // 3= primer campo disponible en det
		V_fil_act = cdw_serie.GetRow()
		cdw_serie.SetRow(V_fil_act)
		cdw_serie.SetFocus()
	else
		MessageBox("Aviso de Error","No se puede eliminar el último detalle")
	end if
END IF

end event

event ue_columna_03;parent.cdw_cab.accepttext() 
parent.cdw_det.accepttext() 

Long v_NroReg
//******************************************************************************************
v_NroReg = cdw_cab.getitemnumber(1,1)
//******************************************************************************************
  
//Actualiza campos con los valores corresp.
THIS.SetItem (getrow(), "Nro_Reg" , v_NroReg)
THIS.SetItem (getrow(), "Codigo" , CodDet)




end event

event editchanged;grabar="1"
end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)
end event

event itemchanged;	cdw_serie.TriggerEvent("ue_columna_03")
end event

type cdw_det from datawindow within tabpage_1
event ue_columna_02 ( )
event ue_columna_03 ( )
event ue_columna_05 ( )
event ue_columna_06 ( )
event ue_tecla_pulsada pbm_dwnkey
event ue_borrar_detalle ( )
event ue_insertar_detalle pbm_dwnprocessenter
event ue_actualiza_totales ( )
event ue_actualiza_detalle ( )
event ue_elimina_nulos ( )
event ue_insertar_detalle_manual ( )
event ue_actualiza_codigo ( )
event ue_cob_barra ( )
integer x = 37
integer y = 940
integer width = 2821
integer height = 648
integer taborder = 30
string dataobject = "dw_abm_ventas_detalle_caja"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_columna_02();cdw_cab.accepttext() 
cdw_det.accepttext() 
string v_CodCli, v_CodProd, v_Descrip, v_UnidProd 
double v_Stock
double v_precio_costo, v_lista_precio, v_Matriz_desc, v_porc_gravado, v_imp_imp, v_precio
double v_precio_lista, ll_porc_vend_prod
string ll_porc_tipo
long v_promo, v_seccion, v_seccion_parsys, row, V_fil_act, V_CodDep, v_codmon
integer v_TipoFiscal, v_CovVend
v_CodProd = trim(THIS.Gettext ())
// Busca Codigos Repetidos
long V_fil_det , band, v_Ac
string v_MiProd
band = 0 
v_ac = 0
row = this.getrow()
if cdw_det.RowCount() > 0 then
	for V_fil_det = 1 to this.RowCount()
		v_MiProd = this.GetItemstring(V_fil_det,"codigo") 
		if v_CodProd = v_MiProd then
			v_ac = v_ac + 1
			if v_ac = 2 then
				if parsys_ventarepprod() = 0 then
					band = 1
    				exit
				end if
			end if
		end if
	next
end if
if band = 1 then
	aviso = MessageBox("Aviso", "Ya existe Codigo Ingresado.", Information! , ok!,1)
		this.DeleteRow(row)
		this.InsertRow(0)		
		post setitem(cdw_det, Row, "codigo", '')
		
else
	long ll_uxb
	//******************************************************************************************
	v_CodCli = string(cdw_cab.getitemnumber(1,"cod_cliente"))
	vi_condicion = cdw_cab.getitemnumber(1,"ventas_cod_condicion")
	V_CodDep = cdw_cab.getitemnumber(1,"cod_deposito")	
	v_CovVend = cdw_cab.getitemnumber(1,"cod_vendedor")
	v_codmon = cdw_cab.getitemnumber(1,"cod_moneda")
	//******************************************************************************************
	//Define Datos de Productos
		SELECT Productos.Descripcion_producto, 
		Productos.Unidad, 
		productos.Tipo_fiscal,
		productos.precio_costo,
		productos.imp_imp,
		productos.porc_gravado,
		productos.cod_seccion,
		productos.cant_paq
		
		INTO :v_Descrip, 
		:v_UnidProd,	
		:v_TipoFiscal,
		:v_precio_costo,
		:v_imp_imp ,
		:v_porc_gravado,
		:v_seccion,
		:ll_uxb
		FROM Productos 
		WHERE Productos.Codigo = :v_CodProd ;
		//agregado por ruben para calculos de comisiones
		select comision into :ll_porc_vend_prod 
		from productos where codigo = :v_CodProd;
		if ll_porc_vend_prod = 0 then
			select porcentaje into :ll_porc_vend_prod 
			from vendedores where cod_vendedor = :v_CovVend;
			ll_porc_tipo = 'V'
		else
			ll_porc_tipo = 'P'
		end if
		
	v_promo = promo(v_CodProd)		

	v_precio = cambiar(precio_cliente(long(v_CodCli),    vi_condicion  , v_CodProd), cdw_cab.getitemdatetime(1,"fecha"), moneda_precio(long(v_CodCli),    vi_condicion  , v_CodProd), cdw_cab.getitemnumber(1,"cod_moneda"), 0)
	v_precio_lista = cambiar(precio_lista_cliente(long(v_CodCli),    vi_condicion  , v_CodProd), cdw_cab.getitemdatetime(1,"fecha"), moneda_precio(long(v_CodCli),    vi_condicion  , v_CodProd), cdw_cab.getitemnumber(1,"cod_moneda"), 0)


 	long ll_prov
	select f_prov_cod(:v_CodProd) into :ll_prov from par_sys;
	if isnull(ll_prov) then ll_prov = 0
	THIS.SetItem (getrow(), "cod_proveedor_ven" , ll_prov)
	
	//Actualiza campos con los valores corresp.
	double ll_precio_lista, ll_precio_iva
	long ll_iva

	select imp_imp into :ll_iva from productos where codigo = :v_CodProd;
	ll_precio_iva = (v_precio * ((ll_iva/100)+1))	
	THIS.SetItem (getrow(), "ventas_det_precio_cli" , ll_precio_iva)
		
	THIS.SetItem (getrow(), "precios_det_precio" , v_precio )
	THIS.SetItem (getrow(), "productos_descripcion_producto" , v_Descrip)
	THIS.SetItem (getrow(), "productos_unidad" , v_UnidProd)
	THIS.SetItem (getrow(), "precio" , v_precio)
	THIS.SetItem (getrow(), "ventas_det_precio_neto" , v_precio)
	THIS.SetItem (getrow(), "ventas_det_precio_bruto" , v_precio)

	THIS.SetItem (getrow(), "precio_lista", v_precio_lista)
	THIS.SetItem (getrow(), "ventas_det_nro_promo" , v_promo)

	THIS.SetItem (getrow(), "ventas_det_tipo_fiscal" , v_Tipofiscal)
	THIS.SetItem (getrow(), "ventas_det_imp_imp" , ll_iva/*v_imp_imp*/)
	THIS.SetItem (getrow(), "productos_imp_imp" , ll_iva)
	THIS.SetItem (getrow(), "ventas_det_porc_gravado" , v_porc_gravado)
	THIS.SetItem (getrow(), "productos_Tipo_fiscal" , v_Tipofiscal)
	THIS.SetItem (getrow(), "productos_precio_costo" , v_precio_costo)
	THIS.setitem (getrow(), "productos_precio_venta_a", (THIS.getitemnumber (getrow(), "precio")))
	//campos agregados para registro de comisiones
	THIS.setitem (getrow(), "ventas_det_porc_comis_prod" , ll_porc_vend_prod)
	THIS.setitem (getrow(), "ventas_det_porc_comis_tipo" , ll_porc_tipo)			
	//fin registros agregados   
	
	parent.cdw_det.accepttext() 
	this.setcolumn(3)
	this.setfocus()

   //Aplica Matriz de Descuento de Cliente
	SELECT MATRIZ_DESCUENTOS.PORC_DESC
	INTO :v_Matriz_desc
	FROM CLIENTES,
		  MATRIZ_DESCUENTOS
	WHERE CLIENTES.COD_DESCUENTO = MATRIZ_DESCUENTOS.COD_DESCUENTO and
			CLIENTES.COD_CLIENTE = :v_CodCli ;
	if v_Matriz_desc = 0 then	
	else
		THIS.SetItem (getrow(), "desc_ven" , v_Matriz_desc)		
		cdw_det.TriggerEvent("ue_columna_06")			
	end if		

end if	


end event

event ue_columna_03();parent.cdw_det.accepttext() 

double v_apl_cant
double v_apl_porc
string v_CodProd
double v_Cant

v_CodProd = cdw_det.getitemstring(getrow(),"codigo")

SELECT Productos.APLICA_DESC_CANT, 
Productos.APLICA_DESC_PORC
INTO :v_apl_cant, 
:v_apl_porc
FROM Productos 
WHERE Productos.Codigo = :v_CodProd ;

v_Cant = cdw_det.getitemnumber(getrow(),"unidades")

/*IF v_apl_cant > 0 THEN
	if v_Cant >= v_apl_cant then
		cdw_det.setitem(getrow(),"desc_ven", v_apl_porc)
		cdw_det.TriggerEvent("ue_columna_06")
	end if 
END IF*/

/*************** agregado para incluir promociones 27/10/06 **********/
	cdw_det.TriggerEvent("ue_columna_06")
/***********************************************************/
cdw_det.triggerEvent("ue_actualiza_detalle")

end event

event ue_columna_05();cdw_cab.accepttext() 
cdw_det.accepttext() 
//double v_primer_precio
Double v_ultimo_prec
Double v_Desc
double v_Valor
double v_ValDesc
LONG v_CodCli
STRING v_CodProd
long V_CodDep, v_codmon
v_CodCli = cdw_cab.getitemnumber(1,"cod_cliente")
V_CodDep = cdw_cab.getitemnumber(1,"cod_deposito")
v_CodProd = cdw_det.getitemstring(getrow(),"codigo")
v_codmon = cdw_cab.getitemnumber(1,"cod_moneda")
v_ultimo_prec = this.getitemnumber(this.getrow(),"precios_det_precio")

primer_precio = cambiar(precio_cliente(v_CodCli,vi_condicion, v_CodProd), cdw_cab.getitemdatetime(1,"fecha"), moneda_precio(v_CodCli, vi_condicion   , v_CodProd), cdw_cab.getitemnumber(1,"cod_moneda"), 0)	

if primer_precio > 0 then
v_Valor = (v_ultimo_prec * 100) / primer_precio
else
v_Valor = 0
end if

if v_Valor > 100 then
	v_ValDesc = 0
else
	v_ValDesc = 100 -  v_Valor	
end if	




end event

event ue_columna_06();
double v_ultimo_prec,v_ultimo_desc,v_Valor,v_ValPrec,v_desc_venta
string v_CodCli,v_CodProd,DWfilter,V_Codigo
long V_CodDep, v_codmon,v_fila

cdw_cab.accepttext() 
cdw_det.accepttext() 
//*******************************************************************************************
V_Codigo = cdw_det.getitemstring(getrow(),2)
CodDet = this.getitemstring(getrow(),2)
//*******************************************************************************************
// Filtra Nro de series segun Codigo de prod
if long(cdw_det.getitemstring(getrow(),2)) > 0 then 
	DWfilter = "codigo = '"+ V_Codigo +" '"
	tab_1.tabpage_1.cdw_serie.SetFilter(DWfilter)
	tab_1.tabpage_1.cdw_serie.Filter( )
	// Inserta Nuevo Registro
	if cdw_serie.getrow() = 0 then
		tab_1.tabpage_1.cdw_serie.insertrow(0)
	End if 
end if


//******************************************************************************************
v_CodProd = tab_1.tabpage_1.cdw_det.getitemstring(tab_1.tabpage_1.cdw_det.getrow(),"codigo")
v_CodCli = string(cdw_cab.getitemnumber(1,"cod_cliente"))
V_CodDep = cdw_cab.getitemnumber(1,"cod_deposito")
v_codmon = cdw_cab.getitemnumber(1,"cod_moneda")
//******************************************************************************************
//Define Datos de Productos
	SELECT productos.Desc_venta
	INTO :v_desc_venta
	FROM Productos 
	WHERE Productos.Codigo = :v_CodProd ;

//Actualiza campos con los valores corresp.

v_ultimo_prec =  precio_cliente(long(v_CodCli),0, v_CodProd)	
v_ultimo_desc = this.getitemnumber(getrow(),"desc_ven")
v_Valor = (v_ultimo_prec * v_ultimo_desc) / 100


v_fila = this.getrow()
if v_desc_venta > 0 and v_ultimo_desc > v_desc_venta then
else
	if v_Valor > 0 then
		v_ValPrec = v_ultimo_prec -  v_Valor	
		this.SetItem(getrow(), "precio", v_ValPrec)
		this.SetItem(getrow(), "precios_det_precio", v_ValPrec) 	
	else
		v_ValPrec = v_ultimo_prec
		this.SetItem(getrow(), "precio", v_ValPrec) 	
		this.SetItem(getrow(), "precios_det_precio", v_ValPrec) 			
	end if	
end if

end event

event ue_tecla_pulsada;if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
elseif keydown(keyf12!) then
   cdw_det.triggerEvent("ue_borrar_detalle")
end if

if keydown(keyf3!) then 
	if this.GetColumn() = 2 then
		gdw_datawindow = this 
		guo_func.of_find_cdw (gdw_datawindow )
		v_f3=1
		this.accepttext()
   end if
end if


end event

event ue_borrar_detalle();long V_fil_act , V_fil_det
//********************************************************************************************
aviso = MessageBox("Aviso", "Desea borrar este detalle?", Question!, YesNo!,1)
IF aviso = 1 THEN 
	cdw_det.DeleteRow(0)
	cdw_det.SetColumn(2) 
	V_fil_act = cdw_det.GetRow()
	cdw_det.SetRow(V_fil_act)
	cdw_det.SetFocus()
	this.TriggerEvent("ue_actualiza_totales")	
	if cdw_det.RowCount() = 0 then
		//this.TriggerEvent("ue_insertar_detalle")
		cdw_det.InsertRow(0)
		cdw_det.SetColumn(2) 
	end if	
END IF

end event

event ue_insertar_detalle;if this.RowCount() > vi_parsys_ventamaxitems then
		aviso = MessageBox("Aviso", "Cantidad de Items en detalle no puede ser mayor a lo especificado en Parametros " , Information! , ok!,1)
		long V_fil_act
		// borra la ultima linea
		this.DeleteRow(0)
		this.SetColumn(2) 
		V_fil_act = this.GetRow()
		this.SetRow(V_fil_act)
		this.SetFocus()
else
	if this.getrow() = this.rowcount() AND (this.getcolumnname() = 'precio' or this.getcolumnname() = 'unidades' or v_f3 = 1) then
		v_f3=0
	 
		if (this.getitemString(this.getrow(),'codigo'))<>'' then
			cdw_det.InsertRow(0)
			cdw_det.SetColumn(2) 
		end if
	end if
end if


end event

event ue_actualiza_totales();
cdw_cab.accepttext() 
cdw_det.accepttext() 
long v_moneda
v_moneda = cdw_cab.getitemnumber(1, 'cod_moneda')	
select cant_dec into :v_decimales from monedas where cod_moneda = :v_moneda;
if isnull(v_decimales) then
	v_decimales = 5
end if
double V_Texe, V_Tcosven
double ac_exe, ac_gra, ac_imp, ac_cosven
long V_fil_det, ll_imp, ll_porc, ll_iva_incl

string V_CodProd
double v_iva, v_ivainv , ac_exe1, ll_iva_incluido
double ac_gra10, ac_imp10, ac_gra5, ac_imp5,  V_Tgra10, V_Timp10, V_Tgra5,  V_Timp5

//*** inicializa las variables
ac_exe =0
ac_gra =0
ac_imp =0

ac_gra10 =0
ac_imp10 =0
ac_gra5 =0
ac_imp5 =0

V_Texe=0
V_Tgra10=0
V_Tgra5=0
V_Timp10=0
V_Timp5=0
V_Tcosven=0

//*** calcula los totales
 ll_iva_incluido = tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"iva_incluido")

for V_fil_det = 1 to tab_1.tabpage_1.cdw_det.RowCount()
	if tab_1.tabpage_1.cdw_det.getitemnumber(V_fil_det,"ventas_det_tipo_fiscal") = 0  then
		ll_imp = tab_1.tabpage_1.cdw_det.getitemnumber(V_fil_det,"ventas_det_imp_imp")
		ll_porc = tab_1.tabpage_1.cdw_det.getitemnumber(V_fil_det,"ventas_det_porc_gravado")
		ac_gra = (tab_1.tabpage_1.cdw_det.GetItemNumber(V_fil_det,"tot_precio") * ll_porc /100)
		ac_imp = tab_1.tabpage_1.cdw_det.GetItemNumber(V_fil_det,"tot_imp")
		ac_exe = ac_exe + (tab_1.tabpage_1.cdw_det.GetItemNumber(V_fil_det,"tot_precio") - ac_gra)
		if ll_imp = 5 then
			 ac_gra5 = ac_gra5 + ac_gra
			 ac_imp5 = ac_imp5 + ac_imp
		else
			ac_gra10 = ac_gra10 + ac_gra 
			ac_imp10 = ac_imp10 + ac_imp
		end if
		
	else
		ac_exe = ac_exe + tab_1.tabpage_1.cdw_det.GetItemNumber(V_fil_det,"tot_precio")
	end if
	ac_cosven = ac_cosven + tab_1.tabpage_1.cdw_det.GetItemNumber(V_fil_det,"tot_costo")
next

V_Tgra10 = round(ac_gra10,v_decimales)
V_Tgra5 = round(ac_gra5,v_decimales)
V_Timp10 = round(ac_imp10,v_decimales) 
V_Timp5 = round(ac_imp5,v_decimales) 
V_Texe = round(ac_exe,v_decimales)
V_Tcosven = round(ac_cosven,v_decimales)

//***actualiza los importes	
tab_1.tabpage_1.cdw_cab.setitem(1,'importe_exento', V_Texe)	
tab_1.tabpage_1.cdw_cab.setitem(1,'importe_gravado',V_Tgra10)	
tab_1.tabpage_1.cdw_cab.setitem(1,'importe_impuesto',V_Timp10)	
tab_1.tabpage_1.cdw_cab.setitem(1,'importe_gravado_5',V_Tgra5)	
tab_1.tabpage_1.cdw_cab.setitem(1,'importe_impuesto_5',V_Timp5)	
tab_1.tabpage_1.cdw_cab.setitem(1,'costo_venta',V_Tcosven)

//***saldo del cliente
if tab_1.tabpage_1.cdw_cab.GetItemNumber(1,"Saldo_a") < 0 then
	tab_1.tabpage_1.cdw_cab.Modify("Saldo_a.Background.COLOR='255'") 
else
	tab_1.tabpage_1.cdw_cab.Modify("Saldo_a.Background.COLOR='11665407'") 
end if


end event

event ue_actualiza_detalle();parent.cdw_cab.accepttext() 
parent.cdw_det.accepttext() 

long V_CodReg, V_TipFis
double V_TotCos ,V_TotPre, V_TotImp
double V_TotCos_a,V_TotCos_b
double V_TotCos_b1
double V_TotUnid, V_TotPrec
datetime V_Mifecha
string V_CodProd
string v_CodCli
double v_iva , v_ivainv
long ll_calc_iva, v_documen, ll_incluido 
double ld_imp, ld_impuesto, ll_porc

V_CodProd = cdw_det.getitemstring(getrow(),"codigo")
v_CodCli = string(cdw_cab.getitemnumber(1,"cod_cliente"))

//***	Define Iva de Producto
IF DRIVER() = 2 THEN
	SELECT Productos.imp_imp
	INTO :v_iva
	FROM Productos 
	WHERE Productos.Codigo = :V_CodProd;
ELSE
	SELECT Productos.imp_imp
	INTO :v_iva
	FROM DBO.Productos 
	WHERE Productos.Codigo = :V_CodProd;	
END IF


//***calcula el costo
V_TotCos_a = double(this.getitemnumber(getrow(),"Unidades"))
V_TotCos_b1 = this.getitemnumber(getrow(),"productos_precio_costo")
//messagebox('V_TotCos_b1',V_TotCos_b1)
V_TotCos_b = cambiar(V_TotCos_b1, cdw_cab.getitemdatetime(1,"fecha"), parsys_codmoneda(), cdw_Cab.getitemnumber(1,"cod_moneda"),0)
//messagebox('V_TotCos_b',V_TotCos_b)
V_TotCos = (V_TotCos_a * V_TotCos_b)

v_documen = long (tab_1.tabpage_1.cdw_Cab.getitemnumber(1,"tipo_documen"))
select calc_imp into :ll_calc_iva from tipo_documentos where tipo_documen=:v_documen;

ll_incluido=  long(tab_1.tabpage_1.cdw_Cab.getitemnumber(1,"iva_incluido"))	
ll_porc = tab_1.tabpage_1.cdw_det.getitemnumber(getrow(),"ventas_det_porc_gravado")
ld_imp = tab_1.tabpage_1.cdw_det.getitemnumber(getrow(),"ventas_det_imp_imp")

//***calcula los precios netos e impuestos
V_TotUnid = double(this.getitemnumber(getrow(),"Unidades"))
V_TotPrec = double(this.getitemnumber(getrow(),"Precio"))
V_TotPre = (V_TotUnid * V_TotPrec)
ld_impuesto = 0

if ll_calc_iva = 1 then
	if ll_incluido= 1 then
		ld_impuesto = ((V_TotUnid * V_TotPrec) * ld_imp) / (100 + ld_imp)
		V_TotPre = (V_TotUnid * V_TotPrec) - ld_impuesto
	else
		ld_impuesto = ((V_TotUnid * V_TotPrec) * ld_imp)/100
	end if
else
	
	ld_impuesto = 0
end if

V_TotImp = ld_impuesto

// Actualiza Campos	
this.SetItem(getrow(), 1, V_CodReg) 
this.SetItem(getrow(), "ventas_det_tipo_fiscal", V_TipFis) 
this.SetItem(getrow(), "unidades_credito", 0) 
this.SetItem(getrow(), "tot_costo", round(V_TotCos,v_decimales )) 
this.SetItem(getrow(), "tot_precio", round(V_TotPre,v_decimales )) 
this.SetItem(getrow(), "tot_imp", round(V_TotImp, v_decimales ))


cdw_det.TriggerEvent("ue_Actualiza_Totales")




end event

event ue_elimina_nulos;long V_fil_det
//********************************************************************************************
if THIS.RowCount() > 0 then
	long v_filas
	v_filas = THIS.RowCount()
	for V_fil_det = 1 to v_filas
		if isnull(THIS.GetItemstring(V_fil_det,2)) or THIS.GetItemstring(V_fil_det,2)='' then
			THIS.DeleteRow(V_fil_det)
			V_fil_det =  V_fil_det - 1
		end if
		if V_fil_det = THIS.RowCount() then
			exit
		end if
	next
end if

end event

event ue_insertar_detalle_manual;if this.RowCount() > parsys_ventamaxitems() then
		aviso = MessageBox("Aviso", "Cantidad de Items en detalle no puede ser mayor a lo especificado en Parametros " , Information! , ok!,1)
		long V_fil_act
		// borra la ultima linea
		this.DeleteRow(0)
		this.SetColumn(2) 
		V_fil_act = this.GetRow()
		this.SetRow(V_fil_act)
		this.SetFocus()
else
	if this.getcolumn() = 2  then
		cdw_det.InsertRow(0)
		cdw_det.SetColumn(2) 
	
	end if
	grabar="1"

end if

if this.rowcount() =0 then
		cdw_det.InsertRow(0)
		cdw_det.SetColumn(2) 
end if


end event

event ue_actualiza_codigo;long V_fil_det
//********************************************************************************************
if THIS.RowCount() > 0 then
 for V_fil_det = 1 to THIS.RowCount()
	string v_cod_dig
	int v_existe_cod, v_existe_cod_bar
	v_cod_dig = this.getitemstring(V_fil_det, "codigo")
	select count(codigo) into :v_existe_cod
	from productos
	where codigo = :v_cod_dig ;
	if v_existe_cod > 0 then
		v_existe_cod = 1
	else
		select count(codigo_barras) into :v_existe_cod_bar
	   from productos
 	   where codigo_barras = :v_cod_dig;
      if v_existe_cod_bar > 0 then
			   string v_codigo
				select top 1 codigo into :v_codigo
				from productos
				where codigo_barras = :v_cod_dig ;
     			this.setitem(V_fil_det, "codigo", v_codigo)
	         v_barras = 1
      end if
	end if

 next
end if

end event

event ue_cob_barra;this.setcolumn(2)
this.setrow(vi_fila)
this.settext(vi_codigo)
this.accepttext()

end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)


end event

event editchanged;grabar="1"
end event

event itemchanged;//tab_1.tabpage_1.cdw_cab.Modify("Cod_moneda.Protect=1") 
tab_1.tabpage_1.cdw_cab.Modify("Cod_cliente.Protect=1") 

parent.cdw_cab.accepttext() 
parent.cdw_det.accepttext() 

if parent.cdw_cab.getitemnumber(1,'cod_deposito') < 1 then
	messagebox("Atención","Debe Ingresar el Depósito")
	return
end if

if this.getcolumnname() = "codigo" then
	string v_cod_dig
	long ll_row
	ll_row = getrow()
	v_cod_dig = this.getitemstring(ll_row, "codigo")
	v_cod_dig = guo_func.of_codigo(v_cod_dig)
	cdw_det.setitem(ll_row, "codigo", v_cod_dig)
	post setitem(cdw_det, ll_row, "codigo", v_cod_dig)
end if

gdw_datawindow = this
guo_func.of_find_descrip(gdw_datawindow , dw_busca)
grabar="1"

if (row >= 1 ) THEN
   if this.getcolumn() = 2 then // Valor Actualizado Codigo Prod
		cdw_det.TriggerEvent("ue_columna_02")
	elseif this.GetColumn() = 3 then // Valor Actualizado Unidades
		cdw_det.TriggerEvent("ue_columna_03")
	elseif this.GetColumn() = 5 then // Valor Actualizado Precio
		cdw_det.TriggerEvent("ue_columna_05")	
	elseif this.GetColumn() = 6 then // Valor Actualizado Desc_ven
		cdw_det.TriggerEvent("ue_columna_06")
	end if
end if

//valida que no se ingrese el mismo codigo 2 vecees
if this.getcolumnname() = 'codigo' then
long   v_Ac, band, V_fil_det 
string v_MiProd, v_CodProd
band = 0 
v_ac = 0
v_CodProd = this.GetItemstring(row,"codigo") 
if cdw_det.RowCount() > 0 then
	for V_fil_det = 1 to this.RowCount()
		v_MiProd = this.GetItemstring(V_fil_det,"codigo") 
		if v_CodProd = v_MiProd then
			v_ac = v_ac + 1
			if v_ac = 2 then
				if parsys_ventarepprod() = 0 then
					band = 1
    				exit
				end if
			end if
		end if
	next
end if
if band = 1 then
	this.DeleteRow(row)
	aviso = MessageBox("Aviso", "Ya existe Codigo Ingresado.", Information! , ok!,1)
end if
end if

cdw_det.triggerEvent("ue_actualiza_detalle")
guo_func.of_find_descrip(gdw_datawindow , dw_busca)

//inserta nueva fila
if this.getrow() = this.rowcount() and this.getcolumnname() = 'codigo' and vi_cant = 0 then
   cdw_det.InsertRow(0)
   cdw_det.SetColumn(2)
	cdw_det.Setrow(this.rowcount())
end if


end event

event getfocus;parent.cdw_cab.accepttext() 
parent.cdw_det.accepttext() 
string V_Codigo
long v_TipoDoc, V_Topc
v_TipoDoc = long (tab_1.tabpage_1.cdw_cab.getitemnumber(1,"tipo_documen"))
if this.rowcount() > 0 then
   if this.getitemnumber(getrow(),"precio") > 0 then 
		if this.getrow() > 0 then
	  		primer_precio = this.getitemnumber(getrow(),"precio")
		end if
   end if
else
	this.TriggerEvent("ue_insertar_detalle")
end if






end event

event itemfocuschanged;parent.cdw_cab.accepttext() 
parent.cdw_det.accepttext() 

string V_Codigo
string DWfilter
//*******************************************************************************************
V_Codigo = cdw_det.getitemstring(getrow(),2)
CodDet = this.getitemstring(getrow(),2) 
//*******************************************************************************************

Double v_ultimo_prec
Double v_ultimo_desc
double v_Valor
string v_CodCli
string v_CodProd
double v_desc_venta
//******************************************************************************************
v_CodProd = tab_1.tabpage_1.cdw_det.getitemstring(tab_1.tabpage_1.cdw_det.getrow(),"codigo")
v_CodCli = string(cdw_cab.getitemnumber(1,"cod_cliente"))
//******************************************************************************************

SELECT productos.Desc_venta
INTO :v_desc_venta
FROM DBO.Productos 
WHERE Productos.Codigo = :v_CodProd ;


//Actualiza campos con los valores corresp.
v_ultimo_prec = cambiar(precio_cliente(long(v_CodCli),0, v_CodProd), cdw_cab.getitemdatetime(1,"fecha"), parsys_codmoneda(), cdw_cab.getitemnumber(1,"cod_moneda"), 0)
//v_ultimo_prec = cambiar(precio_cliente_new(long(v_CodCli),0, v_CodProd, getitemnumber(getrow(),"unidades")), cdw_cab.getitemdatetime(1,"fecha"), parsys_codmoneda(), cdw_cab.getitemnumber(1,"cod_moneda"), 0)

//*Descuento muy grande
//********
v_ultimo_desc = this.getitemnumber(getrow(),"desc_ven")
v_Valor = (v_ultimo_prec * v_ultimo_desc) / 100
long v_fila
v_fila = this.getrow()

if v_desc_venta > 0 and v_ultimo_desc > v_desc_venta then
	aviso = MessageBox("Aviso", "Valor de Descuento es Mayor al Valor definido en Producto.", Information! , ok!,1)
	tab_1.tabpage_1.cdw_det.SetItem(v_fila, "desc_ven", 0)
end if

//*******************************************************************************************
// Valida carga de Unidades
if this.getcolumn() = 5 or this.getcolumn() = 6 then // Precio
	if this.getitemnumber(getrow(),"Unidades") = 0	then
		aviso = MessageBox("Atencion !!!", "Valor en Unidades no puede ser Cero.", StopSign!, OK! ,1)
		this.SetColumn("Unidades") 
		this.SetFocus()
	end if 
end if



end event

event itemerror;string ls_colname, ls_datatype
ls_colname = dwo.Name
ls_datatype = dwo.ColType
messagebox("Error..", "El valor ingresado es inválido....")
CHOOSE CASE left(ls_datatype, 4)
CASE "long"
		This.SetItem(row, ls_colname, 0)
		RETURN 3
CASE "nume"
		This.SetItem(row, ls_colname, 0)
		RETURN 3
CASE "deci"
		This.SetItem(row, ls_colname, 0)
		RETURN 3
CASE "date"
		date null_date
		SetNull(null_date)
		This.SetItem(row, ls_colname, null_date)
		RETURN 3
CASE "char"
		string null_string
		SetNull(null_string)
		This.SetItem(row, ls_colname, null_string)
		RETURN 3
END CHOOSE

end event

type cb_1 from commandbutton within tabpage_1
event ue_act_codigo ( )
boolean visible = false
integer x = 197
integer y = 1508
integer width = 485
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Facturar Pedido"
end type

event ue_act_codigo;long v_CodCli
double v_lista_precio
string v_Descrip
double v_precio_a, v_precio_b, v_precio_c, v_precio_d, v_precio_e
integer v_TipoFiscal
double v_precio_costo
double v_precio

double v_iva , v_ivainv
//double V_TotCos_b1
double V_TotCos_a,V_TotCos_b
double V_TotUnid, V_TotPrec
long V_CodReg
double V_TotPre
double V_TotImp
long V_TipFis
double V_TotCos 
//******************************************************************************************
v_CodCli = tab_1.tabpage_1.cdw_cab.GetItemnumber(1,"cod_cliente")
//******************************************************************************************
//Define Lista de Precio por Cliente
SELECT Clientes.Lista_precio 
INTO :v_lista_precio 
FROM Clientes 
WHERE Clientes.Cod_cliente = :v_CodCli ;

//Define Datos de Productos
SELECT Productos.Descripcion_producto, 
productos.Precio_venta_a,
productos.Precio_venta_b,
productos.Precio_venta_c,
productos.Precio_venta_d,
productos.Precio_venta_e,
productos.Tipo_fiscal,
productos.precio_costo,
Productos.imp_imp
INTO :v_Descrip, 
:v_precio_a,
:v_precio_b,	  
:v_precio_c,
:v_precio_d,
:v_precio_e,
:v_TipoFiscal,
:v_precio_costo,
:v_iva
FROM Productos 
WHERE Productos.Codigo = :vg_CodPed ;
 
//Actualiza campos con los valores corresp.
tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "productos_descripcion_producto" , v_Descrip)
tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "productos_Tipo_fiscal" , v_Tipofiscal)
tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "productos_precio_costo" , v_precio_costo)

if v_lista_precio = 0 then 
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_a, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_a, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 1 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_b, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_b, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 2 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_c, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_c, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 3 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_d, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_d, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 4 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_e, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_e, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
end if	

//tab_1.tabpage_1.cdw_det.setitem(V_fil_det, "productos_precio_venta_a", (THIS.getitemnumber (getrow(), "precio")))

v_ivainv = v_iva / 100 + 1
V_TotCos_a = vg_can
V_TotCos_b = cambiar(v_precio_costo, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_Cab.getitemnumber(1,5),0)
V_TotUnid = vg_can
V_TotPrec = v_precio
V_CodReg = long(tab_1.tabpage_1.cdw_Cab.getitemNumber(1,1))
V_TipFis = v_Tipofiscal

V_TotCos = (V_TotCos_a * V_TotCos_b)
if long(tab_1.tabpage_1.cdw_Cab.getitemnumber(1,"iva_incluido")) <> 0 and v_TipoFiscal = 0 then
	V_TotPre = (V_TotUnid * V_TotPrec)/v_ivainv
else
	V_TotPre = (V_TotUnid * V_TotPrec)
end if	

if v_TipoFiscal = 0 and long(tab_1.tabpage_1.cdw_Cab.getitemnumber(1,"tipo_documentos_calc_imp"))<> 0 then 
	if long(tab_1.tabpage_1.cdw_Cab.getitemnumber(1,4)) <> 0 then
		V_TotImp = ((V_TotUnid * V_TotPrec)-((V_TotUnid * V_TotPrec) / v_ivainv))
   else
		V_TotImp = ((V_TotUnid * V_TotPrec) * v_iva) / 100
	end if	
end if	

// Actualiza Campos	
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "nro_reg", V_CodReg) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "ventas_det_tipo_fiscal", V_TipFis) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "unidades_credito", 0) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "tot_costo", V_TotCos) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "tot_precio", V_TotPre) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "tot_imp", V_TotImp) 		


end event

event clicked;open(w_pedido)
tab_1.tabpage_1.cdw_pedidos.retrieve(vg_pedido)

for vg_fil_ped = 1 to tab_1.tabpage_1.cdw_pedidos.RowCount()
	// Recupera
	vg_CodPed = tab_1.tabpage_1.cdw_pedidos.GetItemString(vg_fil_ped,"codigo")
	vg_can = tab_1.tabpage_1.cdw_pedidos.GetItemNumber(vg_fil_ped,"pedidos_clientes_det_cantidad")
	// Inserta Registro 
	tab_1.tabpage_1.cdw_det.InsertRow(0)
	tab_1.tabpage_1.cdw_det.SetColumn(2) 
	// Carga
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "codigo" , vg_CodPed)
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "unidades" , vg_can)

	// Actualiza Pedido Entregado
	tab_1.tabpage_1.cdw_Pedidos.SetItem (vg_fil_ped, "pedidos_clientes_det_entregado" , 1)

//	tab_1.tabpage_1.cdw_pedidos.retrieve(vg_pedido)
	this.TriggerEvent("ue_act_codigo")
next

tab_1.tabpage_1.cdw_det.TriggerEvent("ue_actualiza_totales")
if vg_pedido <> 0 then
	tab_1.tabpage_1.cdw_det.TriggerEvent("ue_elimina_nulos")
end if

grabar="1"

end event

event getfocus;tab_1.tabpage_1.cdw_cab.accepttext() 
tab_1.tabpage_1.cdw_det.accepttext() 

string V_Codigo
string DWfilter
//*******************************************************************************************

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemdatetime(1,"fecha"))) then // Fecha venta
	aviso = MessageBox("Atencion !!!", "Fecha de Venta no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("fecha")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_cliente"))) then // cod_cliente
	aviso = MessageBox("Atencion !!!", "Nombre de Cliente no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_cliente")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"tipo_documen"))) then // Tipo_Doc
	aviso = MessageBox("Atencion !!!", "Tipo Documento no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("tipo_documen")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_moneda"))) then // Moneda
	aviso = MessageBox("Atencion !!!", "Moneda no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_moneda")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_deposito"))) then // Cod_Deposito
	aviso = MessageBox("Atencion !!!", "Deposito no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_deposito")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_lugar"))) then // Lugar venta
	aviso = MessageBox("Atencion !!!", "Lugar de Venta no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_lugar")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if


long v_TipoDoc, V_Topc
v_TipoDoc = long (tab_1.tabpage_1.cdw_cab.getitemnumber(1,"tipo_documen"))

//Recupera Valor TipoDoc
SELECT Tipo_Documentos.Tipo_Opcion 
INTO :v_Topc
FROM Tipo_Documentos 
WHERE Tipo_Documentos.Tipo_Documen = :v_TipoDoc ;
If v_Topc = 1 then // Contado-Bloquea Campos

else
	if long(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cantidad_cuotas")) = 0 then // cantidad Cuotas
		aviso = MessageBox("Atencion !!!", "Cantidad de Cuotas no puede ser Nulo", StopSign!, OK! ,1)
		tab_1.tabpage_1.cdw_cab.setcolumn("cantidad_cuotas")              
		tab_1.tabpage_1.cdw_cab.SetFocus()
   	return 
	end if

	if isnull(string(tab_1.tabpage_1.cdw_cab.getitemdatetime(1,"inicio_vencimietos"))) then //17 fecha venc
		aviso = MessageBox("Atencion !!!", "Fecha de Vencimiento no puede ser Nulo", StopSign!, OK! ,1)
		tab_1.tabpage_1.cdw_cab.setcolumn("inicio_vencimietos")              
		tab_1.tabpage_1.cdw_cab.SetFocus()
		return 
	end if
				
	if long(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"dias")) = 0 then // Plazo
		aviso = MessageBox("Atencion !!!", "Días no puede ser Nulo", StopSign!, OK! ,1)
		tab_1.tabpage_1.cdw_cab.setcolumn("dias")              
		tab_1.tabpage_1.cdw_cab.SetFocus()
		return 
	end if
end if		

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_vendedor"))) then // Cod_Vendedor
	aviso = MessageBox("Atencion !!!", "Cod Vendedor no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_vendedor")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

end event

type cb_2 from commandbutton within tabpage_1
event ue_act_codigo ( )
boolean visible = false
integer x = 197
integer y = 1620
integer width = 485
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Facturar Prod Comp"
end type

event ue_act_codigo;long v_CodCli
double v_lista_precio
string v_Descrip
double v_precio_a, v_precio_b, v_precio_c, v_precio_d, v_precio_e
integer v_TipoFiscal
double v_precio_costo
double v_precio

double v_iva , v_ivainv
//double V_TotCos_b1
double V_TotCos_a,V_TotCos_b
double V_TotUnid, V_TotPrec
long V_CodReg
double V_TotPre
double V_TotImp
long V_TipFis
double V_TotCos 
//******************************************************************************************
v_CodCli = tab_1.tabpage_1.cdw_cab.GetItemnumber(1,"cod_cliente")
//******************************************************************************************
//Define Lista de Precio por Cliente
SELECT Clientes.Lista_precio 
INTO :v_lista_precio 
FROM Clientes 
WHERE Clientes.Cod_cliente = :v_CodCli ;

//Define Datos de Productos
SELECT Productos.Descripcion_producto, 
productos.Precio_venta_a,
productos.Precio_venta_b,
productos.Precio_venta_c,
productos.Precio_venta_d,
productos.Precio_venta_e,
productos.Tipo_fiscal,
productos.precio_costo,
Productos.imp_imp
INTO :v_Descrip, 
:v_precio_a,
:v_precio_b,	  
:v_precio_c,
:v_precio_d,
:v_precio_e,
:v_TipoFiscal,
:v_precio_costo,
:v_iva
FROM Productos 
WHERE Productos.Codigo = :vg_CodPed ;
 
//Actualiza campos con los valores corresp.
tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "productos_descripcion_producto" , v_Descrip)
tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "productos_Tipo_fiscal" , v_Tipofiscal)
tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "productos_precio_costo" , v_precio_costo)

if v_lista_precio = 0 then 
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_a, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_a, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 1 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_b, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_b, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 2 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_c, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_c, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 3 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_d, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_d, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
elseif v_lista_precio = 4 then 	
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "precio" , cambiar(v_precio_e, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0))
	v_precio = cambiar(v_precio_e, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_cab.getitemnumber(1,5), 0)
end if	

//tab_1.tabpage_1.cdw_det.setitem(V_fil_det, "productos_precio_venta_a", (THIS.getitemnumber (getrow(), "precio")))

v_ivainv = v_iva / 100 + 1
V_TotCos_a = vg_can
V_TotCos_b = cambiar(v_precio_costo, cdw_cab.getitemdatetime(1,2), parsys_codmoneda(), cdw_Cab.getitemnumber(1,5),0)
V_TotUnid = vg_can
V_TotPrec = v_precio
V_CodReg = long(tab_1.tabpage_1.cdw_Cab.getitemNumber(1,1))
V_TipFis = v_Tipofiscal

V_TotCos = (V_TotCos_a * V_TotCos_b)
if long(tab_1.tabpage_1.cdw_Cab.getitemnumber(1,"iva_incluido")) <> 0 and v_TipoFiscal = 0 then
	V_TotPre = (V_TotUnid * V_TotPrec)/v_ivainv
else
	V_TotPre = (V_TotUnid * V_TotPrec)
end if	

if v_TipoFiscal = 0 and long(tab_1.tabpage_1.cdw_Cab.getitemnumber(1,"tipo_documentos_calc_imp"))<> 0 then 
	if long(tab_1.tabpage_1.cdw_Cab.getitemnumber(1,4)) <> 0 then
		V_TotImp = ((V_TotUnid * V_TotPrec)-((V_TotUnid * V_TotPrec) / v_ivainv))
   else
		V_TotImp = ((V_TotUnid * V_TotPrec) * v_iva) / 100
	end if	
end if	

// Actualiza Campos	
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "nro_reg", V_CodReg) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "ventas_det_tipo_fiscal", V_TipFis) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "unidades_credito", 0) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "tot_costo", V_TotCos) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "tot_precio", V_TotPre) 
tab_1.tabpage_1.cdw_det.SetItem(vg_fil_ped, "tot_imp", V_TotImp) 		


end event

event getfocus;tab_1.tabpage_1.cdw_cab.accepttext() 
tab_1.tabpage_1.cdw_det.accepttext() 

string V_Codigo
string DWfilter
//*******************************************************************************************

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemdatetime(1,"fecha"))) then // Fecha venta
	aviso = MessageBox("Atencion !!!", "Fecha de Venta no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("fecha")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_cliente"))) then // cod_cliente
	aviso = MessageBox("Atencion !!!", "Nombre de Cliente no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_cliente")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"tipo_documen"))) then // Tipo_Doc
	aviso = MessageBox("Atencion !!!", "Tipo Documento no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("tipo_documen")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_moneda"))) then // Moneda
	aviso = MessageBox("Atencion !!!", "Moneda no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_moneda")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_deposito"))) then // Cod_Deposito
	aviso = MessageBox("Atencion !!!", "Deposito no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_deposito")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_lugar"))) then // Lugar venta
	aviso = MessageBox("Atencion !!!", "Lugar de Venta no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_lugar")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if


long v_TipoDoc, V_Topc
v_TipoDoc = long (tab_1.tabpage_1.cdw_cab.getitemnumber(1,"tipo_documen"))

//Recupera Valor TipoDoc
SELECT Tipo_Documentos.Tipo_Opcion 
INTO :v_Topc
FROM Tipo_Documentos 
WHERE Tipo_Documentos.Tipo_Documen = :v_TipoDoc ;
If v_Topc = 1 then // Contado-Bloquea Campos

else
	if long(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cantidad_cuotas")) = 0 then // cantidad Cuotas
		aviso = MessageBox("Atencion !!!", "Cantidad de Cuotas no puede ser Nulo", StopSign!, OK! ,1)
		tab_1.tabpage_1.cdw_cab.setcolumn("cantidad_cuotas")              
		tab_1.tabpage_1.cdw_cab.SetFocus()
   	return 
	end if

	if isnull(string(tab_1.tabpage_1.cdw_cab.getitemdatetime(1,"inicio_vencimietos"))) then //17 fecha venc
		aviso = MessageBox("Atencion !!!", "Fecha de Vencimiento no puede ser Nulo", StopSign!, OK! ,1)
		tab_1.tabpage_1.cdw_cab.setcolumn("inicio_vencimietos")              
		tab_1.tabpage_1.cdw_cab.SetFocus()
		return 
	end if
				
	if long(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"dias")) = 0 then // Plazo
		aviso = MessageBox("Atencion !!!", "Días no puede ser Nulo", StopSign!, OK! ,1)
		tab_1.tabpage_1.cdw_cab.setcolumn("dias")              
		tab_1.tabpage_1.cdw_cab.SetFocus()
		return 
	end if
end if		

if isnull(string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,"cod_vendedor"))) then // Cod_Vendedor
	aviso = MessageBox("Atencion !!!", "Cod Vendedor no puede ser Nulo", StopSign!, OK! ,1)
	tab_1.tabpage_1.cdw_cab.setcolumn("cod_vendedor")              
	tab_1.tabpage_1.cdw_cab.SetFocus()
	return 
end if

end event

event clicked;open(w_productos_comp)
tab_1.tabpage_1.cdw_prod_comp.retrieve(vg_producto_comp)

for vg_fil_ped = 1 to tab_1.tabpage_1.cdw_prod_comp.RowCount()
	// Recupera
	vg_CodPed = tab_1.tabpage_1.cdw_prod_comp.GetItemString(vg_fil_ped,"codigo_compuesto")
	vg_can = tab_1.tabpage_1.cdw_prod_comp.GetItemNumber(vg_fil_ped,"cantidad_comp")
	// Inserta Registro 
	tab_1.tabpage_1.cdw_det.InsertRow(0)
	tab_1.tabpage_1.cdw_det.SetColumn(2) 
	// Carga
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "codigo" , vg_CodPed)
	tab_1.tabpage_1.cdw_det.SetItem (vg_fil_ped, "unidades" , vg_can)

	this.TriggerEvent("ue_act_codigo")
next

tab_1.tabpage_1.cdw_det.TriggerEvent("ue_actualiza_totales")
if long(vg_producto_comp) <> 0 then
	tab_1.tabpage_1.cdw_det.TriggerEvent("ue_elimina_nulos")
end if

grabar="1"
end event

type cdw_cab from datawindow within tabpage_1
event ue_tecla_pulsada pbm_dwnkey
event ue_columna_01 ( )
event ue_columna_07 ( )
event recup_tipo_doc ( )
event ue_enter pbm_dwnprocessenter
event ue_columna_12 ( )
event ue_columna_08 ( )
event ue_columna_11 ( )
integer x = 37
integer y = 4
integer width = 2816
integer height = 904
integer taborder = 20
string dataobject = "dw_abm_ventas_caja_nuevo1"
end type

event ue_tecla_pulsada;
if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
end if

if keydown(keyf11!) then 
	if this.getcolumnname() = 'cod_cliente' then
		long v_ocasional, v_cliente_oca
		v_cliente_oca = tab_1.tabpage_1.cdw_cab.getitemnumber(1, 'cod_cliente') 
		select ocasional into :v_ocasional from clientes where cod_cliente = :v_cliente_oca;
		if v_ocasional = 1 then
			tab_1.tabpage_1.cdw_cab.accepttext()
			g_nombre = cdw_cab.getitemstring(1, 'ventas_nombre_cliente')
			g_obs = tab_1.tabpage_1.cdw_cab.getitemstring(1, 'ventas_contacto')
			g_origen = tab_1.tabpage_1.cdw_cab.getitemstring(1, 'ventas_direccion')
			g_serie = tab_1.tabpage_1.cdw_cab.getitemstring(1, 'ventas_ruc')
			g_tabla = tab_1.tabpage_1.cdw_cab.getitemstring(1, 'ventas_telefono')
			open(w_datos_clientes)
			tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_nombre_cliente', g_nombre)
			tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_contacto', g_obs)
			tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_ruc', g_serie)
			tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_direccion', g_origen)
			tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_telefono', g_tabla)
		end if
	end if
end if

if keydown(keyf3!) then 
	gdw_datawindow = this
	guo_func.of_find_cdw(gdw_datawindow )
	this.TriggerEvent("ue_columna_07")		
end if
end event

event ue_columna_01();// Actualiza Nro de series segun Codigo de prod
tab_1.tabpage_1.cdw_serie.retrieve(cdw_cab.getitemnumber(1,1))		

cdw_det.TriggerEvent("ue_Actualiza_Totales")

end event

event ue_columna_07();parent.cdw_cab.accepttext()
parent.cdw_det.accepttext()

string v_CodCli
string v_dir, v_tel, v_ruc
long v_aso, ll_tipo_doc, ll_condicion, ll_plazo, v_tipo_mayorista
//*******************************************************************************************
	v_CodCli = string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,'cod_cliente'))
// ******************************************************************************************

//Recupera Valores del Cliente
   SELECT Clientes.Direccion, 
   Clientes.Telefono, 
   Clientes.Ruc,
	Clientes.Asociacion,
	Clientes.Cod_vendedor,
	Clientes.Tipo_fiscal
   INTO :v_dir,
   :v_tel,
	:v_ruc,
	:v_aso,
	:v_vend,
	:vi_tipo_fiscal
	FROM dbo.Clientes 
   WHERE Clientes.Cod_cliente = :v_CodCli ;
	
	
	SELECT cliente_condicion.tipo_doc,
		cliente_condicion.cod_condicion,
		cliente_condicion.cod_plazo
	INTO
	:ll_tipo_doc,
	:ll_condicion,
	:ll_plazo	
	FROM cliente_condicion
	WHERE cliente_condicion.cod_cliente = :v_CodCli ;
	
	/*select tipo_documen_mayorista
	into :v_tipo_mayorista
	from dbo.par_sys;*/	
	

// verifica que sea el tipo de documento para venta mayorista en linea de caja
//	if v_tipo_mayorista <> ll_tipo_doc then
//		messagebox('Atencion, ','Verifique el tipo de documento de este cliente, porque no corresponde a este tipo de ventas')
//		return
//	end if

// Actualiza Valores del Cliente
	THIS.SetItem (getrow(), "clientes_direccion" , v_dir)
	THIS.SetItem (getrow(), "clientes_Telefono" , v_tel)	  
   THIS.SetItem (getrow(), "clientes_Ruc" , v_ruc)	  

// Actualiza condiciones del Cliente
	THIS.setitem(1,"dias", ll_plazo )
	//THIS.setitem(1,"Tipo_documen", v_tipo_mayorista/*ll_tipo_doc*/ )
	//THIS.setitem(1,"ventas_cod_condicion", ll_condicion )
	cdw_cab.TriggerEvent("ue_columna_12")
	cdw_cab.Modify("Tipo_documen.Protect=1")
	cdw_cab.Modify("ventas_cod_condicion.Protect=1")	
	
// Bloquea campo Cod_asociado
	if v_aso = 0 then // Bloquea Campos
		cdw_Cab.setitem(1,"cod_aso", 0)
		cdw_cab.Modify("Cod_aso.Protect=1") 
		cdw_cab.Modify("Cod_aso.Background.COLOR='128128128'")    
		cdw_Cab.setitem(1,"cod_lugar", 10)
   else
		cdw_Cab.setitem(1,"cod_aso", 0)		
		// Carga parametro Cliente Aso
		DataWindowChild cdw_Cli_Aso
		tab_1.tabpage_1.cdw_Cab.GetChild("cod_aso", cdw_Cli_Aso)
		cdw_Cli_Aso.SetTransObject(SQLCA)
		cdw_Cli_Aso.Retrieve(double(v_CodCli))
		if cdw_Cli_Aso.rowcount() <= 0 then
			cdw_Cli_Aso.InsertRow(0)
			messagebox("Atención..", "Empresa no tiene socios...")
			cdw_cab.Modify("Cod_aso.Protect=1") 
		   cdw_cab.Modify("Cod_aso.Background.COLOR='128128128'")
		else
			cdw_cab.Modify("Cod_aso.Protect=0") 
			cdw_cab.Modify("Cod_aso.Background.COLOR='1090519039'")    
		end if
		cdw_Cab.setitem(1,"cod_lugar", 30)
	end if

// Repintado Ctas del Cliente
	tab_1.tabpage_2.cdw_Ctas.retrieve(long(this.Getitemnumber(1,"cod_cliente")))
	

end event

event ue_enter;int v_sec_sec
int v_sec_sal
int v_columnas, n
int v_col
v_col = this.GetColumn()
v_sec_sal = long(this.Describe("#" + string(v_col) + ".TabSequence"))
v_columnas = long(this.Object.DataWindow.Column.Count)
FOR n = 1 to v_columnas 
v_sec_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
if (v_sec_sal + 10) = v_sec_sec then
   this.setcolumn(n)
	exit
end if
NEXT
if v_sec_sal = (v_columnas*10) then
   this.setcolumn(1)
end if

end event

event ue_columna_12();parent.cdw_cab.accepttext() 
parent.cdw_det.accepttext() 
long v_TipoDoc, V_Topc, VCalImp
LONG V_NC,V_ND
//*******************************************************************************************
	v_TipoDoc = long (this.getitemnumber(1,"tipo_documen"))
// ******************************************************************************************

	SELECT Tipo_Documentos.Tipo_Opcion,
		 	 Tipo_Documentos.calc_imp,
	       TIPO_NC,
          TIPO_ND
	INTO :v_Topc, 
	     :VCalImp,
	     :V_NC,
		  :V_ND
	FROM Tipo_Documentos 
	WHERE Tipo_Documentos.Tipo_Documen = :v_TipoDoc ;

	IF (V_NC + V_ND) > 0 THEN
		MessageBox("Aviso","Inposible generar Nota de Crédito en Modulo de Ventas...", Information! , ok!,1)	
      this.postevent("ue_focus_cabecera")	
    	v_columna = "tipo_documen"
		return
	END IF


	If v_Topc = 1 then // Contado-Bloquea Campos
	   cdw_cab.SetItem (1, "entrega_inicial" , 0)	
		cdw_cab.Modify("entrega_inicial.Protect=1") 
		cdw_cab.Modify("entrega_inicial.Background.COLOR='128128128'")    
	   cdw_cab.SetItem (1, "cantidad_cuotas" , 0)		
	   cdw_cab.Modify("cantidad_cuotas.Protect=1")  
	  	cdw_cab.Modify("cantidad_cuotas.Background.COLOR='128128128'")        
	   cdw_cab.Modify("inicio_vencimietos.Protect=1")
	  	cdw_cab.Modify("inicio_vencimietos.Background.COLOR='128128128'")         
	   cdw_cab.SetItem (1, "dias" , 0)		  
	   cdw_cab.Modify("dias.Protect=1")
	  	cdw_cab.Modify("dias.Background.COLOR='128128128'")         
		  
		tab_1.tabpage_1.cdw_cab.setitem(1,"cantidad_cuotas",0)
		tab_1.tabpage_1.cdw_cab.setitem(1,"dias",0)		  
		
	elseIF  v_Topc = 0 then // Credito-Desbloquea Campos
	  	cdw_cab.Modify("entrega_inicial.Protect=0") 
		cdw_cab.Modify("entrega_inicial.Background.COLOR='1090519039'")    
	   cdw_cab.Modify("cantidad_cuotas.Protect=0")  
	  	cdw_cab.Modify("cantidad_cuotas.Background.COLOR='1090519039'")        
	   cdw_cab.Modify("inicio_vencimietos.Protect=0")
	  	cdw_cab.Modify("inicio_vencimietos.Background.COLOR='1090519039'")         
	   cdw_cab.Modify("dias.Protect=0")
	  	cdw_cab.Modify("dias.Background.COLOR='1090519039'")         
		  
		tab_1.tabpage_1.cdw_cab.setitem(1,"cantidad_cuotas",1)
		tab_1.tabpage_1.cdw_cab.setitem(1,"dias",1)		  
	end if

	// Actualiza Campo calcula Imp
	THIS.SetItem (1, "tipo_documentos_calc_imp" , VCalImp)
	//cdw_cab.Modify("cod_deposito.Protect=0")




end event

event ue_columna_08;parent.cdw_cab.accepttext()
long v_CodCli, v_cliente_aso
v_CodCli = tab_1.tabpage_1.cdw_cab.getitemnumber(1,'cod_cliente')
v_cliente_aso = tab_1.tabpage_1.cdw_cab.getitemnumber(1, 'cod_aso') 

if v_cliente_aso > 0 then
	SELECT Clientes_aso.Nombre_asociado,   
   	    Clientes_aso.Direccion,   
      	 Clientes_aso.Nro_cedula ,   		 
	       Clientes_aso.Telefono
   	    INTO :g_nombre,
      	 :g_origen,
	    	 :g_serie,
   	    :g_tabla
	  FROM Clientes_aso  
	 WHERE Clientes_aso.Cod_cliente = :v_CodCli and
   	    Clientes_aso.Cod_asociado = :v_cliente_aso ;    

	tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_nombre_cliente', g_nombre)
	//tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_contacto', g_obs)
	tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_ruc', g_serie)
	tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_direccion', g_origen)
	tab_1.tabpage_1.cdw_cab.setitem(1, 'ventas_telefono', g_tabla)
end if


end event

event ue_columna_11;parent.cdw_det.accepttext()


string v_CodVend
long v_Realiza_desc
//*******************************************************************************************
	v_CodVend = string(tab_1.tabpage_1.cdw_cab.getitemnumber(1,'cod_vendedor'))
// ******************************************************************************************

//Recupera Valores del Cliente
SELECT Vendedores.Realiza_desc 
INTO :v_Realiza_desc
FROM Vendedores 
WHERE Vendedores.Cod_vendedor = :v_CodVend ;

// Valida descuento a vendedor
if v_Realiza_desc = 1 then
	tab_1.tabpage_1.cdw_det.Modify("precio.Protect=0") 
	tab_1.tabpage_1.cdw_det.Modify("desc_ven.Protect=0") 
else
	tab_1.tabpage_1.cdw_det.Modify("precio.Protect=1") 
	tab_1.tabpage_1.cdw_det.Modify("desc_ven.Protect=1") 
end if

end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)
end event

event editchanged;	grabar="1"
end event

event itemchanged;parent.cdw_cab.accepttext()
parent.cdw_det.accepttext()
long ll_suc, ll_dep
	
if this.GetColumn() = 1 then // Valor Actualizado Nro_Reg
	w_abm_ventas_caja_nuevo.TriggerEvent("ue_leer")
	cdw_cab.TriggerEvent("ue_columna_01")
elseif this.GetColumnName() = "cod_cliente" then 
	cdw_cab.TriggerEvent("ue_columna_07")
	
if v_vend = 0 then
	THIS.setitem(getrow(),"cod_vendedor",long(parsys_ventacodvendedor()) )		
	THIS.Modify("cod_vendedor.Protect=0") 				
else
	THIS.SetItem (getrow(), "cod_vendedor" , v_vend)	
	if parsys_alter_vend() = 1 then
		THIS.Modify("cod_vendedor.Protect=0") 		
	else
		THIS.Modify("cod_vendedor.Protect=1") 					
	end if					
end if	
	
	
elseif this.GetColumnName() = "cod_aso" then
	cdw_cab.TriggerEvent("ue_columna_08")	
elseif this.GetColumnName() = "cod_vendedor" then	
	cdw_cab.TriggerEvent("ue_columna_11")		
elseif this.GetColumnName() = "tipo_documen" then
	cdw_cab.TriggerEvent("ue_columna_12")	
elseif this.GetColumnName() = "cod_deposito"  then
	ll_dep = tab_1.tabpage_1.cdw_Cab.getItemNumber(1, "cod_deposito")
	select cod_sucursal_contable into :ll_suc from depositos where cod_deposito=:ll_dep;
	tab_1.tabpage_1.cdw_Cab.setItem(1, "cod_sucursal_cont", ll_suc)
else
	grabar="1"	
end if

if this.getcolumnname() = 'ventas_cod_condicion' then
	vi_condicion = long(data)
end if
if this.getcolumnname() = 'cod_moneda' then
	cdw_det.reset()
	cdw_det.insertrow(0)
   v_decimales = 5	
	long v_moneda
	v_moneda = this.getitemnumber(1, 'cod_moneda')	
	select cant_dec into :v_decimales from monedas where cod_moneda = :v_moneda;
	if isnull(v_decimales) then
		v_decimales = 5
	end if
end if
gdw_datawindow = this
guo_func.of_find_descrip(gdw_datawindow , dw_busca)

end event

event itemerror;string ls_colname, ls_datatype
ls_colname = dwo.Name
ls_datatype = dwo.ColType
messagebox("Error..", "El valor ingresado es inválido....")
CHOOSE CASE left(ls_datatype, 4)
CASE "long"
		This.SetItem(row, ls_colname, 0)
		RETURN 3
CASE "nume"
		This.SetItem(row, ls_colname, 0)
		RETURN 3
CASE "deci"
		This.SetItem(row, ls_colname, 0)
		RETURN 3
CASE "date"
		date null_date
		SetNull(null_date)
		This.SetItem(row, ls_colname, null_date)
		RETURN 3
CASE "char"
		string null_string
		SetNull(null_string)
		This.SetItem(row, ls_colname, null_string)
		RETURN 3
END CHOOSE

end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 104
integer width = 2903
integer height = 1632
long backcolor = 79741120
string text = "Cuentas a Cobrar"
long tabtextcolor = 33554432
long tabbackcolor = 10789024
long picturemaskcolor = 536870912
cdw_ctas cdw_ctas
end type

on tabpage_2.create
this.cdw_ctas=create cdw_ctas
this.Control[]={this.cdw_ctas}
end on

on tabpage_2.destroy
destroy(this.cdw_ctas)
end on

type cdw_ctas from datawindow within tabpage_2
boolean visible = false
integer x = 32
integer y = 44
integer width = 3470
integer height = 1784
integer taborder = 30
boolean enabled = false
string dataobject = "dw_abm_ventas2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;grabar="1"
end event

type cb_cerrar from commandbutton within w_abm_ventas_caja_nuevo
integer x = 311
integer y = 228
integer width = 247
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_print from uo_datawindow within w_abm_ventas_caja_nuevo
boolean visible = false
integer x = 2912
integer y = 2036
integer width = 146
integer height = 216
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_print_factura_ventas_caja"
end type

type st_1 from statictext within w_abm_ventas_caja_nuevo
boolean visible = false
integer x = 256
integer y = 8
integer width = 1371
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_menu from statictext within w_abm_ventas_caja_nuevo
boolean visible = false
integer x = 251
integer y = 4
integer width = 1376
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_abm_ventas_caja_nuevo
integer x = 462
integer y = 1760
integer width = 1993
integer height = 212
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
end type

type r_1 from rectangle within w_abm_ventas_caja_nuevo
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 8388608
integer width = 142
integer height = 2172
end type


$PBExportHeader$w_abm_pago_proveedor.srw
forward
global type w_abm_pago_proveedor from w_abm_cabecera_detalle_ancestor
end type
type cdw_datos_detalle2 from datawindow within w_abm_pago_proveedor
end type
type cb_seleccionar from commandbutton within w_abm_pago_proveedor
end type
end forward

global type w_abm_pago_proveedor from w_abm_cabecera_detalle_ancestor
integer width = 3570
integer height = 2400
string title = "PAGO AL PROVEEDOR"
event ue_insertar_valor_detalle2 ( )
cdw_datos_detalle2 cdw_datos_detalle2
cb_seleccionar cb_seleccionar
end type
global w_abm_pago_proveedor w_abm_pago_proveedor

type variables
uo_funcion guo_funcion
int aviso
string tipo_valor, valor
end variables

forward prototypes
public function integer fn_validar_campos ()
end prototypes

event ue_insertar_valor_detalle2();long valor1
integer fila                          

fila    = RowCount(cdw_datos_detalle2)
if f_vta_maxitemns () = 0 or fila < f_vta_maxitemns () then
	valor1 = cdw_datos.GetItemNumber(1,1) 
	fila = cdw_datos_detalle2.Insertrow (0)

	cdw_datos_detalle2.setitem (fila, 1, valor1)  
	cdw_datos_detalle2.setrow (fila)
	//cdw_datos_detalle2.setColumn (ii_prim_fila_detalle)
	cdw_datos_detalle2.scrolltorow(fila)
	if ib_focus = true then setfocus (cdw_datos_detalle2)
else
	SetMicroHelp("La máxima cantidad de filas del detalle es " + string(f_vta_maxitemns ()))
end if

end event

public function integer fn_validar_campos ();cdw_datos.accepttext() 
cdw_datos_detalle.accepttext() 
date ldf_fecha

if isnull(string(cdw_datos.getitemnumber(1,"cod_proveedor"))) then // Cod_Proveedor
	aviso = MessageBox("Atencion !!!", "Proveedor no puede ser Nulo", StopSign!, OK! ,1)
	cdw_datos.setfocus( )
  	cdw_datos.setcolumn('cod_proveedor')	
	return -1
end if


ldf_fecha=date(cdw_datos.getitemdatetime(1,"fecha_op"))
if isnull(string(ldf_fecha)) then // Fecha
	aviso = MessageBox("Atencion !!!", "La fecha de la OP no puede ser nula", StopSign!, OK! ,1)
	cdw_datos.setfocus( )
    cdw_datos.setcolumn('fecha_op')	
	return -1
end if


ldf_fecha=date(cdw_datos.getitemdatetime(1,"fecha_pago"))
if isnull(string(ldf_fecha)) then // Fecha
	aviso = MessageBox("Atencion !!!", "La fecha de Pago no puede ser nula", StopSign!, OK! ,1)
	cdw_datos.setfocus( )
    cdw_datos.setcolumn('fecha_pago')	
	return -1
end if


if isnull(string(cdw_datos.getitemnumber(1,"cod_moneda"))) then // Cod_Proveedor
	aviso = MessageBox("Atencion !!!", "Moneda no puede ser nula", StopSign!, OK! ,1)
	cdw_datos.setfocus( )
  	cdw_datos.setcolumn('cod_moneda')	
	return -1
end if


if cdw_datos_detalle2.getitemdecimal(1,"valor")<0 then // Cod_Proveedor
	aviso = MessageBox("Atencion !!!", "Detalles de pagos no puede ser en negativo", StopSign!, OK! ,1)
	cdw_datos.setfocus( )
  	cdw_datos.setcolumn('valor')	
	return -1
end if

return 0
end function

on w_abm_pago_proveedor.create
int iCurrent
call super::create
this.cdw_datos_detalle2=create cdw_datos_detalle2
this.cb_seleccionar=create cb_seleccionar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_datos_detalle2
this.Control[iCurrent+2]=this.cb_seleccionar
end on

on w_abm_pago_proveedor.destroy
call super::destroy
destroy(this.cdw_datos_detalle2)
destroy(this.cb_seleccionar)
end on

event ue_insertar;cdw_datos.reset()
cdw_datos.insertrow(0)
cdw_datos.SetColumn(ii_prim_fila_cab)
cdw_datos.setfocus()

btn_agregar.enabled=false
btn_guardar.enabled=true
btn_modificar.enabled=false
btn_cancelar.enabled=true
btn_buscar.enabled=true
btn_eliminar.enabled=false
btn_agregar_detalle.enabled=true
btn_quitar_detalle.enabled=true
cb_busca.enabled=true
btn_imprimir.enabled=true
cdw_datos.enabled=true
cdw_datos_detalle.enabled=true
ib_focus = false
long ll_max
ll_max=guo_funcion.of_select( 'select ifnull(max(nro_pago),0)+1 from pagos')
cdw_datos.setitem( 1, 'nro_pago',ll_max)
cdw_datos.setitem( 1, 'fecha_pago', today())
cdw_datos.setitem( 1, 'fecha_op', today())

cdw_datos_detalle.reset()
cdw_datos_detalle2.reset()
This.TriggerEvent("ue_insertar_valor_detalle")
This.TriggerEvent("ue_insertar_valor_detalle2")

ib_focus = true
end event

event open;ii_cant_claves = 1
f_centrar (this)
cdw_datos				.SetTransObject (sqlca)
cdw_datos_detalle 	.SetTransObject (sqlca)
cdw_datos_detalle2.SetTransObject (sqlca)

ii_prim_fila_cab = 1
ii_cant_claves=1
ii_prim_fila_detalle = 3
ii_ult_item_detalle = integer(cdw_datos_detalle.Describe("DataWindow.Column.Count"))

ii_max_filas_detalle = 0

if ProfileString ("softpan.ini", "Database", "usar_skin", "1")="1" then
		Long hWnd
		hWnd=Handle(this)
		
		this.OLE_Skin.object.LoadSkin("winaqua.skn")
		this.OLE_Skin.object.ApplySkin (hWnd)
		
		
		 Long    W_Color
		 Long    T_Color
		 String  Aplico_w_color
		 String  Aplico_T_Color
		 
		 W_Color        =this.ole_skin.object.WindowColor()
		 Aplico_w_color = "DataWindow.Color="+"'"+String(W_Color)+"'"
		 this.cdw_datos.Modify ( Aplico_W_color )
		 this.cdw_datos_detalle.Modify ( Aplico_W_color )
		 
		 T_Color        =this.ole_skin.object.PanelTextColor()
		 Aplico_T_color = "Provincias_t.Color="+"'"+String(T_Color)+"'"
		 this.cdw_datos.Modify ( Aplico_T_color )
		 this.cdw_datos_detalle.Modify ( Aplico_T_color)
	end if
	guo_funcion = create uo_funcion
// if cdw_datos.retrieve()<=0 then
// 	this.triggerevent("ue_insertar")
// else
	this.triggerevent("ue_insertar")
//	cdw_datos.retrieve( )
//	cdw_datos.scrolltorow( cdw_datos.rowcount( )  )
//	cdw_datos_detalle.retrieve(cdw_datos.getitemnumber(1,1))
	btn_agregar.enabled=false
	btn_guardar.enabled=true
	btn_modificar.enabled=true
	btn_cancelar.enabled=true
	btn_buscar.enabled=true
	btn_eliminar.enabled=false
	btn_agregar_detalle.enabled=false
	btn_quitar_detalle.enabled=false
	cb_busca.enabled=true
	btn_imprimir.enabled=true
	cdw_datos.enabled=true
	cdw_datos_detalle.enabled=true
	cdw_datos_detalle2.enabled=true
// end if


end event

event ue_guardar;
double v_val_A, v_val_B
datetime v_fecha_pago,v_fecha_op
long v_mon_a, v_mon_b, v_temp, v_mon_ant
v_val_A = cdw_datos.getitemnumber(1,"total_pago")
v_val_B = cdw_datos.getitemnumber(1,"total_detalle")

if (round(v_val_a,0) < round(v_val_b,0)) then
	aviso = MessageBox("Aviso", "El monto de pago es mayor al monto a pagar, favor verifique!!", Information! , ok!,1)
	if cdw_datos_detalle.rowcount() = 0 then
		cdw_datos_detalle2.InsertRow(0)
		cdw_datos_detalle2.SetFocus()
	end if
	return
end if

if (round(v_val_a,0) <> round(v_val_b,0)) then
	aviso = MessageBox("Aviso", "Valores de Pago no coinciden", Information! , ok!,1)
	if cdw_datos_detalle.rowcount() = 0 then
		cdw_datos_detalle2.InsertRow(0)
		cdw_datos_detalle2.SetFocus()
	end if
	return
end if

v_fecha_pago=cdw_datos.getitemdatetime( 1, 'fecha_pago')
v_fecha_op=cdw_datos.getitemdatetime( 1, 'fecha_op')
if v_fecha_pago<v_fecha_op then
	aviso = MessageBox("Aviso", "Fecha de Pago no puede ser menor a la fecha de la OP", Information! , ok!,1)
	cdw_datos.setfocus()
	cdw_datos.setcolumn( 'fecha_pago')
	cdw_datos.settext('')
end if

cdw_datos.setitem( 1, 'pagos_fecha_recibo',cdw_datos.getitemdatetime(1,'fecha_pago'))
if fn_validar_campos()= -1 then return
	If messagebox("SOFTPAN","¿Esta seguro que desea finalizar el proceso?", Exclamation!, yesno!, 2)=2 then return
	cdw_datos.Accepttext()
	cdw_datos_detalle.Accepttext()
		if cdw_datos.GetItemStatus ( 1, 0, Primary! ) = New! or cdw_datos.GetItemStatus ( 1, 0, Primary! ) = NewModified!  then 
			long v_sec,i
			v_sec=cdw_datos.getitemnumber( 1, 'nro_pago')
		
			for i=1 to cdw_datos_detalle.rowcount( )
				cdw_datos_detalle.setitem( i,'pagos_doc_nro_pago',v_sec)
				cdw_datos_detalle.setitem( i,'finiquito',1)
				
			next
			for i=1 to cdw_datos_detalle2.rowcount( )
				cdw_datos_detalle2.setitem( i,'nro_pago',v_sec)
				cdw_datos_detalle2.setitem( i,'finiquito',1)
			next
		
	end if

long fila_det
	if cdw_datos.update(true,false) = 1 then
		if cdw_datos_detalle.update(true,false) > 0 then
			if cdw_datos_detalle2.update(true,false) > 0 then
				cdw_datos.ResetUpdate()
				cdw_datos_detalle.ResetUpdate()
				cdw_datos_detalle2.ResetUpdate()
				commit using sqlca;
				triggerEvent("ue_insertar")
		  else
			   Rollback using sqlca;
			   MessageBox("Aviso","Error al grabar los detalles de pag")
		  end if
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al grabar los detalles de doc")
		end if
	else
		Rollback using sqlca;
		MessageBox("Aviso","Error al grabar la cabecera")
	end if



end event

event ue_eliminar;//if cdw_datos.rowcount() = 0 then return
///*if cdw_datos.getitemnumber(1,"finiquito") = 1 then
//	messagebox('Atención...', 'Orden de pago ya fue finiquitada, y no puede ser borrada...')
//	return
//end if*/
aviso = MessageBox("Aviso", "Desea borrar la transacción?", Question!, YesNo!,1)
IF aviso = 1 THEN 
		long fila_det
		long v_filas
	v_filas = cdw_datos_detalle2.RowCount()
		if cdw_datos_detalle2.RowCount() > 0 then
			for fila_det = 1 to v_filas
				cdw_datos_detalle2.DeleteRow(0)
			next
		end if		
		v_filas = cdw_datos_detalle.RowCount()
		if cdw_datos_detalle.RowCount() > 0 then
			for fila_det = 1 to v_filas
				cdw_datos_detalle.DeleteRow(0)
			next
		end if	
	cdw_datos.deleterow(1)
	if cdw_datos_detalle.update(true,false) = 1 then
		if cdw_datos_detalle2.update(true,false) > 0 then
			if cdw_datos.update(true,false) > 0 then
				cdw_datos.ResetUpdate()
				cdw_datos_detalle2.ResetUpdate()
				cdw_datos_detalle.ResetUpdate()
				commit using sqlca;
				triggerEvent("ue_insertar")
		  else
			   Rollback using sqlca;
			   MessageBox("Aviso","Error al grabar la cabecera")
		  end if
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al grabar los detalles de Pag")
		end if
	else
		Rollback using sqlca;
		MessageBox("Aviso","Error al grabar los detalles de Doc")
	end if
End IF


end event

event ue_leer;long cant_filas,cant_filas_det
any valor1, valor2, valor3
cdw_datos.accepttext()
ii_cant_claves=1
If cdw_datos.rowcount() = 0 then return
CHOOSE CASE ii_cant_claves
	CASE 1
		valor1 = f_tipo_columna(cdw_datos,1,1)
	CASE 2
		valor1 = f_tipo_columna(cdw_datos,1,1)
		valor2 = f_tipo_columna(cdw_datos,2,1)
	CASE 3
		valor1 = f_tipo_columna(cdw_datos,1,1)
		valor2 = f_tipo_columna(cdw_datos,2,1)
		valor3 = f_tipo_columna(cdw_datos,3,1)
END CHOOSE
cant_filas = cdw_datos.retrieve (valor1 ,valor2, valor3)  // *******

if cant_filas = 1 then
	cant_filas = cdw_datos_detalle.retrieve (valor1, valor2, valor3)
	cant_filas_det = cdw_datos_detalle2.retrieve(long(valor1))
	if cant_filas_det = 0 then
		MessageBox("Aviso de Error","El documento no posee detalles de los medios de pagos!")
	    this.TriggerEvent ("ue_insertar_valor_detalle2")
	else
			btn_agregar.enabled=false
			btn_guardar.enabled=true
			btn_modificar.enabled=true
			btn_cancelar.enabled=true
			btn_buscar.enabled=true
			btn_eliminar.enabled=false
			btn_agregar_detalle.enabled=false
			btn_quitar_detalle.enabled=false
			cb_busca.enabled=true
			btn_imprimir.enabled=true
			cdw_datos.enabled=true
			cdw_datos_detalle.enabled=true
			cdw_datos_detalle2.enabled=true
		rollback using sqlca;
	end if
elseif cant_filas = 0 then
	this.TriggerEvent ("ue_insertar")
else
	rollback using sqlca;
end if
cdw_datos.setfocus()
end event

type btn_eliminar from w_abm_cabecera_detalle_ancestor`btn_eliminar within w_abm_pago_proveedor
end type

type cb_busca from w_abm_cabecera_detalle_ancestor`cb_busca within w_abm_pago_proveedor
integer x = 3022
integer y = 936
boolean enabled = true
string text = "&Seleccionar"
end type

event cb_busca::clicked;call super::clicked;
if cdw_datos.rowcount() > 0 then
		vg_proveedor=cdw_datos.getitemnumber(cdw_datos.getrow(),'cod_proveedor')
		vg_moneda=cdw_datos.getitemnumber(cdw_datos.getrow(),'cod_moneda')
		
		if isnull(vg_proveedor) or vg_proveedor=0 then
				messagebox('Aviso','No existe proveedor a seleccionar los documentos a pagar!')
				cdw_datos.setcolumn( 'cod_proveedor')
				cdw_datos.setfocus( )
				return
			end if
			
			openwithparm( w_busqueda_ctas_pagar , cdw_datos_detalle )
			
			cdw_datos.accepttext() 
			cdw_datos_detalle.accepttext() 
			long v_tip_doc, v_temp
			long ll_Calc_imp
			for v_temp = 1 to cdw_datos_detalle.RowCount()
				v_tip_doc = cdw_datos_detalle.getitemnumber(v_temp,"pagos_doc_cod_tipo_comprobante")
				select calcula_imp into :ll_Calc_imp from tipo_comprobante where cod_tipo_comprobante= :v_tip_doc;
				cdw_datos_detalle.setitem(v_temp, "tipo_comprobante_calcula_imp", ll_Calc_imp)
			next	
			cdw_datos_detalle.TriggerEvent("ue_total_detalle")	
	end if
end event

type pb_ultimo from w_abm_cabecera_detalle_ancestor`pb_ultimo within w_abm_pago_proveedor
boolean visible = false
integer x = 2935
integer y = 2284
integer height = 108
boolean enabled = false
end type

type pb_siguiente from w_abm_cabecera_detalle_ancestor`pb_siguiente within w_abm_pago_proveedor
boolean visible = false
integer x = 2747
integer y = 2284
integer height = 108
boolean enabled = false
end type

type pb_anterior from w_abm_cabecera_detalle_ancestor`pb_anterior within w_abm_pago_proveedor
boolean visible = false
integer x = 2560
integer y = 2284
integer height = 108
boolean enabled = false
end type

type btn_uttimo from w_abm_cabecera_detalle_ancestor`btn_uttimo within w_abm_pago_proveedor
boolean visible = false
integer x = 2382
integer y = 2284
integer height = 108
boolean enabled = false
end type

type ole_skin from w_abm_cabecera_detalle_ancestor`ole_skin within w_abm_pago_proveedor
integer x = 3611
integer y = 736
end type

type btn_buscar from w_abm_cabecera_detalle_ancestor`btn_buscar within w_abm_pago_proveedor
end type

type btn_cancelar from w_abm_cabecera_detalle_ancestor`btn_cancelar within w_abm_pago_proveedor
end type

event btn_cancelar::clicked;if messagebox("CANCELAR",'Quieres cancelar los cambios',question!,okcancel!,2)=1 then
//	if cdw_datos.retrieve( )<=0 then
	btn_agregar.triggerevent( clicked!)
//	else
//		cdw_datos.reset()
	//	cdw_datos.retrieve()

//	end if

	btn_cancelar.enabled=false
	btn_modificar.enabled=true
	btn_agregar.enabled=true
	btn_buscar.enabled=true
	btn_eliminar.enabled=true
end if
end event

type btn_modificar from w_abm_cabecera_detalle_ancestor`btn_modificar within w_abm_pago_proveedor
end type

type btn_guardar from w_abm_cabecera_detalle_ancestor`btn_guardar within w_abm_pago_proveedor
end type

type btn_agregar from w_abm_cabecera_detalle_ancestor`btn_agregar within w_abm_pago_proveedor
end type

type st_9 from w_abm_cabecera_detalle_ancestor`st_9 within w_abm_pago_proveedor
integer x = 1509
integer y = 1820
end type

type st_8 from w_abm_cabecera_detalle_ancestor`st_8 within w_abm_pago_proveedor
integer x = 923
integer y = 1820
end type

type st_7 from w_abm_cabecera_detalle_ancestor`st_7 within w_abm_pago_proveedor
integer x = 1509
integer y = 1716
end type

type st_6 from w_abm_cabecera_detalle_ancestor`st_6 within w_abm_pago_proveedor
integer x = 923
integer y = 1720
end type

type st_5 from w_abm_cabecera_detalle_ancestor`st_5 within w_abm_pago_proveedor
integer x = 219
integer y = 1720
end type

type st_4 from w_abm_cabecera_detalle_ancestor`st_4 within w_abm_pago_proveedor
integer x = 210
integer y = 1820
end type

type btn_imprimir from w_abm_cabecera_detalle_ancestor`btn_imprimir within w_abm_pago_proveedor
integer x = 3022
integer y = 1064
string text = "I&mprimir"
end type

type btn_quitar_detalle from w_abm_cabecera_detalle_ancestor`btn_quitar_detalle within w_abm_pago_proveedor
boolean visible = false
integer x = 1920
integer y = 1384
boolean enabled = false
end type

type btn_agregar_detalle from w_abm_cabecera_detalle_ancestor`btn_agregar_detalle within w_abm_pago_proveedor
boolean visible = false
integer x = 1934
integer y = 1408
boolean enabled = false
end type

type st_1 from w_abm_cabecera_detalle_ancestor`st_1 within w_abm_pago_proveedor
integer height = 2420
end type

type btn_salir from w_abm_cabecera_detalle_ancestor`btn_salir within w_abm_pago_proveedor
end type

type cdw_datos_detalle from w_abm_cabecera_detalle_ancestor`cdw_datos_detalle within w_abm_pago_proveedor
event ue_total_detalle ( )
event ue_enter pbm_dwnprocessenter
event ue_borrar_detalle_pago ( )
event ue_tecla_pulsada pbm_dwnkey
integer x = 183
integer y = 876
integer width = 2830
integer height = 584
string dataobject = "dw_abm_pagos_doc"
end type

event cdw_datos_detalle::ue_total_detalle();cdw_datos.accepttext() 
cdw_datos_detalle.accepttext() 

double v_total
if this.rowcount() > 0 then
	v_total = this.getitemnumber(this.rowcount(),"c_total_pagado")
else
	v_total = 0
end if
cdw_datos.setitem(1,'total_pago',v_total)	





end event

event cdw_datos_detalle::ue_borrar_detalle_pago();
aviso = MessageBox("Aviso", "Desea borrar este detalle?", Question!, YesNo!,1)

IF aviso = 1 THEN 
	long fila_det, fila_actual
	if this.RowCount() > 0 then
		this.DeleteRow(0)
		fila_actual = this.GetRow()
		this.SetRow(fila_actual)
		this.SetFocus()
  		this.TriggerEvent("ue_total_detalle")
   end if

END IF


end event

event cdw_datos_detalle::ue_tecla_pulsada;if keydown(keyf12!) then
   this.triggerEvent("ue_borrar_detalle_pago")
elseif  keydown(keyf8!) then
	parent.triggerEvent("ue_insertar_valor_detalle")
end if
end event

event cdw_datos_detalle::itemchanged;cdw_datos.accepttext() 
this.accepttext() 

this.TriggerEvent("ue_total_detalle")	
end event

type cdw_datos from w_abm_cabecera_detalle_ancestor`cdw_datos within w_abm_pago_proveedor
integer height = 516
string dataobject = "dw_abm_pago"
end type

event cdw_datos::itemchanged;call super::itemchanged;if getcolumnname()='cod_proveedor' then
		long ll_proveedor
		ll_proveedor=long(data)
			string ls_razon_social
			select nombre_fantasia
			into :ls_razon_social
			from personas where cod_persona=:ll_proveedor;
			
			this.setitem(this.getrow(),'nombre_proveedor', ls_razon_social)
			

	end if
if getcolumnname()='fecha_pago' then
	if datetime(data)<this.getitemdatetime (this.getrow(),'fecha_op') then
		messagebox('Aviso','Fecha de Pago debe ser mayor o igual al de la Orden de Pago!!')
		this.setfocus( )
		this.setcolumn( 'fecha_op')
		post settext( '')
   end if
	
end if
end event

type st_2 from w_abm_cabecera_detalle_ancestor`st_2 within w_abm_pago_proveedor
end type

type st_3 from w_abm_cabecera_detalle_ancestor`st_3 within w_abm_pago_proveedor
boolean visible = false
integer x = 2331
integer y = 2256
integer height = 168
boolean enabled = false
end type

type cdw_datos_detalle2 from datawindow within w_abm_pago_proveedor
event ue_columna2 ( )
event ue_total_detalle2 ( )
event ue_borrar_detalle_pago ( )
event ue_enter pbm_dwnprocessenter
event ue_tecla_pulsada pbm_dwnkey
integer x = 187
integer y = 1572
integer width = 3150
integer height = 548
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_abm_detalle_medios_pagos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_columna2();integer v_TipCon
integer v_CodCond
string v_CodPro
this.accepttext( )
//*******************************************************************************************
	v_CodCond = this.getitemnumber(getrow(),"cod_condicion")
	v_CodPro = string(cdw_datos.getitemnumber(1,"cod_proveedor"))
// ******************************************************************************************
	//Define Tipo Condicion
	SELECT Tipo_condicion 
	INTO :v_TipCon
	FROM condiciones_pagos 
	WHERE Cod_condicion = :v_CodCond ;
	// Nro Cheque
	If v_TipCon = 1 then // Bloquea Campos
	//messagebox('aaaa','entro 1')
		this.Modify("nro_cheque.Protect=0") 
		this.Modify("nro_cheque.Background.COLOR='1090519039'")  
	
		
	else 
	//	messagebox('aaaa','entro 2')
		this.Modify("nro_cheque.Protect=1") 
		this.Modify("nro_cheque.Background.COLOR='128128128'")    
	
	end if

	if v_codcond=2 then
		cb_seleccionar.visible=true
	else
		cb_seleccionar.visible=false
	end if
	this.setitem(this.getrow(), 'cod_moneda',1)

end event

event ue_total_detalle2();cdw_datos.accepttext() 
cdw_datos_detalle.accepttext() 
cdw_datos_detalle2.accepttext() 

long v_fil_det, v_mon, v_mon_des
double v_tot, v_valor, v_Cam
datetime v_fec
v_fec = cdw_datos.getitemdatetime(1,"fecha_op")
v_mon_des= cdw_datos.getitemnumber(1,"cod_moneda")
v_tot = 0
for V_fil_det = 1 to cdw_datos_detalle.RowCount()
	v_valor = this.getitemnumber(V_fil_det,"valor")
	v_Mon = this.getitemnumber(V_fil_det,"cod_moneda")
	v_Cam = this.getitemnumber(V_fil_det,"cotizacion")	
	v_tot = v_tot + f_cambiar(v_valor, v_fec, v_mon, v_mon_des, v_cam)
next
cdw_datos.setitem(1,'total_detalle', v_tot)	

end event

event ue_borrar_detalle_pago();aviso = MessageBox("Aviso", "Desea borrar este medio de pago?", Question!, YesNo!,1)

IF aviso = 1 THEN 
	long fila_det, fila_actual
	if this.RowCount() > 0 then
		this.DeleteRow(0)
		fila_actual = this.GetRow()
		this.SetRow(fila_actual)
		this.SetFocus()
  		this.TriggerEvent("ue_total_detalle2")
   end if

END IF


end event

event ue_enter;Send(Handle(this),256,9,Long(0,0)) 
Return 1
end event

event ue_tecla_pulsada;if keydown(keyf12!) then
   this.triggerEvent("ue_borrar_detalle_pago")
elseif  keydown(keyf8!) then
	parent.triggerEvent("ue_insertar_valor_detalle2")
end if
end event

event itemchanged;long ll_cta, ll_calc_imp

if row > 0 THEN
   if this.getcolumnname() = "cod_condicion" then // Valor Actualizado Codigo Cond
		this.TriggerEvent("ue_columna2")
	end if
	
	if this.getcolumnname() = "nro_cuenta" then
		ll_cta = this.getitemnumber(getrow(),"nro_cuenta") 
		select calcula_imp into :ll_calc_imp from cuentas_cajas where nro_cuenta=:ll_cta;
		this.setItem(getrow(),"calc_imp_cta", ll_calc_imp)
	end if
	
	this.TriggerEvent("ue_total_detalle2")
end if

end event

type cb_seleccionar from commandbutton within w_abm_pago_proveedor
boolean visible = false
integer x = 1737
integer y = 1472
integer width = 617
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
string text = "Seleccionar Cheques"
end type

event clicked;if cdw_datos_detalle2.rowcount() = 0 then return
string v_cta_txt, v_tip_ch
long v_cuenta,v_nro_cheque
double v_importe_cheque
v_cuenta = cdw_datos_detalle2.getitemnumber(1, 'nro_cuenta')
//messagebox('aaaa',string(v_cuenta))
if isnull(v_cuenta) or v_cuenta=0 then
	messagebox('Aviso','Ingrese la cuenta de la Caja a emitir el cheque')
    cdw_datos_detalle2.setcolumn( 'nro_cuenta')
	 cdw_datos_detalle2.setfocus( )
	return
end if
vg_input_numero=v_cuenta
select nombre_cuenta into :v_cta_txt 
from cuentas_cajas where nro_cuenta = :v_cuenta;
openwithparm(w_seleccionar_cheque_pago, 'Seleccionar nro de cheque para la  cuenta ' + v_cta_txt)
if vg_input_return = 0 then
   v_nro_cheque = 0
else
	v_nro_cheque = vg_input_numero
end if
select importe into:v_importe_cheque from cheques where nro_cheque=:v_nro_cheque and nro_cta=:v_cuenta;
cdw_datos_detalle2.setitem(1, 'nro_cheque', v_nro_cheque)
cdw_datos_detalle2.setitem(1, 'valor', v_importe_cheque)
cdw_datos_detalle2.setitem(1, 'cod_moneda', cdw_datos.getitemnumber(1,'cod_moneda'))

end event


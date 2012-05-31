$PBExportHeader$w_abm_anticipo.srw
forward
global type w_abm_anticipo from w_modelo_abm_cab_det_general_c1
end type
type cdw_det_1 from datawindow within w_abm_anticipo
end type
type dw_busca from datawindow within w_abm_anticipo
end type
type dw_print from uo_datawindow within w_abm_anticipo
end type
end forward

global type w_abm_anticipo from w_modelo_abm_cab_det_general_c1
integer x = 0
integer y = 0
integer width = 3598
integer height = 1796
string title = "Anticipo - Clientes"
cdw_det_1 cdw_det_1
dw_busca dw_busca
dw_print dw_print
end type
global w_abm_anticipo w_abm_anticipo

type variables
string v_columna
end variables

on w_abm_anticipo.create
int iCurrent
call super::create
this.cdw_det_1=create cdw_det_1
this.dw_busca=create dw_busca
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_det_1
this.Control[iCurrent+2]=this.dw_busca
this.Control[iCurrent+3]=this.dw_print
end on

on w_abm_anticipo.destroy
call super::destroy
destroy(this.cdw_det_1)
destroy(this.dw_busca)
destroy(this.dw_print)
end on

event open;cdw_cabecera.settransobject(sqlca)
cdw_detalle.settransobject(sqlca)
cdw_det_1.settransobject(sqlca)
dw_print.settransobject(sqlca)

//*** Filtra Nro Cta
DataWindowChild cdw_NroCta
cdw_det_1.GetChild("nro_cheque", cdw_NroCta)
cdw_NroCta.SetTransObject(SQLCA)
cdw_NroCta.InsertRow(0)

cdw_cabecera.SetColumn(1) 
cdw_cabecera.SetFocus()
triggerevent("ue_parametros")
triggerevent("ue_insertar")
grabar="0"


end event

event ue_elimina_nulos;long V_fil_det
//********************************************************************************************
if cdw_detalle.RowCount() > 0 then
	for V_fil_det = 1 to cdw_detalle.RowCount()
		if isnull(cdw_detalle.GetItemNumber(V_fil_det,2)) then
			cdw_detalle.DeleteRow(V_fil_det)
		end if
	next
end if

end event

event ue_grabar;cdw_cabecera.accepttext()
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

cdw_det_1.triggerEvent("ue_elimina_nulos")
cdw_detalle.triggerEvent("ue_elimina_nulos")

string ls_obs
ls_obs = ' '
ls_obs = cdw_cabecera.getitemstring(1, 'observacion')
		
if isnull(ls_obs)  or len(ls_obs) < 5 then
	MessageBox("Aviso", "Debe cargar la observación...")
	cdw_cabecera.setcolumn('observacion')
	cdw_cabecera.setfocus()
	return
end if

long ll_tipo_doc, ll_calc_imp_tipo, ll_filas, ll_tipo_cuenta, ll_calc_imp_cuenta

ll_tipo_doc = cdw_cabecera.getitemnumber(1, 'anticipo_cab_tipo_documen')
select calc_imp into :ll_calc_imp_tipo from tipo_documentos where tipo_documen = :ll_tipo_doc;

for ll_filas = 1 to cdw_det_1.rowcount()
	ll_tipo_cuenta = cdw_det_1.getitemnumber(ll_filas,'nro_cuenta')
	select calc_imp into :ll_calc_imp_cuenta from Cuentas_cajas where nro_cuenta = :ll_tipo_cuenta;
	if ll_calc_imp_tipo <> ll_calc_imp_cuenta then
		messagebox('Aviso...','Calcula impuesto documento distinto a calcula impuesto cuenta...')
		cdw_det_1.setrow(ll_filas)
		cdw_det_1.setcolumn('nro_cuenta')
		cdw_det_1.setfocus()
		return
	end if
	
next


aviso = MessageBox("Aviso", "Desea grabar la transacción?", Question!, YesNo!,1)
	
IF aviso = 1 THEN 
	
		long fila_det
		if cdw_cabecera.update(true,false) = 1 then
//			f_existe_padre('nro_cobro', 'cobros_fac' , cdw_cabecera.getitemnumber(1, 'nro_cobro'))
			if cdw_detalle.update(true,false) > 0 then
				if cdw_det_1.update(true,false) > 0 then
					cdw_cabecera.ResetUpdate()
					cdw_detalle.ResetUpdate()
					cdw_det_1.ResetUpdate()
					commit using sqlca;
					aviso = MessageBox("Atención !!!", "Desea Imprimir el anticipo? ", Question!, YesNo!,2)
					IF aviso = 1 THEN 	
						dw_print.retrieve(cdw_cabecera.GetItemNumber(1,"nro_anticipo"))
						dw_print.print()
						long ll_nro_anticipo
						ll_nro_anticipo = cdw_cabecera.GetItemNumber(1,"nro_anticipo")
						update anticipo_cab set impreso = 1 where nro_anticipo = :ll_nro_anticipo using sqlca;
					end if
					triggerEvent("ue_insertar")
			else
				Rollback using sqlca;
				MessageBox("Aviso","Error al grabar los detalles de Ent")
			end if
		else
				Rollback using sqlca;
				MessageBox("Aviso","Error al grabar los detalles de Sal")
			end if
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al grabar la cabecera")
		end if
		grabar="0"
	
end if	




end event

event ue_insertar;cdw_cabecera.reset()
cdw_cabecera.InsertRow(0)

cdw_detalle.reset()
//cdw_detalle.InsertRow(0)
//
cdw_det_1.reset()
//cdw_det_1.InsertRow(0)

////Bloquea campo cod_cliente
cdw_cabecera.Modify("cod_cliente.Protect=0") 
cdw_cabecera.Modify("cod_cobrador.Protect=0") 
col_clave= 1

long v_maximo
cdw_cabecera.setcolumn(col_clave)

select max(nro_anticipo) as Valor into :v_maximo from anticipo_cab;


if isnull(v_maximo) then
	v_maximo = 1
else
	v_maximo = v_maximo +1
end if
cdw_cabecera.SetItem(1,col_clave,v_maximo)
//**


cdw_cabecera.setitem(1,"fecha",parsys_fecha_sys() )
if parsys_nro_cta_det() = 1 then
	cdw_det_1.Modify("nro_cuenta.Protect=0") 
	cdw_det_1.Modify("nro_cuenta.Background.COLOR='1090519039'")    		
else
	cdw_det_1.Modify("nro_cuenta.Protect=1") 	
	cdw_det_1.Modify("nro_cuenta.Background.COLOR='128128128'")    		
end if

cdw_det_1.InsertRow(0)
cdw_det_1.SetColumn(primer_col_disp_det)
cdw_det_1.SetFocus()

long v_pla, v_cta

v_cta = long(ProfileString("PEGASUS.INI", vg_emp_cab, "NC", "0"))
select nro_planilla into :v_pla from cuentas_cajas where nro_cuenta = :v_cta;
cdw_det_1.setitem(cdw_det_1.rowcount(), 'nro_cuenta', v_cta)
cdw_det_1.setitem(cdw_det_1.rowcount(), 'nro_plan', v_pla)

grabar="1"


cdw_cabecera.SetColumn(1)
cdw_cabecera.Setfocus()
grabar="0"
vi_situacion = 4

end event

event ue_leer;cdw_cabecera.accepttext()

long cant_filas_cab, cant_filas_det
tipo_valor = cdw_cabecera.describe("#"+string(col_clave_cab)+".coltype")
valor = cdw_cabecera.Gettext()

if tipo_valor = "number" or left(tipo_valor,7)="decimal" then
	cant_filas_cab = cdw_cabecera.retrieve(long(valor))
elseif tipo_valor="long" then
	cant_filas_cab = cdw_cabecera.retrieve(long(valor))
elseif left(tipo_valor,4)="char" then
	cant_filas_cab = cdw_cabecera.retrieve(valor)
elseif tipo_valor ="date" then
	cant_filas_cab = cdw_cabecera.retrieve(date(valor))
end if

if cant_filas_cab = 1 then

	// Retrive Det_1
	if tipo_valor = "number" or left(tipo_valor,7)="decimal"  then
		cant_filas_det = cdw_det_1.retrieve(long(valor))
	elseif tipo_valor="long" then
		cant_filas_det = cdw_det_1.retrieve(long(valor))
	elseif left(tipo_valor,4)="char" then
		cant_filas_det = cdw_det_1.retrieve(valor)
	elseif tipo_valor ="date" then
		cant_filas_det = cdw_det_1.retrieve(date(valor))
	end if
	
	if cant_filas_det > 0 then
	   //Bloquea campo cod_cliente
		cdw_cabecera.Modify("cod_cliente.Protect=1") 
		cdw_cabecera.Modify("cod_cobrador.Protect=1") 
		
		vi_situacion = 2
		commit using sqlca;
   elseif cant_filas_det = 0 then
		MessageBox("Aviso de Error","El documento no posee detalles!!")
      cdw_det_1.reset()
      cdw_det_1.insertrow(0)
	else
		Rollback using sqlca;
		MessageBox("Aviso","Error en la lectura del detalle")
	end if	


elseif cant_filas_cab = 0 then
	triggerEvent("ue_insertar")
	if tipo_valor="number" or left(tipo_valor,7)="decimal" then
		cdw_cabecera.SetItem(1,col_clave_cab,long(valor))
	elseif tipo_valor="long" then
		cdw_cabecera.SetItem(1,col_clave_cab,long(valor))
	elseif left(tipo_valor,4)="char" then
		cdw_cabecera.SetItem(1,col_clave_cab,valor)
	elseif tipo_valor ="date" then
		cdw_cabecera.SetItem(1,col_clave_cab,date(valor))
	end if
else
	Rollback using sqlca;
	MessageBox("Aviso","Error en la lectura de la cabecera")
end if

cdw_cabecera.SetFocus()
grabar="0"


end event

event resize;call super::resize;this.Move ( 0, 0 )
end event

event ue_borrar;aviso = MessageBox("Aviso", "Desea borrar la transacción?", Question!, YesNo!,1)

IF aviso = 1 THEN 
	long fila_det
	long v_filas
	v_filas = cdw_detalle.RowCount()
	if cdw_detalle.RowCount() > 0 then
		for fila_det = 1 to v_filas
			cdw_detalle.DeleteRow(0)
		next
	end if		
	v_filas = cdw_det_1.RowCount()
	if cdw_det_1.RowCount() > 0 then
		for fila_det = 1 to v_filas
			cdw_det_1.DeleteRow(0)
		next
	end if		

		if cdw_det_1.update(true,false) > 0 then
			if cdw_detalle.update(true,false) > 0 then
				cdw_cabecera.DeleteRow(0)
				if cdw_cabecera.update(true,false) = 1 then
					cdw_det_1.ResetUpdate()
					cdw_detalle.ResetUpdate()
					cdw_cabecera.ResetUpdate()
					commit using sqlca;
					TriggerEvent("ue_insertar")
				else
					Rollback using sqlca;
					MessageBox("Aviso","Error al borrar la cabecera")
					return
				end if
			else
				Rollback using sqlca;
				MessageBox("Aviso","Error al grabar los detalles")
				return
			End IF	
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al grabar los detalles")
			return
		End IF	

End IF


end event

event ue_buscar;//open(w_busca_recibo_cobros)
//if vg_nro_reg > 0 then
//	cdw_cabecera.retrieve(vg_nro_reg)
//	cdw_detalle.retrieve(vg_nro_reg)
//	cdw_det_1.retrieve(vg_nro_reg)
//end if
//
//
//
//
end event

type st_menu from w_modelo_abm_cab_det_general_c1`st_menu within w_abm_anticipo
integer x = 151
end type

type cdw_detalle from w_modelo_abm_cab_det_general_c1`cdw_detalle within w_abm_anticipo
event ue_borra_detalle_2 ( )
event ue_insertar_det_2 ( )
event ue_elimina_nulos ( )
event ue_focus_cabecera ( )
boolean visible = false
integer x = 27
integer y = 1064
integer width = 2939
integer height = 532
borderstyle borderstyle = stylelowered!
end type

event cdw_detalle::ue_borra_detalle_2;aviso = MessageBox("Aviso", "Desea borrar este detalle?", Question!, YesNo!,1)

IF aviso = 1 THEN 
	long fila_det, fila_actual
	if cdw_detalle.RowCount() > 0 then
		cdw_detalle.DeleteRow(0)
		fila_actual = cdw_detalle.GetRow()
		cdw_detalle.SetRow(fila_actual)
		cdw_detalle.SetFocus()
		cdw_detalle.SetColumn(primer_col_disp_det)

		if cdw_detalle.RowCount() < 1 then
			this.TriggerEvent("ue_insertar_det_2")
		end if	
	end if
END IF

end event

event cdw_detalle::ue_insertar_det_2;this.InsertRow(0)
this.SetColumn(primer_col_disp_det)
this.SetFocus()
grabar="1"
end event

event cdw_detalle::ue_elimina_nulos;long V_fil_det
//********************************************************************************************
if cdw_detalle.RowCount() > 0 then
	for V_fil_det = 1 to cdw_detalle.RowCount()
		if isnull(cdw_detalle.GetItemnumber(V_fil_det,2)) then
			cdw_detalle.DeleteRow(V_fil_det)
		end if
	next
end if

end event

event cdw_detalle::ue_focus_cabecera;cdw_cabecera.SetFocus()
cdw_cabecera.setcolumn(v_columna)              
return 
end event

event cdw_detalle::itemchanged;cdw_cabecera.accepttext() 
cdw_detalle.accepttext() 

if (row >= 1 ) THEN
   if this.getcolumnname() = "cod_condicion" then 
		cdw_detalle.TriggerEvent("ue_columna_02")
   elseif this.getcolumnname() = "cod_banco" then 
		cdw_detalle.TriggerEvent("ue_columna_03")
   elseif this.getcolumnname() = "importe" then 
		cdw_detalle.TriggerEvent("ue_act_tot_det")
	else
		grabar="1"
	end if
end if

end event

event cdw_detalle::ue_tecla_pulsada;if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
elseif keydown(keyf12!) then
   this.triggerEvent("ue_borra_detalle_2")
end if

end event

event cdw_detalle::getfocus;call super::getfocus;cdw_cabecera.accepttext() 
cdw_det_1.accepttext() 

if isnull(string(cdw_cabecera.getitemnumber(1,"cod_cliente"))) then // Cliente
	aviso = MessageBox("Atencion !!!", "Cliente no puede ser Nulo", StopSign!, OK! ,1)
   this.postevent("ue_focus_cabecera")	
	v_columna = "cod_cliente"
	return 
end if

if isnull(string(cdw_cabecera.getitemnumber(1,"cod_cobrador"))) then // Cobrador
	aviso = MessageBox("Atencion !!!", "Cobrador no puede ser Nulo", StopSign!, OK! ,1)
   this.postevent("ue_focus_cabecera")	
	v_columna = "cod_cobrador"
	return 
end if

if isnull(string(cdw_cabecera.getitemdatetime(1,"fecha"))) then // Fecha
	aviso = MessageBox("Atencion !!!", "Fecha no puede ser Nulo", StopSign!, OK! ,1)
   this.postevent("ue_focus_cabecera")	
	v_columna = "fecha"
	return 
end if


end event

event cdw_detalle::ue_enter;
integer ls_colcount 
integer ls_colact
integer ls_rowact 

ls_colcount = long(This.Object.DataWindow.Column.Count)
ls_colact   = This.getcolumn()
ls_rowact = this.getrow()
if this.RowCount() = this.GetRow() and (ls_colcount = ls_colact) then // 
		this.TriggerEvent("ue_insertar_det_2")
else

int v_sec
int v_sec_sal
int v_columnas, n
int v_col
v_col = this.GetColumn()
v_sec_sal = long(this.Describe("#" + string(v_col) + ".TabSequence"))
v_columnas = long(this.Object.DataWindow.Column.Count)
FOR n = 1 to v_columnas 
v_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
if (v_sec_sal + 10) = v_sec then
   this.setcolumn(n)
	exit
end if
NEXT
if v_sec_sal = (v_columnas*10) then
   this.setcolumn(1)
end if

end if


end event

type cdw_cabecera from w_modelo_abm_cab_det_general_c1`cdw_cabecera within w_abm_anticipo
integer x = 9
integer y = 8
integer width = 3675
integer height = 1672
integer taborder = 0
string dataobject = "dw_abm_anticipo_cab"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event cdw_cabecera::itemchanged;if this.GetColumn() = col_clave_cab then
	parent.TriggerEvent("ue_leer")
else
	grabar="1"
end if

guo_func.of_find_descrip ( cdw_cabecera, dw_busca)




end event

event cdw_cabecera::ue_tecla_pulsada;call super::ue_tecla_pulsada;if keydown(keyf3!) then 
	guo_func.of_find_cdw (cdw_cabecera )
end if


end event

type cb_cerrar from w_modelo_abm_cab_det_general_c1`cb_cerrar within w_abm_anticipo
integer taborder = 0
end type

type cdw_det_1 from datawindow within w_abm_anticipo
event ue_borrar_detalle_1 ( )
event ue_columna_02 ( )
event ue_elimina_nulos ( )
event ue_enter pbm_dwnprocessenter
event ue_tecla_pulsada pbm_dwnkey
event ue_insertar_det_1 ( )
event ue_focus_cabecera ( )
event ue_columna_03 ( )
event ue_act_tot_cab ( )
integer x = 18
integer y = 868
integer width = 3547
integer height = 784
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_abm_anticipo_det"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_borrar_detalle_1;aviso = MessageBox("Aviso", "Desea borrar este detalle?", Question!, YesNo!,1)
IF aviso = 1 THEN 
	long fila_det, fila_actual
	if this.RowCount() > 0 then
		this.DeleteRow(0)
		fila_actual = this.GetRow()
		this.SetRow(fila_actual)
		this.SetFocus()
		this.SetColumn(primer_col_disp_det)
  		this.TriggerEvent("ue_act_tot_cab")		
   end if
	if this.RowCount() < 1 then
		this.TriggerEvent("ue_insertar_det_1")
	end if	
END IF


end event

event ue_columna_02;integer v_TipCon
long v_CodCond
LONG V_CAJERO
//*******************************************************************************************
	v_CodCond = this.getitemnumber(getrow(),"cod_condicion")
	V_CAJERO = CDW_CABECERA.getitemnumber(1,"anticipo_cab_cod_cajero")	
// ******************************************************************************************


	//Define Tipo Condicion
	SELECT Cond_pagos.Tipo_condicion 
	INTO :v_TipCon
	FROM Cond_pagos 
	WHERE Cond_pagos.Cod_condicion = :v_CodCond ;

	// Tarjeta
	If v_TipCon = 2 then // Bloquea Campos
		this.Modify("cod_tarjeta.Protect=0") 
		this.Modify("cod_tarjeta.Background.COLOR='1090519039'")    
	else 
		this.Modify("cod_tarjeta.Protect=1") 
		this.Modify("cod_tarjeta.Background.COLOR='128128128'")    
   end if


	If v_TipCon = 1 then // Bloquea Campos
		this.Modify("fecha_cheque.Protect=0") 
		this.Modify("fecha_cheque.Background.COLOR='1090519039'")    
		this.Modify("nro_cheque.Protect=0") 
		this.Modify("nro_cheque.Background.COLOR='1090519039'")    		
		this.Modify("librador.Protect=0") 
		this.Modify("librador.Background.COLOR='1090519039'")    		
		this.Modify("fecha_ch_emision.Protect=0") 
		this.Modify("fecha_ch_emision.Background.COLOR='1090519039'")    		
		this.Modify("cuenta.Protect=0") 
		this.Modify("cuenta.Background.COLOR='1090519039'")    		
		this.Modify("cod_banco.Protect=0") 
		this.Modify("cod_banco.Background.COLOR='1090519039'")    		
	else 
		this.Modify("fecha_cheque.Protect=1") 
		this.Modify("fecha_cheque.Background.COLOR='128128128'")    
		this.Modify("nro_cheque.Protect=1") 
		this.Modify("nro_cheque.Background.COLOR='128128128'")    		
		this.Modify("librador.Protect=1") 
		this.Modify("librador.Background.COLOR='128128128'")    		
		this.Modify("fecha_ch_emision.Protect=1") 
		this.Modify("fecha_ch_emision.Background.COLOR='128128128'")    		
		this.Modify("cuenta.Protect=1") 
		this.Modify("cuenta.Background.COLOR='128128128'")    		
		this.Modify("cod_banco.Protect=1") 
		this.Modify("cod_banco.Background.COLOR='128128128'")    		
   end if	
	
//Define nro cuenta
if parsys_nro_cta_det() = 1 then
	LONG v_CTA_CAJ
	SELECT NRO_CUENTA 
	INTO :v_CTA_CAJ
	FROM CAJEROS 
	WHERE CAJEROS.COD_CAJERO = :V_CAJERO ;	
	
else
	 v_CTA_CAJ = 0
end if

	
	
	
	long V_CodReg
	V_CodReg = long(cdw_Cabecera.getitemNumber(1,"nro_anticipo"))
	this.SetItem(getrow(), "nro_anticipo", V_CodReg)
   THIS.SetItem(getrow(), "nro_CUENTA", v_CTA_CAJ)	
end event

event ue_elimina_nulos;long V_fil_det
//********************************************************************************************
if this.RowCount() > 0 then
	for V_fil_det = 1 to this.RowCount()
		if isnull(this.GetItemnumber(V_fil_det,2)) then
			this.DeleteRow(V_fil_det)
		end if
	next
end if

end event

event ue_enter;
integer ls_colcount 
integer ls_colact
integer ls_rowact 

ls_colcount = long(This.Object.DataWindow.Column.Count)
ls_colact   = This.getcolumn()
ls_rowact = this.getrow()
if this.RowCount() = this.GetRow() and (ls_colcount = ls_colact) then // 
		this.TriggerEvent("ue_insertar_det_1")
else

int v_sec
int v_sec_sal
int v_columnas, n
int v_col
v_col = this.GetColumn()
v_sec_sal = long(this.Describe("#" + string(v_col) + ".TabSequence"))
v_columnas = long(this.Object.DataWindow.Column.Count)
FOR n = 1 to v_columnas 
v_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
if (v_sec_sal + 10) = v_sec then
   this.setcolumn(n)
	exit
end if
NEXT
if v_sec_sal = (v_columnas*10) then
   this.setcolumn(1)
end if

end if


end event

event ue_tecla_pulsada;if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
elseif keydown(keyf12!) then
 this.triggerEvent("ue_borrar_detalle_1")
end if

end event

event ue_insertar_det_1;this.InsertRow(0)
this.SetColumn(primer_col_disp_det)
this.SetFocus()
grabar="1"
end event

event ue_focus_cabecera;cdw_cabecera.SetFocus()
cdw_cabecera.setcolumn(v_columna)              
return 
end event

event ue_columna_03;long v_NroCta, v_CodCli
long v_Bco_a, v_Bco_b
string v_Cta_a, v_Cta_b
string v_librador_a, v_librador_b
//*******************************************************************************************
   v_CodCli = cdw_cabecera.getitemnumber(1,"cod_cliente")
	v_NroCta = this.getitemnumber(getrow(),"cod_banco")
// ******************************************************************************************

	//Define Datos del Cliente
	SELECT Clientes.Cod_banco_a, 
	Clientes.Cuenta_a, 
	Clientes.TITULAR_A,
	Clientes.Cod_banco_b, 
	Clientes.Cuenta_b,
	Clientes.TITULAR_B	
	INTO :v_Bco_a,
	:v_Cta_a,
	:v_librador_a,
	:v_Bco_b,
	:v_Cta_b,
	:v_librador_b
	FROM Clientes 
	WHERE Clientes.Cod_cliente = :v_CodCli ;

	if v_NroCta = v_Bco_a then
		this.SetItem(getrow(), "cuenta", v_Cta_a)
		this.SetItem(getrow(), "librador", v_librador_a)		
   end if

	if v_NroCta = v_Bco_b then
		this.SetItem(getrow(), "cuenta", v_Cta_b)
		this.SetItem(getrow(), "librador", v_librador_a)				
	end if





end event

event ue_act_tot_cab;cdw_det_1.accepttext() 

double V_Tval
long V_fil_det
double ac_val , v_tot

double v_Valor
double v_Coti
long v_Mon,v_MonCab
datetime v_fec

// Actualiza Valores de Totales en Cabecera
ac_val =0
for V_fil_det = 1 to cdw_det_1.RowCount()
	v_MonCab = cdw_cabecera.getitemnumber(1,"anticipo_cab_cod_moneda")			
	v_Fec = cdw_cabecera.getitemdatetime(1,"fecha")	
	v_valor = this.getitemnumber(V_fil_det,"importe")
	v_Mon = this.getitemnumber(V_fil_det,"cod_moneda")	
	v_Coti = this.getitemnumber(V_fil_det,"cotizacion")	
	
	v_tot = cambiar_cobro(v_valor, v_Fec, v_Mon, v_MonCab, v_Coti)
	ac_val = ac_val + v_tot
next
V_Tval=0
V_Tval= ac_val
cdw_cabecera.setitem(1,'anticipo_cab_valor',V_Tval)	


end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)
end event

event editchanged;grabar="1"
end event

event getfocus;cdw_cabecera.accepttext() 
cdw_det_1.accepttext() 

if isnull(string(cdw_cabecera.getitemnumber(1,"cod_cliente"))) then // Cliente
	aviso = MessageBox("Atencion !!!", "Cliente no puede ser Nulo", StopSign!, OK! ,1)
   this.postevent("ue_focus_cabecera")	
	v_columna = "cod_cliente"
	return 
end if

if isnull(string(cdw_cabecera.getitemnumber(1,"cod_cobrador"))) then // Cobrador
	aviso = MessageBox("Atencion !!!", "Cobrador no puede ser Nulo", StopSign!, OK! ,1)
   this.postevent("ue_focus_cabecera")	
	v_columna = "cod_cobrador"
	return 
end if

if isnull(string(cdw_cabecera.getitemdatetime(1,"fecha"))) then // Fecha
	aviso = MessageBox("Atencion !!!", "Fecha no puede ser Nulo", StopSign!, OK! ,1)
   this.postevent("ue_focus_cabecera")	
	v_columna = "fecha"
	return 
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

event itemchanged;cdw_cabecera.accepttext() 
cdw_det_1.accepttext() 

if (row >= 1 ) THEN
   if this.getcolumnname() = "cod_condicion" then 
		this.TriggerEvent("ue_columna_02")
   elseif this.getcolumnname() = "cod_banco" then 
		this.TriggerEvent("ue_columna_03")
   elseif this.getcolumnname() = "importe" then 
		this.TriggerEvent("ue_act_tot_cab")
	else
		grabar="1"
	end if
end if

end event

event itemfocuschanged;cdw_det_1.accepttext()
cdw_cabecera.accepttext()

long v_TipCon
double v_CodMonDes, v_CodMon 
v_CodMonDes = parsys_codmoneda()
string v_CodCond,v_NroNota
long v_CodCli
double v_Coti 
double v_importe, v_importe_iva , v_importe_exe
LONG v_Nro_NC
double v_ncimporte
date v_FechCob
double V_diff
//*******************************************************************************************
	v_FechCob = date(cdw_cabecera.getitemdatetime(1,"fecha"))
	v_CodMon = this.getitemnumber(this.getrow(),"cod_moneda")
	v_CodCond = string(this.getitemnumber(this.getrow(),"cod_condicion"))
	v_NroNota = string(this.getitemnumber(this.getrow(),"nro_nota"))	

	v_CodCli = cdw_cabecera.getitemnumber(1,"cod_cliente")
// ******************************************************************************************
	long v_CodPro
//******************************************************************************************
	v_CodPro = cdw_cabecera.getitemnumber(1,"cod_cliente")

	//*** Define Tipo Condicion
	SELECT Cond_pagos.Tipo_condicion 
	INTO :v_TipCon
	FROM Cond_pagos 
	WHERE Cond_pagos.Cod_condicion = :v_CodCond ;

	//***	Define Tipo Cotizacion
	SELECT Cotizaciones.Cotizacion 
	INTO :v_Coti
	FROM Cotizaciones 
	WHERE Cotizaciones.Fecha = :v_FechCob and
	Cotizaciones.Cod_moneda = :v_CodMonDes and
	Cotizaciones.Cod_moneda_destino = :v_CodMon;


if isnull(v_ncImporte) then
	v_ncImporte = 0
end if

if THIS.getcolumn() = 6 and this.getitemnumber(this.getrow(),"cotizacion") <= 0 then //*** Valor Actualizado Cotizacion
	if this.getitemnumber(THIS.getrow(),"cod_moneda") = parsys_codmoneda() THEN
		THIS.SetItem (THIS.getrow(), "cotizacion" , 0)
	else
		if v_Coti >=  0 then
			THIS.SetItem (THIS.getrow(), "cotizacion" , v_Coti)		
		else
			THIS.SetItem (THIS.getrow(), "cotizacion" , 0)
		end if
	end if
end if

this.TriggerEvent("ue_act_tot_cab")

end event

event rowfocuschanged;cdw_detalle.accepttext()
cdw_cabecera.accepttext()

integer v_TipCon
string v_CodCond
IF currentrow > 0 then
//*******************************************************************************************
	v_CodCond = string(this.getitemnumber(currentrow,"cod_condicion"))
// ******************************************************************************************

	//Define Tipo Condicion
	SELECT Cond_pagos.Tipo_condicion 
	INTO :v_TipCon
	FROM Cond_pagos 
	WHERE Cond_pagos.Cod_condicion = :v_CodCond ;

	// Tarjeta
	If v_TipCon = 2 then // Bloquea Campos
		this.Modify("cod_tarjeta.Protect=0") 
		this.Modify("cod_tarjeta.Background.COLOR='1090519039'")    
	else 
		this.Modify("cod_tarjeta.Protect=1") 
		this.Modify("cod_tarjeta.Background.COLOR='128128128'")    
   end if

	// Fecha Cheque
	If v_TipCon = 1 then // Bloquea Campos
		this.Modify("fecha_cheque.Protect=0") 
		this.Modify("fecha_cheque.Background.COLOR='1090519039'")    
		this.Modify("nro_cheque.Protect=0") 
		this.Modify("nro_cheque.Background.COLOR='1090519039'")    		
		this.Modify("librador.Protect=0") 
		this.Modify("librador.Background.COLOR='1090519039'")    		
		this.Modify("fecha_ch_emision.Protect=0") 
		this.Modify("fecha_ch_emision.Background.COLOR='1090519039'")    		
		this.Modify("cuenta.Protect=0") 
		this.Modify("cuenta.Background.COLOR='1090519039'")    		
		this.Modify("cod_banco.Protect=0") 
		this.Modify("cod_banco.Background.COLOR='1090519039'")    		
	else 
		this.Modify("fecha_cheque.Protect=1") 
		this.Modify("fecha_cheque.Background.COLOR='128128128'")    
		this.Modify("nro_cheque.Protect=1") 
		this.Modify("nro_cheque.Background.COLOR='128128128'")    		
		this.Modify("librador.Protect=1") 
		this.Modify("librador.Background.COLOR='128128128'")    		
		this.Modify("fecha_ch_emision.Protect=1") 
		this.Modify("fecha_ch_emision.Background.COLOR='128128128'")    		
		this.Modify("cuenta.Protect=1") 
		this.Modify("cuenta.Background.COLOR='128128128'")    		
		this.Modify("cod_banco.Protect=1") 
		this.Modify("cod_banco.Background.COLOR='128128128'")    		
   end if	

end if
end event

type dw_busca from datawindow within w_abm_anticipo
boolean visible = false
integer x = 1678
integer y = 156
integer width = 224
integer height = 184
integer taborder = 10
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from uo_datawindow within w_abm_anticipo
boolean visible = false
integer x = 2290
integer y = 488
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_lista_ctascobrar_anticipo"
end type


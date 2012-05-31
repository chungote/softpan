$PBExportHeader$w_abm_cobros_caja_punto.srw
forward
global type w_abm_cobros_caja_punto from window
end type
type st_1 from statictext within w_abm_cobros_caja_punto
end type
type em_nro_reg from editmask within w_abm_cobros_caja_punto
end type
type dw_cobros_ticket_varios from datawindow within w_abm_cobros_caja_punto
end type
type dw_factura_imp from datawindow within w_abm_cobros_caja_punto
end type
type st_cajero from statictext within w_abm_cobros_caja_punto
end type
type cb_cobrar from commandbutton within w_abm_cobros_caja_punto
end type
type dw_cobros_ticket from datawindow within w_abm_cobros_caja_punto
end type
type dw_cobros from datawindow within w_abm_cobros_caja_punto
end type
end forward

global type w_abm_cobros_caja_punto from window
integer x = 23
integer y = 24
integer width = 2825
integer height = 1420
boolean titlebar = true
string title = "CAJA"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
st_1 st_1
em_nro_reg em_nro_reg
dw_cobros_ticket_varios dw_cobros_ticket_varios
dw_factura_imp dw_factura_imp
st_cajero st_cajero
cb_cobrar cb_cobrar
dw_cobros_ticket dw_cobros_ticket
dw_cobros dw_cobros
end type
global w_abm_cobros_caja_punto w_abm_cobros_caja_punto

on w_abm_cobros_caja_punto.create
this.st_1=create st_1
this.em_nro_reg=create em_nro_reg
this.dw_cobros_ticket_varios=create dw_cobros_ticket_varios
this.dw_factura_imp=create dw_factura_imp
this.st_cajero=create st_cajero
this.cb_cobrar=create cb_cobrar
this.dw_cobros_ticket=create dw_cobros_ticket
this.dw_cobros=create dw_cobros
this.Control[]={this.st_1,&
this.em_nro_reg,&
this.dw_cobros_ticket_varios,&
this.dw_factura_imp,&
this.st_cajero,&
this.cb_cobrar,&
this.dw_cobros_ticket,&
this.dw_cobros}
end on

on w_abm_cobros_caja_punto.destroy
destroy(this.st_1)
destroy(this.em_nro_reg)
destroy(this.dw_cobros_ticket_varios)
destroy(this.dw_factura_imp)
destroy(this.st_cajero)
destroy(this.cb_cobrar)
destroy(this.dw_cobros_ticket)
destroy(this.dw_cobros)
end on

event open;dw_factura_imp.dataobject = "dw_lista_ventas_ticket"


if vg_empresa = "TODO_OFERTAS" then
	dw_factura_imp.dataobject = "dw_lista_ventas_todo_ofertas"
end if
if vg_empresa = "PC_TRONIC" then
	dw_factura_imp.dataobject = "dw_lista_ventas_PcTronic_fiscal"
end if
if vg_empresa = "Aviadores" then
	dw_factura_imp.dataobject = "dw_lista_ventas_aviadores"
end if
if vg_empresa = "Sarambi" then
	dw_factura_imp.dataobject = "dw_lista_ventas_ticket_sarambi"
end if
if vg_empresa = "INTERDENIM_SA" then
	dw_factura_imp.dataobject = "dw_lista_ventas_ticket_interdenim"
end if

if vg_empresa = "Yemita" then
	dw_factura_imp.dataobject = "dw_lista_ventas_yemita_fiscal_caja"
end if


dw_factura_imp.SetTransObject(sqlca)
dw_cobros_ticket.SetTransObject(sqlca)
dw_cobros_ticket_varios.SetTransObject(sqlca)
dw_cobros.SetTransObject(sqlca)

//*** Carga parametro Nro nota
DataWindowChild cdw_NroNota
dw_cobros.GetChild("nro_nota", cdw_NroNota)
cdw_NroNota.SetTransObject(SQLCA)
cdw_NroNota.InsertRow(0)

dw_cobros_ticket.reset()
dw_cobros_ticket.InsertRow(0)
dw_cobros.reset()
dw_cobros.insertrow(0)

dw_cobros.enabled = false
cb_cobrar.enabled = false

string v_cajero_nombre
if (isnull(vg_cajero) or vg_cajero = 0) and  vg_empresa <> "Aviadores" then
	//open(w_cambia_cajero)
end if
//messagebox('aaaa','aaaa'+string(vg_cajero))



if driver() = 2 then				
		SELECT Nombre_cobrador into :v_cajero_nombre FROM Cobradores
	   where Cod_cobrador = :vg_cajero;
	else
		SELECT Nombre_cobrador into :v_cajero_nombre FROM dbo.Cobradores
	   where Cod_cobrador = :vg_cajero;		
	end if		
	st_cajero.text = "El cajero activo es: " + v_cajero_nombre

	// Nro Nota
		dw_cobros.Modify("nro_nota.Protect=1") 
		dw_cobros.Modify("nro_nota.Background.COLOR='128128128'")    
	// Tarjeta
		dw_cobros.Modify("cod_tarjeta.Protect=1") 
		dw_cobros.Modify("cod_tarjeta.Background.COLOR='128128128'")    
	// Fecha Cheque
		dw_cobros.Modify("fecha_cheque.Protect=1") 
		dw_cobros.Modify("fecha_cheque.Background.COLOR='128128128'")    
	//Nro Cheque
		dw_cobros.Modify("nro_cheque.Protect=1") 
		dw_cobros.Modify("nro_cheque.Background.COLOR='128128128'")    
	// Cod Banco
		dw_cobros.Modify("cod_banco.Protect=1") 
		dw_cobros.Modify("cod_banco.Background.COLOR='128128128'")    
	// Cuenta
		dw_cobros.Modify("cuenta.Protect=1") 
		dw_cobros.Modify("cuenta.Background.COLOR='128128128'")    


if vg_nro_reg <> 0 then
string tipo_valor, valor
long cant_filas
dw_cobros_ticket.accepttext()
valor = dw_cobros_ticket.Gettext()
cant_filas = dw_cobros_ticket.retrieve(vg_nro_reg)
cant_filas = dw_cobros_ticket_varios.retrieve(vg_nro_reg,0,0,0,0,0,0,0,0,0)
dw_factura_imp.retrieve(vg_nro_reg)

if cant_filas = 1 then
   if dw_cobros_ticket.getitemnumber(1, "valor_cobrado") > 0 then
		messagebox("Error...", "Ticket ya fue cobrado.....")
		dw_cobros_ticket.DeleteRow(0)
		dw_cobros_ticket.reset()
		dw_cobros_ticket.insertrow(0)
		dw_cobros_ticket.setfocus()
	   return
	end if
	dw_cobros.enabled = true
	cb_cobrar.enabled = true

	vg_con_pago = 	dw_cobros_ticket_varios.getitemNumber(1,'cod_lugar')
	
	integer v_TipCon
	if driver() = 2 then					
		SELECT Cond_pagos.Tipo_condicion 
		INTO :v_TipCon
		FROM Cond_pagos 
		WHERE Cond_pagos.Cod_condicion = :vg_con_pago ;
	else
		SELECT Cond_pagos.Tipo_condicion 
		INTO :v_TipCon
		FROM dbo.Cond_pagos 
		WHERE Cond_pagos.Cod_condicion = :vg_con_pago ;		
	end if	
	If v_TipCon = 2 then // Bloquea Campos
		dw_cobros.Modify("cod_tarjeta.Protect=0") 
		dw_cobros.Modify("cod_tarjeta.Background.COLOR='1090519039'")    
	end if 

	dw_cobros.setitem(1,"cod_condicion", 1)
	dw_cobros.setitem(1,"cod_moneda_vueldo", moneda())
	dw_cobros.setitem(1,"cod_moneda", moneda())
   if dw_cobros_ticket_varios.rowcount() > 0 then
	   dw_cobros.setitem(1,"importe", dw_cobros_ticket_varios.getitemnumber(dw_cobros_ticket_varios.rowcount(),"total_general"))
	end if

   em_nro_reg.text = ''
	dw_cobros.setfocus()
	dw_cobros.setitem(1, 'vueldo', 0)
	
	dw_cobros.setfocus()
elseif cant_filas = 0 then
	dw_cobros_ticket.reset()
   dw_cobros_ticket.InsertRow(0)
	dw_cobros.enabled = false
	cb_cobrar.enabled = false
	MessageBox("AVISO","Ticket no existe...")
end if
end if
end event

event close;vg_nro_reg = 0
end event

type st_1 from statictext within w_abm_cobros_caja_punto
boolean visible = false
integer x = 27
integer y = 148
integer width = 818
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ingrese ticket a cobrar:"
boolean focusrectangle = false
end type

type em_nro_reg from editmask within w_abm_cobros_caja_punto
boolean visible = false
integer x = 846
integer y = 140
integer width = 535
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###"
end type

event modified;long v_fil3, v_filas_fac
long v_aviso
string a3
int b3

//messagebox("nn", "nn")
if em_nro_reg.text = '' then
	return
end if
double v_reg01=0, v_reg02=0, v_reg03=0, v_reg04=0, v_reg05=0
double v_reg06=0, v_reg07=0, v_reg08=0, v_reg09=0, v_reg10=0
long v_tip
setnull(v_tip)
v_reg01 = double(em_nro_reg.text)
select tipo_opcion into :v_tip from tipo_documentos, ventas 
where tipo_documentos.tipo_documen = ventas.tipo_documen and
		ventas.nro_reg = :v_reg01;

if v_tip= 0 then
	v_aviso = MessageBox("Aviso", "Esta venta es a crédito, desea autorizarla?", Question!, YesNo!,1)
	IF v_aviso = 1 THEN 
		if vg_empresa = "PC_TRONIC" then
			a3 = ""
			SetNull(b3)
			dw_factura_imp.retrieve(v_reg01)
			v_filas_fac = dw_factura_imp.rowcount()
			for v_fil3 = 1 to 16 - v_filas_fac //(16 - dw_factura_imp.rowcount())
					dw_factura_imp.RowsCopy (1, 1, Primary!, dw_factura_imp, (dw_factura_imp.rowcount()+1), Primary! )
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"productos_codigo",a3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"productos_descripcion_producto",a3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_det_unidades",b3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_det_precio",b3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"par_c",b3)								
			next
			em_nro_reg.text = ''
			dw_factura_imp.print()
		end if
	end if
	return
end if

v_reg01=0

long v_fila
for v_fila = 1 to dw_cobros_ticket_varios.rowcount() 
	 if v_fila = 1 then
		 v_reg01 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 2 then
		 v_reg02 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 3 then
		 v_reg03 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 4 then
		 v_reg04 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 5 then
		 v_reg05 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 6 then
		 v_reg06 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 7 then
		 v_reg07 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 8 then
		 v_reg08 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 9 then
		 v_reg09 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 10 then
		 v_reg10 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
next
if double(em_nro_reg.text) > 0 then
	if double(em_nro_reg.text) = v_reg01 or double(em_nro_reg.text) = v_reg02 or double(em_nro_reg.text) = v_reg03 or double(em_nro_reg.text) = v_reg04 or double(em_nro_reg.text) = v_reg05 then
		Messagebox("Error...", "Ticket ya fue seleccionado...")
		em_nro_reg.text = ''
		return
	end if
	if double(em_nro_reg.text) = v_reg06 or double(em_nro_reg.text) = v_reg07 or double(em_nro_reg.text) = v_reg08 or double(em_nro_reg.text) = v_reg09 or double(em_nro_reg.text) = v_reg10 then
		Messagebox("Error...", "Ticket ya fue seleccionado...")
		em_nro_reg.text = ''
		return
	end if
end if
if v_reg01 = 0 then
	v_reg01 = double(em_nro_reg.text)
end if
if v_reg02 = 0 then
	v_reg02 = double(em_nro_reg.text)
end if
if v_reg03 = 0 then
	v_reg03 = double(em_nro_reg.text)
end if
if v_reg04 = 0 then
	v_reg04 = double(em_nro_reg.text)
end if
if v_reg05 = 0 then
	v_reg05 = double(em_nro_reg.text)
end if
if v_reg06 = 0 then
	v_reg06 = double(em_nro_reg.text)
end if
if v_reg07 = 0 then
	v_reg07 = double(em_nro_reg.text)
end if
if v_reg08 = 0 then
	v_reg08 = double(em_nro_reg.text)
end if
if v_reg09 = 0 then
	v_reg09 = double(em_nro_reg.text)
end if
if v_reg10 = 0 then
	v_reg10 = double(em_nro_reg.text)
else
	messagebox("Error...", "Solo se pueden cobrar hasta 10 tikets")
	em_nro_reg.text = ''
	return
end if
	
	
string tipo_valor, valor
long cant_filas
valor = em_nro_reg.text
cant_filas = dw_cobros_ticket.retrieve(double(valor))
if cant_filas = 1 then
   if dw_cobros_ticket.getitemnumber(1, "valor_cobrado") > 0 then
		
	v_aviso = MessageBox("Aviso", "Ticket ya fue cobrado, desea reimprimirlo?", Question!, YesNo!,2)
	IF v_aviso = 1 THEN 
		if vg_empresa = "PC_TRONIC" then
			a3 = ""
			SetNull(b3)
			dw_factura_imp.retrieve(double(valor))
			v_filas_fac = dw_factura_imp.rowcount()
			for v_fil3 = 1 to 16 - v_filas_fac //(16 - dw_factura_imp.rowcount())
					dw_factura_imp.RowsCopy (1, 1, Primary!, dw_factura_imp, (dw_factura_imp.rowcount()+1), Primary! )
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"productos_codigo",a3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"productos_descripcion_producto",a3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_det_unidades",b3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_det_precio",b3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"par_c",b3)								
			next
			em_nro_reg.text = ''
			dw_factura_imp.print()
		end if
	end if
		
		dw_cobros_ticket.DeleteRow(0)
		dw_cobros_ticket.reset()
		dw_cobros_ticket.insertrow(0)
	   return
		
		
	end if
	dw_cobros.enabled = true
	cb_cobrar.enabled = true
   dw_cobros_ticket_varios.retrieve(v_reg01, v_reg02, v_reg03, v_reg04, v_reg05, v_reg06, v_reg07, v_reg08, v_reg09, v_reg10)
	
	vg_con_pago = 	dw_cobros_ticket_varios.getitemNumber(1,'cod_lugar')
	
	integer v_TipCon
	SELECT Cond_pagos.Tipo_condicion 
	INTO :v_TipCon
	FROM dbo.Cond_pagos 
	WHERE Cond_pagos.Cod_condicion = :vg_con_pago ;
	If v_TipCon = 2 then // Bloquea Campos
		dw_cobros.Modify("cod_tarjeta.Protect=0") 
		dw_cobros.Modify("cod_tarjeta.Background.COLOR='1090519039'")    
	end if 

	dw_cobros.setitem(1,"cod_condicion", vg_con_pago)
	dw_cobros.setitem(1,"cod_moneda_vueldo", moneda())
	dw_cobros.setitem(1,"cod_moneda", moneda())
   if dw_cobros_ticket_varios.rowcount() > 0 then
	   dw_cobros.setitem(1,"importe", dw_cobros_ticket_varios.getitemnumber(dw_cobros_ticket_varios.rowcount(),"total_general"))
	end if

   em_nro_reg.text = ''
	dw_cobros.setfocus()
	dw_cobros.setitem(1, 'vueldo', 0)
	
elseif cant_filas = 0 then
	dw_cobros_ticket.reset()
   dw_cobros_ticket.InsertRow(0)
   if dw_cobros_ticket_varios.rowcount() > 0 then
	   dw_cobros.enabled = false
	   cb_cobrar.enabled = false
	else
	   dw_cobros.enabled = true
	   cb_cobrar.enabled = true
   end if
	MessageBox("AVISO","Ticket no exite...")
	em_nro_reg.text = ''
end if

end event

type dw_cobros_ticket_varios from datawindow within w_abm_cobros_caja_punto
event ue_tecla_pulsada pbm_dwnkey
integer x = 14
integer y = 128
integer width = 2784
integer height = 344
integer taborder = 20
string dataobject = "dw_abm_cobros_caja_ticket_varios"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;if this.GetColumn() = 1 then
dw_cobros_ticket.accepttext()
string tipo_valor, valor
long cant_filas
dw_cobros_ticket.accepttext()
valor = dw_cobros_ticket.Gettext()
cant_filas = dw_cobros_ticket.retrieve(dw_cobros_ticket.GetItemNumber(1,1))
if cant_filas >= 1 then
   dw_factura_imp.retrieve(dw_cobros_ticket.GetItemNumber(1,1))
   if dw_cobros_ticket.getitemnumber(1, "valor_cobrado") > 0 then
		messagebox("Error...", "Ticket ya fue cobrado.....")
		dw_cobros_ticket.DeleteRow(0)
		dw_cobros_ticket.reset()
		dw_cobros_ticket.insertrow(0)
		dw_cobros_ticket.setfocus()
	   return
	end if
	dw_cobros.enabled = true
	cb_cobrar.enabled = true
	dw_cobros.setitem(1,"cod_condicion", vg_con_pago)
	dw_cobros.setitem(1,"cod_moneda_vueldo", dw_cobros_ticket.getitemnumber(1,"cod_moneda"))
	dw_cobros.setitem(1,"cod_moneda", dw_cobros_ticket.getitemnumber(1,"cod_moneda"))
	dw_cobros.setitem(1,"importe", dw_cobros_ticket.getitemnumber(1,"total"))
	
	dw_cobros.setfocus()
elseif cant_filas = 0 then
	dw_cobros_ticket.reset()
   dw_cobros_ticket.InsertRow(0)
	dw_cobros.enabled = false
	cb_cobrar.enabled = false
	MessageBox("AVISO","Ticket no exites...")
end if

end if

end event

event clicked;long v_fila_clic
v_fila_clic = this.GetClickedRow( )
this.SelectRow ( 0, false )
this.SelectRow ( v_fila_clic, true )
int aviso
aviso = MessageBox("Aviso", "Desea eliminar esta fila?", Question!, YesNo!,1)
IF aviso = 1 THEN 
	this.deleterow(v_fila_clic)
END IF
IF aviso = 2 THEN 
   this.SelectRow ( 0, false )
	return
END IF

if v_fila_clic > 0 then
double v_reg01=0, v_reg02=0, v_reg03=0, v_reg04=0, v_reg05=0
double v_reg06=0, v_reg07=0, v_reg08=0, v_reg09=0, v_reg10=0
long v_fila
for v_fila = 1 to dw_cobros_ticket_varios.rowcount() 
	 if v_fila = 1 then
		 v_reg01 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 2 then
		 v_reg02 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 3 then
		 v_reg03 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 4 then
		 v_reg04 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 5 then
		 v_reg05 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 6 then
		 v_reg06 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 7 then
		 v_reg07 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 8 then
		 v_reg08 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 9 then
		 v_reg09 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
	 if v_fila = 10 then
		 v_reg10 = dw_cobros_ticket_varios.getitemnumber(v_fila, "Nro_reg")
	 end if
next

dw_cobros_ticket_varios.retrieve(v_reg01, v_reg02, v_reg03, v_reg04, v_reg05, v_reg06, v_reg07, v_reg08, v_reg09, v_reg10)
	
dw_cobros.setitem(1,"cod_condicion", vg_con_pago)
dw_cobros.setitem(1,"cod_moneda_vueldo", moneda())
dw_cobros.setitem(1,"cod_moneda", moneda())
if dw_cobros_ticket_varios.rowcount() > 0 then
   dw_cobros.setitem(1,"importe", dw_cobros_ticket_varios.getitemnumber(dw_cobros_ticket_varios.rowcount(),"total_general"))
end if

dw_cobros.setfocus()
	
end if
end event

type dw_factura_imp from datawindow within w_abm_cobros_caja_punto
boolean visible = false
integer x = 1435
integer y = 992
integer width = 494
integer height = 360
integer taborder = 50
string dataobject = "dw_lista_ventas_todo_ofertas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_cajero from statictext within w_abm_cobros_caja_punto
integer x = 27
integer y = 8
integer width = 2770
integer height = 120
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "No hay cajero activo, haga click para selecionar CAJERO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;	open(w_cambia_cajero)
	string v_cajero_nombre
	SELECT Nombre_cobrador into :v_cajero_nombre FROM Cobradores
   where Cod_cobrador = :vg_cajero;
	st_cajero.text = "El cajero activo es: " + v_cajero_nombre
end event

type cb_cobrar from commandbutton within w_abm_cobros_caja_punto
integer x = 2313
integer y = 1052
integer width = 421
integer height = 200
integer taborder = 60
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C&obrar"
end type

event clicked;long v_cont
long v_moneda,v_cobrador,v_cuenta,v_cajero
string v_desc_moneda
double v_vuelto
v_vuelto = dw_cobros.getitemNumber(1,'vueldo')
v_cobrador = long(ProfileString("PEGASUS.INI", vg_emp_cab, "COBRADOR", "0"))
v_cajero = long(ProfileString("PEGASUS.INI", vg_emp_cab, "CAJERO", "0"))
v_cuenta = long(ProfileString("PEGASUS.INI", vg_emp_cab, "CUENTA", "0"))
	dw_cobros.setitem(dw_cobros.getrow(),'nro_cuenta',v_cuenta)
	dw_cobros.accepttext( )
IF dw_cobros.getitemnumber(1,"cod_condicion") = 0 OR ISNULL(dw_cobros.getitemnumber(1,"cod_condicion")) THEN
	MESSAGEBOX("Atención...", "Seleccione condición de pago...")
	RETURN
END IF	

integer v_farmacia
if driver() = 2 then
	select Medic
	into :v_farmacia
	from par_sys;
else
	select Medic
	into :v_farmacia
	from dbo.par_sys;	
end if	
if v_farmacia = 1 then
//////////////////////////Cambia Nro de Tiket///////////////////////////////////
long v_doc
double v_factura
v_doc = long( ProfileString("PEGASUS.INI", vg_emp_cab, "CAJA", "1") )
if driver() = 2 then
	select max(nro_factura) into :v_factura from ventas where Tipo_documen = :v_doc;
else
	select max(nro_factura) into :v_factura from dbo.ventas where Tipo_documen = :v_doc;	
end if	

IF ISNULL(v_factura) THEN
	v_factura = 0 
END IF	
for v_cont = 1 to dw_cobros_ticket_varios.rowcount()
	v_factura = v_factura + 1
	dw_cobros_ticket_varios.SetItem(v_cont, "nro_factura", v_factura )
	dw_cobros_ticket_varios.SetItem(v_cont, "tipo_documen", v_doc )
	dw_cobros_ticket_varios.SetItem(v_cont, "nro_planilla", double( ProfileString("PEGASUS.INI", vg_emp_cab, "NP", "1") ) )
next
	if dw_cobros_ticket_varios.update(true,false) = 1 then
		dw_cobros_ticket_varios.ResetUpdate()
//		commit using sqlca;	
	else
		rollback using sqlca;
		MessageBox("AVISO","ERROR AL ASIGNAR NRO DE TICKET...")
		return
	end if

//////////////////////////Fin de Cambia Nro de Tiket////////////////////////////
else
for v_cont = 1 to dw_cobros_ticket_varios.rowcount()
	dw_cobros_ticket_varios.SetItem(v_cont, "nro_planilla", double( ProfileString("PEGASUS.INI", vg_emp_cab, "NP", "1") ) )
next
	if dw_cobros_ticket_varios.update(true,false) = 1 then
		dw_cobros_ticket_varios.ResetUpdate()
	else
		rollback using sqlca;
		MessageBox("AVISO","ERROR AL ASIGNAR NRO DE TICKET...")
		return
	end if
end if

vg_con_pago = dw_cobros.getitemnumber(1,"cod_condicion")
double v_nro_cobro
long v_cliente
date v_fecha
string v_recibo
double v_total //decimal{2}
long v_tip_doc
select max(Nro_cobro) into :v_nro_cobro from dbo.Cobros_fac using sqlca;
if sqlca.sqlcode < 0 then
	messagebox('Aviso del sistema', "Aviso de error al grabar cobro - Seleccionando Nro de Cobro" + '~r~r' + sqlca.sqlerrtext)
	rollback using sqlca;
	return
End if
if isnull(v_nro_cobro) then v_nro_cobro = 0

long v_caja_ini
long v_planilla_ini 
v_caja_ini = long( ProfileString("PEGASUS.INI", vg_emp_cab, "NC", "1") )
v_planilla_ini = long( ProfileString("PEGASUS.INI", vg_emp_cab, "NP", "1") )
if driver() = 2 then
	update cobradores set Nro_planilla = :v_planilla_ini,
	Nro_cuenta = :v_caja_ini
	where cod_cobrador = :vg_cajero using sqlca;
else
	update dbo.cobradores set Nro_planilla = :v_planilla_ini,
	Nro_cuenta = :v_caja_ini
	where cod_cobrador = :vg_cajero using sqlca;	
end if

if sqlca.sqlcode < 0 then
	messagebox('Aviso del sistema', "Aviso de error al grabar cobro - Colocando planilla y cajero" + '~r~r' + sqlca.sqlerrtext)
	rollback using sqlca;
	return
End if
//messagebox('aaaa','aaaa'+string(vg_cajero))							 
v_nro_cobro = v_nro_cobro + 1
v_total = dw_cobros_ticket_varios.getitemnumber(dw_cobros_ticket_varios.rowcount(),"total_general")
v_recibo = string(dw_cobros_ticket_varios.getitemnumber(1,'nro_factura'))
v_fecha = parsys_fecha_sys()
v_cliente = dw_cobros_ticket_varios.getitemnumber(1,"cod_cliente")
v_moneda = dw_cobros.getitemnumber(1,"cod_moneda")

//messagebox('Atencion',string(vg_cajero))
	insert into dbo.Cobros_fac (Nro_cobro, Cod_cliente, Cod_cobrador, Fecha_cobro, Nro_reci, Total_cob, Total_det,cod_moneda,cod_cajero,tipo_cobro)
	values (:v_nro_cobro, :v_cliente, :v_cobrador, :v_fecha, :v_recibo, :v_total, :v_total, :v_moneda,:v_cajero,0 );	

if sqlca.sqlcode < 0 then
	messagebox('Aviso del sistema', "Aviso de error al grabar cobro - Cobro cabecera" + '~r~r' + sqlca.sqlerrtext)
	rollback using sqlca;
	return
End if


//*************Coloca cobros en Cobros_fac_doc**************//
for v_cont = 1 to dw_cobros_ticket_varios.rowcount()
	v_factura = dw_cobros_ticket_varios.getitemnumber(v_cont,"nro_factura")
	v_tip_doc =  dw_cobros_ticket_varios.getitemnumber(v_cont,"tipo_documen")
	v_total = dw_cobros_ticket_varios.getitemnumber(v_cont,"total")
	v_recibo = string(dw_cobros_ticket_varios.getitemnumber(v_cont,"nro_factura"))
	v_fecha = parsys_fecha_sys()
	v_cliente = dw_cobros_ticket_varios.getitemnumber(v_cont,"cod_cliente")
	//messagebox("nn", string(v_nro_cobro) + ' - ' + string(v_tip_doc) + ' - ' + string(v_factura) + ' - ' + '900' + ' - ' + string(v_total) )
		insert into dbo.Cobros_fac_doc (Nro_cobro, Tipo_documen, Nro_documento, Nro_cuota, Valor_cobrado)
		values (:v_nro_cobro, :v_tip_doc, :v_factura, 1, :v_total ) 
		using sqlca;		
	
	if sqlca.sqlcode < 0 then
		messagebox('Aviso del sistema', "Aviso de error al grabar cobro - Cobro detalle" + '~r~r' + sqlca.sqlerrtext)
		rollback using sqlca;
		return
	End if
NEXT

if (dw_cobros.getitemnumber(1,"cod_moneda") <> dw_cobros.getitemnumber(1,"cod_moneda_vueldo")) then // (dw_cobros_ticket_varios.getitemnumber(1,"cod_moneda") <> dw_cobros.getitemnumber(1,"cod_moneda")) and 
   dw_cobros.insertrow(0)
	dw_cobros.setitem(2, 'cod_condicion', dw_cobros.getitemNumber(1,'cod_condicion'))
	dw_cobros.setitem(2, 'cod_moneda', dw_cobros.getitemNumber(1,'cod_moneda'))
	dw_cobros.setitem(2, 'cotizacion', dw_cobros.getitemNumber(1,'cotizacion'))
	dw_cobros.setitem(2, 'importe', (dw_cobros.getitemNumber(1,'efectivo') - dw_cobros.getitemNumber(1,'importe'))   ) 
   dw_cobros.insertrow(0)
	dw_cobros.setitem(3, 'cod_condicion', dw_cobros.getitemNumber(1,'cod_condicion'))
	dw_cobros.setitem(3, 'cod_moneda', dw_cobros.getitemNumber(1,'cod_moneda_vueldo'))
	dw_cobros.setitem(3, 'cotizacion', dw_cobros.getitemNumber(1,'cotizacion'))
	dw_cobros.setitem(3, 'importe', dw_cobros.getitemNumber(1,'vueldo') * -1 )
end if

for v_cont = 1 to dw_cobros.rowcount()
	dw_cobros.setitem(v_cont, "nro_cobro", v_nro_cobro)
next

if dw_cobros.update(true,false) = 1 then
	dw_cobros.ResetUpdate()
	commit using sqlca;	
	SetProfileString ( 'Ventas.txt', 'Ultima_venta', 'Cobrado', '1' )
//messagebox("aten",1)
	long v_filas
	v_filas = dw_cobros_ticket_varios.rowcount()
	for v_cont = 1 to v_filas
   //***Impresión de tickets***
	if v_farmacia = 1 or v_farmacia <> 1 then
		dw_factura_imp.retrieve(dw_cobros_ticket_varios.GetItemNumber(v_cont,1))
		if dw_factura_imp.rowcount() > 0 then
			
		 if vg_empresa <> "PC_TRONIC" then
			dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_importe_gravado", dw_factura_imp.getitemnumber(dw_factura_imp.rowcount(),"total_fac"))
			dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_importe_exento", 0)
			if v_cont = v_filas then
			   dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_importe_gravado", dw_factura_imp.getitemnumber(dw_factura_imp.rowcount(),"total_fac") + dw_cobros.getitemnumber(1,"vueldo"))
			   dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_importe_exento", dw_cobros.getitemnumber(1,"vueldo"))
			end if
			
			if dw_cobros.getitemnumber(1,"cod_moneda") <> 1 then
				v_moneda = dw_cobros.getitemnumber(1,"cod_moneda")
				if driver() = 2 then				
					select Moneda into :v_desc_moneda from monedas where cod_moneda = :v_moneda;
				else
					select Moneda into :v_desc_moneda from dbo.monedas where cod_moneda = :v_moneda;					
				end if					
				dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_remisiones", left(v_desc_moneda,3) + '.' + string(dw_cobros.getitemnumber(1,"cotizacion")) + ' ')
			end if
		 end if
		
		end if
		
		if vg_empresa = "PC_TRONIC" then
			string a3
			a3 = ""
			int b3
			SetNull(b3)
			long v_fil3, v_filas_fac
			v_filas_fac = dw_factura_imp.rowcount()
			for v_fil3 = 1 to 16 - v_filas_fac //(16 - dw_factura_imp.rowcount())
					dw_factura_imp.RowsCopy (1, 1, Primary!, dw_factura_imp, (dw_factura_imp.rowcount()+1), Primary! )
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"productos_codigo",a3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"productos_descripcion_producto",a3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_det_unidades",b3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"ventas_det_precio",b3)
					dw_factura_imp.setitem(dw_factura_imp.rowcount(),"par_c",b3)								
			next
		end if


		if ProfileString("PEGASUS.INI", vg_emp_cab, "ABRE_CAJA", "1") = "1" AND ProfileString("PEGASUS.INI", vg_emp_cab, "IMPRIMIR_TICKET", "1") = "1" THEN
			LONG JOB
			JOB = PRINTOPEN()
			PRINTSEND(JOB,"~h1Bp~255~100~250", 255)
			PRINTCLOSE(JOB)
		END IF
		IF ProfileString("PEGASUS.INI", vg_emp_cab, "IMPRIMIR_TICKET", "1") = "1" THEN
		   dw_factura_imp.print()
			SetProfileString ( 'Ventas.txt', 'Ultima_venta', 'Impreso', '1' )
		END IF
		
	end if
	NEXT

  	dw_cobros.reset()
   dw_cobros.InsertRow(0)
	dw_cobros.enabled = false
	cb_cobrar.enabled = false
	dw_cobros_ticket.DeleteRow(0)
	dw_cobros_ticket.reset()
	dw_cobros_ticket.insertrow(0)
	dw_cobros_ticket.setfocus()
	if vg_nro_reg > 0 then
		vg_nro_reg = 0
		close(parent)
		return
	end if

	for v_cont = 1 to v_filas
		 dw_cobros_ticket_varios.DELETEROW(0)
	next
	em_nro_reg.setfocus()
	dw_cobros.setitem(1, 'vueldo', v_vuelto)
else
	rollback using sqlca;
	MessageBox("AVISO","ERROR DURANTE LA GRABACIÓN - COBRO DETALLE")	
	dw_cobros.SetFocus()
	return
end if









end event

type dw_cobros_ticket from datawindow within w_abm_cobros_caja_punto
boolean visible = false
integer x = 27
integer y = 196
integer width = 1289
integer height = 416
integer taborder = 30
string dataobject = "dw_abm_cobros_caja_ticket"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;if this.GetColumn() = 1 then
dw_cobros_ticket.accepttext()
string tipo_valor, valor
long cant_filas
dw_cobros_ticket.accepttext()
valor = dw_cobros_ticket.Gettext()
cant_filas = dw_cobros_ticket.retrieve(dw_cobros_ticket.GetItemNumber(1,1))
if cant_filas >= 1 then
   dw_factura_imp.retrieve(dw_cobros_ticket.GetItemNumber(1,1))
   if dw_cobros_ticket.getitemnumber(1, "valor_cobrado") > 0 then
		messagebox("Error...", "Ticket ya fue cobrado.....")
		dw_cobros_ticket.DeleteRow(0)
		dw_cobros_ticket.reset()
		dw_cobros_ticket.insertrow(0)
		dw_cobros_ticket.setfocus()
	   return
	end if
	dw_cobros.enabled = true
	cb_cobrar.enabled = true
	dw_cobros.setitem(1,"cod_condicion", vg_con_pago)
	dw_cobros.setitem(1,"cod_moneda_vueldo", dw_cobros_ticket.getitemnumber(1,"cod_moneda"))
	dw_cobros.setitem(1,"cod_moneda", dw_cobros_ticket.getitemnumber(1,"cod_moneda"))
	dw_cobros.setitem(1,"importe", dw_cobros_ticket.getitemnumber(1,"total"))
	
	dw_cobros.setfocus()
elseif cant_filas = 0 then
	dw_cobros_ticket.reset()
   dw_cobros_ticket.InsertRow(0)
	dw_cobros.enabled = false
	cb_cobrar.enabled = false
	MessageBox("AVISO","Ticket no exites...")
end if

end if

end event

type dw_cobros from datawindow within w_abm_cobros_caja_punto
event ue_enter pbm_dwnprocessenter
integer x = 9
integer y = 480
integer width = 2793
integer height = 812
integer taborder = 40
string dataobject = "dw_abm_cobros_caja"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;int v_sec
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

end event

event itemchanged;this.accepttext()
double v_CodMonDes, v_CodMon, v_Coti
double v_vuelto
date v_FechCob
long v_CodMon_vuelto
v_CodMonDes = parsys_codmoneda()
v_CodMon = moneda()
v_CodMonDes = this.getitemnumber(1,"cod_moneda")
v_FechCob = parsys_fecha_sys()
v_codMon_vuelto = this.getitemnumber(1,"cod_moneda_vueldo")

if this.getcolumnname() = "cod_moneda" then
 // if this.getitemnumber(1,"cod_moneda") <> moneda() then
	 if driver() = 2 then
		//***	Define Tipo Cotizacion
		SELECT Cotizaciones.Cotizacion 
		INTO :v_Coti
		FROM Cotizaciones 
		WHERE Cotizaciones.Fecha = :v_FechCob and
		Cotizaciones.Cod_moneda = :v_CodMon and
		Cotizaciones.Cod_moneda_destino = :v_CodMonDes;
	else	
		//***	Define Tipo Cotizacion
		SELECT Cotizaciones.Cotizacion 
		INTO :v_Coti
		FROM dbo.Cotizaciones 
		WHERE Cotizaciones.Fecha = :v_FechCob and
		Cotizaciones.Cod_moneda = :v_CodMon and
		Cotizaciones.Cod_moneda_destino = :v_CodMonDes;		
	end if
	
	if isnull(v_Coti) then
		v_Coti = 0
	end if

	this.setitem(1,"cotizacion", v_Coti)
   if this.getitemnumber(1, 'cod_moneda') <> 2 then
		this.setitem(1,"importe", cambiar( dw_cobros_ticket_varios.getitemdecimal(dw_cobros_ticket_varios.rowcount(),"total_general"), datetime(v_FechCob), v_CodMon, v_CodMonDes,0))
	else
		this.setitem(1,"importe", dw_cobros_ticket_varios.getitemdecimal(dw_cobros_ticket_varios.rowcount(),"total_general"))
	end if

	if this.getitemnumber(1,"efectivo") > 0 then
		v_vuelto = this.getitemdecimal(1,"efectivo") - this.getitemdecimal(1,"importe")
		this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,0))//v_CodMon,0))
	end if

 //end if
end if

if this.getcolumnname() = "efectivo" then
	v_Coti = this.getitemnumber(1,"cotizacion")
	v_vuelto = this.getitemdecimal(1,"efectivo") - this.getitemdecimal(1,"importe")
	this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,v_Coti)) //v_CodMon
	if v_codMon_vuelto = moneda() then
		this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,v_Coti)) //v_CodMon
   else
		this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,v_Coti)) //v_CodMon
   end if		
end if

if this.getcolumnname() = "cotizacion" then
	if this.getitemnumber(1,"efectivo") > 0 then
		v_Coti = this.getitemnumber(1,"cotizacion")
		v_vuelto = this.getitemdecimal(1,"efectivo") - this.getitemdecimal(1,"importe")
		if v_codMon_vuelto = moneda() then
			this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,v_Coti)) //v_CodMon
   	else
			this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,v_Coti)) //v_CodMon
   	end if		
   end if		
end if

if this.getcolumnname() = "cod_moneda_vueldo" then
	v_Coti = this.getitemnumber(1,"cotizacion")
	v_vuelto = this.getitemdecimal(1,"efectivo") - this.getitemdecimal(1,"importe")
	if v_codMon_vuelto = moneda() then
		this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,v_Coti)) //v_CodMon
   else
		this.setitem(1,"vueldo", cambiar(v_vuelto, datetime(v_FechCob), v_CodMonDes, v_codMon_vuelto,v_Coti)) //v_CodMon
   end if		
end if


if this.getcolumnname() = "cod_condicion" then 

integer v_TipCon
string v_CodCond
//*******************************************************************************************
	v_CodCond = string(this.getitemnumber(getrow(),"cod_condicion"))
// ******************************************************************************************
	if driver() = 2 then
		//Define Tipo Condicion
		SELECT Cond_pagos.Tipo_condicion 
		INTO :v_TipCon
		FROM Cond_pagos 
		WHERE Cond_pagos.Cod_condicion = :v_CodCond ;
	else
		//Define Tipo Condicion
		SELECT Cond_pagos.Tipo_condicion 
		INTO :v_TipCon
		FROM dbo.Cond_pagos 
		WHERE Cond_pagos.Cod_condicion = :v_CodCond ;		
	end if
	
	// Nro Nota
	If v_TipCon = 4 then // Bloquea Campos
		this.Modify("nro_nota.Protect=0") 
		this.Modify("nro_nota.Background.COLOR='1090519039'")    
	else 
		this.Modify("nro_nota.Protect=1") 
		this.Modify("nro_nota.Background.COLOR='128128128'")    
   end if

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
	else 
		this.Modify("fecha_cheque.Protect=1") 
		this.Modify("fecha_cheque.Background.COLOR='128128128'")    
   end if	
	
	//Nro Cheque
	If v_TipCon = 1 then // Bloquea Campos
		this.Modify("nro_cheque.Protect=0") 
		this.Modify("nro_cheque.Background.COLOR='1090519039'")    
	else 
		this.Modify("nro_cheque.Protect=1") 
		this.Modify("nro_cheque.Background.COLOR='128128128'")    
	end if

	// Cod Banco
	If v_TipCon = 1 then // Bloquea Campos
		this.Modify("cod_banco.Protect=0") 
		this.Modify("cod_banco.Background.COLOR='1090519039'")    
	else 
		this.Modify("cod_banco.Protect=1") 
		this.Modify("cod_banco.Background.COLOR='128128128'")    
	end if

	// Cuenta
	If v_TipCon = 1 then // Bloquea Campos
		this.Modify("cuenta.Protect=0") 
		this.Modify("cuenta.Background.COLOR='1090519039'")    
	else 
		this.Modify("cuenta.Protect=1") 
		this.Modify("cuenta.Background.COLOR='128128128'")    
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


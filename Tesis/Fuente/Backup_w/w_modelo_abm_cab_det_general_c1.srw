$PBExportHeader$w_modelo_abm_cab_det_general_c1.srw
forward
global type w_modelo_abm_cab_det_general_c1 from window
end type
type st_menu from statictext within w_modelo_abm_cab_det_general_c1
end type
type cdw_detalle from datawindow within w_modelo_abm_cab_det_general_c1
end type
type cdw_cabecera from datawindow within w_modelo_abm_cab_det_general_c1
end type
type cb_cerrar from commandbutton within w_modelo_abm_cab_det_general_c1
end type
end forward

shared variables

end variables

global type w_modelo_abm_cab_det_general_c1 from window
integer x = 695
integer y = 460
integer width = 2158
integer height = 1548
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = child!
long backcolor = 12632256
event ue_grabar ( )
event ue_borrar ( )
event ue_parametros ( )
event ue_leer ( )
event ue_insertar_detalle ( )
event ue_insertar ( )
event ue_buscar ( )
event ue_imprimir ( )
event ue_borrar_detalle ( )
event ue_elimina_nulos ( )
event ue_buscar_lista ( )
st_menu st_menu
cdw_detalle cdw_detalle
cdw_cabecera cdw_cabecera
cb_cerrar cb_cerrar
end type
global w_modelo_abm_cab_det_general_c1 w_modelo_abm_cab_det_general_c1

type variables
integer col_clave_cab, col_clave_det
integer col_item_det, primer_col_disp_det
string tipo_valor, valor
string grabar
Integer aviso
integer v_barras
long vi_situacion=0

end variables

event ue_grabar();
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

aviso = MessageBox("Aviso", "Desea grabar la transacción?", Question!, YesNo!,1)

IF aviso = 1 THEN 

	cdw_detalle.accepttext()
	cdw_detalle.accepttext()
	
	triggerEvent("ue_elimina_nulos")
	long fila_det
	tipo_valor = cdw_cabecera.describe("#"+string(col_clave_cab)+".coltype")
	cdw_cabecera.setcolumn(col_clave_cab)
	valor = cdw_cabecera.Gettext()

	for fila_det = 1 to cdw_detalle.RowCount()
		if tipo_valor = "number" or left(tipo_valor,7)="decimal" or tipo_valor = "long" then
			cdw_detalle.SetItem(fila_det, col_clave_det,long(valor))	
		elseif left(tipo_valor,4)="char" then
			cdw_detalle.SetItem(fila_det, col_clave_det,valor)	
		elseif tipo_valor ="date" then
			cdw_detalle.SetItem(fila_det, col_clave_det,date(valor))
		end if	
	next

	if cdw_cabecera.update(true,false) = 1 then
		if cdw_detalle.update(true,false) > 0 then
			cdw_cabecera.ResetUpdate()
			cdw_detalle.ResetUpdate()
			commit using sqlca;	
   		TriggerEvent("ue_insertar")
			else
				Rollback using sqlca;
				aviso = MessageBox("Atención !!!","No existen detalles a ser Grabados.", StopSign!, ok!,1)
			end if
		else
			Rollback using sqlca;
			MessageBox("Aviso","Error al grabar la cabecera")
			cdw_cabecera.SetFocus()	
		end if
		grabar="0"
//***/

end if
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


		if cdw_detalle.update(true,false) > 0 then
			cdw_cabecera.DeleteRow(0)
			if cdw_cabecera.update(true,false) = 1 then
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
	
End IF


end event

event ue_parametros;col_clave_cab       = 1	//* número de columna de la clave en la cabecera
col_clave_det 		  = 1	//* número de columna de la clave en el detalle
col_item_det		  = 1	//* número de columna del número de item (generado) en el detalle
primer_col_disp_det = 2	//* primera columna disponible (para edición) en el detalle


end event

event ue_leer;long cant_filas_cab, cant_filas_det
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
	vi_situacion = 2
	if tipo_valor = "number" or left(tipo_valor,7)="decimal"  then
		cant_filas_det = cdw_detalle.retrieve(long(valor))
	elseif tipo_valor="long" then
		cant_filas_det = cdw_detalle.retrieve(long(valor))
	elseif left(tipo_valor,4)="char" then
		cant_filas_det = cdw_detalle.retrieve(valor)
	elseif tipo_valor ="date" then
		cant_filas_det = cdw_detalle.retrieve(date(valor))
	end if
	if cant_filas_det > 0 then
		commit using sqlca;
	elseif cant_filas_det = 0 then
		MessageBox("Aviso de Error","El documento no posee detalles!!")
		triggerEvent("ue_insertar_detalle")
	else
		Rollback using sqlca;
		MessageBox("Aviso","Error en la lectura del detalle")
	end if
elseif cant_filas_cab = 0 then
	triggerEvent("ue_insertar")
//	if tipo_valor="number" or left(tipo_valor,7)="decimal" then
//		cdw_cabecera.SetItem(1,col_clave_cab,long(valor))
//	elseif tipo_valor="long" then
//		cdw_cabecera.SetItem(1,col_clave_cab,long(valor))
//	elseif left(tipo_valor,4)="char" then
//		cdw_cabecera.SetItem(1,col_clave_cab,valor)
//	elseif tipo_valor ="date" then
//		cdw_cabecera.SetItem(1,col_clave_cab,date(valor))
//	end if
else
	Rollback using sqlca;
	MessageBox("Aviso","Error en la lectura de la cabecera")
end if
cdw_cabecera.SetFocus()
grabar="0"


end event

event ue_insertar_detalle;cdw_detalle.InsertRow(0)
cdw_detalle.SetColumn(primer_col_disp_det)
cdw_detalle.SetFocus()
grabar="1"


end event

event ue_insertar;cdw_cabecera.reset()
cdw_cabecera.InsertRow(0)
cdw_detalle.reset()
cdw_detalle.InsertRow(0)

string v_sql, v_nombre_tabla
int v_caracteres
int v_contador
v_sql = cdw_cabecera.Describe("DataWindow.Table.Select")
v_caracteres = len(v_sql)
v_contador = pos(v_sql, "FROM",1)
if v_contador = 0 then
v_contador = pos(v_sql, "From",1)
end if	
if v_contador = 0 then
v_contador = pos(v_sql, "from",1)
end if	
v_contador = v_contador + 5	
for v_contador = v_contador to v_caracteres
	if mid(v_sql, v_contador,1) = " " then
		v_contador = 10000
	else
    v_nombre_tabla = v_nombre_tabla + mid(v_sql, v_contador,1)
   end if
next

long v_maximo
string v_campo
cdw_cabecera.setcolumn(col_clave_cab)
v_campo = cdw_cabecera.getcolumnname()
v_sql = "select max(" + v_campo + ") as Valor from " + v_nombre_tabla //+ ";"
declare mi_cursor dynamic cursor for sqlSa;
prepare sqlsa from :v_sql;
open dynamic mi_cursor;
fetch mi_cursor into :v_maximo;
close mi_cursor;
if isnull(v_maximo) then
	v_maximo = 1
else
	v_maximo = v_maximo +1
end if
cdw_cabecera.SetItem(1,col_clave_cab,v_maximo)
cdw_detalle.SetItem(1,col_clave_det,v_maximo)

cdw_cabecera.SetColumn(1) 
cdw_cabecera.Setfocus()
grabar="0"
vi_situacion = 4
end event

event ue_buscar;messagebox("Aviso", "Esta ventana no tiene propiedad de busqueda")
end event

event ue_imprimir;cdw_cabecera.print()
cdw_detalle.print()
end event

event ue_borrar_detalle;aviso = MessageBox("Aviso", "Desea borrar este detalle?", Question!, YesNo!,1)

IF aviso = 1 THEN 
	long fila_det, fila_actual
	if cdw_detalle.RowCount() > 1 then
		cdw_detalle.DeleteRow(0)
		cdw_detalle.SetColumn(primer_col_disp_det)
		fila_actual = cdw_detalle.GetRow()
		cdw_detalle.SetRow(fila_actual)
		cdw_detalle.SetFocus()
		if cdw_detalle.RowCount() < 1 then
			this.TriggerEvent("ue_insertar_detalle")
		end if	
	else
		cdw_detalle.DeleteRow(0)
		cdw_detalle.SetColumn(primer_col_disp_det)
		fila_actual = cdw_detalle.GetRow()
		cdw_detalle.SetRow(fila_actual)
		cdw_detalle.SetFocus()
      triggerevent("ue_insertar_detalle")
   end if
END IF




end event

event ue_elimina_nulos;long V_fil_det
//********************************************************************************************
if cdw_detalle.RowCount() > 0 then
	for V_fil_det = 1 to cdw_detalle.RowCount()
		if isnull(cdw_detalle.GetItemString(V_fil_det,2)) then
			cdw_detalle.DeleteRow(V_fil_det)
		end if
	next
end if

end event

event ue_buscar_lista;guo_func.of_find_cdw (cdw_cabecera )
end event

event open;
cdw_cabecera.settransobject(sqlca)
cdw_detalle.settransobject(sqlca)
triggerevent("ue_parametros")
triggerevent("ue_insertar")

cdw_cabecera.SetColumn(1) 
cdw_cabecera.SetFocus()
grabar="0"

v_barras = 0

this.Move ( 0, 0 )



end event

on w_modelo_abm_cab_det_general_c1.create
this.st_menu=create st_menu
this.cdw_detalle=create cdw_detalle
this.cdw_cabecera=create cdw_cabecera
this.cb_cerrar=create cb_cerrar
this.Control[]={this.st_menu,&
this.cdw_detalle,&
this.cdw_cabecera,&
this.cb_cerrar}
end on

on w_modelo_abm_cab_det_general_c1.destroy
destroy(this.st_menu)
destroy(this.cdw_detalle)
destroy(this.cdw_cabecera)
destroy(this.cb_cerrar)
end on

event activate;if this.st_menu.text = 'none' then
   this.st_menu.text = vg_menu
end if
if permisos(this.st_menu.text, 3) = 1 then 
	m_menu.m_editar.m_borrar.enabled = true
	m_menu.m_editar.m_borrar.visible = true
else
	m_menu.m_editar.m_borrar.enabled = false
	m_menu.m_editar.m_borrar.visible = false
end if

if permisos(this.st_menu.text, 4) = 1 and permisos(this.st_menu.text, 2) = 1 then 
	m_menu.m_editar.m_grabar.enabled = true
	m_menu.m_editar.m_grabar.visible = true
else
	m_menu.m_editar.m_grabar.enabled = false
	m_menu.m_editar.m_grabar.visible = false
end if

if permisos(this.st_menu.text, 4) <> permisos(this.st_menu.text, 2) then 
	m_menu.m_editar.m_grabar.enabled = true
	m_menu.m_editar.m_grabar.visible = true
end if

end event

type st_menu from statictext within w_modelo_abm_cab_det_general_c1
boolean visible = false
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

type cdw_detalle from datawindow within w_modelo_abm_cab_det_general_c1
event ue_enter pbm_dwnprocessenter
event ue_tecla_pulsada pbm_dwnkey
event ue_columna_02 ( )
integer x = 9
integer y = 588
integer width = 2089
integer height = 852
integer taborder = 20
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;	long ll_rows, ll_colcount, ll_colact, ll_rowact
	ll_colcount = long(This.Object.DataWindow.Column.Count)
	ll_colact   = This.getcolumn()
	ll_rowact = this.getrow()
	ll_rows = this.RowCount()
	if ll_rows = ll_rowact and ll_colcount = ll_colact then 
		parent.TriggerEvent("ue_insertar_detalle")
	else
		long ll_sec, ll_sec_sal, ll_columnas, n, ll_col
		long ll_row, ll_columnas_con_tab, ll_primera_col
		ll_row = this.getrow()
		ll_col = this.GetColumn()
		ll_sec_sal = long(this.Describe("#" + string(ll_col) + ".TabSequence"))
		ll_columnas = long(this.Object.DataWindow.Column.Count)
		for n = 1 to ll_columnas 
			ll_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
			if (ll_sec_sal + 10) = ll_sec then
				post setfocus(this)
				post setrow(this, ll_rowact)
				post setcolumn(this, n)
				exit
			end if
		next
		ll_columnas_con_tab = 0
		for n = 1 to ll_columnas 
			ll_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
			if ll_sec = 10 then ll_primera_col = n
			if ll_sec <> 0 then ll_columnas_con_tab = ll_columnas_con_tab + 1
		next

		if ll_sec_sal = (ll_columnas_con_tab*10) then //(v_columnas*10) then
			if ll_rowact = ll_rows then
				post setrow(this, ll_rowact)
				post setcolumn(this, ll_primera_col)
			else
				post setrow(this, ll_rowact + 1)
				post setcolumn(this, ll_primera_col)
			end if
		end if
//	  Send(Handle(this), 256, 9, 0)
	end if


end event

event ue_tecla_pulsada;if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
//elseif keydown(keyf4!) then
//	fn_releer_lista(this)
elseif keydown(keyf12!) then
 parent.triggerEvent("ue_borrar_detalle")
end if

if keydown(keyf3!) then 
	guo_func.of_find_cdw (cdw_detalle )
end if

end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)
end event

event itemchanged;cdw_cabecera.accepttext() 
cdw_detalle.accepttext() 

if (row >= 1 ) THEN
	grabar="1"
end if

if this.getcolumnname() = "codigo" then
	string v_cod_dig
	long ll_row
	ll_row = getrow()
	v_cod_dig = this.getitemstring(ll_row, "codigo")
	v_cod_dig = guo_func.of_codigo(v_cod_dig)
	cdw_detalle.setitem(ll_row, "codigo", v_cod_dig)
	post setitem(cdw_detalle, ll_row, "codigo", v_cod_dig)
end if


end event

event editchanged;grabar="1"
end event

event itemerror;string ls_colname, ls_datatype, ls_err
ls_colname = dwo.Name
ls_datatype = dwo.ColType
ls_err = dwo.ValidationMsg
if ls_err = '?' then ls_err = ''
messagebox("Error..", "El valor ingresado es inválido...." + '~r' + ls_err)
post setrow(this, row)
post setcolumn(this, ls_colname)
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

event rowfocuschanged;this.setrowfocusindicator(FocusRect!)

end event

type cdw_cabecera from datawindow within w_modelo_abm_cab_det_general_c1
event ue_tecla_pulsada pbm_dwnkey
event ue_enter pbm_dwnprocessenter
integer x = 5
integer y = 4
integer width = 2112
integer height = 372
integer taborder = 10
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_tecla_pulsada;if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
//elseif keydown(keyf4!) then
//	fn_releer_lista(this)
elseif keydown(KeyEscape!) then
	close(parent)
end if
end event

event ue_enter;long ll_sec, ll_sec_sal, ll_columnas, n, ll_col
long ll_row, ll_columnas_con_tab, ll_primera_col
ll_row = this.getrow()
ll_col = this.GetColumn()
ll_sec_sal = long(this.Describe("#" + string(ll_col) + ".TabSequence"))
ll_columnas = long(this.Object.DataWindow.Column.Count)
for n = 1 to ll_columnas 
	ll_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
	if (ll_sec_sal + 10) = ll_sec then
		post setfocus(this)
		post setcolumn(this, n)
		exit
	end if
next
ll_columnas_con_tab = 0
for n = 1 to ll_columnas 
	ll_sec = long(this.Describe("#" + string(n) + ".TabSequence"))
	if ll_sec = 10 then ll_primera_col = n
	if ll_sec <> 0 then ll_columnas_con_tab = ll_columnas_con_tab + 1
next
if ll_sec_sal = (ll_columnas_con_tab*10) then post setcolumn(this, ll_primera_col)

end event

event itemchanged;if this.GetColumn() = col_clave_cab then
	parent.TriggerEvent("ue_leer")
else
	grabar="1"
end if

end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)
end event

event editchanged;	grabar="1"
end event

event itemerror;string ls_colname, ls_datatype, ls_err
ls_colname = dwo.Name
ls_datatype = dwo.ColType
ls_err = dwo.ValidationMsg
if ls_err = '?' then ls_err = ''
messagebox("Error..", "El valor ingresado es inválido...." + '~r' + ls_err)
post setrow(this, row)
post setcolumn(this, ls_colname)
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

type cb_cerrar from commandbutton within w_modelo_abm_cab_det_general_c1
integer x = 142
integer y = 76
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
boolean cancel = true
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


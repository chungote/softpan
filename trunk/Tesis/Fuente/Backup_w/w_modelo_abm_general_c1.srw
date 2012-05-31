$PBExportHeader$w_modelo_abm_general_c1.srw
forward
global type w_modelo_abm_general_c1 from Window
end type
type dw_busca from datawindow within w_modelo_abm_general_c1
end type
type st_menu from statictext within w_modelo_abm_general_c1
end type
type cdw_datos from datawindow within w_modelo_abm_general_c1
end type
type cdw_lista from datawindow within w_modelo_abm_general_c1
end type
type cb_cerrar from commandbutton within w_modelo_abm_general_c1
end type
end forward

shared variables

end variables

global type w_modelo_abm_general_c1 from Window
int X=640
int Y=372
int Width=2981
int Height=1136
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_grabar ( )
event ue_borrar ( )
event ue_imprimir ( )
event ue_insertar ( )
event ue_parametros ( )
event ue_leer ( )
event ue_buscar ( )
event ue_buscar_lista ( )
dw_busca dw_busca
st_menu st_menu
cdw_datos cdw_datos
cdw_lista cdw_lista
cb_cerrar cb_cerrar
end type
global w_modelo_abm_general_c1 w_modelo_abm_general_c1

type variables
string grabar
string v_tabla
Integer aviso
long band  
long vi_situacion=0
long campo
end variables

event ue_grabar;if vi_situacion = 4 then
//   if permisos(this.st_menu.text, 4) <> 1 then 
// 		messagebox("Error de seguridad...", "No tiene permiso de agregar nuevos registros...")
//		return
//	end if
end if
if vi_situacion = 2 then
//   if permisos(this.st_menu.text, 2) <> 1 then 
// 		messagebox("Error de seguridad...", "No tiene permiso de modificar registros...")
//		return
//	end if
end if

	aviso = MessageBox("Aviso", "Desea grabar la transacción?", Question!, YesNo!,1)
	if Aviso = 1 then
		if cdw_datos.rowcount() > 0 then
			cdw_datos.triggerevent("ue_validar_nulos")
		end if
	end if

IF aviso = 1 THEN 
//	if cdw_datos.rowcount() > 0 then
//		cdw_datos.triggerevent("ue_validar_nulos")
//		if band = 1 then
//			band = 0
//			return
//		end if
//	end if

	if cdw_datos.update(true,false) = 1 then
		cdw_datos.ResetUpdate()
		commit using sqlca;	
	   TriggerEvent("ue_insertar")
	else
		rollback using sqlca;
		MessageBox("AVISO","ERROR DURANTE LA GRABACIÓN")	
		if cdw_datos.DeletedCount() > 0 then
			cdw_datos.InsertRow(0)
			cdw_datos.RowsMove(1,1,delete!,cdw_datos,1,primary!)
			cdw_datos.SetRow(1)
//			cdw_datos.SetColumn(col_clave)
		end if
		cdw_datos.SetFocus()	
	end if
	grabar='0'
END IF
end event

event ue_borrar;aviso = MessageBox("Aviso", "Desea borrar la transacción?", Question!, YesNo!,1)
IF aviso = 1 THEN 
	cdw_datos.DeleteRow(0)
	TriggerEvent("ue_grabar")
END IF

end event

event ue_imprimir;cdw_datos.print()
end event

event ue_insertar;cdw_lista.reset()
cdw_lista.InsertRow(0)
cdw_datos.reset()
cdw_datos.insertrow(0)


string v_sql, v_nombre_tabla
int v_caracteres
int v_contador

v_sql = cdw_datos.Describe("DataWindow.Table.Select")
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
//cdw_datos.setcolumn(col_clave)
v_campo = cdw_datos.getcolumnname()

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
//cdw_datos.SetItem(1,col_clave,v_maximo)

//cdw_datos.setColumn(col_clave)
cdw_datos.setfocus()

vi_situacion = 4

end event

event ue_parametros;
//col_clave = 1

end event

event ue_leer;string tipo_valor, valor
long cant_filas

//tipo_valor = cdw_datos.describe("#"+string(col_clave)+".coltype")
valor = cdw_datos.Gettext()

if tipo_valor = "number" or left(tipo_valor,7)="decimal" or left(tipo_valor,4)="long" then
	cant_filas = cdw_datos.retrieve(long(valor))
elseif left(tipo_valor,4)="char" then
	cant_filas = cdw_datos.retrieve(valor)
elseif tipo_valor ="date" then
	cant_filas = cdw_datos.retrieve(date(valor))
end if

if cant_filas = 1 then
	vi_situacion = 2
	commit using sqlca;
elseif cant_filas = 0 then
	TriggerEvent("ue_insertar")
	if tipo_valor="number" or left(tipo_valor,7)="decimal" or left(tipo_valor,4)="long" then
		//cdw_datos.SetItem(1,col_clave,long(valor))
	elseif left(tipo_valor,4)="char" then
	//	cdw_datos.SetItem(1,col_clave,valor)
	elseif tipo_valor ="date" then
	//	cdw_datos.SetItem(1,col_clave,date(valor))
	end if
else
	rollback using sqlca;
	MessageBox("AVISO","ERROR DURANTE LA LECTURA DE LOS DATOS")
end if
cdw_datos.setfocus()
grabar = "0"
end event

event ue_buscar;string tipo_valor, valor
long cant_filas

tipo_valor = cdw_lista.describe("#"+string(2)+".coltype")
valor = cdw_lista.Gettext()

if tipo_valor = "number" or left(tipo_valor,7)="decimal" or left(tipo_valor,4)="long" then
	cant_filas = cdw_lista.retrieve(long(valor))
elseif left(tipo_valor,4)="char" then
	cant_filas = cdw_lista.retrieve('%' + valor + '%')
elseif tipo_valor ="date" then
	cant_filas = cdw_lista.retrieve(date(valor))
elseif left(tipo_valor,8) ="datetime" then
	cant_filas = cdw_lista.retrieve(date(valor))
end if

if cant_filas >= 1 then
	commit using sqlca;
elseif cant_filas = 0 then
	cdw_lista.reset()
	cdw_lista.InsertRow(0)
else
	rollback using sqlca;
	MessageBox("AVISO EN EVENTO: CLICKED-BT_LEER","ERROR DURANTE LA LECTURA DE LOS DATOS")
end if

cdw_lista.triggerevent(rowfocuschanged!)
cdw_lista.setfocus()

end event

event ue_buscar_lista;
//guo_func.of_find_cdw (cdw_datos )
end event

event open;
cdw_lista.SetTransObject(sqlca)
cdw_datos.SetTransObject(sqlca)


triggerEvent("ue_parametros")
TriggerEvent("ue_insertar")

//cdw_datos.SetColumn(col_clave) 
cdw_datos.SetFocus()

grabar = "0"

this.Move ( 0, 0 )


end event

on w_modelo_abm_general_c1.create
this.dw_busca=create dw_busca
this.st_menu=create st_menu
this.cdw_datos=create cdw_datos
this.cdw_lista=create cdw_lista
this.cb_cerrar=create cb_cerrar
this.Control[]={this.dw_busca,&
this.st_menu,&
this.cdw_datos,&
this.cdw_lista,&
this.cb_cerrar}
end on

on w_modelo_abm_general_c1.destroy
destroy(this.dw_busca)
destroy(this.st_menu)
destroy(this.cdw_datos)
destroy(this.cdw_lista)
destroy(this.cb_cerrar)
end on

//event activate;if this.st_menu.text = 'none' then
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


if permisos(this.st_menu.text, 4) <> permisos(this.st_menu.text, 2) then 
	m_menu.m_editar.m_grabar.enabled = true
	m_menu.m_editar.m_grabar.visible = true
end if

end event

//type dw_busca from datawindow within w_modelo_abm_general_c1
int X=1486
int Y=588
int Width=494
int Height=360
int TabOrder=30
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type st_menu from statictext within w_modelo_abm_general_c1
int X=5
int Y=4
int Width=1376
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cdw_datos from datawindow within w_modelo_abm_general_c1
event ue_tecla_pulsada pbm_dwnkey
event ue_enter pbm_dwnprocessenter
event ue_validar_nulos ( )
event ue_error ( )
int X=18
int Y=368
int Width=2903
int Height=620
int TabOrder=20
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

event ue_tecla_pulsada;if keydown(keyf1!) then 
	fn_consulta_en_lista(this)
//elseif keydown(keyf4!) then
//	fn_releer_lista(this)
end if
if keydown(keyf3!) then 
	guo_func.of_find_cdw (cdw_datos )
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

event itemchanged;
//if this.GetColumn() = col_clave then
//	parent.TriggerEvent("ue_leer")
//else
//	grabar = "1"
//end if
//guo_func.of_find_descrip ( cdw_datos, dw_busca)

end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)
end event

event editchanged;grabar = "1"
end event

event error;action = exceptionfail!
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
CASE "nume"
		This.SetItem(row, ls_colname, 0)
CASE "deci"
		This.SetItem(row, ls_colname, 0)
CASE "date"
		date null_date
		SetNull(null_date)
		This.SetItem(row, ls_colname, null_date)
CASE "char"
		string null_string
		SetNull(null_string)
		This.SetItem(row, ls_colname, null_string)
END CHOOSE


return 1
end event

type cdw_lista from datawindow within w_modelo_abm_general_c1
int X=14
int Y=16
int Width=2903
int Height=332
int TabOrder=10
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event error;action = exceptionfail!
end event

event dberror;return mostrar_error_db(sqldbcode, sqlerrtext)

end event

event rowfocuschanged;
string tipo_clave
tipo_clave = this.describe("#"+string(1)+".coltype")
//this.setrowfocusindicator(FocusRect!)
if this.rowcount() > 0 and this.getrow() >0 then
//	messagebox("nn",this.getitemnumber(this.getrow(),1))
	if tipo_clave = "string" or Left(tipo_clave,4) = "char" then
		cdw_datos.retrieve(this.getitemstring(this.getrow(),1))
   elseif tipo_clave = "number" or tipo_clave = "long" or left(tipo_clave,3) = "int" or left(tipo_clave,4) = "deci" then
		cdw_datos.retrieve(this.getitemnumber(this.getrow(),1))
   elseif left(tipo_clave,8) = "datetime" then
		cdw_datos.retrieve(this.getitemdatetime(this.getrow(),1))
   elseif tipo_clave = "date" then
		cdw_datos.retrieve(this.getitemdate(this.getrow(),1))
   end if
	cdw_lista.setfocus()
	vi_situacion=2
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

type cb_cerrar from commandbutton within w_modelo_abm_general_c1
int X=146
int Y=76
int Width=247
int Height=108
string Text="Cerrar"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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


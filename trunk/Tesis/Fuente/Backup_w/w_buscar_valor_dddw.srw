$PBExportHeader$w_buscar_valor_dddw.srw
forward
global type w_buscar_valor_dddw from window
end type
type dw_filtro from uo_datawindow within w_buscar_valor_dddw
end type
type cb_delete from commandbutton within w_buscar_valor_dddw
end type
type cb_update from commandbutton within w_buscar_valor_dddw
end type
type cb_insert from commandbutton within w_buscar_valor_dddw
end type
type cb_1 from commandbutton within w_buscar_valor_dddw
end type
type st_error from statictext within w_buscar_valor_dddw
end type
type st_1 from statictext within w_buscar_valor_dddw
end type
type cdw_new from datawindow within w_buscar_valor_dddw
end type
type st_msg from statictext within w_buscar_valor_dddw
end type
end forward

global type w_buscar_valor_dddw from window
integer x = 631
integer y = 96
integer width = 2519
integer height = 2008
boolean titlebar = true
string title = "Buscar ..."
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
dw_filtro dw_filtro
cb_delete cb_delete
cb_update cb_update
cb_insert cb_insert
cb_1 cb_1
st_error st_error
st_1 st_1
cdw_new cdw_new
st_msg st_msg
end type
global w_buscar_valor_dddw w_buscar_valor_dddw

type variables
integer ii_rows
integer ii_col[]
integer ii_dev[]
boolean ii_setitem[]

DataWindow idw_data

end variables

forward prototypes
public function integer wf_recuperar (string a_valor)
end prototypes

public function integer wf_recuperar (string a_valor);integer rows
date v_d
datetime v_dt
time v_t
string ls_coltype
ls_coltype = idw_data.Describe("#" + string(idw_data.GetColumn()) + ".ColType")
CHOOSE CASE Upper(Left(ls_coltype,5))
CASE "CHAR("
		rows = cdw_new.Retrieve( "%" + a_valor + "%", 'xxzzyy'  )
CASE "NUMBE","LONG"
	   if cdw_new.DataObject = 'dw_bus_proveedor' then 
			rows = cdw_new.Retrieve(a_valor + "%", 0  )
		else
			rows = cdw_new.Retrieve("%" + a_valor + "%", 0  )
		end if
CASE "DECIM"
		rows = cdw_new.Retrieve("%" + a_valor + "%", 0  )
CASE "DATE"
		rows = cdw_new.Retrieve("%" + a_valor + "%", v_d  )
CASE "DATET","TIMES"
		rows = cdw_new.Retrieve("%" + a_valor + "%", v_dt )
CASE "TIME"
		rows = cdw_new.Retrieve("%" + a_valor + "%", v_t )
CASE ELSE
		MessageBox ("Error - ColType", "No se pudo identificar el tipo de dato de la columna nro. " )
		return 0
END CHOOSE


if rows = -1 then
	MessageBox("Aviso..","Error al recuperar los datos.")
else
	if rows <= 1 then
		st_msg.Text = string(rows) + "  fila recuperada..."
	else
		st_msg.Text = string(rows) + "  filas recuperadas..."
	end if
end if

return 0
end function

on w_buscar_valor_dddw.create
this.dw_filtro=create dw_filtro
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_insert=create cb_insert
this.cb_1=create cb_1
this.st_error=create st_error
this.st_1=create st_1
this.cdw_new=create cdw_new
this.st_msg=create st_msg
this.Control[]={this.dw_filtro,&
this.cb_delete,&
this.cb_update,&
this.cb_insert,&
this.cb_1,&
this.st_error,&
this.st_1,&
this.cdw_new,&
this.st_msg}
end on

on w_buscar_valor_dddw.destroy
destroy(this.dw_filtro)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_insert)
destroy(this.cb_1)
destroy(this.st_error)
destroy(this.st_1)
destroy(this.cdw_new)
destroy(this.st_msg)
end on

event open;///*
//	Este modelo utiliza un esquema de busqueda basado en los parámetros definidos en la
//	propiedad 	'DATAWINDOW.column.TAG'. Por lo que es dependiente de la DW definida y no de la 
//	window en que se halle.
//	
//	Utilice este modelo para aquellos casos en que utilizar una DDDW puede ser muy costosa a
//	nivel de recursos...Este modelo sirve para reemplar a la dddw por otro mecanismo de busqueda.
//	
//	<<< UTILIZACION
//	1. Cree una DataWindow que será utilizada para la busqueda..defina el argumento de recuperación 
//	unicamente en el campo de tipo STRING (descripcion, nombre, etc.) y utilize el criterio de busqueda
//	LIKE en el WHERE del SQL de la DataWindow..
//	
//	2. Escriba en la propiedad 'TAG' de la columna específica como sigue:
//	
//	dddw:DataWindow;campo_origen1>campo_destino1[;campo_origen2>campo_destino2][:@]
//	
//	DEFINICION:
//	
//	dddw: 
//			utilizar siempre, determina si la columna posee una criterio de busqueda..
//
//	DataWindow
//			la DataWindow que se utilizará para la busqueda del valor específico, 
//			no olvide definir el argumento de recuperación.
//			Utilice la instrucción LIKE del SQL para indicar por que campo debe recuperar
//			 Ej: tabla.columna LIKE :argumento
//			 
//	;campo_origen1>campo_destino1 
//			campo_origen: 	el campo cuyo valor se desea devolver.
//			campo_destino: el campo al cual se desea devolver el valor.
//			> ó = (opcional): > emplea el metodo de SETTEXT para asignar el valor. Tenga en cuenta que
//									  esto dispara el ITEMCHANGED de la DW destino..
//									= emplea el metodo de SETITEM para asignar el valor. No dispara el ITEMCHANGED.
//			Soporta toda la cantidad de campos que la datawindow pueda devolver
//			
//	:@
//			Utilice esta, cuando desee que al abrirse la ventana ya aparezcan valores en la lista.
//			OJO!!, tenga cuidado de emplear esta opcion cuando la cantidad de datos en muy grande ya que 
//			recuperar todas las filas de la tabla en cuestion..
//			
//	EJEMPLO: dddw:dw_paices;1>5;2=8:@
//
//	Importante!!
//	- Recuerde que la instruccion SETTEXT, no es valida en caso de que el campo se encuentre invisible
//	  o el TABORDER sea igual a cero.., en cuyo caso se empleará obligadamente el SETITEM..
//*/

String 	ls_tag
Integer  col, po, po1, po2, posi, i
Boolean	recuperar = false

dw_filtro.SetTransObject(sqlca)
dw_filtro.insertrow(0)

idw_data = create datawindow

idw_data = message.PowerObjectParm

col		= idw_data.GetColumn()
ls_tag 	= Lower( idw_data.Describe("#" + string(col) + ".tag") )

// verifica si debe de mostrarse los datos..
	po = Pos( ls_tag , ":@" )
	if po > 0 then
		recuperar = true
		ls_tag = Left( ls_tag , po - 1 )
	end if

// asigna la datawindow de busqueda
	po = pos(ls_tag,";")
	if po > 0 then
		cdw_new.DataObject = mid(ls_tag,6,po - 6)
	else
		cdw_new.DataObject = mid(ls_tag,6)
	end if
	
	if cdw_new.SetTransObject(SQLCA) = -1 then
		beep(1)
		st_error.text = "Por favor verifique el nombre de la datawindow."
	else
		if po > 0 then
			ls_tag = mid(ls_tag,po + 1)
			DO
				po = pos(ls_tag,";")
				if po > 0 then
					ii_rows ++
	
					po1 = pos(ls_tag,">")
					po2 = pos(ls_tag,"=")
					
					if po1 = 0 then
						posi = po2
						ii_setitem[ii_rows] = true
					elseif po2 = 0 then
						posi = po1
						ii_setitem[ii_rows] = false
					elseif po1 < po2 and po1 <> 0 and po2 <> 0 then
						posi = po1
						ii_setitem[ii_rows] = false
					elseif po2 < po1 and po1 <> 0 and po2 <> 0 then
						posi = po2
						ii_setitem[ii_rows] = true
					end if
						
					ii_col[ii_rows] = integer( mid( ls_tag , 1 , posi - 1))
					ii_dev[ii_rows] = integer( mid( ls_tag , posi + 1, po - posi - 1))
					ls_tag = mid(ls_tag,po + 1)
				else
					ii_rows ++
	
					po1 = pos(ls_tag,">")
					po2 = pos(ls_tag,"=")
	
					if po1 = 0 then
						posi = po2
						ii_setitem[ii_rows] = true
					elseif po2 = 0 then
						posi = po1
						ii_setitem[ii_rows] = false
					elseif po1 < po2 and po1 <> 0 and po2 <> 0 then
						posi = po1
						ii_setitem[ii_rows] = false
					elseif po2 < po1 and po1 <> 0 and po2 <> 0 then
						posi = po2
						ii_setitem[ii_rows] = true
					end if
	
					ii_col[ii_rows] = integer( mid( ls_tag , 1 , posi - 1))
					ii_dev[ii_rows] = integer( mid(ls_tag , posi + 1  ))
					ls_tag			 = ""
				end if
				
			LOOP WHILE Len(ls_tag) > 0
		else
			ii_rows = 1
			ii_dev[1] = col
			ii_col[1] = 1
		end if
	
		if recuperar then
			wf_recuperar("")
			//cdw_new.SetFocus()
		end if
		
		cdw_new.SetSort(cdw_new.Describe("#2.name") + " A")
		cdw_new.Sort()
	
		if upper( cdw_new.Describe(cdw_new.Describe("#1.name") + ".Update") ) = 'YES' then
			cb_insert.SHOW()
			cb_update.SHOW()
			cb_delete.SHOW()
			this.Width = 2478
		end if
	
	end if

end event

event systemkey;//if key = KeyEscape! then
//	close(this)
//end if
end event

type dw_filtro from uo_datawindow within w_buscar_valor_dddw
integer x = 375
integer y = 32
integer width = 1225
integer height = 100
string dataobject = "filtro_texto"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;integer rows

if trim(data) = "" then return -1

st_msg.show()
st_msg.Text = "Buscando..."

if len(data) = 1 and cdw_new.DataObject <> 'dw_bus_proveedor' then
	MessageBox("Advertencia..","Debe definir un valor para la consulta.~rLa longitud mínima para el mismo deberá ser de 2 caracteres.")
	Beep(1)
	return -1
end if

wf_recuperar (data)

end event

event editchanged;call super::editchanged;if cdw_new.DataObject = 'dw_bus_proveedor' then 
	dw_filtro.accepttext()
//	integer rows
//	if trim(sle_1.text) = "" then return -1
//	wf_recuperar (Trim(Text))
end if
end event

type cb_delete from commandbutton within w_buscar_valor_dddw
boolean visible = false
integer x = 2272
integer y = 568
integer width = 165
integer height = 132
integer textsize = -24
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "£"
end type

event clicked;cdw_new.deleterow( cdw_new.getrow() )

cb_update.triggerevent(clicked!)
end event

type cb_update from commandbutton within w_buscar_valor_dddw
boolean visible = false
integer x = 2272
integer y = 408
integer width = 165
integer height = 132
integer textsize = -24
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "Í"
end type

event clicked;cdw_new.accepttext()
if cdw_new.update() = 1 then
	commit ;
else
	rollback;
	cdw_new.rowsmove(1,cdw_new.deletedcount(),delete!,cdw_new,1,primary!)
end if
end event

type cb_insert from commandbutton within w_buscar_valor_dddw
boolean visible = false
integer x = 2272
integer y = 248
integer width = 165
integer height = 132
integer textsize = -24
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "¤"
end type

event clicked;integer row

row = cdw_new.insertrow(0)

cdw_new.scrolltorow(row)

string v_sql, v_nombre_tabla
int v_caracteres
int v_contador

v_sql = upper(cdw_new.Describe("DataWindow.Table.Select"))
v_caracteres = len(v_sql)

v_contador = pos(v_sql, "FROM",1)
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
cdw_new.setcolumn(1)
v_campo = cdw_new.getcolumnname()
v_sql = "select max(" + v_campo + ") as Valor from " + v_nombre_tabla
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
cdw_new.SetItem(row,1,v_maximo)

cdw_new.setfocus()

end event

type cb_1 from commandbutton within w_buscar_valor_dddw
integer x = 1979
integer y = 28
integer width = 238
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Salir"
boolean cancel = true
end type

event clicked;Close(parent)

end event

type st_error from statictext within w_buscar_valor_dddw
integer x = 55
integer y = 1852
integer width = 2153
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_buscar_valor_dddw
integer x = 32
integer y = 32
integer width = 338
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
string text = " &Buscar por:"
boolean focusrectangle = false
end type

event clicked;dw_filtro.SetFocus()

end event

type cdw_new from datawindow within w_buscar_valor_dddw
event ue_processenter pbm_dwnprocessenter
event ue_tecla_pulsada pbm_dwnkey
integer y = 256
integer width = 2235
integer height = 1556
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_processenter;integer 	i, row, row2, asigna
string 	ls_coltype

row  = idw_data.GetRow()
row2 = GetRow()

if row = 0 or row2 = 0 then return

For i = 1 to ii_rows
		ls_coltype = cdw_new.Describe("#" + String(ii_col[i]) + ".ColType")
		CHOOSE CASE Upper(Left(ls_coltype,5))
		CASE "CHAR("
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],GetItemString(row2,ii_col[i]))
			else
				if SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],GetItemString(row2,ii_col[i]))
				else
					idw_data.SetText( GetText() )
				end if
			end if
				
		CASE "NUMBE","LONG"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],GetItemNumber(row2,ii_col[i]))
			else
				if SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],GetItemNumber(row2,ii_col[i]))
				else
					idw_data.SetText( GetText() )
				end if
			end if
		CASE "DECIM"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],GetItemDecimal(row2,ii_col[i]))
			else
				if SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],GetItemDecimal(row2,ii_col[i]))
				else
					idw_data.SetText( GetText() )
				end if
			end if
		CASE "DATE"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],GetItemDate(row2,ii_col[i]))
			else
				if SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],GetItemDate(row2,ii_col[i]))
				else
					idw_data.SetText( GetText() )
				end if
			end if
		CASE "DATET","TIMES"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],GetItemDateTime(row2,ii_col[i]))
			else
				if SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],GetItemDateTime(row2,ii_col[i]))
				else
					idw_data.SetText( GetText() )
				end if
			end if
		CASE "TIME"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],GetItemTime(row2,ii_col[i]))
			else
				if SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],GetItemTime(row2,ii_col[i]))
				else
					idw_data.SetText( GetText() )
				end if
			end if
		CASE ELSE
			MessageBox ("Error - ColType", "No se pudo identificar el tipo de dato de la columna nro. " + Describe("#" + String(ii_col[i]) + ".Name"))
			return -1
		END CHOOSE
Next

idw_data.AcceptText ()
	
close(parent)

end event

event ue_tecla_pulsada;if keydown(keyf3!) then 
	if cdw_new.DataObject = 'dw_busca_producto' then
		OpenWithParm(w_stock_producto, cdw_new.getitemstring(this.getrow(),1))
   end if
end if
end event

event doubleclicked;triggerevent(this,"ue_processenter")
end event

event error;action = exceptionfail!
end event

event dberror;
guo_func.of_db_error( sqldbcode,sqlerrtext,'' )

return 1

end event

event itemchanged;//if getitemstatus(row,0,primary!) <> NewModified! and getitemstatus(row,0,primary!) <> New!  then
//
//	return 2
//	
//else
//	
//	return 0
//
//end if
end event

type st_msg from statictext within w_buscar_valor_dddw
boolean visible = false
integer y = 160
integer width = 2235
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type


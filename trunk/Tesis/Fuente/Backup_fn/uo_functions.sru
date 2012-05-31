$PBExportHeader$uo_functions.sru
forward
global type uo_functions from nonvisualobject
end type
end forward

global type uo_functions from nonvisualobject
end type
global uo_functions uo_functions

type variables
public boolean ib_foto = false
public string is_carpeta = 'c:'
end variables

forward prototypes
public function integer of_append_row (ref datawindow a_cdw)
public function integer of_db_error (long a_sqldbcode, string a_sqlerrtext, string a_texto)
public function integer of_delete_row (ref datawindow a_cdw)
public function integer of_db_error (ref transaction a_transaction, string a_texto)
public function string of_find_cdw (ref datawindow a_cdw)
public function integer of_print (ref datawindow ar_cdw, boolean ar_dialog)
public subroutine of_open (window a_window)
public function string of_find_descrip (ref datawindow a_cdw, ref datawindow a_cdw_busca)
public function string of_etiqueta (integer v_archivo, integer v_tipo, string v_etiqueta)
public subroutine of_grupo (ref datawindow cdw_temp, integer v_grupo, boolean v_ocultar, integer v_altura)
public subroutine of_detalle (ref datawindow cdw_temp, boolean v_ocultar, integer v_altura)
public function integer of_permisos (string v_menu, integer v_opcion)
public subroutine of_reset_dw (ref datawindow a_dwo)
public function date of_last_day_of_month (integer v_anio, integer v_mes)
public function integer of_len_cuenta (long ar_codemp)
public function string of_formato_cuenta (long ar_codemp)
public function string of_update_mask (long ar_codemp)
public function integer of_update_dw (ref datawindow a_cdw)
public function string of_cuenta_superior (long ar_codemp, string ar_cuenta)
public function integer of_nivel_cuenta (long ar_codemp, string ar_cuenta)
public function string of_llenar_cuenta (long ar_codemp, string ar_cuenta)
public function integer of_niveles_cuentas (long ar_codemp)
public function string of_codigo (string ar_cod_dig)
public function date of_cast_date (string ar_fecha)
public function boolean of_valida_suc (ref datawindow ar_dw, integer ar_tipo, string ar_col)
public function integer of_asignar_foto (ref olecontrol ole, string codigo)
public function boolean of_existe_cotiz (datetime ar_fecha, long ar_mon_ori, long ar_mon_des)
public function string f_of_codigo (string ar_cod_dig)
end prototypes

public function integer of_append_row (ref datawindow a_cdw);
return a_cdw.InsertRow( 0 )

end function

public function integer of_db_error (long a_sqldbcode, string a_sqlerrtext, string a_texto);/*	Errores definidos para ORABLE...
	CHOOSE CASE a_sqldbcode
	CASE 1722
		ls_error = ""
	END CHOOSE	*/

string ls_error, msg

msg = ls_error + "~r~r" + &
		"Error Code:~t" + string( a_sqldbcode ) + "~r" + &
		"Text Error:~t" + a_sqlerrtext

MessageBox( "Error en la Base de Datos..",  msg )

/*	GUARDA EL ERROR EN UN ARCHIVO
	Modificar esta porcion utilizando el FileOpen
	en vez del datastore...
*/

return 1

end function

public function integer of_delete_row (ref datawindow a_cdw);
dwitemstatus dwis_1
integer row

row = GetRow( a_cdw )

if row <= 0 then return row

dwis_1 = a_cdw.GetItemStatus( row , 0 , Primary! )

if dwis_1 = new! or dwis_1 = newmodified! then
	a_cdw.DeleteRow( row )
else
	a_cdw.SelectRow( 0 , false )
	a_cdw.SelectRow( row , true )
	if MessageBox('PREGUNTA?','Desea borrar la fila?',Question!,YesNo!,1) = 1 then
		a_cdw.DeleteRow( row )
	end if
end if

a_cdw.SelectRow( 0 , false )

return row

end function

public function integer of_db_error (ref transaction a_transaction, string a_texto);
if a_transaction.sqlcode <> -1 then return 0

string msg

msg = a_texto + &
		"~r~r" + &
		"Error Code:~t" 	+ string( a_transaction.sqldbcode ) 	+ "~r" + &
		"Text Error:~r" 	+ a_transaction.sqlerrtext + "~r" + &
		"NRows:~t" 			+ String( a_transaction.sqlnrows )

MessageBox( "Error en la Base de Datos..", msg , stopSign! )


/*	GUARDA EL ERROR EN UN ARCHIVO
	Modificar esta porcion utilizando el FileOpen
	en vez del datastore...
*/

return a_transaction.sqlcode

end function

public function string of_find_cdw (ref datawindow a_cdw);
/*	Despliega la ventana de busqueda */

string ls_tag

ls_tag = Lower ( a_cdw.Describe ( "#" + string( a_cdw.GetColumn() ) + ".tag" ) )

if Left(ls_tag,5) = "dddw:" then
	OpenWithParm( w_buscar_valor_dddw , a_cdw )
	return ''
end if

if Pos(ls_tag,'findcuenta') > 0 then
	long codemp
	
	//codemp = a_cdw.GetItemNumber( GetRow(a_cdw) , 'codigo_empresa' )

	codemp = gl_codemp
	
	if isnull(codemp) or codemp <= 0 then return ''
	
	//OpenWithParm( w_buscar_cuenta, codemp )
	vg_codigo_cuenta = message.StringParm
	a_cdw.SetItem( GetRow(a_cdw), GetColumn(a_cdw), message.StringParm )
	return message.StringParm
	
end if

return ''

end function

public function integer of_print (ref datawindow ar_cdw, boolean ar_dialog);
return ar_cdw.print( ar_dialog )

end function

public subroutine of_open (window a_window);
open( a_window )

end subroutine

public function string of_find_descrip (ref datawindow a_cdw, ref datawindow a_cdw_busca);/*	Despliega la ventana de busqueda */
string ls_tag
ls_tag = Lower ( a_cdw.Describe ( "#" + string( a_cdw.GetColumn() ) + ".tag" ) )
integer 	row, row2, asigna
string 	ls_coltype

if Left(ls_tag,5) = "dddw:" then
	integer ii_rows
	integer ii_col[]
	integer ii_dev[]
	boolean ii_setitem[]
	DataWindow idw_data, cdw_new
	
	Integer  col, po, po1, po2, posi, i
	//idw_data = create datawindow
	//cdw_new = create datawindow
	cdw_new = a_cdw_busca
	idw_data = a_cdw
	
	col		= idw_data.GetColumn()
	ls_tag 	= Lower( idw_data.Describe("#" + string(col) + ".tag") )
	// verifica si debe de mostrarse los datos..
	po = Pos( ls_tag , ":@" )
	if po > 0 then
		ls_tag = Left( ls_tag , po - 1 )
	end if
	// asigna la datawindow de busqueda
	po = pos(ls_tag,";")
	if po > 0 then
		cdw_new.DataObject = mid(ls_tag,6,po - 6)
	else
		cdw_new.DataObject = mid(ls_tag,6)
	end if
	if cdw_new.SetTransObject(sqlca) = -1 then 
		beep(1)
		messagebox('Error', "Por favor verifique el nombre de la datawindow.")
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
					ii_dev[ii_rows] = integer( mid( ls_tag , posi + 1 , po - posi - 1))
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
					ii_dev[ii_rows] = integer( mid(ls_tag , posi + 1 ))
					ls_tag			 = ""
				end if
				
			LOOP WHILE Len(ls_tag) > 0
		else
			ii_rows = 1
			ii_dev[1] = col
			ii_col[1] = 1
		end if
	
		integer rows
		ls_coltype = idw_data.Describe("#" + string(idw_data.GetColumn()) + ".ColType")
		CHOOSE CASE Upper(Left(ls_coltype,5))
		CASE "CHAR("
			rows = cdw_new.Retrieve("xxxzzzyyyaaa", idw_data.gettext()  )
		CASE "NUMBE","LONG"
			rows = cdw_new.Retrieve("xxxzzzyyyaaa", double(idw_data.gettext())  )
		CASE "DECIM"
			rows = cdw_new.Retrieve("xxxzzzyyyaaa", double(idw_data.gettext())  )
		CASE "DATE"
			rows = cdw_new.Retrieve("xxxzzzyyyaaa", date(idw_data.gettext())  )
		CASE "DATET","TIMES"
			rows = cdw_new.Retrieve("xxxzzzyyyaaa", datetime(idw_data.gettext())  )
		CASE "TIME"
			rows = cdw_new.Retrieve("xxxzzzyyyaaa", time(idw_data.gettext())  )
		CASE ELSE
			MessageBox ("Error - ColType", "No se pudo identificar el tipo de dato de la columna nro. " )
			return ''
		END CHOOSE
		
		if rows = -1 then
			MessageBox("Aviso..","Error al recuperar los datos.")
		else
			if rows <= 0 then
				messagebox('Error...', 'No existe el valor digitado: ' + idw_data.gettext())
//				idw_data.event post itemerror(idw_data.getrow(), dwo_temp, '')
				double v_temp_err
				SetNull(v_temp_err)
				string ls_datatype
				row = idw_data.getrow()
				col = idw_data.getcolumn()
				ls_datatype = idw_data.describe("#"+string(idw_data.getcolumn())+".coltype") 
				CHOOSE CASE left(ls_datatype, 4)
				CASE "long"
					post setitem(idw_data, row, col, v_temp_err)
				CASE "nume"
					post setitem(idw_data, row, col, v_temp_err)
				CASE "deci"
					post setitem(idw_data, row, col, v_temp_err)
				CASE "date"
					date null_date
					SetNull(null_date)
					post setitem(idw_data, row, col, null_date)
				CASE "char"
					string null_string
					SetNull(null_string)
					post setitem(idw_data, row, col, null_string)
				END CHOOSE
				post setcolumn(idw_data, idw_data.getcolumn())

				return ''
				cdw_new.setrow(1)
			end if
		end if

//Asigna los valores correspondientes a las columnas	

row  = idw_data.GetRow()
row2 = cdw_new.GetRow()

if row = 0 or row2 = 0 then return ''

For i = 1 to ii_rows
		ls_coltype = cdw_new.Describe("#" + String(ii_col[i]) + ".ColType")
		CHOOSE CASE Upper(Left(ls_coltype,5))
		CASE "CHAR("
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemString(row2,ii_col[i]))
			else
				if cdw_new.SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemString(row2,ii_col[i]))
				else
					idw_data.SetText( cdw_new.GetText() )
				end if
			end if
				
		CASE "NUMBE","LONG"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemNumber(row2,ii_col[i]))
			else
				if cdw_new.SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemNumber(row2,ii_col[i]))
				else
					idw_data.SetText( cdw_new.GetText() )
				end if
			end if
		CASE "DECIM"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemDecimal(row2,ii_col[i]))
			else
				if cdw_new.SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemDecimal(row2,ii_col[i]))
				else
					idw_data.SetText( cdw_new.GetText() )
				end if
			end if
		CASE "DATE"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemDate(row2,ii_col[i]))
			else
				if cdw_new.SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemDate(row2,ii_col[i]))
				else
					idw_data.SetText( cdw_new.GetText() )
				end if
			end if
		CASE "DATET","TIMES"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemDateTime(row2,ii_col[i]))
			else
				if cdw_new.SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemDateTime(row2,ii_col[i]))
				else
					idw_data.SetText( cdw_new.GetText() )
				end if
			end if
		CASE "TIME"
			if ii_setitem[i] then
				idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemTime(row2,ii_col[i]))
			else
				if cdw_new.SetColumn(ii_col[i]) = -1 or idw_data.SetColumn(ii_dev[i]) = -1 then
					idw_data.SetItem(row,ii_dev[i],cdw_new.GetItemTime(row2,ii_col[i]))
				else
					idw_data.SetText( cdw_new.GetText() )
				end if
			end if
		CASE ELSE
			MessageBox ("Error - ColType", "No se pudo identificar el tipo de dato de la columna nro. " + cdw_new.Describe("#" + String(ii_col[i]) + ".Name"))
			return ''
		END CHOOSE
		
Next

idw_data.AcceptText ()
	

	
	
	
	
	
	
	end if
	return ''
end if

if Pos(ls_tag,'findcuenta') > 0 then
	long codemp
// codemp = a_cdw.GetItemNumber( GetRow(a_cdw) , 'codigo_empresa' )
//	codemp = gl_codemp
//	if isnull(codemp) or codemp <= 0 then return ''
//	OpenWithParm( w_buscar_cuenta, codemp )
//	vg_codigo_cuenta = message.StringParm
//	a_cdw.SetItem( GetRow(a_cdw), GetColumn(a_cdw), message.StringParm )
//	return message.StringParm
end if

return ''

end function

public function string of_etiqueta (integer v_archivo, integer v_tipo, string v_etiqueta);if v_archivo = 1 then
	IF v_tipo = 1 THEN
		RETURN ProfileString("Stock.dic", "FICHAS" , LEFT(v_etiqueta,5), RIGHT(v_etiqueta,LEN(V_ETIQUETA)-5))	
	ELSEIF v_tipo = 2 THEN
		RETURN ProfileString("STOCK.DIC", "MOVIMIENTOS" , LEFT(v_etiqueta,5), RIGHT(v_etiqueta,LEN(V_ETIQUETA)-5))	
	ELSEIF v_tipo = 3 THEN
		RETURN ProfileString("STOCK.DIC", "INFORMES" , LEFT(v_etiqueta,5), RIGHT(v_etiqueta,LEN(V_ETIQUETA)-5))	
	END IF
end if



	

end function

public subroutine of_grupo (ref datawindow cdw_temp, integer v_grupo, boolean v_ocultar, integer v_altura);string v_temp
if v_ocultar then
	v_temp = 'DataWindow.Header.' + trim(string(v_grupo)) + '.Height=' + trim(string(v_altura))
else
	v_temp = 'DataWindow.Header.' + trim(string(v_grupo)) + '.Height=0'
end if
cdw_temp.Modify(v_temp)
end subroutine

public subroutine of_detalle (ref datawindow cdw_temp, boolean v_ocultar, integer v_altura);string v_temp
if v_ocultar then
	v_temp = 'DataWindow.Detail.Height=' + trim(string(v_altura))
else
	v_temp = 'DataWindow.Detail.Height=0'
end if
cdw_temp.Modify(v_temp)
end subroutine

public function integer of_permisos (string v_menu, integer v_opcion);Int v_permitido
int v_existe
	if v_opcion = 1 then
		Select ver into :v_permitido
		from dbo.sys_permisos
		where grupo = :vg_grupo and id = :v_menu;
	end if
	if v_opcion = 2 then
		Select Grabar into :v_permitido
		from dbo.sys_permisos
		where grupo = :vg_grupo and id = :v_menu;
	end if
	if v_opcion = 3 then
		Select Borrar into :v_permitido
		from dbo.sys_permisos
		where grupo = :vg_grupo and id = :v_menu;
	end if
	if v_opcion = 4 then
		Select Incluir into :v_permitido
		from dbo.sys_permisos
		where grupo = :vg_grupo and id = :v_menu;
	end if
	Select count(*) into :v_existe
	from dbo.sys_permisos
	where grupo = :vg_grupo and id = :v_menu;
if v_existe = 0 then
	v_permitido = 1
end if
return v_permitido
end function

public subroutine of_reset_dw (ref datawindow a_dwo);long v_temp_err
SetNull(v_temp_err)
string ls_datatype 
ls_datatype = a_dwo.describe("#"+string(a_dwo.getcolumn())+".coltype") 
long row, col
row = a_dwo.getrow()
col = a_dwo.getcolumn()

CHOOSE CASE left(ls_datatype, 4)
CASE "long"
		a_dwo.SetItem(row, col, v_temp_err)
CASE "nume"
		a_dwo.SetItem(row, col, v_temp_err)
CASE "deci"
		a_dwo.SetItem(row, col, v_temp_err)
CASE "date"
		date null_date
		SetNull(null_date)
		a_dwo.SetItem(row, col, null_date)
CASE "char"
		string null_string
		SetNull(null_string)
		a_dwo.SetItem(row, col, null_string)
END CHOOSE

a_dwo.setcolumn(col)


end subroutine

public function date of_last_day_of_month (integer v_anio, integer v_mes);CHOOSE CASE v_mes
CASE 1
   return date(v_anio, v_mes, 31)
CASE 2
	if mod(v_anio, 4) = 0 then
   	return date(v_anio, v_mes, 29)
	else
   	return date(v_anio, v_mes, 28)
	end if
CASE 3
   return date(v_anio, v_mes, 31)
CASE 4
   return date(v_anio, v_mes, 30)
CASE 5
   return date(v_anio, v_mes, 31)
CASE 6
   return date(v_anio, v_mes, 30)
CASE 7
   return date(v_anio, v_mes, 31)
CASE 8
   return date(v_anio, v_mes, 31)
CASE 9
   return date(v_anio, v_mes, 30)
CASE 10
   return date(v_anio, v_mes, 30)
CASE 11
   return date(v_anio, v_mes, 30)
CASE 12
   return date(v_anio, v_mes, 31)
CASE ELSE
   return date(today())
END CHOOSE



		 
end function

public function integer of_len_cuenta (long ar_codemp);
integer 	li_nivel[1 to 9]
integer 	li_niveles, i, li_len

/*	Recupera los niveles de las cuentas */
  SELECT dbo.empresas.niveles,   
         dbo.empresas.nivel1,   
         dbo.empresas.nivel2,   
         dbo.empresas.nivel3,   
         dbo.empresas.nivel4,   
         dbo.empresas.nivel5,   
         dbo.empresas.nivel6,   
         dbo.empresas.nivel7,   
         dbo.empresas.nivel8,   
         dbo.empresas.nivel9  
    INTO :li_niveles,   
         :li_nivel[1],   
         :li_nivel[2],   
         :li_nivel[3],   
         :li_nivel[4],   
         :li_nivel[5],   
         :li_nivel[6],   
         :li_nivel[7],   
         :li_nivel[8],   
         :li_nivel[9]  
    FROM dbo.empresas  
   WHERE dbo.empresas.codigo_empresa = :ar_codemp ;
	
	if guo_func.of_db_error ( sqlca, 'Al recuperar niveles de las cuentas (Longitud).' ) = -1 then return 0
	
	For i = 1 to li_niveles
		li_len += li_nivel[i]
	Next

	return li_len

end function

public function string of_formato_cuenta (long ar_codemp);
integer 	li_nivel[1 to 9]
integer 	li_niveles, i, j
string	ls_mask = ''

/*	Recupera los niveles de las cuentas */
  SELECT empresas.niveles,   
         empresas.nivel1,   
         empresas.nivel2,   
         empresas.nivel3,   
         empresas.nivel4,   
         empresas.nivel5,   
         empresas.nivel6,   
         empresas.nivel7,   
         empresas.nivel8,   
         empresas.nivel9  
    INTO :li_niveles,   
         :li_nivel[1],   
         :li_nivel[2],   
         :li_nivel[3],   
         :li_nivel[4],   
         :li_nivel[5],   
         :li_nivel[6],   
         :li_nivel[7],   
         :li_nivel[8],   
         :li_nivel[9]  
    FROM empresas  
   WHERE empresas.codigo_empresa = :ar_codemp ;
	
	if guo_func.of_db_error ( sqlca, 'Al recuperar niveles de las cuentas.' ) = -1 then return ''
	
	For i = 1 to li_niveles
		For j = 1 to li_nivel[i]
			ls_mask = ls_mask + '#'
		Next
		if i < li_niveles then ls_mask = ls_mask + '.'
	Next

return ls_mask

end function

public function string of_update_mask (long ar_codemp);gs_mask = guo_func.of_formato_cuenta ( gl_codemp )

  UPDATE parametros  
     SET mask = :gs_mask  
   WHERE parametros.codigo_empresa = :ar_codemp ;

if guo_func.of_db_error ( sqlca, 'No se pudo guardar la máscara de la cuenta.' ) = -1 then return ''
commit;
return gs_mask

end function

public function integer of_update_dw (ref datawindow a_cdw);if a_cdw.Update() = 1 then
	Commit using sqlca ;
else
	rollback using sqlca ;
	/*	Poner la logica que recupera las filas borradas con error en el dberror */
	//a_cdw.RowsMove ( 1 , DeletedCount(a_cdw) , delete! , a_cdw , RowCount(a_cdw) + 1 , primary! )
	return -1
end if

return 0

end function

public function string of_cuenta_superior (long ar_codemp, string ar_cuenta);/***************************************************************************
	Calcula el nivel que le pertenece a la cuenta dada, conforme a la 
	cantidad de niveles que maneja el plan de cuentas.
	
	Arg		:	codigo de la empresa
					cuenta
	Return	:	nivel de la cuenta
****************************************************************************/

	integer 	li_nivel[1 to 9]
	string	ls_cuentasup
	integer 	li_niveles, pos, li_nivel_cuenta


	setnull( ls_cuentasup )

/*	Recupera los niveles de las cuentas */
  SELECT empresas.niveles,   
         empresas.nivel1,   
         empresas.nivel2,   
         empresas.nivel3,   
         empresas.nivel4,   
         empresas.nivel5,   
         empresas.nivel6,   
         empresas.nivel7,   
         empresas.nivel8,   
         empresas.nivel9  
    INTO :li_niveles,   
         :li_nivel[1],   
         :li_nivel[2],   
         :li_nivel[3],   
         :li_nivel[4],   
         :li_nivel[5],   
         :li_nivel[6],   
         :li_nivel[7],   
         :li_nivel[8],   
         :li_nivel[9]  
    FROM empresas  
   WHERE empresas.codigo_empresa = :ar_codemp ;
	
	if guo_func.of_db_error ( sqlca, 'Al recuperar niveles de las cuentas.' ) = -1 then 
		return ''
	end if
	

	/* recupera el nivel de la cuenta */
	
	li_nivel_cuenta = guo_func.of_nivel_cuenta ( ar_codemp, ar_cuenta )

	if li_nivel_cuenta = 1 then
		return ar_cuenta ;
	end if;

	li_nivel_cuenta --

	pos = 1

	IF li_nivel_cuenta >= 1 THEN
		ls_cuentasup = mid(ar_cuenta,pos,li_nivel[1])
		pos = pos + li_nivel[1]
	END IF;

	IF li_nivel_cuenta >= 2 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[2])
		pos = pos + li_nivel[2]
	END IF;

	IF li_nivel_cuenta >= 3 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[3])
		pos = pos + li_nivel[3]
	END IF;

	IF li_nivel_cuenta >= 4 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[4])
		pos = pos + li_nivel[4]
	END IF;

	IF li_nivel_cuenta >= 5 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[5])
		pos = pos + li_nivel[5]
	END IF;

	IF li_nivel_cuenta >= 6 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[6])
		pos = pos + li_nivel[6]
	END IF;

	IF li_nivel_cuenta >= 7 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[7])
		pos = pos + li_nivel[7]
	END IF;

	IF li_nivel_cuenta >= 8 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[8])
		pos = pos + li_nivel[8]
	END IF;

	IF li_nivel_cuenta >= 9 THEN
		ls_cuentasup = ls_cuentasup + mid(ar_cuenta,pos,li_nivel[9])
		pos = pos + li_nivel[9]
	END IF;

	/*	determinar la longitud de la cuenta */
	pos = 0 ;

	IF li_niveles >= 1 THEN
		pos = pos + li_nivel[1]
	END IF;

	IF li_niveles >= 2 THEN
		pos = pos + li_nivel[2]
	END IF;

	IF li_niveles >= 3 THEN
		pos = pos + li_nivel[3]
	END IF;

	IF li_niveles >= 4 THEN
		pos = pos + li_nivel[4]
	END IF;

	IF li_niveles >= 5 THEN
		pos = pos + li_nivel[5]
	END IF;

	IF li_niveles >= 6 THEN
		pos = pos + li_nivel[6]
	END IF;

	IF li_niveles >= 7 THEN
		pos = pos + li_nivel[7] ;
	END IF;

	IF li_niveles >= 8 THEN
		pos = pos + li_nivel[8] ;
	END IF;

	IF li_niveles >= 9 THEN
		pos = pos + li_nivel[9] ;
	END IF;

	ls_cuentasup = mid(ls_cuentasup + '0000000000000000000000000000',1,pos);

RETURN ls_cuentasup

end function

public function integer of_nivel_cuenta (long ar_codemp, string ar_cuenta);
/***************************************************************************
	Calcula el nivel que le pertenece a la cuenta dada, conforme a la 
	cantidad de niveles que maneja el plan de cuentas.
	
	Arg		:	codigo de la empresa
					cuenta
	Return	:	nivel de la cuenta
****************************************************************************/


	integer 	li_nivel[1 to 9], li_ini = 1, li_len, li_nivel_actual
	string	ls_nivel_cuenta
	integer 	li_niveles, i

/*	Recupera los niveles de las cuentas */
  SELECT dbo.empresas.niveles,   
         dbo.empresas.nivel1,   
         dbo.empresas.nivel2,   
         dbo.empresas.nivel3,   
         dbo.empresas.nivel4,   
         dbo.empresas.nivel5,   
         dbo.empresas.nivel6,   
         dbo.empresas.nivel7,   
         dbo.empresas.nivel8,   
         dbo.empresas.nivel9  
    INTO :li_niveles,   
         :li_nivel[1],   
         :li_nivel[2],   
         :li_nivel[3],   
         :li_nivel[4],   
         :li_nivel[5],   
         :li_nivel[6],   
         :li_nivel[7],   
         :li_nivel[8],   
         :li_nivel[9]  
    FROM dbo.empresas  
   WHERE dbo.empresas.codigo_empresa = :ar_codemp ;
	
	if guo_func.of_db_error ( sqlca, 'Al recuperar niveles de las cuentas.' ) = -1 then return 0
	
	For i = 1 to li_niveles
		li_len = li_nivel[i]
		ls_nivel_cuenta = Mid(ar_cuenta,li_ini,li_len)
		if long(ls_nivel_cuenta) > 0 then
			li_nivel_actual = i
		else
			Exit
		end if
		li_ini += li_len
	Next
	
	if li_nivel_actual < 0 then li_nivel_actual = 0
	
	return li_nivel_actual

end function

public function string of_llenar_cuenta (long ar_codemp, string ar_cuenta);
/********************************************************************
	Rellena de ceros a la derecha de la cuenta
*********************************************************************/

integer li_niveles, li_len

//li_niveles = guo_func.of_niveles_cuentas ( gl_codemp )
li_len = guo_func.of_len_cuenta( gl_codemp )

if li_niveles > 0 then
	ar_cuenta = Trim( ar_cuenta )
	ar_cuenta = Left( ar_cuenta + '000000000000000000000000000000' , li_len )
end if

return ar_cuenta

end function

public function integer of_niveles_cuentas (long ar_codemp);/*****************************************************************************
	Determina la cantidad de niveles que maneja el plan de cuenta.
	
	Arg		: codigo de la empresa
	Return	: niveles de plan de cuentas
******************************************************************************/
	integer li_niveles

  SELECT dbo.empresas.niveles  
    INTO :li_niveles  
    FROM dbo.empresas  
   WHERE dbo.empresas.codigo_empresa = :ar_codemp ;

	if guo_func.of_db_error ( sqlca, 'Error al recuperar niveles de las cuentas.' ) = -1 then return 0

return li_niveles


end function

public function string of_codigo (string ar_cod_dig);//string ls_codigo
//long ll_new
//select new_product into :ll_new from par_sys;
//if ll_new = 1 then
//	select codigo into :ls_codigo from productos_codigos 
//	where codigo_alternativo = :ar_cod_dig;
//	if isnull(ls_codigo) or ls_codigo = '' then 
//		select top 1 codigo into :ls_codigo from productos_prov 
//		where cod_proveedor = :gl_proveedor and codigo_prov = :ar_cod_dig;
//		/*if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig*/
//	end if
//	if isnull(ls_codigo) or ls_codigo = '' then 
//		select top 1 codigo into :ls_codigo from productos_prov 
//		where /*principal = 1 and */codigo_prov = :ar_cod_dig;
//		if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig
//	end if	
//else
//	select codigo into :ls_codigo from productos
//	where codigo_barras = :ar_cod_dig ;
//	if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig
//end if
//return ls_codigo
//		
string ls_codigo
long ll_new
select new_product into :ll_new from par_sys;
if ll_new = 1 then
	select codigo into :ls_codigo from productos_codigos 
	where codigo_alternativo = :ar_cod_dig;
	if isnull(ls_codigo) or ls_codigo = '' then 
		select top 1 codigo into :ls_codigo from productos_prov 
		where cod_proveedor = :gl_proveedor and codigo_prov = :ar_cod_dig;
		if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig
	end if
	
else
	select codigo into :ls_codigo from productos
	where codigo_barras = :ar_cod_dig ;
	if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig
end if
return ls_codigo
		

end function

public function date of_cast_date (string ar_fecha);date ld_return
ld_return = date(ar_fecha)
if isnull(ar_fecha) or ar_fecha = '' or ar_fecha = '00/00/00' or ar_fecha = '00/00/0000' or not isdate(ar_fecha) then
	setnull(ld_return)
end if
return ld_return
end function

public function boolean of_valida_suc (ref datawindow ar_dw, integer ar_tipo, string ar_col);if gl_sucursal = 0 then return true
if ar_dw.rowcount() = 0 then return false
long ll_suc
if ar_tipo = 1 then
	long ll_dep
	ll_dep = ar_dw.getitemnumber(ar_dw.getrow(), ar_col)
	select cod_sucursal into :ll_suc from depositos where cod_deposito = :ll_dep;
	if error_db(sqlca, 'Error al selecionar sucursal en depósitos...') then return false
	if ll_suc = gl_sucursal then
		return true
	else
		return false
	end if
	return true
elseif ar_tipo = 2 then
	long ll_lista
	ll_lista = ar_dw.getitemnumber(ar_dw.getrow(), ar_col)
	select cod_sucursal into :ll_suc from precios_cab where nro_lista = :ll_lista;
	if error_db(sqlca, 'Error al selecionar sucursal en precios_cab...') then return false
	if ll_suc = gl_sucursal then
		return true
	else
		return false
	end if
elseif ar_tipo = 3 then
	return true
else
	return false
end if
end function

public function integer of_asignar_foto (ref olecontrol ole, string codigo);if not ib_foto then return 0
ole.visible = true
if not FileExists ( is_carpeta + '\' + codigo + '.jpg' ) then return 0
ole.InsertClass("Paint.Picture")
ole.LinkTo(is_carpeta + '\' + codigo + '.jpg')
return 1
end function

public function boolean of_existe_cotiz (datetime ar_fecha, long ar_mon_ori, long ar_mon_des);long ll_temp
boolean lb_return
if ar_mon_ori = ar_mon_des then return true
select count(*) into :ll_temp from 
cotizaciones 
where cod_moneda = :ar_mon_ori and 
		cod_moneda_destino = :ar_mon_des and 
		fecha = :ar_fecha;
if error_db(sqlca, 'Error al seleccionar cotización...') then return false
lb_return = false
if ll_temp > 0 then lb_return = true
return lb_return

end function

public function string f_of_codigo (string ar_cod_dig);string ls_codigo
long ll_new
select new_product into :ll_new from par_sys;
if ll_new = 1 then
	select codigo into :ls_codigo from productos_codigos 
	where codigo_alternativo = :ar_cod_dig;
	if isnull(ls_codigo) or ls_codigo = '' then 
		select top 1 codigo into :ls_codigo from productos_prov 
		where cod_proveedor = :gl_proveedor and codigo_prov = :ar_cod_dig;
		/*if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig*/
	end if
	if isnull(ls_codigo) or ls_codigo = '' then 
		select top 1 codigo into :ls_codigo from productos_prov 
		where /*principal = 1 and */codigo_prov = :ar_cod_dig;
		if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig
	end if	
else
	select codigo into :ls_codigo from productos
	where codigo_barras = :ar_cod_dig ;
	if isnull(ls_codigo) or ls_codigo = '' then ls_codigo = ar_cod_dig
end if
return ls_codigo
		
end function

on uo_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


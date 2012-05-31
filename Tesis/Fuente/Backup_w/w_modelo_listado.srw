$PBExportHeader$w_modelo_listado.srw
forward
global type w_modelo_listado from window
end type
type dw_codecs from uo_datawindow within w_modelo_listado
end type
type pb_file from uo_boton within w_modelo_listado
end type
type pb_salir from uo_boton within w_modelo_listado
end type
type pb_ver from uo_boton within w_modelo_listado
end type
type pb_mail from uo_boton within w_modelo_listado
end type
type pb_print from uo_boton within w_modelo_listado
end type
type pb_export from uo_boton within w_modelo_listado
end type
type pb_orden from uo_boton within w_modelo_listado
end type
type pb_filtrar from uo_boton within w_modelo_listado
end type
type cbx1 from checkbox within w_modelo_listado
end type
type cdw_listado from uo_datawindow within w_modelo_listado
end type
end forward

shared variables

end variables

global type w_modelo_listado from window
integer x = 5
integer y = 4
integer width = 3589
integer height = 2100
boolean titlebar = true
string title = "Vista previa de informe..."
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
event ue_primera ( )
event ue_siguiente ( )
event ue_anterior ( )
event ue_ultima ( )
dw_codecs dw_codecs
pb_file pb_file
pb_salir pb_salir
pb_ver pb_ver
pb_mail pb_mail
pb_print pb_print
pb_export pb_export
pb_orden pb_orden
pb_filtrar pb_filtrar
cbx1 cbx1
cdw_listado cdw_listado
end type
global w_modelo_listado w_modelo_listado

type variables
any vi_argumentos[30]
datastore di_codecs
end variables

event ue_primera;cdw_listado.ScrollToRow ( 1 )

end event

event ue_siguiente;cdw_listado.ScrollNextPage ( )
end event

event ue_anterior;cdw_listado.ScrollPriorPage ( )
end event

event ue_ultima;cdw_listado.ScrollToRow ( cdw_listado.rowcount() )
end event

event open;if permisos(vg_menu, 5) = 1 then 
	pb_print.enabled = true
else
	pb_print.enabled = false
end if

//messagebox('vg_menu', string(vg_menu)
if isnull(Message.StringParm) or  Message.StringParm = '' then
	messagebox('Error...', 'El reporte no existe o tiene problemas...')
	post close(this)
	return
else
	cdw_listado.dataobject = Message.StringParm
end if
cdw_listado.settransobject(vg_server5)
dw_codecs.settransobject(sqlca)

cdw_listado.Modify("datawindow.print.Preview=Yes")
cdw_listado.object.datawindow.print.preview.rulers = 'yes'


end event

on w_modelo_listado.create
this.dw_codecs=create dw_codecs
this.pb_file=create pb_file
this.pb_salir=create pb_salir
this.pb_ver=create pb_ver
this.pb_mail=create pb_mail
this.pb_print=create pb_print
this.pb_export=create pb_export
this.pb_orden=create pb_orden
this.pb_filtrar=create pb_filtrar
this.cbx1=create cbx1
this.cdw_listado=create cdw_listado
this.Control[]={this.dw_codecs,&
this.pb_file,&
this.pb_salir,&
this.pb_ver,&
this.pb_mail,&
this.pb_print,&
this.pb_export,&
this.pb_orden,&
this.pb_filtrar,&
this.cbx1,&
this.cdw_listado}
end on

on w_modelo_listado.destroy
destroy(this.dw_codecs)
destroy(this.pb_file)
destroy(this.pb_salir)
destroy(this.pb_ver)
destroy(this.pb_mail)
destroy(this.pb_print)
destroy(this.pb_export)
destroy(this.pb_orden)
destroy(this.pb_filtrar)
destroy(this.cbx1)
destroy(this.cdw_listado)
end on

event resize;cdw_listado.Resize(this.Width - 80, this.Height - 300)

//vg_cancel_retrieve = false
//Open(w_cancel_button)

//w_cancel_button.st_count.text = String(row)
//if vg_cancel_retrieve = true then 
//	return 1
//end if
//Close(w_cancel_button)
end event

event activate;m_menu.m_editar.m_grabar.enabled = false
m_menu.m_editar.m_borrar.enabled = false
m_menu.m_editar.m_buscar.enabled = false
m_menu.m_editar.m_imprimir_abm.enabled = false

m_menu.m_editar.m_primero.enabled = true
m_menu.m_editar.m_siguiente.enabled = true
m_menu.m_editar.m_anterior.enabled = true
m_menu.m_editar.m_ultimo.enabled = true

this.Move ( 0, 0 )
end event

event deactivate;m_menu.m_editar.m_grabar.enabled = true
m_menu.m_editar.m_borrar.enabled = true
m_menu.m_editar.m_buscar.enabled = true
m_menu.m_editar.m_imprimir_abm.enabled = true

m_menu.m_editar.m_primero.enabled = false
m_menu.m_editar.m_siguiente.enabled = false
m_menu.m_editar.m_anterior.enabled = false
m_menu.m_editar.m_ultimo.enabled = false

end event

event close;vg_param_1a =''
vg_param_1b=''
vg_param_2a =0
vg_param_2b=0
vg_param_3a =0
vg_param_3b=0
vg_param_4a =0
vg_param_4b=0
vg_param_5a =0
vg_param_5b=0
vg_param_6a =0
vg_param_6b=0
vg_param_7a =0
vg_param_7b=0

end event

type dw_codecs from uo_datawindow within w_modelo_listado
string tag = "cdw_listado"
boolean visible = false
integer x = 2779
integer y = 192
integer width = 622
integer height = 896
integer taborder = 50
string dataobject = "dw_productos_codigo_alternativo"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;long ll_cant_filas,i
integer li_filnum
string variable,direccion,sintax,errors
string cod_report
integer filas,j,z
string cod_alternativo
ll_cant_filas = this.rowcount( )
if ll_cant_filas > 0 then
	if dwo.name = 't_35' then
		direccion = profilestring("pegasus.ini",'carpetas','CARGA','')
		if fileexists(direccion) then
			li_filnum = fileopen(direccion,LineMode!,Write!,LockWrite!,Replace!)
		else
			messagebox('Aviso','No se ha podido encontrar el archivo en donde guardar los productos!',Exclamation!)
			if GetFileOpenName('Archivo de Exportacion de Productos',direccion,variable,'txt') <= 0  then
				Messagebox('Aviso','No ha podido especificar el archivo de exportacion de productos',StopSign!)
				return
			else
				li_filnum = fileopen(direccion,linemode!,Write!,LockWrite!,Replace!)
			end if
		end if
		if li_filnum > 0 then
			di_codecs = create datastore
			sintax = sqlca.syntaxfromsql( "select codigo_alternativo from productos_codigos" ,"",errors)
			if len(errors) > 0 then
					Messagebox('Error','NO se ha podido construir la base para tomar todos los codigos de barra:~n'&
						+errors,StopSign!)
					Return
			end if
			di_codecs.Create(sintax,errors)
			if len(errors) > 0 then
			  MessageBox("Error", &
      		"No se ha podido tomar los codigos de barra: " + ERRORS,stopsign!)
				return
			end if
			setpointer(hourglass!)
			di_codecs.settransobject(sqlca)
			for i = 1 to ll_cant_filas
				string ll
				cod_report = string(this.object.data[i,6])
				di_codecs.SetSQLSelect ("select codigo_alternativo from productos_codigos where codigo = "+cod_report)
				ll = di_codecs.GetSQLSelect ( )
				Messagebox('ll','ll '+ll,StopSign!)
				di_codecs.settransobject( sqlca)
				filewrite(li_filnum,cod_report)
				z ++
				filas = di_codecs.retrieve(cod_report)
				Messagebox('cod_report','cod_report '+cod_report,StopSign!)
				Messagebox('filas','filas '+string(filas),StopSign!)
				if filas <=0 then continue
				for j = 1 to filas
					cod_alternativo = string(di_codecs.object.data[j,1])
					if cod_alternativo = cod_report then continue
					filewrite(li_filnum,cod_alternativo)
					z++
				next
			next
			Messagebox('Confirmado','Se han exportado los '+string(i - 1 )+' productos para la recepcion~n'&
					+'con:'+string(z)+ ' codigos de barras')
			fileclose(li_filnum)
			setpointer(arrow!)
			openwithparm(w_files_transfer,1)
		else
			Messagebox('Aviso','Error al intentar abrir el archivo de exportacion!')
			return
		end if
	end if
end if
//long ll_cant_filas,i
//integer li_filnum
//string variable,direccion
//
//ll_cant_filas = this.rowcount( )
//if ll_cant_filas > 0 then
//	if dwo.name = 't_35' then
//		direccion = profilestring("pegasus.ini",'carpetas','CARGA','')
//		if fileexists(direccion) then
//			li_filnum = fileopen(direccion,LineMode!,Write!,LockWrite!,Replace!)
//		else
//			messagebox('Aviso','No se podido encontrar el archivo en donde guardar los productos!',Exclamation!)
//			if GetFileOpenName('Archivo de Exportacion de Productos',direccion,variable,'txt') <= 0  then
//				Messagebox('Aviso','No ha podido especificar el archivo de exportacion de productos',StopSign!)
//				return
//			else
//				li_filnum = fileopen(direccion,linemode!,Write!,LockWrite!,Replace!)
//			end if
//		end if
//		if li_filnum > 0 then
//			for i = 1 to ll_cant_filas
//				variable = string(this.object.data[i,8]) + '~r~n'
//				if len(variable) <= 0 or isnull(variable) then
//					variable = string(this.object.data[i,6])
//				end if
//				filewrite(li_filnum,variable)
//			next
//			Messagebox('Confirmado','Se han exportado los '+string(i - 1 )+' productos para la recepcion!!')
//			fileclose(li_filnum)
//			openwithparm(w_files_transfer,1)
//		else
//			Messagebox('Aviso','Error al intentar abrir el archivo de exportacion!')
//			return
//		end if
//	end if
//end if
end event

type pb_file from uo_boton within w_modelo_listado
integer x = 1225
integer y = 20
integer width = 283
integer taborder = 40
string text = "&Archivo"
end type

event clicked;call super::clicked;string docname, named
integer value
value = GetFileOpenName("Select File", docname, named, "PSR", "Power report (*.psr) ,*.psr")
IF value = 1 THEN 
	cdw_listado.DataObject = trim(docname)
	cdw_listado.setredraw(true) 
end if
cdw_listado.Modify("datawindow.print.Preview=Yes")
cdw_listado.object.datawindow.print.preview.rulers = 'yes'

end event

type pb_salir from uo_boton within w_modelo_listado
integer x = 3237
integer y = 20
integer width = 283
integer taborder = 30
string text = "&Salir"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)
end event

type pb_ver from uo_boton within w_modelo_listado
integer x = 2949
integer y = 20
integer width = 283
string text = "&Ver"
end type

event clicked;call super::clicked;if string(cdw_listado.Describe("cf_paginas.tag")) = '?' or cdw_listado.Describe("cf_paginas.tag") = '' or isnull(cdw_listado.Describe("cf_paginas.tag")) or cdw_listado.Describe("cf_paginas.tag") = '*' then
	long cant_filas
	cant_filas = cdw_listado.retrieve()
	if cant_filas = 0 then		
		messageBox("Aviso...","No existen datos para recuperar...")
	end if
else
	window lwin_temp
	OpenWithParm(lwin_temp,cdw_listado, cdw_listado.Describe("cf_paginas.tag"))
end if

end event

type pb_mail from uo_boton within w_modelo_listado
integer x = 2665
integer y = 20
integer width = 283
integer taborder = 90
string text = "e-&mail"
end type

event clicked;call super::clicked;gdw_datawindow = cdw_listado
open(w_mail_send)

end event

type pb_print from uo_boton within w_modelo_listado
integer x = 2377
integer y = 20
integer width = 283
integer taborder = 20
string text = "&Imprimir"
end type

event clicked;call super::clicked;gdw_datawindow = cdw_listado
open(w_print_parametros)


end event

type pb_export from uo_boton within w_modelo_listado
integer x = 2089
integer y = 20
integer width = 283
integer taborder = 80
string text = "&Exportar"
end type

event clicked;call super::clicked;if cdw_listado.dataobject='dw_lista_marcaciones_ent_sal_reloj' then
	string ls_path, ls_file
	int li_rc
	li_rc = GetFileSaveName ( "Guardar Archivo",  ls_path, ls_file, "xls", "Todos los archivos (*.*),*.*" , "C:\My Documents", 32770)
	cdw_listado.SaveAsAscii(ls_path , '~t', '')
else
	cdw_listado.SaveAs ("",Excel!, TRUE)
end if




end event

type pb_orden from uo_boton within w_modelo_listado
integer x = 1801
integer y = 20
integer width = 283
integer taborder = 70
string text = "&Ordenar"
end type

event clicked;call super::clicked;gdw_datawindow = cdw_listado
open(w_ordenar)
cdw_listado.GroupCalc()
end event

type pb_filtrar from uo_boton within w_modelo_listado
integer x = 1513
integer y = 20
integer width = 283
integer taborder = 50
string text = "&Filtrar"
end type

event clicked;call super::clicked;gdw_datawindow = cdw_listado
open(w_filtrar)

end event

type cbx1 from checkbox within w_modelo_listado
boolean visible = false
integer x = 1198
integer y = 88
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detallado"
boolean righttoleft = true
end type

type cdw_listado from uo_datawindow within w_modelo_listado
string tag = "cdw_listado"
integer y = 112
integer width = 3493
integer height = 1804
integer taborder = 60
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;long ll_cant_filas,i
integer li_filnum
string variable,direccion,sintax,errors
string cod_report
integer filas,j,z
string cod_alternativo
ll_cant_filas = this.rowcount( )
if ll_cant_filas > 0 then
	if dwo.name = 't_35' then
		direccion = profilestring("pegasus.ini",'carpetas','CARGA','')
		if fileexists(direccion) then
			li_filnum = fileopen(direccion,LineMode!,Write!,LockWrite!,Replace!)
		else
			messagebox('Aviso','No se ha podido encontrar el archivo en donde guardar los productos!',Exclamation!)
			if GetFileOpenName('Archivo de Exportacion de Productos',direccion,variable,'txt') <= 0  then
				Messagebox('Aviso','No ha podido especificar el archivo de exportacion de productos',StopSign!)
				return
			else
				li_filnum = fileopen(direccion,linemode!,Write!,LockWrite!,Replace!)
			end if
		end if
		if li_filnum > 0 then
			/*di_codecs = create datastore
			sintax = sqlca.syntaxfromsql( "select codigo_alternativo from productos_codigos" ,"",errors)
			if len(errors) > 0 then
					Messagebox('Error','NO se ha podido construir la base para tomar todos los codigos de barra:~n'&
						+errors,StopSign!)
					Return
			end if
			di_codecs.Create(sintax,errors)
			if len(errors) > 0 then
			  MessageBox("Error", &
      		"No se ha podido tomar los codigos de barra: " + ERRORS,stopsign!)
				return
			end if
			setpointer(hourglass!)
			di_codecs.settransobject(sqlca)
			*/
			for i = 1 to ll_cant_filas
				string ll
				cod_report = string(this.object.data[i,6])
				//di_codecs.SetSQLSelect ("select codigo_alternativo from productos_codigos where codigo = "+cod_report)    
				//ll = di_codecs.GetSQLSelect ( )
				//Messagebox('ll','ll '+ll,StopSign!)
				//di_codecs.settransobject( sqlca)
				filewrite(li_filnum,cod_report)
				z ++
				//filas = di_codecs.retrieve(cod_report)
				filas = dw_codecs.retrieve(cod_report)
				//Messagebox('cod_report','cod_report '+cod_report,StopSign!)
				//Messagebox('filas','filas '+string(filas),StopSign!)
				if filas <=0 then continue
				for j = 1 to filas
					//cod_alternativo = string(di_codecs.object.data[j,1])
					cod_alternativo = string(dw_codecs.object.data[j,1])
					if cod_alternativo = cod_report then continue
					filewrite(li_filnum,cod_alternativo)
					z++
				next
			next
			Messagebox('Confirmado','Se han exportado los '+string(i - 1 )+' productos para la recepcion~n'&
					+'con:'+string(z)+ ' codigos de barras')
			fileclose(li_filnum)
			setpointer(arrow!)
			openwithparm(w_files_transfer,1)
		else
			Messagebox('Aviso','Error al intentar abrir el archivo de exportacion!')
			return
		end if
	end if
end if
//long ll_cant_filas,i
//integer li_filnum
//string variable,direccion
//
//ll_cant_filas = this.rowcount( )
//if ll_cant_filas > 0 then
//	if dwo.name = 't_35' then
//		direccion = profilestring("pegasus.ini",'carpetas','CARGA','')
//		if fileexists(direccion) then
//			li_filnum = fileopen(direccion,LineMode!,Write!,LockWrite!,Replace!)
//		else
//			messagebox('Aviso','No se podido encontrar el archivo en donde guardar los productos!',Exclamation!)
//			if GetFileOpenName('Archivo de Exportacion de Productos',direccion,variable,'txt') <= 0  then
//				Messagebox('Aviso','No ha podido especificar el archivo de exportacion de productos',StopSign!)
//				return
//			else
//				li_filnum = fileopen(direccion,linemode!,Write!,LockWrite!,Replace!)
//			end if
//		end if
//		if li_filnum > 0 then
//			for i = 1 to ll_cant_filas
//				variable = string(this.object.data[i,8]) + '~r~n'
//				if len(variable) <= 0 or isnull(variable) then
//					variable = string(this.object.data[i,6])
//				end if
//				filewrite(li_filnum,variable)
//			next
//			Messagebox('Confirmado','Se han exportado los '+string(i - 1 )+' productos para la recepcion!!')
//			fileclose(li_filnum)
//			openwithparm(w_files_transfer,1)
//		else
//			Messagebox('Aviso','Error al intentar abrir el archivo de exportacion!')
//			return
//		end if
//	end if
//end if
end event

event retrievestart;call super::retrievestart;//cdw_listado.settransobject(vg_server5)
end event


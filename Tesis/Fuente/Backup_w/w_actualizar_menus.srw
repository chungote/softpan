$PBExportHeader$w_actualizar_menus.srw
forward
global type w_actualizar_menus from window
end type
type st_2 from statictext within w_actualizar_menus
end type
type cbx_1 from checkbox within w_actualizar_menus
end type
type st_1 from statictext within w_actualizar_menus
end type
type cb_1 from commandbutton within w_actualizar_menus
end type
type dw_1 from datawindow within w_actualizar_menus
end type
end forward

global type w_actualizar_menus from window
integer width = 2583
integer height = 1236
boolean titlebar = true
string title = "Actualizar Menus"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
cbx_1 cbx_1
st_1 st_1
cb_1 cb_1
dw_1 dw_1
end type
global w_actualizar_menus w_actualizar_menus

type variables

end variables

forward prototypes
public function long add_menu (menu menu_actual, long ult_orden, integer nivel)
public subroutine add_menu (menu menu_actual, integer ult_orden)
end prototypes

public function long add_menu (menu menu_actual, long ult_orden, integer nivel);integer i,ult_orden_aux = 0,orden,ult_orden_recibido,orden_aux,j
long factor
string menu_encontrado,nombre_menu,nombre_id,id_text,ult_id

if not isvalid(menu_actual) then
	messagebox('Aviso','El menu enviado no es un objeto valido')
	return - 1 
end if
nivel ++
//messagebox('',nivel)
//messagebox('',factor)
ult_orden_recibido = ult_orden
for i = 1 to upperbound(menu_actual.item[])
	id_text = menu_actual.item[i].classname()
	if left(id_text,3) = 'm_-' then continue
	nombre_menu = ''
	nombre_id = ''
	orden = 0
	select menu,id,orden
	into :nombre_menu,:nombre_id,:orden
	from sys_menus
	where id = :id_text;
	if isnull(orden) or orden  = 0  then /*no se encontró el menu*/
		choose case ult_orden 
			case ult_orden_recibido /*es el primer item del menu recorrido*/
				/*buscar en todo el menu si existe algun numero para posicionarse*/
				orden_aux = 0
				for j = i to upperbound(menu_actual.item[])
					nombre_id = menu_actual.item[j].classname()
					select orden
					into :orden_aux
					from sys_menus
					where menu = :nombre_id;
					if orden_aux > 0  then exit /*encontro un item con algun orden*/
				next
				if (ult_orden_recibido - orden_aux) < 0 and orden_aux > 0  then /*hay espacio entre ambos para insertar uno nuevo*/
					dw_1.insertrow(0)
					dw_1.setitem(dw_1.rowcount(),1,menu_actual.item[i].text)
					dw_1.setitem(dw_1.rowcount(),2,menu_actual.item[i].classname())
					dw_1.setitem(dw_1.rowcount(),3,orden_aux - 1)
					ult_orden = orden_aux
					cb_1.text = 'Guardar'
				elseif orden_aux = 0 then /*no se encontró ningun item numerado*/
					dw_1.insertrow(0)
					dw_1.setitem( dw_1.rowcount(),1,menu_actual.item[i].text)
					dw_1.setitem( dw_1.rowcount(),2,menu_actual.item[i].classname())
					dw_1.setitem( dw_1.rowcount(),3,ult_orden_recibido + 10)
					ult_orden = ult_orden_recibido + 10
					cb_1.text = 'Guardar'
				elseif (ult_orden_recibido - orden_aux) > 0 then
					Messagebox('Aviso','No se puede insertar el menu:~n'+menu_actual.item[i].text+'~n'&
									+'No hay espacio para insertar entre dos menus especificados')
				end if
			case else /*ya fue encontrado un ult_orden*/
					dw_1.insertrow(0)	
					dw_1.setitem( dw_1.rowcount(),1,menu_actual.item[i].text)
					dw_1.setitem( dw_1.rowcount(),2,menu_actual.item[i].classname())
					dw_1.setitem( dw_1.rowcount(),3,ult_orden + 10)
					ult_orden = ult_orden + 10
					cb_1.text = 'Guardar'
		end choose
	else /*se encontró el menu*/
		ult_orden = orden
	end if
	/**/
	ult_orden_aux = 0
	if upperbound(menu_actual.item[i].item[]) > 0 then
		ult_id = menu_actual.item[i].classname()
		select orden
		into :ult_orden_aux
		from sys_menus
		where id = :ult_id;
		if ult_orden_aux  = 0 or isnull(ult_orden_aux ) then
			ult_orden_aux  = ult_orden
		end if
		ult_orden = add_menu(menu_actual.item[i],ult_orden_aux,nivel)
	end if
next
return ult_orden
end function

public subroutine add_menu (menu menu_actual, integer ult_orden);integer i,ult_orden_aux = 0,orden,ult_orden_recibido,orden_aux,j
long factor
string menu_encontrado,nombre_menu,nombre_id,id_text,ult_id

if not isvalid(menu_actual) then
	messagebox('Aviso','El menu enviado no es un objeto valido')
	return 
end if
//nivel ++
//messagebox('',nivel)
//messagebox('',factor)
ult_orden_recibido = ult_orden
for i = 1 to upperbound(menu_actual.item[])
	id_text = menu_actual.item[i].classname()
	if left(id_text,3) = 'm_-' then continue
	nombre_menu = ''
	nombre_id = ''
	orden = 0
	select menu,id,orden
	into :nombre_menu,:nombre_id,:orden
	from sys_menus
	where id = :id_text;
	if isnull(orden) or orden  = 0  then /*no se encontró el menu*/
		choose case ult_orden 
			case ult_orden_recibido /*es el primer item del menu recorrido*/
				/*buscar en todo el menu si existe algun numero para posicionarse*/
				orden_aux = 0
				for j = i to upperbound(menu_actual.item[])
					nombre_id = menu_actual.item[j].classname()
					select orden
					into :orden_aux
					from sys_menus
					where menu = :nombre_id;
					if orden_aux > 0  then exit /*encontro un item con algun orden*/
				next
				if (ult_orden_recibido - orden_aux) < 0 and orden_aux > 0  then /*hay espacio entre ambos para insertar uno nuevo*/
					dw_1.insertrow(0)
					dw_1.setitem(dw_1.rowcount(),1,menu_actual.item[i].text)
					dw_1.setitem(dw_1.rowcount(),2,menu_actual.item[i].classname())
					dw_1.setitem(dw_1.rowcount(),3,orden_aux - 1)
					ult_orden = orden_aux
					cb_1.text = 'Guardar'
				elseif orden_aux = 0 then /*no se encontró ningun item numerado*/
					dw_1.insertrow(0)
					dw_1.setitem( dw_1.rowcount(),1,menu_actual.item[i].text)
					dw_1.setitem( dw_1.rowcount(),2,menu_actual.item[i].classname())
					dw_1.setitem( dw_1.rowcount(),3,ult_orden_recibido + 1)
					ult_orden = ult_orden_recibido + 1
					cb_1.text = 'Guardar'
				elseif (ult_orden_recibido - orden_aux) > 0 then
					Messagebox('Aviso','No se puede insertar el menu:~n'+menu_actual.item[i].text+'~n'&
									+'No hay espacio para insertar entre dos menus especificados')
				end if
			case else /*ya fue encontrado un ult_orden*/
					dw_1.insertrow(0)	
					dw_1.setitem( dw_1.rowcount(),1,menu_actual.item[i].text)
					dw_1.setitem( dw_1.rowcount(),2,menu_actual.item[i].classname())
					dw_1.setitem( dw_1.rowcount(),3,ult_orden + 1)
					ult_orden = ult_orden + 1
					cb_1.text = 'Guardar'
		end choose
	else /*se encontró el menu*/
		ult_orden = orden
	end if
	/**/
	ult_orden_aux = 0
	if upperbound(menu_actual.item[i].item[]) > 0 then
		ult_id = menu_actual.item[i].classname()
		select orden
		into :ult_orden_aux
		from sys_menus
		where id = :ult_id;
		if ult_orden_aux  = 0 or isnull(ult_orden_aux ) then
			ult_orden_aux  = ult_orden
		end if
		add_menu(menu_actual.item[i],ult_orden_aux)
	end if
next

end subroutine

on w_actualizar_menus.create
this.st_2=create st_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.cbx_1,&
this.st_1,&
this.cb_1,&
this.dw_1}
end on

on w_actualizar_menus.destroy
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type st_2 from statictext within w_actualizar_menus
boolean visible = false
integer x = 123
integer y = 1072
integer width = 718
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Reconstruir todo el menu?"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_actualizar_menus
boolean visible = false
integer x = 37
integer y = 1068
integer width = 64
integer height = 72
integer taborder = 10
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;cb_1.text = '&Actualizar'
end event

type st_1 from statictext within w_actualizar_menus
boolean visible = false
integer x = 32
integer y = 20
integer width = 672
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lista de Menus Actualizables:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_actualizar_menus
integer x = 2117
integer y = 1064
integer width = 302
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Actualizar"
end type

event clicked;menu menu_enviado
if this.text = 'Guardar' then // puedo intentar guardar
	dw_1.accepttext( )
//	messagebox('','intentar guardar')
	st_2.text = 'Guardando Menu..'
	if dw_1.update( true,false) > 0 then
		dw_1.resetupdate()
		commit using sqlca;
		Messagebox('Aviso','Menus Actualizados con exito')
		dw_1.reset()
		post close(parent)
	else
		Rollback using sqlca;
		Messagebox('Aviso','Error al intentar actualizar los menus')
	end if
else
	choose case cbx_1.checked
	case true
		if messagebox('Confirmar','Al reconstruir todo el menu se eliminarán todos los menus actuales,~n' &
						+'con todos los permisos que ha asignado hasta el momento.~n' &
						+'Pudiendo asi perder toda la configuracion de sus menus' &
						+'~nEl proceso tardará unos minutos dependiendo de la velocidad de su máquina'&
						+'~n~nEstá seguro que desea continuar?', Question!,yesno!,2) = 1 then
			dw_1.reset( )
			st_2.text = 'Eliminando los permisos del menu anterior...'
			execute immediate 'delete from sys_permisos' using sqlca;
			if sqlca.sqldbcode <> - 1 then
				st_2.text = 'Eliminando todos los menus actuales...'
				execute immediate 'delete from sys_menus' using sqlca;
			else
				st_2.text = 'Reconstruir todo el menu?'
				rollback using sqlca;
				Messagebox('Aviso','Ha ocurrido un Error!~n~n'+sqlca.sqlerrtext)
				return
			end if 
			if sqlca.sqldbcode <> -1 then
				commit using sqlca;
				st_2.text = 'Construyendo los menus actuales...'
				add_menu(w_menuppal.menuid,0,0)
				st_2.text = 'Reconstruir todo el menu?'
			else
				st_2.text = 'Reconstruir todo el menu?'
				rollback using sqlca;
				Messagebox('Aviso','Ha ocurrido un Error!~n'+sqlca.sqlerrtext)
			end if
		else
			return
		end if
	case false
			 add_menu( w_menuppal.menuid,0)
	end choose
	if cb_1.text = '&Actualizar' then
		Messagebox('Aviso','No se encontraron menus actualizables')
	else
		st_1.visible = true
	end if
end if
end event

type dw_1 from datawindow within w_actualizar_menus
event press_key pbm_dwnkey
integer x = 18
integer y = 96
integer width = 2510
integer height = 952
integer taborder = 30
string title = "none"
string dataobject = "dw_actualizar_menu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event press_key;
if key = keyf12! then
	dw_1.deleterow(dw_1.getrow())
end if
end event

event constructor;this.settransobject( sqlca)
//this.retrieve()
end event


$PBExportHeader$w_error_db.srw
forward
global type w_error_db from window
end type
type em_1 from editmask within w_error_db
end type
type dw_det from uo_datawindow within w_error_db
end type
type pb_2 from uo_boton within w_error_db
end type
type pb_1 from uo_boton_cancel within w_error_db
end type
type dw_err from uo_datawindow within w_error_db
end type
end forward

global type w_error_db from window
integer width = 2688
integer height = 532
boolean titlebar = true
string title = "DB Message"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
em_1 em_1
dw_det dw_det
pb_2 pb_2
pb_1 pb_1
dw_err dw_err
end type
global w_error_db w_error_db

on w_error_db.create
this.em_1=create em_1
this.dw_det=create dw_det
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_err=create dw_err
this.Control[]={this.em_1,&
this.dw_det,&
this.pb_2,&
this.pb_1,&
this.dw_err}
end on

on w_error_db.destroy
destroy(this.em_1)
destroy(this.dw_det)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_err)
end on

event open;string ls_msn, ls_duplicado
dw_err.insertrow(0)
dw_det.insertrow(0)
ls_msn = message.stringparm
dw_det.setitem(1,1, ls_msn)

//*Error al insertar el en Bloqueo_reservas ---*SQLSTATE = 23000
//[MySQL][ODBC 3.51 Driver][mysqld-5.0.32-Debian_7etch1-log]Duplicate entry 'Producto sin stock - 1317R' for key 1 Producto 1317R

if pos(ls_msn, 'SQLSTATE = 23000') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, 'SQLSTATE = 23000'), 16, '' )
if pos(ls_msn, 'SQLSTATE = S1000') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, 'SQLSTATE = S1000'), 16, '' )
if pos(ls_msn, 'Duplicate entry') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, 'Duplicate entry'), 15, '' )
if pos(ls_msn, 'No changes made to database.') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, 'No changes made to database.'), 28, '' )
if pos(ls_msn, 'for key 1') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, 'for key 1'), 10, '' )
if pos(ls_msn, "doesn't have a default value") > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, "doesn't have a default value"), 29, ' debe contener obligatoriamente un valor...' )
if pos(ls_msn, "Field '") > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, "Field '"), 7, 'Campo ' )
if pos(ls_msn, "for key 'PRIMARY'") > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, "for key 'PRIMARY'"), 17, '' )
if pos(ls_msn, "Error al") > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, "Error al"), 8, 'No se pudo' )

/* Comentado por Fabiola Mujica
if pos(ls_msn, '[unixODBC][MySQL][ODBC 3.51&
Driver][mysqld-5.0.45-Debian_1ubuntu3-log]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[unixODBC][MySQL][ODBC 3.51&
Driver][mysqld-5.0.45-Debian_1ubuntu3-log]'), 69, '' )
if pos(ls_msn, '[unixODBC][MySQL][ODBC 3.51Driver][mysqld-5.0.45-Debian_1ubuntu3-log]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[unixODBC][MySQL][ODBC 3.51Driver][mysqld-5.0.45-Debian_1ubuntu3-log]'), 69, '' )
if pos(ls_msn, '[unixODBC][MySQL][ODBC 3.51 Driver][mysqld-5.0.45-Debian_1ubuntu3-log]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[unixODBC][MySQL][ODBC 3.51 Driver][mysqld-5.0.45-Debian_1ubuntu3-log]'), 70, '' )
if pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.45-Debian_1ubuntu3-log]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.45-Debian_1ubuntu3-log]'), 60, '' )
if pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.45-community-nt-log]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.45-community-nt-log]'), 57, '' )
if pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.45-community-nt]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.45-community-nt]'), 53, '' )
if pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.41-community-nt]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.41-community-nt]'), 53, '' )
if pos(ls_msn, '[MySQL][ODBC 3.51 Driver][5.0.32-Debian_7etch1-log]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[MySQL][ODBC 3.51 Driver][5.0.32-Debian_7etch1-log]'), 52, '' )
if pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.32-Debian_7etch1-log]') > 0 then ls_msn = Replace ( ls_msn, pos(ls_msn, '[MySQL][ODBC 3.51 Driver][mysqld-5.0.32-Debian_7etch1-log]'), 60, '' )
*/
/**** Agregado por Fabiola Mujica 2009-01-05 ****/

long ll_conta_ini, ll_conta_fin, ll_cant
ll_conta_ini = Pos(ls_msn, "[")

ll_conta_fin = 2

if ll_conta_ini > 0 then
	Do 
		ll_conta_fin = Pos(ls_msn, "]")
		
		if ll_conta_fin > 0 then
			ll_cant = ll_conta_fin
			ls_msn = Replace ( ls_msn, ll_conta_fin, 1, '%' )
			ll_conta_fin = 2
		else
			ll_conta_fin = 0
		end if
	//Loop Until ll_conta_fin = 2
	LOOP WHILE ll_conta_fin = 2
	ls_msn = Replace ( ls_msn, ll_conta_ini, (ll_cant - ll_conta_ini)+1, '' )
end if

/**** Fin ****/


//*Error al insertar el en Bloqueo_reservas ---*SQLSTATE = 23000
//[unixODBC][MySQL][ODBC 3.51
//Driver][mysqld-5.0.45-Debian_1ubuntu3-log]Duplicate entry 'Producto
//sin stock - 145920' for key 1 Producto 145920

ls_duplicado = 'no'
if pos(lower(ls_msn), 'Duplicate entry') > 0 then ls_duplicado = 'si'
if pos(lower(ls_msn), 'producto ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'no se pu') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'lote ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'compuesto ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'diferente a ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'negativo ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'a la ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'al insertar ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'no puede ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'contabilizada ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'modificar ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'ya se ') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'compra ya') > 0 then ls_duplicado = 'no' 
if pos(lower(ls_msn), 'venta ya') > 0 then ls_duplicado = 'no' 
if ls_duplicado = 'si' then ls_msn = ls_msn + '~r~r' + 'No se puede insertar una clave duplicada...'
dw_err.setitem(1,1, ls_msn)
//dw_err.setfocus()
em_1.text = ls_msn
end event

type em_1 from editmask within w_error_db
integer x = 91
integer y = 60
integer width = 2491
integer height = 196
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean border = false
maskdatatype maskdatatype = stringmask!
end type

type dw_det from uo_datawindow within w_error_db
boolean visible = false
integer x = 46
integer y = 420
integer width = 2578
integer height = 744
integer taborder = 30
string dataobject = "dw_error_db"
boolean vscrollbar = true
boolean livescroll = false
end type

event itemchanged;//
end event

event constructor;//

end event

type pb_2 from uo_boton within w_error_db
integer x = 1312
integer y = 288
integer taborder = 20
integer textsize = -8
string text = "&Detalles"
end type

event clicked;call super::clicked;dw_det.visible = true
parent.Height = 1300

end event

type pb_1 from uo_boton_cancel within w_error_db
integer x = 878
integer y = 288
string text = "&Aceptar"
boolean default = true
end type

type dw_err from uo_datawindow within w_error_db
boolean visible = false
integer x = 46
integer y = 32
integer width = 2578
integer height = 76
integer taborder = 0
string dataobject = "dw_error_db"
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;//
end event


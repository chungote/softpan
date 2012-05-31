$PBExportHeader$w_inicio.srw
$PBExportComments$Ventana de Inicio de Sesión
forward
global type w_inicio from window
end type
type p_2 from picture within w_inicio
end type
type ole_skin from olecustomcontrol within w_inicio
end type
type cbx_1 from checkbox within w_inicio
end type
type p_1 from picture within w_inicio
end type
type st_msg from statictext within w_inicio
end type
type cb_cancel from commandbutton within w_inicio
end type
type st_3 from statictext within w_inicio
end type
type st_2 from statictext within w_inicio
end type
type sle_pass from singlelineedit within w_inicio
end type
type sle_usuario from singlelineedit within w_inicio
end type
type cb_ok from commandbutton within w_inicio
end type
type gb_2 from groupbox within w_inicio
end type
type st_1 from statictext within w_inicio
end type
end forward

global type w_inicio from window
integer width = 2007
integer height = 1432
boolean titlebar = true
string title = "SOFTPAN- Inicio de Sesión"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
event ue_postopen ( )
p_2 p_2
ole_skin ole_skin
cbx_1 cbx_1
p_1 p_1
st_msg st_msg
cb_cancel cb_cancel
st_3 st_3
st_2 st_2
sle_pass sle_pass
sle_usuario sle_usuario
cb_ok cb_ok
gb_2 gb_2
st_1 st_1
end type
global w_inicio w_inicio

type variables
boolean ib_control = false
end variables

forward prototypes
public function integer wf_center ()
public function integer wf_desconectar ()
public function integer wf_conectar (string a_usuario, string a_contrasena)
end prototypes

event ue_postopen();sle_usuario.setfocus()

end event

public function integer wf_center ();//*-----------------------------------------------------------------*/
//*    f_Center:  Centra un ventana
//*-----------------------------------------------------------------*/
int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1
environment	lenv_obj

If IsNull ( this ) Or Not IsValid ( this ) Then Return -1
If GetEnvironment ( lenv_obj ) = -1 Then Return -1
li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1

If li_screenwidth > this.Width Then
	li_x = ( li_screenwidth / 2 ) - ( this.Width / 2 )
End If
If li_screenheight > this.Height Then
	li_y = ( li_screenheight / 2 ) - ( this.Height / 2 )
End If

/*  Aqui centra la ventana*/
li_rc = this.Move ( li_x, li_y )
If li_rc <> 1 Then Return -1

Return 1

end function

public function integer wf_desconectar ();If sqlca.dbhandle() > 0 then
	Disconnect using sqlca;
	g_sqlerrtext = sqlca.sqlerrtext
	if sqlca.sqlcode <> 0 then
		Rollback using sqlca;
		MessageBox("Error de Desconexión !!",g_sqlerrtext)
		return 0
	end if
end if
return 1
end function

public function integer wf_conectar (string a_usuario, string a_contrasena);st_msg.text 		= upper("Iniciando...")
setpointer(hourglass!)
String  ls_userid, ls_password, ls_parm, ls_database, a_pass, ls_pass
integer  intentos
ls_userid 			= a_usuario
ls_password 		= a_contrasena
sqlca.DBMS       	= ProfileString ("fileini.ini", "database", "dbms","ODBC")
sqlca.DataBase   	= ProfileString ("fileini.ini", "database", "database","")
sqlca.UserId 		= ls_userid
sqlca.DBPass 		= ls_password
sqlca.LogID 		= ls_userid
sqlca.LogPass 		= ls_password
sqlca.servername 	= ProfileString ("fileini.ini", "database", "servername","")
ls_database			= ProfileString ("fileini.ini", "database", "database","")
ls_parm 				= "Connectstring='DSN=" + ls_database + ";UID=" + sqlca.UserId + ";PWD=" + sqlca.LogPass + ";',CommitOnDisconnect='No',DisableBind=1,"+&
								"ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"
sqlca.dbparm     	= ls_parm
CONNECT USING sqlca;

g_sqldbcode = sqlca.sqldbcode
g_sqlerrtext = sqlca.sqlerrtext
IF sqlca.SQLCode = -1 THEN
	DISCONNECT using sqlca;
	st_msg.textcolor 	= 0
	st_msg.text 		= upper("Error en la conexion..")
	Beep (1)
	choose case g_Sqldbcode
		case -103
			Messagebox('Error de Conexión..','El usuario y contrasena ingresados son invalidos!!',information!)
		case else
			MessageBox("Error de Conexión..","No se pudo conectar. Favor consulte al soporte informático." + &
		               "~n~r~n~rDetalle: " + f_error_db(g_sqldbcode, g_sqlerrtext),StopSign!)
	End Choose
	sle_usuario.text = ''
	sle_pass.text	=	''
	sle_usuario.setfocus()
	return 0
ELSEIF sqlca.SQLCode = 100 THEN
	MessageBox("Error de Conexión !!","No se encuentra la Base de Datos..!!~rConsulte al soporte informático.",StopSign!)
	return 0
ELSEIF sqlca.SQLCode = 0 THEN
	SetProfileString("fileini.ini","DataBase","UserId",sle_usuario.text)
END IF
Return 1
end function

on w_inicio.create
this.p_2=create p_2
this.ole_skin=create ole_skin
this.cbx_1=create cbx_1
this.p_1=create p_1
this.st_msg=create st_msg
this.cb_cancel=create cb_cancel
this.st_3=create st_3
this.st_2=create st_2
this.sle_pass=create sle_pass
this.sle_usuario=create sle_usuario
this.cb_ok=create cb_ok
this.gb_2=create gb_2
this.st_1=create st_1
this.Control[]={this.p_2,&
this.ole_skin,&
this.cbx_1,&
this.p_1,&
this.st_msg,&
this.cb_cancel,&
this.st_3,&
this.st_2,&
this.sle_pass,&
this.sle_usuario,&
this.cb_ok,&
this.gb_2,&
this.st_1}
end on

on w_inicio.destroy
destroy(this.p_2)
destroy(this.ole_skin)
destroy(this.cbx_1)
destroy(this.p_1)
destroy(this.st_msg)
destroy(this.cb_cancel)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_pass)
destroy(this.sle_usuario)
destroy(this.cb_ok)
destroy(this.gb_2)
destroy(this.st_1)
end on

event open;
//run( 'regsvr32 "C:\PROYECTO DE  TESIS\SOFTPAN\FUENTE\actskin4.ocx"')
this.ole_skin.object.connecttoobject( "..\actskin4.ocx")
Long hWnd
hWnd=Handle(this)
this.OLE_Skin.object.LoadSkin("winaqua.skn")
this.OLE_Skin.object.ApplySkin (hWnd)
wf_center( )
this.postevent('ue_postopen')
end event

event close;setnull(g_bandera)
end event

type p_2 from picture within w_inicio
integer x = 178
integer y = 56
integer width = 1591
integer height = 380
string picturename = "C:\PROYECTO DE  TESIS\SOFTPAN\Imagenes\logo2.bmp"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ole_skin from olecustomcontrol within w_inicio
integer x = 818
integer y = 472
integer width = 146
integer height = 128
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_inicio.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cbx_1 from checkbox within w_inicio
integer x = 242
integer y = 920
integer width = 411
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
string text = "Por defecto"
boolean lefttext = true
end type

event clicked;if this.checked=true then
	parent.sle_usuario.text="ADMIN"
	parent.sle_pass.text="ADMIN"
   sle_usuario.setfocus( )
else
	parent.sle_usuario.text=""
	parent.sle_pass.text=""
	 sle_usuario.setfocus( )
end if
end event

type p_1 from picture within w_inicio
integer x = 229
integer y = 584
integer width = 242
integer height = 180
string picturename = "..\Imagenes\USER5.jpg"
boolean focusrectangle = false
end type

type st_msg from statictext within w_inicio
integer x = 187
integer y = 1120
integer width = 1582
integer height = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 8388608
long backcolor = 16777215
string text = "LISTO.."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_inicio
integer x = 1056
integer y = 908
integer width = 320
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;halt close
end event

type st_3 from statictext within w_inicio
integer x = 581
integer y = 732
integer width = 334
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 16777215
string text = "Contraseña:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_inicio
integer x = 581
integer y = 600
integer width = 320
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 16777215
string text = "Usuario:"
boolean focusrectangle = false
end type

type sle_pass from singlelineedit within w_inicio
integer x = 919
integer y = 720
integer width = 663
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean password = true
textcase textcase = upper!
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1,len(this.text))
end event

type sle_usuario from singlelineedit within w_inicio
integer x = 919
integer y = 592
integer width = 663
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1,len(this.text))
end event

type cb_ok from commandbutton within w_inicio
integer x = 731
integer y = 908
integer width = 320
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Aceptar"
boolean default = true
end type

event clicked;long result, ll_estado,ll_tipo_usuario
string v_userid, v_pass, ls_cambiar_clave
If not wf_desconectar()= 1 then halt
v_userid = upper(sle_usuario.text)
v_pass 	= upper(sle_pass.text)
If trim(v_userid) = "" then
	Beep(1)
	st_msg.text = upper("Falta Usuario..")
	sle_usuario.setfocus()
	return 0
end if

if trim(v_pass) = "" then
	Beep(1)
	st_msg.text = upper("Falta Contraseña..")
	sle_pass.setfocus()
	return 0
end if

If not wf_conectar("dba", "sql") = 1 then return


select/* nombres,*/ estado,cod_usuario
into /*:g_nombre_usuario,*/ :ll_estado,:g_cod_usuario
from USUARIOS
where usuario = :v_userid
and contrasenia=:v_pass;


g_sqlerrtext = sqlca.sqlerrtext
if sqlca.sqlcode < 0 then
	messagebox('Atencion!!','SQL Error: '+g_Sqlerrtext)
	cbx_1.checked=false
	return
end if
If ll_estado = 0 then
	messagebox('Atencion!!','El usuario se encuentra DESHABILITADO para el ingreso al sistema.',exclamation!)
	cbx_1.checked=false
	return
end if
g_userid	=	v_userid

SetProfileString("fileini.ini","DataBase","UserId",sle_usuario.text)
Open (w_principal)
close(w_inicio)
sqlca.sp_anular_pedido_cliente_vencidos( )
end event

type gb_2 from groupbox within w_inicio
integer x = 713
integer y = 852
integer width = 681
integer height = 176
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
end type

type st_1 from statictext within w_inicio
integer x = 187
integer y = 460
integer width = 1582
integer height = 624
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Trebuchet MS"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_inicio.bin 3076 
2000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000d7453c8001c9c44b00000003000002400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000030944d16c4389d0f485a02a98b39e5a5900000000d7453c8001c9c44bd7453c8001c9c44b000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000021c000000000000000100000002000000030000000400000005000000060000000700000008fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000001000000020000000a0000001a005f006d007300620072007400750041006800740072006f000400000000000000240000006d00000062005f007400730044007200730065007200630070006900690074006e006f000400000000000000240000006d00000062005f0074007300410072007000700069006c0061006300690074006e006f0004000000000000000e0000006d0000006e005f007500480000006500000008000000040000000000000018005f006d00610042006b0063006f0043006f006c00000072000000070000000318ffffff6d00000046005f0072006f00430065006c006f0072006f00070000000300000000000000001a0000006d00000050005f006e0061006c0065006f0043006f006c00000072000000070000000322ece9d86d00000050005f006e0061006c00650065005400740078006f0043006f006c00000072000000070000000300000000000000001e005f006d00410062007000700079006c006f0043006f006c0073007200060000000200000000000000000024005f006d005300620069006b0043006e0069006c006e00650041007400650072000000610000000600000002000200010000000000030000000000000000000000010000000200000002000000160000006d00000062005f00740073004e0072006d006100000065000000040000000000000014005f006d00730062007200740061005400000067000000040000000000000000003900300032003a0020003300730000005f007700620061005f006d0069006c0074007300640061005f006f006e006100650063007400730072006f0073002e0077007200280020002900780028002000320032003300330029003800310020002f0031003400300032002f0030003000200039003500310031003a003a00330031003500000020007700730062005f00720061006100720068005f00720065006100720069006d006e006500610074002e00730072007300200077007800280020002900390028003900350029003000310020002f0033003800300032002f0030003000200038003100310031003a003a00360039003300000020007700730062005f0073007500610063002e00720072007300200077007800280020002900390028003400330029003800310020002f0032003400300032002f0030003000200039003800310031003a003a00350033003000000020007700730062005f0073007500610063005f0072006e006100650063007400730072006f0073002e00770072002800200029007800280020003400370039003500200029003900320031002f002f0030003000320038003000320020003a0031003900300032003a00200034000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_inicio.bin 3076 
End of PowerBuilder Binary Data Section : No Source Expected After This Point

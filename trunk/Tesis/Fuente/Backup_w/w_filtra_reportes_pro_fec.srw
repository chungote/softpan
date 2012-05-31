$PBExportHeader$w_filtra_reportes_pro_fec.srw
forward
global type w_filtra_reportes_pro_fec from w_filtra_reportes_productos
end type
type st_3 from statictext within w_filtra_reportes_pro_fec
end type
type st_4 from statictext within w_filtra_reportes_pro_fec
end type
type v_fech_fin from editmask within w_filtra_reportes_pro_fec
end type
type v_fech_ini from editmask within w_filtra_reportes_pro_fec
end type
end forward

global type w_filtra_reportes_pro_fec from w_filtra_reportes_productos
int Width=2601
int Height=1660
st_3 st_3
st_4 st_4
v_fech_fin v_fech_fin
v_fech_ini v_fech_ini
end type
global w_filtra_reportes_pro_fec w_filtra_reportes_pro_fec

on w_filtra_reportes_pro_fec.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_4=create st_4
this.v_fech_fin=create v_fech_fin
this.v_fech_ini=create v_fech_ini
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.v_fech_fin
this.Control[iCurrent+4]=this.v_fech_ini
end on

on w_filtra_reportes_pro_fec.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_4)
destroy(this.v_fech_fin)
destroy(this.v_fech_ini)
end on

event open;call super::open;if isdate(string(vi_dw_lista.vi_argumentos[29])) then v_fech_ini.text = string(vi_dw_lista.vi_argumentos[29])
if isdate(string(vi_dw_lista.vi_argumentos[30])) then v_fech_fin.text = string(vi_dw_lista.vi_argumentos[30])

end event

event close;call super::close;vi_dw_lista.vi_argumentos[29] = v_fech_ini.text 
vi_dw_lista.vi_argumentos[30] = v_fech_fin.text 
end event

type pb_close from w_filtra_reportes_productos`pb_close within w_filtra_reportes_pro_fec
int X=1280
int Y=1380
int TabOrder=40
end type

type pb_ok from w_filtra_reportes_productos`pb_ok within w_filtra_reportes_pro_fec
int X=887
int Y=1380
int TabOrder=30
end type

event pb_ok::clicked;dw_filtro.accepttext() 
DATE A,B
A = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
	setnull(A)
end if	
B = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
	setnull(B)
end if	

vg_param_1a = dw_filtro.Getitemstring(1,1)
vg_param_1b = dw_filtro.Getitemstring(1,3)
IF ISNULL(vg_param_1a) THEN
	vg_param_1a =''
END IF
IF ISNULL(vg_param_1b) THEN
	vg_param_1b=''
END IF

vg_param_2a = dw_filtro.Getitemnumber(1,5)
vg_param_2b = dw_filtro.Getitemnumber(1,7)
IF ISNULL(vg_param_2a) THEN
	vg_param_2a =0
END IF
IF ISNULL(vg_param_2b) THEN
	vg_param_2b=0
END IF

vg_param_3a = dw_filtro.Getitemnumber(1,9)
vg_param_3b = dw_filtro.Getitemnumber(1,11)
IF ISNULL(vg_param_3a) THEN
	vg_param_3a =0
END IF
IF ISNULL(vg_param_3b) THEN
	vg_param_3b=0
END IF

vg_param_4a = dw_filtro.Getitemnumber(1,13)
vg_param_4b = dw_filtro.Getitemnumber(1,15)
IF ISNULL(vg_param_4a) THEN
	vg_param_4a =0
END IF
IF ISNULL(vg_param_4b) THEN
	vg_param_4b=0
END IF

vg_param_5a = dw_filtro.Getitemnumber(1,17)
vg_param_5b = dw_filtro.Getitemnumber(1,19)
IF ISNULL(vg_param_5a) THEN
	vg_param_5a =0
END IF
IF ISNULL(vg_param_5b) THEN
	vg_param_5b=0
END IF

vg_param_6a = dw_filtro.Getitemnumber(1,21)
vg_param_6b = dw_filtro.Getitemnumber(1,23)
IF ISNULL(vg_param_6a) THEN
	vg_param_6a =0
END IF
IF ISNULL(vg_param_6b) THEN
	vg_param_6b=0
END IF

vg_param_7a = dw_filtro.Getitemnumber(1,25)
vg_param_7b = dw_filtro.Getitemnumber(1,27)
IF ISNULL(vg_param_7a) THEN
	vg_param_7a =0
END IF
IF ISNULL(vg_param_7b) THEN
	vg_param_7b=0
END IF

long cant_filas
cant_filas = vi_dw_lista.retrieve(vg_param_1a,vg_param_1b,vg_param_2a,vg_param_2b,vg_param_3a,vg_param_3b,vg_param_4a,vg_param_4b,vg_param_5a,vg_param_5b,vg_param_6a,vg_param_6b,vg_param_7a,vg_param_7b,A,B)
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para el rango definido...")
end if

	if vg_param_1a <> '' then
		vi_dw_lista.Object.filtro1a.Text = filtro_producto(vg_param_1a)
	ELSE
		vi_dw_lista.Object.filtro1a.Text = "Todos "
	END IF
	if vg_param_1b <> '' then
		vi_dw_lista.Object.filtro1b.Text = filtro_producto(vg_param_1b)
	ELSE
		vi_dw_lista.Object.filtro1b.Text = "Todos "
	END IF
	if vg_param_2a <> 0 then
		vi_dw_lista.Object.filtro2a.Text = filtro_seccion(vg_param_2a)
	ELSE
		vi_dw_lista.Object.filtro2a.Text = "Todos "
	END IF
	if vg_param_2b <> 0 then
		vi_dw_lista.Object.filtro2b.Text = filtro_seccion(vg_param_2b)
	ELSE
		vi_dw_lista.Object.filtro2b.Text = "Todos "
	END IF

	if vg_param_3a <> 0 then
		vi_dw_lista.Object.filtro3a.Text = filtro_sub_seccion(vg_param_3a)
	ELSE
		vi_dw_lista.Object.filtro3a.Text = "Todos "
	END IF
	if vg_param_3b <> 0 then
		vi_dw_lista.Object.filtro3b.Text = filtro_sub_seccion(vg_param_3b)
	ELSE
		vi_dw_lista.Object.filtro3b.Text = "Todos "
	END IF

	if vg_param_4a <> 0 then
		vi_dw_lista.Object.filtro4a.Text = filtro_grupo(vg_param_4a)
	ELSE
		vi_dw_lista.Object.filtro4a.Text = "Todos "
	END IF
	if vg_param_4b <> 0 then
		vi_dw_lista.Object.filtro4b.Text = filtro_grupo(vg_param_4b)
	ELSE
		vi_dw_lista.Object.filtro4b.Text = "Todos "
	END IF

	if vg_param_5a <> 0 then
		vi_dw_lista.Object.filtro5a.Text = filtro_categoria(vg_param_5a)
	ELSE
		vi_dw_lista.Object.filtro5a.Text = "Todos "
	END IF
	if vg_param_5b <> 0 then
		vi_dw_lista.Object.filtro5b.Text = filtro_categoria(vg_param_5b)
	ELSE
		vi_dw_lista.Object.filtro5b.Text = "Todos "
	END IF

	if vg_param_6a <> 0 then
		vi_dw_lista.Object.filtro6a.Text = filtro_sub_cate(vg_param_6a)
	ELSE
		vi_dw_lista.Object.filtro6a.Text = "Todos "
	END IF
	if vg_param_6b <> 0 then
		vi_dw_lista.Object.filtro6b.Text = filtro_sub_cate(vg_param_6b)
	ELSE
		vi_dw_lista.Object.filtro6b.Text = "Todos "
	END IF

	if vg_param_7a <> 0 then
		vi_dw_lista.Object.filtro7a.Text = filtro_marcas(vg_param_7a)
	ELSE
		vi_dw_lista.Object.filtro7a.Text = "Todos "
	END IF
	if vg_param_7b <> 0 then
		vi_dw_lista.Object.filtro7b.Text = filtro_marcas(vg_param_7b)
	ELSE
		vi_dw_lista.Object.filtro7b.Text = "Todos "
	END IF
	vi_dw_lista.Object.filtro8a.Text = trim(v_Fech_ini.text)
	vi_dw_lista.Object.filtro8b.Text = trim(v_Fech_fin.text)

end event

type gb_borde from w_filtra_reportes_productos`gb_borde within w_filtra_reportes_pro_fec
int X=855
int Y=1308
int TabOrder=0
end type

type dw_busca from w_filtra_reportes_productos`dw_busca within w_filtra_reportes_pro_fec
int TabOrder=50
end type

type dw_filtro from w_filtra_reportes_productos`dw_filtro within w_filtra_reportes_pro_fec
int TabOrder=60
boolean BringToTop=true
end type

type st_3 from statictext within w_filtra_reportes_pro_fec
int X=448
int Y=1208
int Width=389
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha Inicial:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_filtra_reportes_pro_fec
int X=1248
int Y=1208
int Width=389
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha Final:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type v_fech_fin from editmask within w_filtra_reportes_pro_fec
int X=1618
int Y=1208
int Width=379
int Height=80
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
double Increment=1
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type v_fech_ini from editmask within w_filtra_reportes_pro_fec
int X=814
int Y=1208
int Width=379
int Height=80
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
double Increment=1
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


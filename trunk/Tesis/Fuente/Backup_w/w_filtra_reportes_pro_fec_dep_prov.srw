$PBExportHeader$w_filtra_reportes_pro_fec_dep_prov.srw
forward
global type w_filtra_reportes_pro_fec_dep_prov from w_filtra_reportes_pro_fec_dep_nro
end type
type cdw_param_2 from datawindow within w_filtra_reportes_pro_fec_dep_prov
end type
type gb_2 from groupbox within w_filtra_reportes_pro_fec_dep_prov
end type
type rb_6 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
end type
type rb_7 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
end type
type rb_8 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
end type
type rb_9 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
end type
end forward

global type w_filtra_reportes_pro_fec_dep_prov from w_filtra_reportes_pro_fec_dep_nro
int Width=2501
int Height=2132
cdw_param_2 cdw_param_2
gb_2 gb_2
rb_6 rb_6
rb_7 rb_7
rb_8 rb_8
rb_9 rb_9
end type
global w_filtra_reportes_pro_fec_dep_prov w_filtra_reportes_pro_fec_dep_prov

on w_filtra_reportes_pro_fec_dep_prov.create
int iCurrent
call super::create
this.cdw_param_2=create cdw_param_2
this.gb_2=create gb_2
this.rb_6=create rb_6
this.rb_7=create rb_7
this.rb_8=create rb_8
this.rb_9=create rb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_2
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.rb_6
this.Control[iCurrent+4]=this.rb_7
this.Control[iCurrent+5]=this.rb_8
this.Control[iCurrent+6]=this.rb_9
end on

on w_filtra_reportes_pro_fec_dep_prov.destroy
call super::destroy
destroy(this.cdw_param_2)
destroy(this.gb_2)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.rb_8)
destroy(this.rb_9)
end on

event open;call super::open;cdw_param_2.SetTransObject(sqlca)
cdw_param_2.reset()
cdw_param_2.insertrow(0)

end event

type pb_close from w_filtra_reportes_pro_fec_dep_nro`pb_close within w_filtra_reportes_pro_fec_dep_prov
int Y=1740
end type

type pb_ok from w_filtra_reportes_pro_fec_dep_nro`pb_ok within w_filtra_reportes_pro_fec_dep_prov
int Y=1740
end type

event pb_ok::clicked;dw_filtro.accepttext()

   Long A,B
   Date C,D
   Long E, ll_tipo_producto
	A = cdw_param_1.Getitemnumber(1,1)
	IF ISNULL(A) THEN
		A=0
	END IF	
	B = cdw_param_2.Getitemnumber(1,1)
	IF ISNULL(B) THEN
		B=0
	END IF	
	
	C = Date(v_Fech_ini.text)
	If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
		setnull(C)
	end if		
	D = Date(v_Fech_fin.text)	
	If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
		setnull(D)
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

if rb_6.checked = true then
	 ll_tipo_producto = 3
end if

if rb_7.checked = true then
	 ll_tipo_producto = 0
end if

if rb_8.checked = true then
	 ll_tipo_producto = 1
end if

if rb_9.checked = true then
	 ll_tipo_producto = 2
end if

long cant_filas
cant_filas = vi_dw_lista.retrieve(vg_param_1a,vg_param_1b,vg_param_2a,vg_param_2b,vg_param_3a,vg_param_3b,vg_param_4a,vg_param_4b,vg_param_5a,vg_param_5b,vg_param_6a,vg_param_6b,vg_param_7a,vg_param_7b,A,B,C,D, ll_tipo_producto)
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

	if A <> 0 then
		vi_dw_lista.Object.filtro1.Text = filtro_depositos(A)
	ELSE
		vi_dw_lista.Object.filtro1.Text = "Todos "
	END IF
	if B <> 0 then
		vi_dw_lista.Object.filtro2.Text = filtro_proveedores(B)
	ELSE
		vi_dw_lista.Object.filtro2.Text = "Todos "
	END IF

	vi_dw_lista.Object.filtro8a.Text = trim(v_Fech_ini.text)
	vi_dw_lista.Object.filtro8b.Text = trim(v_Fech_fin.text)


end event

type gb_borde from w_filtra_reportes_pro_fec_dep_nro`gb_borde within w_filtra_reportes_pro_fec_dep_prov
int Y=1668
end type

type dw_busca from w_filtra_reportes_pro_fec_dep_nro`dw_busca within w_filtra_reportes_pro_fec_dep_prov
int TabOrder=100
end type

type dw_filtro from w_filtra_reportes_pro_fec_dep_nro`dw_filtro within w_filtra_reportes_pro_fec_dep_prov
int TabOrder=90
boolean BringToTop=true
end type

type st_3 from w_filtra_reportes_pro_fec_dep_nro`st_3 within w_filtra_reportes_pro_fec_dep_prov
boolean BringToTop=true
end type

type st_4 from w_filtra_reportes_pro_fec_dep_nro`st_4 within w_filtra_reportes_pro_fec_dep_prov
int Y=1236
boolean BringToTop=true
end type

type v_fech_fin from w_filtra_reportes_pro_fec_dep_nro`v_fech_fin within w_filtra_reportes_pro_fec_dep_prov
int Y=1236
boolean BringToTop=true
end type

type v_fech_ini from w_filtra_reportes_pro_fec_dep_nro`v_fech_ini within w_filtra_reportes_pro_fec_dep_prov
int Y=1236
boolean BringToTop=true
end type

type cdw_param_1 from w_filtra_reportes_pro_fec_dep_nro`cdw_param_1 within w_filtra_reportes_pro_fec_dep_prov
int Y=1328
boolean BringToTop=true
end type

type rb_1 from w_filtra_reportes_pro_fec_dep_nro`rb_1 within w_filtra_reportes_pro_fec_dep_prov
int X=1271
int Y=1556
boolean Visible=false
boolean BringToTop=true
string Text="Pendiente"
end type

type rb_2 from w_filtra_reportes_pro_fec_dep_nro`rb_2 within w_filtra_reportes_pro_fec_dep_prov
int Y=1656
boolean Visible=false
boolean BringToTop=true
string Text="Retornado"
end type

type rb_3 from w_filtra_reportes_pro_fec_dep_nro`rb_3 within w_filtra_reportes_pro_fec_dep_prov
int Y=1724
boolean Visible=false
boolean BringToTop=true
end type

type gb_1 from w_filtra_reportes_pro_fec_dep_nro`gb_1 within w_filtra_reportes_pro_fec_dep_prov
int Y=1552
int TabOrder=80
boolean Visible=false
end type

type cdw_param_5 from w_filtra_reportes_pro_fec_dep_nro`cdw_param_5 within w_filtra_reportes_pro_fec_dep_prov
int Y=1484
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
end type

type st_1 from w_filtra_reportes_pro_fec_dep_nro`st_1 within w_filtra_reportes_pro_fec_dep_prov
int Y=1484
int Width=306
boolean Visible=false
boolean BringToTop=true
string Text="Nro Factura:"
end type

type rb_comp from w_filtra_reportes_pro_fec_dep_nro`rb_comp within w_filtra_reportes_pro_fec_dep_prov
int Y=1904
boolean Visible=false
end type

event rb_comp::clicked;//*

end event

type cdw_param_2 from datawindow within w_filtra_reportes_pro_fec_dep_prov
int X=485
int Y=1404
int Width=1586
int Height=80
int TabOrder=40
boolean BringToTop=true
string DataObject="dw_param_proveedor"
boolean Border=false
boolean LiveScroll=true
end type

type gb_2 from groupbox within w_filtra_reportes_pro_fec_dep_prov
int X=681
int Y=1504
int Width=1170
int Height=140
int TabOrder=100
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_6 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
int X=722
int Y=1552
int Width=343
int Height=76
boolean BringToTop=true
string Text="Mercaderías"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_7 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
int X=1609
int Y=1552
int Width=210
int Height=76
boolean BringToTop=true
string Text="Todos"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_8 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
int X=1079
int Y=1552
int Width=256
int Height=76
boolean BringToTop=true
string Text="Insumos"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_9 from radiobutton within w_filtra_reportes_pro_fec_dep_prov
int X=1353
int Y=1552
int Width=247
int Height=76
boolean BringToTop=true
string Text="Activos"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


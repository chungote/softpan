$PBExportHeader$w_filtra_reportes_productos.srw
forward
global type w_filtra_reportes_productos from w_modelo_filtro
end type
type st_2 from statictext within w_filtra_reportes_productos
end type
type dw_busca from datawindow within w_filtra_reportes_productos
end type
type dw_filtro from datawindow within w_filtra_reportes_productos
end type
end forward

global type w_filtra_reportes_productos from w_modelo_filtro
int X=553
int Y=148
int Width=2533
int Height=1532
long BackColor=12632256
st_2 st_2
dw_busca dw_busca
dw_filtro dw_filtro
end type
global w_filtra_reportes_productos w_filtra_reportes_productos

type variables
string vi_data
long vi_columna
end variables

on w_filtra_reportes_productos.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_busca=create dw_busca
this.dw_filtro=create dw_filtro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_busca
this.Control[iCurrent+3]=this.dw_filtro
end on

on w_filtra_reportes_productos.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_busca)
destroy(this.dw_filtro)
end on

event open;call super::open;dw_filtro.reset()
dw_filtro.insertrow(0)
long v_temp
string tipo_valor
for v_temp = 1 to 28
	 tipo_valor = dw_filtro.describe("#"+string(v_temp)+".coltype")
	 if left(tipo_valor,4)="long" then
	    dw_filtro.setitem(1, v_temp, long(vi_dw_lista.vi_argumentos[v_temp]))
	 elseif left(tipo_valor,4)="char" then
	    dw_filtro.setitem(1, v_temp, string(vi_dw_lista.vi_argumentos[v_temp]))
	 end if
next

end event

event close;call super::close;long v_temp
string tipo_valor
for v_temp = 1 to 28
	 tipo_valor = dw_filtro.describe("#"+string(v_temp)+".coltype")
	 if left(tipo_valor,4)="long" then
	    vi_dw_lista.vi_argumentos[v_temp] = dw_filtro.getitemnumber(1, v_temp)
	 elseif left(tipo_valor,4)="char" then
	    vi_dw_lista.vi_argumentos[v_temp] = dw_filtro.getitemstring(1, v_temp)
	 end if
next

end event

type pb_close from w_modelo_filtro`pb_close within w_filtra_reportes_productos
int X=1230
int Y=1252
int TabOrder=30
end type

type pb_ok from w_modelo_filtro`pb_ok within w_filtra_reportes_productos
int X=837
int Y=1252
end type

event pb_ok::clicked;dw_filtro.accepttext() 
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
cant_filas = vi_dw_lista.retrieve(vg_param_1a,vg_param_1b,vg_param_2a,vg_param_2b,vg_param_3a,vg_param_3b,vg_param_4a,vg_param_4b,vg_param_5a,vg_param_5b,vg_param_6a,vg_param_6b,vg_param_7a,vg_param_7b)
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



end event

type gb_borde from w_modelo_filtro`gb_borde within w_filtra_reportes_productos
int X=805
int Y=1180
int TabOrder=40
long TextColor=128
long BackColor=12632256
end type

type st_2 from statictext within w_filtra_reportes_productos
int X=37
int Y=12
int Width=1495
int Height=100
boolean Enabled=false
string Text="Pulse F3 para capturar desde lista..."
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_busca from datawindow within w_filtra_reportes_productos
int X=169
int Y=20
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_filtro from datawindow within w_filtra_reportes_productos
event ue_tecla_pulsada pbm_dwnkey
event ue_modificar ( )
int X=23
int Y=48
int Width=2450
int Height=1164
int TabOrder=20
boolean BringToTop=true
string DataObject="dw_filtra_productos"
boolean Border=false
boolean LiveScroll=true
end type

event ue_tecla_pulsada;if keydown(keyf3!) then 
	dw_filtro.accepttext()
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
	
	//#par_glo (s int,ss int, g int, c int, sc int, s_f int,ss_f int, g_f int, c_f int, sc_f int  );
		update #par_glo set 	s = :vg_param_2a,
									ss = :vg_param_3a,
									g = :vg_param_4a,
									c = :vg_param_5a,
									sc = :vg_param_6a,
									s_f = :vg_param_2b ,
									ss_f = :vg_param_3b,
									g_f = :vg_param_4b,
									c_f = :vg_param_5b,
									sc_f = :vg_param_6b ;
		if error_db(sqlca, 'Error al actualizar temp') then return
	
	guo_func.of_find_cdw (dw_filtro )
end if


end event

event ue_modificar;if vi_columna = 1 then
	this.setcolumn(3)
	this.settext(vi_data)
end if
if vi_columna = 5 then
	this.setcolumn(7)
	this.settext(vi_data)
end if
if vi_columna = 9 then
	this.setcolumn(11)
	this.settext(vi_data)
end if
if vi_columna = 13 then
	this.setcolumn(15)
	this.settext(vi_data)
end if
if vi_columna = 17 then
	this.setcolumn(19)
	this.settext(vi_data)
end if
if vi_columna = 21 then
	this.setcolumn(23)
	this.settext(vi_data)
end if
if vi_columna = 25 then
	this.setcolumn(27)
	this.settext(vi_data)
end if
dw_filtro.accepttext() 

end event

event itemchanged;if this.getcolumnname() = 'seccion_cod_seccion' or this.getcolumnname() = 'seccion_cod_seccion_hasta' then 
	dw_filtro.setitem(1,'sub_seccion_cod_sub_seccion', 0)	
	dw_filtro.setitem(1,'sub_seccion_cod_sub_seccion_hasta', 0)	
	dw_filtro.setitem(1,'grupo_cod_grupo', 0)	
	dw_filtro.setitem(1,'grupo_cod_grupo_hasta', 0)	
	dw_filtro.setitem(1,'categorias_cod_categoria', 0)	
	dw_filtro.setitem(1,'categorias_cod_categoria_hasta', 0)	
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria', 0)	
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria_hasta', 0)	
end if
if this.getcolumnname() = 'sub_seccion_cod_sub_seccion' or this.getcolumnname() = 'sub_seccion_cod_sub_seccion_hasta' then 
	dw_filtro.setitem(1,'grupo_cod_grupo', 0)	
	dw_filtro.setitem(1,'grupo_cod_grupo_hasta', 0)	
	dw_filtro.setitem(1,'categorias_cod_categoria', 0)	
	dw_filtro.setitem(1,'categorias_cod_categoria_hasta', 0)	
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria', 0)	
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria_hasta', 0)	
end if
if this.getcolumnname() = 'grupo_cod_grupo' or this.getcolumnname() = 'grupo_cod_grupo_hasta' then 
	dw_filtro.setitem(1,'categorias_cod_categoria', 0)	
	dw_filtro.setitem(1,'categorias_cod_categoria_hasta', 0)	
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria', 0)	
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria_hasta', 0)	
end if
if this.getcolumnname() = 'categorias_cod_categoria' or this.getcolumnname() = 'categorias_cod_categoria_hasta' then 
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria', 0)	
	dw_filtro.setitem(1,'sub_categorias_cod_sub_categoria_hasta', 0)	
end if

this.accepttext()
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

//#par_glo (s int,ss int, g int, c int, sc int, s_f int,ss_f int, g_f int, c_f int, sc_f int  );
	update #par_glo set 	s = :vg_param_2a,
								ss = :vg_param_3a,
								g = :vg_param_4a,
								c = :vg_param_5a,
								sc = :vg_param_6a,
								s_f = :vg_param_2b ,
								ss_f = :vg_param_3b,
								g_f = :vg_param_4b,
								c_f = :vg_param_5b,
								sc_f = :vg_param_6b ;
	if error_db(sqlca, 'Error al actualizar temp') then return

guo_func.of_find_descrip ( dw_filtro, dw_busca)

vi_data = data
vi_columna = this.getcolumn()
this.PostEvent("ue_modificar")


end event


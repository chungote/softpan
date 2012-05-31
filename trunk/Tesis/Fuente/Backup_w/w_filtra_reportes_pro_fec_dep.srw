$PBExportHeader$w_filtra_reportes_pro_fec_dep.srw
forward
global type w_filtra_reportes_pro_fec_dep from w_filtra_reportes_pro_fec
end type
type cdw_param_1 from datawindow within w_filtra_reportes_pro_fec_dep
end type
end forward

global type w_filtra_reportes_pro_fec_dep from w_filtra_reportes_pro_fec
int Height=1712
cdw_param_1 cdw_param_1
end type
global w_filtra_reportes_pro_fec_dep w_filtra_reportes_pro_fec_dep

on w_filtra_reportes_pro_fec_dep.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
end on

on w_filtra_reportes_pro_fec_dep.destroy
call super::destroy
destroy(this.cdw_param_1)
end on

event open;call super::open;cdw_param_1.SetTransObject(sqlca)
cdw_param_1.reset()
cdw_param_1.insertrow(0)

end event

type pb_close from w_filtra_reportes_pro_fec`pb_close within w_filtra_reportes_pro_fec_dep
int Y=1452
end type

type pb_ok from w_filtra_reportes_pro_fec`pb_ok within w_filtra_reportes_pro_fec_dep
int Y=1452
end type

event pb_ok::clicked;dw_filtro.accepttext() 
DATE A
long B
A = Date(v_Fech_ini.text)
B = cdw_param_1.Getitemnumber(1,1)
IF ISNULL(B) THEN
		B=0
END IF

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
	
	vi_dw_lista.Object.filtro9.Text = trim(v_Fech_ini.text)
	
	if B <> 0 then
		vi_dw_lista.Object.filtro8.Text = filtro_depositos(B)
	ELSE
		vi_dw_lista.Object.filtro8.Text = "Todos "
	END IF


end event

type gb_borde from w_filtra_reportes_pro_fec`gb_borde within w_filtra_reportes_pro_fec_dep
int Y=1380
end type

type dw_busca from w_filtra_reportes_pro_fec`dw_busca within w_filtra_reportes_pro_fec_dep
int TabOrder=70
end type

type dw_filtro from w_filtra_reportes_pro_fec`dw_filtro within w_filtra_reportes_pro_fec_dep
boolean BringToTop=true
end type

type st_3 from w_filtra_reportes_pro_fec`st_3 within w_filtra_reportes_pro_fec_dep
int X=480
int Y=1236
int Width=334
boolean BringToTop=true
string Text="Fecha :"
end type

type st_4 from w_filtra_reportes_pro_fec`st_4 within w_filtra_reportes_pro_fec_dep
boolean Visible=false
boolean BringToTop=true
end type

type v_fech_fin from w_filtra_reportes_pro_fec`v_fech_fin within w_filtra_reportes_pro_fec_dep
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
end type

type v_fech_ini from w_filtra_reportes_pro_fec`v_fech_ini within w_filtra_reportes_pro_fec_dep
boolean BringToTop=true
end type

type cdw_param_1 from datawindow within w_filtra_reportes_pro_fec_dep
int X=485
int Y=1308
int Width=1591
int Height=80
int TabOrder=20
boolean BringToTop=true
string DataObject="dw_param_depositos"
boolean Border=false
boolean LiveScroll=true
end type


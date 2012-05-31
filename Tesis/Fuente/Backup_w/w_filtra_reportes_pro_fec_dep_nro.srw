$PBExportHeader$w_filtra_reportes_pro_fec_dep_nro.srw
forward
global type w_filtra_reportes_pro_fec_dep_nro from w_filtra_reportes_pro_fec_dep
end type
type rb_1 from radiobutton within w_filtra_reportes_pro_fec_dep_nro
end type
type rb_2 from radiobutton within w_filtra_reportes_pro_fec_dep_nro
end type
type rb_3 from radiobutton within w_filtra_reportes_pro_fec_dep_nro
end type
type gb_1 from groupbox within w_filtra_reportes_pro_fec_dep_nro
end type
type cdw_param_5 from editmask within w_filtra_reportes_pro_fec_dep_nro
end type
type st_1 from statictext within w_filtra_reportes_pro_fec_dep_nro
end type
type rb_comp from checkbox within w_filtra_reportes_pro_fec_dep_nro
end type
end forward

global type w_filtra_reportes_pro_fec_dep_nro from w_filtra_reportes_pro_fec_dep
integer width = 2505
integer height = 2068
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
gb_1 gb_1
cdw_param_5 cdw_param_5
st_1 st_1
rb_comp rb_comp
end type
global w_filtra_reportes_pro_fec_dep_nro w_filtra_reportes_pro_fec_dep_nro

on w_filtra_reportes_pro_fec_dep_nro.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.gb_1=create gb_1
this.cdw_param_5=create cdw_param_5
this.st_1=create st_1
this.rb_comp=create rb_comp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cdw_param_5
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rb_comp
end on

on w_filtra_reportes_pro_fec_dep_nro.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.gb_1)
destroy(this.cdw_param_5)
destroy(this.st_1)
destroy(this.rb_comp)
end on

event open;call super::open;rb_comp.triggerevent('clicked')
end event

type pb_close from w_filtra_reportes_pro_fec_dep`pb_close within w_filtra_reportes_pro_fec_dep_nro
integer y = 1824
integer taborder = 60
end type

type pb_ok from w_filtra_reportes_pro_fec_dep`pb_ok within w_filtra_reportes_pro_fec_dep_nro
integer y = 1824
integer taborder = 50
end type

event pb_ok::clicked;dw_filtro.accepttext()

	long A
	Date B,C
	long D	
	long E

	A = cdw_param_1.Getitemnumber(1,1)
	IF ISNULL(A) THEN
		A=0
	END IF
	
	B = Date(v_Fech_ini.text)
	If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then
		setnull(B)
	end if	
	
	C = Date(v_Fech_fin.text)	
	If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then
		setnull(C)
	end if		
	
	D = Long(cdw_param_5.text)
	IF ISNULL(D) THEN
		D=0
	END IF
	
	IF rb_1.checked = TRUE THEN
		E = 0
	END IF
	IF rb_2.checked = TRUE THEN
		E = 1
	END IF
	IF rb_3.checked = TRUE THEN
		E = 2
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
cant_filas = vi_dw_lista.retrieve(vg_param_1a,vg_param_1b,vg_param_2a,vg_param_2b,vg_param_3a,vg_param_3b,vg_param_4a,vg_param_4b,vg_param_5a,vg_param_5b,vg_param_6a,vg_param_6b,vg_param_7a,vg_param_7b,A,B,C,D,E)
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

	if A <> 0 then
		vi_dw_lista.Object.filtro9.Text = filtro_depositos(A)
	ELSE
		vi_dw_lista.Object.filtro9.Text = "Todos "
	END IF

	if D <> 0 then
		vi_dw_lista.Object.filtro10.Text = string(D)
	ELSE
		vi_dw_lista.Object.filtro10.Text = "Todos "
	END IF

end event

type gb_borde from w_filtra_reportes_pro_fec_dep`gb_borde within w_filtra_reportes_pro_fec_dep_nro
integer y = 1752
end type

type st_2 from w_filtra_reportes_pro_fec_dep`st_2 within w_filtra_reportes_pro_fec_dep_nro
end type

type dw_busca from w_filtra_reportes_pro_fec_dep`dw_busca within w_filtra_reportes_pro_fec_dep_nro
integer taborder = 80
end type

type dw_filtro from w_filtra_reportes_pro_fec_dep`dw_filtro within w_filtra_reportes_pro_fec_dep_nro
integer x = 27
integer y = 56
integer taborder = 70
end type

type st_3 from w_filtra_reportes_pro_fec_dep`st_3 within w_filtra_reportes_pro_fec_dep_nro
end type

type st_4 from w_filtra_reportes_pro_fec_dep`st_4 within w_filtra_reportes_pro_fec_dep_nro
boolean visible = true
end type

type v_fech_fin from w_filtra_reportes_pro_fec_dep`v_fech_fin within w_filtra_reportes_pro_fec_dep_nro
boolean visible = true
integer taborder = 20
end type

type v_fech_ini from w_filtra_reportes_pro_fec_dep`v_fech_ini within w_filtra_reportes_pro_fec_dep_nro
end type

type cdw_param_1 from w_filtra_reportes_pro_fec_dep`cdw_param_1 within w_filtra_reportes_pro_fec_dep_nro
integer taborder = 30
end type

type rb_1 from radiobutton within w_filtra_reportes_pro_fec_dep_nro
integer x = 841
integer y = 1508
integer width = 430
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "A Confirmar"
boolean lefttext = true
boolean righttoleft = true
end type

type rb_2 from radiobutton within w_filtra_reportes_pro_fec_dep_nro
integer x = 878
integer y = 1576
integer width = 389
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Confirmado"
boolean lefttext = true
boolean righttoleft = true
end type

type rb_3 from radiobutton within w_filtra_reportes_pro_fec_dep_nro
integer x = 878
integer y = 1644
integer width = 389
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todos"
boolean checked = true
boolean lefttext = true
boolean righttoleft = true
end type

type gb_1 from groupbox within w_filtra_reportes_pro_fec_dep_nro
integer x = 805
integer y = 1472
integer width = 544
integer height = 276
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cdw_param_5 from editmask within w_filtra_reportes_pro_fec_dep_nro
integer x = 809
integer y = 1404
integer width = 357
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0"
end type

type st_1 from statictext within w_filtra_reportes_pro_fec_dep_nro
integer x = 485
integer y = 1404
integer width = 302
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nro Ajuste:"
boolean focusrectangle = false
end type

type rb_comp from checkbox within w_filtra_reportes_pro_fec_dep_nro
integer x = 393
integer y = 1824
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

event clicked;if rb_comp.Checked = TRUE then   
	vi_dw_lista.dataobject = "dw_lista_stock_ajustestock"				
else	
	vi_dw_lista.dataobject = "dw_lista_stock_ajustestock_res"
end if		
vi_dw_lista.settransobject(vg_server5)
vi_dw_lista.Modify("datawindow.print.Preview=Yes")
vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event


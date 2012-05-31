$PBExportHeader$w_modelo_listado_familias.srw
forward
global type w_modelo_listado_familias from w_modelo_listado
end type
type cbx_1 from checkbox within w_modelo_listado_familias
end type
type cbx_2 from checkbox within w_modelo_listado_familias
end type
type cbx_3 from checkbox within w_modelo_listado_familias
end type
type cbx_4 from checkbox within w_modelo_listado_familias
end type
type cbx_5 from checkbox within w_modelo_listado_familias
end type
type cbx_6 from checkbox within w_modelo_listado_familias
end type
type cbx_7 from checkbox within w_modelo_listado_familias
end type
type pb_ok from uo_boton within w_modelo_listado_familias
end type
end forward

global type w_modelo_listado_familias from w_modelo_listado
int Width=3584
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
cbx_6 cbx_6
cbx_7 cbx_7
pb_ok pb_ok
end type
global w_modelo_listado_familias w_modelo_listado_familias

type variables
long vi_sec, vi_sub_sec, vi_gru, vi_cat, vi_sub_cat,vi_mar, vi_pro
long il_prod_hi
end variables

event open;call super::open;cbx_1.text = f_etiqueta(1,1,"00001Sección:")
cbx_2.text = f_etiqueta(1,1,"00010Sub Sección:")
cbx_3.text = f_etiqueta(1,1,"00020Grupo:")
cbx_4.text = f_etiqueta(1,1,"00030Categoría:")
cbx_5.text = f_etiqueta(1,1,"00040Sub Categoría:")
cbx_6.text = f_etiqueta(1,1,"00050Marca:")

long v_po1, v_po2
string v_grupos
v_grupos = cdw_listado.Describe("cf_paginas.tag")
v_po1 = pos( v_grupos  , "[")
v_po2 = pos( v_grupos , "]")
if v_po1 > 0 and v_po2 > 0 then
	v_grupos = mid(v_grupos, v_po1 + 1)
	v_grupos = left(v_grupos, 14 )
 	vi_sec = long(mid(v_grupos, 1 , 2))
	vi_sub_sec = long(mid(v_grupos, 3 , 2))
	vi_gru = long(mid(v_grupos, 5 , 2))
	vi_cat = long(mid(v_grupos, 7 , 2))
	vi_sub_cat = long(mid(v_grupos, 9 , 2))
	vi_mar = long(mid(v_grupos, 11 , 2))
	vi_pro = long(mid(v_grupos, 13 , 2))
else
 	vi_sec = 0
	vi_sub_sec = 0
	vi_gru = 0
	vi_cat = 0
	vi_sub_cat = 0
	vi_mar = 0
	vi_pro = 0
end if

if vi_pro > 0 then
	il_prod_hi = long(cdw_listado.describe('DataWindow.Header.' + trim(string(vi_pro)) + '.Height'))
else
	il_prod_hi = long(cdw_listado.describe('DataWindow.Detail.Height'))
end if

end event

on w_modelo_listado_familias.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.cbx_6=create cbx_6
this.cbx_7=create cbx_7
this.pb_ok=create pb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
this.Control[iCurrent+3]=this.cbx_3
this.Control[iCurrent+4]=this.cbx_4
this.Control[iCurrent+5]=this.cbx_5
this.Control[iCurrent+6]=this.cbx_6
this.Control[iCurrent+7]=this.cbx_7
this.Control[iCurrent+8]=this.pb_ok
end on

on w_modelo_listado_familias.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.cbx_6)
destroy(this.cbx_7)
destroy(this.pb_ok)
end on

event resize;cdw_listado.Resize(this.Width - 80, this.Height - 350)

end event

type pb_file from w_modelo_listado`pb_file within w_modelo_listado_familias
int Y=12
end type

event pb_file::clicked;call super::clicked;long v_po1, v_po2
string v_grupos
v_grupos = cdw_listado.Describe("cf_paginas.tag")
v_po1 = pos( v_grupos  , "[")
v_po2 = pos( v_grupos , "]")
if v_po1 > 0 and v_po2 > 0 then
	v_grupos = mid(v_grupos, v_po1 + 1)
	v_grupos = left(v_grupos, 14 )
 	vi_sec = long(mid(v_grupos, 1 , 2))
	vi_sub_sec = long(mid(v_grupos, 3 , 2))
	vi_gru = long(mid(v_grupos, 5 , 2))
	vi_cat = long(mid(v_grupos, 7 , 2))
	vi_sub_cat = long(mid(v_grupos, 9 , 2))
	vi_mar = long(mid(v_grupos, 11 , 2))
	vi_pro = long(mid(v_grupos, 13 , 2))
else
 	vi_sec = 0
	vi_sub_sec = 0
	vi_gru = 0
	vi_cat = 0
	vi_sub_cat = 0
	vi_mar = 0
	vi_pro = 0
end if

end event

type pb_salir from w_modelo_listado`pb_salir within w_modelo_listado_familias
int Y=12
end type

type pb_ver from w_modelo_listado`pb_ver within w_modelo_listado_familias
int Y=12
end type

event pb_ver::clicked;cdw_listado.reset()
cbx_1.Checked = TRUE
cbx_2.Checked = TRUE
cbx_3.Checked = TRUE
cbx_4.Checked = TRUE
cbx_5.Checked = TRUE
cbx_6.Checked = TRUE
cbx_7.Checked = TRUE
guo_func.of_grupo(cdw_listado, vi_sec, true, 76)
guo_func.of_grupo(cdw_listado, vi_sub_sec, true, 76)
guo_func.of_grupo(cdw_listado, vi_gru, true, 76)
guo_func.of_grupo(cdw_listado, vi_cat, true, 76)
guo_func.of_grupo(cdw_listado, vi_sub_cat, true, 76)
guo_func.of_grupo(cdw_listado, vi_mar, true, 76)
if vi_pro = 0 then
	guo_func.of_detalle(cdw_listado, true, 76)
else
	guo_func.of_grupo(cdw_listado, vi_pro, true, 76)
end if

if left(string(cdw_listado.Describe("cf_paginas.tag")), 1) = '[' or string(cdw_listado.Describe("cf_paginas.tag")) = '?' or cdw_listado.Describe("cf_paginas.tag") = '' or isnull(cdw_listado.Describe("cf_paginas.tag")) or cdw_listado.Describe("cf_paginas.tag") = '*' then
	long cant_filas
	cant_filas = cdw_listado.retrieve()
	if cant_filas = 0 then		
		messageBox("Aviso...","No existen datos para recuperar...")
	end if
else
	window lwin_temp
	if pos(cdw_listado.Describe("cf_paginas.tag"), '[') > 0 then
	   OpenWithParm(lwin_temp,cdw_listado, left(cdw_listado.Describe("cf_paginas.tag"),len(cdw_listado.Describe("cf_paginas.tag")) - 16) )
	else
	   OpenWithParm(lwin_temp,cdw_listado, cdw_listado.Describe("cf_paginas.tag"))
	end if
end if

long v_po1, v_po2
string v_grupos
v_grupos = cdw_listado.Describe("cf_paginas.tag")
v_po1 = pos( v_grupos  , "[")
v_po2 = pos( v_grupos , "]")
if v_po1 > 0 and v_po2 > 0 then
	v_grupos = mid(v_grupos, v_po1 + 1)
	v_grupos = left(v_grupos, 14 )
 	vi_sec = long(mid(v_grupos, 1 , 2))
	vi_sub_sec = long(mid(v_grupos, 3 , 2))
	vi_gru = long(mid(v_grupos, 5 , 2))
	vi_cat = long(mid(v_grupos, 7 , 2))
	vi_sub_cat = long(mid(v_grupos, 9 , 2))
	vi_mar = long(mid(v_grupos, 11 , 2))
	vi_pro = long(mid(v_grupos, 13 , 2))
else
 	vi_sec = 0
	vi_sub_sec = 0
	vi_gru = 0
	vi_cat = 0
	vi_sub_cat = 0
	vi_mar = 0
	vi_pro = 0
end if

end event

type pb_mail from w_modelo_listado`pb_mail within w_modelo_listado_familias
int Y=12
end type

type pb_print from w_modelo_listado`pb_print within w_modelo_listado_familias
int Y=12
end type

type pb_export from w_modelo_listado`pb_export within w_modelo_listado_familias
int Y=12
end type

type pb_orden from w_modelo_listado`pb_orden within w_modelo_listado_familias
int Y=12
end type

type pb_filtrar from w_modelo_listado`pb_filtrar within w_modelo_listado_familias
int Y=12
end type

type cdw_listado from w_modelo_listado`cdw_listado within w_modelo_listado_familias
int Y=184
int Height=1712
end type

type cbx_1 from checkbox within w_modelo_listado_familias
int X=27
int Y=112
int Width=421
int Height=64
boolean BringToTop=true
string Text="Sección"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//guo_func.of_grupo(cdw_listado, vi_sec, cbx_1.checked, 76)

end event

type cbx_2 from checkbox within w_modelo_listado_familias
int X=485
int Y=112
int Width=485
int Height=64
boolean BringToTop=true
string Text="Sub Sección"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//guo_func.of_grupo(cdw_listado, vi_sub_sec, cbx_2.checked, 76)

end event

type cbx_3 from checkbox within w_modelo_listado_familias
int X=997
int Y=112
int Width=485
int Height=64
boolean BringToTop=true
string Text="Grupo"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//guo_func.of_grupo(cdw_listado, vi_gru, cbx_3.checked, 76)

end event

type cbx_4 from checkbox within w_modelo_listado_familias
int X=1504
int Y=120
int Width=421
int Height=64
boolean BringToTop=true
string Text="Categoría"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//guo_func.of_grupo(cdw_listado, vi_cat, cbx_4.checked, 76)

end event

type cbx_5 from checkbox within w_modelo_listado_familias
int X=1993
int Y=120
int Width=485
int Height=64
boolean BringToTop=true
string Text="Sub Categoría"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//guo_func.of_grupo(cdw_listado, vi_sub_cat, cbx_5.checked, 76)

end event

type cbx_6 from checkbox within w_modelo_listado_familias
int X=2510
int Y=120
int Width=485
int Height=64
boolean BringToTop=true
string Text="Marca"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//guo_func.of_grupo(cdw_listado, vi_mar, cbx_6.checked, 76)

end event

type cbx_7 from checkbox within w_modelo_listado_familias
int X=3017
int Y=120
int Width=421
int Height=64
boolean BringToTop=true
string Text="Productos"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//if vi_pro = 0 then
//	guo_func.of_detalle(cdw_listado, cbx_7.checked, 76)
//else
//	guo_func.of_grupo(cdw_listado, vi_pro, cbx_7.checked, 76)
//end if
end event

type pb_ok from uo_boton within w_modelo_listado_familias
int X=14
int Y=12
int Width=105
int Height=88
int TabOrder=20
boolean BringToTop=true
string Text="&OK"
int TextSize=-7
end type

event clicked;call super::clicked;string v_temp
long v_s, v_ss, v_g, v_c, v_sc, v_m
v_s = 0
v_ss = 0 
v_g = 0
v_c = 0
v_sc = 0
v_m = 0
cdw_listado.SetRedraw(FALSE)
if cbx_1.checked then 
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_sec)) + '.Height=' + trim(string(76)) )
else
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_sec)) + '.Height=0')
	v_s = 1
end if
if cbx_2.checked then
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_sub_sec)) + '.Height=' + trim(string(76)) )
else
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_sub_sec)) + '.Height=0')
	v_ss = 1
end if
if cbx_3.checked then
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_gru)) + '.Height=' + trim(string(76)) )
else
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_gru)) + '.Height=0')
	v_g = 1
end if
if cbx_4.checked then
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_cat)) + '.Height=' + trim(string(76)) )
else
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_cat)) + '.Height=0')
	v_c = 1
end if
if cbx_5.checked then
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_sub_cat)) + '.Height=' + trim(string(76)) )
else
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_sub_cat)) + '.Height=0')
	v_sc = 1
end if
if cbx_6.checked then
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_mar)) + '.Height=' + trim(string(76)) )
else
	cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_mar)) + '.Height=0')
	v_m = 1
end if
if vi_pro > 0 then
	if cbx_7.checked then
		cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_pro)) + '.Height=' + trim(string(76)) )
	else
		cdw_listado.Modify('DataWindow.Header.' + trim(string(vi_pro)) + '.Height=0')
	end if
else
	if cbx_7.checked then
		cdw_listado.Modify('DataWindow.Detail.Height=' +  + trim(string(il_prod_hi)) ) //trim(string(76)) )
	else
		cdw_listado.Modify('DataWindow.Detail.Height=0' )
	end if
end if
//long v_temp1, v_filas
//v_filas = cdw_listado.rowcount()
//for v_temp1 = 1 to v_filas
//	 cdw_listado.setitem(v_temp1, 'v_s', v_s)
//	 cdw_listado.setitem(v_temp1, 'v_ss', v_ss)
//	 cdw_listado.setitem(v_temp1, 'v_g', v_g)
//	 cdw_listado.setitem(v_temp1, 'v_c', v_c)
//	 cdw_listado.setitem(v_temp1, 'v_sc', v_sc)
//	 cdw_listado.setitem(v_temp1, 'v_m', v_m)
//next
cdw_listado.GroupCalc()
cdw_listado.SetRedraw(TRUE)

end event


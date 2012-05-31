$PBExportHeader$w_filtra_reportes_pagos_detallado.srw
forward
global type w_filtra_reportes_pagos_detallado from w_filtra_reportes_fec
end type
type cdw_param_1 from datawindow within w_filtra_reportes_pagos_detallado
end type
type cdw_param_4 from editmask within w_filtra_reportes_pagos_detallado
end type
type st_72 from statictext within w_filtra_reportes_pagos_detallado
end type
type cdw_param_5 from editmask within w_filtra_reportes_pagos_detallado
end type
type st_73 from statictext within w_filtra_reportes_pagos_detallado
end type
type cdw_param_3 from datawindow within w_filtra_reportes_pagos_detallado
end type
type st_80 from statictext within w_filtra_reportes_pagos_detallado
end type
type st_81 from statictext within w_filtra_reportes_pagos_detallado
end type
type v_fech_fin_doc from editmask within w_filtra_reportes_pagos_detallado
end type
type v_fech_ini_doc from editmask within w_filtra_reportes_pagos_detallado
end type
type st_82 from statictext within w_filtra_reportes_pagos_detallado
end type
type st_83 from statictext within w_filtra_reportes_pagos_detallado
end type
type v_fech_fin_rec from editmask within w_filtra_reportes_pagos_detallado
end type
type v_fech_ini_rec from editmask within w_filtra_reportes_pagos_detallado
end type
end forward

global type w_filtra_reportes_pagos_detallado from w_filtra_reportes_fec
int Width=1874
int Height=968
cdw_param_1 cdw_param_1
cdw_param_4 cdw_param_4
st_72 st_72
cdw_param_5 cdw_param_5
st_73 st_73
cdw_param_3 cdw_param_3
st_80 st_80
st_81 st_81
v_fech_fin_doc v_fech_fin_doc
v_fech_ini_doc v_fech_ini_doc
st_82 st_82
st_83 st_83
v_fech_fin_rec v_fech_fin_rec
v_fech_ini_rec v_fech_ini_rec
end type
global w_filtra_reportes_pagos_detallado w_filtra_reportes_pagos_detallado

event open;call super::open;cdw_param_1.SetTransObject(sqlca)
cdw_param_1.reset()
cdw_param_1.insertrow(0)
cdw_param_3.SetTransObject(sqlca)
cdw_param_3.reset()
cdw_param_3.insertrow(0)

end event

on w_filtra_reportes_pagos_detallado.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
this.cdw_param_4=create cdw_param_4
this.st_72=create st_72
this.cdw_param_5=create cdw_param_5
this.st_73=create st_73
this.cdw_param_3=create cdw_param_3
this.st_80=create st_80
this.st_81=create st_81
this.v_fech_fin_doc=create v_fech_fin_doc
this.v_fech_ini_doc=create v_fech_ini_doc
this.st_82=create st_82
this.st_83=create st_83
this.v_fech_fin_rec=create v_fech_fin_rec
this.v_fech_ini_rec=create v_fech_ini_rec
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
this.Control[iCurrent+2]=this.cdw_param_4
this.Control[iCurrent+3]=this.st_72
this.Control[iCurrent+4]=this.cdw_param_5
this.Control[iCurrent+5]=this.st_73
this.Control[iCurrent+6]=this.cdw_param_3
this.Control[iCurrent+7]=this.st_80
this.Control[iCurrent+8]=this.st_81
this.Control[iCurrent+9]=this.v_fech_fin_doc
this.Control[iCurrent+10]=this.v_fech_ini_doc
this.Control[iCurrent+11]=this.st_82
this.Control[iCurrent+12]=this.st_83
this.Control[iCurrent+13]=this.v_fech_fin_rec
this.Control[iCurrent+14]=this.v_fech_ini_rec
end on

on w_filtra_reportes_pagos_detallado.destroy
call super::destroy
destroy(this.cdw_param_1)
destroy(this.cdw_param_4)
destroy(this.st_72)
destroy(this.cdw_param_5)
destroy(this.st_73)
destroy(this.cdw_param_3)
destroy(this.st_80)
destroy(this.st_81)
destroy(this.v_fech_fin_doc)
destroy(this.v_fech_ini_doc)
destroy(this.st_82)
destroy(this.st_83)
destroy(this.v_fech_fin_rec)
destroy(this.v_fech_ini_rec)
end on

type pb_close from w_filtra_reportes_fec`pb_close within w_filtra_reportes_pagos_detallado
int X=905
int Y=704
int TabOrder=120
end type

type pb_ok from w_filtra_reportes_fec`pb_ok within w_filtra_reportes_pagos_detallado
int X=512
int Y=704
int TabOrder=100
end type

event pb_ok::clicked;long cant_filas
long ll_provee, ll_doc, ll_recibo, ll_tipo
Date dl_pago_ini, dl_pago_fin, dl_doc_ini, dl_doc_fin, dl_recibo_ini, dl_recibo_fin

ll_provee = cdw_param_1.Getitemnumber(1,1)
IF ISNULL(ll_provee) THEN	ll_provee=0

ll_tipo = cdw_param_3.Getitemnumber(1,1)
IF ISNULL(ll_tipo) THEN	ll_tipo=0

dl_pago_ini = Date(v_Fech_ini.text)
if isnull(v_Fech_ini.text) or v_Fech_ini.text = ' ' then setnull(dl_pago_ini)
dl_pago_fin = Date(v_Fech_fin.text)
if isnull(v_Fech_ini.text) or v_Fech_ini.text = ' ' then setnull(dl_pago_fin)
dl_doc_ini = Date(v_fech_ini_doc.text)
if isnull(v_fech_ini_doc.text) or v_fech_ini_doc.text = ' ' then setnull(dl_doc_ini)
dl_doc_fin = Date(v_fech_fin_doc.text)
if isnull(v_fech_fin_doc.text) or v_fech_fin_doc.text = ' ' then setnull(dl_doc_fin)
dl_recibo_ini = Date(v_fech_ini_rec.text)
if isnull(v_fech_ini_rec.text) or v_fech_ini_rec.text = ' ' then setnull(dl_recibo_ini)
dl_recibo_fin = Date(v_fech_fin_rec.text)
if isnull(v_fech_fin_rec.text) or v_fech_fin_rec.text = ' ' then setnull(dl_recibo_fin)

ll_doc = long(cdw_param_4.text)
if isnull(ll_doc) then ll_doc = 0

ll_recibo = long(cdw_param_5.text)
if isnull(ll_recibo) then ll_recibo = 0

cant_filas = vi_dw_lista.retrieve(ll_provee,dl_pago_ini,dl_pago_fin, ll_recibo, ll_tipo, ll_doc,dl_recibo_ini, dl_recibo_fin, dl_doc_ini, dl_doc_fin)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if
DataWindowChild cdw_Cliente
cdw_param_1.GetChild("cod_cliente", cdw_Cliente)
cdw_Cliente.SetTransObject(SQLCA)
if ll_provee <> 0 then
	vi_dw_lista.Object.filtro2.Text = trim( cdw_Cliente.getitemstring(cdw_Cliente.getrow(),2) ) 
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "
END IF
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)
vi_dw_lista.Object.filtro6.Text = trim(v_fech_ini_doc.text)
vi_dw_lista.Object.filtro7.Text = trim(v_fech_fin_doc.text)
vi_dw_lista.Object.filtro8.Text = trim(v_fech_ini_rec.text)
vi_dw_lista.Object.filtro9.Text = trim(v_fech_fin_rec.text)
end event

type gb_borde from w_filtra_reportes_fec`gb_borde within w_filtra_reportes_pagos_detallado
int X=480
int Y=632
end type

type st_3 from w_filtra_reportes_fec`st_3 within w_filtra_reportes_pagos_detallado
int Width=462
boolean BringToTop=true
string Text="Fecha Inicial Pago:"
end type

type st_4 from w_filtra_reportes_fec`st_4 within w_filtra_reportes_pagos_detallado
int X=974
int Width=434
boolean BringToTop=true
string Text="Fecha Final Pago:"
end type

type v_fech_fin from w_filtra_reportes_fec`v_fech_fin within w_filtra_reportes_pagos_detallado
int X=1449
boolean BringToTop=true
end type

type v_fech_ini from w_filtra_reportes_fec`v_fech_ini within w_filtra_reportes_pagos_detallado
int X=539
boolean BringToTop=true
end type

type cdw_param_1 from datawindow within w_filtra_reportes_pagos_detallado
int X=123
int Y=324
int Width=1586
int Height=80
int TabOrder=70
boolean BringToTop=true
string DataObject="dw_param_proveedor"
boolean Border=false
boolean LiveScroll=true
end type

type cdw_param_4 from editmask within w_filtra_reportes_pagos_detallado
int X=448
int Y=524
int Width=343
int Height=80
int TabOrder=90
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###,##0"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_72 from statictext within w_filtra_reportes_pagos_detallado
int X=187
int Y=528
int Width=251
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Nro Doc.:"
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

type cdw_param_5 from editmask within w_filtra_reportes_pagos_detallado
int X=1198
int Y=524
int Width=343
int Height=80
int TabOrder=110
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###,##0"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_73 from statictext within w_filtra_reportes_pagos_detallado
int X=882
int Y=528
int Width=306
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Nro Recibo:"
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

type cdw_param_3 from datawindow within w_filtra_reportes_pagos_detallado
int X=119
int Y=416
int Width=1591
int Height=80
int TabOrder=80
boolean BringToTop=true
string DataObject="dw_param_tip_doc"
boolean Border=false
boolean LiveScroll=true
end type

type st_80 from statictext within w_filtra_reportes_pagos_detallado
int X=37
int Y=132
int Width=443
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha Inicial Doc.:"
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

type st_81 from statictext within w_filtra_reportes_pagos_detallado
int X=974
int Y=132
int Width=416
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha Final Doc.:"
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

type v_fech_fin_doc from editmask within w_filtra_reportes_pagos_detallado
int X=1449
int Y=132
int Width=379
int Height=80
int TabOrder=40
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

type v_fech_ini_doc from editmask within w_filtra_reportes_pagos_detallado
int X=539
int Y=132
int Width=379
int Height=80
int TabOrder=30
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

type st_82 from statictext within w_filtra_reportes_pagos_detallado
int X=37
int Y=224
int Width=507
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha Inicial Recibo:"
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

type st_83 from statictext within w_filtra_reportes_pagos_detallado
int X=974
int Y=224
int Width=480
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha Final Recibo:"
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

type v_fech_fin_rec from editmask within w_filtra_reportes_pagos_detallado
int X=1449
int Y=224
int Width=379
int Height=80
int TabOrder=60
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

type v_fech_ini_rec from editmask within w_filtra_reportes_pagos_detallado
int X=539
int Y=224
int Width=379
int Height=80
int TabOrder=50
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


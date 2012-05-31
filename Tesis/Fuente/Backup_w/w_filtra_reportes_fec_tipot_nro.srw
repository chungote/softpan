$PBExportHeader$w_filtra_reportes_fec_tipot_nro.srw
forward
global type w_filtra_reportes_fec_tipot_nro from w_filtra_reportes_fec
end type
type cdw_param_1 from datawindow within w_filtra_reportes_fec_tipot_nro
end type
type nro_remis from editmask within w_filtra_reportes_fec_tipot_nro
end type
type st_1 from statictext within w_filtra_reportes_fec_tipot_nro
end type
type cdw_param_2 from datawindow within w_filtra_reportes_fec_tipot_nro
end type
type st_2 from statictext within w_filtra_reportes_fec_tipot_nro
end type
type st_10 from statictext within w_filtra_reportes_fec_tipot_nro
end type
end forward

global type w_filtra_reportes_fec_tipot_nro from w_filtra_reportes_fec
int Width=1755
int Height=776
cdw_param_1 cdw_param_1
nro_remis nro_remis
st_1 st_1
cdw_param_2 cdw_param_2
st_2 st_2
st_10 st_10
end type
global w_filtra_reportes_fec_tipot_nro w_filtra_reportes_fec_tipot_nro

event open;call super::open;cdw_param_1.SetTransObject(sqlca)
cdw_param_1.insertrow(0)
cdw_param_2.SetTransObject(sqlca)
cdw_param_2.insertrow(0)

end event

on w_filtra_reportes_fec_tipot_nro.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
this.nro_remis=create nro_remis
this.st_1=create st_1
this.cdw_param_2=create cdw_param_2
this.st_2=create st_2
this.st_10=create st_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
this.Control[iCurrent+2]=this.nro_remis
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cdw_param_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_10
end on

on w_filtra_reportes_fec_tipot_nro.destroy
call super::destroy
destroy(this.cdw_param_1)
destroy(this.nro_remis)
destroy(this.st_1)
destroy(this.cdw_param_2)
destroy(this.st_2)
destroy(this.st_10)
end on

type pb_close from w_filtra_reportes_fec`pb_close within w_filtra_reportes_fec_tipot_nro
int X=878
int Y=496
int TabOrder=60
end type

type pb_ok from w_filtra_reportes_fec`pb_ok within w_filtra_reportes_fec_tipot_nro
int X=485
int Y=496
int TabOrder=50
end type

event pb_ok::clicked;long cant_filas
long A,B,E
Date C,D

A = cdw_param_1.Getitemnumber(1,1)
IF ISNULL(A) THEN	A=0
E = cdw_param_2.Getitemnumber(1,1)
IF ISNULL(E) THEN	E=0
B = Long(nro_remis.text)

C = Date(v_Fech_ini.text)
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then	setnull(C)
D = Date(v_Fech_fin.text)
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then	setnull(D)

cant_filas = vi_dw_lista.retrieve(A,B,C,D,E)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if

if A <> 0 then
	vi_dw_lista.Object.filtro1.Text = filtro_tipo_ot(A)
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF
if E <> 0 then
	vi_dw_lista.Object.filtro5.Text = filtro_tipo_ot(E)
ELSE
	vi_dw_lista.Object.filtro5.Text = "Todos "
END IF
if B <> 0 then
	vi_dw_lista.Object.filtro2.Text = STRING(B)
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "	
END IF	

vi_dw_lista.Object.filtro3.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_fin.text)




end event

type gb_borde from w_filtra_reportes_fec`gb_borde within w_filtra_reportes_fec_tipot_nro
int X=453
int Y=424
end type

type st_3 from w_filtra_reportes_fec`st_3 within w_filtra_reportes_fec_tipot_nro
boolean BringToTop=true
end type

type st_4 from w_filtra_reportes_fec`st_4 within w_filtra_reportes_fec_tipot_nro
boolean BringToTop=true
end type

type v_fech_fin from w_filtra_reportes_fec`v_fech_fin within w_filtra_reportes_fec_tipot_nro
boolean BringToTop=true
end type

type v_fech_ini from w_filtra_reportes_fec`v_fech_ini within w_filtra_reportes_fec_tipot_nro
boolean BringToTop=true
end type

type cdw_param_1 from datawindow within w_filtra_reportes_fec_tipot_nro
int X=78
int Y=136
int Width=1586
int Height=80
int TabOrder=30
boolean BringToTop=true
string DataObject="dw_param_tip_ot"
boolean Border=false
boolean LiveScroll=true
end type

type nro_remis from editmask within w_filtra_reportes_fec_tipot_nro
int X=667
int Y=328
int Width=379
int Height=80
int TabOrder=40
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

type st_1 from statictext within w_filtra_reportes_fec_tipot_nro
int X=251
int Y=328
int Width=398
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Nro Documento"
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

type cdw_param_2 from datawindow within w_filtra_reportes_fec_tipot_nro
int X=78
int Y=232
int Width=1586
int Height=80
int TabOrder=40
boolean BringToTop=true
string DataObject="dw_param_tip_ot"
boolean Border=false
boolean LiveScroll=true
end type

type st_2 from statictext within w_filtra_reportes_fec_tipot_nro
int X=9
int Y=144
int Width=402
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Des. Tipo OT:"
Alignment Alignment=Center!
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

type st_10 from statictext within w_filtra_reportes_fec_tipot_nro
int X=9
int Y=236
int Width=402
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Has. Tipo OT:"
Alignment Alignment=Center!
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


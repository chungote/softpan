$PBExportHeader$w_filtra_reportes_fec_cli.srw
forward
global type w_filtra_reportes_fec_cli from w_filtra_reportes_fec
end type
type cdw_param_1 from datawindow within w_filtra_reportes_fec_cli
end type
end forward

global type w_filtra_reportes_fec_cli from w_filtra_reportes_fec
int Width=1655
int Height=640
cdw_param_1 cdw_param_1
end type
global w_filtra_reportes_fec_cli w_filtra_reportes_fec_cli

event open;call super::open;cdw_param_1.SetTransObject(sqlca)
cdw_param_1.reset()
cdw_param_1.insertrow(0)
cdw_param_1.setitem(1, 1, vi_dw_lista.vi_argumentos[3])


end event

on w_filtra_reportes_fec_cli.create
int iCurrent
call super::create
this.cdw_param_1=create cdw_param_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_1
end on

on w_filtra_reportes_fec_cli.destroy
call super::destroy
destroy(this.cdw_param_1)
end on

event close;call super::close;vi_dw_lista.vi_argumentos[3] = cdw_param_1.getitemnumber(1, 1)
end event

type pb_close from w_filtra_reportes_fec`pb_close within w_filtra_reportes_fec_cli
int Y=344
int TabOrder=50
end type

type pb_ok from w_filtra_reportes_fec`pb_ok within w_filtra_reportes_fec_cli
int Y=344
int TabOrder=40
end type

event pb_ok::clicked;long cant_filas
long A
Date D,E
A = cdw_param_1.Getitemnumber(1,1)
D = Date(v_Fech_ini.text)
E = Date(v_Fech_fin.text)
IF ISNULL(A) THEN
	A=0
END IF
cant_filas = vi_dw_lista.retrieve(A,D,E)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if

if a <> 0 then
	vi_dw_lista.Object.filtro2.Text = filtro_clientes(A)
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "
END IF
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)



end event

type gb_borde from w_filtra_reportes_fec`gb_borde within w_filtra_reportes_fec_cli
int Y=272
end type

type st_3 from w_filtra_reportes_fec`st_3 within w_filtra_reportes_fec_cli
boolean BringToTop=true
end type

type st_4 from w_filtra_reportes_fec`st_4 within w_filtra_reportes_fec_cli
boolean BringToTop=true
end type

type v_fech_fin from w_filtra_reportes_fec`v_fech_fin within w_filtra_reportes_fec_cli
boolean BringToTop=true
end type

type v_fech_ini from w_filtra_reportes_fec`v_fech_ini within w_filtra_reportes_fec_cli
boolean BringToTop=true
end type

type cdw_param_1 from datawindow within w_filtra_reportes_fec_cli
int X=27
int Y=156
int Width=1586
int Height=80
int TabOrder=30
boolean BringToTop=true
string DataObject="dw_param_clientes"
boolean Border=false
boolean LiveScroll=true
end type


$PBExportHeader$w_filtra_reportes_fec_cli_nofac.srw
forward
global type w_filtra_reportes_fec_cli_nofac from w_filtra_reportes_fec_cli
end type
type cdw_param_2 from datawindow within w_filtra_reportes_fec_cli_nofac
end type
end forward

global type w_filtra_reportes_fec_cli_nofac from w_filtra_reportes_fec_cli
int Width=1646
int Height=720
cdw_param_2 cdw_param_2
end type
global w_filtra_reportes_fec_cli_nofac w_filtra_reportes_fec_cli_nofac

event open;call super::open;cdw_param_2.SetTransObject(sqlca)
DataWindowChild cdw_Fac
cdw_param_2.GetChild("nro_factura", cdw_Fac)
cdw_Fac.SetTransObject(SQLCA)
cdw_Fac.retrieve(0)
if cdw_Fac.rowcount() = 0 then
	cdw_Fac.InsertRow(0)
end if
cdw_param_2.insertrow(0)



end event

on w_filtra_reportes_fec_cli_nofac.create
int iCurrent
call super::create
this.cdw_param_2=create cdw_param_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cdw_param_2
end on

on w_filtra_reportes_fec_cli_nofac.destroy
call super::destroy
destroy(this.cdw_param_2)
end on

type pb_close from w_filtra_reportes_fec_cli`pb_close within w_filtra_reportes_fec_cli_nofac
int Y=424
int TabOrder=60
end type

type pb_ok from w_filtra_reportes_fec_cli`pb_ok within w_filtra_reportes_fec_cli_nofac
int Y=424
int TabOrder=50
end type

event pb_ok::clicked;long cant_filas
long A,B
Date C,D
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

cant_filas = vi_dw_lista.retrieve(A,B,C,D)
if cant_filas = 0 then		
	messageBox("AVISO","NO EXISTEN DATOS PARA EL RANGO DEFINIDO")
end if

if A <> 0 then
	vi_dw_lista.Object.filtro1.Text = filtro_clientes(A)
ELSE
	vi_dw_lista.Object.filtro1.Text = "Todos "
END IF
if B <> 0 then
	vi_dw_lista.Object.filtro2.Text = string(B)
ELSE
	vi_dw_lista.Object.filtro2.Text = "Todos "
END IF

vi_dw_lista.Object.filtro3.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro4.Text = trim(v_Fech_fin.text)



end event

type gb_borde from w_filtra_reportes_fec_cli`gb_borde within w_filtra_reportes_fec_cli_nofac
int Y=352
end type

type st_3 from w_filtra_reportes_fec_cli`st_3 within w_filtra_reportes_fec_cli_nofac
boolean BringToTop=true
end type

type st_4 from w_filtra_reportes_fec_cli`st_4 within w_filtra_reportes_fec_cli_nofac
boolean BringToTop=true
end type

type v_fech_fin from w_filtra_reportes_fec_cli`v_fech_fin within w_filtra_reportes_fec_cli_nofac
boolean BringToTop=true
end type

type v_fech_ini from w_filtra_reportes_fec_cli`v_fech_ini within w_filtra_reportes_fec_cli_nofac
boolean BringToTop=true
end type

type cdw_param_1 from w_filtra_reportes_fec_cli`cdw_param_1 within w_filtra_reportes_fec_cli_nofac
boolean BringToTop=true
end type

event cdw_param_1::itemchanged;call super::itemchanged;string valor
valor = this.Gettext()

// Carga parametro Nro Fac*****
DataWindowChild cdw_Fac
cdw_param_2.GetChild("nro_factura", cdw_Fac)
cdw_Fac.SetTransObject(SQLCA)
cdw_Fac.retrieve(long(valor))
if cdw_Fac.rowcount() = 0 then
	cdw_Fac.InsertRow(0)
end if

end event

type cdw_param_2 from datawindow within w_filtra_reportes_fec_cli_nofac
int X=32
int Y=244
int Width=1586
int Height=80
int TabOrder=40
boolean BringToTop=true
string DataObject="dw_param_facturas"
boolean Border=false
boolean LiveScroll=true
end type


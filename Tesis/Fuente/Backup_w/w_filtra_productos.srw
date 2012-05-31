$PBExportHeader$w_filtra_productos.srw
forward
global type w_filtra_productos from w_filtra_reportes_pro_fec
end type
type cbx_1 from checkbox within w_filtra_productos
end type
end forward

global type w_filtra_productos from w_filtra_reportes_pro_fec
integer width = 2574
integer height = 812
cbx_1 cbx_1
end type
global w_filtra_productos w_filtra_productos

on w_filtra_productos.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_filtra_productos.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;	vi_dw_lista.dataobject = "dw_lista_seguimiento_costo_new"
	vi_dw_lista.settransobject(vg_server5)
	vi_dw_lista.Modify("datawindow.print.Preview=Yes")
	vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end event

type pb_close from w_filtra_reportes_pro_fec`pb_close within w_filtra_productos
integer x = 1326
integer y = 532
integer taborder = 50
end type

type pb_ok from w_filtra_reportes_pro_fec`pb_ok within w_filtra_productos
integer x = 933
integer y = 532
integer taborder = 40
end type

event pb_ok::clicked;dw_filtro.accepttext() 
long A,B,C
DATEtime ld_fecha_ini, ld_fecha_fin

if cbx_1.checked=true then
	vi_dw_lista.dataobject = "dw_lista_seguimiento_costo"
	vi_dw_lista.settransobject(vg_server_repl)
	vi_dw_lista.Modify("datawindow.print.Preview=Yes")
	vi_dw_lista.object.datawindow.print.preview.rulers = 'yes'
end if

ld_fecha_ini = Datetime(date(v_Fech_ini.text))
If isnull(v_Fech_ini.text) or v_Fech_ini.text = "" then setnull(ld_fecha_ini)
ld_fecha_fin = Datetime(date(v_Fech_fin.text))
If isnull(v_Fech_fin.text) or v_Fech_fin.text = "" then setnull(ld_fecha_fin)

vg_param_1a = dw_filtro.Getitemstring(1,1)

IF ISNULL(vg_param_1a) THEN
	vg_param_1a =''
END IF
IF ISNULL(vg_param_1b) THEN
	vg_param_1b=''
END IF

long cant_filas
cant_filas = vi_dw_lista.retrieve(vg_param_1a,1,ld_fecha_ini,ld_fecha_fin)
if cant_filas = 0 then		
	messageBox("Aviso...","No existen datos para el rango definido...")
end if

if vg_param_1a <> '' then
	vi_dw_lista.Object.filtro1a.Text = filtro_producto(vg_param_1a)
ELSE
	vi_dw_lista.Object.filtro1a.Text = "Todos "
END IF

vi_dw_lista.Object.filtro4.Text = trim(v_Fech_ini.text)
vi_dw_lista.Object.filtro5.Text = trim(v_Fech_fin.text)
end event

type gb_borde from w_filtra_reportes_pro_fec`gb_borde within w_filtra_productos
integer x = 901
integer y = 476
integer height = 192
end type

type st_2 from w_filtra_reportes_pro_fec`st_2 within w_filtra_productos
integer x = 82
integer y = 76
end type

type dw_busca from w_filtra_reportes_pro_fec`dw_busca within w_filtra_productos
integer taborder = 60
end type

type dw_filtro from w_filtra_reportes_pro_fec`dw_filtro within w_filtra_productos
integer x = 69
integer y = 112
integer height = 160
integer taborder = 10
string dataobject = "dw_filtra_productos_sc"
end type

event dw_filtro::ue_tecla_pulsada;if keydown(keyf3!) then 
	dw_filtro.accepttext()
	guo_func.of_find_cdw (dw_filtro )
	
end if


end event

event dw_filtro::itemchanged;guo_func.of_find_descrip ( dw_filtro, dw_busca)
/*
vi_data = data
vi_columna = this.getcolumn()
this.PostEvent("ue_modificar")

*/
end event

type st_3 from w_filtra_reportes_pro_fec`st_3 within w_filtra_productos
integer x = 494
integer y = 240
end type

type st_4 from w_filtra_reportes_pro_fec`st_4 within w_filtra_productos
integer x = 1294
integer y = 240
end type

type v_fech_fin from w_filtra_reportes_pro_fec`v_fech_fin within w_filtra_productos
integer x = 1664
integer y = 240
integer taborder = 30
end type

type v_fech_ini from w_filtra_reportes_pro_fec`v_fech_ini within w_filtra_productos
integer x = 859
integer y = 240
integer taborder = 20
end type

type cbx_1 from checkbox within w_filtra_productos
integer x = 805
integer y = 384
integer width = 768
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Informe tipo 2"
end type


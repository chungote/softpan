$PBExportHeader$w_fr_general.srw
forward
global type w_fr_general from w_modelo_filtro
end type
type st_3 from statictext within w_fr_general
end type
type v_fi1 from editmask within w_fr_general
end type
type st_4 from statictext within w_fr_general
end type
type v_ff1 from editmask within w_fr_general
end type
type st_5 from statictext within w_fr_general
end type
type v_fi2 from editmask within w_fr_general
end type
type st_6 from statictext within w_fr_general
end type
type v_ff2 from editmask within w_fr_general
end type
type st_7 from statictext within w_fr_general
end type
type v_fi3 from editmask within w_fr_general
end type
type st_8 from statictext within w_fr_general
end type
type v_ff3 from editmask within w_fr_general
end type
type st_9 from statictext within w_fr_general
end type
type st_10 from statictext within w_fr_general
end type
type v_ff4 from editmask within w_fr_general
end type
type v_fi4 from editmask within w_fr_general
end type
type dw_suc1 from uo_datawindow within w_fr_general
end type
type dw_busca from uo_datawindow within w_fr_general
end type
type dw_suc2 from uo_datawindow within w_fr_general
end type
type st_12 from statictext within w_fr_general
end type
type st_13 from statictext within w_fr_general
end type
type dw_dep1 from uo_datawindow within w_fr_general
end type
type st_14 from statictext within w_fr_general
end type
type dw_dep2 from uo_datawindow within w_fr_general
end type
type st_15 from statictext within w_fr_general
end type
type pb_1 from uo_boton within w_fr_general
end type
type dw_provee from uo_datawindow within w_fr_general
end type
type st_16 from statictext within w_fr_general
end type
type gb_1 from groupbox within w_fr_general
end type
type rb_1 from radiobutton within w_fr_general
end type
type rb_2 from radiobutton within w_fr_general
end type
type rb_3 from radiobutton within w_fr_general
end type
type rb_4 from radiobutton within w_fr_general
end type
type rb_5 from radiobutton within w_fr_general
end type
type st_17 from statictext within w_fr_general
end type
type dw_tip_doc from uo_datawindow within w_fr_general
end type
type dw_comp_cond from uo_datawindow within w_fr_general
end type
type st_18 from statictext within w_fr_general
end type
type st_19 from statictext within w_fr_general
end type
type dw_plazo from uo_datawindow within w_fr_general
end type
type dw_moneda from uo_datawindow within w_fr_general
end type
type dw_comprador from uo_datawindow within w_fr_general
end type
type st_20 from statictext within w_fr_general
end type
type dw_mot_ajuste from uo_datawindow within w_fr_general
end type
type st_121 from statictext within w_fr_general
end type
type dw_clientes from uo_datawindow within w_fr_general
end type
type st_30 from statictext within w_fr_general
end type
type dw_clientes_cate from datawindow within w_fr_general
end type
type st_61 from statictext within w_fr_general
end type
type dw_ciudad from uo_datawindow within w_fr_general
end type
type st_60 from statictext within w_fr_general
end type
type dw_pais from uo_datawindow within w_fr_general
end type
end forward

global type w_fr_general from w_modelo_filtro
int X=110
int Y=188
int Width=3429
int Height=1704
long BackColor=12632256
event ue_argumentos ( )
event ue_arg_produc ( )
st_3 st_3
v_fi1 v_fi1
st_4 st_4
v_ff1 v_ff1
st_5 st_5
v_fi2 v_fi2
st_6 st_6
v_ff2 v_ff2
st_7 st_7
v_fi3 v_fi3
st_8 st_8
v_ff3 v_ff3
st_9 st_9
st_10 st_10
v_ff4 v_ff4
v_fi4 v_fi4
dw_suc1 dw_suc1
dw_busca dw_busca
dw_suc2 dw_suc2
st_12 st_12
st_13 st_13
dw_dep1 dw_dep1
st_14 st_14
dw_dep2 dw_dep2
st_15 st_15
pb_1 pb_1
dw_provee dw_provee
st_16 st_16
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
st_17 st_17
dw_tip_doc dw_tip_doc
dw_comp_cond dw_comp_cond
st_18 st_18
st_19 st_19
dw_plazo dw_plazo
dw_moneda dw_moneda
dw_comprador dw_comprador
st_20 st_20
dw_mot_ajuste dw_mot_ajuste
st_121 st_121
dw_clientes dw_clientes
st_30 st_30
dw_clientes_cate dw_clientes_cate
st_61 st_61
dw_ciudad dw_ciudad
st_60 st_60
dw_pais dw_pais
end type
global w_fr_general w_fr_general

type variables
long vi_suc1
long vi_suc2
long vi_dep1
long vi_dep2
long vi_prov
long vi_tip_doc
long vi_comp_cond
long vi_plazo
long vi_moneda
long vi_comprador
long vi_mot_ajus
long vi_cliente
long vi_cliente_cate

date vi_fi1
date vi_ff1
date vi_fi2
date vi_ff2
date vi_fi3
date vi_ff3
datetime vi_fi4
datetime vi_ff4

string vi_suc_text1
string vi_suc_text2
string vi_dep_text1
string vi_dep_text2
string vi_prov_text
string vi_tip_doc_text
string vi_comp_cond_text
string vi_plazo_text
string vi_comprador_text
string vi_mot_ajus_text
string vi_cliente_text
string vi_cliente_cate_text
string vi_pais
string vi_ciudad


end variables

event ue_argumentos;vi_dep1 = dw_dep1.Getitemnumber(1,1)
if isnull(vi_dep1) then vi_dep1 = 0
vi_dep2 = dw_dep2.Getitemnumber(1,1)
if isnull(vi_dep2) then vi_dep2 = 0

vi_suc1 = dw_suc1.Getitemnumber(1,1)
if isnull(vi_suc1) then vi_suc1 = 0
vi_suc2 = dw_suc2.Getitemnumber(1,1)
if isnull(vi_suc2) then vi_suc2 = 0

vi_prov = dw_provee.Getitemnumber(1,1)
if isnull(vi_prov) then vi_prov = 0

vi_tip_doc = dw_tip_doc.Getitemnumber(1,1)
if isnull(vi_tip_doc) then vi_tip_doc = 0

vi_comp_cond = dw_comp_cond.Getitemnumber(1,1)
if isnull(vi_comp_cond) then vi_comp_cond = 0

vi_plazo = dw_plazo.Getitemnumber(1,1)
if isnull(vi_plazo) then vi_plazo = 0

vi_moneda = dw_moneda.Getitemnumber(1,1)
if isnull(vi_moneda) then vi_moneda = 0

vi_comprador = dw_comprador.Getitemnumber(1,1)
if isnull(vi_comprador) then vi_comprador = 0

vi_mot_ajus = dw_mot_ajuste.Getitemnumber(1,1)
if isnull(vi_mot_ajus) then vi_mot_ajus = 0

vi_cliente = dw_clientes.Getitemnumber(1,1)
if isnull(vi_cliente) then vi_cliente = 0
vi_cliente_cate = dw_clientes_cate.Getitemnumber(1,1)
if isnull(vi_cliente_cate) then vi_cliente_cate = 0

vi_pais = dw_pais.Getitemstring(1,1) 
if isnull(vi_pais) then vi_pais = ''
vi_ciudad =  dw_ciudad.Getitemstring(1,1) 
if isnull(vi_ciudad) then vi_ciudad = ''

DATE A, B, v_fvi, v_fvf, v_ffi, v_fff
datetime v_fai, v_faf
setnull(vi_fi1)
setnull(vi_ff1)
setnull(vi_fi2)
setnull(vi_ff2)
setnull(vi_fi3)
setnull(vi_ff3)
setnull(vi_fi4)
setnull(vi_ff4)
if isdate(v_fi1.text) then vi_fi1 = Date(v_fi1.text)
if isdate(v_ff1.text) then vi_ff1 = Date(v_ff1.text)
if isdate(v_fi2.text) then vi_fi2 = Date(v_fi2.text)
if isdate(v_ff2.text) then vi_ff2 = Date(v_ff2.text)
if isdate(v_fi3.text) then vi_fi3 = Date(v_fi3.text)
if isdate(v_ff3.text) then vi_ff3 = Date(v_ff3.text)
if isdate(left(v_fi4.text,8)) then vi_fi4 = Datetime( date(left(v_fi4.text, 8)) , time(right(v_fi4.text, 5)) )
if isdate(left(v_ff4.text,8)) then vi_ff4 = Datetime( date(left(v_ff4.text, 8)) , time(right(v_ff4.text, 5)) )

if vi_dep1 <> 0 then
	vi_dep_text1 = filtro_depositos(vi_dep1)
ELSE
	vi_dep_text1 = "Todos "
END IF
if vi_dep2 <> 0 then
	vi_dep_text2 = filtro_depositos(vi_dep2)
ELSE
	vi_dep_text2 = "Todos "
END IF

if vi_suc1 <> 0 then
	vi_suc_text1 = filtro_sucursales(vi_suc1)
ELSE
	vi_suc_text1 = "Todos "
END IF
if vi_suc2 <> 0 then
	vi_suc_text2 = filtro_sucursales(vi_suc2)
ELSE
	vi_suc_text2 = "Todos "
END IF

if vi_prov <> 0 then
	vi_prov_text = filtro_proveedores(vi_prov)
ELSE
	vi_prov_text = "Todos "
END IF

if vi_tip_doc <> 0 then
	vi_tip_doc_text = filtro_tipo_doc(vi_tip_doc)
ELSE
	vi_tip_doc_text = "Todos "
END IF

if vi_comp_cond <> 0 then
	vi_comp_cond_text = filtro_comp_cond(vi_comp_cond)
ELSE
	vi_comp_cond_text = "Todos "
END IF

if vi_plazo <> 0 then
	vi_plazo_text = filtro_plazo(vi_plazo)
ELSE
	vi_plazo_text = "Todos "
END IF

if vi_comprador <> 0 then
	vi_comprador_text = filtro_comprador(vi_comprador)
ELSE
	vi_comprador_text = "Todos "
END IF

if vi_mot_ajus <> 0 then
	vi_mot_ajus_text = filtro_comprador(vi_mot_ajus)
ELSE
	vi_mot_ajus_text = "Todos "
END IF

if vi_cliente_cate <> 0 then
	vi_cliente_cate_text = filtro_clientes_cate(vi_cliente_cate) 
ELSE
	vi_cliente_cate_text = "Todos "
END IF



end event

event ue_arg_produc;if vg_param_1a <> '' then
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

on w_fr_general.create
int iCurrent
call super::create
this.st_3=create st_3
this.v_fi1=create v_fi1
this.st_4=create st_4
this.v_ff1=create v_ff1
this.st_5=create st_5
this.v_fi2=create v_fi2
this.st_6=create st_6
this.v_ff2=create v_ff2
this.st_7=create st_7
this.v_fi3=create v_fi3
this.st_8=create st_8
this.v_ff3=create v_ff3
this.st_9=create st_9
this.st_10=create st_10
this.v_ff4=create v_ff4
this.v_fi4=create v_fi4
this.dw_suc1=create dw_suc1
this.dw_busca=create dw_busca
this.dw_suc2=create dw_suc2
this.st_12=create st_12
this.st_13=create st_13
this.dw_dep1=create dw_dep1
this.st_14=create st_14
this.dw_dep2=create dw_dep2
this.st_15=create st_15
this.pb_1=create pb_1
this.dw_provee=create dw_provee
this.st_16=create st_16
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.st_17=create st_17
this.dw_tip_doc=create dw_tip_doc
this.dw_comp_cond=create dw_comp_cond
this.st_18=create st_18
this.st_19=create st_19
this.dw_plazo=create dw_plazo
this.dw_moneda=create dw_moneda
this.dw_comprador=create dw_comprador
this.st_20=create st_20
this.dw_mot_ajuste=create dw_mot_ajuste
this.st_121=create st_121
this.dw_clientes=create dw_clientes
this.st_30=create st_30
this.dw_clientes_cate=create dw_clientes_cate
this.st_61=create st_61
this.dw_ciudad=create dw_ciudad
this.st_60=create st_60
this.dw_pais=create dw_pais
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.v_fi1
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.v_ff1
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.v_fi2
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.v_ff2
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.v_fi3
this.Control[iCurrent+11]=this.st_8
this.Control[iCurrent+12]=this.v_ff3
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.st_10
this.Control[iCurrent+15]=this.v_ff4
this.Control[iCurrent+16]=this.v_fi4
this.Control[iCurrent+17]=this.dw_suc1
this.Control[iCurrent+18]=this.dw_busca
this.Control[iCurrent+19]=this.dw_suc2
this.Control[iCurrent+20]=this.st_12
this.Control[iCurrent+21]=this.st_13
this.Control[iCurrent+22]=this.dw_dep1
this.Control[iCurrent+23]=this.st_14
this.Control[iCurrent+24]=this.dw_dep2
this.Control[iCurrent+25]=this.st_15
this.Control[iCurrent+26]=this.pb_1
this.Control[iCurrent+27]=this.dw_provee
this.Control[iCurrent+28]=this.st_16
this.Control[iCurrent+29]=this.gb_1
this.Control[iCurrent+30]=this.rb_1
this.Control[iCurrent+31]=this.rb_2
this.Control[iCurrent+32]=this.rb_3
this.Control[iCurrent+33]=this.rb_4
this.Control[iCurrent+34]=this.rb_5
this.Control[iCurrent+35]=this.st_17
this.Control[iCurrent+36]=this.dw_tip_doc
this.Control[iCurrent+37]=this.dw_comp_cond
this.Control[iCurrent+38]=this.st_18
this.Control[iCurrent+39]=this.st_19
this.Control[iCurrent+40]=this.dw_plazo
this.Control[iCurrent+41]=this.dw_moneda
this.Control[iCurrent+42]=this.dw_comprador
this.Control[iCurrent+43]=this.st_20
this.Control[iCurrent+44]=this.dw_mot_ajuste
this.Control[iCurrent+45]=this.st_121
this.Control[iCurrent+46]=this.dw_clientes
this.Control[iCurrent+47]=this.st_30
this.Control[iCurrent+48]=this.dw_clientes_cate
this.Control[iCurrent+49]=this.st_61
this.Control[iCurrent+50]=this.dw_ciudad
this.Control[iCurrent+51]=this.st_60
this.Control[iCurrent+52]=this.dw_pais
end on

on w_fr_general.destroy
call super::destroy
destroy(this.st_3)
destroy(this.v_fi1)
destroy(this.st_4)
destroy(this.v_ff1)
destroy(this.st_5)
destroy(this.v_fi2)
destroy(this.st_6)
destroy(this.v_ff2)
destroy(this.st_7)
destroy(this.v_fi3)
destroy(this.st_8)
destroy(this.v_ff3)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.v_ff4)
destroy(this.v_fi4)
destroy(this.dw_suc1)
destroy(this.dw_busca)
destroy(this.dw_suc2)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.dw_dep1)
destroy(this.st_14)
destroy(this.dw_dep2)
destroy(this.st_15)
destroy(this.pb_1)
destroy(this.dw_provee)
destroy(this.st_16)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.st_17)
destroy(this.dw_tip_doc)
destroy(this.dw_comp_cond)
destroy(this.st_18)
destroy(this.st_19)
destroy(this.dw_plazo)
destroy(this.dw_moneda)
destroy(this.dw_comprador)
destroy(this.st_20)
destroy(this.dw_mot_ajuste)
destroy(this.st_121)
destroy(this.dw_clientes)
destroy(this.st_30)
destroy(this.dw_clientes_cate)
destroy(this.st_61)
destroy(this.dw_ciudad)
destroy(this.st_60)
destroy(this.dw_pais)
end on

event open;call super::open;dw_suc1.SetTransObject(sqlca)
dw_suc1.insertrow(0)
dw_suc2.SetTransObject(sqlca)
dw_suc2.insertrow(0)

if gl_sucursal <> 0 then
	dw_suc1.setcolumn(1)
	dw_suc1.settext(string(gl_sucursal))
	dw_suc1.accepttext()
	dw_suc1.enabled = false
	dw_suc2.setcolumn(1)
	dw_suc2.settext(string(gl_sucursal))
	dw_suc2.accepttext()
	dw_suc2.enabled = false
end if

dw_dep1.SetTransObject(sqlca)
dw_dep1.insertrow(0)
dw_dep2.SetTransObject(sqlca)
dw_dep2.insertrow(0)

dw_provee.SetTransObject(sqlca)
dw_provee.insertrow(0)
dw_tip_doc.SetTransObject(sqlca)
dw_tip_doc.insertrow(0)
dw_comp_cond.SetTransObject(sqlca)
dw_comp_cond.insertrow(0)
dw_plazo.SetTransObject(sqlca)
dw_plazo.insertrow(0)
dw_moneda.SetTransObject(sqlca)
dw_moneda.insertrow(0)
dw_comprador.SetTransObject(sqlca)
dw_comprador.insertrow(0)

dw_mot_ajuste.SetTransObject(sqlca)
dw_mot_ajuste.insertrow(0)

dw_clientes.SetTransObject(sqlca)
dw_clientes.insertrow(0)
dw_clientes_cate.SetTransObject(sqlca)
dw_clientes_cate.insertrow(0)

dw_pais.SetTransObject(sqlca)
dw_pais.insertrow(0)
dw_ciudad.SetTransObject(sqlca)
dw_ciudad.insertrow(0)

if isdate(string(vi_dw_lista.vi_argumentos[29])) then v_fi1.text = string(vi_dw_lista.vi_argumentos[29])
if isdate(string(vi_dw_lista.vi_argumentos[30])) then v_ff1.text = string(vi_dw_lista.vi_argumentos[30])
if isdate(string(vi_dw_lista.vi_argumentos[31])) then v_fi2.text = string(vi_dw_lista.vi_argumentos[31])
if isdate(string(vi_dw_lista.vi_argumentos[32])) then v_ff2.text = string(vi_dw_lista.vi_argumentos[32])
if isdate(string(vi_dw_lista.vi_argumentos[33])) then v_fi3.text = string(vi_dw_lista.vi_argumentos[33])
if isdate(string(vi_dw_lista.vi_argumentos[34])) then v_ff3.text = string(vi_dw_lista.vi_argumentos[34])
if isdate(string(vi_dw_lista.vi_argumentos[35])) then v_fi4.text = string(vi_dw_lista.vi_argumentos[35])
if isdate(string(vi_dw_lista.vi_argumentos[36])) then v_ff4.text = string(vi_dw_lista.vi_argumentos[36])


dw_dep1.setitem(1,1, vi_dw_lista.vi_argumentos[37] )
dw_dep1.setitem(1,2, vi_dw_lista.vi_argumentos[38] ) 
dw_dep2.setitem(1,1, vi_dw_lista.vi_argumentos[39])
dw_dep2.setitem(1,2, vi_dw_lista.vi_argumentos[40]) 
dw_suc1.setitem(1,1, vi_dw_lista.vi_argumentos[41])
dw_suc1.setitem(1,2, vi_dw_lista.vi_argumentos[42]) 
dw_suc2.setitem(1,1, vi_dw_lista.vi_argumentos[43])
dw_suc2.setitem(1,2, vi_dw_lista.vi_argumentos[44]) 

dw_provee.setitem(1,1,vi_dw_lista.vi_argumentos[45])
dw_provee.setitem(1,2,vi_dw_lista.vi_argumentos[46]) 

CHOOSE CASE ClassName(vi_dw_lista.vi_argumentos[47])
CASE "boolean"
	rb_1.checked = vi_dw_lista.vi_argumentos[47] 
	rb_2.checked = vi_dw_lista.vi_argumentos[48] 
	rb_3.checked = vi_dw_lista.vi_argumentos[49]
	rb_4.checked = vi_dw_lista.vi_argumentos[50]
	rb_5.checked = vi_dw_lista.vi_argumentos[51]
END CHOOSE

dw_tip_doc.setitem(1,1,vi_dw_lista.vi_argumentos[52])
dw_tip_doc.setitem(1,2,vi_dw_lista.vi_argumentos[53]) 

dw_comp_cond.setitem(1,1,vi_dw_lista.vi_argumentos[54])
dw_comp_cond.setitem(1,2,vi_dw_lista.vi_argumentos[55]) 

dw_plazo.setitem(1,1,vi_dw_lista.vi_argumentos[56])
dw_plazo.setitem(1,2,vi_dw_lista.vi_argumentos[57]) 

dw_moneda.setitem(1,1,vi_dw_lista.vi_argumentos[58])

dw_comprador.setitem(1,1,vi_dw_lista.vi_argumentos[59])
dw_comprador.setitem(1,2,vi_dw_lista.vi_argumentos[60]) 

dw_mot_ajuste.setitem(1,1,vi_dw_lista.vi_argumentos[61])
dw_mot_ajuste.setitem(1,2,vi_dw_lista.vi_argumentos[62]) 

dw_clientes.setitem(1,1,vi_dw_lista.vi_argumentos[63])
dw_clientes.setitem(1,2,vi_dw_lista.vi_argumentos[64]) 
dw_clientes_cate.setitem(1,1,vi_dw_lista.vi_argumentos[65])

dw_pais.setitem(1,1,vi_dw_lista.vi_argumentos[66])
dw_ciudad.setitem(1,1,vi_dw_lista.vi_argumentos[67])




end event

event close;call super::close;vi_dw_lista.vi_argumentos[29] = v_fi1.text 
vi_dw_lista.vi_argumentos[30] = v_ff1.text 
vi_dw_lista.vi_argumentos[31] = v_fi2.text 
vi_dw_lista.vi_argumentos[32] = v_ff2.text 
vi_dw_lista.vi_argumentos[33] = v_fi3.text 
vi_dw_lista.vi_argumentos[34] = v_ff3.text 
vi_dw_lista.vi_argumentos[35] = v_fi4.text 
vi_dw_lista.vi_argumentos[36] = v_ff4.text 

vi_dw_lista.vi_argumentos[37] = dw_dep1.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[38] = dw_dep1.Getitemstring(1,2) 
vi_dw_lista.vi_argumentos[39] = dw_dep2.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[40] = dw_dep2.Getitemstring(1,2) 
vi_dw_lista.vi_argumentos[41] = dw_suc1.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[42] = dw_suc1.Getitemstring(1,2) 
vi_dw_lista.vi_argumentos[43] = dw_suc2.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[44] = dw_suc2.Getitemstring(1,2) 

vi_dw_lista.vi_argumentos[45] = dw_provee.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[46] = dw_provee.Getitemstring(1,2) 

vi_dw_lista.vi_argumentos[47] = rb_1.checked
vi_dw_lista.vi_argumentos[48] = rb_2.checked
vi_dw_lista.vi_argumentos[49] = rb_3.checked
vi_dw_lista.vi_argumentos[50] = rb_4.checked
vi_dw_lista.vi_argumentos[51] = rb_5.checked

vi_dw_lista.vi_argumentos[52] = dw_tip_doc.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[53] = dw_tip_doc.Getitemstring(1,2) 

vi_dw_lista.vi_argumentos[54] = dw_comp_cond.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[55] = dw_comp_cond.Getitemstring(1,2) 

vi_dw_lista.vi_argumentos[56] = dw_plazo.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[57] = dw_plazo.Getitemstring(1,2) 

vi_dw_lista.vi_argumentos[58] = dw_moneda.Getitemnumber(1,1)

vi_dw_lista.vi_argumentos[59] = dw_comprador.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[60] = dw_comprador.Getitemstring(1,2) 

vi_dw_lista.vi_argumentos[61] = dw_mot_ajuste.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[62] = dw_mot_ajuste.Getitemstring(1,2) 

vi_dw_lista.vi_argumentos[63] = dw_clientes.Getitemnumber(1,1)
vi_dw_lista.vi_argumentos[64] = dw_clientes.Getitemstring(1,2) 
vi_dw_lista.vi_argumentos[63] = dw_clientes_cate.Getitemnumber(1,1)

vi_dw_lista.vi_argumentos[66] = dw_pais.Getitemstring(1,1) 
vi_dw_lista.vi_argumentos[67] =  dw_ciudad.Getitemstring(1,1) 


end event

event activate;call super::activate;f_centrar_ventana(this)
end event

type pb_close from w_modelo_filtro`pb_close within w_fr_general
int X=2949
int Y=1324
int TabOrder=270
end type

type pb_ok from w_modelo_filtro`pb_ok within w_fr_general
int X=2555
int Y=1324
int TabOrder=220
end type

event pb_ok::clicked;Parent.TriggerEvent("ue_argumentos")

end event

type gb_borde from w_modelo_filtro`gb_borde within w_fr_general
int X=2523
int Y=1252
int TabOrder=0
long BackColor=12632256
end type

type st_3 from statictext within w_fr_general
int X=37
int Y=40
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Desde:"
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

type v_fi1 from editmask within w_fr_general
int X=462
int Y=40
int Width=297
int Height=80
int TabOrder=10
boolean Visible=false
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

type st_4 from statictext within w_fr_general
int X=942
int Y=44
int Width=466
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Hasta:"
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

type v_ff1 from editmask within w_fr_general
int X=1417
int Y=40
int Width=297
int Height=80
int TabOrder=30
boolean Visible=false
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

type st_5 from statictext within w_fr_general
int X=37
int Y=136
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Desde:"
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

type v_fi2 from editmask within w_fr_general
int X=462
int Y=136
int Width=297
int Height=80
int TabOrder=70
boolean Visible=false
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

type st_6 from statictext within w_fr_general
int X=942
int Y=140
int Width=466
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Hasta:"
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

type v_ff2 from editmask within w_fr_general
int X=1417
int Y=136
int Width=297
int Height=80
int TabOrder=100
boolean Visible=false
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

type st_7 from statictext within w_fr_general
int X=37
int Y=236
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Desde:"
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

type v_fi3 from editmask within w_fr_general
int X=462
int Y=236
int Width=297
int Height=80
int TabOrder=110
boolean Visible=false
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

type st_8 from statictext within w_fr_general
int X=942
int Y=240
int Width=466
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Hasta:"
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

type v_ff3 from editmask within w_fr_general
int X=1417
int Y=236
int Width=297
int Height=80
int TabOrder=120
boolean Visible=false
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

type st_9 from statictext within w_fr_general
int X=37
int Y=336
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha hora:"
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

type st_10 from statictext within w_fr_general
int X=942
int Y=336
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Fecha hora:"
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

type v_ff4 from editmask within w_fr_general
int X=1417
int Y=336
int Width=421
int Height=80
int TabOrder=140
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy hh:mm"
MaskDataType MaskDataType=DateTimeMask!
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

type v_fi4 from editmask within w_fr_general
int X=462
int Y=336
int Width=421
int Height=80
int TabOrder=130
boolean Visible=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy hh:mm"
MaskDataType MaskDataType=DateTimeMask!
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

type dw_suc1 from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=444
int Width=1467
int Height=100
int TabOrder=160
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_sucursal"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_suc1)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_suc1, dw_busca)

end event

type dw_busca from uo_datawindow within w_fr_general
int X=5
int Y=0
int Width=142
int Height=100
int TabOrder=150
boolean Visible=false
boolean BringToTop=true
end type

type dw_suc2 from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=540
int Width=1467
int Height=100
int TabOrder=170
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_sucursal"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_suc2)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_suc2, dw_busca)

end event

type st_12 from statictext within w_fr_general
int X=37
int Y=448
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Sucursal:"
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

type st_13 from statictext within w_fr_general
int X=37
int Y=544
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Sucursal:"
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

type dw_dep1 from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=640
int Width=1467
int Height=100
int TabOrder=190
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_deposito"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_dep1)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_dep1, dw_busca)

end event

type st_14 from statictext within w_fr_general
int X=37
int Y=644
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Depósito:"
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

type dw_dep2 from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=752
int Width=1467
int Height=100
int TabOrder=210
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_deposito"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_dep2)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_dep2, dw_busca)

end event

type st_15 from statictext within w_fr_general
int X=37
int Y=756
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Depósito:"
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

type pb_1 from uo_boton within w_fr_general
int X=2725
int Y=1172
int Width=434
int Height=84
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string Text="Filtrar &Familias"
int TextSize=-8
end type

event clicked;call super::clicked;OpenWithParm(w_abm_seleccionar_nivel_reporte, vi_dw_lista )
//OpenWithParm(w_seleccionar_familias, vi_dw_lista )

end event

type dw_provee from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=856
int Width=1467
int Height=100
int TabOrder=230
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_proveedor"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_provee)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_provee, dw_busca)

end event

type st_16 from statictext within w_fr_general
int X=37
int Y=860
int Width=361
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Proveedor:"
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

type gb_1 from groupbox within w_fr_general
int X=2720
int Y=644
int Width=635
int Height=472
int TabOrder=200
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_fr_general
int X=2843
int Y=712
int Width=375
int Height=76
boolean Visible=false
boolean BringToTop=true
string Text="none"
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

type rb_2 from radiobutton within w_fr_general
int X=2843
int Y=784
int Width=375
int Height=76
boolean Visible=false
boolean BringToTop=true
string Text="none"
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

type rb_3 from radiobutton within w_fr_general
int X=2843
int Y=856
int Width=375
int Height=76
boolean Visible=false
boolean BringToTop=true
string Text="none"
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

type rb_4 from radiobutton within w_fr_general
int X=2843
int Y=928
int Width=375
int Height=76
boolean Visible=false
boolean BringToTop=true
string Text="none"
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

type rb_5 from radiobutton within w_fr_general
int X=2843
int Y=996
int Width=375
int Height=76
boolean Visible=false
boolean BringToTop=true
string Text="none"
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

type st_17 from statictext within w_fr_general
int X=37
int Y=960
int Width=389
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Tip. documen.:"
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

type dw_tip_doc from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=956
int Width=1467
int Height=100
int TabOrder=250
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_tipo_doc"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_tip_doc)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_tip_doc, dw_busca)

end event

type dw_comp_cond from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=1060
int Width=1467
int Height=100
int TabOrder=260
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_comp_condi"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_comp_cond)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_comp_cond, dw_busca)

end event

type st_18 from statictext within w_fr_general
int X=37
int Y=1064
int Width=361
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Com. Condic."
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

type st_19 from statictext within w_fr_general
int X=37
int Y=1172
int Width=384
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Plazo:"
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

type dw_plazo from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=434
int Y=1172
int Width=1467
int Height=100
int TabOrder=90
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_plazo"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_plazo)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_plazo, dw_busca)

end event

type dw_moneda from uo_datawindow within w_fr_general
int X=2025
int Y=124
int Width=1019
int Height=100
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_param_monedas"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

type dw_comprador from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=434
int Y=1280
int Width=1467
int Height=100
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_comprador"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_comprador)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_comprador, dw_busca)

end event

type st_20 from statictext within w_fr_general
int X=37
int Y=1284
int Width=384
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Comprador:"
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

type dw_mot_ajuste from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=434
int Y=1388
int Width=1467
int Height=100
int TabOrder=60
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_mot_ajuste"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_mot_ajuste)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_mot_ajuste, dw_busca)

end event

type st_121 from statictext within w_fr_general
int X=37
int Y=1392
int Width=384
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Motivo:"
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

type dw_clientes from uo_datawindow within w_fr_general
event ue_tecla_pulsada pbm_dwnkey
int X=439
int Y=1492
int Width=1467
int Height=100
int TabOrder=240
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_arg_cliente"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_tecla_pulsada;if keydown(keyf3!) then
	guo_func.of_find_cdw (dw_clientes)
end if

end event

event itemchanged;call super::itemchanged;guo_func.of_find_descrip ( dw_clientes, dw_busca)

end event

type st_30 from statictext within w_fr_general
int X=41
int Y=1496
int Width=361
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Cliente:"
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

type dw_clientes_cate from datawindow within w_fr_general
int X=1751
int Y=228
int Width=1586
int Height=80
int TabOrder=80
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_param_categorias_cli"
boolean Border=false
boolean LiveScroll=true
end type

type st_61 from statictext within w_fr_general
int X=2043
int Y=436
int Width=434
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Ciudad proveed.:"
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

type dw_ciudad from uo_datawindow within w_fr_general
int X=2482
int Y=432
int Width=690
int Height=96
int TabOrder=180
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_param_ciudad_proveedor"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

type st_60 from statictext within w_fr_general
int X=2043
int Y=348
int Width=425
int Height=80
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Pais proveedor:"
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

type dw_pais from uo_datawindow within w_fr_general
int X=2473
int Y=340
int Width=690
int Height=96
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_param_pais_proveedor"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type


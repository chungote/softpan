$PBExportHeader$uo_print.sru
forward
global type uo_print from nonvisualobject
end type
end forward

global type uo_print from nonvisualobject
end type
global uo_print uo_print

forward prototypes
public function boolean of_print (string file, datawindow dw1, datawindow dw2)
public function string of_replace_values (string as_linea, long al_row, datawindow adw_dw)
public function string of_ret_field (string as_text)
public function string of_replace_text (string as_text, string as_rep_old, string as_rep_new)
end prototypes

public function boolean of_print (string file, datawindow dw1, datawindow dw2);if dw1.rowcount() = 0 then 
	messagebox('Atención...', 'No existen datos a imprimir...')
	return false
end if
if not FileExists(file) then 
	messagebox('Atención...', 'El archivo ' + file + ' no existe...')
	return false
end if
integer li_file
string ls_line, ls_line_det
long ll_err
li_file = FileOpen(file, LineMode! ,Read!)

if li_file = -1 or isnull(li_file)then 
	messagebox('Atención...', 'El archivo ' + file + ' no se pudo abrir...')
	return false
end if
//~t	Tab
//~r	Carriage return
//~n	Newline or linefeed
//~"	Double quote
//~'	Single quote
//~~	Tilde
long ll_filas_det, ll_row
long ll_contador
long ll_pj
string ls_tipo
ll_pj = PrintOpen()
ll_err = 1
ll_contador = 0
do while ll_err > 0 
	ll_contador = ll_contador + 1
	ll_err = fileread(li_file, ls_line) 
	ls_line = Lower(ls_line)
	if ll_err = 0 or ll_err = -100 then continue
	//messagebox('Atención...', 'El archivo ' + STRING(ls_line) + ' li_file...')
	if ll_err = -1 or isnull(ll_err) then
		messagebox('Atención...', 'El archivo ' + file + ' no se pudo leer...')
		PrintClose(ll_pj)
		fileclose(li_file)		
		return false
	end if
	if ll_contador = 1 then
		ll_filas_det = long(right(ls_line, len(ls_line) - 16))
	end if		
	if ll_contador <= 5 then continue
	ls_tipo = left(ls_line, 2) 
	if left(ls_tipo, 1) <> 'd' then
		ls_line = of_replace_values(ls_line, dw1.rowcount(), dw1)
		PrintSend(ll_pj,ls_line)
		PrintSend(ll_pj,"~n")
		if left(ls_tipo, 2) = 'to' then
			for ll_row = 1 to ll_filas_det - dw1.rowcount()
				PrintSend(ll_pj,"~n")
			next
		end if
	else
		if ls_tipo = 'd1' then
			for ll_row = 1 to dw1.rowcount()
				ls_line_det = of_replace_values(ls_line, ll_row, dw1)
				PrintSend(ll_pj,ls_line_det)
				PrintSend(ll_pj,"~n")
			next
		end if
	end if
loop
PrintClose(ll_pj)
fileclose(li_file)
return true

end function

public function string of_replace_values (string as_linea, long al_row, datawindow adw_dw);string ls_field
string ls_field_value
string ls_spaces
ls_spaces = '                                                                                                                                                                                                        '
//as_linea
//al_row
//ad_dw
as_linea = right(as_linea, len(as_linea) - 3)
ls_field = '  '
do while ls_field <> ''
	ls_field = of_ret_field(as_linea)
	if ls_field = '' then continue

//messagebox('Error', 'Campo ' + right(ls_field, len(ls_field) -5) + ' ') 
	
	ls_field_value = adw_dw.getitemstring(al_row, right(ls_field, len(ls_field) -5) )
	if left(ls_field, 1) = 'r' then
 		ls_field_value = right((ls_spaces + ls_field_value), long( right(left(ls_field, 4),3) ) )
	else
 		ls_field_value = left((ls_field_value + ls_spaces), long( right(left(ls_field, 4),3) ) )
	end if
	ls_field_value = of_replace_text(ls_field_value, '#', ' ')
	ls_field_value = of_replace_text(ls_field_value, '#', ' ')
	ls_field_value = of_replace_text(ls_field_value, '#', ' ')
	ls_field_value = of_replace_text(ls_field_value, ':', ' ')
	ls_field_value = of_replace_text(ls_field_value, ':', ' ')
	ls_field_value = of_replace_text(ls_field_value, ':', ' ')

	as_linea = of_replace_text(as_linea, '#'+ls_field+'#', ls_field_value )
	
loop
return as_linea
end function

public function string of_ret_field (string as_text);long ll_pos
ll_pos = pos(as_text, '#')
if ll_pos = 0 or isnull(ll_pos) then
	return ''
else
	as_text = right(as_text, len(as_text) - ll_pos)
end if

ll_pos = pos(as_text, '#')
if ll_pos = 0 or isnull(ll_pos) then
	return ''
else
	as_text = left(as_text, ll_pos - 1)
end if

return as_text
end function

public function string of_replace_text (string as_text, string as_rep_old, string as_rep_new);if pos(as_text, as_rep_old) = 0 or isnull(pos(as_text, as_rep_old)) then
	return as_text
end if
as_text = replace(as_text, pos(as_text, as_rep_old), len(as_rep_old), as_rep_new)
return as_text
end function

on uo_print.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_print.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


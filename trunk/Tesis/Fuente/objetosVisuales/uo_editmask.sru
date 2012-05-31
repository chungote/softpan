$PBExportHeader$uo_editmask.sru
forward
global type uo_editmask from editmask
end type
end forward

global type uo_editmask from editmask
int Width=247
int Height=100
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global uo_editmask uo_editmask

event getfocus;this.SelectText(1, len(this.text))
end event


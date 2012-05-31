CREATE FUNCTION f_compara_pass(v_pass varchar(12)) RETURNS char(48)
BEGIN
   declare V_pass_conv char(48);
   declare v_strsql varchar(50);
   set V_pass_conv =password(v_pass);
   return V_pass_conv;


END


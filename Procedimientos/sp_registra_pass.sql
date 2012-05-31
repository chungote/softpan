CREATE PROCEDURE sp_registra_pass (v_user varchar(12))
begin

   declare v_pass char(48);

   select user.password into v_pass
   from user
   where user.user=v_user;

   update sys_usuarios
   set contrasenia=v_pass
   where usuario=v_user;


end;

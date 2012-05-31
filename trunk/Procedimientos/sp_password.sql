CREATE PROCEDURE sp_password( old_pass CHAR(41), new_pass CHAR(41), loginame char(16) )
begin
   DECLARE v_status integer;
   DECLARE my_error CONDITION FOR SQLSTATE '45000';

        UPDATE Mysql.user SET
        Mysql.user.Password=PASSWORD(new_pass)
        WHERE Mysql.user.User=loginame
        AND Mysql.user.Password=PASSWORD(old_pass);

        FLUSH PRIVILEGES;

        update sys_usuarios
        set contrasenia= password(new_pass)
        where usuario= loginame
        and contrasenia= password(old_pass);



end
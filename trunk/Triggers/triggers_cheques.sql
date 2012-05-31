DROP TRIGGER tia_cheques
CREATE TRIGGER tia_cheques after insert ON cheques
FOR EACH ROW
BEGIN

 update detalle_chequeras
 set detalle_chequeras.nro_registro =new.nro_registro
 where (select chequeras.nro_cta  from chequeras where chequeras.nro_chequera=detalle_chequeras.nro_chequera limit 1)= new.nro_cta and
       nro_cheque = new.nro_cheque;

end
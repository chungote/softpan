
CREATE TRIGGER [dbo].[tia_habilitaciones_det] ON [dbo].DETALLE_HABILITACIONES WITH encryption FOR insert
AS
declare @v_importe_old numeric(12,2);
declare @v_cod_cobro numeric(12,2);

select @v_cod_cobro=cod_cobro, @v_importe=importe_neto from inserted;

if @v_cod_cobro=1 --efectivo
begin
  
   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 

if @v_cod_cobro=2 --cheque
begin

   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 


if @v_cod_cobro=3 --targeta de credito
begin

   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 


if @v_cod_cobro=4 --nc de venta
begin

   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 



/*********************************tua_habilitaciones_det***************************************************/

CREATE TRIGGER [dbo].[tua_habilitaciones_det] ON [dbo].DETALLE_HABILITACIONES WITH encryption FOR update
AS
declare @v_importe_new numeric(12,2);
declare @v_importe_old numeric(12,2);
declare @v_cod_cobro numeric(12,2);

select @v_cod_cobro=cod_cobro, @v_importe_new=importe_neto from inserted;
select  @v_importe_old=importe_neto from deleted;

if @v_cod_cobro=1 --efectivo
begin
   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo-@v_importe_old
   WHERE nro_habilitacion=(select nro_habilitacion from deleted)

   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe_new
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 

if @v_cod_cobro=2 --cheque
begin
   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo-@v_importe_old
   WHERE nro_habilitacion=(select nro_habilitacion from deleted)

   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe_new
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 


if @v_cod_cobro=3 --targeta de credito
begin
   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo-@v_importe_old
   WHERE nro_habilitacion=(select nro_habilitacion from deleted)

   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe_new
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 


if @v_cod_cobro=4 --nc de venta
begin
   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo-@v_importe_old
   WHERE nro_habilitacion=(select nro_habilitacion from deleted)

   UPDATE [HABILITACIONES]
   SET total_efectivo = total_efectivo+@v_importe_new
   WHERE nro_habilitacion=(select nro_habilitacion from inserted)
end 


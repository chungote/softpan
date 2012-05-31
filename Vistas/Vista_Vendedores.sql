create view v_vendedores
as
select cod_vendedor as cod_vendedor,
ifnull(personas.nombre_fantasia,concat(personas.nombres,' ',personas.apellidos)) AS nombre_vendedor
from vendedores, personas
where vendedores.cod_persona =personas.cod_persona
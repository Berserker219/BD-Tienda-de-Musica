-- FUNCIONES Y VISTAS DE DESENCRIPTACION

--FUNCIONES


-- Funcion de desencriptar del atributo telefono
CREATE OR REPLACE FUNCTION desencriptar_telefono(f_telefono BYTEA)
RETURNS TABLE (
	telefono VARCHAR (10)
) AS $$
BEGIN 
	RETURN QUERY
	SELECT
		pgp_sym_decrypt(f_telefono, 'RA*Fco|,w^');
END;
$$ LANGUAGE plpgsql;

-- Funcion de desencriptar del atributo ruta
CREATE OR REPLACE FUNCTION desencriptar_ruta(f_ruta BYTEA)
RETURNS TABLE (
	ruta VARCHAR(45)
) AS $$
BEGIN 
	RETURN QUERY
	SELECT
		pgp_sym_decrypt(f_ruta, 'e!CND/.tD[');
END;
$$ LANGUAGE plpgsql;


-- Funcion de desencriptar del atributo nombre, apellido_paterno y apellido_materno
CREATE OR REPLACE FUNCTION desencriptar_nombre(f_nombre BYTEA, f_apellido_paterno BYTEA, f_apellido_materno BYTEA) 
RETURNS TABLE (
    nombre TEXT,
    apellido_paterno TEXT,
    apellido_materno TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        pgp_sym_decrypt(f_nombre, 'uCZs~)g\i}'),
        pgp_sym_decrypt(f_apellido_paterno, 'ARv-_@zv3y'),
        pgp_sym_decrypt(f_apellido_materno, 'MqCTb.c05x');
END;
$$ LANGUAGE plpgsql;

-- Funcion de desencriptar del atributo calle, colonia y numero
CREATE OR REPLACE FUNCTION desencriptar_direccion(f_calle BYTEA, f_colonia BYTEA)
RETURNS TABLE (
	calle TEXT,
	colonia TEXT
) AS $$
BEGIN
	RETURN QUERY
	SELECT
		pgp_sym_decrypt(f_calle, '=<T0IzkC;m'),
		pgp_sym_decrypt(f_colonia, 'U>*~6pXwx:');
END;
$$ LANGUAGE plpgsql;



-- VISTAS
-- Vista provedor desencriptar_telefono
CREATE VIEW vista_provedor_desencriptar_telefono AS
SELECT
    id_provedor,
    id_ruta,
    id_direccion,
    id_nombre,
    (SELECT telefono FROM desencriptar_telefono(telefono::BYTEA)) AS telefono
FROM provedor;

-- Vista provedor_ruta desencriptar_ruta
CREATE VIEW vista_provedor_ruta_desencriptar_ruta AS
SELECT
    id_ruta,
    (SELECT ruta FROM desencriptar_ruta(ruta::BYTEA)) AS ruta
FROM provedor_ruta;

-- Vista provedor_nombre desencriptada_nombre
CREATE VIEW vista_provedor_nombre_desencriptada_nombre AS
SELECT
    id_nombre,
    (SELECT nombre FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS nombre,
    (SELECT apellido_paterno FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS apellido_paterno,
    (SELECT apellido_materno FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS apellido_materno
FROM provedor_nombre;

-- Vista provedor_direccion desencriptar_direccion
CREATE VIEW vista_provedor_direccion_desencriptar_direccion AS
SELECT 
    id_direccion,
    (SELECT calle FROM desencriptar_direccion(calle::BYTEA, colonia::BYTEA)) AS calle,
    (SELECT colonia FROM desencriptar_direccion(calle::BYTEA, colonia::BYTEA)) AS colonia,
    numero -- No se necesita desencriptar ya que es un entero
FROM provedor_direccion;

-- Vista cliente desencriptar_telefono
CREATE VIEW vista_cliente_desencriptar_telefono AS
SELECT
    id_cliente,
    id_nombre,
    id_direccion,
    (SELECT telefono FROM desencriptar_telefono(telefono::BYTEA)) AS telefono
FROM cliente;

-- Vista cliente_nombre desencriptar_nombre
CREATE VIEW vista_cliente_nombre_desencriptar_nombre AS 
SELECT
    id_nombre,
    (SELECT nombre FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS nombre,
    (SELECT apellido_paterno FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS apellido_paterno,
    (SELECT apellido_materno FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS apellido_materno
FROM cliente_nombre;

-- Vista cliente_direccion desencriptar_direccion
CREATE VIEW vista_cliente_direccion_desencriptar_direccion AS
SELECT 
    id_direccion,
    (SELECT calle FROM desencriptar_direccion(calle::BYTEA, colonia::BYTEA)) AS calle,
    (SELECT colonia FROM desencriptar_direccion(calle::BYTEA, colonia::BYTEA)) AS colonia,
    numero -- No se necesita desencriptar ya que es un entero
FROM cliente_direccion;

-- Vista empleado desencriptar_telefono
CREATE VIEW vista_empleado_desencriptar_telefono AS
SELECT 
    id_empleado,
    id_nombre,
    id_direccion,
    id_sucursal,
    (SELECT telefono FROM desencriptar_telefono(telefono::BYTEA)) AS telefono
FROM empleado;

-- Vista empleado_nombre desencriptar_nombre
CREATE VIEW vista_empleado_nombre_desencriptar_nombre AS
SELECT 
    id_nombre,
    (SELECT nombre FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS nombre,
    (SELECT apellido_paterno FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS apellido_paterno,
    (SELECT apellido_materno FROM desencriptar_nombre(nombre::BYTEA, apellido_paterno::BYTEA, apellido_materno::BYTEA)) AS apellido_materno
FROM empleado_nombre;

-- Vista empleado_direccion desencriptar_direccion
CREATE VIEW vista_empleado_direcion_desencriptar_direccion AS
SELECT 
    id_direccion,
    (SELECT calle FROM desencriptar_direccion(calle::BYTEA, colonia::BYTEA)) AS calle,
    (SELECT colonia FROM desencriptar_direccion(calle::BYTEA, colonia::BYTEA)) AS colonia,
    numero -- No se necesita desencriptar ya que es un entero
FROM empleado_direccion;


-- VISTAS DE DESENCRIPTACION

-- Vista para desencriptar todos los datos de la tabla proveedor
CREATE OR REPLACE VIEW vista_proveedor_desencriptado AS
SELECT
    id_proveedor,
    pgp_sym_decrypt(nombre, 'uCZs~)g\i}')::VARCHAR AS nombre,
    pgp_sym_decrypt(apellido_paterno, 'ARv-_@zv3y')::VARCHAR AS apellido_paterno,
    pgp_sym_decrypt(apellido_materno, 'MqCTb.c05x')::VARCHAR AS apellido_materno,
    pgp_sym_decrypt(calle, '=<T0IzkC;m')::VARCHAR AS calle,
    pgp_sym_decrypt(colonia, 'U>*~6pXwx:')::VARCHAR AS colonia,
    pgp_sym_decrypt(numero, 'Fpx!fb;9zj')::INTEGER AS numero,
    pgp_sym_decrypt(ruta, 'e!CND/.tD[')::VARCHAR AS ruta,
    pgp_sym_decrypt(telefono, 'RA*Fco|,w^')::VARCHAR(10) AS telefono
FROM proveedor;

-- Vista para desencriptar todos los datos de la tabla cliente
CREATE OR REPLACE VIEW vista_cliente_desencriptado AS
SELECT
    id_cliente,
    pgp_sym_decrypt(nombre, 'uCZs~)g\i}')::VARCHAR AS nombre,
    pgp_sym_decrypt(apellido_paterno, 'ARv-_@zv3y')::VARCHAR AS apellido_paterno,
    pgp_sym_decrypt(apellido_materno, 'MqCTb.c05x')::VARCHAR AS apellido_materno,
    pgp_sym_decrypt(calle, '=<T0IzkC;m')::VARCHAR AS calle,
    pgp_sym_decrypt(colonia, 'U>*~6pXwx:')::VARCHAR AS colonia,
    pgp_sym_decrypt(numero, 'Fpx!fb;9zj')::INTEGER AS numero,
    pgp_sym_decrypt(telefono, 'RA*Fco|,w^')::VARCHAR(10) AS telefono
FROM cliente;

-- Vista para desencriptar todos los datos de la tabla empleado
CREATE OR REPLACE VIEW vista_empleado_desencriptado AS
SELECT
    id_empleado,
    id_sucursal,
    pgp_sym_decrypt(nombre, 'uCZs~)g\i}')::VARCHAR AS nombre,
    pgp_sym_decrypt(apellido_paterno, 'ARv-_@zv3y')::VARCHAR AS apellido_paterno,
    pgp_sym_decrypt(apellido_materno, 'MqCTb.c05x')::VARCHAR AS apellido_materno,
    pgp_sym_decrypt(calle, '=<T0IzkC;m')::VARCHAR AS calle,
    pgp_sym_decrypt(colonia, 'U>*~6pXwx:')::VARCHAR AS colonia,
    pgp_sym_decrypt(numero, 'Fpx!fb;9zj')::INTEGER AS numero,
    pgp_sym_decrypt(telefono, 'RA*Fco|,w^')::VARCHAR(10) AS telefono
FROM empleado;

-- Vista para desencriptar los datos de la tabla sucursal
CREATE OR REPLACE VIEW vista_sucursal_desencriptado AS
SELECT
    id_sucursal,
    nombre,
    pgp_sym_decrypt(calle, '=<T0IzkC;m')::VARCHAR AS calle,
    pgp_sym_decrypt(colonia, 'U>*~6pXwx:')::VARCHAR AS colonia,
    pgp_sym_decrypt(numero, 'Fpx!fb;9zj')::INTEGER AS numero
FROM sucursal;

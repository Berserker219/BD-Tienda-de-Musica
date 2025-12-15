-- FUNCIONES Y TRIGGERS DE ENCRIPTACION
-- Encriptación de atributos por medio de un algortimo de cifrado simetrico

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- FUNCIONES

-- Función de trigger para encriptar los datos de la tabla proveedor
CREATE OR REPLACE FUNCTION trigger_encrypt_proveedor() RETURNS TRIGGER AS $$
BEGIN
    -- Encrypt nombre
    IF NEW.nombre IS NOT NULL THEN NEW.nombre := pgp_sym_encrypt(NEW.nombre::text, 'uCZs~)g\i}'::text); END IF;
    IF NEW.apellido_paterno IS NOT NULL THEN NEW.apellido_paterno := pgp_sym_encrypt(NEW.apellido_paterno::text, 'ARv-_@zv3y'::text); END IF;
    IF NEW.apellido_materno IS NOT NULL THEN NEW.apellido_materno := pgp_sym_encrypt(NEW.apellido_materno::text, 'MqCTb.c05x'::text); END IF;

    -- Encrypt direccion
    IF NEW.calle IS NOT NULL THEN NEW.calle := pgp_sym_encrypt(NEW.calle::text, '=<T0IzkC;m'::text); END IF;
    IF NEW.colonia IS NOT NULL THEN NEW.colonia := pgp_sym_encrypt(NEW.colonia::text, 'U>*~6pXwx:'::text); END IF;
    IF NEW.numero IS NOT NULL THEN NEW.numero := pgp_sym_encrypt(NEW.numero::text, 'Fpx!fb;9zj'::text); END IF;

    -- Encrypt ruta
    IF NEW.ruta IS NOT NULL THEN NEW.ruta := pgp_sym_encrypt(NEW.ruta::text, 'e!CND/.tD['::text); END IF;

    -- Encrypt telefono
    IF NEW.telefono IS NOT NULL THEN
        IF LENGTH(NEW.telefono::text) != 10 THEN RAISE EXCEPTION 'El número de teléfono debe tener 10 dígitos'; END IF;
        NEW.telefono := pgp_sym_encrypt(NEW.telefono::text, 'RA*Fco|,w^'::text);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Función de trigger para encriptar los datos de la tabla cliente
CREATE OR REPLACE FUNCTION trigger_encrypt_cliente() RETURNS TRIGGER AS $$
BEGIN
    -- Encrypt nombre
    IF NEW.nombre IS NOT NULL THEN NEW.nombre := pgp_sym_encrypt(NEW.nombre::text, 'uCZs~)g\i}'::text); END IF;
    IF NEW.apellido_paterno IS NOT NULL THEN NEW.apellido_paterno := pgp_sym_encrypt(NEW.apellido_paterno::text, 'ARv-_@zv3y'::text); END IF;
    IF NEW.apellido_materno IS NOT NULL THEN NEW.apellido_materno := pgp_sym_encrypt(NEW.apellido_materno::text, 'MqCTb.c05x'::text); END IF;

    -- Encrypt direccion
    IF NEW.calle IS NOT NULL THEN NEW.calle := pgp_sym_encrypt(NEW.calle::text, '=<T0IzkC;m'::text); END IF;
    IF NEW.colonia IS NOT NULL THEN NEW.colonia := pgp_sym_encrypt(NEW.colonia::text, 'U>*~6pXwx:'::text); END IF;
    IF NEW.numero IS NOT NULL THEN NEW.numero := pgp_sym_encrypt(NEW.numero::text, 'Fpx!fb;9zj'::text); END IF;

    -- Encrypt telefono
    IF NEW.telefono IS NOT NULL THEN
        IF LENGTH(NEW.telefono::text) != 10 THEN RAISE EXCEPTION 'El número de teléfono debe tener 10 dígitos'; END IF;
        NEW.telefono := pgp_sym_encrypt(NEW.telefono::text, 'RA*Fco|,w^'::text);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Función de trigger para encriptar los datos de la tabla empleado
CREATE OR REPLACE FUNCTION trigger_encrypt_empleado() RETURNS TRIGGER AS $$
BEGIN
    -- Encrypt nombre
    IF NEW.nombre IS NOT NULL THEN NEW.nombre := pgp_sym_encrypt(NEW.nombre::text, 'uCZs~)g\i}'::text); END IF;
    IF NEW.apellido_paterno IS NOT NULL THEN NEW.apellido_paterno := pgp_sym_encrypt(NEW.apellido_paterno::text, 'ARv-_@zv3y'::text); END IF;
    IF NEW.apellido_materno IS NOT NULL THEN NEW.apellido_materno := pgp_sym_encrypt(NEW.apellido_materno::text, 'MqCTb.c05x'::text); END IF;

    -- Encrypt direccion
    IF NEW.calle IS NOT NULL THEN NEW.calle := pgp_sym_encrypt(NEW.calle::text, '=<T0IzkC;m'::text); END IF;
    IF NEW.colonia IS NOT NULL THEN NEW.colonia := pgp_sym_encrypt(NEW.colonia::text, 'U>*~6pXwx:'::text); END IF;
    IF NEW.numero IS NOT NULL THEN NEW.numero := pgp_sym_encrypt(NEW.numero::text, 'Fpx!fb;9zj'::text); END IF;

    -- Encrypt telefono
    IF NEW.telefono IS NOT NULL THEN
        IF LENGTH(NEW.telefono::text) != 10 THEN RAISE EXCEPTION 'El número de teléfono debe tener 10 dígitos'; END IF;
        NEW.telefono := pgp_sym_encrypt(NEW.telefono::text, 'RA*Fco|,w^'::text);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Función de trigger para encriptar los datos de la tabla sucursal
CREATE OR REPLACE FUNCTION trigger_encrypt_sucursal() RETURNS TRIGGER AS $$
BEGIN
    -- Encrypt direccion
    IF NEW.calle IS NOT NULL THEN NEW.calle := pgp_sym_encrypt(NEW.calle::text, '=<T0IzkC;m'::text); END IF;
    IF NEW.colonia IS NOT NULL THEN NEW.colonia := pgp_sym_encrypt(NEW.colonia::text, 'U>*~6pXwx:'::text); END IF;
    IF NEW.numero IS NOT NULL THEN NEW.numero := pgp_sym_encrypt(NEW.numero::text, 'Fpx!fb;9zj'::text); END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS

-- Trigger para la tabla proveedor
CREATE TRIGGER trigger_encrypt_proveedor
BEFORE INSERT OR UPDATE ON proveedor
FOR EACH ROW
EXECUTE FUNCTION trigger_encrypt_proveedor();

-- Trigger para la tabla cliente
CREATE TRIGGER trigger_encrypt_cliente
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
EXECUTE FUNCTION trigger_encrypt_cliente();

-- Trigger para la tabla empleado
CREATE TRIGGER trigger_encrypt_empleado
BEFORE INSERT OR UPDATE ON empleado
FOR EACH ROW
EXECUTE FUNCTION trigger_encrypt_empleado();

-- Trigger para la tabla sucursal
CREATE TRIGGER trigger_encrypt_sucursal
BEFORE INSERT OR UPDATE ON sucursal
FOR EACH ROW
EXECUTE FUNCTION trigger_encrypt_sucursal();

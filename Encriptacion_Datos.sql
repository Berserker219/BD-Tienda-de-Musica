-- FUNCIONES Y TRIGGERS DE ENCRIPTACION
-- Encriptación de atributos por medio de un algortimo de cifrado simetrico

-- FUNCIONES

-- Funcion de encriptación del atributo telefono
CREATE OR REPLACE FUNCTION encriptar_telefono() RETURNS TRIGGER AS $$
BEGIN
    NEW.telefono := pgp_sym_encrypt(NEW.telefono, 'RA*Fco|,w^');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Funcion de encriptación del atributo ruta
CREATE OR REPLACE FUNCTION encriptar_ruta() RETURNS TRIGGER AS $$
BEGIN
	NEW.ruta := pgp_sym_encrypt(NEW.ruta, 'e!CND/.tD[');
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Función para encriptación de los atributos nombre,apellido_paterno y apellido_materno
CREATE OR REPLACE FUNCTION encriptar_nombre() RETURNS TRIGGER AS $$
BEGIN
	NEW.nombre := pgp_sym_encrypt(NEW.nombre, 'uCZs~)g\i}');
	NEW.apellido_paterno := pgp_sym_encrypt(NEW.apellido_paterno, 'ARv-_@zv3y');
	NEW.apellido_materno := pgp_sym_encrypt(NER.apellido_materno, 'MqCTb.c05x');
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Función para encriptación de los atributos calle, colonia y numero
CREATE OR REPLACE FUNCTION encriptar_direccion() RETURNS TRIGGER AS $$
BEGIN
	NEW.calle := pgp_sym_encrypt(NEW.calle, '=<T0IzkC;m');
	NEW.colonia := pgp_sym_encrypt(NEW.colonia, 'U>*~6pXwx:');
	NEW.numero := pgp_sym_encrypt(NEW.numero, 'Fpx!fb;9zj');
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;





-- TRIGGERS

-- Trigger de provedor para la funcion encriptar_telefono
CREATE TRIGGER trigger_proveedor_encriptar_telefono
BEFORE INSERT ON provedor
FOR EACH ROW
EXECUTE FUNCTION encriptar_telefono();

-- Trigger de cliente para la funcion encriptar_telefono
CREATE TRIGGER trigger_cliente_encriptar_telefono
BEFORE INSERT ON cliente
FOR EACH ROW
EXECUTE FUNCTION encriptar_telefono();

-- Trigger de empleado para la funcion encriptar_telefono
CREATE TRIGGER trigger_empleado_encriptar_telefono
BEFORE INSERT ON empleado
FOR EACH ROW
EXECUTE FUNCTION encriptar_telefono();

-- Trigger de provedor_ruta para la funcion de encriptar_ruta
CREATE TRIGGER trigger_provedor_ruta_encriptar_ruta
BEFORE INSERT ON provedor_ruta
FOR EACH ROW
EXECUTE FUNCTION encriptar_ruta();

-- Trigger de provedor_nombre para la funcion de encriptar_nombre
CREATE TRIGGER trigger_provedor_nombre_encriptar_nombre
BEFORE INSERT ON provedor_nombre
FOR EACH ROW
EXECUTE FUNCTION encriptar_nombre();

-- Trigger de cliente_nombre para la funcion de encriptar_nombre
CREATE TRIGGER trigger_cliente_nombre_encriptar_nombre
BEFORE INSERT ON cliente_nombre
FOR EACH ROW
EXECUTE FUNCTION encriptar_nombre();

-- Trigger de empleado_nombre para la funcion de encriptar_nombre
CREATE TRIGGER trigger_empleado_nombre_encriptar_nombre
BEFORE INSERT ON empleado_nombre
FOR EACH ROW
EXECUTE FUNCTION encriptar_nombre();

-- Trigger de provedor_direccion para la funcion de encriptar_direccion	
CREATE TRIGGER trigger_provedor_direccion_encriptar_direccion
BEFORE INSERT ON provedor_direccion
FOR EACH ROW
EXECUTE FUNCTION encriptar_direccion();

-- Trigger de cliente_direccion para la funcion de encriptar_direccion	
CREATE TRIGGER trigger_cliente_direccion_encriptar_direccion
BEFORE INSERT ON cliente_direccion
FOR EACH ROW
EXECUTE FUNCTION encriptar_direccion();

-- Trigger de empleado_direccion para la funcion de encriptar_direccion	
CREATE TRIGGER trigger_empleado_direccion_encriptar_direccion
BEFORE INSERT ON empleado_direccion
FOR EACH ROW
EXECUTE FUNCTION encriptar_direccion();



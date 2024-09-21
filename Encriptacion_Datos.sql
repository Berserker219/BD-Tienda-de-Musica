-- funciones y triggers encriptación del atributo telefono
CREATE OR REPLACE FUNCTION encriptar_telefono() RETURNS TRIGGER AS $$
BEGIN
    NEW.telefono := pgp_sym_encrypt(NEW.telefono, 'mi_clave_secreta');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_encriptar_telefono
BEFORE INSERT ON proveedor
FOR EACH ROW
EXECUTE FUNCTION encriptar_telefono();

-- ejemplo
-- INSERT INTO proveedor (id_proveedor, id_ruta, id_direccion, id_nombre, telefono) VALUES
-- (60004, 1, 40001, 50001, '1234567890');

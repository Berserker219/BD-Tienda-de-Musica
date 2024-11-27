-- Auditoría

-- FUNCIONES

-- Funcion para Auditoría de la tabla Producto

-- Razón: Cambios en los precios, nombres o descripciones de productos pueden afectar a las ventas y generar discrepancias si no se registran adecuadamente.
-- Auditoría recomendada:
-- Cambios en el nombre o precio del producto.
-- Eliminaciones o adiciones de productos.

CREATE OR REPLACE FUNCTION trigger_auditoria_producto()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('producto', NEW.id_producto, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.precio IS DISTINCT FROM OLD.precio OR
		   NEW.nombre IS DISTINCT FROM OLD.nombre OR
		   NEW.descripcion IS DISTINCT FROM OLD.descripcion THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('producto', OLD.id_producto, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('producto', OLD.id_producto, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Proveedor

-- Razón: Modificaciones en los datos de contacto de proveedores o eliminaciones de registros pueden generar incosistencias en el sistema de inventario.
-- Auditoría recomendada:
-- Actualizaciones en información clave como nombre, teléfono o dirección.
-- Eliminaciones de provedores.

CREATE OR REPLACE FUNCTION trigger_auditoria_provedor()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('provedor', NEW.id_provedor, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.id_ruta IS DISTINCT FROM OLD.id_ruta OR
		   NEW.id_direccion IS DISTINCT FROM OLD.direccion OR
		   NEW.id_nombre IS DISTINCT FROM OLD.id_nombre OR 
		   NEW.telefono IS DISTINCT FROM OLD.telefono THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('producto', OLD.id_producto, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('provedor', OLD.id_provedor, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;



-- Funcion para Auditoría para la tabla provedor nombre


CREATE OR REPLACE FUNCTION trigger_auditoria_provedor_nombre()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('provedor_nombre', NEW.id_nombre, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.id_nombre IS DISTINCT FROM OLD.direccion OR
		   NEW.apellido_paterno IS DISTINCT FROM OLD.apellido_paterno OR 
		   NEW.apellido_materno IS DISTINCT FROM OLD.apellido_materno THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('provedor_nombre', OLD.id_nombre, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('provedor_nombre', OLD.id_nombre, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla provedor_direccion



CREATE OR REPLACE FUNCTION trigger_auditoria_provedor_direccion()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('provedor_direccion', NEW.id_direccion, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.calle IS DISTINCT FROM OLD.calle OR
		   NEW.colonia IS DISTINCT FROM OLD.colonia OR
		   NEW.numero IS DISTINCT FROM OLD.numero THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('provedor_direccion', OLD.id_direccion, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('provedor_direccion', OLD.id_direccion, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;



-- Funcion para Auditoría para la tabla provedor_ruta



CREATE OR REPLACE FUNCTION trigger_auditoria_provedor_ruta()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('provedor_ruta', NEW.id_ruta, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.ruta IS DISTINCT FROM OLD.ruta  THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('provedor_ruta', OLD.id_ruta, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('provedor_ruta', OLD.id_ruta, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Almacen

-- Razón: Cualquier cambio en las cantidades de inventario puede implicar errores de cálculo o transacciones no autorizada.
-- Auditoría recomendada:
-- Ajustes de inventario(alta, bajas o ajustes manuales).


CREATE OR REPLACE FUNCTION trigger_auditoria_almacen()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('almacen', NEW.codigo_barras, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.titulo IS DISTINCT FROM OLD.titulo OR
		   NEW.precio IS DISTINCT FROM OLD.precio OR
		   NEW.inventario IS DISTINCT FROM OLD.inventario THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('almacen', OLD.codigo_barras, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('almacen', OLD.codigo_barras, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Sucursal

-- Razón: Cambios en las sucursales pueden implicar cierres, aperturas o modificaciones críticas.
-- Auditoría recomendada:
-- Adiciones o eliminaciones de sucursales.


CREATE OR REPLACE FUNCTION trigger_auditoria_sucursal()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('sucursal', NEW.id_sucursal, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.titulo IS DISTINCT FROM OLD.titulo OR
		   NEW.nombre IS DISTINCT FROM OLD.nombre OR
		   NEW.id_direccion IS DISTINCT FROM OLD.direccion THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('sucursal', OLD.id_sucursal, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('sucursal', OLD.id_sucursal, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Sucursal_direccion

-- Razón: Cambios en las sucursales pueden implicar cierres, aperturas o modificaciones críticas.
-- Auditoría recomendada:
-- Cambios en la ubicación o detalles de la sucursal.


CREATE OR REPLACE FUNCTION trigger_auditoria_sucursal_direccion()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('sucursal_direccion', NEW.id_direccion, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.calle IS DISTINCT FROM OLD.calle OR
		   NEW.colonia IS DISTINCT FROM OLD.colonia OR
		   NEW.numero IS DISTINCT FROM OLD.numero THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('sucursal_direccion', OLD.id_direccion, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;	
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('sucursal_direccion', OLD.id_direccion, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Compra_material

-- Razón: Cambios en las compra_material puede implicar errores de cálculo o transacciones no autorizada
-- Auditoría recomendada:
-- Ajustes de compra_material.
-- Movimientos de compra_material.


CREATE OR REPLACE FUNCTION trigger_auditoria_compra_material()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('compra_material', NEW.id_compra, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.fecha IS DISTINCT FROM OLD.fecha OR
		   NEW.total IS DISTINCT FROM OLD.total OR THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('compra_material', OLD.id_compra, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('compra_material', OLD.id_compra, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Funcion para Auditoría para la tabla Cliente

-- Razón: Cambios en los datos de clientes podrían impactar en su historial de compras o en la comunicación.
-- Auditoría recomendada:
-- Actualizaciones en información clave como nombre, email dirección.
-- Eliminaciones de resgistros.


CREATE OR REPLACE FUNCTION trigger_auditoria_cliente()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('cliente', NEW.id_cliente, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.id_direccion IS DISTINCT FROM OLD.direccion OR
		   NEW.id_nombre IS DISTINCT FROM OLD.id_nombre OR 
		   NEW.telefono IS DISTINCT FROM OLD.telefono THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('cliente', OLD.id_cliente, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('cliente', OLD.id_cliente, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Funcion para Auditoría para la tabla Cliente nombre


CREATE OR REPLACE FUNCTION trigger_auditoria_cliente_nombre()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('cliente_nombre', NEW.id_nombre, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.id_nombre IS DISTINCT FROM OLD.direccion OR
		   NEW.apellido_paterno IS DISTINCT FROM OLD.apellido_paterno OR 
		   NEW.apellido_materno IS DISTINCT FROM OLD.apellido_materno THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('cliente_nombre', OLD.id_nombre, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('cliente_nombre', OLD.id_nombre, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla cliente_direccion


CREATE OR REPLACE FUNCTION trigger_auditoria_cliente_direccion()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('cliente_direccion', NEW.id_direccion, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.calle IS DISTINCT FROM OLD.calle OR
		   NEW.colonia IS DISTINCT FROM OLD.colonia OR
		   NEW.numero IS DISTINCT FROM OLD.numero THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('cliente_direccion', OLD.id_direccion, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSEIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('cliente_direccion', OLD.id_direccion, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;



-- Trigger auditoria_producto
CREATE TRIGGER auditoria_producto
AFTER INSERT OR UPDATE OR DELETE ON producto
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_producto();

-- Trigger auditoria_provedor
CREATE TRIGGER auditoria_provedor
AFTER INSERT OR UPDATE OR DELETE ON provedor
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_provedor();

-- Trigger auditoria_provedor_nombre
CREATE TRIGGER auditoria_provedor_nombre
AFTER INSERT OR UPDATE OR DELETE ON provedor_nombre
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_provedor_nombre();

-- Trigger auditoria_provedor_direccion
CREATE TRIGGER auditoria_provedor_direccion
AFTER INSERT OR UPDATE OR DELETE ON provedor_direccion
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_provedor_direccion();

-- Trigger auditoria_provedor_ruta
CREATE TRIGGER auditoria_provedor_ruta
AFTER INSERT OR UPDATE OR DELETE ON provedor_ruta
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_provedor_ruta();

-- Trigger auditoria_almacen
CREATE TRIGGER auditoria_almacen
AFTER INSERT OR UPDATE OR DELETE ON almacen
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_almacen();

-- Trigger auditoria_sucursal
CREATE TRIGGER auditoria_sucursal
AFTER INSERT OR UPDATE OR DELETE ON sucursal
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_sucursal();

-- Trigger auditoria_sucursal_direccion
CREATE TRIGGER auditoria_sucursal_direccion
AFTER INSERT OR UPDATE OR DELETE ON sucursal_direccion
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_sucursal_direccion();

-- Trigger auditoria_compra_material
CREATE TRIGGER auditoria_compra_material
AFTER INSERT OR UPDATE OR DELETE ON compra_material
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_compra_material();

-- Trigger auditoria_cliente
CREATE TRIGGER auditoria_cliente
AFTER INSERT OR UPDATE OR DELETE ON cliente
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_cliente();

-- Trigger auditoria_cliente_nombre
CREATE TRIGGER auditoria_cliente_nombre
AFTER INSERT OR UPDATE OR DELETE ON cliente_nombre
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_cliente_nombre();

-- Trigger auditoria_cliente_direccion
CREATE TRIGGER auditoria_cliente_direccion
AFTER INSERT OR UPDATE OR DELETE ON cliente_direccion
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_cliente_direccion();
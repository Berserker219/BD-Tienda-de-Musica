-- Auditoría

-- FUNCIONES

-- Funcion para Auditoría de la tabla Producto
CREATE OR REPLACE FUNCTION trigger_auditoria_producto()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('producto', NEW.id_producto, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.precio IS DISTINCT FROM OLD.precio OR
		   NEW.nombre_producto IS DISTINCT FROM OLD.nombre_producto OR
		   NEW.descripcion IS DISTINCT FROM OLD.descripcion THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('producto', OLD.id_producto, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('producto', OLD.id_producto, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Proveedor
CREATE OR REPLACE FUNCTION trigger_auditoria_proveedor()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('proveedor', NEW.id_proveedor, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.nombre IS DISTINCT FROM OLD.nombre OR
		   NEW.apellido_paterno IS DISTINCT FROM OLD.apellido_paterno OR
           NEW.apellido_materno IS DISTINCT FROM OLD.apellido_materno OR
           NEW.calle IS DISTINCT FROM OLD.calle OR
           NEW.colonia IS DISTINCT FROM OLD.colonia OR
           NEW.numero IS DISTINCT FROM OLD.numero OR
		   NEW.ruta IS DISTINCT FROM OLD.ruta OR
		   NEW.telefono IS DISTINCT FROM OLD.telefono THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('proveedor', OLD.id_proveedor, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('proveedor', OLD.id_proveedor, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Almacen
CREATE OR REPLACE FUNCTION trigger_auditoria_almacen()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('almacen', NEW.id_almacen, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.titulo IS DISTINCT FROM OLD.titulo OR
		   NEW.precio IS DISTINCT FROM OLD.precio OR
		   NEW.inventario IS DISTINCT FROM OLD.inventario THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('almacen', OLD.id_almacen, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('almacen', OLD.id_almacen, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Sucursal
CREATE OR REPLACE FUNCTION trigger_auditoria_sucursal()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('sucursal', NEW.id_sucursal, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.nombre IS DISTINCT FROM OLD.nombre OR
		   NEW.calle IS DISTINCT FROM OLD.calle OR
           NEW.colonia IS DISTINCT FROM OLD.colonia OR
           NEW.numero IS DISTINCT FROM OLD.numero THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('sucursal', OLD.id_sucursal, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('sucursal', OLD.id_sucursal, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Funcion para Auditoría para la tabla Compra
CREATE OR REPLACE FUNCTION trigger_auditoria_compra()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('compra', NEW.id_compra, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.fecha IS DISTINCT FROM OLD.fecha OR
		   NEW.total IS DISTINCT FROM OLD.total THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('compra', OLD.id_compra, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('compra', OLD.id_compra, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Funcion para Auditoría para la tabla Cliente
CREATE OR REPLACE FUNCTION trigger_auditoria_cliente()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('cliente', NEW.id_cliente, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.nombre IS DISTINCT FROM OLD.nombre OR
		   NEW.apellido_paterno IS DISTINCT FROM OLD.apellido_paterno OR
           NEW.apellido_materno IS DISTINCT FROM OLD.apellido_materno OR
           NEW.calle IS DISTINCT FROM OLD.calle OR
           NEW.colonia IS DISTINCT FROM OLD.colonia OR
           NEW.numero IS DISTINCT FROM OLD.numero OR
		   NEW.telefono IS DISTINCT FROM OLD.telefono THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('cliente', OLD.id_cliente, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('cliente', OLD.id_cliente, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Funcion para Auditoría para la tabla Venta
CREATE OR REPLACE FUNCTION trigger_auditoria_venta()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('venta', NEW.id_venta, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.fecha IS DISTINCT FROM OLD.fecha OR
           NEW.cantidad IS DISTINCT FROM OLD.cantidad OR
           NEW.precio_venta IS DISTINCT FROM OLD.precio_venta THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('venta', OLD.id_venta, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('venta', OLD.id_venta, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Funcion para Auditoría para la tabla Empleado
CREATE OR REPLACE FUNCTION trigger_auditoria_empleado()
RETURNS TRIGGER AS $$
BEGIN 
	IF TG_OP = 'INSERT' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_despues)
		VALUES('empleado', NEW.id_empleado, TG_OP, SESSION_USER, row_to_json(NEW));
	ELSIF TG_OP = 'UPDATE' THEN
		IF NEW.nombre IS DISTINCT FROM OLD.nombre OR
		   NEW.apellido_paterno IS DISTINCT FROM OLD.apellido_paterno OR
           NEW.apellido_materno IS DISTINCT FROM OLD.apellido_materno OR
           NEW.calle IS DISTINCT FROM OLD.calle OR
           NEW.colonia IS DISTINCT FROM OLD.colonia OR
           NEW.numero IS DISTINCT FROM OLD.numero OR
		   NEW.telefono IS DISTINCT FROM OLD.telefono OR
           NEW.id_sucursal IS DISTINCT FROM OLD.id_sucursal THEN
			INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes, valores_despues)
			VALUES('empleado', OLD.id_empleado, TG_OP, SESSION_USER, row_to_json(OLD), row_to_json(NEW));
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		INSERT INTO auditoria (tabla_afectada,id_registro, operacion, usuario, valores_antes)
		VALUES('empleado', OLD.id_empleado, TG_OP, SESSION_USER, row_to_json(OLD));
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Triggers

CREATE TRIGGER auditoria_producto
AFTER INSERT OR UPDATE OR DELETE ON producto
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_producto();

CREATE TRIGGER auditoria_proveedor
AFTER INSERT OR UPDATE OR DELETE ON proveedor
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_proveedor();

CREATE TRIGGER auditoria_almacen
AFTER INSERT OR UPDATE OR DELETE ON almacen
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_almacen();

CREATE TRIGGER auditoria_sucursal
AFTER INSERT OR UPDATE OR DELETE ON sucursal
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_sucursal();

CREATE TRIGGER auditoria_compra
AFTER INSERT OR UPDATE OR DELETE ON compra
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_compra();

CREATE TRIGGER auditoria_cliente
AFTER INSERT OR UPDATE OR DELETE ON cliente
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_cliente();

CREATE TRIGGER auditoria_venta
AFTER INSERT OR UPDATE OR DELETE ON venta
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_venta();

CREATE TRIGGER auditoria_empleado
AFTER INSERT OR UPDATE OR DELETE ON empleado
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_empleado();

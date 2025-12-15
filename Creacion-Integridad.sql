-- Creación de Tablas y aplicando Integridad

-- Creación de Tabla Album
CREATE TABLE IF NOT EXISTS album(
	id_album SERIAL PRIMARY KEY,-- llave primaria
	nombre VARCHAR (100) NOT NULL UNIQUE,
	anio_album DATE NOT NULL
);
-- Creación de Tabla Artista
CREATE TABLE IF NOT EXISTS artista(
	id_artista SERIAL PRIMARY KEY,-- llave primaria
	nombre VARCHAR (100) NOT NULL
);
-- Creación de Tabla de la relacion muchos a muchos Album-Artista
CREATE TABLE IF NOT EXISTS album_artista(
	id_album INT NOT NULL,
	id_artista INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_album FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_artista FOREIGN KEY (id_artista) REFERENCES artista(id_artista) ON DELETE CASCADE ON UPDATE CASCADE,
--  Creación de llave primaria compuesta
    PRIMARY KEY (id_album, id_artista)
);
-- Creación de Tabla Genero_Músical
CREATE TABLE IF NOT EXISTS genero_musical(
	id_genero_musical SERIAL PRIMARY KEY,-- llave primaria
	nombre_genero VARCHAR (100) NOT NULL UNIQUE
);
-- Creación de Tabla de la relacion muchos a muchos Album-Genero_Músical
CREATE TABLE IF NOT EXISTS album_genero_musical(
	id_album INT NOT NULL,
	id_genero_musical INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_album_genero FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_genero_album FOREIGN KEY (id_genero_musical) REFERENCES genero_musical(id_genero_musical) ON DELETE CASCADE ON UPDATE CASCADE,
--  Creación de llave primaria compuesta
    PRIMARY KEY (id_album, id_genero_musical)
);
-- Creación de Tabla Producto
CREATE TABLE IF NOT EXISTS producto(
	id_producto SERIAL PRIMARY KEY,
	nombre_producto VARCHAR(25) NOT NULL,
	descripcion TEXT NOT NULL,
	precio NUMERIC NOT NULL,
	existencia INT NOT NULL
);
-- Creación de Tabla de la relacion muchos a muchos Album-Producto
CREATE TABLE IF NOT EXISTS album_producto(
	id_album INT NOT NULL,
	id_producto INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_album_producto FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_album FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
--  Creación de llave primaria compuesta
    PRIMARY KEY (id_album, id_producto)
);
-- Creación de Tabla Proveedor
CREATE TABLE IF NOT EXISTS proveedor(
	id_proveedor SERIAL PRIMARY KEY,
	nombre bytea NOT NULL,
	apellido_paterno bytea,
	apellido_materno bytea,
    calle bytea,
	colonia bytea,
	numero bytea,
    ruta bytea NOT NULL,
	telefono bytea NOT NULL
);

-- Creación de Tabla de la relacion muchos a muchos Proveedor-Producto
CREATE TABLE IF NOT EXISTS proveedor_producto(
	id_proveedor INT NOT NULL,
	id_producto INT NOT NULL,
--  Creación de llaves foráneas
	CONSTRAINT fk_proveedor_producto_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_proveedor_producto_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
--  Creación de llave primaria compuesta
    PRIMARY KEY (id_proveedor, id_producto)
);
-- Creación de Tabla Almacen
CREATE TABLE IF NOT EXISTS almacen(
    id_almacen SERIAL PRIMARY KEY,
	codigo_barras INT,
	titulo VARCHAR(100),
	precio NUMERIC NOT NULL,
	inventario INT NOT NULL,
--  Integridad del codigo_barras para que solo lo conforme los numeros	entre 10000000 y 999999999
	CONSTRAINT chk_codigo_barras CHECK (codigo_barras BETWEEN 10000000 AND 999999999),
    UNIQUE (codigo_barras, titulo)
);
-- Creación de Tabla de la relacion muchos a muchos Producto_Almacen
CREATE TABLE IF NOT EXISTS producto_almacen(
	id_producto INT NOT NULL,
	id_almacen INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_producto_almacen_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_almacen_almacen FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen) ON DELETE CASCADE ON UPDATE CASCADE,
--  Creación de llave primaria compuesta
    PRIMARY KEY (id_producto, id_almacen)
);
-- Creación de Tabla Compra
CREATE TABLE IF NOT EXISTS compra(
	id_compra SERIAL PRIMARY KEY,
	fecha DATE NOT NULL,
	total INT NOT NULL
);
-- Creación de Tabla de la relacion muchos a muchos Producto-Compra (Detalle Compra)
CREATE TABLE IF NOT EXISTS detalle_compra(
	id_producto INT NOT NULL,
	id_compra INT NOT NULL,
    cantidad INT NOT NULL,
    costo_unitario NUMERIC NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_producto_compra FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_compra_producto FOREIGN KEY (id_compra) REFERENCES compra(id_compra) ON DELETE CASCADE ON UPDATE CASCADE,
--  Creación de llave primaria compuesta
    PRIMARY KEY (id_producto, id_compra)
);
-- Creación de Tabla Cliente
CREATE TABLE IF NOT EXISTS cliente(
	id_cliente SERIAL PRIMARY KEY,
	nombre bytea NOT NULL,
	apellido_paterno bytea,
	apellido_materno bytea,
    calle bytea,
	colonia bytea,
	numero bytea,
	telefono bytea NOT NULL
);
-- Creación de Tabla Venta (antes producto_cliente)
CREATE TABLE IF NOT EXISTS venta(
    id_venta SERIAL PRIMARY KEY,
	id_producto INT NOT NULL,
	id_cliente INT NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    precio_venta NUMERIC NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_venta_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Sucursal
CREATE TABLE IF NOT EXISTS sucursal(
	id_sucursal SERIAL PRIMARY KEY,
	nombre VARCHAR(100) UNIQUE,
    calle bytea,
	colonia bytea,
	numero bytea
);
-- Creación de Tabla de la relacion muchos a muchos Producto-Sucursal
CREATE TABLE IF NOT EXISTS producto_sucursal(
	id_producto INT NOT NULL,
	id_sucursal INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_producto_sucursal_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_sucursal_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE,
--  Creación de llave primaria compuesta
    PRIMARY KEY (id_producto, id_sucursal)
);
-- Creación de Tabla Empleado
CREATE TABLE IF NOT EXISTS empleado(
	id_empleado SERIAL PRIMARY KEY,
	id_sucursal INT NOT NULL,
	nombre bytea NOT NULL,
	apellido_paterno bytea,
	apellido_materno bytea,
    calle bytea,
	colonia bytea,
	numero bytea,
	telefono bytea NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_empleado_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Creación de Tabla Auditoria
CREATE TABLE IF NOT EXISTS auditoria(
	id_auditoria SERIAL PRIMARY KEY, 
	tabla_afectada VARCHAR(100) NOT NULL,            --Nombre de la tabla afectada
	id_registro INT NOT NULL,                        -- ID del registro afectado
	operacion VARCHAR(10) NOT NULL,                  -- Tipo de operacíon: INSERT, UPDATE, DELETE
	usuario VARCHAR(100),                            -- Usuario que realizó el cambio
	fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Fecha y hora del cambio
	valores_antes JSONB,                             -- Valores antes del cambio (para UPDATE y DELETE)
	valores_despues JSONB                            -- Valores despues del cambio(para INSERT y UPDATE)	
);

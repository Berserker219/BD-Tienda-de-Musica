-- Creación de tablas

CREATE TABLE IF NOT EXISTS album(
	id_album INT PRIMARY KEY,
	nombre VARCHAR (45) NOT NULL,
	anio_album DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS artista(
	id_artista INT PRIMARY KEY,
	nombre VARCHAR (45) NOT NULL
);

CREATE TABLE IF NOT EXISTS album_artista(
	id_album INT NOT NULL,
	id_artista INT NOT NULL,
	CONSTRAINT fk_album FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_artista FOREIGN KEY (id_artista) REFERENCES artista(id_artista) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS genero_musical(
	id_genero_musical INT PRIMARY KEY,
	nombre_genero VARCHAR (45) NOT NULL
);

CREATE TABLE IF NOT EXISTS album_genero_musical(
	id_album INT NOT NULL,
	id_genero_musical INT NOT NULL,
	CONSTRAINT fk_album_genero FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_genero_album FOREIGN KEY (id_genero_musical) REFERENCES genero_musical(id_genero_musical) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS producto(
	id_producto INT,
	nombre_producto VARCHAR(25),
	descripcion TEXT NOT NULL,
	precio NUMERIC NOT NULL,
	existencia INT NOT NULL,
	PRIMARY KEY (id_producto, nombre_producto)
);

CREATE TABLE IF NOT EXISTS album_producto(
	id_album INT NOT NULL,
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(25) NOT NULL,
	CONSTRAINT fk_album_producto FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_album FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS provedor_direccion(
	id_direccion INT PRIMARY KEY,
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);

CREATE TABLE IF NOT EXISTS provedor_nombre(
	id_nombre INT PRIMARY KEY,
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45),
	apellido_materno VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS provedor_ruta(
	id_ruta INT PRIMARY KEY,
	ruta VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS provedor(
	id_provedor INT NOT NULL,
	id_ruta INT NOT NULL,
	id_direccion INT NOT NULL,
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(25) NOT NULL,
	id_nombre INT NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	PRIMARY KEY (id_provedor),
	CONSTRAINT chk_telefono CHECK (telefono ~ '[0-9]{10}'),
	CONSTRAINT fk_proveedor_producto FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_proveedor_direccion FOREIGN KEY (id_direccion) REFERENCES provedor_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_proveedor_ruta FOREIGN KEY (id_ruta) REFERENCES provedor_ruta(id_ruta) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_proveedor_nombre FOREIGN KEY (id_nombre) REFERENCES provedor_nombre(id_nombre) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS almacen(
	codigo_barras INT,
	titulo VARCHAR(45),
	precio INT NOT NULL,
	inventario INT NOT NULL,
	PRIMARY KEY (codigo_barras, titulo),
	CONSTRAINT chk_codigo_barras CHECK (codigo_barras BETWEEN 10000000 AND 999999999)
);

CREATE TABLE IF NOT EXISTS producto_almacen(
	id_producto INT NOT NULL,
	titulo VARCHAR(45) NOT NULL,
	codigo_barras INT NOT NULL,
	nombre_producto VARCHAR(45) NOT NULL,
	CONSTRAINT fk_producto_almacen_producto FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_almacen_almacen FOREIGN KEY (codigo_barras, titulo) REFERENCES almacen(codigo_barras, titulo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS compra_material(
	id_compra INT PRIMARY KEY,
	fecha DATE NOT NULL,
	total INT NOT NULL
);

CREATE TABLE IF NOT EXISTS producto_compra_material(
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(45) NOT NULL,
	id_compra INT NOT NULL,
	CONSTRAINT fk_producto_compra FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_compra_producto FOREIGN KEY (id_compra) REFERENCES compra_material(id_compra) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS cliente_nombre(
	id_nombre INT PRIMARY KEY,
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45),
	apellido_materno VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS cliente_direccion(
	id_direccion INT PRIMARY KEY,
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);

CREATE TABLE IF NOT EXISTS cliente(
	id_cliente INT PRIMARY KEY,
	id_nombre INT NOT NULL,
	id_direccion INT NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	CONSTRAINT fk_cliente_nombre FOREIGN KEY (id_nombre) REFERENCES cliente_nombre(id_nombre) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_cliente_direccion FOREIGN KEY (id_direccion) REFERENCES cliente_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT chk_telefono_cliente CHECK (telefono ~ '[0-9]{10}')
);

CREATE TABLE IF NOT EXISTS producto_cliente(
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(25) NOT NULL,
	id_cliente INT NOT NULL,
	CONSTRAINT fk_producto_cliente_producto FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_cliente_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS sucursal_direccion(
	id_direccion INT PRIMARY KEY,
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);

CREATE TABLE IF NOT EXISTS sucursal(
	id_sucursal INT PRIMARY KEY,
	nombre VARCHAR(45),
	id_direccion INT NOT NULL,
	CONSTRAINT fk_sucursal_direccion FOREIGN KEY (id_direccion) REFERENCES sucursal_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS producto_sucursal(
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(25) NOT NULL,
	id_sucursal INT NOT NULL,
	CONSTRAINT fk_producto_sucursal_producto FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_sucursal_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS empleado_nombre(
	id_nombre INT PRIMARY KEY,
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45),
	apellido_materno VARCHAR(45)
);

CREATE TABLE IF NOT EXISTS empleado_direccion(
	id_direccion INT PRIMARY KEY,
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);

CREATE TABLE IF NOT EXISTS empleado(
	id_empleado INT PRIMARY KEY,
	id_nombre INT NOT NULL,
	id_direccion INT NOT NULL,
	id_sucursal INT NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	CONSTRAINT fk_empleado_nombre FOREIGN KEY (id_nombre) REFERENCES empleado_nombre(id_nombre) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_empleado_direccion FOREIGN KEY (id_direccion) REFERENCES empleado_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_empleado_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT chk_telefono_empleado CHECK (telefono ~ '[0-9]{10}')
);

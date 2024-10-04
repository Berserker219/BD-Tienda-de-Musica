-- Creación de Tablas y aplicando Integridad

-- Creación de Tabla Album
CREATE TABLE IF NOT EXISTS album(
	id_album INT PRIMARY KEY,-- llave primaria
	nombre VARCHAR (45) NOT NULL,
	anio_album DATE NOT NULL
);
-- Creación de Tabla Artista
CREATE TABLE IF NOT EXISTS artista(
	id_artista INT PRIMARY KEY,-- llave primaria
	nombre VARCHAR (45) NOT NULL
);
-- Creación de Tabla de la relacion muchos a muchos Album-Artista
CREATE TABLE IF NOT EXISTS album_artista(
	id_album INT NOT NULL,
	id_artista INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_album FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_artista FOREIGN KEY (id_artista) REFERENCES artista(id_artista) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Genero_Músical
CREATE TABLE IF NOT EXISTS genero_musical(
	id_genero_musical INT PRIMARY KEY,-- llave primaria
	nombre_genero VARCHAR (45) NOT NULL
);
-- Creación de Tabla de la relacion muchos a muchos Album-Genero_Músical
CREATE TABLE IF NOT EXISTS album_genero_musical(
	id_album INT NOT NULL,
	id_genero_musical INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_album_genero FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_genero_album FOREIGN KEY (id_genero_musical) REFERENCES genero_musical(id_genero_musical) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Producto
CREATE TABLE IF NOT EXISTS producto(
	id_producto INT,
	nombre_producto VARCHAR(25),
	descripcion TEXT NOT NULL,
	precio NUMERIC NOT NULL,
	existencia INT NOT NULL,
-- Creación de llave primaria compuesta, formada por id_producto y nombre_producto
	PRIMARY KEY (id_producto, nombre_producto)
);
-- Creación de Tabla de la relacion muchos a muchos Album-Producto
CREATE TABLE IF NOT EXISTS album_producto(
	id_album INT NOT NULL,
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(25) NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_album_producto FOREIGN KEY (id_album) REFERENCES album(id_album) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_album FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Provedor_dirección
CREATE TABLE IF NOT EXISTS provedor_direccion(
	id_direccion INT PRIMARY KEY, -- llave primaria
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);
-- Creación de Tabla Provedor_Nombre
CREATE TABLE IF NOT EXISTS provedor_nombre(
	id_nombre INT PRIMARY KEY,-- llave primaria
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45),
	apellido_materno VARCHAR(45)
);
-- Creación de Tabla Provedor_Ruta
CREATE TABLE IF NOT EXISTS provedor_ruta(
	id_ruta INT PRIMARY KEY,-- llave primaria
	ruta VARCHAR(45) NOT NULL
);
-- Creación de Tabla Provedor
CREATE TABLE IF NOT EXISTS provedor(
	id_provedor INT NOT NULL,
	id_ruta INT NOT NULL,
	id_direccion INT NOT NULL,
	id_nombre INT NOT NULL,
	telefono VARCHAR(10) NOT NULL,
--  llave primaria
	PRIMARY KEY (id_provedor),
--  Integridad del Atributo Telefono para que solo tenga 10 numeros	
	CONSTRAINT chk_telefono CHECK (telefono ~ '[0-9]{10}'),
--  Creación de llaves foráneas 	
	CONSTRAINT fk_proveedor_direccion FOREIGN KEY (id_direccion) REFERENCES provedor_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_proveedor_ruta FOREIGN KEY (id_ruta) REFERENCES provedor_ruta(id_ruta) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_proveedor_nombre FOREIGN KEY (id_nombre) REFERENCES provedor_nombre(id_nombre) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Creación de Tabla de la relacion muchos a muchos Provedor-Producto
CREATE TABLE IF NOT EXISTS provedor_producto(
	id_provedor INT NOT NULL,
	id_producto INT NOT NULL,
	nombre_producto VARCHAR (45) NOT NULL,
--  Creación de llaves foráneas
	CONSTRAINT fk_provedor_producto_provedor FOREIGN KEY (id_provedor) REFERENCES provedor(id_provedor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_provedor_producto_producto FOREIGN KEY (id_producto,nombre_producto) REFERENCES producto(id_producto,nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Almacen
CREATE TABLE IF NOT EXISTS almacen(
	codigo_barras INT,
	titulo VARCHAR(45),
	precio NUMERIC NOT NULL,
	inventario INT NOT NULL,
--  llave primaria 	
	PRIMARY KEY (codigo_barras, titulo),
--  Integridad del codigo_barras para que solo lo conforme los numeros	entre 10000000 y 999999999
	CONSTRAINT chk_codigo_barras CHECK (codigo_barras BETWEEN 10000000 AND 999999999)
);
-- Creación de Tabla de la relacion muchos a muchos Producto_Almacen
CREATE TABLE IF NOT EXISTS producto_almacen(
	id_producto INT NOT NULL,
	titulo VARCHAR(45) NOT NULL,
	codigo_barras INT NOT NULL,
	nombre_producto VARCHAR(45) NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_producto_almacen_producto FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_almacen_almacen FOREIGN KEY (codigo_barras, titulo) REFERENCES almacen(codigo_barras, titulo) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Compra_Material
CREATE TABLE IF NOT EXISTS compra_material(
	id_compra INT PRIMARY KEY,-- llave primaria
	fecha DATE NOT NULL,
	total INT NOT NULL
);
-- Creación de Tabla de la relacion muchos a muchos Producto-Compra_Material
CREATE TABLE IF NOT EXISTS producto_compra_material(
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(45) NOT NULL,
	id_compra INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_producto_compra FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_compra_producto FOREIGN KEY (id_compra) REFERENCES compra_material(id_compra) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Cliente_Nombre
CREATE TABLE IF NOT EXISTS cliente_nombre(
	id_nombre INT PRIMARY KEY,-- llave primaria
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45),
	apellido_materno VARCHAR(45)
);
-- Creación de Tabla Cliente_Dirección
CREATE TABLE IF NOT EXISTS cliente_direccion(
	id_direccion INT PRIMARY KEY,-- llave primaria
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);
-- Creación de Tabla Cliente
CREATE TABLE IF NOT EXISTS cliente(
	id_cliente INT PRIMARY KEY,-- llave primaria
	id_nombre INT NOT NULL,
	id_direccion INT NOT NULL,
	telefono VARCHAR(10) NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_cliente_nombre FOREIGN KEY (id_nombre) REFERENCES cliente_nombre(id_nombre) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_cliente_direccion FOREIGN KEY (id_direccion) REFERENCES cliente_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE,
--  Integridad del Atributo Telefono para que solo tenga 10 numeros		
	CONSTRAINT chk_telefono_cliente CHECK (telefono ~ '[0-9]{10}')
);
-- Creación de Tabla de la relacion muchos a muchos Producto-Cliente
CREATE TABLE IF NOT EXISTS producto_cliente(
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(25) NOT NULL,
	id_cliente INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_producto_cliente_producto FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_cliente_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Sucursal_Dirección
CREATE TABLE IF NOT EXISTS sucursal_direccion(
	id_direccion INT PRIMARY KEY,-- llave primaria
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);
-- Creación de Tabla Sucursal
CREATE TABLE IF NOT EXISTS sucursal(
	id_sucursal INT PRIMARY KEY,-- llave primaria
	nombre VARCHAR(45),
	id_direccion INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_sucursal_direccion FOREIGN KEY (id_direccion) REFERENCES sucursal_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla de la relacion muchos a muchos Producto-Sucursal
CREATE TABLE IF NOT EXISTS producto_sucursal(
	id_producto INT NOT NULL,
	nombre_producto VARCHAR(25) NOT NULL,
	id_sucursal INT NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_producto_sucursal_producto FOREIGN KEY (id_producto, nombre_producto) REFERENCES producto(id_producto, nombre_producto) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_producto_sucursal_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Creación de Tabla Empleado_Nombre
CREATE TABLE IF NOT EXISTS empleado_nombre(
	id_nombre INT PRIMARY KEY,-- llave primaria
	nombre VARCHAR(45) NOT NULL,
	apellido_paterno VARCHAR(45),
	apellido_materno VARCHAR(45)
);
-- Creación de Tabla Empleado_Dirección
CREATE TABLE IF NOT EXISTS empleado_direccion(
	id_direccion INT PRIMARY KEY,-- llave primaria
	calle VARCHAR(45),
	colonia VARCHAR(45),
	numero INT
);
-- Creación de Tabla Empleado
CREATE TABLE IF NOT EXISTS empleado(
	id_empleado INT PRIMARY KEY,-- llave primaria
	id_nombre INT NOT NULL,
	id_direccion INT NOT NULL,
	id_sucursal INT NOT NULL,
	telefono VARCHAR(10) NOT NULL,
--  Creación de llaves foráneas 	
	CONSTRAINT fk_empleado_nombre FOREIGN KEY (id_nombre) REFERENCES empleado_nombre(id_nombre) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_empleado_direccion FOREIGN KEY (id_direccion) REFERENCES empleado_direccion(id_direccion) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_empleado_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE,
--  Integridad del Atributo Telefono para que solo tenga 10 numeros	
	CONSTRAINT chk_telefono_empleado CHECK (telefono ~ '[0-9]{10}')
);

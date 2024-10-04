-- INDICES 



--Indices en Claves Foráneas

-- Indices para la tabla album_artista
CREATE INDEX idx_album_artista_album ON album_artista(id_album);
CREATE INDEX idx_album_artista_artista ON album_artista(id_artista);

-- Indices para la tabla album_genero_musical
CREATE INDEX idx_album_genero_album ON album_genero_musical(id_album);
CREATE INDEX idx_album_genero_genero ON album_genero_musical(id_genero_musical);

-- Indices para la tabla album_producto
CREATE INDEX idx_album_producto_album ON album_producto(id_album);
CREATE INDEX idx_album_producto_producto ON album_producto(id_producto,nombre_producto);

-- Indices para la tabla provedor_producto
CREATE INDEX idx_provedor_producto_provedor ON provedor_producto(id_provedor);
CREATE INDEX idx_provedor_producto_producto ON provedor_producto(id_producto,nombre_producto);

-- Indices para la tabla producto_almacen
CREATE INDEX idx_producto_almacen_producto ON producto_almacen(id_producto,nombre_producto);
CREATE INDEX idx_producto_almacen_codigo_barras ON producto_almacen(codigo_barras,titulo);

-- Indices para la tabla producto_conpra_material
CREATE INDEX idx_producto_compra_producto ON producto_compra_material(id_producto,nombre_producto);
CREATE INDEX idx_producto_compra_compra ON producto_compra_material(id_compra);

-- Indices para la tabla producto_cliente
CREATE INDEX idx_producto_cliente_producto ON producto_cliente(id_producto,nombre_producto);
CREATE INDEX idx_producto_cliente_cliente ON producto_cliente(id_cliente);

-- Indices para la tabla producto_sucursal
CREATE INDEX idx_producto_sucursal_producto ON producto_sucursal(id_producto,nombre_producto);
CREATE INDEX idx_producto_sucursal_sucursal ON producto_sucursal(id_sucursal);

-- Indice para la tabla cliente_nombre
CREATE INDEX idx_cliente_nombre ON cliente_nombre(nombre);


-- Indices de Campos usados frencuentemente en consultas


-- Indice en nombre_producto en la tabla producto
CREATE INDEX idx_producto_nombre ON producto(nombre_producto);

-- Indice en telefono en cliente
CREATE INDEX idx_cliente_telefono ON cliente(telefono);

-- Indice en telefono en empleado
CREATE INDEX idx_empleado_telefono ON empleado(telefono);

-- Indice en telefono en provedor
CREATE INDEX idx_provedor_telefono ON provedor(telefono);


-- Indices en Campos numericos


-- Indice en precio en la tabla producto
CREATE INDEX idx_producto_precio ON producto(precio);

-- Indice de existencia(stock) en la tabla producto
CREATE INDEX idx_producto_existencia ON producto(existencia);

-- Indice de inventario en la tabla almacen
CREATE INDEX idx_almacen_inventario ON almacen(inventario);


-- Indices en fechas


-- Indice anio_album en la tabla album
CREATE INDEX idx_album_anio ON album(anio_album);

-- Indice fecha en la tabla compra_material
CREATE INDEX idx_compra_fecha ON compra_material(fecha);


-- Indices en atributos de texto completo


-- Indice de texto completo en descripcion en la tabla producto
CREATE INDEX idx_producto_descripcion_fulltext ON producto USING gin(to_tsvector('spanish', descripcion));


-- Indices unicos para garantizar unicidad


-- Indice unico en nombre de album en la tabla album
CREATE UNIQUE INDEX idx_album_nombre_unico ON album(nombre);

-- Indice unico en nombre de genero en la tabla genero_musical
CREATE UNIQUE INDEX idx_genero_nombre_unico ON genero_musical(nombre_genero);

-- Indice unico en nombre del provedor en la tabla provedor_nombre
CREATE UNIQUE INDEX idx_provedor_nombre_unico ON provedor_nombre(nombre);

-- Indice unico en telefono del cliente
CREATE UNIQUE INDEX idx_cliente_telefono_unico ON cliente(telefono);

-- Indice unico en telefono del empleado
CREATE UNIQUE INDEX idx_empleado_telefono_unico ON empleado(telefono);

-- Indice unico en telefono del provedor
CREATE UNIQUE INDEX idx_provedor_telefono_unico ON provedor(telefono);


-- Indices compuestos


-- Indice compuesto en id_producto y nombre_producto en la tabla producto
CREATE INDEX idx_producto_compuesto ON producto(id_producto,nombre_producto);

-- Indice compuesto en id_album, id_producto, nombre_producto en la tabla album producto
CREATE INDEX idx_album_producto_compuesto ON album_producto(id_album,id_producto,nombre_producto);

-- Indice compuesto en id_provedor, id_producto, nombre_producto en la tabla provedor_producto
CREATE INDEX idx_provedor_producto_compuesto ON provedor_producto(id_provedor, id_producto, nombre_producto);

-- Indice compuesto en id_sucursal y id_direccion en la tabla sucursal
CREATE INDEX idx_sucursal_direccion_compuesto ON sucursal(id_sucursal, id_direccion);

-- Indice compuesto en id_cliente, id_direccion y telefono en la tabla cliente
CREATE INDEX idx_cliente_direccion_telefono_compuesto ON cliente(id_cliente,id_direccion, telefono);

-- Indice compuesto en id_empleado, id_direccion, id_sucursal en la tabla empleado
CREATE INDEX idx_empleado_sucusal_direccion_compuesto ON empleado(id_empleado,id_direccion, id_sucursal);


-- Indices de Relaciones de Muchos a Muchos


-- Indice en id_producto, nombre_producto y id_almacen en la tabla producto_almacen
CREATE INDEX idx_producto_almacen_compuesto ON producto_almacen(id_producto,nombre_producto, codigo_barras);

-- Indice en id_producto, nombre_producto y id_compra en la tabla producto_compra
CREATE INDEX idx_producto_compra_compuesto ON producto_compra_material(id_producto, nombre_producto, id_compra);

-- Indice en id_producto, nombre_producto y id_cliente pra la tabla producto_cliente
CREATE INDEX idx_producto_cliente_compuesto ON producto_cliente(id_producto,nombre_producto,id_cliente);

-- Indice en id_producto, nombre_producto y id_sucursal en la tabla producto_sucursal
CREATE INDEX idx_producto_sucrsal_compuesto ON producto_sucursal(id_producto,nombre_producto,id_sucursal);

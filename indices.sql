-- INDICES 

-- Índices en Claves Foráneas

-- Índices para la tabla album_artista
CREATE INDEX IF NOT EXISTS idx_album_artista_album ON album_artista(id_album);
CREATE INDEX IF NOT EXISTS idx_album_artista_artista ON album_artista(id_artista);

-- Índices para la tabla album_genero_musical
CREATE INDEX IF NOT EXISTS idx_album_genero_album ON album_genero_musical(id_album);
CREATE INDEX IF NOT EXISTS idx_album_genero_genero ON album_genero_musical(id_genero_musical);

-- Índices para la tabla album_producto
CREATE INDEX IF NOT EXISTS idx_album_producto_album ON album_producto(id_album);
CREATE INDEX IF NOT EXISTS idx_album_producto_producto ON album_producto(id_producto);

-- Índices para la tabla proveedor_producto
CREATE INDEX IF NOT EXISTS idx_proveedor_producto_proveedor ON proveedor_producto(id_proveedor);
CREATE INDEX IF NOT EXISTS idx_proveedor_producto_producto ON proveedor_producto(id_producto);

-- Índices para la tabla producto_almacen
CREATE INDEX IF NOT EXISTS idx_producto_almacen_producto ON producto_almacen(id_producto);
CREATE INDEX IF NOT EXISTS idx_producto_almacen_almacen ON producto_almacen(id_almacen);

-- Índices para la tabla detalle_compra
CREATE INDEX IF NOT EXISTS idx_detalle_compra_producto ON detalle_compra(id_producto);
CREATE INDEX IF NOT EXISTS idx_detalle_compra_compra ON detalle_compra(id_compra);

-- Índices para la tabla venta
CREATE INDEX IF NOT EXISTS idx_venta_producto ON venta(id_producto);
CREATE INDEX IF NOT EXISTS idx_venta_cliente ON venta(id_cliente);

-- Índices para la tabla producto_sucursal
CREATE INDEX IF NOT EXISTS idx_producto_sucursal_producto ON producto_sucursal(id_producto);
CREATE INDEX IF NOT EXISTS idx_producto_sucursal_sucursal ON producto_sucursal(id_sucursal);

-- Índice para la tabla empleado
CREATE INDEX IF NOT EXISTS idx_empleado_sucursal ON empleado(id_sucursal);

-- Índices de Campos usados frecuentemente en consultas

-- Índice en nombre_producto en la tabla producto
CREATE INDEX IF NOT EXISTS idx_producto_nombre ON producto(nombre_producto);

-- Índice en telefono en cliente (sobre el dato encriptado)
CREATE INDEX IF NOT EXISTS idx_cliente_telefono ON cliente(telefono);

-- Índice en telefono en empleado (sobre el dato encriptado)
CREATE INDEX IF NOT EXISTS idx_empleado_telefono ON empleado(telefono);

-- Índice en telefono en proveedor (sobre el dato encriptado)
CREATE INDEX IF NOT EXISTS idx_proveedor_telefono ON proveedor(telefono);


-- Índices en Campos numéricos

-- Índice en precio en la tabla producto
CREATE INDEX IF NOT EXISTS idx_producto_precio ON producto(precio);

-- Índice de existencia(stock) en la tabla producto
CREATE INDEX IF NOT EXISTS idx_producto_existencia ON producto(existencia);

-- Índice de inventario en la tabla almacen
CREATE INDEX IF NOT EXISTS idx_almacen_inventario ON almacen(inventario);


-- Índices en fechas

-- Índice anio_album en la tabla album
CREATE INDEX IF NOT EXISTS idx_album_anio ON album(anio_album);

-- Índice fecha en la tabla compra
CREATE INDEX IF NOT EXISTS idx_compra_fecha ON compra(fecha);

-- Índice fecha en la tabla venta
CREATE INDEX IF NOT EXISTS idx_venta_fecha ON venta(fecha);


-- Índices en atributos de texto completo

-- Índice de texto completo en descripcion en la tabla producto
CREATE INDEX IF NOT EXISTS idx_producto_descripcion_fulltext ON producto USING gin(to_tsvector('spanish', descripcion));

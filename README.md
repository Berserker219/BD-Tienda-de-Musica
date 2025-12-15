# Base de Datos de Tienda de Música
# Entidades:

- **Álbum**: Cada álbum tiene un nombre único, un año de lanzamiento y se identifica con `id_album`.
- **Artista**: Cada artista tiene un nombre y se identifica con `id_artista`. Un álbum puede estar asociado con varios artistas, y un artista puede participar en múltiples álbumes.
- **Género Musical**: Cada género tiene un nombre único y se identifica con `id_genero_musical`. Un álbum puede pertenecer a uno o más géneros.
- **Producto**: Incluye álbumes para la venta. Cada producto tiene un nombre, descripción, precio, existencias y se identifica con `id_producto`.
- **Proveedor**: Surte los productos a la tienda. Cada proveedor tiene nombre, dirección, ruta de entrega, teléfono y se identifica con `id_proveedor`.
- **Almacén**: Contiene productos listados por código de barras y título. Tienen precio, inventario y se identifican con `id_almacen`.
- **Compra**: Registra las compras de productos a proveedores, con fecha y total. Se identifica con `id_compra`.
- **Detalle Compra**: Vincula los productos con las compras, especificando la cantidad y el costo unitario de cada producto en una compra.
- **Cliente**: Tiene nombre, dirección, teléfono y se identifica con `id_cliente`.
- **Venta**: Registra las ventas de productos a clientes, incluyendo fecha, cantidad y precio de venta. Se identifica con `id_venta`.
- **Sucursal**: Cada sucursal tiene un nombre único, dirección y se identifica con `id_sucursal`.
- **Empleado**: Gestiona las operaciones de las sucursales. Cada empleado tiene nombre, dirección, teléfono y está asociado a una sucursal. Se identifica con `id_empleado`.

# Reglas de Negocio:
# Álbumes:
- Cada álbum debe tener un nombre único (`UNIQUE`).
- El año de lanzamiento es obligatorio.
- Un álbum puede estar relacionado con múltiples artistas y géneros (relaciones *muchos a muchos*).
# Artistas:
- Los nombres de los artistas no son necesariamente únicos, pero se identifican con un `id_artista` único.
# Géneros Musicales:
- Cada género musical debe tener un nombre único (`UNIQUE`).
# Productos:
- El precio y las existencias deben actualizarse con cada venta o compra.
- Un producto puede estar asociado a múltiples álbumes.
# Proveedores:
- Todos los campos de contacto y dirección del proveedor son obligatorios.
- Un proveedor puede suministrar múltiples productos.
# Almacén:
- El `codigo_barras` debe ser un número de 8 a 9 dígitos.
- La combinación de `codigo_barras` y `titulo` debe ser única.
# Compras:
- Cada compra debe registrar una fecha y un total.
- El detalle de la compra debe incluir la cantidad y el costo unitario de cada producto.
# Clientes:
- Los datos de contacto del cliente, incluyendo dirección y teléfono, deben estar actualizados.
- Se recomienda que el número de teléfono siga un formato estándar.
# Ventas:
- Cada venta debe estar asociada a un cliente y un producto.
- Se debe registrar la fecha, cantidad y precio de venta de cada transacción.
# Sucursales:
- Cada sucursal debe tener un nombre único (`UNIQUE`) y una dirección.
- Las sucursales gestionan inventarios de productos de forma independiente.
# Empleados:
- Cada empleado debe estar asociado a una única sucursal.
- Se debe mantener un registro de las actividades de los empleados para fines de auditoría.

**Nota**: Para generar un diagrama de entidad-relación actualizado, por favor, utilice el script `Creacion-Integridad.sql` con una herramienta de modelado de bases de datos.

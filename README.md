# Base de Datos de Tienda de Música
#Entidades:

- Álbum: Cada álbum tiene un nombre y un año de lanzamiento.
- Artistas: Cada artista tiene un nombre. Un álbum puede estar asociado con varios artistas, y un artista puede participar en múltiples álbumes.
- Géneros Musicales: Cada álbum pertenece a uno o más géneros musicales. Los géneros están categorizados con nombres únicos.
- Producto: Los productos incluyen álbumes que están disponibles para la venta. Cada producto tiene un nombre, una descripción, un precio y una cantidad en existencia. Un producto puede estar relacionado 
             con varios álbumes.
- Proveedores: Los proveedores surten los productos a la tienda. Cada proveedor tiene una dirección, un nombre y un número de ruta para las entregas.
- Almacén: Cada almacén contiene productos listados por código de barras. Los productos en el almacén tienen un título, un precio y un inventario asociado. Los productos pueden estar almacenados en 
            múltiples ubicaciones.
- Compras de Material: La tienda puede realizar compras de materiales, registrando la fecha y el total de la compra. Cada compra está relacionada con los productos comprados.
- Clientes: Los clientes tienen nombres, direcciones y números de teléfono. Un cliente puede adquirir múltiples productos.
- Sucursales: La tienda puede tener varias sucursales, y cada sucursal tiene una dirección asociada.
- Empleados: Los empleados gestionan las operaciones de las sucursales. Cada empleado tiene un nombre, dirección y está asociado a una sucursal específica.

# Reglas de Negocio:
# Álbumes:
Cada álbum debe tener un nombre único y estar asociado con una o más fechas de lanzamiento.
Un álbum puede estar relacionado con múltiples artistas y géneros musicales.
La información del álbum se debe mantener actualizada en caso de que un artista o género se actualice o elimine.
# Artistas:
Los artistas pueden estar asociados a múltiples álbumes, ya sea como solistas o en colaboración.
Los artistas deben tener un nombre registrado, y pueden tener alias o seudónimos que deben ser almacenados para futuras referencias.
# Géneros Musicales:
Los géneros musicales pueden clasificarse de manera que cada género tenga un nombre único.
Un álbum puede pertenecer a varios géneros simultáneamente.
# Productos:
Cada producto tiene un precio asociado y un inventario que se debe actualizar cada vez que se realiza una venta o compra.
Un producto puede estar relacionado con múltiples álbumes, y cada relación debe ser única.
Los productos deben estar identificados por su nombre y su código de producto.
# Proveedores:
Los proveedores pueden suministrar varios productos a la tienda.
Cada proveedor debe tener un nombre, dirección y ruta registrados en el sistema para facilitar el envío de productos.
Los proveedores y sus productos asociados deben ser actualizados cuando cambie la relación de suministro o cuando se actualicen los productos.
# Almacén:
Los productos en el almacén deben estar identificados por su código de barras único y su título.
Los productos deben tener un inventario que se actualice cada vez que se realice una compra o se agregue nuevo stock.
Cada almacén puede tener múltiples productos, y los productos pueden estar ubicados en múltiples almacenes.
# Compras:
Las compras de materiales deben registrar la fecha de la transacción y el total gastado.
Los productos comprados deben estar vinculados a la compra registrada, manteniendo la trazabilidad de cada transacción.
# Clientes:
Los clientes deben tener un nombre único y sus datos de contacto, incluyendo la dirección y teléfono, actualizados.
Un cliente puede comprar múltiples productos, y cada compra debe ser registrada en el sistema.
Los números de teléfono de los clientes deben cumplir con un formato estándar de 10 dígitos.
# Sucursales:
Cada sucursal debe tener una dirección registrada y un nombre único para su identificación.
Las sucursales pueden gestionar productos y empleados, y deben mantener inventarios independientes.
# Empleados:
Los empleados están asociados a una sucursal específica y deben tener un nombre y dirección registrados.
Los empleados gestionan las ventas, las compras y los inventarios en la sucursal correspondiente.
Se debe llevar un registro de las actividades de los empleados para auditorías y gestión.

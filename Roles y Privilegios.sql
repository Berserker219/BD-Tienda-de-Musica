-- Creacion de de roles y asignacion de privilegios



/* Administrador de Base de Datos
Descripción: Este rol tiene el control total sobre la base de datos,
			 incluye la creación y eliminación de tablas, la gestión de roles y el acceso
			 a todos los datos.

Permisos: 
		  - Todos los privilegios en todas las tablas y esquemas.
		  - Crear y eliminar tablas.
		  - Crear y gestionar usuarios y roles.
		  - Administrar backups y restauraciones.
		  - Control completo sobre las politicas de seguridad.
*/

-- Creación de rol db_admin
CREATE ROLE db_admin WITH LOGIN PASSWORD 'EWl_>k\r';
-- Asignación de privilegios
GRANT ALL PRIVILEGES ON DATABASE TIENDA_MUSICA TO db_admin;



/* Gestor de inventarios
Descripción: Este rol se encargará de gestioinar los productos, provedores, y el almacen.

Permisos:
		  - Permisos de lectura y escritura(SELECT, INSERT, UPDATE, DELETE) en las tablas 
		    relacionadas con productos, provedores, compra_material, almacen, artista, genero_musical
*/

-- Creación de rol gestor_inventario
CREATE ROLE gestor_inventario WITH LOGIN PASSWORD 'JLos+~7E';
-- Asignación de privilegios
--Permisos para gestionar inventarios
GRANT SELECT, INSERT, UPDATE, DELETE ON producto, provedor, almacen, compra_material TO gestor_inventario;
-- Permisos para las tablas relacionadas con provedores
GRANT SELECT, INSERT, UPDATE, DELETE ON provedor_direccion, provedor_ruta, provedor_nombre TO gestor_inventario;
-- Permisos para gestionar relaciones entre provedores y productos 
GRANT SELECT, INSERT, UPDATE, DELETE ON provedor_producto TO gestor_inventario;
-- Permisos para gestionar relaciones entre productos, compra_material, almacen 
GRANT SELECT, INSERT, UPDATE, DELETE ON producto_almacen, producto_compra_material TO gestor_inventario;



/* Gestor de Clientes
Descripción: Este roll gestiona la información relacionada con los clientes y sus compras.

Permisos: 
		  - SELECT, INSERT, UPDATE, DELETE en tablas de clientes y
		    compras de productos:
				- Cliente
				- Producto_cliente
				- Cliente_nombre
				- Cliente_dirección
		  - No puede modificar la estructura de las tablas, solo los datos.
*/

-- Creación de rol gestor_cliente
CREATE ROLE gestor_cliente WITH LOGIN PASSWORD 'PpGiL%n;';
-- Permisos para gestionar cliente y tablas relacionadas 
GRANT SELECT, INSERT, UPDATE, DELETE ON cliente, cliente_nombre, cliente_direccion TO gestor_cliente;
-- Permisos para gestionar relaciones entre cliente y producto (compras)
GRANT SELECT, INSERT, UPDATE, DELETE ON producto_cliente TO gestor_cliente;



/* Gestor de Sucursales
Descripción: Este rol gestiona los datos relacionados con las sucursales y empleados.

Permisos:
		  - SELECT, INSERT, UPDATE, DELETE en tablas relacionadas con sucursales
		    y empleados:
				-Sucursal
				-Sucursal_dirección
				-Producto_sucursal
				-Empleado
				-Empleado_nombre
				-Empleado_dirección
		  - No puede modificar la estructura de las tablas, solo los datos.
*/

-- Creación de rol gestor_sucursal
CREATE ROLE gestor_sucursal WITH LOGIN PASSWORD 'X</!,CT+';
-- Permisos para gestionar sucursal y tablas relacionadas
GRANT SELECT, INSERT, UPDATE, DELETE ON sucursal, sucursal_direccion TO gestor_sucursal; 
-- Permisos para gestionar empleados y tablas relacionadas
GRANT SELECT, INSERT, UPDATE, DELETE ON empleado, empleado_nombre, empleado_direccion TO gestor_sucursal;
-- Permisos para gestionar relaciones entre producto y sucursal
GRANT SELECT, INSERT, UPDATE, DELETE ON producto_sucursal TO gestor_sucursal;



/* Lectores de Datos (data_reader)
Descrición: Este rol solo puede consultar datos, pero no puede modificarlos.

Permisos:
		  - SELECT en todas las tablas de la base de datos, pero sin permisos 
		    de modificaión o eliminación.
*/

-- Creación de rol data_reader
CREATE ROLE data_reader WITH LOGIN PASSWORD 'v]P7=C1x';
-- Permisos para el rol data_reader
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO data_reader;



/* Auditor
Decripción: Este rol tiene acceso para leer todas las tablas con fines
		 	de auditoría y análisis de datos, pero no puede modificar ni eliminar nada.

Permisos:
		  - SELECT en todas las tablas de la base de datos.
		  - Permisos adicionales para consultar logs si tienes un sistema de auditoría configurado.
*/

-- Creación de rol auditor
CREATE ROLE auditor WITH LOGIN PASSWORD '*Gc#4\m~';
-- Permisos para gestionar el rol auditor
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO auditor;



/* Usuario de Mantenimiento
Descripción: Se encarga de realizar tareas de mantenimiento como verificar la
			 integridad de los datos y ejecutar scripts especificos.

Permisos:
		  - SELECT, UPDATE, INSERT en tablas específicas, como las de logs,
		    productos y almacenes.
		  - No tiene permisos para eliminar datos ni modificar estructuras.
*/

-- Creación de rol usuario_mantenimiento
CREATE ROLE usuario_mantenimiento WITH LOGIN PASSWORD 'iB]co5$v';
-- Permisos para gestionar el rol usuario_mantenimiento
GRANT SELECT, INSERT, UPDATE ON ALL TABLAS IN SCHEMA PUBLIC TO usuario_mantenimiento;
CREATE TABLE TIENDA
(
	Nif VARCHAR2(10),
	Nombre VARCHAR2(20),
	Direccion VARCHAR2(20),
	Poblacion VARCHAR2(20),
	provincia VARCHAR2(20),
	codpostal VARCHAR2(5),
	CONSTRAINT PK_TIENDA PRIMARY KEY (Nif),
	CONSTRAINT CK_Provincia_Mayus CHECK (Provincia = UPPER(Provincia))
);

CREATE TABLE FABRICANTES
(
	Cod_fabricante NUMBER(3),
	Nombre VARCHAR2(15),
	Pais VARCHAR2(15),
	CONSTRAINT PK_FABRICANTES PRIMARY KEY (Cod_fabricante),
	CONSTRAINT CK_Mayus CHECK (Nombre = UPPER(Nombre) AND Pais = UPPER(Pais))
);

CREATE TABLE ARTICULOS
(
	Articulo VARCHAR2(20),
	Cod_fabricante NUMBER(3),
	Peso NUMBER(3),
	Categoria VARCHAR2(10),
	Precio_venta NUMBER(4, 2),
	Precio_costo NUMBER(4,2),
	Existencias NUMBER(5),
	CONSTRAINT PK_ARTICULOS PRIMARY KEY (Articulo, Cod_fabricante, Peso, Categoria),
	CONSTRAINT FK_Cod_Fabricante FOREIGN KEY (Cod_fabricante) REFERENCES FABRICANTES (Cod_fabricante)
);

CREATE TABLE PEDIDOS
(
	Nif VARCHAR2(10),
	Articulo VARCHAR2(20),
	Cod_fabricante NUMBER(3),
	Peso NUMBER(3),
	Categoria VARCHAR2(10),
	Fecha_pedido DATE,
	Unidades_pedidas NUMBER(4),
	CONSTRAINT PK_PEDIDOS PRIMARY KEY (Nif, Articulo, Cod_fabricante, Peso, Categoria, Fecha_pedido),
	CONSTRAINT FK_Fabricante FOREIGN KEY (Cod_fabricante) REFERENCES FABRICANTES (Cod_fabricante),
	CONSTRAINT FK_Articulos FOREIGN KEY (Articulo, Cod_fabricante, Peso, Categoria) REFERENCES ARTICULOS (Articulo, Cod_fabricante, Peso, Categoria) ON DELETE CASCADE,
	CONSTRAINT FK_Tienda_Nif FOREIGN KEY (Nif) REFERENCES TIENDA (Nif),
	CONSTRAINT CK_Unidades_Mayor0 CHECK (Unidades_pedidas > 0)
);

CREATE TABLE VENTAS
(
	Nif VARCHAR2(10),
	Articulo VARCHAR2(20),
	Cod_fabricante NUMBER(2),
	Peso NUMBER(3),
	Categoria VARCHAR2(10),
	Fecha_venta DATE DEFAULT SYSDATE,
	Unidades_vendidas NUMBER(4),
	CONSTRAINT PK_VENTAS PRIMARY KEY (Nif, Articulo, Cod_fabricante, Peso, Categoria, Fecha_venta),
	CONSTRAINT FK_Ventas FOREIGN KEY (Cod_fabricante) REFERENCES FABRICANTES (Cod_fabricante),
	CONSTRAINT CK_Unidades_VendidasMayor0 CHECK (Unidades_vendidas > 0),
	CONSTRAINT FK_Ventas_Articulo FOREIGN KEY (Articulo, Cod_fabricante, Peso, Categoria) REFERENCES ARTICULOS (Articulo, Cod_fabricante, Peso, Categoria) ON DELETE CASCADE
);

--1.Modificar las columnas de las tablas pedidos y ventas para que lasunidades_vendidas y las unidades_pedidas puedan almacenar cantidades numéricasde 6 dígitos.
ALTER TABLE VENTAS MODIFY Unidades_vendidas NUMBER(6);
ALTER TABLE PEDIDOS MODIFY Unidades_pedidas NUMBER(6);

--2.Añadir a las tablas pedidos y ventas una nueva columna para que almacenen el PVP del artículo.
ALTER TABLE VENTAS ADD PVP NUMBER(3, 2);
ALTER TABLE PEDIDOS ADD PVP NUMBER(3, 2);

--3.Borra la columna pais de la tabla fabricante.
ALTER TABLE FABRICANTES DROP CONSTRAINT CK_Mayus;
ALTER TABLE FABRICANTES DROP COLUMN Pais;

--4.Añade una restricción que indique que las unidades vendidas son como mínimo 100
ALTER TABLE VENTAS ADD CONSTRAINT CK_Unidades_Vendidas_Mayor100 CHECK (Unidades_vendidas > 100);

--5.Borra la restricción anterior
ALTER TABLE VENTAS DROP CONSTRAINT CK_Unidades_Vendidas_Mayor100

--6.Borra todas las tablas creadas.
DROP TABLE TIENDA CASCADE CONSTRAINTS;
DROP TABLE FABRICANTES CASCADE CONSTRAINTS;
DROP TABLE ARTICULOS CASCADE CONSTRAINTS;
DROP TABLE PEDIDOS CASCADE CONSTRAINTS;
DROP TABLE VENTAS CASCADE CONSTRAINTS;







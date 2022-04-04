CREATE TABLE fabricante
(
	codigo INT(10) AUTO_INCREMENT,
	nombre VARCHAR(100),
	CONSTRAINT PK_FABRICANTE PRIMARY KEY (codigo)
);

CREATE TABLE producto
(
	codigo INT(10) AUTO_INCREMENT,
	nombre VARCHAR(100),
	precio DOUBLE,
	codigo_fabricante INT(10),
	CONSTRAINT PK_PRODUCTO PRIMARY KEY (codigo),
	CONSTRAINT FK_Codigo_Fab FOREIGN KEY (codigo_fabricante) REFERENCES fabricante (codigo)
);

--Insertar datos en tabla fabricante
INSERT INTO fabricante
VALUES (1, 'Asus');

INSERT INTO fabricante
VALUES (2, 'Lenovo');

INSERT INTO fabricante
VALUES (3, 'Hewlett-Packard');

INSERT INTO fabricante
VALUES (4, 'Samsung');

INSERT INTO fabricante
VALUES (5, 'Seagate');

INSERT INTO fabricante
VALUES (6, 'Crucial'); 

INSERT INTO fabricante
VALUES (7, 'Gigabyte'); 

INSERT INTO fabricante
VALUES (8, 'Huawei');

INSERT INTO fabricante
VALUES (9, 'Xiaomi'); 

--Insertar datos en tabla producto
INSERT INTO producto
VALUES (1, 'Disco duro SATA3 1TB', 86.99, 5);

INSERT INTO producto
VALUES (2, 'Memoria RAM DDR4 8GB', 120, 6);

INSERT INTO producto
VALUES (3, 'Disco SSD 1 TB', 150.99, 4);

INSERT INTO producto
VALUES (4, 'GeForce GTX 1050Ti', 150.99, 4);

INSERT INTO producto
VALUES (5,'GeForce GTX 1050 Xtreme', 185, 7);

INSERT INTO producto
VALUES (6,'Monitor 24 LED Full HD', 202, 1);

INSERT INTO producto
VALUES (7,'Monitor 27 LED Full HD', 245.99, 1);

INSERT INTO producto
VALUES (8,'Portátil Yoga 520', 559, 2);

INSERT INTO producto
VALUES (9,'Portátil Ideapd 320', 444, 2);

INSERT INTO producto
VALUES (10,'Impresora HP Deskjet 3720', 59.99, 3);

INSERT INTO producto
VALUES (11,'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1.Inserta un nuevo fabricante indicando su código y su nombre
INSERT INTO fabricante
VALUES (10, 'Apple');
-- 2.Inserta un nuevo fabricante indicando solamente su nombre.
INSERT INTO fabricante (nombre)
VALUES ('MSI');

-- 3.Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: código, nombre, precio y código_fabricante.
INSERT INTO producto
VALUES (12, 'Mac', 1200, 10);

SELECT * FROM fabricante
-- 4.Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: nombre, precio y código_fabricante.
INSERT INTO producto (nombre, precio, codigo_fabricante)
VALUES ('MSI GT76 Titan', 4186.34, 11);

-- 5.Elimina el fabricante Asus. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
-- No se puede eliminar ya que es un FOREIGN KEY.
-- Solucion:
ALTER TABLE producto DROP CONSTRAINT FK_Codigo_Fab;
ALTER TABLE producto ADD CONSTRAINT Fk_Codigo_Fab FOREIGN KEY (codigo_fabricante) REFERENCES fabricante (codigo) ON DELETE CASCADE;
SELECT * FROM fabricante;
SELECT * FROM producto;
DELETE FROM fabricante
WHERE nombre = 'Asus';

-- 6.Elimina el fabricante Xiaomi. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
DELETE FROM fabricante
WHERE nombre = 'Xiaomi';

-- 7.Actualiza el código del fabricante Lenovo y asígnale el valor 20. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
ALTER TABLE producto DROP CONSTRAINT FK_Codigo_Fab;
ALTER TABLE producto ADD CONSTRAINT Fk_Codigo_Fab FOREIGN KEY (codigo_fabricante) REFERENCES fabricante (codigo) ON UPDATE CASCADE;
UPDATE fabricante
SET codigo = 20
WHERE nombre = 'Lenovo';

-- 8.Actualiza el código del fabricante Huawei y asígnale el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
UPDATE fabricante
SET codigo = 30
WHERE nombre = 'Huawei';

-- 9.Actualiza el precio de todos los productos sumándole 5€ al precio actual.
UPDATE producto
SET precio = precio + 5;

-- 10.Elimina todas las impresoras que tienen un precio menor de 200 €.
SELECT * FROM producto
WHERE upper(nombre) LIKE upper('%Impresora%')

DELETE FROM producto
WHERE upper(nombre) LIKE upper('%Impresora%') AND precio < 200;

SELECT * FROM producto
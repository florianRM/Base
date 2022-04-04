CREATE TABLE DEPARTAMENTO
(
	codigo NUMBER(10),
	nombre VARCHAR2(100),
	presupuesto NUMBER(10,2),
	gastos NUMBER(10, 2),
	CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO
(
	codigo NUMBER(10),
	nif VARCHAR2(9),
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	codigo_departamento NUMBER(10),
	CONSTRAINT PK_EMPLEADO PRIMARY KEY (codigo),
	CONSTRAINT FK_Codigo_Dep FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo)
);


--Insertar datos de departamento
INSERT INTO DEPARTAMENTO
VALUES (1, 'Desarrollo', 120000, 6000);

INSERT INTO DEPARTAMENTO
VALUES (2, 'Sistemas', 150000, 21000);

INSERT INTO DEPARTAMENTO
VALUES (3, 'Recursos Humanos', 280000, 25000);

INSERT INTO DEPARTAMENTO
VALUES (4, 'Contabilidad', 110000, 3000);

INSERT INTO DEPARTAMENTO
VALUES (5, 'I+D', 375000, 380000);

INSERT INTO DEPARTAMENTO
VALUES (6, 'Proyectos', 0, 0);

INSERT INTO DEPARTAMENTO
VALUES (7, 'Publicidad', 0, 1000);


--Insertar datos de empleado
INSERT INTO EMPLEADO
VALUES (1,'32481596F','Aarón','Rivero','Gómez',1);

INSERT INTO EMPLEADO
VALUES (2,'Y5575632D','Adela','Salas','Díaz',2);

INSERT INTO EMPLEADO
VALUES (3,'R6970642B','Adolfo','Rubio','Flores',3);

INSERT INTO EMPLEADO
VALUES (4,'77705545E','Adrián','Suárez',NULL,4);

INSERT INTO EMPLEADO
VALUES (5,'17087203C','Marcos','Loyola','Méndez',5);

INSERT INTO EMPLEADO
VALUES (6,'38382980M','María','Santana','Moreno',1);

INSERT INTO EMPLEADO
VALUES (7,'80576669X','Pilar','Ruiz',NULL,2);

INSERT INTO EMPLEADO
VALUES (8,'71651431Z','Pepe','Ruiz','Santana',3);

INSERT INTO EMPLEADO
VALUES (9,'56399183D','Juan','Gómez','López',2);

INSERT INTO EMPLEADO
VALUES (10,'46384486H','Diego','Flores','Salas',5);

INSERT INTO EMPLEADO
VALUES (11,'67389283A','Marta','Herrera','Gil',1);

INSERT INTO EMPLEADO
VALUES (12,'41234836R','Irene','Salas','Flores',NULL);

INSERT INTO EMPLEADO
VALUES (13,'82635162B','JuanAntonio','Sáez','Guerrero',NULL);

--1.Inserta un nuevo departamento indicando su código, nombre y presupuesto.
INSERT INTO DEPARTAMENTO
VALUES (8, 'Directivo', 800000, NULL)

--2.Inserta un nuevo departamento indicando sunombreypresupuesto.

--3.Inserta un nuevo departamento indicando su código, nombre,presupuesto y gastos.
INSERT INTO DEPARTAMENTO
VALUES (9, 'Conserje', 40000, 200);

--4.Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción debe incluir: código, nif, nombre, apellido1, apellido2 y codigo_departamento.
INSERT INTO EMPLEADO
VALUES (14, '8743563F', 'Florian', 'Marian', 'Ristea', 8);

--5.Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción debe incluir: nif, nombre, apellido1, apellido2 y codigo_departamento.

--6.Crea una nueva tabla con el nombre departamento_backup que tenga las mismas columnas que la tabla departamento. Una vez creada copia todos las filas de tabla departamento en departamento_backup.
CREATE TABLE DEPARTAMENTO_BACKUP
(
	codigo NUMBER(10),
	nombre VARCHAR2(100),
	presupuesto NUMBER(10,2),
	gastos NUMBER(10, 2),
	CONSTRAINT PK_DEPARTAMENTO_BACKUP PRIMARY KEY (codigo)
);

INSERT INTO DEPARTAMENTO_BACKUP
SELECT * FROM DEPARTAMENTO;

--7.Elimina el departamento Proyectos. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
DELETE FROM DEPARTAMENTO
WHERE nombre='Proyectos';

--8.Elimina el departamento Desarrollo. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
--No se puede eliminar debido a la constraint
--Solución:
ALTER TABLE EMPLEADO DROP CONSTRAINT FK_Codigo_Dep;
ALTER TABLE EMPLEADO ADD CONSTRAINT FK_Codigo_Dep FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo) ON DELETE CASCADE;

DELETE FROM DEPARTAMENTO
WHERE nombre='Desarrollo';

--9.Actualiza el código del departamento Recursos Humanos y asígnale el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
UPDATE DEPARTAMENTO
SET codigo = 30
WHERE nombre='Recursos Humanos';

--10.Actualiza el código del departamento Publicidad y asígnale el valor 40. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
UPDATE DEPARTAMENTO
SET codigo = 40
WHERE nombre='Publicidad';

--11.Actualiza el presupuesto de los departamentos sumándole 50000 € al valor del presupuesto actual, solamente a aquellos departamentos que tienen un presupuesto menor que 20000 €.
SELECT * FROM DEPARTAMENTO;

UPDATE DEPARTAMENTO
SET presupuesto = presupuesto + 50000
WHERE presupuesto < 20000;

--12.Realiza una transacción que elimine todas los empleados que no tienen un departamento asociado.
SELECT * FROM EMPLEADO WHERE codigo_departamento IS NULL;

DELETE EMPLEADO
WHERE codigo_departamento IS NULL;

SELECT * FROM EMPLEADO;



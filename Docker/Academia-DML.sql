CREATE TABLE PROFESORES
(
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	dni VARCHAR2(9),
	direccion VARCHAR2(100),
	titulo VARCHAR2(100),
	gana NUMBER(10,2),
	CONSTRAINT PK_PROFESORES PRIMARY KEY (dni)
);

CREATE TABLE CURSOS
(
	nombre_curso VARCHAR2(100),
	cod_curso VARCHAR2(2),
	dni_profesor VARCHAR2(9),
	maximo_alumnos NUMBER(2),
	fecha_incio DATE,
	fecha_fin DATE,
	num_horas NUMBER(10),
	CONSTRAINT PK_CURSOS PRIMARY KEY (cod_curso),
	CONSTRAINT FK_Dni_Profesor FOREIGN KEY (dni_profesor) REFERENCES PROFESORES(dni)
);

CREATE TABLE ALUMNOS
(
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	dni VARCHAR2(9),
	direccion VARCHAR2(100),
	sexo VARCHAR2(1),
	fecha_nacimiento DATE,
	curso VARCHAR2(2),
	CONSTRAINT PK_ALUMNOS PRIMARY KEY (dni),
	CONSTRAINT FK_Curso FOREIGN KEY (curso) REFERENCES CURSOS(cod_curso),
	CONSTRAINT CH_Sexo CHECK (sexo IN ('H') OR sexo IN ('M'))
);


--Insertar datos de profesores
INSERT INTO PROFESORES
VALUES ('Juan', 'Arch', 'López', '32432455', 'Puerta Negra, 4', 'Ing. Informática', 7500);  

INSERT INTO PROFESORES
VALUES ('María', 'Oliva', 'Rubio', '43215643', 'Juan Alfonso, 32', 'Lda. Fil. Inglesa', 5400);  

--Insertar datos de cursos
INSERT INTO CURSOS
VALUES ('Inglés Básico', '1', '43215643', 15, TO_DATE('01/11/00', 'dd/mm/yy'), TO_DATE('22/12/2000', 'dd/mm/yyyy'), 120);   

INSERT INTO CURSOS
VALUES ('Administración', '2', '32432455', NULL, TO_DATE('01-09-2000', 'dd/mm/yyyy'), NULL, 80);


--Insertar datos de alumnos
INSERT INTO ALUMNOS
VALUES ('Lucas', 'Manilva', 'López', '123523', 'Alhamar, 3', 'H', TO_DATE('01/11/1979', 'DD/MM/YYYY'), 1);

INSERT INTO ALUMNOS
VALUES ('Antonia', 'López', 'Alcantara', '2567567', 'Maniquí, 21', 'M', NULL,2);

INSERT INTO ALUMNOS
VALUES ('Manuel', 'Alcantara', 'Pedrós','3123689', 'Julian, 2', 'H', NULL,1);

INSERT INTO ALUMNOS
VALUES ('José', 'Pérez', 'Caballar', '4896765', 'Jarcha,5 ', 'H', TO_DATE('03/02/1977', 'DD/MM/YYYY'), 2);

--3. Insertar otro alumno
INSERT INTO ALUMNOS
VALUES ('Sergio', 'Navas', 'Retal', '123523', NULL, 'P', NULL, 1);
--Este modo nos da fallo ya que la Primary Key se repite
--Solucion:
--Cambiamos el DNI para que sea distinto y el sexo ya que debe ser H o M.
INSERT INTO ALUMNOS
VALUES ('Sergio', 'Navas', 'Retal', '123529', NULL, 'H', NULL, 1);

--4. Insertar otro profesor
INSERT INTO PROFESORES
VALUES ('Juan', 'Arch', 'López', '32432455', 'Puerta Negra, 4','Ing. Informática', NULL);
--Este modo nos da fallo ya que la Primary Key se repite
--Solucion:
--Cambiamos el DNI para que sea distinto
INSERT INTO PROFESORES
VALUES ('Juan', 'Arch', 'López', '32432459', 'Puerta Negra, 4','Ing. Informática', NULL);

--5. Insertar otra tabla de estudiante
INSERT INTO ALUMNOS
VALUES ('María', 'Jaén', 'Sevilla', '789678', 'Martos, 5', 'M', NULL, NULL);

--6. La fecha de nacimiento de Antonia López está equivocada. La verdadera es 23 de diciembre de 1976.
UPDATE ALUMNOS
SET fecha_nacimiento = TO_DATE('23/12/1972', 'DD/MM/YYYY')
WHERE nombre = 'Antonia';

--7. Cambiar a Antonia López al curso de código 5.
UPDATE ALUMNOS
SET curso = 5
WHERE nombre = 'Antonia';
--De esta manera nos da error ya que el curso 5 no existe
--Solucion:
UPDATE ALUMNOS
SET curso = 1
WHERE nombre = 'Antonia';
--Introducimos un curso que existe ya como por ejemplo el 1 o el 2.

--8. Eliminar la profesora Laura Jiménez
SELECT * FROM PROFESORES 
WHERE nombre = 'Laura' AND apellido1 = 'Jiménez';

DELETE PROFESORES
WHERE nombre = 'Laura' AND apellido1 = 'Jiménez';
--No hace nada ya que Laura Jiménez no existe

--9. Borrar el curso con código 1.
DELETE CURSOS 
WHERE cod_curso = '1';
--No funciona ya que esta violando una constraint.
--Solución
ALTER TABLE ALUMNOS DROP CONSTRAINT FK_Curso;
ALTER TABLE ALUMNOS ADD CONSTRAINT FK_Curso FOREIGN KEY (curso) REFERENCES CURSOS (cod_curso) ON DELETE CASCADE;

DELETE CURSOS 
WHERE cod_curso = '1';

--10. Añadir un campo llamado numero_alumnos en la tabla curso.
ALTER TABLE CURSOS ADD numero_alumnos NUMBER(4);

--11. Modificar la fecha de nacimiento a 01/01/2012 en aquellos alumnos que no tengan fecha de nacimiento.
SELECT * FROM ALUMNOS
WHERE fecha_nacimiento IS NULL;

UPDATE ALUMNOS
SET fecha_nacimiento = TO_DATE('01/01/2012', 'DD/MM/YYYY')
WHERE fecha_nacimiento IS NULL;

SELECT * FROM ALUMNOS

--12. Borra el campo sexo en la tabla de alumnos.
ALTER TABLE ALUMNOS DROP COLUMN sexo;

--13. Modificar la tabla profesores para que los  profesores de Informática cobren un 20 por ciento más de lo que cobran actualmente.
SELECT gana FROM PROFESORES

UPDATE PROFESORES
SET gana = gana + (gana * 0.2)
WHERE titulo = 'Ing. Informática'

--14. Modifica el dni de Juan Arch a 1234567
SELECT * FROM PROFESORES

UPDATE PROFESORES
SET dni = '1234567'
WHERE nombre = 'Juan' AND gana IS NULL

--15. Modifica el dni de todos los profesores de informática para que tengan el dni 7654321
UPDATE PROFESORES
SET dni = '7654321'
WHERE titulo = 'Ing. Informática'
--No nos permite hacer esto ya que no pueden tener la misma clave primaria más de 1 persona.

--16. Cambia el sexo de la alumna María Jaén a F.
UPDATE ALUMNOS
SET sexo = 'F'
WHERE nombre = 'María'
--No se puede ya que anteriormente hemos borrado la columna sexo.
--Solucion:
ALTER TABLE ALUMNOS ADD sexo VARCHAR2(2)

UPDATE ALUMNOS
SET sexo = 'F'
WHERE nombre = 'María'


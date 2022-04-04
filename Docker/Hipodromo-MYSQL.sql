CREATE TABLE CABALLOS
(
	CodCaballo VARCHAR(4),
	Nombre VARCHAR(20) NOT NULL,
	Peso INT(3),
	Fecha_Nacimiento DATE,
	Propietario VARCHAR(25),
	Nacionalidad VARCHAR(20),
	CONSTRAINT PK_CABALLOS PRIMARY KEY (CodCaballo),
	CONSTRAINT CK_Peso_Caballo CHECK (Peso BETWEEN 240 AND 300),
	CONSTRAINT CK_Mayor_Edad CHECK (YEAR(Fecha_Nacimiento) > '2000'),
	CONSTRAINT CK_Nacionalidad_Mayus CHECK (Nacionalidad = UPPER(Nacionalidad))
);

CREATE TABLE CARRERAS
(
	CodCarrera VARCHAR(4),
	Fecha_Y_Hora DATETIME,
	Importe_Premio INT(6),
	Apuesta_Limite DECIMAL(5, 2),
	CONSTRAINT PK_CARRERAS PRIMARY KEY (CodCarrera),
	CONSTRAINT CK_Restriccion_Hora CHECK (TIME(Fecha_Y_Hora) >= '09:00' AND TIME(Fecha_Y_Hora) <= '14:30'),
	CONSTRAINT CK_Limite_Apuesta CHECK (Apuesta_Limite < 20000)
);

CREATE TABLE PARTICIPACIONES
(
	CodCaballo VARCHAR(4),
	CodCarrera VARCHAR(4),
	Dorsal INT(2) NOT NULL,
	Jockey VARCHAR(10) NOT NULL,
	PosicionFinal INT(2),
	CONSTRAINT PK_PARTICIPACIONES PRIMARY KEY (CodCaballo, CodCarrera),
	CONSTRAINT FK_CodCaballo FOREIGN KEY (CodCaballo) REFERENCES CABALLOS(CodCaballo),
	CONSTRAINT FK_CodCarrera FOREIGN KEY (CodCarrera) REFERENCES CARRERAS(CodCarrera),
	CONSTRAINT CK_Posicion_Mayor0 CHECK (PosicionFinal > 0)
);

CREATE TABLE CLIENTES
(
	DNI VARCHAR(10),
	Nombre VARCHAR(20),
	Nacionalidad VARCHAR(20),
	CONSTRAINT PK_CLIENTES PRIMARY KEY (DNI),
	CONSTRAINT CK_Formato_DNI CHECK (regexp_like(DNI, '[0-9]{8}[A-Z]{1}')),
	CONSTRAINT CK_Nacionalidad_Mayuscula CHECK (Nacionalidad = UPPER(Nacionalidad))
);

CREATE TABLE APUESTAS
(
	DNICliente VARCHAR(10),
	CodCaballo VARCHAR(4),
	CodCarrera VARCHAR(4),
	Importe INT(6) DEFAULT 300 NOT NULL,
	Tantoporuno DECIMAL(4, 2),
	CONSTRAINT PK_APUESTAS PRIMARY KEY (DNICliente, CodCaballo, CodCarrera),
	CONSTRAINT FK_Dni FOREIGN KEY (DNICliente) REFERENCES CLIENTES(DNI) ON DELETE CASCADE,
	CONSTRAINT FK_CodCaballo_Apuestas FOREIGN KEY (CodCaballo) REFERENCES CABALLOS(CodCaballo) ON DELETE CASCADE,
	CONSTRAINT FK_CodCarrera_Apuestas FOREIGN KEY (CodCarrera) REFERENCES CARRERAS(CodCarrera) ON DELETE CASCADE,
	CONSTRAINT CK_Mayor_A_1 CHECK (Tantoporuno > 1)
);

-- 2. Inserta el registro o registros necesarios para guardar la siguiente información:
       
-- El cliente escocés realiza una apuesta al caballo más pesado de la primera carrera que se corra en el verano de 2009 por 
-- un importe de 2000 euros. En ese momento ese caballo en esa carrera se paga 30 a 1.
-- Si es necesario algún dato invéntatelo, pero sólo los datos que sean estrictamente necesaria.

INSERT INTO CLIENTES (DNI, Nacionalidad)
VALUES ('45678455F', 'ESCOCÉS');

INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora)
VALUES ('1234', '2009-06-09 08:00');

INSERT INTO CABALLOS (CodCaballo, Nombre, Peso)
VALUES ('12', 'Pegaso', 290);

INSERT INTO APUESTAS 
VALUES ('45678455F', '12', '1234', 2000, 30);

-- Inscribe a 2 caballos  en la carrera cuyo código es C6. La carrera aún no se ha celebrado. 
-- Invéntate los jockeys y los dorsales y los caballos.
INSERT INTO CARRERAS (CodCarrera)
VALUES ('C6')

INSERT INTO CABALLOS (CodCaballo, Nombre)
VALUES ('342', 'Rayo')

INSERT INTO PARTICIPACIONES (CodCaballo, CodCarrera, Dorsal, Jockey)
VALUES ('12', 'C6', '42', 'Raul')

INSERT INTO PARTICIPACIONES (CodCaballo, CodCarrera, Dorsal, Jockey)
VALUES ('342', 'C6', '22', 'John')

-- 3. Inserta dos carreras con los datos que creas necesario.
INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora, Importe_Premio)
VALUES ('B12', '2020-06-14 9:00', 6000)

INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora, Importe_Premio)
VALUES ('D45', '2020-06-14 12:30', 3000)

-- 4. Quita el campo propietario de la tabla caballos
ALTER TABLE CABALLOS DROP COLUMN Propietario

-- 5. Añadir las siguientes restricciones a las tablas:
-- En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en mayúsculas.

-- La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
-- ALTER TABLE CARRERAS DROP CONSTRAINT CK_Restriccion_Hora
-- ALTER TABLE CARRERAS ADD CONSTRAINT CK_Restriccion_Fecha CHECK (DATE(Fecha_Y_Hora) >= '0000-03-10' AND DATE(Fecha_Y_Hora) <= '0000-11-10') 
-- Da error de violación de constraint.

-- La nacionalidad de los caballos sólo puede ser Española, Británica o Árabe.
ALTER TABLE CABALLOS ADD CONSTRAINT CK_Nacionalidad_Caballo CHECK (UPPER(Nacionalidad) IN ('ESPAÑOL', 'BRITÁNICO', 'ÁRABE'))

-- Borra las carreras en las que no hay caballos inscritos.
SELECT * FROM PARTICIPACIONES 
WHERE CodCaballo IS NULL

DELETE FROM PARTICIPACIONES
WHERE CodCaballo IS NULL
-- En este caso no el delete no haria nada porque no hay ninguna carrera sin caballos.

-- Añade un campo llamado código en el campo clientes, que no permita valores nulos ni repetidos
ALTER TABLE CLIENTES ADD Codigo VARCHAR(10);
ALTER TABLE CLIENTES ADD CONSTRAINT UC_Codigo UNIQUE(Codigo);

-- Nos hemos equivocado y el código C6 de la carrera en realidad es C66.
ALTER TABLE PARTICIPACIONES DROP CONSTRAINT FK_CodCarrera;
ALTER TABLE PARTICIPACIONES ADD CONSTRAINT FK_CodCarrera FOREIGN KEY (CodCarrera) REFERENCES CARRERAS(CodCarrera) ON UPDATE CASCADE;

UPDATE CARRERAS 
SET CodCarrera = 'C66'
WHERE CodCarrera = 'C6';
-- No nos deja ya que viola un restricción de foreign key ya que ese código esta intrducido en otra tabla.

-- Añade un campo llamado premio a la tabla apuestas.
ALTER TABLE APUESTAS ADD Premio INT(10)

-- Borra todas las tablas y datos con el número menor de instrucciones posibles.
DROP TABLE IF EXISTS CLIENTES, PARTICIPACIONES, CABALLOS, CARRERAS, APUESTAS


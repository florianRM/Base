CREATE TABLE CABALLOS
(
	CodCaballo VARCHAR2(4),
	Nombre VARCHAR2(20) NOT NULL,
	Peso NUMBER(3),
	Fecha_Nacimiento DATE,
	Propietario VARCHAR2(25),
	Nacionalidad VARCHAR2(20),
	CONSTRAINT PK_CABALLOS PRIMARY KEY (CodCaballo),
	CONSTRAINT CK_Peso_Caballo CHECK (Peso BETWEEN 240 AND 300),
	CONSTRAINT CK_Mayor_Edad CHECK (TO_CHAR(Fecha_Nacimiento, 'YYYY') > '2000'),
	CONSTRAINT CK_Nacionalidad_Mayus CHECK (Nacionalidad = UPPER(Nacionalidad))
);

CREATE TABLE CARRERAS
(
	CodCarrera VARCHAR2(4),
	Fecha_Y_Hora DATE,
	Importe_Premio NUMBER(6),
	Apuesta_Limite NUMBER(5, 2),
	CONSTRAINT PK_CARRERAS PRIMARY KEY (CodCarrera),
	CONSTRAINT CK_Restriccion_Hora CHECK (TO_CHAR(Fecha_Y_Hora, 'HH:MI') BETWEEN '09:00' AND '14:30'),
	CONSTRAINT CK_Limite_Apuesta CHECK (Apuesta_Limite < 20000)
);

CREATE TABLE PARTICIPACIONES
(
	CodCaballo VARCHAR2(4),
	CodCarrera VARCHAR2(4),
	Dorsal NUMBER(2) NOT NULL,
	Jockey VARCHAR2(10) NOT NULL,
	PosicionFinal NUMBER(2),
	CONSTRAINT PK_PARTICIPACIONES PRIMARY KEY (CodCaballo, CodCarrera),
	CONSTRAINT FK_CodCaballo FOREIGN KEY (CodCaballo) REFERENCES CABALLOS(CodCaballo),
	CONSTRAINT FK_CodCarrera FOREIGN KEY (CodCarrera) REFERENCES CARRERAS(CodCarrera),
	CONSTRAINT CK_Posicion_Mayor0 CHECK (PosicionFinal > 0)
);

CREATE TABLE CLIENTES
(
	DNI VARCHAR2(10),
	Nombre VARCHAR2(20),
	Nacionalidad VARCHAR2(20),
	CONSTRAINT PK_CLIENTES PRIMARY KEY (DNI),
	CONSTRAINT CK_Formato_DNI CHECK (regexp_like(DNI, '[0-9]{8}[A-Z]{1}')),
	CONSTRAINT CK_Nacionalidad_Mayuscula CHECK (Nacionalidad = UPPER(Nacionalidad))
);

CREATE TABLE APUESTAS
(
	DNICliente VARCHAR2(10),
	CodCaballo VARCHAR2(4),
	CodCarrera VARCHAR2(4),
	Importe NUMBER(6) DEFAULT 300 NOT NULL,
	Tantoporuno NUMBER(4, 2),
	CONSTRAINT PK_APUESTAS PRIMARY KEY (DNICliente, CodCaballo, CodCarrera),
	CONSTRAINT FK_Dni FOREIGN KEY (DNICliente) REFERENCES CLIENTES(DNI) ON DELETE CASCADE,
	CONSTRAINT FK_CodCaballo_Apuestas FOREIGN KEY (CodCaballo) REFERENCES CABALLOS(CodCaballo) ON DELETE CASCADE,
	CONSTRAINT FK_CodCarrera_Apuestas FOREIGN KEY (CodCarrera) REFERENCES CARRERAS(CodCarrera) ON DELETE CASCADE,
	CONSTRAINT CK_Mayor_A_1 CHECK (Tantoporuno > 1)
);

--2. Inserta el registro o registros necesarios para guardar la siguiente informaci�n:
       
--El cliente escoc�s realiza una apuesta al caballo m�s pesado de la primera carrera que se corra en el verano de 2009 por 
--un importe de 2000 euros. En ese momento ese caballo en esa carrera se paga 30 a 1.
--Si es necesario alg�n dato inv�ntatelo, pero s�lo los datos que sean estrictamente necesaria.

INSERT INTO CLIENTES (DNI, Nacionalidad)
VALUES ('45678455F', 'ESCOCÉS');

INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora)
VALUES ('1234', TO_DATE('09/06/2009 09:00', 'DD/MM/YYYY HH:MI'));

INSERT INTO CABALLOS (CodCaballo, Nombre, Peso)
VALUES ('12', 'Pegaso', 290);

INSERT INTO APUESTAS 
VALUES ('45678455F', '12', '1234', 2000, 30);

--Inscribe a 2 caballos  en la carrera cuyo c�digo es C6. La carrera a�n no se ha celebrado. 
--Inv�ntate los jockeys y los dorsales y los caballos.
INSERT INTO CARRERAS (CodCarrera)
VALUES ('C6')

INSERT INTO CABALLOS (CodCaballo, Nombre)
VALUES ('342', 'Rayo')

INSERT INTO PARTICIPACIONES (CodCaballo, CodCarrera, Dorsal, Jockey)
VALUES ('12', 'C6', '42', 'Raul')

INSERT INTO PARTICIPACIONES (CodCaballo, CodCarrera, Dorsal, Jockey)
VALUES ('342', 'C6', '22', 'John')

--3. Inserta dos carreras con los datos que creas necesario.
INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora, Importe_Premio)
VALUES ('B12', TO_DATE('14/06/2020 9:00', 'DD/MM/YYYY HH:MI'), 6000)

INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora, Importe_Premio)
VALUES ('D45', TO_DATE('14/06/2020 12:30', 'DD/MM/YYYY HH:MI'), 3000)

--4. Quita el campo propietario de la tabla caballos
ALTER TABLE CABALLOS DROP COLUMN Propietario

--5. A�adir las siguientes restricciones a las tablas:
--En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en may�sculas.
ALTER TABLE PARTICIPACIONES ADD CONSTRAINT CK_Iniciales_Mayus CHECK (Jockey = INITCAP(Jockey))

--La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
ALTER TABLE CARRERAS DROP CONSTRAINT CK_Restriccion_Hora
ALTER TABLE CARRERAS ADD CONSTRAINT CK_Restriccion_Fecha CHECK (TO_CHAR(Fecha_Y_Hora, 'DD/MM') >= '10/03')     

INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora)
VALUES ('1234', TO_DATE('09/06/2009 09:00', 'DD/MM/YYYY HH:MI'));

INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora, Importe_Premio)
VALUES ('B12', TO_DATE('14/06/2020 9:00', 'DD/MM/YYYY HH:MI'), 6000)

INSERT INTO CARRERAS (CodCarrera, Fecha_Y_Hora, Importe_Premio)
VALUES ('D45', TO_DATE('14/06/2020 12:30', 'DD/MM/YYYY HH:MI'), 3000)

--La nacionalidad de los caballos s�lo puede ser Espa�ola, Brit�nica o �rabe.
ALTER TABLE CABALLOS ADD CONSTRAINT CK_Nacionalidad_Caballo CHECK (UPPER(Nacionalidad) IN ('ESPA�OL', 'BRIT�NICO', '�RABE'))

--Borra las carreras en las que no hay caballos inscritos.
SELECT * FROM PARTICIPACIONES 
WHERE CodCaballo IS NULL

DELETE FROM PARTICIPACIONES
WHERE CodCaballo IS NULL
--En este caso no el delete no haria nada porque no hay ninguna carrera sin caballos.

--A�ade un campo llamado c�digo en el campo clientes, que no permita valores nulos ni repetidos
ALTER TABLE CLIENTES ADD Codigo VARCHAR2(10);
ALTER TABLE CLIENTES ADD CONSTRAINT UC_Codigo UNIQUE(Codigo);

--Nos hemos equivocado y el c�digo C6 de la carrera en realidad es C66.
UPDATE CARRERAS 
SET CodCarrera = 'C66'
WHERE CodCarrera = 'C6';
--No nos deja ya que viola un restricci�n de foreign key ya que ese c�digo esta intrducido en otra tabla.

--A�ade un campo llamado premio a la tabla apuestas.
ALTER TABLE APUESTAS ADD Premio NUMBER(10)

--Borra todas las tablas y datos con el n�mero menor de instrucciones posibles.
DROP TABLE CLIENTES CASCADE CONSTRAINTS
DROP TABLE PARTICIPACIONES CASCADE CONSTRAINTS
DROP TABLE CARRERAS CASCADE CONSTRAINTS
DROP TABLE CABALLOS CASCADE CONSTRAINTS
DROP TABLE APUESTAS CASCADE CONSTRAINTS

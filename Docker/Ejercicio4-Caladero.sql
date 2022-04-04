CREATE TABLE BARCOS 
(
    matricula VARCHAR2(7),
    nombre VARCHAR2(30),
    clase VARCHAR2(20),
    armador VARCHAR2(20),
    capacidad VARCHAR2(6),
    nacionalidad VARCHAR2(20),
    CONSTRAINT PK_BARCOS PRIMARY KEY (matricula),
--La matrícula de los barcos empieza por dos letras mayúsculas, luego tiene un guión y luego cuatronúmeros
    CONSTRAINT CK_matricula CHECK (regexp_like(matricula, '[A-Z]{2}[-][0-9]{4}'))
);

CREATE TABLE CALADERO
(
    codigo VARCHAR2(30),
    nombre VARCHAR2(30), 
	ubicacion VARCHAR2(30), 
	especie_principal VARCHAR2(20),
	CONSTRAINT PK_CALADERO PRIMARY KEY (codigo),
--El campo nombre y ubicación de la tabla caladero deben estar siempre en mayúsculas.
	CONSTRAINT CK_Mayus_Nombre CHECK (nombre = UPPER(nombre) AND ubicacion = UPPER(ubicacion))
);

CREATE TABLE ESPECIE
(
    codigo VARCHAR2(20), 
	nombre VARCHAR2(30), 
	tipo VARCHAR2(30), 
	cupoporbarco VARCHAR2(30), 
	caladero_principal VARCHAR2(30),
	CONSTRAINT PK_ESPECIE PRIMARY KEY (codigo),
	CONSTRAINT FK_Caladero_Princ FOREIGN KEY (caladero_principal) REFERENCES CALADERO (codigo)
);

ALTER TABLE CALADERO ADD CONSTRAINT FK_Especie_Principal FOREIGN KEY (especie_principal) REFERENCES ESPECIE (codigo);

CREATE TABLE LOTES
(
    codigo VARCHAR2(30),
    matricula VARCHAR2(7),
    numkilos NUMBER(6, 3),
    precioporkilosalida NUMBER(6, 3),
	precioporkiloadjudicado NUMBER(6, 3),
--La fechaventa de la tabla lotes no admite valores nulos.
    fechaventa DATE NOT NULL,
    cod_especie VARCHAR2(20),
    CONSTRAINT PK_LOTES PRIMARY KEY (codigo),
    CONSTRAINT FK_Matricula FOREIGN KEY (matricula) REFERENCES BARCOS (matricula) ON DELETE CASCADE,
    CONSTRAINT FK_Especie_Princ FOREIGN KEY (cod_especie) REFERENCES ESPECIE (codigo) ON DELETE CASCADE,
--El campo precioporkiloadjudicado debe ser mayor que el campo precioporkilosalida.
	CONSTRAINT CK_Precio CHECK (precioporkiloadjudicado > precioporkilosalida),
--El campo numkilos y los campos precio de la tabla lotes deben ser mayor que cero
	CONSTRAINT CK_Kilos_Precios CHECK (numkilos > 0 AND precioporkiloadjudicado > 0 AND precioporkilosalida > 0)
);

CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS 
(
    cod_especie VARCHAR2(20), 
	cod_caladero VARCHAR2(30), 
	fecha_inicial DATE, 
	fecha_final DATE,
	CONSTRAINT PK_FECHAS PRIMARY KEY (cod_especie, cod_caladero),
	CONSTRAINT FK_Cod_Especie FOREIGN KEY (cod_especie) REFERENCES ESPECIE (codigo),
	CONSTRAINT FK_Cod_Caladero FOREIGN KEY (cod_caladero) REFERENCES CALADERO (codigo),
--Hay que tener en cuenta que en ningún caladero se permite ninguna captura de especie desde el 2 defebrero al 28 de marzo
	CONSTRAINT CK_Fecha_Inicial_Restringida CHECK(TO_CHAR(fecha_inicial, 'dd/mm')<'02/02' OR TO_CHAR(fecha_inicial, 'dd/mm')>'28/03'),
	CONSTRAINT CK_Fecha_Final_Restringida CHECK(TO_CHAR(fecha_final, 'dd/mm') < '02/02' OR TO_CHAR(fecha_final, 'dd/mm') > '28/03')
);

--1.Añade un nuevo campo a la tabla caladero que almacene el nombre científico.
ALTER TABLE CALADERO ADD nombre_cientifico VARCHAR2(30);

--2.Inserta dos registros en cada tabla.
INSERT INTO BARCOS (matricula, nombre) VALUES ('HT4567', 'Titanic');
INSERT INTO CALADERO (codigo, nombre) VALUES ('68574H', 'LA RED FELIZ');
INSERT INTO ESPECIE (codigo, nombre) VALUES ('75884758T', 'Trucha');
INSERT INTO LOTES (codigo, fechaventa) VALUES ('634634P', TO_DATE('17-1-2022', 'DD-MM-YYYY'));
INSERT INTO FECHAS_CAPTURAS_PERMITIDAS (cod_especie, cod_caladero) VALUES ('75884758T', '68574H');
SELECT * FROM FECHAS_CAPTURAS_PERMITIDAS;

--3.Borra el campo armador de la tabla barco
ALTER TABLE BARCOS DROP COLUMN armador;

--4.Borra todas las tablas
DROP TABLE BARCOS CASCADE CONSTRAINTS;
DROP TABLE LOTES CASCADE CONSTRAINTS;
DROP TABLE ESPECIE CASCADE CONSTRAINTS;
DROP TABLE CALADERO CASCADE CONSTRAINTS;
DROP TABLE FECHAS_CAPTURAS_PERMITIDAS CASCADE CONSTRAINTS;

ALTER TABLE 

--TRUNCATE es para borrar los datos de una tabla


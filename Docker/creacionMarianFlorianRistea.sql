CREATE TABLE MEDICO
(
	cod_medico NUMBER(8),
	nombre VARCHAR2(50),
	especialidad VARCHAR2(50) DEFAULT 'FAM',
	cod_director NUMBER(8),
	CONSTRAINT PK_MEDICO PRIMARY KEY (cod_medico),
	CONSTRAINT FK_Cod_Director FOREIGN KEY (cod_director) REFERENCES MEDICO (cod_medico)
);

CREATE TABLE ENFERMO
(
	cod_inscripcion NUMBER(6),
	nss VARCHAR2(10),
	nombre VARCHAR2(50),
	sexo VARCHAR2(1),
	CONSTRAINT PK_ENFERMO PRIMARY KEY (cod_inscripcion)
);

CREATE TABLE HABITACION
(
	num_hab NUMBER(4),
	numero_camas NUMBER(6),
	CONSTRAINT PK_HABITACION PRIMARY KEY (num_hab),
	CONSTRAINT CK_Num_Hab CHECK (num_hab BETWEEN 100 AND 200),
	CONSTRAINT CK_Num_Camas CHECK (num_hab <= 4)
);

CREATE TABLE INGRESO
(
	cod_ingreso NUMBER(6),
	cod_inscripcion NUMBER(6),
	fecha_ingreso DATE DEFAULT SYSDATE,
	fecha_alta DATE,
	num_hab NUMBER(4),
	CONSTRAINT PK_INGRESO PRIMARY KEY (cod_ingreso),
	CONSTRAINT FK_Cod_Inscripcion FOREIGN KEY (cod_inscripcion) REFERENCES ENFERMO (cod_inscripcion) ON DELETE CASCADE,
	CONSTRAINT FK_Num_Habitacion FOREIGN KEY (num_hab) REFERENCES HABITACION (num_hab)
);

CREATE TABLE VISITA
(
	cod_medico NUMBER(8),
	cod_inscripcion NUMBER(6),
	fecha_ingreso DATE,
	diagnostico VARCHAR2(30),
	CONSTRAINT PK_VISITA PRIMARY KEY (cod_medico, cod_inscripcion),
	CONSTRAINT FK_Cod_Enfermo FOREIGN KEY (cod_inscripcion) REFERENCES ENFERMO (cod_inscripcion) ON DELETE CASCADE,
	CONSTRAINT FK_Cod_Medico FOREIGN KEY (cod_medico) REFERENCES MEDICO (cod_medico) ON DELETE CASCADE
);
CREATE TABLE TEMA
(
	cod_tema NUMBER(5),
	denominacion VARCHAR2(30),
	cod_tema_padre NUMBER(5) NOT NULL,
	CONSTRAINT PK_TEMA PRIMARY KEY (cod_tema),
	CONSTRAINT FK_Tema_Padre FOREIGN KEY (cod_tema_padre) REFERENCES TEMA(cod_tema) ON DELETE CASCADE,
	CONSTRAINT CK_COD_TEMA CHECK (cod_tema_padre > cod_tema)
);

CREATE TABLE AUTOR
(
	cod_autor NUMBER(5),
	nombre VARCHAR2(30) NOT NULL,
	f_nacimiento DATE,
	libro_principal NUMBER(5),
	CONSTRAINT PK_AUTOR PRIMARY KEY (cod_autor)
);

CREATE TABLE LIBRO 
(
	cod_libro NUMBER(5),
	titulo VARCHAR2(15),
	f_creacion DATE,
	cod_tema NUMBER(5) NOT NULL,
	autor_principal NUMBER(5) NOT NULL,
	CONSTRAINT PK_LIBRO PRIMARY KEY (cod_libro),
	CONSTRAINT FK_TEMA FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema),
	CONSTRAINT FK_AUTOR FOREIGN KEY (autor_principal) REFERENCES AUTOR (cod_autor)
);

ALTER TABLE AUTOR ADD CONSTRAINT FK_LIBRO 
FOREIGN KEY (libro_principal) REFERENCES LIBRO (cod_libro) ON DELETE SET NULL;

CREATE TABLE LIBRO_AUTOR
(
	cod_libro NUMBER(5),
	cod_autor NUMBER(5),
	orden NUMBER(5)  NOT NULL,
	CONSTRAINT PK_LIBRO_AUTOR PRIMARY KEY (cod_libro, cod_autor),
	CONSTRAINT FK_LIBROPUBL FOREIGN KEY (cod_libro) REFERENCES LIBRO (cod_libro),
	CONSTRAINT FK_AUTORLIB FOREIGN KEY (cod_autor) REFERENCES AUTOR (cod_autor),
	CONSTRAINT CK_ORDEN CHECK (ORDEN >= 1 AND ORDEN <= 5)
);

CREATE TABLE EDITORIAL
(
	cod_editorial NUMBER(5),
	denominacion VARCHAR2(10),
	CONSTRAINT PK_EDITORIAL PRIMARY KEY (cod_editorial)
);

CREATE TABLE PUBLICACIONES
(
	cod_editorial NUMBER(5),
	cod_libro NUMBER(5),
	precio NUMBER(5, 2) NOT NULL,
	f_publicacion DATE DEFAULT sysdate,
	CONSTRAINT PK_PUBLICACIONES PRIMARY KEY (cod_editorial, cod_libro),
	CONSTRAINT FK_LIBROPUBLI FOREIGN KEY (cod_libro) REFERENCES LIBRO (cod_libro) ON DELETE CASCADE,
	CONSTRAINT FK_EDITORIAL FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial) ON DELETE CASCADE,
	CONSTRAINT CHK_PRECIO CHECK (precio > 0)
);

DROP TABLE TEMA CASCADE CONSTRAINTS;
DROP TABLE AUTOR CASCADE CONSTRAINTS;
DROP TABLE EDITORIAL CASCADE CONSTRAINTS;
DROP TABLE LIBRO CASCADE CONSTRAINTS;
DROP TABLE LIBRO_AUTOR CASCADE CONSTRAINTS;
DROP TABLE PUBLICACIONES CASCADE CONSTRAINTS;
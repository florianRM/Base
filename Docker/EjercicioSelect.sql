--1.
SELECT nombre, creditos FROM ASIGNATURA

--2.
SELECT DISTINCT creditos FROM ASIGNATURA

--3.
SELECT * FROM PERSONA

--4.
SELECT NOMBRE, CREDITOS FROM ASIGNATURA
WHERE CUATRIMESTRE = 1

--5.
SELECT NOMBRE, APELLIDO FROM PERSONA
WHERE FECHA_NACIMIENTO < TO_DATE('1975-01-01', 'YYYY-MM-DD')

--6.
SELECT NOMBRE, COSTEBASICO FROM ASIGNATURA
WHERE CREDITOS > 4.5

--7.
SELECT NOMBRE FROM ASIGNATURA
WHERE COSTEBASICO BETWEEN 25 AND 35

--8.
SELECT DISTINCT IDALUMNO FROM ALUMNO_ASIGNATURA
WHERE IDASIGNATURA = '150212' OR IDASIGNATURA = '130113' OR (IDASIGNATURA='15012' AND IDASIGNATURA='130113')    

--9.
SELECT NOMBRE FROM ASIGNATURA
WHERE CUATRIMESTRE = 2 AND CREDITOS != 6

--10.
SELECT NOMBRE, APELLIDO FROM PERSONA
WHERE APELLIDO LIKE 'G%'

--11.
SELECT NOMBRE FROM ASIGNATURA
WHERE IDTITULACION IS NULL

--12.
SELECT NOMBRE FROM ASIGNATURA
WHERE IDTITULACION IS NOT NULL

--13.
SELECT NOMBRE FROM ASIGNATURA
WHERE (COSTEBASICO / CREDITOS) > 8

--14.
SELECT NOMBRE, CREDITOS * 10 AS NUM_HORAS FROM ASIGNATURA
SELECT NOMBRE, NVL(CREDITOS, 0) * 10 AS NUM_HORAS FROM ASIGNATURA

--15.
SELECT * FROM ASIGNATURA
WHERE CUATRIMESTRE = 2
ORDER BY IDASIGNATURA
-- ORDER BY IDASIGNATURA ASC, CREDITOS DESC

--16.
SELECT NOMBRE FROM PERSONA
WHERE VARON = 0 AND CIUDAD = 'Madrid'

--17.
SELECT NOMBRE, TELEFONO FROM PERSONA
WHERE TELEFONO LIKE '91%'

--18.
SELECT NOMBRE FROM ASIGNATURA
WHERE LOWER(NOMBRE) LIKE '%pro%'

--19.
SELECT NOMBRE FROM ASIGNATURA
WHERE CUATRIMESTRE = 1 AND IDPROFESOR = 'P101'

--20.
SELECT IDALUMNO, IDASIGNATURA FROM ALUMNO_ASIGNATURA
WHERE NUMEROMATRICULA >= 3;

--21.
SELECT NOMBRE,NVL(COSTEBASICO,0), NVL(COSTEBASICO + COSTEBASICO * 0.10, 0) AS PRECIO_PRIMERAREPETICION, NVL(COSTEBASICO + COSTEBASICO * 0.30, 0) AS PRECIO_SEGUNDAREPETICION, NVL(COSTEBASICO + COSTEBASICO * 0.60, 0) AS PRECIO_TERCERAREPETICION FROM ASIGNATURA                   

--22.
SELECT * FROM PERSONA
WHERE EXTRACT (YEAR FROM FECHA_NACIMIENTO) BETWEEN 1970 AND 1979

--23.
SELECT DISTINCT DNI FROM PROFESOR WHERE DNI IS NOT NULL;

--24.
SELECT IDALUMNO FROM ALUMNO_ASIGNATURA
WHERE IDASIGNATURA = '130122'

--25.
SELECT DISTINCT IDASIGNATURA FROM ALUMNO_ASIGNATURA
WHERE IDALUMNO IS NOT NULL

--26.
SELECT NOMBRE FROM ASIGNATURA
WHERE CREDITOS > 4 AND (CUATRIMESTRE = 1 OR CURSO = 1)

--28.
SELECT DNI FROM PERSONA 
WHERE UPPER(APELLIDO) LIKE '%G%'

--29.
SELECT * FROM PERSONA
WHERE VARON = 1 AND EXTRACT (YEAR FROM FECHA_NACIMIENTO) > 1970 AND CIUDAD LIKE 'M%'








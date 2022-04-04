--1.Muestra el nombre de las empresas productoras de Huelva o Málaga ordenadas 
--por el nombre en orden alfabético inverso.
SELECT NOMBRE_EMPRESA FROM EMPRESAPRODUCTORA
WHERE UPPER(CIUDAD_EMPRESA) IN ('HUELVA', 'MALAGA', 'MÁLAGA')
ORDER BY NOMBRE_EMPRESA DESC

--2.Mostrar los nombres de los destinos cuya ciudad contenga una b mayúscula o minúscula.
SELECT NOMBRE_DESTINO FROM DESTINO
WHERE LOWER(CIUDAD_DESTINO) LIKE ('%b%')

--3.Obtener el código de los residuos con una cantidad superior a 4 del constituyente 116.
SELECT COD_RESIDUO FROM RESIDUO_CONSTITUYENTE
WHERE CANTIDAD > 4 AND COD_CONSTITUYENTE = 116

--4.Muestra el tipo de transporte, los kilómetros y el coste de los traslados realizados en 
--diciembre de 1994.
SELECT TIPO_TRANSPORTE, KMS, COSTE FROM TRASLADO
WHERE EXTRACT (MONTH FROM FECHA_ENVIO) = 12
AND EXTRACT(YEAR FROM FECHA_ENVIO) = 1994

--5.Mostrar el código del residuo y el número de constituyentes de cada residuo.
SELECT COD_RESIDUO,  COUNT(COD_CONSTITUYENTE) FROM RESIDUO_CONSTITUYENTE
GROUP BY COD_RESIDUO

--6.Mostrar la cantidad media de residuo vertida por las empresas durante el año 1994.
SELECT NVL(AVG(NVL(CANTIDAD, 0)), 0) FROM RESIDUO_EMPRESA
WHERE EXTRACT(YEAR FROM FECHA) = 1994

--7.Mostrar el mayor número de kilómetros de un traslado realizado el mes de marzo.
SELECT MAX(KMS) FROM TRASLADO
WHERE EXTRACT(MONTH FROM FECHA_ENVIO) = 3 

--8.Mostrar el número de constituyentes distintos que genera cada empresa, mostrando también 
--el nif de la empresa, para aquellas empresas que generen más de 4 constituyentes.
SELECT COUNT(DISTINCT C.COD_CONSTITUYENTE), RE.NIF_EMPRESA 
FROM CONSTITUYENTE C, RESIDUO_CONSTITUYENTE RC, RESIDUO R, RESIDUO_EMPRESA RE
WHERE C.COD_CONSTITUYENTE = RC.COD_CONSTITUYENTE
AND RC.COD_RESIDUO = R.COD_RESIDUO
AND R.COD_RESIDUO = RE.COD_RESIDUO
GROUP BY RE.NIF_EMPRESA
HAVING COUNT(C.COD_CONSTITUYENTE) > 4

--9.Mostrar el nombre de las diferentes empresas que han enviado residuos que contenga la 
--palabra metales en su descripción.
SELECT DISTINCT EP.NOMBRE_EMPRESA
FROM EMPRESAPRODUCTORA EP, TRASLADO T, RESIDUO R
WHERE EP.NIF_EMPRESA = T.NIF_EMPRESA
AND T.COD_RESIDUO = R.COD_RESIDUO
AND T.COD_DESTINO IS NOT NULL
AND UPPER(R.OD_RESIDUO) LIKE '%METALES%'

--10.Mostrar el número de envíos que se han realizado entre cada ciudad, 
--indicando también la ciudad origen y la ciudad destino.
SELECT COUNT(T.COD_DESTINO), EP.CIUDAD_EMPRESA, D.CIUDAD_DESTINO
FROM EMPRESATRANSPORTISTA EP, TRASLADO T, DESTINO D
WHERE EP.NIF_EMPRESA = T.NIF_EMPRESA
AND T.COD_DESTINO = D.COD_DESTINO
GROUP BY EP.CIUDAD_EMPRESA, D.CIUDAD_DESTINO

--11.Mostrar el nombre de la empresa transportista que ha transportado para una empresa que esté 
--en Málaga o en Huelva un residuo que contenga Bario o Lantano. 
--Mostrar también la fecha del transporte.

--12.Mostrar el coste por kilómetro del total de traslados encargados por la empresa productora 
--Carbonsur.

--13.Mostrar el número de constituyentes de cada residuo.


--14.Mostrar la descripción de los residuos y la fecha que se generó el residuo, para aquellos 
--residuos que se han generado en los últimos 30 días por una empresa cuyo nombre tenga unac. 
--La consulta debe ser válida para cualquier fecha y el listado debe aparecer ordenado por 
--la descripción del residuo y la fecha.







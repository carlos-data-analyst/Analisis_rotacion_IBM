# testeo de la BD

USE ibm_attrition_db;

SELECT COUNT(*) 
FROM Employee;

SELECT COUNT(*)
FROM JobInfo;

SELECT COUNT(*)
FROM satisfactionScores;

SELECT COUNT(*)
FROM compensation;

SELECT COUNT(*)
FROM performancehistory;

SELECT COUNT(*)
FROM attrition;

# 1 — Conteo cruzado con integridad
# Objetivo: Verificar que la base está coherente cuando unimos todas las tablas y que no se “pierde” ningún empleado en el camino.
# Qué debe hacer la consulta: Unir las 6 tablas usando EmployeeNumber como llave.
# Contar cuántos registros resultan de esa unión completa.
# En este caso se espera que regrese un solo número : 1470. De esta forma se sabrá que no se está perdiendo ningún dato.

SELECT COUNT(*)
FROM employee AS e
JOIN performancehistory AS p
	ON e.EmployeeNumber = p.EmployeeNumber
JOIN compensation as c
	ON p.EmployeeNumber = c.EmployeeNumber
JOIN jobinfo as j
	ON c.EmployeeNumber = j.EmployeeNumber
JOIN satisfactionscores as s
	ON j.EmployeeNumber = s.EmployeeNumber
JOIN attrition as a
	ON s.EmployeeNumber = a.EmployeeNumber;


# 2 — Detectar empleados huérfanos en una tabla específica
# Objetivo: Verificar si existe algún empleado que esté en la tabla Employee pero no tenga registro en SatisfactionScores.
# ¿que debe hacer la consulta?: No debería traer nada. Si llegara a regresar al menos un registro podría faltar un dato
# en alguna de las dos tablas derivado de algún error en la carga.alter

SELECT e.EmployeeNumber
FROM employee AS e
LEFT JOIN satisfactionscores AS s
	ON e.EmployeeNumber = s.EmployeeNumber
WHERE s.EmployeeNumber IS NULL;

# 3 — Validar que Compensation también está completa
# Se debe buscar empleados que: Están en employee, pero no tienen registro en compensation.
# Se tiene la misma lógica que la consulta anterior

SELECT e.EmployeeNumber
FROM employee AS e
LEFT JOIN compensation as c
	ON e.EmployeeNumber = c. EmployeeNumber
WHERE c.EmployeeNumber IS NULL;

# 4 — Validar integridad en PerformanceHistory
# Objetivo: Detectar si existe algún empleado que está en employee pero no en performancehistory

SELECT e.EmployeeNumber
FROM employee AS e
LEFT JOIN performancehistory AS p
	ON e.EmployeeNumber = p.EmployeeNumber
WHERE p.EmployeeNumber IS NULL;

# 5 — Validar integridad en JobInfo
SELECT e.EmployeeNumber
FROM employee AS e
LEFT JOIN jobinfo AS j
	ON e.EmployeeNumber = j.EmployeeNumber
WHERE j.EmployeeNumber IS NULL;

# 6 — Validar integridad en Attrition
SELECT 
    e.EmployeeNumber
FROM
    employee AS e
        LEFT JOIN
    attrition AS a ON e.EmployeeNumber = a.EmployeeNumber
WHERE
    a.EmployeeNumber IS NULL;

#7 — Duplicados en Employee
# Objetivo: Comprobar que EmployeeNumber es realmente único en la tabla Employee
# Qué esperamos que regrese: Cero filas. Si aparece algún EmployeeNumber repetido, la tabla Employee estaría corrupta.

SELECT 
    EmployeeNumber, COUNT(*) AS Veces
FROM
    employee
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

# 8 — Validar duplicados en TODAS las tablas secundarias
# Objetivo: Confirmar que EmployeeNumber también es único en las tablas secundarias (JobInfo, SatisfactionScores, 
#Compensation, PerformanceHistory y Attrition).

# Aunque ya validamos duplicados en employee, ahora es necesario asegurar que ninguna tabla relacionada tenga registros 
# duplicados, porque eso podría causar errores al construir vistas o al conectar Power BI.
# ¿que esperamos?: Cero filas en cada tabla. Si aparece algún número repetido, significa que la tabla está corrupta o que la carga tuvo un error.

SELECT EmployeeNumber, COUNT(*) AS Veces
FROM JobInfo
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;





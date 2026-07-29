USE ibm_attrition_db;

-- Creación de la Vista Maestra Ejecutiva para Power BI
CREATE OR REPLACE VIEW v_master_executive_analytics AS
SELECT 
    -- 1. Identificador Único e Interactividad Demográfica (Tabla Employee)
    e.EmployeeNumber,
    e.Age,
    e.Gender,
    e.MaritalStatus,
    e.DistanceFromHome, -- Base para KPI 6 (Impacto por Distancia)
    e.Education,
    e.EducationField,
    
    -- 2. Datos del Puesto y Filtros Operativos (Tabla JobInfo)
    j.Department,      -- Filtro Superior 1 y Base para KPI 5
    j.JobRole,         -- Filtro Superior 2 y Base para KPI 5
    j.BusinessTravel,  -- Filtro Superior 3
    j.JobLevel,
    j.OverTime,        -- Base para KPI 3 (Impacto por Horas Extra)
    
    -- 3. Índices de Clima Laboral (Tabla SatisfactionScores)
    s.EnvironmentSatisfaction, -- Base para KPI 4 (Satisfacción Crítica)
    s.JobSatisfaction,         -- Base para KPI 4 (Satisfacción Crítica)
    s.RelationshipSatisfaction,
    s.JobInvolvement,
    s.WorkLifeBalance,
    
    -- 4. Datos Financieros (Tabla Compensation)
    c.MonthlyIncome,   -- Base para KPI 2 (Brecha de Ingresos)
    c.MonthlyRate,
    c.DailyRate,
    c.HourlyRate,
    c.PercentSalaryHike,
    c.StockOptionLevel,
    
    -- 5. Historial de Desempeño (Tabla PerformanceHistory)
    p.PerformanceRating,
    p.TotalWorkingYears,
    p.TrainingTimesLastYear,
    p.YearsAtCompany,
    p.YearsInCurrentRole,
    p.YearsSinceLastPromotion,
    p.YearsWithCurrManager,
    p.NumCompaniesWorked,
    
    -- 6. Variable Objetivo de Negocio (Tabla Attrition)
    a.Attrition,
    -- Transformación para facilitar cálculos directos (KPI 1, 3, 5)
    CASE WHEN a.Attrition = 'Yes' THEN 1 ELSE 0 END AS Attrition_Numeric

FROM Employee e
INNER JOIN JobInfo j            ON e.EmployeeNumber = j.EmployeeNumber
INNER JOIN SatisfactionScores s ON e.EmployeeNumber = s.EmployeeNumber
INNER JOIN Compensation c       ON e.EmployeeNumber = c.EmployeeNumber
INNER JOIN PerformanceHistory p ON e.EmployeeNumber = p.EmployeeNumber
INNER JOIN Attrition a          ON e.EmployeeNumber = a.EmployeeNumber;
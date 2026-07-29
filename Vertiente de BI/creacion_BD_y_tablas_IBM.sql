-- 1. Crear la base de datos
CREATE DATABASE ibm_attrition_db;
USE ibm_attrition_db;

-- 2. Tabla Employee
CREATE TABLE Employee (
    EmployeeNumber INT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(20),
    MaritalStatus VARCHAR(20),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50)
);

-- 3. Tabla JobInfo
CREATE TABLE JobInfo (
    EmployeeNumber INT PRIMARY KEY,
    Department VARCHAR(50),
    JobRole VARCHAR(50),
    JobLevel INT,
    BusinessTravel VARCHAR(50),
    OverTime VARCHAR(10),
    FOREIGN KEY (EmployeeNumber) REFERENCES Employee(EmployeeNumber)
);

-- 4. Tabla SatisfactionScores
CREATE TABLE SatisfactionScores (
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    JobSatisfaction INT,
    RelationshipSatisfaction INT,
    JobInvolvement INT,
    WorkLifeBalance INT,
    FOREIGN KEY (EmployeeNumber) REFERENCES Employee(EmployeeNumber)
);

-- 5. Tabla Compensation
CREATE TABLE Compensation (
    EmployeeNumber INT PRIMARY KEY,
    MonthlyIncome INT,
    MonthlyRate INT,
    DailyRate INT,
    HourlyRate INT,
    PercentSalaryHike INT,
    StockOptionLevel INT,
    FOREIGN KEY (EmployeeNumber) REFERENCES Employee(EmployeeNumber)
);

-- 6. Tabla PerformanceHistory
CREATE TABLE PerformanceHistory (
    EmployeeNumber INT PRIMARY KEY,
    PerformanceRating INT,
    TotalWorkingYears INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,
    NumCompaniesWorked INT,
    TrainingTimesLastYear INT,
    FOREIGN KEY (EmployeeNumber) REFERENCES Employee(EmployeeNumber)
);

-- 7. Tabla Attrition
CREATE TABLE Attrition (
    EmployeeNumber INT PRIMARY KEY,
    Attrition VARCHAR(10),
    FOREIGN KEY (EmployeeNumber) REFERENCES Employee(EmployeeNumber)
);

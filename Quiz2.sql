/* CREATE TABLE SALARIES*/
CREATE TABLE SALARIES (
    ID NUMBER(*,0),
    EMPLOYEE_ID NUMBER(*,0) NOT NULL,
    PROJECT_ID NUMBER(*,0),
    SALARY NUMBER (10, 2) NOT NULL CHECK (SALARY > 1000),
    CONSTRAINT SALARIES_PK PRIMARY KEY (ID)
)
SELECT * FROM SALARIES

/* CREATE TABLE PROJECTS */
CREATE TABLE PROJECTS (
    ID NUMBER(*,0),
    CODE VARCHAR2(255 BYTE) NOT NULL,
    MANAGER_ID NUMBER(*,0),
    BUDGET NUMBER (10, 2) NOT NULL,
    DATE_OF_BEGINNING DATE,
    DATE_OF_ENDING DATE,
    CONSTRAINT PROJECTS_PK PRIMARY KEY (ID)
)
SELECT * FROM PROJECTS

/* CREATE TABLE EMPLOYEES*/
CREATE TABLE EMPLOYEES (
    ID NUMBER(*,0),
    MANAGER_ID NUMBER(*,0),
    DATE_OF_JOINING DATE NOT NULL,
    FULL_NAME VARCHAR2(255 BYTE) NOT NULL,
    CONSTRAINT EMPLOYEES_PK PRIMARY KEY (ID)
)
SELECT * FROM EMPLOYEES

/* ADDING FOREIGN KEYS SALARIES*/
ALTER TABLE SALARIES ADD CONSTRAINT FK_SALARY_EMPLOYEE FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(ID);
ALTER TABLE SALARIES ADD CONSTRAINT FK_SALARY_PROJECT FOREIGN KEY (PROJECT_ID) REFERENCES PROJECTS(ID);

/* ADDING FOREIGN KEYS PROJECTS */
ALTER TABLE PROJECTS ADD CONSTRAINT FK_MANAGER_PROJECT FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(ID);

/* ADDING FOREIGN KEEYS EMPLOYEES */
ALTER TABLE EMPLOYEES ADD CONSTRAINT FK_MANAGER FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(ID);

/* Write a SQL query to count the number of employees working in project '48205501099' */
SELECT
    COUNT(P.MANAGER_ID)
FROM
    EMPLOYEES E
        INNER JOIN
    PROJECTS P ON (E.ID = P.MANAGER_ID)
WHERE
    P.ID = 48205501099
    
/* Write a SQL query to fetch employee names (one column, don't change the alias) having salary greater than or equal to 2500 
and less than or equal 3000. */
SELECT
    E.FULL_NAME
FROM
    EMPLOYEES E
        INNER JOIN
    SALARIES S ON (E.ID = S.EMPLOYEE_ID)
WHERE
    S.SALARY BETWEEN  2500 AND 3000
    
/* Write a SQL query to fetch project code and count of employees (code, employees_count) sorted by employees_count in 
descending order. example 48205501099, 4 */
SELECT
    ID,
    COUNT(MANAGER_ID) AS employees_count
FROM
    PROJECTS
GROUP BY ID
ORDER BY employees_count DESC

/* Write a query to fetch employee names and their salaries records order by salary asc. Return employee details even if 
he/she is not assigned to any project */
SELECT 
    E.FULL_NAME,
    SALARY
FROM 
    EMPLOYEES E
        LEFT JOIN
    SALARIES S ON (E.ID = S.EMPLOYEE_ID)
ORDER BY SALARY ASC

/* Write a SQL query to fetch all the Employees who are also managers from employees table */
SELECT
    *
FROM
    EMPLOYEES
WHERE
    MANAGER_ID IS NOT NULL
    
/* Write a SQL query to fetch each employee with the name of his/her boss in one column named "employee_boss" separated by 
' - ' (don't forget the spaces). Example: "Drew Rosario - Holmes Manning", "Emery Kelley - Holmes Manning" 
(employee name - manager name) */
SELECT
    CONCAT(CONCAT(E.FULL_NAME, ' - '), EM.FULL_NAME) AS employee_boss
FROM 
    EMPLOYEES E
        INNER JOIN
    EMPLOYEES EM ON (E.ID = EM.MANAGER_ID)
    
/* Write a SQL query to fetch all the employees which first name starts with O (uppercase) (Orlando, Ovidio) */
SELECT
    *
FROM
    EMPLOYEES
WHERE 
    FULL_NAME LIKE 'O%'

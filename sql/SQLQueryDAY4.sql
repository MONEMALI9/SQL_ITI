--DQL
--1. Display (Using Union Function)
	--a. The name and the gender of the dependence that's gender is Female and depending on Female Employee.
	--b. And the male dependence that depends on Male Employee.
SELECT Dependent_name , d.Sex , e.Fname , e.Lname , e.Sex
	FROM Dependent AS d
	JOIN Employee AS e
		ON d.ESSN = e.SSN
	WHERE d.Sex = 'f'  and e.Sex='f'

UNION all 

SELECT Dependent_name , d.Sex , e.Fname , e.Lname , e.Sex
	FROM Dependent AS d 
	JOIN Employee AS e
		ON d.ESSN = e.SSN
WHERE d.Sex = 'm' and e.Sex='m';


--2. For each project, list the project name and the total hours per week (for all employees) spent on that project.
SELECT p.Pname , sum(w.Hours)
	FROM Project AS p 
	JOIN Works_for AS w
		ON p.Pnumber=w.Pno
	GROUP BY P.Pname;

--3. Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT * 
	FROM Departments  
	WHERE Dnum = 
		(select top(1) d.Dnum
			FROM Departments AS d 
			JOIN Employee AS e
				ON d.Dnum=e.Dno
			ORDER BY e.SSN
	);

--4. For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
SELECT d.Dname , MAX(e.Salary) AS max_salary , MIN(e.Salary) AS min_salary , AVG(e.Salary) AS avg_salary
	FROM Departments AS d 
		JOIN Employee AS e
			ON d.Dnum=e.Dno
	GROUP BY d.Dname;


--5. List the full name of all managers who have no dependents.
SELECT e.fname , e.lname , e.SSN , de.Dname 
	FROM Employee AS e 
	join Departments AS de
		ON e.SSN = de.MGRSSN
	WHERE e.SSN NOT IN (
		SELECT d.ESSN 
		FROM Dependent AS d 
	);

--6. For each department-- if its average salary is less than the average salary of all
	--employees-- display its number, name and number of its employees.
SELECT  d.Dnum , d.Dname , COUNT(e.SSN), AVG(e.Salary)
	FROM Employee AS e 
	JOIN Departments AS d
		ON e.Dno=d.Dnum 
	GROUP BY d.Dnum, d.Dname
	HAVING AVG(Salary) < (
		SELECT AVG(Salary)
		FROM Employee 
);

--7. Retrieve a list of employees names and the projects names they are working on
	--ordered by department number and within each department, ordered alphabetically by last name, first name.
SELECT e.Fname , e.Lname , w.Pno
	FROM Employee AS e 
	JOIN Works_for AS w
		ON e.SSN = w.ESSn
	JOIN Project p 
		on w.Pno=p.Pnumber
	ORDER BY  e.Dno,e.Fname,e.Lname ;

--8. Try to get the max 2 salaries using subquery
SELECT * 
	FROM employee
	WHERE salary in 
		(SELECT DISTINCT TOP(2) Salary 
			FROM Employee 
			WHERE Salary IS NOT NULL 
			ORDER BY Salary DESC);	

--9. Get the full name of employees that is similar to any dependent name
SELECT Fname +' '+ Lname  full_name
	FROM Employee 
	WHERE Fname +' '+ Lname  IN (
		SELECT Dependent_name
			FROM Dependent
	);

--10. Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.
SELECT Fname , Lname , SSN
	FROM Employee
	WHERE exists (
		SELECT ESSN
			FROM Dependent
			WHERE ssn=ESSN
			);

--11. In the department table insert new department called "DEPT IT" , with id 100,
	--employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'
INSERT Departments
VALUES('DEPT IT',100,112233,1-11-2006);


--12. Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574) moved to
	--be the manager of the new department (id = 100), and they give you(your SSN = 102672) her position (Dept. 20 manager)
		--a. First try to update her record in the department table
		--b. Update your record to be department 20 manager.
		--c. Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)
update Departments 
SET MGRSSN = 968574 WHERE Dnum = 100;

UPDATE Departments
SET MGRSSN = '102672'
WHERE dnum = 20;


update Employee 
SET Superssn = 102672 , Dno = 20 WHERE SSN = 102660;

--13. Unfortunately the company ended the contract with Mr. Kamel Mohamed
	--(SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
		--Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises
			--any employees or works in any projects and handle these cases).

delete Dependent where ESSN=223344
delete Works_for where ESSN=223344

update Departments set MGRSSN=102672 where MGRSSN=223344;

update Employee set Superssn = 102672  where Superssn=223344;

delete Employee where SSN=223344


--14. Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
update Employee 
	SET Salary= Salary*1.3  
	WHERE ssn in (
		SELECT w.ESSn
			FROM  Works_for AS w  
			JOIN Project AS p 
				ON w.Pno=p.Pnumber
			WHERE p.Pname='Al Rabwah'
	);
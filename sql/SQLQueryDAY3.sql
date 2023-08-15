									/* DAY 3 Task */
--1. Display the Department id, name and id and the name of its manager.
SELECT Departments.Dname , Departments.Dnum , Departments.MGRSSN , Employee.Fname , Employee.Lname
	FROM Departments 
	JOIN Employee 
		ON Departments.MGRSSN = Employee.SSN;

--2.Display the name of the departments and the name of the projects under its control.
SELECT Departments.Dname , Project.Pname
	FROM Departments 
	JOIN Project 
		on Departments.Dnum = Project.Dnum;

--3. Display the full data about all the dependence associated with the name of the employee they depend on him/her.
SELECT Dependent.*  , Employee.Fname , Employee.Lname
	FROM Dependent 
	JOIN Employee 
		ON Dependent.ESSN = Employee.SSN;

--4. Display the Id, name and location of the projects in Cairo or Alex city.
SELECT *
	FROM Project
	WHERE City in('Alex','Cairo');

--5. Display the Projects full data of the projects with a name starts with "a" letter.
SELECT *
	FROM Project
	WHERE Pname like 'a%';

--6. display all the employees in department 30 whose salary from 1000 to 2000 LE monthly.
SELECT * 
	FROM Employee 
	WHERE Dno=30 and Salary between 1000 and 2000;

--7. Retrieve the names of all employees in department 10 who works more than or equal 10 hours per week on "AL Rabwah" project.
SELECT Employee.Fname , Employee.Lname ,Employee.Dno, Works_for.Hours ,Works_for.Pno , Project.Pname 
	FROM Employee  join Works_for 
		on Employee.SSN = Works_for.ESSn 
	JOIN Project 
		on Works_for.Pno=Project.Pnumber
	WHERE Employee.Dno=10 and Works_for.Hours >= 10 and Project.Pname='AL Rabwah';

--8. Find the names of the employees who directly supervised with Kamel Mohamed.
SELECT e.Fname,e.Lname, s.Fname , s.Lname
	FROM Employee e
	JOIN Employee s 
		ON e.Superssn = s.ssn
	WHERE s.Fname='Kamel' and s.Lname='Mohamed';

--9. Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
SELECT Employee.Fname , Employee .Lname , Project.Pname 
	FROM Employee  
	JOIN Works_for 
		ON Employee.SSN = Works_for.ESSn 
	JOIN Project
		ON Works_for.Pno = Project.Pnumber
	ORDER BY Project.Pname;

--10. For each project located in Cairo City , find the project number, the controlling department name ,
--the department manager last name ,address and birthdate.
SELECT Project.City , Project.Pname , Project.Pnumber , Project.Dnum , Departments.Dname , 
		Employee.Fname , Employee.Lname , Employee.Address , Employee.Bdate
	FROM Project 
	JOIN Departments 
		ON Project.Dnum=Departments.Dnum
	JOIN Employee
		ON Departments.MGRSSN = Employee.SSN
	WHERE Project.City = 'Cairo';

--11. Display All Data of the managers
SELECT Departments.Dname , Employee.*
	FROM Departments 
	JOIN Employee 
		ON Departments.MGRSSN = Employee.SSN;

--12. Display All Employees data and the data of their dependents even if they have no dependents
SELECT Employee.* ,Dependent.*
	FROM Employee 
	LEFT JOIN Dependent  
		ON Employee.SSN = Dependent.ESSN;

--13.  Insert your personal data to the employee table as a new employee in department
		--number 30, SSN = 102672, Superssn = 112233, salary=3000	
INSERT Employee (Fname,Lname,ssn,Bdate,Address,Sex,Salary,Superssn,Dno)
VALUES('monem','ali',102672,9-2-1999,'mansoura','M',3000,112233,30);


--14. Insert another employee with personal data your friend as new employee in
	--department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him.
INSERT Employee (Fname,Lname,ssn,Bdate,Address,Sex,Salary,Superssn,Dno)
VALUES('ahmed','ali',102660,5-11-1987,'Mansoura','M',NULL,NULL,30);


--15. Upgrade your salary by 20 % of its last value.
update Employee
SET Salary=Salary*1.2 
WHERE  SSN = 102672; 


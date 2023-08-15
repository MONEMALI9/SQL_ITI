--Part-1: Use ITI DB


--1. Retrieve number of students who have a value in their age. 
SELECT COUNT(St_Age)
	FROM Student;

--2. Get all instructors Names without repetition
SELECT DISTINCT Ins_Name 
	FROM Instructor;

--3. Display student with the following Format (use isNull function)
SELECT s.St_Id , isnull(s.St_fname,'fname') + ' '+ isnull(s.St_Lname,'lname') AS full_name ,
		d.Dept_Name
	FROM Student AS s 
	JOIN Department AS d
		ON s.Dept_Id = d.Dept_Id;

--4. Display instructor Name and Department Name Note: display all the instructors if they are attached to a department or not
SELECT i.Ins_Name,d.Dept_Name
	FROM Instructor AS i 
	LEFT JOIN Department d 
		ON i.Dept_Id = d.Dept_Id;

--5. Display student full name and the name of the course he is taking For only courses which have a grade
SELECT s.St_Fname,s.St_Lname ,c.Crs_Name
	FROM Student AS s 
	JOIN Stud_Course AS sc
		ON s.St_Id = sc.St_Id
	JOIN Course AS c
		ON sc.Crs_Id = c.Crs_Id
	WHERE sc.Grade IS NOT NULL;

--6. Display number of courses for each topic name
SELECT COUNT(*) , t.Top_Name
	FROM Course AS c 
	JOIN Topic AS t 
		ON c.Top_Id=t.Top_Id
	GROUP BY t.Top_Name;

--7. Display max and min salary for instructors
SELECT MAX(Salary),MIN(Salary)
	FROM Instructor;

--8. Display instructors who have salaries less than the average salary of all instructors.
SELECT Ins_Id , Salary ,AVG(Salary)
	FROM Instructor
	GROUP BY Ins_Id,Salary
	HAVING Salary >= AVG(Salary);

SELECT ins_name
	FROM Instructor
	WHERE salary >= (select avg(salary) from Instructor);

--9. Display the Department name that contains the instructor who receives the minimum salary.
SELECT d.Dept_Name
	FROM Instructor AS i 
	JOIN Department AS d 
		ON i.Dept_Id = d.Dept_Id
	where i.Salary = (
			SELECT MIN(Salary)
			FROM Instructor
		);

--10. Select max two salaries in instructor table.
SELECT top(2) *
	FROM Instructor
	ORDER BY Salary DESC;

--11. Select instructor name and his salary but if there is no salary display instructor
	--bonus keyword. “use coalesce Function”
SELECT Ins_Name, coalesce(CONVERT(varchar(10),Salary),'instructor bonus')	
	FROM Instructor;

--12. Select Average Salary for instructors
SELECT AVG (isnull(Salary,0))
	FROM Instructor;

--13.Select Student first name and the data of his supervisor
select s1.St_Fname,s1.St_Lname ,s2.St_Id,s2.St_Fname,s2.St_Lname
	FROM Student AS s1 
	JOIN Student AS s2
		ON  s1.St_super = s2.St_Id;

--14. Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”
SELECT * 
	FROM (SELECT *, ROW_NUMBER() over(partition by dept_id ORDER BY salary DESC) AS max_sal
			FROM Instructor i) AS new
		WHERE max_sal<=2;

--15. Write a query to select a random  student from each department.  “using one of Ranking Functions”
SELECT * 
	FROM( select  *,ROW_NUMBER() over(partition by dept_id ORDER BY newid()) AS random
		FROM Student) AS new
	WHERE random = 1;
--1. Create a view that displays student full name, course name if the student has a grade more than 50. 
CREATE VIEW stddata AS 
	SELECT st_fname+' '+st_lname AS fullname,crs_name
	FROM Student AS s 
	JOIN Stud_Course AS stc
		ON s.St_Id=stc.St_Id
	JOIN Course c
		ON c.Crs_Id=stc.Crs_Id AND grade>50;


SELECT * FROM stddata;


--2. Create an Encrypted view that displays manager names and the topics they teach. 
ALTER VIEW insdata WITH encryption AS
	SELECT ins_name AS mangername , crs_name AS topicname
	FROM Instructor AS i , Department AS d , Ins_Course AS ic , Course AS c
	WHERE i.Ins_Id = d.Dept_Manager AND i.Ins_Id = ic.Ins_Id AND c.Crs_Id = ic.Crs_Id;


SELECT* FROM insdata;


--3. Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department-
     -- “use Schema binding” and describe what is the meaning of Schema Binding
	 --This means that the underlying tables and views cannot be modified in a way that would affect the definition of the schema-bound object.
	 -- It also means that the underlying objects cannot be dropped.
CREATE VIEW dbo.inamedep WITH SCHEMABINDING AS
	SELECT ins_name , dept_name
	FROM dbo.Instructor AS i 
	JOIN dbo.Department AS d
		ON d.Dept_Id = i.Dept_Id AND d.Dept_Name IN ('sd','java');

SELECT* FROM dbo.inamedep;

--4. Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
	--Note: Prevent the users to run the following query 
	--Update V1 set st_address=’tanta’
	--Where st_address=’alex’;
CREATE VIEW v1 AS
	SELECT *FROM Student WHERE St_Address IN ('alex','cairo')
	WITH CHECK OPTION;
	

--5. Create index on column (Hiredate) that allow u to cluster the data 
	--in table Department. What will happen?
CREATE CLUSTERED INDEX hire
	ON department (manager_hiredate);

--6. Create index that allow u to enter unique ages in student table.
	-- What will happen?
CREATE UNIQUE INDEX stage
ON student(st_age);
-- icannot make it as there were repeating ages 

--7. Create temporary table [Session based] on Company DB 
	--to save employee name and his today task.
Create table #emp
 (
  ename varchar(20),
  etask varchar(20)
  );

--8. Create a view that will display the project name and the number of employees work on it. “Use Company DB”
CREATE VIEW pnum AS
	SELECT COUNT(essn) AS numofemp,p.Pname
	FROM Project p ,Works_for w
	WHERE p.Pnumber=w.Pno
	GROUP BY p.Pname;

select *from pnum;


--9. Using Merge statement between the following two tables [User ID, Transaction Amount]

create table tlast
(
userid int primary key,
tamount int
); 

insert into tlast values(1,4000),(4,2000),(2,10000);

create table tdaliy
(
userid int primary key,
tamount int
);

insert into tdaliy values(1,1000),(2,2000),(3,1000);

merge into tlast as l
using tdaliy as d

on l.userid=d.userid
when matched then
update set l.tamount=d.tamount
when not matched by source then delete;

select*from tlast;


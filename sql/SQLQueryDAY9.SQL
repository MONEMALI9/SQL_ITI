--iti database 
--1. Create a stored procedure without parameters to show the number of students per department name.[use ITI DB] 
create procedure std_num as
begin 

	select s.Dept_Id, COUNT(s.St_Id)
	from Student s join Department d
	on s.Dept_Id=d.Dept_Id
	group by s.Dept_Id

end

exec std_num

--Company DB database
--2. Create a stored procedure that will check for the # of employees in the project p1 if they are more than 3 
--print message to the user “'The number of employees in the project p1 is 3 or more'” 
--if they are less display a message to the user “'The following employees work for the project p1'” in addition to 
--the first name and last name of each one. [Company DB] 
create procedure proj_emp (@pid int)as 
begin 
	declare @t int 
	set @t = (select COUNT(ESSn)
	from  Works_for 
	where pno=@pid
	group by Pno)


	if @t >=3
	select 'The number of employees in the project p1 is 3 or more'
	
	else 
	select e.fname,e.lname
	from employee e join works_For w 
	on e.ssn = w.essn
	where w.pno = @pid
end 

exec proj_emp @pid = 700

--Company DB database
--3. Create a stored procedure that will be used in case there is an old employee has left the project
--and a new one become instead of him. The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number)
--and it will be used to update works_on table. [Company DB]
create procedure update_emp(@old_id int , @new_id int , @p_id int) as
begin 
	update works_for 
	set essn = @new_id 
	where essn = @old_id and pno = @p_id 
end

drop procedure update_emp


exec update_emp 521634 , 102660 ,600

--Company DB database
--4.add column budget in project table and insert any draft values in i then Create an Audit table with the following structure 
alter table project add Budget int 

create table project_audit (ProjectNo varchar(10),UserName  varchar(20),ModifiedDate  datetime , Budget_Old  int ,Budget_New  int )

create trigger update_project on Project after update as 
begin 
	if update(Budget)
	insert into project_audit 
	select d.Pnumber,user_name(), GETDATE(),d.Budget,i.Budget
	from deleted d , inserted i
end 


update Project 
	set Budget = 900 where Pnumber=100

SET ansi_warnings OFF	

--iti database
--5.Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”
create trigger no_insert on Department instead of insert as 
begin 

	select 'U cannot insert a new record'

end 

insert into Department(Dept_Id)
values(1111111)

--Company DB database
--6. Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
create trigger no_insert_employee on employee instead of  insert  as 
begin 
	declare @m int = month(getdate()) 

	if @m = 3
	select 'U cannot Insert'
	else 
	insert into Employee
	select * from inserted 
end 

drop trigger no_insert_employee

insert into employee
	values('eael','nael',15455 , 1944-03-12  ,'fdffd','F',23222,112233,30)

select month(1973-04-18 )


--7. Create a trigger on student table after insert to add Row in Student Audit table (Server User Name , Date, Note) 
	--where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”		 iti
create table student_audit (server_user_name varchar(20),date datetime ,note varchar(50))


create trigger student_insert on student after insert as
begin 
insert into student_audit
select  user_name(),getdate(), concat( user_name(),' inserted new row with key = ' , st_id,' in table Student' )
from inserted
end


insert into student 
values (15,'Riad','Nageh','Ras EL-bar',22,NULL,NULL);


--8.Create a trigger on student table instead of delete to add Row in Student Audit table (Server User Name, Date, Note)
	--where note will be“ try to delete Row with Key=[Key Value]”
create trigger student_delete on student instead of delete as
begin 
	insert into student_audit
	select  user_name(),getdate(), concat( user_name(),'try to delete row with key = ' , st_id )
	from deleted
end


delete from student where st_id=15
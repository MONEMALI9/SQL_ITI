--1. Create a scalar function that takes date and returns Month name of that date.
create function get_month_name(@date date)
returns varchar(20)
begin
declare @monthnam varchar(20)
	if month(@date)=1
		select @monthnam = 'jan'
	if month(@date)=2
		select @monthnam = 'feb'
	if month(@date)=3
		select @monthnam = 'mar'
	if month(@date)=4
		select @monthnam = 'apr'
	if month(@date)=5
	select @monthnam = 'may'
		if month(@date)=6
	select @monthnam = 'jun'
		if month(@date)=7
	select @monthnam = 'jal'
		if month(@date)=8
	select @monthnam = 'aug'
		if month(@date)=9
	select @monthnam = 'sep'
		if month(@date)=10
	select @monthnam = 'oct'
		if month(@date)=11
	select @monthnam = 'nov'
		if month(@date)=12
	select @monthnam = 'dec'

return @monthnam
end

select dbo.get_month_name('5-1-2010')

-----------------------------------------------

create function get_name_month(@date date)
returns varchar(20)
begin
declare @name varchar(20)
select @name= (format(@date,'MMMM') )
return @name
end

select dbo.get_name_month('3/5/2010')

--2. Create a multi-statements table-valued function that takes 2 integers and returns the values between them.
create function getvalue_between(@x int,@y int)
returns @t table (val int) as
    begin
    declare @midel int = @x+1
    while  @midel<@y 
    begin
    insert into @t select @midel
    select @midel+=1
    end
    return
    end

select*from dbo.getvalue_between(5,10) 
		  
--3  Create a tabled valued function that takes Student No and returns Department Name with Student full name.
create function getinfo(@id int)
returns table
as
return
(
select Dept_Name,S.St_Fname+' '+s.St_Lname as fullname
	from Department d,Student s
	where d.Dept_Id=s.Dept_Id and St_Id=@id	 
	)

select *from getinfo(10)

--4. Create a scalar function that takes Student ID and returns a message to user 
	--a. If first name and Last name are null then display 'First name & last name are null'
	--b. If First name is null then display 'first name is null'
	--c. If Last name is null then display 'last name is null'
	--d. Else display 'First name & last name are not null'

create function mesage(@sid int)
returns varchar(30)
begin
declare @messagee varchar(50)
declare @firstname varchar(20)
declare @lastname varchar(20)
select @firstname=st_fname from Student where St_Id=@sid
select @lastname=St_Lname from Student where St_Id=@sid
if @firstname is null and @lastname is null
select @messagee= 'First name & last name are null'
if @firstname is null
select @messagee= 'First name is null'
if @lastname is null
select @messagee= 'last name is null'
else
select @messagee= 'First name & last name are not null'
return @messagee
end

select dbo.mesage(50)

--5. Create a function that takes integer which represents manager ID and
--  displays department name, Manager Name and hiring date 
create function mgr(@id int)
returns table as 
return(
select d.MGRSSN,e.Fname,e.Lname,d.Dnum,d.Dname,d.[MGRStart Date]
from Departments d join Employee e 
on d.MGRSSN=e.SSN
where d.MGRSSN=@id
)


select * from dbo.mgr(512463)


--6. Create multi-statements table-valued function that takes a string
	--If string='first name' returns student first name
	--If string='last name' returns student last name 
	--If string='full name' returns Full Name from student table 
	--Note: Use “ISNULL” function
create function stdname(@name varchar(20))
returns @t table (name varchar(30)) as  begin
	if @name='first name'
	insert into @t
	select ISNULL(st_fname,' ')from Student
	else if @name='last name'
	insert into @t
	select ISNULL(St_Lname,' ')from Student
	else if @name='full name'
	insert into @t
	select ISNULL(St_Fname+' '+St_Lname,' ')from Student
	return
	end

select * from stdname('full name')


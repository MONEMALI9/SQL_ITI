--Cursors task
--1.Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000
--and increases it by 20% if Salary >=3000. Use company DB

declare s_cur1 cursor
	for select ssn, concat(Fname,' ',Lname) full_name ,Salary from Employee
	for update

declare @id int
declare @name varchar(50)
declare @s int
open s_cur1 
fetch s_cur1 into @id,@name,@s
begin
	While @@fetch_status=0
	begin
		if @s<3000
			begin
update Employee	set Salary= @s*1.10 where current of s_cur1 
		    end
		else if @s >=3000
update Employee	set Salary= @s*1.20 where current of s_cur1 
fetch s_cur1 into @id,@name,@s

	end
end
close s_cur1
deallocate s_cur1


--2.Display Department name with its manager name using cursor. Use ITI DB
declare s_cur2 cursor
	for select d.Dept_Name , i.Ins_Name
	from Instructor i join Department d
	on i.Ins_Id=d.Dept_Manager
	for read only				--(other option is )update


declare @Dept_Name nvarchar(50)
declare @manager_name nvarchar(50)
open s_cur2
fetch s_cur2 into @dept_name,@manager_name			--put first id and name into vars
begin
	While @@fetch_status=0  --returns 0 success -- 1 failed  --2 no more rows to fetch
	begin
		select @Dept_Name,@manager_name
		fetch s_cur2 into @Dept_Name,@manager_name		-- go to next row
	end
end
close s_cur2
deallocate s_cur2
	

--3.Try to display all students first name in one cell separated by comma. Using Cursor 
declare s_cur3 cursor
	for select st_fname from student
	for read only				--(other option is )update

declare @first nvarchar(50)
declare @x nvarchar(50) =' ' 
open s_cur3 
fetch s_cur3 into @first			--put first id and name into vars
begin
	While @@fetch_status=0  --returns 0 success -- 1 failed  --2 no more rows to fetch
	begin
		set @first=@first+ ',' + @x
		select @first
		fetch s_cur3 into @x	
	end
end
close s_cur3
deallocate s_cur3
	


--One Cell [ahmed,Amr,Mona..........]
--4. Create full, differential Backup for SD30_Company DB.
declare c1 Cursor
for select st_fname
    from student
    where st_fname is not NULL and st_address='cairo'
for read only
declare @name varchar(20),@allnames varchar(300)=''
open c1
fetch c1 into @name
while @@FETCH_STATUS=0
	begin
		Set  @allnames=Concat(@allnames,',',@name)
		fetch c1 into @name
	end
Select @allnames
close c1
deallocate c1

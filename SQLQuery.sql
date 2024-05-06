
CREATE DATABASE STUDENT;

USE STUDENT;

Create table StudentInfo
(
StudentID int,
StudentName varchar(8000),
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000), 
City varchar(8000),
Country varchar(8000),
);

DROP TABLE StudentInfo;

CREATE DATABASE STUDENT1;

USE STUDENT1;

Drop database student;
USE STUDENT1;
Create table StudentInfo
(
StudentID int,
StudentName varchar(8000),
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000), 
City varchar(8000),
Country varchar(8000),
);

Alter table StudentInfo add BloodGroup varchar(8000);

Alter table StudentInfo drop column BloodGroup;

Alter table StudentInfo add DOB date;

Alter table StudentInfo alter column DOB datetime;

Alter table StudentInfo drop column DOB;

Insert into StudentInfo values('01','Ankit','Akash','0123456','HSR','Bangalore','India');

truncate table StudentInfo;

sp_rename 'StudentInfo','InfoStudent';

---------------------------------------------------------------------------------------

/*CONSTRAINTS*/
 
-- 1) NOT NULL

Create table StudentInfo
(
StudentID int,
StudentName varchar(8000) not null,
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000) NOT NULL, 
City varchar(8000),
Country varchar(8000),
);

Alter table StudentInfo Alter Column PhoneNumber int not null;

-- 2) UNIQUE

drop table studentinfo;

Create table StudentInfo
(
StudentID int unique not null,
StudentName varchar(8000) not null,
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000) NOT NULL, 
City varchar(8000),
Country varchar(8000),
PRIMARY KEY(StudentID) 
);
 -- Unique for multiple columbs

 drop table studentinfo;

 Create table StudentInfo
(
StudentID int not null,
StudentName varchar(8000) not null,
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000) NOT NULL, 
City varchar(8000),
Country varchar(8000),
CONSTRAINT UC_UniqueOne UNIQUE(StudentID, PhoneNumber)
);

Alter table StudentInfo add unique (StudentID);

--Drop unique contraint

Alter table Studentinfo
drop constraint UC_UniqueOne;


--  3) CHECK CONTSRAINT
--     Used to add a condition

 drop table StudentInfo;

 Create table StudentInfo
(
StudentID int not null,
StudentName varchar(8000) not null,
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000) NOT NULL, 
City varchar(8000),
Country varchar(8000) check (country='India'),
);

--Check on Alter Table

Alter table StudentInfo
add check(Country = 'India');


-- Give name to check constraint

alter table StudentInfo
add constraint checkcontaint check(Country ='India');	

-- Drop the contraint

alter table StudentInfo
drop constraint checkcontaint;


--  4) DEFAULT CONTSRAINT
--     Used to insert default value if not given explicitely

drop table StudentInfo;

Create table StudentInfo
(
StudentID int not null,
StudentName varchar(8000) not null,
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000) NOT NULL, 
City varchar(8000),
Country varchar(8000) default 'India',
);

-- Use Default with Alter

Alter table StudentInfo
add constraint DefaultCity
default 'Bangalore' for City;

-- Drop the Default contraint

Alter table StudentInfo
drop constraint DefaultCity;


--  4) INDEX CONTSRAINT
--     Used for fast insertion and deletion of data on column

   Create index index_studentname
   on StudentInfo (StudentName);

   --- Deleting the Index

   Drop index StudentInfo.index_studentname;

   /*DML  (DATA MANIPULATION LANGUAGE)*/

   --1) USE
   --2) Insert
   --3) Select
   --4) Update
   --5) Delete
   --6) Merge
   --7) Distict in SELECT
   --8) OrderBY in SELECT
   --9) GroupBy in SELECT
  --10) HAVING Clause in SELECT
  --11) Aggregate Functions
  --12) Cube Command
  --13) RollUp Command
  --14) OffSet clause
  --15) Fetch Statement


   --6) Lock
   --7) Call
   --8) EXPLAIN CALL

   --1) USE

   use student1;

   --2) INSERT

   drop table studentinfo;

   Create table StudentInfo
(
StudentID int not null,
StudentName varchar(8000) not null,
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000) NOT NULL, 
City varchar(8000),
Country varchar(8000),
);
   
   --a) FIRST WAY

    Insert into StudentInfo(StudentID,StudentName,ParentName,PhoneNumber,AddressOfStudent,City,Country) 
	values('01','Ankit','Chauhan','0123456','HSR','Rishikesh','India');

	--a) SECOND WAY
	Insert into StudentInfo values('01','Ankit','Chauhan','0123456','HSR','Rishikesh','India');
	Insert into StudentInfo values('02','Mukul','Pahwa','234535','RR','Haridwar','India');
	Insert into StudentInfo values('03','Amit','Yadav','847659','SBC','Dehradun','India');
	Insert into StudentInfo values('04','Alok','Kumar','9362574','NDL','Mumbai','India');
	Insert into StudentInfo values('05','Akash','Chauhan','86372','Chan','Pune','India');
	Insert into StudentInfo values('06','Vibhav','Shrivastav','01','Pun','Bangalore','India');
	Insert into StudentInfo values('07','Avantika','Singh','012334','Chandni','Delhi','India');
	Insert into StudentInfo values('08','Meeta','Gulati','0123534','Channna','Delhi','India');

      
	--3) SELECT

	Select * from StudentInfo;

	--4) UPDATE

	UPDATE StudentInfo Set StudentName='AVANTIKA', AddressOfStudent='Chandani Chock'
	where StudentID=07;

	select * from StudentInfo;

	--5) DELETE

	delete from StudentInfo where StudentName='Akash';
	Select * from StudentInfo;

	--6) MERGE

		/*Merge command is used to perform Insert, Update, Delete operations on a specific table, 
		where source table is provided.*/
		 /*
		      MERGE TargetTableName USING SourceTableName
			  ON MergeCondition
			  WHEN MATCHED
			  THEN Update_Statement
			  WHEN NOT MATCHED
			  THEN Insert_Statement
			  WHEN NOT MATCHED BY SOURCE
			  THEN DELETE;
		 */

		 Create table SourceTable(StudentID int,StudentName varchar(8000), Marks int);
		 Create table TargetTable(StudentID int,StudentName varchar(8000), Marks int)

		 Insert into SourceTable values ('1','A','77'); 
		 Insert into SourceTable values ('2','B','88');
		 Insert into SourceTable values ('3','C','99');
		 
		 Insert into TargetTable values ('1','A','77');
		 Insert into TargetTable values ('2','B','90');
		 Insert into TargetTable values ('3','D','91');

		
		MERGE TargetTable TARGET USING SourceTable SOURCE ON (TARGET.StudentID = SOURCE.StudentID)
		 WHEN MATCHED AND TARGET.StudentName <> Source.StudentName OR TARGET.Marks <> Source.Marks
		 THEN 
		 UPDATE SET TARGET.StudentName =SOURCE.StudentName, TARGET.Marks = Source.Marks
		 WHEN NOT MATCHED BY TARGET THEN
		 INSERT(StudentID, StudentName, Marks) VALUES (SOURCE.StudentID, SOURCE.StudentName, SOURCE.Marks)
		 WHEN NOT MATCHED BY SOURCE THEN
		 DELETE;

		 Select * from TargetTable;
		 Select * from SourceTable;

		 /*Here all the values which are common is present in TARGET table but when not matched then
		   if ID is matching all the source table values fr corresponding rows get coppied to target table
		   and old target rows gets deleted.
		   OUR SOURCE TABLE REMAIN UNAFFECTED ONLY TARGET TABLE CHANGES
		   
		   SOURCE TABLE    PREVIOUS TARGET TABLE       CHANGED TARGET TABLE
		   ************    ********************       ********************
		   1	A	77       1   A   77                 1   A    77 
           2	B	88       2   B   90                 2   B    88
           3	C	99       3   D   91                 3   C    99
		   
		   */


		   /*TYPES OF SELECT STATEMENTS*/

		   Select StudentName, StudentID from StudentInfo;

		   -- Select top 3 rows
		   Select TOP 3 * from StudentInfo;

		   -- FIND distinct City
		   Select Distinct city from StudentInfo;

		   -- SORT BY Parents Name (Default- anscending)
		   Select * from StudentInfo ORDER BY ParentName;

		   Select * from StudentInfo Order By ParentName Desc;
		   
		   -- Sorting data with different column
		   /*Sort student with parent name and well as student name*/

		   --As studentName is first in order, it will sort according to that
		   Select * from StudentInfo Order By StudentName, ParentName;

		   --As ParentName is first in order, it will sort according to that
		   Select * from StudentInfo Order By ParentName, StudentName;

		   Select * from StudentInfo Order By StudentName ASC, ParentName Desc;


		   -- Group By
   Select Count(StudentID) TotalCount, City From StudentInfo Group By City; 

   Select StudentID, StudentName,COUNT(City) CityCount from StudentInfo 
   Group By
   Grouping Sets((StudentID, StudentName,City),(StudentID), (StudentName),(City));

   -- HAVING CLAUSE
   -- Used when we cant use "WHERE"  Keyword

   /* Count the number of students from specific city where count should be one and should be ordered by StudendID with 
    Descending order */

	Select Count(StudentID) IDCOUNT, City FROM StudentInfo GROUP BY City
	Having Count(StudentID)=1
	Order By Count(StudentID) Desc;


	-- BACKUP OF TABLE

	-- Copy whole table
	select * into StudentInfoBackup from StudentInfo;

	-- Copy selected column
	select * into DelhiStudent from StudentInfo where city ='Delhi';
	
	select * from DelhiStudent;


	--12) Cube Command
	/*Extension of group by clause allow us to generate sum totals for
	the combinations for grouping column specified in group by clause
	*/

	select * from StudentInfo;

	Select studentName, Count(city) CityCount from StudentInfo group by cube (StudentName) order by StudentName;

	--13) RollUp Command

	Select studentName, Count(city) CityCount from StudentInfo group by rollup (StudentName)

	--14) OffSet clause
	   /*Used with select and ordered by statement to retreive a range of records. It must
	   be used with the Order By clause as it cannot be used on its own.
	   The range that we mentioned must be equal and greater than 0.*/

	   Create table OffsetValues(Marks int);
	   Insert into OffsetValues values('65');
	   Insert into OffsetValues values('66');
	   Insert into OffsetValues values('67');
	   Insert into OffsetValues values('68');
	   Insert into OffsetValues values('69');

	   Select * from OffsetValues;
	   -- This will not show first row as we have given offset as 1
	   Select * from OffsetValues order by Marks offset 1 rows;
	   
	   Select * from OffsetValues;
	   Select * from OffsetValues order by Marks offset 3 rows;
	   

	   --15) Fetch Statement
	   /*
	   Used to return a set of numbeer of rows . Have to be used in conjucture with offset clause
	   */

	   Select * from OffsetValues order by Marks offset 1 rows fetch next 1 rows only;
	   
	   Select * from OffsetValues order by Marks offset 1 rows fetch next 2 rows only;
	   -- This will not show first row as offset is used but will show next two rows only

	   --16) Pivot

	/* Used to rotate the rows to column values and run aggregations when required on the remaining column values
	*/
	 Create table SupplierTable
	 (
	 SupplierID int not null,
	 DaysOfManufacture int,
	 Cost int,
	 CustomerID int,
	 PurchaseID varchar(4000)
	 );

	 Insert into SupplierTable values ('1','12','1230','11','P1');
	 Insert into SupplierTable values ('2','21','1456','22','P2');
	 Insert into SupplierTable values ('3','32','1344','11','P3');
	 Insert into SupplierTable values ('4','14','2345','33','P1');
	 Insert into SupplierTable values ('5','42','3456','33','P3');
	 Insert into SupplierTable values ('6','31','4567','22','P1');
	 Insert into SupplierTable values ('7','41','5678','11','P2');
	 Insert into SupplierTable values ('9','54','6789','33','P2');
	 Insert into SupplierTable values ('10','33','7891','11','P3');
	 Insert into SupplierTable values ('1','12','1230','11','P1');
	 
	 Select CustomerId , Avg(Cost) as AverageCostOFCustomer from SupplierTable group by CustomerID;

	 Select 'AverageCostOfCustomer' As Cost_According_To_Customer, [11],[22],[33]
	 From
	 (Select  CustomerID, Cost from SupplierTable) AS SourceTable
	 PIVOT
	 (AVG(Cost) for CustomerID in ([11],[22],[33])) as PivotTable;


	 --UNPivot the table

	 Create Table SampleTable(SupplierID int, AAA int, BBB int, CCC int)
	 go
	 Insert into SampleTable VALUES(1,3,5,6);
	 Insert into SampleTable VALUES(1,9,2,8);
	 Insert into SampleTable VALUES(3,8,1,7);
	 go

	 select * from SampleTable;

	 Select SupplierID, Customers, Products
	 from
	 (Select SupplierID,AAA,BBB,CCC from SampleTable) p
	 Unpivot
	 (Products for Customers in (AAA,BBB,CCC)) AS Example;
	 Go
	 

	 /*BIT WISE OPERATORS

	 1) Arithmetic Operators
	 2) Assignment Operators
	 3) Bitwise Operators
	 4) Comparision
	 5) Compound
	 6) Logical
	 7) Scope Resolution
	 8) Set
	 9) String Concat
	 10) Aggregate Function
	 */

	 -- 1) Arithmetic Operators

	 Select 60+40;

	 Declare @var int = 60;
	 Set @var /= 13;
	 Select @var as exmaple;

	 Select * from OffsetValues where marks between '77' and '88'; 
	 
	 -- LIke OPeartor

	 use STUDENT1;

	 --Select all student names starts with 'A'
	 select * from StudentInfo where StudentName LIke 'a%';

      --Select all student names starts with 'A' and has 8 letter(7 underscore after a)
	  select * from StudentInfo where StudentName LIke 'a_______%';

	  --Select all student names starts with 'A' and ends with 'a'
         select * from StudentInfo where StudentName LIke 'a%a';	  
 
      --Using SCOPE(::) to acess the root member of the heirarchy ID type
	  Declare @exid  hierarchyid;
	  Select @exid= hierarchyid::GetRoot();
	  print @exid.ToString();
	   
	   -- String concatination Operator
        Select (StudentName+' , '+ParentName) as StudentINfo from StudentInfo;
		-- Aggrarate Functions
		Select AVG(Marks) as AvgMarks from OffsetValues;

		--SET OPERATORS(UNION, INTERSECT, EXCEPT)

		Create table StudentDetails
(
StudentID int unique not null,
StudentName varchar(8000) not null,
ParentName varchar(8000),
PhoneNumber bigint,
AddressOfStudent varchar(8000) NOT NULL, 
City varchar(8000),
Country varchar(8000),
PRIMARY KEY(StudentID) 
);

Insert into StudentDetails values('01','An','Chauhan','012456','HSR','Risikesh','India');
	Insert into StudentDetails values('02','Muk','Pahwa','23535','RR','Haidwar','India');
	Insert into StudentDetails values('03','Amit','Yadav','847659','SBC','Dehradun','India');
	Insert into StudentDetails values('04','Al','Kumar','936574','NDL','Mumbai','India');
	Insert into StudentDetails values('05','Aka','Chauhan','86372','Chan','Pne','India');
	Insert into StudentDetails values('06','Vibhav','Shrivastav','01','Pun','Banglore','India');
	Insert into StudentDetails values('07','Avantika','Singh','012334','Chandni','Delhi','India');
	Insert into StudentDetails values('08','Meeta','Gulati','012534','Channna','Delhi','India');


	---UNION
	Select * from StudentInfo
	Union
	Select * from StudentDetails;

	--Intersect
	Select * from StudentInfo
	Intersect
	Select * from StudentDetails;

	Select * from StudentDetails
	Intersect
	Select * from StudentInfo;
	-- Except
	Select * from StudentInfo
	Except
	Select * from StudentDetails;

	/****NESTED QUERIES******

	Queries which have an outer querie and inner sub query. The subquery is a query nested 
	with another query such as select,insert, uodate and delete
	*/

	Select StudentName, ParentName 
	from StudentInfo 
	where AddressOfStudent in(Select AddressOfStudent from StudentInfoBackup where Country='India');



	/****Joins******

	Joins in Sql are commands which are used to combine one or more rows from two or more tables
	based on the related column between the two tables.
	used when user is trying to extract data from tables which has one to many or many to many relationshipo between them.

	Types of Join-
	1) Inner Join - matching value in both the table
	2) Left Join - Left table and satisfy the condition from right table
	3) Right Join - right table and satisfy the condition from left table
	4) Full Join - return either h match in right and left table
	*/

	Create table Subjects(SubjectID int, StudentID int, SubjectName varchar(8000))

	Insert into subjects values('10','10','Maths');
	Insert into subjects values('2','11','Physics');
	Insert into subjects values('3','12','Chemistry');
	Insert into subjects values('11','01','Boilogy');

	Select Subjects.SubjectID, StudentInfo.StudentName 
	from Subjects
	Inner Join
	StudentInfo on
	Subjects.StudentID = StudentInfo.StudentID;

	Select Subjects.SubjectID, StudentInfo.StudentName 
	from StudentInfo
	Left Join
	Subjects on
    StudentInfo.StudentID = Subjects.StudentID;

	Select Subjects.SubjectID, StudentInfo.StudentName 
	from StudentInfo
	Right Join
	Subjects on
    StudentInfo.StudentID = Subjects.StudentID;

	Select Subjects.SubjectID, StudentInfo.StudentName 
	from StudentInfo
	Full Outer Join 
	Subjects on
    StudentInfo.StudentID = Subjects.StudentID;


	/*************Stored Procedures****************/

	/*These are reuseable units that encapsulate the specific bussiness logic of the application.
	It is a group of SQL statements and logic, compiled and stored together to perform  a specifc task
	*/

	-- SYNTAX
     
	 /*
	 CREATE [ OR REPLACE ] PROCEDURE
	 procedure_name [
	 (parameter name [IN | OUT|IN OUT] type [
	 ])]
	 {IS|AS}
     BEGIN [decleration_section]
	 executable_section
	 //SQL statement used in stored procedure
	 END
	 GO
	 */
	 
	 Create Procedure Student_City @SCity varchar(8000)
	 AS
	 Select * from StudentInfo
	 where City=@SCity
     GO
	 Select * from StudentInfo
	 --We are using the above created stored procedure
	 Exec Student_City @Scity = 'Delhi';

	 Create Procedure Student_City3 @SCity varchar(8000)
	 AS
	 Select * from StudentInfo
	 where City=@SCity -- this query is responsible to shoe data selected
     GO
	 Select StudentName from StudentInfo
	 Exec Student_City3 @SCity = 'Delhi';


	 /* ***********DCL Commands************* */
	 -- Used to grant or revoke previlages to a user

	 /*
	   -- To create a user
	  1) Create a login foir the user
	  2) thern create a user with that login
	  
	  */

	  Create Login Sample1 with password ='prabhat@123user';
	  create user PRABHATUSER for login Sample1;

	  --Grant privilages 
	  -- here we have created a user and want to grant permission to use "StudentInfo" Table

	  Grant select on StudentInfo to PrabhatUser;

	  --Revoke Pervilages

	  Revoke select on StudentInfo to PrabhatUser;


	  /* ************TCL COMMANDS************* */
	  --Used to handle transactions

	  Create table TCLSAMPLE (StudentID int, StudentNAme varchar(8000), Marks int);
	  insert into TCLSAMPLE values(1, 'Rohit',23);
	  insert into TCLSAMPLE values(2, 'Suhana',48);
	  insert into TCLSAMPLE values(3, 'Ashish',65);
	  insert into TCLSAMPLE values(4, 'Prerna',32);

	  -- TO START A TRANSCATION(We use Try Catch Block here)

	  Begin try
	  begin transaction
	  insert into TCLSAMPLE values(5,'avinash', 56);
	  update TCLSAMPLE set StudentNAme ='Akash' where StudentID='5';
	  update TCLSAMPLE set Marks='67' where StudentID='5'
	  commit transaction
	  print 'transactrion complete'
	  end try
	  begin catch
	  rollback transaction
	  print 'transaction failed and rolled back'
	  end catch

	  Select * from TCLSAMPLE;

	  Begin try
	  begin transaction
	  insert into TCLSAMPLE values(5,'avinash', 56);
	  update TCLSAMPLE set StudentNAme ='Akash' where StudentID='6';
	  update TCLSAMPLE set Marks='67' where StudentID='5'
	  commit transaction
	  print 'transactrion complete'
	  end try
	  begin catch
	  rollback transaction
	  print 'transaction failed and rolled back'
	  end catch

	  Select * from TCLSAMPLE;

	  delete from tclsample where StudentNAme='avinash';

	  Select * from TCLSAMPLE;

	  Update tclsample
	  set Marks = 88 
	  where studentNAme ='Akash';


	  Select * from TCLSAMPLE;

	  Begin try
	  begin transaction
	  insert into TCLSAMPLE values(6,'avinash', 56);
	  update TCLSAMPLE set StudentNAme ='mukul' where StudentID='6';
	  update TCLSAMPLE set Marks='67' where StudentID='9'
	  commit transaction
	  print 'transactrion complete'
	  end try
	  begin catch
	  rollback transaction
	  print 'transaction failed and rolled back'
	  end catch




	  -- it will enter catch if any one queries throw error. The all the correct working queries will be rolledback


	  /*For query to throw error, if no changes in record it will not throw
	   to throw error we can make airthmetic error like below
	   */
	  Begin try
	  begin transaction
	  insert into TCLSAMPLE values(8,'avh', 16);-- this will be rolledback as next query throw error
	  update TCLSAMPLE set Marks='67/0' where StudentID='9'
	  commit transaction
	  print 'transactrion complete'
	  end try
	  begin catch
	  rollback transaction
	  print 'transaction failed and rolled back'
	  end catch
	    
		
		/* ***********EXCEPTION HANDLING************** */

		-- 1) Throw block

		throw 51000, 'Record not found', 1;





		select * from StudentDetails;
		use STUDENT1;

		select * from StudentDetails;



		Create Table StudentLog
		(
		LogID int Identity(1,2),
		StuID int Not Null,
		Operation Nvarchar(10) not null,
		UpdatedDate datetime not null
		);

		Create trigger studentInsert
		on StudentDetails
		for Insert
		as
		Insert into StudentLog(StuID,Operation,UpdatedDate)
		Select StudentId,'Insert',GETDATE() from Inserted

		Insert into StudentDetails values('09','Sandhya','Chauhan','012784','BTM','Bangalore','India');

		select * from StudentLog;

		CREATE TRIGGER trgTablechanges
ON DATABASE
FOR	
    CREATE_TABLE,
    ALTER_TABLE, 
    DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO TableLog
    (
       EventVal,
       DateChanged,
       ChangedBy
     )
        VALUES (
           EVENTDATA(),
           GETDATE(),
           USER
        );
END;












































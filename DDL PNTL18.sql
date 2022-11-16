/*
					SQL Project Name : Hospital Management System(H-M-S)
							    Trainee Name : Wasik Billah Farhad
						    	Batch ID :  PNTL-18 & BITM-14 

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: Created a Database [H-M-S]
			=> SECTION 02: Created Appropriate Tables with column definition related to the project
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE A VIEW & ALTER VIEW
			=> SECTION 05: STORED PROCEDURE & ALTER STORED PROCEDURE
			=> SECTION 06: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) & ALTER FUNCTION
			=> SECTION 07: CREATE TRIGGER (FOR/AFTER TRIGGER)
			=> SECTION 08: CREATE TRIGGER (INSTEAD OF TRIGGER)
*/


/*
==============================  SECTION 01  ==============================
	                CREATE DATABASE And USE FOR CREATING TABLES
==========================================================================
*/


Use MASTER
GO

Create database H_M_S
Go

Use H_M_S
Go

/*
==============================  SECTION 02  ==============================
		          CREATE TABLES WITH COLUMN DEFINITION 
==========================================================================
*/

--============== Table with IDENTITY KEY, UNIQUE KEY , PRIMARY KEY, FOREIGN KEY & nullability CONSTRAINT... ============--

create table tblPatient
(
   patient_id int identity,
   [name] varchar(20) not null,
   age int not null,
   gender varchar(5) not null,
   [address] varchar(20) not null,
   nid_no varchar(20) UNIQUE ,
   disease varchar(20) not null ,
   constraint pk_pid primary key(patient_id),
   constraint chk_age check( age >= 0) 
)
Go
create table tblDoctor
(
   doctor_id int identity,
   [name] varchar(20) not null,
   age int not null,
   gender varchar(10) not null,
   [address] varchar(20) not null,
   constraint pk_did primary key(doctor_id)
)
Go
create table tblLab
(
   lab_no int identity,
   patient_id int not null,
   doctor_id int not null,
   [date] date DEFAULT GETDATE() , 
   amount int DEFAULT 0.00 ,
   constraint pk_lab_no primary key(lab_no),
   constraint fk_pid foreign key(patient_id) references tblPatient(patient_id),
   constraint fk_did foreign key(doctor_id) references tblDoctor(doctor_id),
   
)
Go

Create table tblPatient_Audit
(
   Id int identity,
   Auditdata varchar(50)
)

Go 

Create table tblDoctor_Dept
(
   Dept_ID int not null , 
   Dept_Name varchar(20),
   doctor_id int, 
   constraint fk_d_id_dept foreign key(doctor_id) references tblDoctor(doctor_id)
);


--============== Table with CHECK CONSTRAINT & DEFAULT CONSTRAINT name ============--

create table tblInpatient
(
   patient_id int not null  ,
   date_of_adm date DEFAULT GETDATE() ,
   date_of_dis date DEFAULT GETDATE(),
   Doctor_charge money CHECK (doctor_charge > 0 ), 
   lab_no int  ,
   constraint fk_pid1 foreign key(patient_id) references tblPatient(patient_id),
   constraint fk_lab_no foreign key(lab_no) references tblLab(lab_no)
)
Go
create table tblOutpatient
(
   patient_id int,
   [date] date DEFAULT GETDATE() ,
   lab_no int,
   constraint fk_pid2 foreign key(patient_id) references tblPatient(patient_id),
   constraint lab_num foreign key(lab_no) references tblLab(lab_no)

)
Go
create table tblRoom
(
   room_no int identity,
   room_type varchar(10),
   [status] varchar(20),
   room_charge money DEFAULT 0.00 ,
   constraint pk_roomNo primary key(room_no)
  )
Go

--============== Table with composite PRIMARY KEY ============--

create table tblBill
(
   bill_no int identity ,
   patient_id int,
   no_of_days int , 
   bill money,
   primary key ( bill_no , patient_id ),
   constraint fk_pid3 foreign key(patient_id) references tblPatient(patient_id)
)
Go

/*
==============================  SECTION 03  ==============================
		          ALTER, DROP AND MODIFY TABLES & COLUMNS
==========================================================================
*/

--============== DROP COLUMN ============--

Alter table tblInpatient
drop column date_of_dis 
Go

Alter table tblLab
drop column [date] 

Go 

Alter table tblOutpatient
drop column [date] 
Go

alter table tbllab
drop column amount
Go 


alter table tblLab
drop column date
Go 

alter table tblInpatient
drop column date_of_dis
Go

alter table tblInpatient
drop column Doctor_charge
Go 

alter table tblOutpatient
drop column date
Go 

--============== ADD column ============--

alter table tblInpatient
add room_no int


--============== ADD column with DEFAULT CONSTRAINT ============--

Alter table tblOutpatient
add date_of_dis date default getdate()
Go

--============== ADD column with CHECK CONSTRAINT ============--

Alter table tblLab
add date_of_test date CHECK (date_of_test is not null ) 
Go

--============== update column with FOREIGN KEY CONSTRAINT ============--

alter table TBLDOCTOR
add patient_id int 
Go

alter table tblDoctor
add constraint fk_p_id foreign key(patient_id) references tblPatient(patient_id) 
Go 

alter table tblInpatient
add constraint fk_room_no foreign key (room_no) references tblRoom(room_no)
Go 

--============== update column with datatype size ============--

alter table tblpatient
alter column gender varchar(10)

/*
==============================  SECTION 04  ==============================
							  CREATE A VIEW
==========================================================================
*/

create view VWPatientInfo AS

select [name] as 'Patient Name',age,gender,nid_no,date_of_adm,room_no,bill from tblPatient join tblInpatient on tblPatient.patient_id = tblInpatient.patient_id 
                         join tblBill on tblInpatient.patient_id = tblBill.patient_id where tblpatient.patient_id = 1
Go 

Create view vw_PatientData
As
Select name as 'Patient Name',age,gender,address,disease from tblPatient

Go 

Create View VW_InsertDoctor_Dept AS

Select Dept_ID,Dept_Name,tblDoctor.doctor_id from tblDoctor_Dept  join tblDoctor

on tblDoctor.doctor_id = tblDoctor_Dept.doctor_id


--==============  CREATE A VIEW WITH ENCRYPTION ============--

create view VWTreatment 
With Encryption
AS
select [name] as 'Doctor Name' , tbldoctor.patient_id , date_of_dis from tblDoctor join tblOutpatient on tblDoctor.patient_id = tblOutpatient.patient_id
Go 

Create view vw_DoctorDetails
With Encryption 
AS
Select name as 'Doctor Name',age,[address] from tblDoctor
Go 

--============== ALTER VIEW ============--

alter view VWPatientInfo
as 
select [name] as 'Patient Name',age,gender , bill from tblPatient join tblBill on tblPatient.patient_id = tblBill.patient_id

--============== DROP A VIEW ============--

Drop view vw_DoctorDetails
Go 


/*
==============================  SECTION 05  ==============================
							 STORED PROCEDURE
==========================================================================
*/

--============== CREATE A STORED PROCEDURE ============--

Create proc SPpatientList
as
begin
select name as 'Patient name' from tblPatient
end

Go 


--============== CREATE A STORED PROCEDURE USING INPUT PARAMETER ============--

Create proc SPpatienInfo @patient_name varchar(20),
                           @patient_id int

As
Begin
select * from tblpatient where patient_id =@patient_id or name =@patient_name
End
Go 

Create proc spInsertPatient 

							@name varchar(20),
							@age int,
							@gender varchar(20),
							@address varchar(20),
							@nid_no int,
							@disease varchar(20)

As
Begin

Insert Into tblPatient(name,age,gender,address,nid_no,disease) values (@name,@age,@gender,@address,@nid_no,@disease)

End

--============== CREATE A STORED PROCEDURE USING OUTPUT PARAMETER ============--

Create proc spTotaldoctorCountByGender @gender varchar(20),
                                       @doctor_count int output

AS
Begin

Select @doctor_count = count(*) from tblDoctor where gender = @gender

End
declare @total_count int 

exec spTotaldoctorCountByGender 'Female', @total_count output 
select @total_count

Go 


Create proc spInsertDoctorwithOutput @name varchar, 
                                     @age int ,
									 @gender varchar(10),
									 @address varchar(20),
									 @patient_id int,
									 @TotalDoctor int Output
As
Begin
  Insert Into tblDoctor(name,age,gender,address,patient_id) values (@name,@age,@gender,@address,@patient_id)
  select @TotalDoctor = Ident_current('tblDoctor')
End


--============== STORED PROCEDURE for UPDATE data ============--

Create proc spPatientAddressUpdateByID @patient_id int

As 
Begin
     update tblPatient
	 set address = 'Narayanganj'
	 where patient_id = @patient_id
End
Go 
Exec spPatientAddressUpdateByID @patient_id = 2 

--============== STORED PROCEDURE for DELETE Table data ============--

Create proc spPatientDeleteByID @ int

As 
Begin
     delete tblPatient
	 where patient_id = @patient_id
End

Exec spPatientDeleteByID 6

Go 

--============== ALTER STORED PROCEDURE ============--

Alter proc spPatientAddressUpdateByID @patient_id int,
                                      @Disease varchar(20)

As 
Begin
     update tblPatient
	 set address = 'Narayanganj'
	 where patient_id = @patient_id or disease = @Disease
End

Go 

exec spPatientAddressUpdateByID 5 , 'Cancer'

Go 


/*
==============================  SECTION 06  ==============================
								 FUNCTION
==========================================================================
*/

--============== A SCALAR FUNCTION ============--
-- A Scalar Function to get Total days of admission for patient -- 

Create Function Fn_DaysCount(@DOB DATE )  
RETURNS INT  
AS  
BEGIN  
      DECLARE @TOTAL_DAYS INT  
      SET @TOTAL_DAYS = DATEDIFF(DAY,@DOB,GETDATE())  
      RETURN @TOTAL_DAYS   
  
END

--============== A SIMPLE TABLE VALUED FUNCTION ============--

-- An In Line Table Valued Function to get every data filtering by gender from patient table -- 

Create function Fn_CallbyGender(@gender varchar(10))
Returns Table
As
Return(
       Select * from tblPatient
       where gender=@gender
	  )
	  
	  
	  
--============== A MULTISTATEMENT TABLE VALUED FUNCTION ============--

-- An Mutti Statement Table Valued Function to get every data filtering by patient id from patient table --

Create function Fn_PatientRegistered(@patient_id int)
Returns @Patient table (p_name int , age int , disease varchar(20)) 
As
Begin
		Insert Into @Patient
		Select [name],age,disease 
		from tblPatient
		where patient_id = @patient_id
		Return
End

--============== ALTER FUNCTION ============--

Alter function Fn_PatientRegistered(@patient_id int)
Returns @Patient table (p_name varchar(20) , age int , disease varchar(20)) 
As
Begin
		Insert Into @Patient
		Select [name],age,disease 
		from tblPatient
		where patient_id = @patient_id
		Return
End

/*
==============================  SECTION 07  ==============================
							FOR/AFTER TRIGGER
==========================================================================
*/



--============== CREATE A TRIGGER ON INSERT ============--

Create trigger Tr_tblPatient_onInsert
On tblPatient
For Insert
As
Begin
          declare @id int
          select @id = patient_id from inserted
		  Insert into tblPatient_Audit(auditdata) values ('New Patient admitted with ID :'+Cast(@id as varchar(10))+' at '+ cast(getdate() as varchar(20)))
End

Go 

--============== CREATE A TRIGGER ON DELETE ============--

Create trigger Tr_tblPatient_onDelete
On tblPatient
For Delete
As
Begin
          declare @id int
          select @id = patient_id from deleted
		  Insert into tblPatient_Audit(auditdata) values ('Existing Patient deleted with ID :'+Cast(@id as varchar(10))+' at '+ cast(getdate() as varchar(20)))
End

--============== CREATE A TRIGGER ON UPDATE ============--

Create trigger Tr_tblPatient_onUpdate
On tblPatient
For Update
As
Begin
          select * from inserted
		  select * from deleted
End

/*
==============================  SECTION 08  ==============================
							INSTEAD OF TRIGGER
==========================================================================
*/

--============== AN INSTEAD OF TRIGGER ON VIEW ============--

Create Trigger Tr_InsertDoctorDept_InsteadOfInsert
on VW_InsertDoctor_Dept
Instead of Insert 
AS
Begin
      declare @doctor_id int

	  select @doctor_id = tbldoctor.doctor_id from tblDoctor join inserted on tblDoctor.doctor_id = inserted.doctor_id

	  if(@doctor_id is null )
	  begin
			 Raiserror('Doctor id is not found to added into any department , so terminated',16,1)
			 return
	  end

      Insert into tblDoctor_Dept (Dept_ID,Dept_Name,doctor_id)
	  select Dept_ID,Dept_Name,doctor_id from inserted
End

--============== ALTER A TRIGGER ============--

Alter trigger Tr_tblPatient_onUpdate
On tblPatient
For Update
As
Begin
          declare @patient_id int 
		  select @patient_id = tblPatient.patient_id from tblPatient join inserted 
		  on tblPatient.patient_id = inserted.patient_id

		  if(@patient_id is null ) 
		  begin
			raiserror('Patient is not correct. Terminated',16,1)
			return
		  end
		  Insert Into tblPatient_Audit(Auditdata) values ('Patient with ID :' + CAST(@patient_id as varchar(20))+'Changed the name')

End
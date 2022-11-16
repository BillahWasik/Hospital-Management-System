/*

					SQL Project Name : Hospital Management System(H-M-S)
					
							    Trainee Name : Wasik Billah Farhad  
								
							    Batch ID : PNTL-18 & BITM-14

 --------------------------------------------------------------------------------
Table of Contents: DML
			=> SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			
			=> SECTION 02: INSERT UPDATE DELETE DATA THROUGH VIEW
				SUB SECTION => 2.1 : INSERT DATA through view
				SUB SECTION => 2.2 : UPDATE DATA through view
				SUB SECTION => 2.3 : DELETE DATA through view
				
			=> SECTION 03: INSERT UPDATE DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.1 : INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER 
				SUB SECTION => 3.2 : INSERT DATA USING SEQUENCE VALUE
				SUB SECTION => 3.3 : UPDATE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.4 : DELETE DATA THROUGH STORED PROCEDURE
				
			=> SECTION 04: RETREIVE DATA USING FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED)
			
			=> SECTION 05: TEST TRIGGER (FOR/AFTER TRIGGER ON TABLE, INSTEAD OF TRIGGER ON TABLE & VIEW)
			
			=> SECTION 06: QUERY
				SUB SECTION => 6.01 : A SELECT STATEMENT TO GET Patient List FROM A TABLE
				SUB SECTION => 6.02 : A SELECT STATEMENT TO GET Doctor List FROM A TABLE
				SUB SECTION => 6.03 : A SELECT STATEMENT WITH DISTINCT CLAUSE
				SUB SECTION => 6.04 : A SELECT STATEMENT WITH WHERE CLAUSE
				SUB SECTION => 6.05 : A SELECT STATEMENT WITH AND OR NOT OPERATOR
				SUB SECTION => 6.06 : A SELECT STATEMENT WITH ORDER BY
				SUB SECTION => 6.07 : A SELECT STATEMENT WITH NULL VALUES
				SUB SECTION => 6.08 : A SELECT STATEMENT WITH TOP CLAUSE
				SUB SECTION => 6.09 : A SELECT STATEMENT WITH AGGREGATE Function
				SUB SECTION => 6.10 : A SELECT STATEMENT WITH LIKE OPERATOR
				SUB SECTION => 6.11 : A SELECT STATEMENT WITH IN OPERATOR
				SUB SECTION => 6.12 : A SELECT STATEMENT WITH BETWEEN OPERATOR
				SUB SECTION => 6.13 : A SELECT STATEMENT WITH AS OPERATOR
				SUB SECTION => 6.14 : A SELECT STATEMENT WITH NATURAL JOIN OPERATOR
				SUB SECTION => 6.15 : A SELECT STATEMENT WITH INNER JOIN OPERATOR
				SUB SECTION => 6.16 : A SELECT STATEMENT WITH LEFT OUTER JOIN OPERATOR
				SUB SECTION => 6.17 : A SELECT STATEMENT WITH RIGHT OUTER JOIN OPERATOR
				SUB SECTION => 6.18 : A SELECT STATEMENT WITH GROUP BY OPERATOR 
				SUB SECTION => 6.19 :  A SELECT STATEMENT WITH GROUP BY AND HAVING OPERATOR
				SUB SECTION => 6.20 : A SELECT STATEMENT WITH SELECT INTO KEYWORD
				SUB SECTION => 6.21 : A SELECT STATEMENT WITH SUB-QUERIES
				
*/


/*
==============================  SECTION 01  ==============================
					INSERT DATA USING INSERT INTO KEYWORD
==========================================================================
*/

USE TCMS
GO

--============== Insert data by specifying column name ============--

Insert into tblPatient(name,age,address,gender,nid_no,disease) values ('Rahim',22,'Narayanganj','Male','687286','Fever'),
                                                                      ('Karim',32,'Dhaka','Male','134256','Cardiac'),
																	  ('Tanim',28,'Narayanganj','Male','222286','Fracture')



Go


Insert into tblDoctor(name,age,address,gender,patient_id) values  ('Abdur Rahman',52,'Narayanganj','Male',1),
                                                                  ('Mojibur Rahman',62,'Dhaka','Male',2),
																  ('Masuma Ahmed',45,'Narayanganj','Female',3)
         
Go 

Insert Into tblBill(patient_id,no_of_days,bill) values (1,4,2000),(2,6,2500)

Go 


--============== Insert data by column sequence ============--

Insert into tblLab values (1,1,'2022-09-16'),(2,2,'2022-08-16'),(3,3,'2022-08-09')
Go 


Insert Into tblRoom  values (101,'Male Ward','Full of Patient',300),
                            (102,'FemaleWard','Full of Patient',300),
							(103,'S-Cabin','Shared Cabin',1200),
							(104,'P-Cabin','Personal Cabin',2000)
							
Go 

Insert Into tblInpatient values (1,'2022-09-15',1,101),
                                (2,'2022-08-15',2,101)
Go 

Insert Into tblOutpatient values (1,1,'2022-09-19') , 
                                 (2,2,'2022-08-19')
Go 

Insert Into tblDoctor_Dept values (3,'Medicine',3)
Go

Insert Into tblDoctor_Dept values (4,'Eye Specialist',5)
Go 

Insert Into tblDoctor_Dept values (5,'Surgery',6)


/*
==============================  SECTION 02  ==============================
					INSERT UPDATE DELETE DATA THROUGH VIEW
==========================================================================
*/

--============== INSERT DATA through view ============--

Insert Into vw_PatientData([Patient Name],age,gender,address,disease) values ('Rahin',18,'Male','Kashipur','Accident')
Go 

Insert Into VW_InsertDoctor_Dept(Dept_ID,Dept_Name,doctor_id) values ('5','Medicine',6)
Go 

Insert Into VW_InsertDoctor_Dept(Dept_ID,Dept_Name,doctor_id) values ('6','Surgery',7)
Go 

--============== UPDATE DATA through view ============--


update vw_PatientData
set disease = 'Skin disease'
where [Patient Name] = 'Rahin'

Go 

--============== DELETE DATA through view ============--


delete from vw_PatientData
where [Patient Name] = 'Rahin'
Go 

/*
==============================  SECTION 03  ==============================
					INSERT UPDATE DELETE DATA THROUGH STORED PROCEDURE
==========================================================================
*/

Exec spInsertPatient 'Abrukun',22,'Female','Kashipur','88', 'Scabies'
Go 
Exec spInsertPatient 'Sara',22,'Female','Kashipur','0', 'Scabies'
Go 
Exec spInsertPatient 'Juena',20,'Female','Amlapara','9000', 'Scabies'
Go
Exec spInsertPatient 'Abrukun',22,'Female','Kashipur','88111', 'Scabies'
Go 
Exec spInsertPatient 'Neha',10,'Female','Modongonj','1212', 'Scabies'
Go
Exec spInsertPatient 'Ruponty',15,'Female','Amin r/a','111100', 'Eye problem'
Go 

--============== INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER ============--

Declare @total_doctor int
Exec spInsertDoctorwithOutput 'Faysal',29,'Male','London',18,@total_doctor output
select @total_doctor
Go


Declare @total_doctor int
Exec spInsertDoctorwithOutput 'Mukta',31,'Female','Masdair',15,@total_doctor output
select @total_doctor

Go 

Declare @total_doctor int
Exec spInsertDoctorwithOutput 'Mutasim',29,'Male','UK',19,@total_doctor output
select @total_doctor
Go
Declare @total_doctor int
Exec spInsertDoctorwithOutput 'Rudra',27,'Male','Noakhali',17,@total_doctor output
select @total_doctor


--============== UPDATE DATA THROUGH STORED PROCEDURE ============--

Exec spPatientAddressUpdateByID 19,'Eye Problem'
GO

Exec spPatientAddressUpdateByID 20,'Scabies'
Go 

Exec spPatientAddressUpdateByID 18,'Cardiac'
Go 

--============== DELETE DATA THROUGH STORED PROCEDURE ============--

EXEC spPatientDeleteByID 20
Go
 
EXEC spPatientDeleteByID 19
Go
 
EXEC spPatientDeleteByID 18
Go

/*
==============================  SECTION 04  ==============================
						RETREIVE DATA USING FUNCTION
==========================================================================
*/

-- A Scalar Function to get 

select dbo.Fn_DaysCount(date_of_adm) from tblInpatient where patient_id=1
Go 

select dbo.Fn_DaysCount(date_of_adm) from tblInpatient where patient_id=2
Go 


-- A Inline Table Valued Function to get 


SELECT DBO.Fn_CallbyGender('Female')
Go 

SELECT DBO.Fn_CallbyGender('Male')
Go 


-- A Multi Statement Table Valued Function to get 

select dbo.Fn_PatientRegistered(2)
Go

select dbo.Fn_PatientRegistered(3)
Go

select dbo.Fn_PatientRegistered(4)
Go


/*
==============================  SECTION 05  ==============================
							   TEST TRIGGER
==========================================================================
*/

--============== FOR/AFTER TRIGGER ON INSERT ============--

Insert Into tblPatient values ('Joina',04,'Female','Masdair','1112','Eye Problem')
Go 

Insert Into tblPatient values ('Adiyan',06,'Male','Masdair','11112','Eye Problem')
Go
 
Insert Into tblPatient values ('Anaya',10,'Female','Masdair','11121212','Joint')
Go 

--============== FOR/AFTER TRIGGER ON DELETE ============--

DELETE  from tblPatient where patient_id= 22
Go 
DELETE  from tblPatient where patient_id= 23
Go 
DELETE  from tblPatient where patient_id= 24
Go 
DELETE  from tblPatient where patient_id= 25
Go 

--============== FOR/AFTER TRIGGER ON UPDATE ============--

update tblPatient
set  name = 'Joaina'
where patient_id = 25
Go 

/*
==============================  SECTION 06  ==============================
								  QUERY
==========================================================================
*/

--============== 6.01 A SELECT STATEMENT TO GET Patient List FROM A TABLE ============--

SELECT * FROM tblPatient
GO 

--============== 6.02 A SELECT STATEMENT TO GET Doctor List FROM A TABLE ============--

SELECT * FROM tblDoctor
GO 

--============== 6.03 A SELECT STATEMENT WITH DISTINCT CLAUSE ============--

SELECT DISTINCT disease FROM tblPatient
GO 

--============== 6.04 A SELECT STATEMENT WITH WHERE CLAUSE ============--

SELECT * FROM tblPatient
WHERE patient_id = 1
GO

--============== 6.05 A SELECT STATEMENT WITH AND OR NOT OPERATOR ============--

SELECT * FROM tblPatient 
WHERE GENDER = 'MALE' AND ( address = 'Narayanganj' OR address = ' Masdair')
GO 

SELECT * FROM tblPatient WHERE NOT gender = 'MALE' 
GO 

--============== 6.06 A SELECT STATEMENT WITH ORDER BY ============--

SELECT * FROM tblPatient ORDER BY name DESC
GO 

--============== 6.07 A SELECT STATEMENT WITH NULL VALUES ============--

SELECT * FROM tblPatient WHERE nid_no IS NULL
GO 


--============== 6.08 A SELECT STATEMENT WITH TOP CLAUSE ============--

SELECT TOP 3 * FROM tblDoctor
GO 

--============== 6.09 A SELECT STATEMENT WITH AGGREGATE Function ============--

SELECT AVG(AGE) FROM tblDoctor
GO 

SELECT MAX(AGE) FROM tblDoctor
GO 

SELECT MIN(AGE) FROM tblDoctor
GO 

SELECT COUNT(*) FROM tblDoctor
GO 

SELECT SUM(patient_id) FROM tblPatient
GO 

--============== 6.10 A SELECT STATEMENT WITH LIKE OPERATOR ============--

SELECT * FROM tblPatient WHERE [name] LIKE '%a'  
GO 

SELECT * FROM tblPatient WHERE [name] LIKE 'a%'
GO 

SELECT * FROM tblPatient WHERE [name] LIKE '%a%'  
GO 

SELECT * FROM tblPatient WHERE [name] LIKE 'a_%'  
GO 

SELECT * FROM tblPatient WHERE [name] LIKE '__a%'  
GO 

SELECT * FROM tblPatient WHERE [name] LIKE 'a%n'  
GO 
  
--============== 6.11 A SELECT STATEMENT WITH IN OPERATOR ============--

SELECT * FROM tblPatient WHERE disease IN ('Fever','Eye Problem')  
GO 

--============== 6.12 A SELECT STATEMENT WITH BETWEEN OPERATOR ============--

SELECT * FROM tblDoctor WHERE   AGE BETWEEN 20 AND 50
GO 


--============== 6.13 A SELECT STATEMENT WITH AS OPERATOR ============--

SELECT name as 'Patient Name' FROM tblPatient
GO 


--============== 6.14 A SELECT STATEMENT WITH NATURAL JOIN OPERATOR ============--


SELECT * FROM tblDoctor JOIN tblLab 
GO 

--============== 6.15 A SELECT STATEMENT WITH INNER JOIN OPERATOR ============--

SELECT * FROM tblDoctor JOIN tblLab ON tblDoctor.patient_id = tblLab.patient_id
GO 

--============== 6.16 A SELECT STATEMENT WITH LEFT OUTER JOIN OPERATOR ============--


SELECT * FROM tblPatient LEFT OUTER JOIN tblInpatient ON tblPatient.patient_id = tblInpatient.patient_id
GO 


--============== 6.17 A SELECT STATEMENT WITH RIGHT OUTER JOIN OPERATOR ============--

SELECT * FROM tblPatient RIGHT OUTER JOIN tblOutpatient ON tblPatient.patient_id = tblOutpatient.patient_id
GO 

--============== 6.18 A SELECT STATEMENT WITH GROUP BY OPERATOR ============--

SELECT COUNT(patient_id) , disease FROM tblPatient GROUP BY disease
GO 

--============== 6.19 A SELECT STATEMENT WITH GROUP BY AND HAVING OPERATOR ============--

SELECT COUNT(patient_id) , disease FROM tblPatient  GROUP BY disease HAVING COUNT(disease) > 2
GO 

--============== 6.20 A SELECT STATEMENT WITH SELECT INTO KEYWORD ============--

SELECT * INTO #TMPTBL FROM tblDoctor
GO 

--============== 6.21 A SELECT STATEMENT WITH SUB-QUERIES ============--

select dept_name from tblDoctor_Dept where doctor_id IN ( select doctor_id from tblDoctor where gender = 'Male')
Go 



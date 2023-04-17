CREATE TABLE staff(
	first_name varchar(25),
	last_name varchar(25),
	age integer,
	gender varchar(6)

)
CREATE TABLE member_position(
	position_name varchar(25),
	department varchar(25)
)
CREATE TABLE salary(
	position_name varchar(25),
	employee_name varchar(25),
	amount integer
)

INSERT INTO staff(first_name,last_name,age,gender) 
VALUES('Max','Denisov',27,'Male');
INSERT INTO staff(first_name,last_name,age,gender) 
VALUES('Ivan','Petrov',22,'Male');
INSERT INTO staff(first_name,last_name,age,gender) 
VALUES('Dmytro','Kovalenko',31,'Male');
INSERT INTO staff(first_name,last_name,age,gender) 
VALUES('Vlad','Savchenko',19,'Male');
INSERT INTO staff(first_name,last_name,age,gender) 
VALUES('Anna','Polishuk',24,'Female');


INSERT INTO member_position VALUES('Worker','Cleaning Department');
INSERT INTO member_position VALUES('Software engeneer','IT Department');
INSERT INTO member_position VALUES('Recruiter','Human Resources');
INSERT INTO member_position VALUES('Tester','QA Department');
INSERT INTO member_position VALUES('Mentor','Academy Department');


INSERT INTO salary VALUES('Software engeneer','Max',250000);
INSERT INTO salary VALUES('Mentor','Anna',100000);
INSERT INTO salary VALUES('HR Manager','Vlad',25000);
INSERT INTO salary VALUES('Worker','Dmytro',2500);
INSERT INTO salary VALUES('Tester','Ivan',150000);


SELECT * FROM salary;
SELECT * FROM staff;
SELECT * FROM member_position;
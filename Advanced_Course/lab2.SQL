CREATE TABLE lab2.bank_data(
	username varchar(40),
	balance integer
);

INSERT INTO lab2.bank_data VALUES 
('User1',200000),('User2',300000),('User3',50000),('User4',300000);

SELECT * FROM lab2.bank_data

BEGIN;
UPDATE  lab2.bank_data SET balance = balance - 100000 WHERE username = 'User4';
UPDATE  lab2.bank_data SET balance = balance + 100000 WHERE username = 'User3';
COMMIT;

BEGIN;
UPDATE  lab2.bank_data SET balance = balance - 100000 WHERE username = 'User4';
UPDATE  lab2.bank_data SET balance = balance + 100000 WHERE username = 'User3';
ROLLBACK;

SELECT username,xmin FROM lab2.bank_data;

BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT balance,xmin FROM lab2.bank_data WHERE username ='User4' FOR UPDATE;
UPDATE  lab2.bank_data SET balance = balance - 100000 WHERE username = 'User4';
SELECT balance,xmin FROM lab2.bank_data WHERE username ='User3' FOR UPDATE;
UPDATE  lab2.bank_data SET balance = balance + 100000 WHERE username = 'User3';
COMMIT;

BEGIN;
SELECT balance FROM lab2.bank_data WHERE username ='User4' FOR UPDATE;
UPDATE  lab2.bank_data SET balance = balance + 200000 WHERE username = 'User4';
SELECT balance FROM lab2.bank_data WHERE username ='User3' FOR UPDATE;
UPDATE  lab2.bank_data SET balance = balance - 200000 WHERE username = 'User3';
COMMIT;



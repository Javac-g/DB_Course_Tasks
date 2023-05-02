CREATE SCHEMA lab1;
CREATE TABLE lab1.users(
	number SERIAL PRIMARY KEY,
	name varchar(20)
);
INSERT INTO lab1.users(name) VALUES ('User1'),('User2'),('User3'),('User4'),
('User5'),('User6'),('User7'),('User8'),('User9'),('User10');

CREATE OR REPLACE FUNCTION lab1.copytable(tablename varchar)
RETURNS VOID AS $$ 
DECLARE
	tr RECORD;
BEGIN
	EXECUTE format('CREATE TABLE lab1.%I(
				  number SERIAL PRIMARY KEY,
				  name varchar(40))',tablename);
	FOR tr IN 
		SELECT * FROM lab1.users
	LOOP
		EXECUTE format('INSERT INTO lab1.%I VALUES(%s,%L)',tablename,tr.number,tr.name);
	END LOOP;
	
	RETURN;
END;	
$$LANGUAGE plpgsql

SELECT lab1.copytable('data1');
SELECT * FROM lab1.data1;
CREATE VIEW names_view AS SELECT name FROM lab1.users;
SELECT * FROM names_view;
CREATE INDEX names_index ON lab1.users(name);

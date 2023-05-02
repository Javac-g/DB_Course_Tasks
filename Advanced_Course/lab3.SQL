CREATE TABLE lab3.clients(
	id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	adress TEXT,
	phone TEXT
);

INSERT INTO lab3.clients(first_name,last_name,adress,phone) VALUES ('Anna','Savchuk','123 Elm Street','6-23-15');
INSERT INTO lab3.clients(first_name,last_name,adress,phone) VALUES ('Daria','Koval','213 Elm Street','6-44-33');
INSERT INTO lab3.clients(first_name,last_name,adress,phone) VALUES ('Karin','Heller','143 Elm Street','6-83-19');
INSERT INTO lab3.clients(first_name,last_name,adress,phone) VALUES ('Alexa','Holod','183 Elm Street','9-40-67');
SELECT * FROM lab3.clients;

CREATE INDEX name_index ON lab3.clients(first_name);
CLUSTER lab3.clients USING name_index;

SELECT * FROM lab3.clients;

CREATE INDEX phone_index ON lab3.clients(phone);
SELECT * FROM lab3.clients WHERE phone = '6-83-19';

CREATE INDEX fullname_index ON lab3.clients(first_name,last_name);
CLUSTER lab3.clients USING fullname_index;




CREATE TABLE lab3.orders(
	id SERIAL PRIMARY KEY,
	name text,
	numbers integer,
	price decimal,
	start_date date
);

INSERT INTO lab3.orders(name,numbers,price,start_date) VALUES ('Anna',3,73.3,'2023-03-22');
INSERT INTO lab3.orders(name,numbers,price,start_date) VALUES ('Vlad',5,26.1,'2021-07-05');
INSERT INTO lab3.orders(name,numbers,price,start_date) VALUES ('Daria',8,38.5,'2020-08-13');


CREATE INDEX namedate_index ON lab3.orders(name,start_date);
CLUSTER lab3.orders USING namedate_index;

CREATE INDEX namedateprice_ind ON lab3.orders(name,start_date,price);
CLUSTER lab3.orders USING namedateprice_ind;

CREATE INDEX numdateprice_ind ON lab3.orders(numbers,price,start_date);
CLUSTER lab3.orders USING numdateprice_ind;

SELECT * FROM lab3.orders;





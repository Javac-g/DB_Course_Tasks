CREATE SCHEMA practice_lection_1;
CREATE TABLE practice_lection_1.Films(
	code char(40) PRIMARY KEY,
	title varchar(40) NOT NULL,
	timing integer NOT NULL,
	genre varchar (15) NOT NULL
); 

SELECT * FROM practice_lection_1.Films;

CREATE TABLE practice_lection_1.Users(
	login varchar(40) PRIMARY  KEY
); 
CREATE TABLE practice_lection_1.Favorite_Films(
	id SERIAL PRIMARY KEY,
	login varchar(40)NOT NULL REFERENCES practice_lection_1.Users(login) ON DELETE CASCADE,
	code char(40)NOT NULL REFERENCES practice_lection_1.Films(code) ON DELETE CASCADE
); 
INSERT INTO practice_lection_1.Users VALUES ('Max');
INSERT INTO practice_lection_1.Users VALUES ('Vlad');
INSERT INTO practice_lection_1.Users VALUES ('Anton');
INSERT INTO practice_lection_1.Users VALUES ('Dmytro');

INSERT INTO practice_lection_1.Films VALUES ('azxs','First film',120,'Comedy');
INSERT INTO practice_lection_1.Films VALUES ('xaza','Second film',150,'Horror');
INSERT INTO practice_lection_1.Films VALUES ('adfg','Third film',250,'Detective');
INSERT INTO practice_lection_1.Films VALUES ('vdvsdv','Fours film',75,'Fantasy');

INSERT INTO practice_lection_1.Favorite_Films VALUES (1,'Max','xaza');
INSERT INTO practice_lection_1.Favorite_Films VALUES (2,'Anton','adfg');
INSERT INTO practice_lection_1.Favorite_Films(login,code) VALUES ('Dmytro','vdvsdv');
SELECT * FROM  practice_lection_1.Favorite_Films
SELECT * FROM  practice_lection_1.Users
DELETE FROM practice_lection_1.Users WHERE login = 'Max';
SELECT login, title FROM practice_lection_1.Films 
LEFT JOIN practice_lection_1.Favorite_Films 
ON practice_lection_1.Films.code = practice_lection_1.Favorite_Films.code
WHERE practice_lection_1.Favorite_Films.login = 'Max';







CREATE TABLE practice_lection_1.Test(
	num integer,
	name varchar(40)
	
)
SELECT * FROM practice_lection_1.Test;
INSERT INTO practice_lection_1.Test(num) SELECT g.id FROM generate_series(1,10000) AS g(id);
SELECT * FROM practice_lection_1.Test WHERE num = 1995;
CREATE INDEX num_index ON practice_lection_1.Test(num);

CREATE TABLE practice_lection_1.customer(
	num integer NOT NULL,
	name varchar(40),
	comission float,
	wallet float
)
INSERT INTO practice_lection_1.customer VALUES(1,'customer1',0.02,1.22);
INSERT INTO practice_lection_1.customer VALUES(1,'customer2',0.04,7.22);
INSERT INTO practice_lection_1.customer VALUES(1,'customer3',0.42,6.22);
INSERT INTO practice_lection_1.customer VALUES(1,'customer4',0.62,3.22);
INSERT INTO practice_lection_1.customer VALUES(1,'customer5',0.72,5.32);

SELECT * FROM practice_lection_1.customer
CREATE VIEW customer_view AS SELECT name,comission FROM practice_lection_1.customer;

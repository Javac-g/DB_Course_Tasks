CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name varchar(25) NOT NULL,
  last_name varchar(25) NOT NULL,
  created_date TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_date TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO users (first_name,last_name) 
VALUES
('Max','Denisov'),
('Ivan','Ivanov'),
('Petr','Petrov'),
('Semen','Semenov'),
('Anton','Antonov');
 

CREATE TABLE roles (
  id SERIAL PRIMARY KEY,
  role_name varchar(25) UNIQUE NOT NULL
);

INSERT INTO roles(role_name)
VALUES('Gamer'),('Admin'),('Moder'),('System');


CREATE TABLE credentials (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  email varchar(100) UNIQUE NOT NULL,
  password varchar(100) NOT NULL,
  role_id INTEGER REFERENCES roles(id)
);

INSERT INTO credentials(user_id,email,password,role_id)
VALUES
(1,'Max@gmail.com','pass1234',1),
(2,'Ivan@gmail.com','1234pass1234',2),
(3,'Petr@yahoo.com','pa543ss125434',3),
(4,'Semen@hotmail.com','paspasspssas1234',4),
(5,'Anton@gmail.com','pa234ss851234',1);

CREATE TABLE items(
	id SERIAL PRIMARY KEY,
	item_name varchar(25),
	description text,
	prise integer
);
INSERT INTO items(item_name,description,prise) VALUES('Sword of seven','Ancient relict +200 ATK',2000);
INSERT INTO items(item_name,description,prise) VALUES('Saint orb','Can ressurect great dragon',500);
INSERT INTO items(item_name,description,prise) VALUES('Langrisser','The word of light +500 ATK',12000);
INSERT INTO items(item_name,description,prise) VALUES('Magic shield','Magic defense +300',1500);
 
CREATE TABLE inventory(
	id SERIAL PRIMARY KEY,
	item_id INTEGER REFERENCES items(id) ,
	quuntity INTEGER,
	equipped bool
);
INSERT INTO inventory(item_id,quuntity,equipped)VALUES(1,2,true),(2,1,true),(3,3,false),(4,2,true);

CREATE TABLE game_characters(
	id SERIAL PRIMARY KEY,
	character_name varchar(25),
	character_class varchar(25),
	character_level integer,
	character_exp float,
	inventory_id integer REFERENCES inventory(id)
	
);
INSERT INTO game_characters(character_name,character_class,character_level,character_exp,inventory_id)
VALUES
('Bolson','Yama',75,10000,2),
('Pagus','Qsiti',80,5000,3),
('Torgal','Sovani',99,797,4),
('David Nassau','Human',90,23545,1);

 
CREATE TABLE players(
	id SERIAL PRIMARY KEY,
	user_id INTEGER REFERENCES users(id),
	character_id INTEGER REFERENCES game_characters(id)
);
INSERT INTO players (user_id,character_id) VALUES(1,1),(1,2),(2,3),(3,3);


CREATE TABLE match_result(
	id SERIAL PRIMARY KEY,
	character_id INTEGER REFERENCES game_characters(id),
	win bool
);
INSERT INTO match_result(character_id,win)VALUES(1,true),(2,False);

SELECT * FROM users;
SELECT * FROM roles;
select * from credentials;
select * from items
SELECT * FROM inventory
SELECT * FROM game_characters;
SELECT * FROM players;
SELECT * FROM match_result;


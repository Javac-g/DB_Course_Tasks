CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	name varchar(45)
);
INSERT INTO users(name) VALUES('Koval'),('Demidov'),('Max');

CREATE TABLE clients(
	id SERIAL PRIMARY KEY,
	name varchar(45)
);

INSERT INTO clients(name) VALUES('Koval'),('Petrov'),('Demidov');

SELECT users.id id_a,users.name name_a ,clients.id id_b,clients.name name_b 
FROM users INNER JOIN clients ON users.name = clients.name;

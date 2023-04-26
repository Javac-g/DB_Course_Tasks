CREATE TABLE practice_lection_3.Users(
	id SERIAL,
	name varchar,
	email varchar
);
INSERT INTO practice_lection_3.Users(name,email) VALUES ('A','A@a.com');
INSERT INTO practice_lection_3.Users(name,email) VALUES ('B','B@b.com');

BEGIN;
SELECT * FROM practice_lection_3.Users FOR UPDATE;
COMMIT;

BEGIN;
SELECT * FROM practice_lection_3.Users WHERE id = 1;
SELECT xmin::text FROM practice_lection_3.Users WHERE id = 1;
UPDATE practice_lection_3.Users SET name = 'john' WHERE id = 1 AND xmin::text = '6422';
COMMIT;

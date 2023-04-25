CREATE TABLE practice_lection_2.Users(
	username varchar,
	password varchar
);
BEGIN;
INSERT INTO practice_lection_2.Users(username,password) Values('Sam','Smith');
INSERT INTO practice_lection_2.Users(username1,password2) Values(100,200);
COMMIT;
SELECT * FROM practice_lection_2.users;

ALTER TABLE practice_lection_2.users ADD COLUMN IF NOT EXISTS balanse int;
UPDATE practice_lection_2.users SET balanse = 500;

BEGIN;
UPDATE practice_lection_2.users SET balanse = balanse - 100 WHERE username = 'john';
UPDATE practice_lection_2.users SET balanse = balanse + 100 WHERE username = 'Mike';
COMMIT;

BEGIN;
INSERT INTO practice_lection_2.Users(username,password,balanse) Values('Kate','Smith',100);
SAVEPOINT my_savepoint;
INSERT INTO practice_lection_2.Users(username,password,balanse) Values('Oleg','passw',100);
ROLLBACK TO SAVEPOINT my_savepoint;
INSERT INTO practice_lection_2.Users(username,password,balanse) Values('Max','qwerty',900);
COMMIT;

BEGIN;
UPDATE practice_lection_2.users SET balanse = balanse - 100 WHERE username = 'john';
SAVEPOINT my_savepoint;
UPDATE practice_lection_2.users SET balanse = balanse + 1000 WHERE username = 's';

COMMIT;

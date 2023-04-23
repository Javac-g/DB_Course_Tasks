CREATE TABLE users(
  id integer,
  name varchar
)

CREATE OR REPLACE FUNCTION ReloadFunction(Tablename varchar)
RETURNS void AS $$
DECLARE 
  tr RECORD
BEGIN
  EXECUTE format('CREATE TABLE %I(
                          id integer,
                          name varchar)',Tablename);
  FOR tr IN
    SELECT * FROM users;
  LOOP
    EXECUTE format(INSERT INTO %I VALUES(%s, %L),Tablename ,tr.id, tr.name);
  END LOOP;
  
  RETURN;

END;
$$LANGUAGE plpgsql;

SELECT reloadFirstTable('banned'); 



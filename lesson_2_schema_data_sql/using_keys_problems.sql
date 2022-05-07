CREATE SEQUENCE counter;

SELECT nextval('counter');

DROP SEQUENCE counter;

CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 2;

ALTER TABLE films
  ADD COLUMN id serial PRIMARY KEY;

UPDATE films
  SET id = 1
  WHERE title = 'Casablanca';

ALTER TABLE films
  ADD COLUMN id_2 serial PRIMARY KEY;

ALTER TABLE films
  DROP CONSTRAINT films_pkey;
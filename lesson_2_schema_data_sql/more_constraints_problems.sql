ALTER TABLE films
  ALTER COLUMN title SET NOT NULL;

ALTER TABLE films
  ALTER COLUMN "year" SET NOT NULL;

ALTER TABLE films
  ALTER COLUMN genre SET NOT NULL;

ALTER TABLE films
  ALTER COLUMN director SET NOT NULL;

ALTER TABLE films
  ALTER COLUMN duration SET NOT NULL;

ALTER TABLE films
  ADD UNIQUE (title);

ALTER TABLE films
  DROP CONSTRAINT films_title_key;

ALTER TABLE films
  ADD CHECK (length(title) >= 1);

INSERT INTO films
  VALUES ('', 2021, 'genre', 'director', 130);

ALTER TABLE films
  DROP CONSTRAINT films_title_check;

ALTER TABLE films
  ADD CONSTRAINT year_range CHECK ("year" BETWEEN 1900 AND 2100);

ALTER TABLE films
  ADD CONSTRAINT director_name CHECK (length(director) >= 3 AND position(' ' in director) > 0);

UPDATE films
  SET director = 'Johnny'
  WHERE title = 'Die Hard';

CREATE TABLE test (
  name integer DEFAULT 0 CHECK (name > 0)
);

INSERT INTO test VALUES (DEFAULT);
SELECT * FROM films;

SELECT * FROM films WHERE length(title) < 12;

ALTER TABLE films
  ADD COLUMN director text, 
  ADD COLUMN duration integer;

UPDATE films
  SET director = 'John McTiernan', duration = 132
  WHERE title = 'Die Hard';

UPDATE films
  SET director = 'Michael Curtiz', duration = 102
  WHERE title = 'Casablanca';

UPDATE films
  SET director = 'Francis Ford Coppola', duration = 113
  WHERE title = 'The Conversation';

INSERT INTO films
  VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90),
         ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
         ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);

SELECT title, extract("year" from current_date) - "year" AS age 
  FROM films
  ORDER BY age ASC;

SELECT title, duration
  FROM films
  WHERE duration > 120
  ORDER BY duration DESC;

SELECT title
  FROM films
  ORDER BY duration DESC
  LIMIT 1;

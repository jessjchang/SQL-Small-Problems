CREATE TABLE directors_films (
  id serial PRIMARY KEY,
  director_id integer NOT NULL REFERENCES directors(id) ON DELETE CASCADE,
  film_id integer NOT NULL REFERENCES films(id) ON DELETE CASCADE
);

INSERT INTO directors_films (director_id, film_id)
  VALUES (1, 1),
         (2, 2),
         (3, 3),
         (4, 4),
         (5, 5),
         (6, 6),
         (3, 7),
         (7, 8),
         (8, 9),
         (4, 10);

INSERT INTO directors_films (director_id, film_id) (
  SELECT directors.id, films.id FROM films CROSS JOIN directors
  WHERE films.director_id = directors.id);

ALTER TABLE films
  DROP COLUMN director_id;

SELECT films.title, directors.name
  FROM films
  JOIN directors_films
    ON films.id = directors_films.film_id
  JOIN directors
    ON directors.id = directors_films.director_id
  ORDER BY films.title;

INSERT INTO films (title, year, genre, duration)
  VALUES ('Fargo', 1996, 'comedy', 98),
         ('No Country for Old Men', 2007, 'western', 122),
         ('Sin City', 2005, 'crime', 124),
         ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors (name)
  VALUES ('Joel Coen'),
         ('Ethan Coen'),
         ('Frank Miller'),
         ('Robert Rodriguez');

INSERT INTO directors_films (director_id, film_id)
  VALUES (9, 11),
         (9, 12),
         (10, 12),
         (11, 13),
         (12, 13),
         (12, 14);

SELECT directors.name AS director, count(directors_films.film_id) AS films
  FROM directors
  JOIN directors_films
    ON directors.id = directors_films.director_id
  GROUP BY directors.name
  ORDER BY films DESC, director ASC;
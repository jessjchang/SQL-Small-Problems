INSERT INTO films (title, "year", genre, director, duration)
  VALUES ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95),
         ('Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);

SELECT DISTINCT genre FROM films;

SELECT genre FROM films
  GROUP BY genre;

SELECT round(avg(duration)) FROM films;

SELECT genre, round(avg(duration)) AS average_duration FROM films
  GROUP BY genre;

SELECT (year / 10) * 10 AS decade, round(avg(duration)) AS average_duration
  FROM films
  GROUP BY decade
  ORDER BY decade ASC;

SELECT * FROM films
  WHERE director LIKE 'John %';

SELECT genre, count(id)
  FROM films
  GROUP BY genre
  ORDER BY count DESC;

SELECT (year / 10) * 10 AS decade, genre, string_agg(title, ', ') AS films
  FROM films
  GROUP BY decade, genre
  ORDER BY decade, genre;

SELECT genre, sum(duration) AS total_duration
  FROM films
  GROUP BY genre
  ORDER BY total_duration, genre;
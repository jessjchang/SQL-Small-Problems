SELECT state, count(id) FROM people
  GROUP BY state
  ORDER BY count DESC
  LIMIT 10;

SELECT substr(email, strpos(email, '@') + 1) AS domain, count(id)
  FROM people
  GROUP BY domain
  ORDER BY count DESC;

DELETE FROM people
  WHERE id = 3399;

DELETE FROM people
  WHERE state = 'CA';

UPDATE people
  SET given_name = upper(given_name)
  WHERE email LIKE '%teleworm.us';

DELETE FROM people;
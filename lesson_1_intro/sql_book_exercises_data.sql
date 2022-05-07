INSERT INTO countries (name, capital, population)
  VALUES ('France', 'Paris', 67158000);

INSERT INTO countries (name, capital, population)
  VALUES ('USA', 'Washington D.C.', 325365189),
         ('Germany', 'Berlin', 82349400),
         ('Japan', 'Tokyo', 126672000);

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
  VALUES ('Bruce', 'Springsteen', 'Singer, Songwriter', '1949-09-23', false);

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth)
  VALUES ('Scarlett', 'Johansson', 'Actress', '1984-11-22');

INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
  VALUES ('Frank', 'Sinatra', 'Singer, Actor', '1915-12-12', true),
         ('Tom', 'Cruise', 'Actor', '1962-07-03', DEFAULT);

ALTER TABLE celebrities
  ALTER COLUMN last_name DROP NOT NULL;

INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
  VALUES ('Madonna', 'Singer, Actress', '1958-08-16', false),
         ('Prince', 'Singer, Songwriter, Musician, Actor', '1958-06-07', true);

ALTER TABLE animals
  DROP CONSTRAINT unique_binomial_name;

INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status)
  VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
         ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
         ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
         ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
         ('Kakapo', 'Strigops habroptila', 4, 60, 'CR');

INSERT INTO orders (customer_name, customer_email, burger, side, drink, customer_loyalty_points, burger_cost, side_cost, drink_cost)
  VALUES ('James Bergman', 'james1998@email.com', 'LS Chicken Burger', 'Fries', 'Cola', 28, 4.50, 0.99, 1.50),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Cheeseburger', 'Fries', NULL, 18, 3.50, 0.99, DEFAULT),
         ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 42, 6.00, 1.50, 2.00),
         ('Aaron Muller', NULL, 'LS Burger', NULL, NULL, 10, 3.00, DEFAULT, DEFAULT);

SELECT population
  FROM countries
  WHERE name = 'USA';

SELECT population, capital
  FROM countries;

SELECT name
  FROM countries
  ORDER BY name;

SELECT name, capital
  FROM countries
  ORDER BY population;

SELECT name, capital
  FROM countries
  ORDER BY population DESC;

SELECT name, binomial_name, max_weight_kg, max_age_years
  FROM animals
  ORDER BY max_age_years, max_weight_kg, name DESC;

SELECT name
  FROM countries
  WHERE population > 70000000;

SELECT name
  FROM countries
  WHERE population BETWEEN 70000000 AND 200000000;

SELECT name
  FROM countries
  WHERE population > 70000000
  AND population < 200000000;

SELECT first_name, last_name
  FROM celebrities
  WHERE deceased != true
  OR deceased IS NULL;

SELECT first_name, last_name
  FROM celebrities
  WHERE occupation LIKE '%Singer%';

SELECT first_name, last_name
  FROM celebrities
  WHERE occupation LIKE '%Actor%'
  OR occupation LIKE '%Actress%';

SELECT first_name, last_name
  FROM celebrities
  WHERE (occupation LIKE '%Actor%' OR occupation LIKE '%Actress%')
  AND occupation LIKE '%Singer%';

SELECT burger
  FROM orders
  WHERE burger_cost < 5.00
  ORDER BY burger_cost;

SELECT customer_name, customer_email, customer_loyalty_points
  FROM orders
  WHERE customer_loyalty_points >= 20
  ORDER BY customer_loyalty_points DESC;

SELECT burger
  FROM orders
  WHERE customer_name = 'Natasha O''Shea';

SELECT customer_name
  FROM orders
  WHERE drink IS NULL;

SELECT burger, side, drink
  FROM orders
  WHERE side != 'Fries'
  OR side IS NULL;

SELECT burger, side, drink
  FROM orders
  WHERE side IS NOT NULL
  AND drink IS NOT NULL;

SELECT * FROM countries LIMIT 1;

SELECT name FROM countries
  ORDER BY population DESC
  LIMIT 1;

SELECT name FROM countries
  ORDER BY population DESC
  LIMIT 1
  OFFSET 1;

SELECT DISTINCT binomial_name
  FROM animals;

SELECT binomial_name FROM animals
  ORDER BY length(binomial_name) DESC
  LIMIT 1;

SELECT first_name FROM celebrities
  WHERE date_part('year', date_of_birth) = 1958;

SELECT max(max_age_years) FROM animals;

SELECT avg(max_weight_kg) FROM animals;

SELECT count(id) FROM countries;

SELECT sum(population) FROM countries;

SELECT DISTINCT conservation_status, count(id)
  FROM animals
  GROUP BY conservation_status;

SELECT avg(burger_cost) FROM orders
  WHERE side = 'Fries';

SELECT min(side_cost) FROM orders
  WHERE side IS NOT NULL;

SELECT side, count(id) FROM orders
  WHERE side = 'Fries' OR side = 'Onion Rings'
  GROUP BY side;

ALTER TABLE animals
  ADD COLUMN class varchar(100);

UPDATE animals SET class = 'Aves';

ALTER TABLE animals
  ADD COLUMN phylum varchar(100),
  ADD COLUMN kingdom varchar(100);

UPDATE animals
  SET phylum = 'Chordata', kingdom = 'Animalia';

ALTER TABLE countries
  ADD COLUMN continent varchar(50);

UPDATE countries
  SET continent = 'Europe'
  WHERE name = 'France' OR name = 'Germany';

UPDATE countries
  SET continent = 'Asia'
  WHERE name = 'Japan';

UPDATE countries
  SET continent = 'North America'
  WHERE name = 'USA';

UPDATE celebrities
  SET deceased = true
  WHERE first_name = 'Elvis';

ALTER TABLE celebrities
  ALTER COLUMN deceased SET NOT NULL;

DELETE FROM celebrities
  WHERE first_name = 'Tom' AND last_name = 'Cruise';

ALTER TABLE celebrities RENAME TO singers;

DELETE FROM singers
  WHERE occupation NOT LIKE '%Singer%';

DELETE FROM countries;

UPDATE orders
  SET drink = 'Lemonade'
  WHERE customer_name = 'James Bergman' AND drink = 'Cola';

UPDATE orders
  SET side = 'Fries', side_cost = 0.99, customer_loyalty_points = 13
  WHERE customer_name = 'Aaron Muller';

UPDATE orders
  SET side_cost = 1.20
  WHERE side = 'Fries';

CREATE TABLE continents (
  id serial PRIMARY KEY,
  continent_name varchar(50)
);

ALTER TABLE countries
  DROP COLUMN continent;

ALTER TABLE countries
  ADD COLUMN continent_id integer;

ALTER TABLE countries
  ADD FOREIGN KEY (continent_id)
  REFERENCES continents(id);

INSERT INTO continents (continent_name)
  VALUES ('Asia'),
         ('Africa'),
         ('Europe'),
         ('North America'),
         ('South America');

INSERT INTO countries (name, capital, population, continent_id)
  VALUES ('Brazil', 'Brasilia', 208385000, 5),
         ('Egypt', 'Cairo', 96308900, 2),
         ('France', 'Paris', 67158000, 3),
         ('Germany', 'Berlin', 82349400, 3),
         ('Japan', 'Tokyo', 126672000, 1),
         ('USA', 'Washington D.C.', 325365189, 4);

ALTER TABLE singers
  ADD CONSTRAINT unique_id UNIQUE (id);

CREATE TABLE albums (
  id serial PRIMARY KEY,
  album_name varchar(100),
  released date,
  genre varchar(100),
  label varchar(100),
  singer_id integer,
  FOREIGN KEY (singer_id) REFERENCES singers(id)
);

INSERT INTO albums (album_name, released, genre, label, singer_id)
  VALUES ('Born to Run', '1975-08-25', 'Rock and roll', 'Columbia', 1),
         ('Purple Rain', '1984-06-25', 'Pop, R&B, Rock', 'Warner Bros', 6),
         ('Born in the USA', '1984-06-04', 'Rock and roll, pop', 'Columbia', 1),
         ('Madonna', '1983-07-27', 'Dance-pop, post-disco', 'Warner Bros', 5),
         ('True Blue', '1986-06-30', 'Dance-pop, Pop', 'Warner Bros', 5),
         ('Elvis', '1956-10-19', 'Rock and roll, Rhythm and Blues', 'RCA Victor', 7),
         ('Sign o'' the Times', '1987-03-30', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
         ('G.I. Blues', '1960-10-01', 'Rock and roll, Pop', 'RCA Victor', 7);

CREATE TABLE customers (
  id serial PRIMARY KEY,
  customer_name varchar(100)
);

CREATE TABLE email_addresses (
  customer_id integer PRIMARY KEY,
  customer_email varchar(50),
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

INSERT INTO customers (customer_name)
  VALUES ('James Bergman'),
         ('Natasha O''Shea'),
         ('Aaron Muller');

INSERT INTO email_addresses (customer_id, customer_email)
  VALUES (1, 'james1998@email.com'),
         (2, 'natasha@osheafamily.com');

CREATE TABLE products (
  id serial PRIMARY KEY,
  product_name varchar(50),
  product_cost numeric(4,2) DEFAULT 0,
  product_type varchar(20),
  product_loyalty_points integer
);

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
  VALUES ('LS Burger', 3.00, 'Burger', 10 ),
         ('LS Cheeseburger', 3.50, 'Burger', 15 ),
         ('LS Chicken Burger', 4.50, 'Burger', 20 ),
         ('LS Double Deluxe Burger', 6.00, 'Burger', 30 ),
         ('Fries', 1.20, 'Side', 3 ),
         ('Onion Rings', 1.50, 'Side', 5 ),
         ('Cola', 1.50, 'Drink', 5 ),
         ('Lemonade', 1.50, 'Drink', 5 ),
         ('Vanilla Shake', 2.00, 'Drink', 7 ),
         ('Chocolate Shake', 2.00, 'Drink', 7 ),
         ('Strawberry Shake', 2.00, 'Drink', 7);

DROP TABLE orders;

CREATE TABLE orders (
  id serial PRIMARY KEY,
  customer_id integer,
  order_status varchar(20),
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
  id serial PRIMARY KEY,
  order_id integer NOT NULL,
  product_id integer NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO orders (customer_id, order_status)
  VALUES (1, 'In Progress'),
         (2, 'Placed'),
         (2, 'Complete'),
         (3, 'Placed');

INSERT INTO order_items (order_id, product_id)
  VALUES (1, 3),
         (1, 5),
         (1, 6),
         (1, 8),
         (2, 2),
         (2, 5),
         (2, 7),
         (3, 4),
         (3, 2),
         (3, 5),
         (3, 5),
         (3, 6),
         (3, 10),
         (3, 9),
         (4, 1),
         (4, 5);

SELECT countries.name, continents.continent_name
  FROM countries
  JOIN continents
    ON continents.id = countries.continent_id;

SELECT countries.name, countries.capital
  FROM countries
  JOIN continents
    ON continents.id = countries.continent_id
  WHERE continents.continent_name = 'Europe';

SELECT DISTINCT singers.first_name
  FROM singers
  JOIN albums
    ON albums.singer_id = singers.id
  WHERE albums.label LIKE '%Warner Bros%';

SELECT singers.first_name, singers.last_name, albums.album_name, albums.released
  FROM singers
  JOIN albums
    ON albums.singer_id = singers.id
  WHERE albums.released >= '1980-01-01'
  AND albums.released < '1990-01-01'
  AND singers.deceased = false
  ORDER BY singers.date_of_birth DESC;

SELECT singers.first_name, singers.last_name
  FROM singers
  LEFT OUTER JOIN albums
    ON albums.singer_id = singers.id
  WHERE albums.id IS NULL;

SELECT first_name, last_name
  FROM singers
  WHERE id NOT IN (
    SELECT singer_id FROM albums
  );

SELECT orders.*, products.*
  FROM orders
  JOIN order_items
    ON orders.id = order_items.order_id
  JOIN products
    ON products.id = order_items.product_id;

SELECT o.id
  FROM orders AS o
  JOIN order_items AS oi
    ON o.id = oi.order_id
  JOIN products AS p
    ON p.id = oi.product_id
  WHERE p.product_name = 'Fries';

SELECT DISTINCT c.customer_name AS "Customers who like Fries"
  FROM customers AS c
  JOIN orders AS o
    ON c.id = o.customer_id
  JOIN order_items AS oi
    ON o.id = oi.order_id
  JOIN products AS p
    ON p.id = oi.product_id
  WHERE p.product_name = 'Fries';

SELECT sum(products.product_cost)
  FROM products
  JOIN order_items
    ON order_items.product_id = products.id
  JOIN orders
    ON orders.id = order_items.order_id
  JOIN customers
    ON orders.customer_id = customers.id
  WHERE customers.customer_name = 'Natasha O''Shea';

SELECT products.product_name, COUNT(order_items.id)
  FROM products
  JOIN order_items
    ON order_items.product_id = products.id
  GROUP BY products.product_name
  ORDER BY products.product_name;
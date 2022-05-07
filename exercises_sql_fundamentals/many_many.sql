CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10,2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
  VALUES ('Pat Johnson', 'XHGOAHEQ'),
         ('Nancy Monreal', 'JKWQPJKL'),
         ('Lynn Blake', 'KLZXWEEE'),
         ('Chen Ke-Hua', 'KWETYCVX'),
         ('Scott Lakso', 'UUEAPQPS'),
         ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price)
VALUES ('Unix Hosting', 5.95),
       ('DNS', 4.95),
       ('Whois Registration', 1.95),
       ('High Bandwidth', 15.00),
       ('Business Support', 250.00),
       ('Dedicated Hosting', 50.00),
       ('Bulk Email', 250.00),
       ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
  service_id integer NOT NULL REFERENCES services(id),
  UNIQUE (customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id)
  VALUES (1, 1),
         (1, 2),
         (1, 3),
         (3, 1),
         (3, 2),
         (3, 3),
         (3, 4),
         (3, 5),
         (4, 1),
         (4, 4),
         (5, 1),
         (5, 2),
         (5, 6),
         (6, 1),
         (6, 6),
         (6, 7);

SELECT DISTINCT customers.* FROM customers
  JOIN customers_services
    ON customers.id = customers_services.customer_id;

SELECT DISTINCT customers.* FROM customers
  LEFT OUTER JOIN customers_services
    ON customers.id = customers_services.customer_id
  WHERE customers_services.service_id IS NULL;

SELECT customers.*, services.* FROM customers
  FULL OUTER JOIN customers_services
    ON customers.id = customers_services.customer_id
  FULL OUTER JOIN services
    ON services.id = customers_services.service_id
  WHERE customers_services.service_id IS NULL OR customers_services.customer_id IS NULL;

SELECT services.description FROM customers_services
  RIGHT OUTER JOIN services
    ON services.id = customers_services.service_id
  WHERE customers_services.service_id IS NULL;

SELECT customers.name, string_agg(services.description, ', ') AS services
  FROM customers
  LEFT OUTER JOIN customers_services
    ON customers.id = customers_services.customer_id
  LEFT OUTER JOIN services
    ON services.id = customers_services.service_id
  GROUP BY customers.name;

SELECT services.description, count(customers_services.customer_id)
  FROM services
  JOIN customers_services
    ON services.id = customers_services.service_id
  GROUP BY services.description
  HAVING count(customers_services.customer_id) >= 3
  ORDER BY services.description;

SELECT sum(services.price) AS gross
  FROM services
  JOIN customers_services
    ON services.id = customers_services.service_id;

INSERT INTO customers (name, payment_token)
  VALUES ('John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id)
  VALUES (7, 1), (7, 2), (7, 3);

SELECT sum(price)
  FROM services
  JOIN customers_services
    ON service_id = services.id
  WHERE price > 100;

SELECT sum(price)
  FROM services
  CROSS JOIN customers
  WHERE price > 100;

DELETE FROM customers WHERE name = 'Chen Ke-Hua';

DELETE FROM customers_services
  WHERE service_id IN (SELECT id FROM services WHERE description = 'Bulk Email');

DELETE FROM services WHERE description = 'Bulk Email';
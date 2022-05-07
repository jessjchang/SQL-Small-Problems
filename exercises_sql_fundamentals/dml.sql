CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices(id)
);

INSERT INTO devices (name)
  VALUES ('Accelerometer'),
         ('Gyroscope');

INSERT INTO parts (part_number, device_id)
  VALUES (1, 1),
         (2, 1),
         (3, 1);

INSERT INTO parts (part_number, device_id)
  VALUES (4, 2),
         (5, 2),
         (6, 2),
         (7, 2),
         (8, 2);

INSERT INTO parts (part_number)
  VALUES (9), (10), (11);

SELECT devices.name, parts.part_number
  FROM devices
  INNER JOIN parts
    ON devices.id = parts.device_id;

SELECT * FROM parts
  WHERE part_number::text LIKE '3%';

SELECT devices.name, count(parts.device_id)
  FROM devices
  LEFT OUTER JOIN parts
    ON devices.id = parts.device_id
  GROUP BY devices.name;

SELECT devices.name, count(parts.device_id)
  FROM devices
  LEFT OUTER JOIN parts
    ON devices.id = parts.device_id
  GROUP BY devices.name
  ORDER BY devices.name DESC;

SELECT part_number, device_id
  FROM parts WHERE device_id IS NOT NULL
  ORDER BY part_number, device_id;

SELECT part_number, device_id
  FROM parts WHERE device_id IS NULL
  ORDER BY part_number;

SELECT name AS oldest_device FROM devices
  ORDER BY created_at
  LIMIT 1;

UPDATE parts
  SET device_id = (SELECT id FROM devices WHERE name = 'Accelerometer')
  WHERE part_number IN (SELECT part_number FROM parts WHERE device_id = 2 ORDER BY part_number DESC LIMIT 2);

UPDATE parts
  SET device_id = (SELECT id FROM devices WHERE name = 'Gyroscope')
  WHERE part_number IN (SELECT part_number FROM parts ORDER BY part_number LIMIT 1);

DELETE FROM parts
  WHERE device_id = (SELECT id FROM devices WHERE name = 'Accelerometer');

DELETE FROM devices
  WHERE name = 'Accelerometer';
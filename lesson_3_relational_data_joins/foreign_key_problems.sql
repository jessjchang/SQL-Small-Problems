ALTER TABLE orders
  ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);

INSERT INTO products (name)
  VALUES ('small bolt'),
         ('large bolt');

INSERT INTO orders (product_id, quantity)
  VALUES (1, 10),
         (1, 25),
         (2, 15);

SELECT orders.quantity, products.name
  FROM products
  JOIN orders
    ON orders.product_id = products.id
  ORDER BY products.name DESC, orders.quantity ASC;

INSERT INTO orders (quantity) VALUES (10);

ALTER TABLE orders
  ALTER COLUMN product_id SET NOT NULL;

DELETE FROM orders WHERE product_id IS NULL;

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  description text NOT NULL,
  product_id integer REFERENCES products(id) NOT NULL
);

INSERT INTO reviews (description, product_id)
  VALUES ('a little small', 1),
         ('very round!', 1),
         ('could have been smaller', 2);
CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6,2) NOT NULL CHECK (initial_price BETWEEN 0.01 AND 1000.00),
  sales_price numeric(6,2) CHECK (sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL CHECK (amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

\copy bidders FROM 'bidders.csv' WITH HEADER CSV;

\copy items FROM 'items.csv' WITH HEADER CSV;

\copy bids FROM 'bids.csv' WITH HEADER CSV;

SELECT name AS "Bid on Items" FROM items
  WHERE id IN (
    SELECT DISTINCT item_id FROM bids
);

SELECT name AS "Not Bid On" FROM items
  WHERE id NOT IN (
    SELECT DISTINCT item_id FROM bids
  );

SELECT name FROM bidders
  WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

SELECT bidders.name FROM bidders
  JOIN bids
    ON bids.bidder_id = bidders.id
  GROUP BY bidders.id
  ORDER BY bidders.id;

SELECT max(bid_counts.count) FROM (
  SELECT count(bidder_id) FROM bids
    GROUP BY bidder_id) AS bid_counts;

SELECT name,
    (SELECT count(item_id) FROM bids WHERE item_id = items.id)
  FROM items;

SELECT items.name, count(bids.item_id)
  FROM items
  LEFT OUTER JOIN bids
    ON items.id = bids.item_id
  GROUP BY items.id
  ORDER BY items.id;

SELECT id FROM items
  WHERE ROW('Painting', 100.00, 250.00) =
    ROW(name, initial_price, sales_price);
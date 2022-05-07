SELECT count(*) FROM tickets;

SELECT count(DISTINCT customer_id) FROM tickets;

SELECT round((count(DISTINCT tickets.customer_id) / count(DISTINCT customers.id)::decimal) * 100, 2) AS percent
  FROM customers
  LEFT OUTER JOIN tickets
    ON customers.id = tickets.customer_id;

SELECT events.name, count(tickets.id) AS popularity
  FROM events
  LEFT OUTER JOIN tickets
    ON events.id = tickets.event_id
  GROUP BY events.id
  ORDER BY popularity DESC;

SELECT c.id, c.email, count(DISTINCT t.event_id)
  FROM customers AS c
  JOIN tickets AS t
    ON c.id = t.customer_id
  GROUP BY c.id
  HAVING count(DISTINCT t.event_id) = 3;

SELECT e.name AS event, e.starts_at, sc.name AS section, s.row, s.number AS seat
  FROM customers AS c
  JOIN tickets AS t
    ON c.id = t.customer_id
  JOIN events AS e
    ON e.id = t.event_id
  JOIN seats AS s
    ON s.id = t.seat_id
  JOIN sections AS sc
    ON s.section_id = sc.id
  WHERE c.email = 'gennaro.rath@mcdermott.co';
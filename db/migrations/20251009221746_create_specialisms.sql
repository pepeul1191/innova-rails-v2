-- migrate:up

CREATE TABLE specialisms (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(70) NOT NULL
);

-- migrate:down

DROP TABLE specialisms;
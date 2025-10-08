CREATE TABLE IF NOT EXISTS "schema_migrations" (version varchar(128) primary key);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE periods (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(10) NOT NULL UNIQUE,
  init_date DATE NOT NULL,
  end_date DATE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE program_types (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(20) NOT NULL UNIQUE
);
-- Dbmate schema migrations
INSERT INTO "schema_migrations" (version) VALUES
  ('20251007234822'),
  ('20251008125721'),
  ('20251008125724');

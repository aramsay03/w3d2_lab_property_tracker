DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  address VARCHAR(255),
  value INT,
  bedrooms INT,
  build VARCHAR(255),
  id SERIAL PRIMARY KEY
);

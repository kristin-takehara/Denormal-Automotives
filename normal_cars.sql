\c KRISTINTAKEHARA

DROP DATABASE normal_cars;
DROP USER normal_user;

-- ## Modeling a Normalized Schema
-- Write your queries in `normal_cars.sql` when instructed to.

-- 1. Create a new postgres user named `normal_user`.

CREATE USER normal_user;

-- 1. Create a new database named `normal_cars` owned by `normal_user`.

CREATE DATABASE normal_cars
OWNER normal_user;

\c normal_cars;
\i scripts/denormal_data.sql;

-- 1. Whiteboard your solution to normalizing the `denormal_cars` schema.

--DONE

-- 1. [bonus] Generate a diagram (somehow) in .png (or other) format, that of your normalized cars schema. (save and commit to this repo).

-- SEE IMAGE FILE

-- 1. In `normal_cars.sql` Create a query to generate the tables needed to accomplish your normalized schema, including any primary and foreign key constraints. Logical renaming of columns is allowed.

-- 1. Using the resources that you now possess, In `normal_cars.sql` Create queries to insert **all** of the data that was in the `denormal_cars.car_models` table, into the new normalized tables of the `normal_cars` database.

CREATE TABLE IF NOT EXISTS years (
year integer PRIMARY KEY
);


CREATE TABLE IF NOT EXISTS make (
id SERIAL PRIMARY KEY,
make_code VARCHAR(255) NULL,
make_title VARCHAR(255) NULL
);

CREATE TABLE IF NOT EXISTS model (
id SERIAL PRIMARY KEY,
make_id integer REFERENCES make (id),
model_code VARCHAR(255) NULL,
model_title VARCHAR(255) NULL,
year integer REFERENCES years (year)
);

------------------------------

INSERT INTO years (year) SELECT DISTINCT year FROM car_models;

INSERT INTO make (make_code) SELECT DISTINCT make_code FROM car_models;
INSERT INTO make (make_title) SELECT DISTINCT make_title FROM car_models;

INSERT INTO model (model_code) SELECT DISTINCT model_code FROM car_models;
INSERT INTO model (model_title) SELECT DISTINCT model_title FROM car_models;

------------------------------

-- 1. In `normal_cars.sql` Create a query to get a list of all `make_title` values in the `car_models` table. Without any duplicate rows, this should have 71 results.

SELECT DISTINCT make_title
FROM car_models;

-- 1. In `normal_cars.sql` Create a query to list all `model_title` values where the `make_code` is `'VOLKS'` Without any duplicate rows, this should have 27 results.

SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';

-- 1. In `normal_cars.sql` Create a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`. Without any duplicate rows, this should have 136 rows.

SELECT DISTINCT (make_code, model_code, model_title, year)
FROM car_models
WHERE make_code = 'LAM';

-- 1. In `normal_cars.sql` Create a query to list all fields from all `car_models` in years between `2010` and `2015`. Without any duplicate rows, this should have 7884 rows.

SELECT DISTINCT (make_code, make_title, model_code, model_title, year)
FROM car_models
WHERE year BETWEEN 2010 AND 2015;
-- 01_setup_db_and_schema.sql


CREATE DATABASE tp_ecommerce;
\c tp_ecommerce

CREATE SCHEMA IF NOT EXISTS shop AUTHORIZATION postgres;
SET search_path TO shop, public;


CREATE USER tp_user WITH PASSWORD 'tp_pass';
GRANT CONNECT ON DATABASE tp_ecommerce TO tp_user;
GRANT USAGE ON SCHEMA shop TO tp_user;
ALTER DATABASE tp_ecommerce OWNER TO postgres;
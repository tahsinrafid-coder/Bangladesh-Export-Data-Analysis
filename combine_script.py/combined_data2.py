CREATE TABLE combined_data2 (
    country VARCHAR(100),
    hs_code VARCHAR(20),
    product TEXT,
    value TEXT,
    fiscal_year VARCHAR(20)
);

ALTER TABLE combined_data2
ALTER COLUMN value TYPE NUMERIC
USING REPLACE(value, ',', '')::NUMERIC;

SELECT SUM(value)
FROM combined_data2
WHERE fiscal_year = '2017-2018';

SELECT DISTINCT country
FROM combined_data2;

ALTER TABLE combined_data2




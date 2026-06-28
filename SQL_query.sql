CREATE TABLE combined_data2 (
    country VARCHAR(100),
    hs_code VARCHAR(20),
    product TEXT,
    value TEXT,
    fiscal_year VARCHAR(20)
);

ALTER TABLE combined_data
ALTER COLUMN value TYPE NUMERIC
USING REPLACE(value, ',', '')::NUMERIC;

SELECT *
FROM combined_data2;

--create category
SELECT *, 
CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
     WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
	 ELSE 'OTHERS'
END AS category
FROM combined_data2;

---export value by fiscal year for knit and woven
SELECT fiscal_year, 
CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
     WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
	 ELSE 'OTHERS'
END AS category,
SUM(value) AS export_value
FROM combined_data2
WHERE LOWER(product) LIKE '%denim%'
   OR LOWER(product) LIKE '%woven%'
   OR LOWER(product) LIKE '%knit%'
GROUP BY fiscal_year, category
ORDER BY fiscal_year;

---Total decade growht
---beginning vs ending year
WITH yearly AS
(
SELECT fiscal_year, 
CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
     WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
	 ELSE 'OTHERS'
END AS category,
SUM(value) AS export_value
FROM combined_data2
WHERE LOWER(product) LIKE '%denim%'
   OR LOWER(product) LIKE '%woven%'
   OR LOWER(product) LIKE '%knit%'
GROUP BY fiscal_year, category
)
SELECT * 
FROM yearly;

--overall groeth
WITH yearly AS
(
SELECT fiscal_year, 
CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
     WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
	 ELSE 'OTHERS'
END AS category,
SUM(value) AS export_value
FROM combined_data2
WHERE LOWER(product) LIKE '%denim%'
   OR LOWER(product) LIKE '%woven%'
   OR LOWER(product) LIKE '%knit%'
GROUP BY fiscal_year, category
)

SELECT 
category,
MIN(export_value) AS first_year_value,
MAX(export_value) AS last_year_value,
ROUND ((MAX(export_value)-MIN(export_value))/MIN(export_value)*100,2) growth_percent
FROM yearly
GROUP BY category;

--peak year and weakest year
WITH yearly AS
(
SELECT fiscal_year, 
CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
     WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
	 ELSE 'OTHERS'
END AS category,
SUM(value) AS export_value
FROM combined_data2
WHERE LOWER(product) LIKE '%denim%'
   OR LOWER(product) LIKE '%woven%'
   OR LOWER(product) LIKE '%knit%'
GROUP BY fiscal_year, category
)

SELECT *
FROM 
(
SELECT *,
RANK() OVER(PARTITION BY category ORDER BY export_value DESC) peak_rank,
RANK() OVER(PARTITION BY category ORDER BY export_value ASC) weak_rank
FROM yearly
) AS t

WHERE peak_rank = 1 OR weak_rank=1;

-- pandemic dip and recovery
SELECT fiscal_year,
SUM(value) AS export_value
FROM combined_data2
WHERE fiscal_year IN ('2018-2019','2019-2020','2020-2021','2021-2022')
GROUP BY fiscal_year
ORDER BY fiscal_year;

---Y0Y growth%
CREATE VIEW YoY growth%

WITH yearly AS
(
SELECT fiscal_year, 
CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
     WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
	 ELSE 'OTHERS'
END AS category,
SUM(value) AS export_value
FROM combined_data2
WHERE LOWER(product) LIKE '%denim%'
   OR LOWER(product) LIKE '%woven%'
   OR LOWER(product) LIKE '%knit%'
GROUP BY fiscal_year, category
)

SELECT category, fiscal_year, export_value,ROUND(
export_value - LAG(export_value) OVER(PARTITION BY category ORDER BY fiscal_year)
/ 
LAG(export_value) OVER(PARTITION BY category ORDER BY fiscal_year) * 100,2
) AS yoy_growth_pact
FROM yearly;

--CAGR
CREATE VIEW CAGR AS

WITH yearly AS
(
    SELECT fiscal_year, 
    CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
         WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
         ELSE 'OTHERS'
    END AS category,
    SUM(value) AS export_value
    FROM combined_data2
    WHERE LOWER(product) LIKE '%denim%'
       OR LOWER(product) LIKE '%woven%'
       OR LOWER(product) LIKE '%knit%'
    GROUP BY fiscal_year, category
), -- 1. Fixed: Added missing comma here

ranked AS
(
    SELECT * ,
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY fiscal_year) AS rn1,
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY fiscal_year DESC) AS rn2
    FROM yearly
)

SELECT a.category, -- 2. Fixed: Replaced dot with a comma
a.export_value AS beginning_value, -- 3. Fixed: Changed total_value to export_value
b.export_value AS ending_value,    -- 3. Fixed: Changed total_value to export_value
ROUND(
    (
    POWER(b.export_value / a.export_value, 1.0 / 13) - 1 -- 4. Fixed: Corrected typo and column names
    ) * 100,
    2) AS cagr_percent -- 5. Optional: Fixed typo in alias 'precent'
FROM ranked a
JOIN ranked b
ON a.category = b.category
WHERE a.rn1 = 1
AND b.rn2 = 1;

--Contribution to Total Growth

WITH category_growth AS
(
    SELECT  
    CASE WHEN LOWER(product) LIKE '%denim%' OR LOWER(product) LIKE '%woven%' THEN 'WOVEN'
         WHEN LOWER(product) LIKE '%knit%' THEN 'KNIT'
         ELSE 'OTHERS'
    END AS category,
    SUM(value) AS export_value
    FROM combined_data2
    WHERE LOWER(product) LIKE '%denim%'
       OR LOWER(product) LIKE '%woven%'
       OR LOWER(product) LIKE '%knit%'
    GROUP BY category
)

SELECT 
category,
ROUND(export_value,2),
ROUND(100*export_value/SUM(export_value) OVER(),2) AS contribution_percent
FROM category_growth;
DROP TABLE population;
DROP TABLE cases;
DROP TABLE rates;

CREATE TABLE population(
country char(80) NOT NULL,
year integer NOT NULL,
population integer NOT NULL

);

COPY population FROM   
'/Users/chittampalliyashaswini/Desktop/Yadu/population.csv'
DELIMITER ',' CSV HEADER;

CREATE TABLE cases AS
(SELECT country, year, SUM(child + adult + elderly) AS cases
FROM tb
GROUP BY country, year
ORDER BY country

);


CREATE TABLE rates AS
(SELECT cases.country, cases.year, 
(CAST(cases.cases AS FLOAT)/(CAST(population.population AS FLOAT))) AS rates
FROM cases
INNER JOIN population
ON cases.country = population.country
AND cases.year = population.year
WHERE cases IS NOT NULL
ORDER BY cases.country, cases.year);

COPY 
(SELECT cases.country, cases.year, 
(CAST(cases.cases AS FLOAT)/(CAST(population.population AS FLOAT))) AS rates
FROM cases
INNER JOIN population
ON cases.country = population.country
AND cases.year = population.year
WHERE cases IS NOT NULL
ORDER BY cases.country, cases.year)
TO '/Users/chittampalliyashaswini/Desktop/Yadu/rates.csv'
DELIMITER ',' CSV HEADER;



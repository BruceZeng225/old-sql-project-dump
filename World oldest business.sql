-- What is the oldest business on each continent?
SELECT c.continent, country, business, year_founded 
FROM public.countries as c
INNER JOIN public.businesses as b  -- joins country and businesses together
USING (country_code)
INNER JOIN 
	(SELECT continent, min(year_founded) as continent_oldest_year -- found the oldest founding date for each continent 
	FROM public.countries
	INNER JOIN public.businesses
	USING (country_code)
	GROUP BY continent) as sub
ON c.continent = sub.continent
	AND b.year_founded = sub.continent_oldest_year; -- pick out businesses based on the oldest founding date

-- How many countries per continent lack data on the oldest businesses
-- Does including the `new_businesses` data change this?
SELECT continent, count(*) as countries_without_businesses
FROM public.countries as c
LEFT JOIN 
	(SELECT *
	FROM public.businesses
	UNION ALL
	SELECT *
	FROM public.new_businesses) as sub
	
USING(country_code)
WHERE sub.business is null
GROUP BY continent;

-- Which business categories are best suited to last over the course of centuries?
SELECT continent, category, min(year_founded) as year_founded 
FROM public.countries
INNER JOIN public.businesses
USING(country_code)
INNER JOIN public.categories
USING(category_code)

GROUP BY continent, category
ORDER BY continent, category ASC;

-- List the overall top five names in alphabetical order and find out if each name is "Classic" or "Trendy."
select first_name, sum(num) as sum,
case 
	when count(year) > 50 then 'Classic'
	else 'Trendy' end as popularity_type
	
from public.baby_names as bn
group by first_name
order by first_name
limit 5;

-- What were the top 20 male names overall, and how did the name Paul rank?
select Rank() over (order by sum(num) desc) as name_rank,
first_name, sum(num) as sum
from public.baby_names
where sex = 'M'
group by first_name
order by name_rank
limit 20;

-- Which female names appeared in both 1920 and 2020?
-- Select first name and total occurrences
SELECT a.first_name, (a.num + b.num) AS total_occurrences
FROM baby_names a
JOIN baby_names b
-- Join on first name
ON a.first_name = b.first_name
-- Filter for the years 1920 and 2020 and sex equals 'F'
WHERE a.year = 1920 AND a.sex = 'F'
AND b.year = 2020 AND b.sex = 'F';
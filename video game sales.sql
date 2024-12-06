-- best_selling_games
select *
from public.game_sales
order by public.game_sales.games_sold desc
limit 10;

-- critics_top_ten_years
select year, count(year) as num_games, round(avg(public.reviews.critic_score),2) as avg_critic_score
from public.game_sales
join public.reviews on public.game_sales.name = public.reviews.name
group by year
having count(public.game_sales.year) >= 4
order by avg_critic_score desc
limit 10;

-- golden_years
select public.critics_avg_year_rating.year as year, public.critics_avg_year_rating.num_games, avg_critic_score, avg_user_score, public.critics_avg_year_rating.avg_critic_score - public.users_avg_year_rating.avg_user_score as diff
from public.critics_avg_year_rating
join public.users_avg_year_rating on public.critics_avg_year_rating.year = public.users_avg_year_rating.year
where avg_critic_score > 9 or avg_user_score > 9
order by year asc
limit 10;
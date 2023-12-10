with monthly_revenue as (
select 
    date_part('month', created_at) as month,
    sum(t.quantity * p.price) revenue
from transactions t 
inner join products p 
    on t.product_id = p.id
-- choose only year = 2019
where date_part('year', created_at) = 2019
group by 1
)
select
    month,
    round(month_over_month, 2) as month_over_month
from (
    select
        month,
        -- month over month change: (this revenue - last revenue)/last revenue
        ((revenue - lag(revenue, 1) OVER(ORDER BY month ASC))
        /lag(revenue, 1) OVER(ORDER BY month ASC))::numeric as month_over_month
    from monthly_revenue
) i;
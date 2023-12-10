-- https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced?code_type=1

with a as (
    select
        user_id,
        created_at,
        product_id,
        dense_rank() over (partition by user_id order by created_at) as date_rank,
        dense_rank() over (partition by user_id, product_id order by created_at) as product_rank
    from
        marketing_campaign
)
select
    count(distinct user_id)
from
    a
where
    -- get users made one or multiple purchases NOT ONLY on the first day
    date_rank > 1
    -- get users that over time purchase NOT ONLY the products they purchased on the first day
    and product_rank = 1;

select
    count(distinct user_id) from (
        select
            *,
            -- first date of purchase is different from other dates of purchase
            -- product first purchased is different from products purchased
            case when min(created_at) over (partition by user_id)
            <> min(created_at) over(partition by user_id, product_id) then 1 else 0 end as is_valid
        from marketing_campaign
    ) a
where is_valid = 1;
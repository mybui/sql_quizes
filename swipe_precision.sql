-- https://www.interviewquery.com/questions/swipe-precision

with a as (
    select
        user_id,
        count(*) as swipe_threshold,
        sum(is_right_swipe) as total_right_swipes
    from
        swipes
    -- swiped at least 10 times
    -- swiped 10, 50, and 100 swipes
    group by
        user_id
    having
        count(*) in (10, 50, 100)
)
select
    v.variant,
    -- average number of right swipes for two different variants 
    sum(total_right_swipes)/count(s.user_id) as mean_right_swipes,
    a.swipe_threshold,
    count(distinct a.user_id) as num_users
from
    a
join
    swipes s on a.user_id = s.user_id
join
    variants v on v.user_id = s.user_id
group by
    v.variant, swipe_threshold;


-- https://www.interviewquery.com/questions/liked-pages

select
    f.user_id,
    p.page_id,
    count(friend_id) as num_friend_likes
from
    friends f
-- get friends pages
left join
    page_likes p
    on f.friend_id = p.user_id
-- exclude user pages already liked
where
    (f.user_id, p.page_id) not in (
            select distinct user_id,page_id from page_likes
        )
group by
    f.user_id,
    p.page_id;
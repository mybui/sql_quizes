select user_fullname
from (
    select
        concat(n.user_firstname, ' ', n.user_lastname) as user_fullname,
        dense_rank() over(order by count(distinct n.video_id) desc) as place
    from user_flags n 
    join flag_review r on n.flag_id = r.flag_id
    where
        reviewed_outcome like 'APPROVED'
        and reviewed_by_yt = true
    group by user_fullname
) i
where place = 1;
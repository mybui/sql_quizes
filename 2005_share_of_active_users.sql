select avg(case when status = 'open' then 1 else 0 end) as usa_open_count
from fb_active_users
where country = 'USA';
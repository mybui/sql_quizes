-- https://leetcode.com/problems/trips-and-users/description/

select
    t.request_at as Day,
    round(avg(case when t.status = 'cancelled_by_driver' or t.status = 'cancelled_by_client' then 1 else 0 end), 2) as "Cancellation Rate"
from
    Trips t
join
    Users u1 on t.client_id = u1.users_id
join
    Users u2 on t.driver_id = u2.users_id
where 
    u1.banned = 'No'
    and u2.banned = 'No' 
    and t.request_at between '2013-10-01' and '2013-10-03'
group by
    t.request_at;
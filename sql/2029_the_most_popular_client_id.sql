-- https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls/discussion?code_type=1

with rate as (
    select
        client_id,
        user_id
    from fact_events
    group by client_id, user_id
    having avg(
        case
            when event_type in ('video call received', 'video call sent', 'voice call received', 'voice call sent') then 1
            else 0
        end) >= 0.5
), rk as (
    select
        client_id,
        -- rank by order of user id counts descending
        -- i.e. the most valid users first
        rank() over(order by count(user_id) desc) as place
    from rate
    group by client_id
) select
    client_id
from rk
where place = 1;
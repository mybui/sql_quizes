with voter_scores as (
    select 
        voter,
        candidate,
        -- or use group by
        -- 1st get individual score for each voter
        1/count(candidate) over(partition by voter) as score
    from voting_results
    where candidate is not null
), total_scores as (
    select
        candidate,
        -- 2nd sum for total score
        sum(score) as total_score
    from voter_scores
    group by candidate
), rk as (
    select
        candidate,
        -- 3rd rank for the highest place
        dense_rank() over(ORDER BY total_score DESC) as place
    from total_scores
) select candidate from rk where place = 1;

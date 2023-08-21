select
    student_id
from sat_scores
where sat_writing = (
    select
        percentile_cont(0.5) within group (order by sat_writing) as median
    from sat_scores
);
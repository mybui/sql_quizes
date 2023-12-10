-- https://leetcode.com/problems/exchange-seats/description/

with student_to_swap as (
    select
    id,
    student,
    lag(student, 1) over(order by id) as previous_student,
    lead(student, 1) over(order by id) as next_student
from
    Seat
)
select
    id,
    case
        -- swap the seat id of every two consecutive students
        when id % 2 != 0 and next_student is not null then next_student
        -- the id of the last student is not swapped
        when id % 2 != 0 and next_student is null then student
        -- swap the seat id of every two consecutive students
        when id % 2 = 0 then previous_student
        else null
    end as student
from
    student_to_swap;
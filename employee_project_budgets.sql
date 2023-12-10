-- https://www.interviewquery.com/questions/employee-project-budgets

with a as (
    select
        title,
        --budget to employee count ratio
        max(budget)/count(e.employee_id)::numeric as budget_per_employee
    from employee_projects e
    join projects p on p.id = e.project_id
    group by title
)
select
    title,
    budget_per_employee
from
    a
order by
    budget_per_employee desc
--top five most expensive projects
limit 5;
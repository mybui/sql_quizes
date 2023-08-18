select a.entry_date,
    count(a.account_id) as premium_paid_accounts,
    count(b.account_id) as premium_paid_accounts_after_7_days
from premium_accounts_by_day a
-- left join instead of join to not miss records
-- that started as paid but didn't maintain paid after 7 days
left join premium_accounts_by_day b on a.account_id = b.account_id and datediff(b.entry_date, a.entry_date) = 7
-- condition for final prize must be put inside left join
-- to not miss records that started as paid but didn't maintain paid after 7 days
and b.final_price > 0
where a.final_price > 0
group by a.entry_date
order by a.entry_date
limit 7;
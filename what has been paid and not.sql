select c.name, min_due, due_date, s.code, weekending
from credit c
join credit_status s on c.credit_status_id = s.credit_status_id
join date_dimension dd on c.due_date = dd.DateKey
where c.name <> 'GTE Credit'
and s.code = 'UNPAID'
and due_date < '2022-05-13'
order by dd.WeekEnding, due_date

select c.name, min_due, due_date, s.code, weekending
from credit c
join credit_status s on c.credit_status_id = s.credit_status_id
join date_dimension dd on c.due_date = dd.DateKey
where c.name <> 'GTE Credit'
and s.code = 'UNPAID'
and due_date >= '2022-05-13'
order by dd.WeekEnding, due_date

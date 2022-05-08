USE Budget

select min_due, s.code[status], iif(dd.DayOfWeekName in ('Saturday','Sunday'), dateadd(week, -1,dd.WeekEnding), dd.weekending)[weekending]
into #credit
from credit c
join credit_status s on c.credit_status_id = s.credit_status_id
join date_dimension dd on c.due_date = dd.DateKey
where c.name <> 'GTE Credit'

select sum(min_due), status, weekending
from #credit
group by status, weekending

;with cte as (
			  select amount_due[amount_due], s.code[status], iif(dd.dayofweekname in ('Saturday','Sunday'), dateadd(week, -1,dd.weekending), dd.weekending)[weekending]
			  from bill c			  
			  join bill_status s on c.bill_status_id = s.bill_status_id
			  join date_dimension dd on c.due_date = dd.DateKey
			  where c.active_flag = 1
			  and c.name <> 'Mortgage'			  
			  
			  union all 
			  
			  select min_due, s.code, iif(dd.dayofweekname in ('Saturday','Sunday'), dateadd(week, -1,dd.weekending), dd.weekending)[weekending]
			  from credit c			  
			  join credit_status s on c.credit_status_id = s.credit_status_id
			  join date_dimension dd on c.due_date  = dd.DateKey
			  where c.name = 'GTE Credit'			  

			  )

			  select sum(amount_due), status, weekending
			  from cte 
			  group by status, weekending			  
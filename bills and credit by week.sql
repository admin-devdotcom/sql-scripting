USE Budget

;with cte as (
			  select b.name, amount_due, due_date, s.name[status]
			       , case when dd.WeekOfYear = 18 then 'Week 5'
			  	        when dd.WeekOfYear = 19 then 'Week 1'
			  			when dd.WeekOfYear = 20 then 'Week 2'
			  			when dd.WeekOfYear = 21 then 'Week 3'
			  			when dd.WeekOfYear = 22 then 'Week 4' end [week]
			  from bill b
			  join bill_status s on b.bill_status_id = s.bill_status_id
			  join date_dimension dd on b.due_date = dd.DateKey
			  where s.code = 'UNPAID'
			  
			  union all 
			  
			  select c.name, min_due, due_date, s.name[status]
			       , case when dd.WeekOfYear = 18 then 'Week 5'
			  	        when dd.WeekOfYear = 19 then 'Week 1'
			  			when dd.WeekOfYear = 20 then 'Week 2'
			  			when dd.WeekOfYear = 21 then 'Week 3'
			  			when dd.WeekOfYear = 22 then 'Week 4' end [week]
			  from credit c 
			  join credit_status s on c.credit_status_id = s.credit_status_id
			  join date_dimension dd on c.due_date = dd.DateKey
			  where s.code = 'UNPAID'
			)

select sum(amount_due)[amount_due], [week] from cte group by [week]
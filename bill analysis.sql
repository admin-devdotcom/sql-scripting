USE Budget

if object_id('tempdb..#bill') is not null drop table #bill
if object_id('tempdb..#income2') is not null drop table #income2

select sum(amount_due)[Bills Amount Due]
from bill 
where active_flag = 1

select name[Name], amount_due[Amount Due]
from bill 
where active_flag = 1
order by amount_due 

select sum(amount_due)[Amount Due]
from bill 
where active_flag = 1

select sum(weekly_gross) * 4[Monthly Income]
from income

select 1[type], sum(amount_due)[Amount Due]
into #bill
from bill 
where active_flag = 1

select 1[type], sum(weekly_gross) * 4[Monthly Income]
into #income
from income

select ([Amount Due] / [Monthly Income]) * 100[Bill to Income Ratio]
from #income i
join #bill b on i.type = b.type
USE Budget

if object_id('tempdb..#credit') is not null drop table #credit
if object_id('tempdb..#income') is not null drop table #income

select sum(credit_limit)[Total Credit Limit], sum(allowable)[Total Available], sum(balance)[Total Due], sum(min_due)[Min Due]
from credit c
where balance > 0

select sum(balance) / sum(credit_limit)[Utilization]
from credit c
where balance > 0

select name[Name], credit_limit[Credit Limit], allowable[Available], balance[Balance], min_due[Min Due]
from credit
where balance > 0
order by balance 

select sum(min_due)[Min Due]
from credit c
where balance > 0

select 1[type], sum(min_due)[Min Due]
into #credit
from credit c
where balance > 0

select 1[type], sum(weekly_gross) * 4[Monthly Income]
into #income
from income

select ([Min Due] / [Monthly Income] ) * 100 [Credit to Income Ratio]
from #credit c
join #income i on c.type = i.type
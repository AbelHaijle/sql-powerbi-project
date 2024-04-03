select *
from Absenteeism_at_work$ ab
left join compensation$ com
on ab.id = com.id
left join reasons$ rea
on ab.[Reason for absence] = rea.number


--find the healthiest employees for the bonus
select *
from Absenteeism_at_work$ ab
left join compensation$ com
on ab.id = com.id
left join reasons$ rea
on ab.[Reason for absence] = rea.number
where ab.[Body mass index] < '25' and ab.[Social smoker] = '0' and ab.[Social drinker] = '0' 
and [Absenteeism time in hours] < (select avg([Absenteeism time in hours]) from Absenteeism_at_work$)

--compensation rate increase for non-smokers/ budget 983,221 so 0.68 increase per hour/ 1414 per year increase
select count(*) as non_smokers
from Absenteeism_at_work$ ab
where [Social smoker] = 0

--optimize this query
select ab.ID, rea.reason, [Month of absence], [body mass index],
case when [body mass index] < 18.5 then 'underweight'
     when [body mass index] between 18.5 and 25 then 'Healthy Weight'
	 when [body mass index] between 25 and 30 then 'overweight'
	 when [body mass index] > 30 then 'Obese'
	 else 'Unknown' end as BMI,
case when [Month of absence] in (12,1,2) then 'Winter'
when [Month of absence] in (3,4,5) then 'Spring'
when [Month of absence] in (6,7,8) then 'Summer'
when [Month of absence] in (9,10,11) then 'Fall'
else 'unknown' end as Seaon_Names,
Seasons, [Month of absence], [Day of the week], [Transportation expense], Education, Son, [Social drinker], [Social smoker],
Pet, [Disciplinary failure], Age, [Work load Average/day ], [Absenteeism time in hours]
from Absenteeism_at_work$ ab
left join compensation$ com
on ab.id = com.id
left join reasons$ rea
on ab.[Reason for absence] = rea.number
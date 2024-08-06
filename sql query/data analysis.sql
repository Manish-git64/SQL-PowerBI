use projects;

-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
select gender, count(*) as count
from hr
where age >= 18
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race ,count(*)  as count
from HR
where age>= 18
group by race
order by count desc;

-- 3. What is the age distribution of employees in the company?
select 
  min(age) as youngest,
  max(age) as oldest
from HR
where age>=18;

select floor(age/10)*10 as age_group, COUNT(*) as count
from hr
where age >= 18
group by floor(age/10)*10;

select
  case 
    when age >= 18 and age <= 24 then '18-24'
    when age >= 25 and age <= 34 then '25-34'
    when age >= 35 and age <= 44 then '35-44'
    when age >= 45 and age <= 54 then '45-54'
    when age >= 55 and age <= 64 then '55-64'
    else '65+' 
  end as age_group, 
  count(*) as count
from 
  HR
where 
  age >= 18
group by age_group
order by age_group;

select
  case 
    when age >= 18 and age <= 24 then '18-24'
    when age >= 25 and age <= 34 then '25-34'
    when age >= 35 and age <= 44 then '35-44'
    when age >= 45 and age <= 54 then '45-54'
    when age >= 55 and age <= 64 then '55-64'
    else '65+' 
  end as age_group, gender,
  count(*) as count
from 
  HR
where 
  age >= 18
group by age_group,gender
order by age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?
select location, count(*) as count
from HR
where age>=18
group by location;

-- 5. What is the average length of employment for employees who have been terminated?
select round(avg(datediff(termdate, hire_date)),0)/365 as avg_length_of_employment
from HR
where termdate <= curdate() and age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?
select department, gender, count(*) as count
from HR
where age >= 18
group by department, gender
order by department;


-- 7. What is the distribution of job titles across the company?
select jobtitle, count(*) as count
from HR
where age >= 18
group by jobtitle
order by jobtitle desc;

-- 8. Which department has the highest turnover rate?
select department,
       count(*) as total_count,
       sum(case when termdate is not null and termdate <= CURDATE() then 1 else 0 end) as terminated_count,
       SUM(case when termdate is null then 1 else 0 end) as active_count,
       (sum(case when termdate is not null and termdate <= CURDATE() then 1 else 0 end) / count(*)) as termination_rate
from HR
where age >= 18
group by department
order by termination_rate desc;


-- 9. What is the distribution of employees across locations by city and state?
select location_state, count(*) as count
from HR
where age >= 18
group by location_state
order by count desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?
select 
    year(hire_date) AS year, 
    count(*) as hires, 
    sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminations, 
    count(*) - sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end) as net_change,
    round(((count(*) - sum(case when termdate is not null and termdate <= curdate() then 1 else 0 end)) / count(*) * 100), 2) as net_change_percent
from HR
where age >= 18
group by year(hire_date)
order by year(hire_date) asc;


-- 11. What is the tenure distribution for each department?
SELECT department,
       ROUND(
           AVG(
               CASE 
                   WHEN ISNULL(termdate) OR STR_TO_DATE(termdate, '%Y-%m-%d') IS NULL THEN NULL
                   ELSE DATEDIFF(CURDATE(), STR_TO_DATE(termdate, '%Y-%m-%d')) / 365.0
               END
           ), 0
       ) AS avg_tenure
FROM hr
WHERE age >= 18
  AND STR_TO_DATE(termdate, '%Y-%m-%d') IS NOT NULL
  AND STR_TO_DATE(termdate, '%Y-%m-%d') <= CURDATE()
GROUP BY department
LIMIT 1000;











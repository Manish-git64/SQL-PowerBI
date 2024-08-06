create database projects;

use projects;

select * from HR;

alter table HR
change column ï»¿id emp_id varchar(20) null;

describe HR;

select birthdate from HR;


update HR
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table HR
modify column birthdate date;

update HR
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table HR
modify column hire_date date;

update HR
set termdate = if(termdate is not null and termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
where true;

set sql_mode = 'ALLOW_INVALID_DATES';

alter table HR
modify column termdate date;

select termdate from HR;

alter table HR add column age int;

update HR
set age = timestampdiff(year, birthdate, curdate());


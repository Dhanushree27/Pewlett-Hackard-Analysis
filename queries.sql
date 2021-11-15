-- Query based on birth date
select first_name,last_name
from employees
where birth_date between '1952-01-01' and '1955-12-31';

select first_name,last_name
from employees
where birth_date between '1952-01-01' and '1952-12-31';

select first_name,last_name
from employees
where birth_date between '1953-01-01' and '1953-12-31';

select first_name,last_name
from employees
where birth_date between '1954-01-01' and '1954-12-31';

select first_name,last_name
from employees
where birth_date between '1955-01-01' and '1955-12-31';

-- To query based on date and return the count
select count(emp_no)
from employees
where birth_date between '1952-01-01' and '1955-12-31';

-- Query based on birth date and hire date
select first_name,last_name
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');
-- Query and return the count
select count(emp_no)
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Query and store data in new table for export
select first_name,last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Query and store retirement employee data in new table for export
select emp_no,first_name,last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Join retirement info and dep_emp and store in new table
select ri.emp_no, 
	ri.first_name,
	ri.last_name,
	de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de on ri.emp_no=de.emp_no
where de.to_date = '9999-01-01'

-- Get the count of employees retiring from each department
select count(c.emp_no),
		de.dept_no
into retirement_count_dept
from current_emp as c
left join dept_emp as de
on c.emp_no=de.emp_no
group by de.dept_no
order by de.dept_no

-- Create retiring employee details table with salary
select e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
into emp_info
from employees as e
inner join salaries as s 
on e.emp_no=s.emp_no
inner join dept_emp as de
on e.emp_no=de.emp_no
where (e.birth_date between '1952-01-01' and '1955-12-31')
and (e.hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date = '9999-01-01');

-- List of retiring managers per department
select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
into manager_info
from dept_manager as dm
	inner join departments as d
	on dm.dept_no=d.dept_no
	inner join current_emp as ce
	on dm.emp_no=ce.emp_no;

-- List of departments for retiring employees
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
into dept_info
from current_emp as ce
inner join dept_emp as de
on ce.emp_no=de.emp_no
inner join departments as d
on de.dept_no=d.dept_no

-- Query on multiple conditions
select * from dept_info
where dept_name in ('Sales','Development')
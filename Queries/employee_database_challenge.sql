-- Query to retrieve retirement eligible employees with their titles
SELECT e.emp_no, e.first_name, e.last_name,
        t. title, t.from_date,t.to_date
INTO retirement_title_info
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no=t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_title_info
ORDER BY emp_no ASC, to_date DESC;

-- Count of employees retiring by title
SELECT title,
	count (emp_no)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Query to retrieve eligible members for mentorship program	
SELECT DISTINCT ON(e.emp_no) e.emp_no,e.first_name,e.last_name,e.birth_date,
		de.from_date,de.to_date,
		t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
	ON e.emp_no=de.emp_no
INNER JOIN titles AS t
	ON e.emp_no=t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' and '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC, t.to_date DESC;
# Retirement Impact analysis at Pewlett Hackard

## Overview of the Project
This project was initiated to identify the number of employees who will be retiring soon and the open positions that will have to be filled. To begin the analysis, the employee data available in csv files was to be moved to a database. A ERD diagram was created and the data was successfully stored in a database. 

Queries were then created to retrieve the list of employees retiring from the company. A new mentorship training idea was also proposed to train the next set of senior employees. As part of the final analysis, the below lists were generated:
- The number of employees retiring by title
- The employees eligible for the mentorship program

The data was stored in a PostgreSQL database and pgAdmin was used to interface.

## Results
From the analysis, the below inferences were made:

**Number of Employees retiring by Title**   

- Based on the number of employess retiring by title, it was observed that there are almost 60,000 employees retiring from Senior roles (Senior Engineer and Senior Staff) and 2 from Manager roles, amounting to a total of 57,670 retiring from leadership roles. This is 63.7 % of the total employees retiring.  
- Similar to the senior role (Senior Engineer and Senior Staff), there are a high number of Engineers and Staff retiring as well, which might create a deficit in these roles. The total number of Engineers retiring amounts to 45397, and the total number of Staff retiring amounts to 40497. These are two kinds of roles which would need immediate focus.
 
     ![Retiring Employee Count](https://github.com/Dhanushree27/Pewlett-Hackard-Analysis/blob/main/Images/Retiring_count_by_title.PNG) 

**Mentorship program**

- Based on the list, it can be seen that there are only a total of 1,550 employees who can participate in the program. Taking the count of employees per title into consideration, it can be seen that each mentor would have atleast 50 mentee, which might be difficult to handle. 

     ![Mentee per Mentor](https://github.com/Dhanushree27/Pewlett-Hackard-Analysis/blob/main/Images/Mentee_per_Mentor.PNG)

- Not all employees from the list might be available or qualified for mentoring. Also, there are no managers in the list. The mentor list will need to be expanded. 

## Summary

- There will be a total of 90,398 roles that will need to be filled across 7 designations.
- There are not enough mentors to mentor the upcoming influx of employess. Currently, each mentor would have to mentor atleast 50 employees. The list of mentors needs to be expanded.

In addition to the retiring or mentor qualified employees by title list, it would be helpful if the lists had the department information as well, since this would also provide a better picture on which areas need more focus.

**Employees retiring per Dept, per Title**
```sql
SELECT d.dept_name, u.title,  COUNT(u.emp_no) 
FROM unique_titles as u
INNER JOIN dept_emp as de
ON u.emp_no=de.emp_no
INNER JOIN departments as d
ON de.dept_no=d.dept_no
WHERE de.to_date='9999-01-01'
GROUP BY d.dept_name,u.title
ORDER BY d.dept_name,count desc
```
Running this query, shows that the Developement team has a lot of senior employees retiring followed by Production and Sales. It can also be seen that the manager for Sales and Research departments are retiring

**Mentors available per Dept, per Title**

Running a similar query, we can obtain the mentors available per Dept, per Title

Alternatively, we can join the two queries to compare the possible open positions with the mentors for each role

```sql
SELECT rc.dept_name,rc.title,rc.r_count,mc.m_count
FROM (SELECT d.dept_name, u.title,  COUNT(u.emp_no)as r_count
        FROM unique_titles as u
        INNER JOIN dept_emp as de
        ON u.emp_no=de.emp_no
        INNER JOIN departments as d
        ON de.dept_no=d.dept_no
        WHERE de.to_date='9999-01-01'
        GROUP BY d.dept_name,u.title
        ORDER BY d.dept_name,r_count DESC) AS RC
LEFT OUTER JOIN (SELECT d.dept_name, m.title,  COUNT(m.emp_no) AS m_count
        FROM mentorship_eligibility as m
        INNER JOIN dept_emp as de
        ON m.emp_no=de.emp_no
        INNER JOIN departments as d
        ON de.dept_no=d.dept_no
        GROUP BY d.dept_name,m.title
        ORDER BY d.dept_name) AS MC
ON rc.dept_name=mc.dept_name AND rc.title = mc.title                       
```

From the query, we can see that there are no mentors for a few roles for a few departments. Filtering for that using the where clause, we can obtain the list 

   ![No Mentor](https://github.com/Dhanushree27/Pewlett-Hackard-Analysis/blob/main/Images/No_Mentor.PNG)








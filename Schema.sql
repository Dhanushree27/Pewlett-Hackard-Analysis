-- Creating tables for PH-EmployeeDB

-- Table for departments
CREATE TABLE departments (
			dept_no VARCHAR(4) NOT NULL,
			dept_name VARCHAR(40) NOT NULL,
			PRIMARY KEY(dept_no),
			UNIQUE (dept_name)	
			);
			
-- Table for employees
CREATE TABLE employees (
			emp_no INT NOT NULL,
			birth_date DATE NOT NULL,
			first_name VARCHAR NOT NULL,
			last_name VARCHAR NOT NULL,
			gender VARCHAR NOT NULL,
			hire_date DATE NOT NULL,
			PRIMARY KEY(emp_no)
			);

-- Table for dept managers
CREATE TABLE dept_manager (
			dept_no VARCHAR(4) NOT NULL,
			emp_no INT NOT NULL,
			from_date DATE NOT NULL,
			to_date DATE NOT NULL,
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
			PRIMARY KEY (emp_no, dept_no)
			);
			
-- Table for dept employees
CREATE TABLE dept_emp (
			emp_no INT NOT NULL,
			dept_no VARCHAR(4) NOT NULL,			
			from_date DATE NOT NULL,
			to_date DATE NOT NULL,
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
			PRIMARY KEY (emp_no, dept_no)
			);

-- Table for employee salaries
CREATE TABLE salaries (
			emp_no INT NOT NULL,
			salary INT NOT NULL,			
			from_date DATE NOT NULL,
			to_date DATE NOT NULL,
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			PRIMARY KEY (emp_no)
			);

-- Table for employee titles
CREATE TABLE titles (
			emp_no INT NOT NULL,
			title VARCHAR NOT NULL,			
			from_date DATE NOT NULL,
			to_date DATE NOT NULL,
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			PRIMARY KEY (emp_no,title,from_date)
			);
-- Reestablish/add foreign ket
alter table dept_manager
			add constraint dept_manager_emp_no_fkey FOREIGN KEY (emp_no) REFERENCES employees (emp_no);

-- Add auto generated column
alter table titles
			add column id int not null generated always as identity;
-- Remove existing p key			
alter table titles
			drop constraint titles_pkey;
-- Add new p key
alter table titles
			add constraint titles_pkey primary key(id);
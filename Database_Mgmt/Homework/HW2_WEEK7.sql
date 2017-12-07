-- Question 1 - using root :)
SELECT User, Host, Password 
	FROM mysql.user;

-- Question 2
CREATE DATABASE Baseball;

USE Baseball;

CREATE TABLE Stats 
	(TEAM VARCHAR(50), 
    PLAYER VARCHAR(50), 
    SALARY DECIMAL(20,5), 
    POSITION VARCHAR(20));

LOAD DATA LOCAL INFILE 
'/Users/patrickcorynichols/Desktop/Data Science/Database Mgmt/Homework/baseball_salaries_2003.txt'
	INTO TABLE Stats
	FIELDS TERMINATED BY ':'
	LINES TERMINATED BY '\n'
	IGNORE 3 LINES
	(Team, Player, Salary, Position);

UPDATE STATS
	SET PLAYER = REPLACE(Player,'"','');

SELECT POSITION, CONCAT('$',ROUND(AVG(SALARY),2)) avgSal
	FROM STATS
	GROUP BY POSITION
	ORDER BY AvgSal DESC;
    
    
    
CREATE DATABASE university;
USE university;

CREATE table classroom
	(building varchar(15),
    room_number varchar(7),
    capacity numeric(4,0),
    PRIMARY KEY(building, room_number));
    
CREATE TABLE department
	(dept_name varchar(20),
    building varchar(15),
    budget numeric(12,2) check(budget>0),
    primary key (dept_name));
    
CREATE TABLE course
	(course_id varchar(8),
    title varchar(50),
    dept_name varchar(20),
    credits numeric(2,0) check(credits>0),
    PRIMARY KEY(course_id),
    FOREIGN KEY(dept_name) REFERENCES department(dept_name)
		ON DELETE SET NULL);

CREATE TABLE instructor
	(ID VARCHAR(5),
    name VARCHAR(20) not null,
    dept_name VARCHAR(20),
    salary NUMERIC(8,2) CHECK(salary>29000),
    PRIMARY KEY(ID),
    FOREIGN KEY(dept_name) REFERENCES department(dept_name)
		ON DELETE SET NULL);

CREATE TABLE section
	(course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6) check(semester IN('Fall','Winter','Spring','Summer')),
    year NUMERIC(4,0) check(year > 1701 AND year < 2100),
    building varchar(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY(course_id, sec_id, semester, year),
    FOREIGN KEY(course_id) REFERENCES course(course_id)
		ON DELETE CASCADE,
	FOREIGN KEY(building,room_number) REFERENCES classroom(building,room_number)
		ON DELETE SET NULL);
        
CREATE table teaches
	(ID varchar(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year numeric(4,0),
    PRIMARY KEY(ID, course_id, sec_id, semester, year),
    FOREIGN KEY(course_id, sec_id, semester, year) 
		REFERENCES section(course_id, sec_id, semester, year)
        ON DELETE CASCADE,
	FOREIGN KEY(ID) REFERENCES instructor(ID));
	-- ON DELETE SET NULL); -- this operation is not allowed in mySQL because ID is in the primary key and does NOT accept nulls

CREATE TABLE student
	(ID varchar(5),
    name varchar(20) NOT NULL,
    dept_name varchar(20),
    tot_cred numeric(3,0) check(tot_cred>=0),
    PRIMARY KEY(ID),
    FOREIGN KEY(dept_name) REFERENCES department(dept_name)
		ON DELETE set null);
        
CREATE TABLE takes
	(ID varchar(5),
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year numeric(4,0),
    grade varchar(2),
    PRIMARY KEY(ID, course_id, sec_id, semester, year),
    FOREIGN KEY(course_id, sec_id, semester, year) 
		REFERENCES section(course_id, sec_id, semester, year)
        ON DELETE CASCADE,
	FOREIGN KEY(ID) 
		REFERENCES student(ID)
		ON DELETE CASCADE);
        
CREATE TABLE advisor
	(s_id varchar(5),
    i_id varchar(5),
    PRIMARY KEY(s_id),
    FOREIGN KEY (i_id) REFERENCES instructor(ID)
		ON DELETE SET NULL,
	FOREIGN KEY(s_id) REFERENCES student(ID)
		ON DELETE CASCADE);
        
CREATE TABLE prereq
	(course_id varchar(8),
    prereq_id varchar(8),
    PRIMARY KEY(course_id, prereq_id),
    FOREIGN KEY(course_id) 
		REFERENCES course(course_id)
        ON DELETE CASCADE,
	FOREIGN KEY(prereq_id) 
		REFERENCES course(course_id));
        
CREATE TABLE timeslot
	(time_slot_id varchar(4),
    day varchar(1) check(day in('M','T','W','R','F','S','U')),
    start_time time,
    end_time time,
    PRIMARY KEY (time_slot_id,day,start_time));
  
INSERT INTO department(dept_name, building, budget) VALUES
	('Biology', 'Watson', 90000),
    ('Comp. Sci.', 'Taylor', 100000),
    ('Elec. Eng.', 'Taylor', 85000),
    ('Finance', 'Painter', 120000),
    ('History', 'Painter', 50000),
    ('Music', 'Packard', 80000),
    ('Physics', 'Watson', 70000)
    ;


INSERT INTO student 
	(ID, name, dept_name, tot_cred)
VALUES 
	(00129,'Zhang', 'Comp. Sci.', 102),
	(19991, 'Brandt', 'History',80),
    (12345, 'Shankar','Comp. Sci.', 32),
	(23121, 'Chavez', 'Finance', 110),
	(44553, 'Peltier', 'Physics', 56),
	(45678, 'Levy', 'Physics', 46),
	(54321, 'Williams', 'Comp. Sci.', 54),
	(55739, 'Sanchez', 'Music', 38),
	(70557, 'Snow', 'Physics', 0),
	(76543, 'Brown', 'Comp. Sci.', 58),
	(76653, 'Aoi', 'Elec. Eng.', 60),
	(98765, 'Bourikas', 'Elec. Eng.', 98),
	(98988, 'Tanaka', 'Biology', 120);


INSERT INTO instructor
	(ID, name, dept_name, salary)
VALUES 
	(10101,'Srinivasan', 'Comp. Sci.', 65000),
	(12121, 'Wu', 'Finance',90000),
    (15151, 'Mozart','Music', 40000),
	(22222, 'Einstein', 'Physics', 95000),
	(32343, 'El Said', 'History', 60000),
	(33456, 'Gold', 'Physics', 87000),
	(45565, 'Katz', 'Comp. Sci.', 75000),
	(58583, 'Califieri', 'History', 62000),
	(76543, 'Singh', 'Finance', 80000),
	(76766, 'Crick', 'Biology', 72000),
	(83821, 'Brandt', 'Comp. Sci.', 92000),
	(98345, 'Kim', 'Elec. Eng.', 80000);
    



SELECT * 
FROM Student
ORDER BY Name ASC;

SELECT name, salary
FROM Instructor
WHERE dept_name IN ('Comp. Sci.','Elec. Eng')
ORDER BY salary DESC;



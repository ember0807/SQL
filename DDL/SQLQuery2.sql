USE PD_311_DDL;

CREATE TABLE Teachers
(
	teacer_id INT PRIMARY KEY IDENTITY(1,1),
	first_name VARCHAR(150)	NOT NULL,
	last_name VARCHAR(150)NOT NULL,
	middle_name VARCHAR(150),
	birth_day DATE	NOT NULL,
	works_since DATE	NOT NULL,
	rate MONEY	NOT NULL
)
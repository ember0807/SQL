USE PD_311_DDL;
CREATE TABLE Directions
(
	direction_id SMALLINT PRIMARY KEY,
	direction_name NVARCHAR(150) NOT NULL
);
CREATE TABLE Groups
(
	group_id	INT	PRIMARY KEY,
	group_name	NVARCHAR(16) NOT NULL,
	direction SMALLINT NOT NULL
	CONSTRAINT FK_Groups_Firections FOREIGN KEY REFERENCES Directions(direction_id)
);
CREATE TABLE Stidents
(
	student_id	INT	PRIMARY KEY	IDENTITY(1,1),
	last_name   NVARCHAR(150) NOT NULL,
	first_name  NVARCHAR(150) NOT NULL,
	middle_name NVARCHAR(150),
	birth_day DATE NOT NULL,
	"group"	INT ,
	FOREIGN KEY ("group") REFERENCES Groups("group_id")
);

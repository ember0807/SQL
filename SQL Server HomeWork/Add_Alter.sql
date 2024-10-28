USE PD_311_DDL;
GO

ALTER PROC sp_AddAlternatingDisciplineToScheduale
@group_name				NVARCHAR(50),
@discipline_name		NVARCHAR(256),
@start_date				DATE,
@start_time				TIME,
@teacher_first_name		NVARCHAR(150),
@consatant_day			INT,
@alternate_day			INT
AS
BEGIN
		DECLARE @group			AS	INT			=	(SELECT group_id	FROM Groups WHERE group_name = @group_name);
		DECLARE	@discipline		AS	SMALLINT	=	(SELECT disciplin_id FROM Disciplines WHERE disciplin_name LIKE @discipline_name);
		DECLARE	@date			AS	DATE		=	@start_date;
		DECLARE @teacher		AS	INT			=	(SELECT teacer_id FROM Teachers WHERE last_name = @teacher_first_name);
		DECLARE	@num_of_les		AS	SMALLINT	=	(SELECT	number_of_lesson FROM Disciplines WHERE disciplin_name LIKE @discipline_name);

		DECLARE @lesson_num		AS	SMALLINT	=	0;
		DECLARE @alternate_week	AS	BIT			=	0;
		DECLARE	@ca_interval 	INT		=	ABS(@consatant_day - @alternate_day );
		DECLARE	@prelast_date	AS DATE;
		
		
		PRINT(@group);
		PRINT(@discipline);
		PRINT(@num_of_les);
		PRINT(@date);
		PRINT(@teacher);
		PRINT(@ca_interval);
		
		
		WHILE @lesson_num < @num_of_les
		BEGIN
			PRINT(@lesson_num);
			PRINT(@date);
			PRINT(DATENAME(WEEKDAY,@date));
			PRINT('---------------------------------------------')
			IF(DATEPART(WEEKDAY,@date) = @consatant_day)
			BEGIN
				IF(@consatant_day < @alternate_day)
					BEGIN
						SET	@prelast_date = (SELECT MAX([date])	FROM Schedule WHERE [date] < @date);
						SET @date = DATEADD(DAY ,IIF(DATEPART(WEEKDAY,@prelast_date) = @consatant_day,@ca_interval,7),@date );
					END
					ELSE
					BEGIN
						SET @prelast_date = (SELECT MAX([date]) FROM Schedule WHERE [date] < @date 
						AND DATEPART(WEEKDAY,[date])  = @alternate_day);
						SET @date = DATEADD(DAY ,IIF(DATEDIFF(DAY,@prelast_date,@date) > 7,7 - @ca_interval,7),@date);
					END

					--SET @date = DATEADD(DAY,@ca_interval,@date);
					--SET @alternate_week = 0;
			END
			ELSE
			BEGIN
				SET	@date = DATEADD(DAY,7,@date);
				SET @alternate_week = 1;
			END
				SET @lesson_num = @lesson_num +2;

		END

END

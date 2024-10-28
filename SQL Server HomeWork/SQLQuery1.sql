 --Выбрать все дисциплины, зависящие от Процедурного программирования на C++

USE PD_311_DDL;
GO

--SELECT
--[target]  = DependetDisciplines.target_discipline,
--[Необходимо изучить] = disciplin_name,
--[Необходимо изучить id] = disciplin_id

--FROM Disciplines,DependetDisciplines
--WHERE 
--DependetDisciplines.target_discipline = 1
--AND disciplin_id = dependet_discipline

----2. Для каждого препода вывести возраст и опыт преподавания;

--SELECT
--[FIO] = FORMATMESSAGE('%s %s %s', first_name ,last_name ,middle_name),
--[Возраст] = DATEDIFF(YEAR, Teachers.birth_day, GETDATE()),
--[опыт работы] = CONCAT(
--        CASE 
--            WHEN DATEDIFF(YEAR, Teachers.works_since, GETDATE()) > 0  --когда
--            THEN CONVERT(NVARCHAR, DATEDIFF(YEAR, Teachers.works_since, GETDATE())) + ' лет '  -- затем
--            ELSE '' --иначе
--        END,
--        CASE 
--            WHEN DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12) + ' месяцев ' 
--            ELSE ''
--        END,
--        CASE 
--            WHEN DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30) + ' дней' 
--            ELSE ''
--        END
--    ) 

--FROM Teachers
--ORDER BY works_since DESC

----3. Вывести преподов с опытом преподавания больше десяти лет;


--SELECT
--[FIO] = FORMATMESSAGE('%s %s %s', first_name ,last_name ,middle_name),
--[Возраст] = DATEDIFF(YEAR, Teachers.birth_day, GETDATE()),
--[опыт работы] = CONCAT(
--        CASE 
--            WHEN DATEDIFF(YEAR, Teachers.works_since, GETDATE()) > 0  --когда
--            THEN CONVERT(NVARCHAR, DATEDIFF(YEAR, Teachers.works_since, GETDATE())) + ' лет '  -- затем
--            ELSE '' --иначе
--        END,
--        CASE 
--            WHEN DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12) + ' месяцев ' 
--            ELSE ''
--        END,
--        CASE 
--            WHEN DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30) + ' дней' 
--            ELSE ''
--        END
--    ) 
--FROM Teachers

--WHERE 
--    DATEDIFF(YEAR, Teachers.works_since, GETDATE()) >= 10

----4. Выставить расписание для группы 'PD_321' со 2 октября 2024 на весь курс MS SQL Server.
----   Группа занимается Пн., Ср., Пт. по две пары с 13:30;
--SELECT 
--   [Дата проведения] = DATEADD
--FROM 
--    Schedule
--объявление переменной
DECLARE @group		AS INT =			(SELECT group_id FROM Groups WHERE group_name = 'PD_212');
DECLARE @discipline	AS SMALLINT =		(SELECT disciplin_id FROM Disciplines WHERE disciplin_name LIKE '%MS_SQL%');
DECLARE	@teacher	AS INT =			(SELECT teacer_id FROM Teachers WHERE first_name LIKE N'Покидюк');
DECLARE	@startDate	AS DATE=			'2023-11-27';
DECLARE @date AS DATE = @startDate;
DECLARE @time		AS TIME=			'14:30';
DECLARE @number_of_lessont as SMALLINT =	(SELECT number_of_lesson FROM Disciplines WHERE disciplin_name LIKE '%MS_SQL%')


DECLARE @lesson AS SMALLINT = 0;
WHILE  @lesson < @number_of_lessont
BEGIN
	--PRINT(FORMATMESSAGE(N'%s %s', N'Дата:\t',CAST(@date AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %s', N'День:\t',DATENAME(WEEKDAY,@date)))
	--PRINT(FORMATMESSAGE(N'%s %s', N'Время:\t',CAST(@time AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %i', N'Урок №\t', @lesson))
		INSERT 
		Schedule	([date],[time],[group],discipline,teacher,spent)
		VALUES		(@date,@time,@group,@discipline,@teacher,IIF(@date<GETDATE(),1,0))
		SET @lesson = @lesson + 1;
		IF @lesson < @number_of_lessont
		BEGIN
	--PRINT(FORMATMESSAGE(N'%s %s', N'Дата:\t',CAST(@date AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %s', N'Время:\t',CAST(DATEADD(MINUTE,90,@time) AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %i', N'Урок №\t', @lesson))
		INSERT 
		Schedule	([date],	[time],						[group],	discipline,		teacher,	spent)
		VALUES		(@date,		DATEADD(MINUTE,90,@time),	@group,		@discipline,	@teacher,	IIF(@date < GETDATE(),1,0))
		SET @lesson = @lesson + 1;
	END
	SET @date = DATEADD(DAY,IIF(DATEPART(WEEKDAY,@date)=5,3,2),@date);
	
	PRINT '------------------------------'
	
END
GO

SELECT
		[Дата] =			[date],
		[Время] =			[Time],
		[День] =			DATENAME(WEEKDAY,[date]),
		[Группа] =			group_name,
		[Дисциплина] =		disciplin_name,
		[Преподаватель] =	FORMATMESSAGE(N'%s %s %s',first_name,last_name,middle_name),
		[Статус проведения] = IIF(spent = 1 , N'Проведено',N'Запланировано')

FROM	Schedule,Groups,Disciplines,Teachers
WHERE	[group]		= group_id
AND		discipline	= disciplin_id
AND		teacher		= teacer_id

--PRINT (@group)
--PRINT (@discipline)
--PRINT (@teacher)
--INSERT 
--Schedule	([date],[time],[group],discipline,teacher,[subject],spent)
--VALUES		('2024-10-21','13:30',)

--SELECT * FROM Disciplines;

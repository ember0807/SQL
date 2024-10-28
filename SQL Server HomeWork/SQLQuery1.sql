 --������� ��� ����������, ��������� �� ������������ ���������������� �� C++

USE PD_311_DDL;
GO

--SELECT
--[target]  = DependetDisciplines.target_discipline,
--[���������� �������] = disciplin_name,
--[���������� ������� id] = disciplin_id

--FROM Disciplines,DependetDisciplines
--WHERE 
--DependetDisciplines.target_discipline = 1
--AND disciplin_id = dependet_discipline

----2. ��� ������� ������� ������� ������� � ���� ������������;

--SELECT
--[FIO] = FORMATMESSAGE('%s %s %s', first_name ,last_name ,middle_name),
--[�������] = DATEDIFF(YEAR, Teachers.birth_day, GETDATE()),
--[���� ������] = CONCAT(
--        CASE 
--            WHEN DATEDIFF(YEAR, Teachers.works_since, GETDATE()) > 0  --�����
--            THEN CONVERT(NVARCHAR, DATEDIFF(YEAR, Teachers.works_since, GETDATE())) + ' ��� '  -- �����
--            ELSE '' --�����
--        END,
--        CASE 
--            WHEN DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12) + ' ������� ' 
--            ELSE ''
--        END,
--        CASE 
--            WHEN DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30) + ' ����' 
--            ELSE ''
--        END
--    ) 

--FROM Teachers
--ORDER BY works_since DESC

----3. ������� �������� � ������ ������������ ������ ������ ���;


--SELECT
--[FIO] = FORMATMESSAGE('%s %s %s', first_name ,last_name ,middle_name),
--[�������] = DATEDIFF(YEAR, Teachers.birth_day, GETDATE()),
--[���� ������] = CONCAT(
--        CASE 
--            WHEN DATEDIFF(YEAR, Teachers.works_since, GETDATE()) > 0  --�����
--            THEN CONVERT(NVARCHAR, DATEDIFF(YEAR, Teachers.works_since, GETDATE())) + ' ��� '  -- �����
--            ELSE '' --�����
--        END,
--        CASE 
--            WHEN DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(MONTH, Teachers.works_since, GETDATE()) % 12) + ' ������� ' 
--            ELSE ''
--        END,
--        CASE 
--            WHEN DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30 > 0 
--            THEN CONVERT(NVARCHAR, DATEDIFF(DAY, Teachers.works_since, GETDATE()) % 30) + ' ����' 
--            ELSE ''
--        END
--    ) 
--FROM Teachers

--WHERE 
--    DATEDIFF(YEAR, Teachers.works_since, GETDATE()) >= 10

----4. ��������� ���������� ��� ������ 'PD_321' �� 2 ������� 2024 �� ���� ���� MS SQL Server.
----   ������ ���������� ��., ��., ��. �� ��� ���� � 13:30;
--SELECT 
--   [���� ����������] = DATEADD
--FROM 
--    Schedule
--���������� ����������
DECLARE @group		AS INT =			(SELECT group_id FROM Groups WHERE group_name = 'PD_212');
DECLARE @discipline	AS SMALLINT =		(SELECT disciplin_id FROM Disciplines WHERE disciplin_name LIKE '%MS_SQL%');
DECLARE	@teacher	AS INT =			(SELECT teacer_id FROM Teachers WHERE first_name LIKE N'�������');
DECLARE	@startDate	AS DATE=			'2023-11-27';
DECLARE @date AS DATE = @startDate;
DECLARE @time		AS TIME=			'14:30';
DECLARE @number_of_lessont as SMALLINT =	(SELECT number_of_lesson FROM Disciplines WHERE disciplin_name LIKE '%MS_SQL%')


DECLARE @lesson AS SMALLINT = 0;
WHILE  @lesson < @number_of_lessont
BEGIN
	--PRINT(FORMATMESSAGE(N'%s %s', N'����:\t',CAST(@date AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %s', N'����:\t',DATENAME(WEEKDAY,@date)))
	--PRINT(FORMATMESSAGE(N'%s %s', N'�����:\t',CAST(@time AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %i', N'���� �\t', @lesson))
		INSERT 
		Schedule	([date],[time],[group],discipline,teacher,spent)
		VALUES		(@date,@time,@group,@discipline,@teacher,IIF(@date<GETDATE(),1,0))
		SET @lesson = @lesson + 1;
		IF @lesson < @number_of_lessont
		BEGIN
	--PRINT(FORMATMESSAGE(N'%s %s', N'����:\t',CAST(@date AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %s', N'�����:\t',CAST(DATEADD(MINUTE,90,@time) AS NVARCHAR(50))))
	--PRINT(FORMATMESSAGE(N'%s %i', N'���� �\t', @lesson))
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
		[����] =			[date],
		[�����] =			[Time],
		[����] =			DATENAME(WEEKDAY,[date]),
		[������] =			group_name,
		[����������] =		disciplin_name,
		[�������������] =	FORMATMESSAGE(N'%s %s %s',first_name,last_name,middle_name),
		[������ ����������] = IIF(spent = 1 , N'���������',N'�������������')

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

USE QATSQLPLUS

CREATE VIEW dbo.CourseList AS (
SELECT c.CourseName, c.CourseID, v.VendorName FROM Course AS c
JOIN Vendor AS v
ON v.VendorID = c.VendorID
)
GO
SELECT * FROM dbo.CourseList

-- Exc2
CREATE FUNCTION dbo.BourneCourses()
RETURNS TABLE
AS
RETURN (
SELECT d.DelegateID, SUM(cr.DurationDays) AS DelegateDays, 
		COUNT(*) AS DelegateCourses 
	FROM dbo.Delegate AS d
	INNER JOIN DelegateAttendance AS da
		ON d.DelegateID = da.DelegateID
	INNER JOIN CourseRun AS cr 
		ON cr.CourseRunId = da.CourseRunId
GROUP BY d.delegateID
)
GO

SELECT * FROM dbo.BourneCourses()


-- EXC3
SELECT * FROM Trainer

SELECT CourseRunID, StartDate FROM CourseRun AS cr
JOIN dbo.Trainer AS t
ON cr.TrainerID = t.TrainerID
WHERE TrainerName = 'Jason Bourne'

--Task2 EXC3
SELECT * FROM DelegateAttendance
SELECT * FROM Delegate

SELECT d.DelegateID, d.DelegateName, d.CompanyName FROM Delegate AS d
Join DelegateAttendance AS da 
ON d.DelegateID = da.DelegateID
INNER JOIN(
	SELECT CourseRunID, StartDate FROM CourseRun AS cr
	JOIN dbo.Trainer AS t
	ON cr.TrainerID = t.TrainerID
	WHERE TrainerName = 'Jason Bourne' ) AS jb
	ON da.CourseRunID = jb.CourseRunID

-- EXC4 1)
WITH BourneCourses AS (
SELECT CourseRunID, StartDate 
FROM CourseRun AS cr
	JOIN dbo.Trainer AS t
	ON cr.TrainerID = t.TrainerID
	WHERE TrainerName = 'Jason Bourne'
)
SELECT * FROM BourneCourses

SELECT d.DelegateID, d.DelegateName, d.CompanyName, jb.StartDate FROM dbo.Delegate AS d
INNER JOIN dbo.DelegateAttendance AS da
ON d.DelegateID = da.DelegateID
INNER JOIN dbo.BourneCourses AS jb
ON da.CourseRunID = jb.courseRunID

--exc5
select * into #MicrsoftLocal
from dbo.course 
where VendorID =2

select * into ##MicrosoftGlobal
from dbo.course 
where VendorID =2
GO

SELECT * from #MicrsoftLocal
SELECT * from ##MicrosoftGlobal

SELECT ProductID, SUM(TransferAmount) AS STOCK
FROM DBO.BookTransfers
GROUP BY ProductID

SELECT ProductID, TransferDate, SUM(TransferAmount) OVER (PARTITION BY ProductID ORDER BY TransferDate) AS RUNNINGSTOCK
FROM DBO.BookTransfers

-- tASK1 mODULE 3
SELECT *,
RANK() OVER (ORDER BY NumberDelegates DESC) AS O_RANK,
DENSE_RANK() OVER (ORDER BY NumberDelegates DESC) AS D_RANK,
ROW_NUMBER() OVER (ORDER BY NumberDelegates DESC) AS R_NUMBER,
NTILE(3) OVER (ORDER BY NumberDelegates DESC) AS TILE

FROM DBO.VendorCourseDelegateCount
go

-- task 2











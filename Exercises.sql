USE QATSQLPLUS

SELECT VendorName,PhoneNumber FROM DBO.Vendor
UNION
SELECT TrainerName,PhoneNumber FROM Trainer

SELECT 'Vendor' AS ContactType, contactName FROM DBO.Vendor
UNION
SELECT 'Trainer' AS ContactType, TrainerName FROM Trainer

SELECT * FROM DelegateAttendance as da
JOIN CourseRun as cr
ON da.CourseRunID = cr.CourseRunID
JOIN Course as c
ON c.CourseID = cr.CourseID
where CourseName = 'QATSQLPLUS'

-- Module 4 task 1
SELECT * FROM (
SELECT VendorName, CourseName,StartDate,NumberDelegates FROM dbo.VendorCourseDateDelegateCount ) AS BaseData
PIVOT(
	SUM(NumberDelegates) FOR VendorName IN (QA,Microsoft, Oracle)
) AS Pivoted

SELECT VendorName, CourseName,StartDate,SUM(NumberDelegates) AS TotalDelegates FROM VendorCourseDateDelegateCount
GROUP BY VendorName, CourseName,StartDate
WITH ROLLUP
GO

-- Task 2
SELECT VendorName, CourseName,StartDate,SUM(NumberDelegates) AS TotalDelgates 
FROM VendorCourseDateDelegateCount
GROUP BY GROUPING SETS( (VendorName), (VendorName ,CourseName,StartDate)
)
GO

SELECT VendorName,StartDate, NumberDelegates FROM VendorCourseDateDelegateCount








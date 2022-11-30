EXEC sp_addmessage 50003,16, 'vendor cant be found'
GO

RAISERROR(50003, 16, 1,'Red Hat')
GO

DECLARE @Vendor VARCHAR(100)
SET @Vendor = 'QA'

IF @Vendor IS NULL
	BEGIN
		PRINT 'Vendor must not be NULL'
		RETURN
	END

IF NOT EXISTS (SELECT * FROM dbo.Vendor WHERE VendorName = @Vendor)
	BEGIN
		PRINT 'Vendor ' + @Vendor + ' does not exist'
		RETURN
	END

SELECT *
	FROM dbo.Course AS C
		INNER JOIN dbo.Vendor AS V
			ON C.VendorID = V.VendorID
	WHERE VendorName = @Vendor	
GO

-- Ex 3 Task 2	STARTING POINT

BEGIN TRY
UPDATE dbo.Vendor
SET VendorName = NULL
WHERE VendorID = 1
END TRY

BEGIN CATCH
THROW 60000, 'Error',1
END CATCH
GO
-- Vendor Name cannot be NULL. This will be an issue

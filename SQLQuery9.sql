-- columns do not allow nulls
-- stock amount value needs to be >= 0
-- Insert could succeed and update could fail. 

DECLARE @productID
DECLARE @Amount INT = 20

IF (@Product )
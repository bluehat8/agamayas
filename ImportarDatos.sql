---IMPORTAR DATOS

use AdventureWorks2019


SELECT BulkColumn
 FROM OPENROWSET (BULK 'D:\dataMay-10-2021.json', SINGLE_CLOB) as j;

 SELECT value
 FROM OPENROWSET (BULK 'D:\dataMay-10-2021.json', SINGLE_CLOB) as j
 CROSS APPLY OPENJSON(BulkColumn)

 SET IDENTITY_INSERT Person.ContactType ON

 insert into Person.ContactType (ContactTypeID,[Name],ModifiedDate) SELECT ContactTypeID, [Name] as [Name],ModifiedDate
 FROM OPENROWSET (BULK 'D:\dataMay-10-2021.json', SINGLE_CLOB) as j
 CROSS APPLY OPENJSON(BulkColumn)
 WITH( ContactTypeID int, [Name] nvarchar(50), ModifiedDate datetime) AS Person





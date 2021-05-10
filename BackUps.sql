--------BACKUPS (6PTS)-------
use AdventureWorks2019


--Crea dispositivo de almacenamiento
EXEC sp_addumpdevice 'disk', 'AdventureData',   
'D:\BD2\SQL\BACKUP\AdventureData.bak';  
GO


----C) Rutina que asigna nombres de backups unicos (Ejecucion de 4 backups en el dispositivo creado)

--1) NOMBRE DE BACKUP FULL
DECLARE @BackupName VARCHAR(100)
SET @BackupName = N'AdventureWorks2019 – Full Backup ' + FORMAT(GETDATE(),'yyyyMMdd_hhmmss');


BACKUP DATABASE AdventureWorks2019 TO [AdventureData] WITH NOFORMAT, NOINIT, NAME = @BackupName,
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--2) NOMBRE DE BACKUP DIFERENCIAL
DECLARE @BackupDifName VARCHAR(100)
SET @BackupDifName = N'AdventureWorks2019 – Differential Backup ' + FORMAT(GETDATE(),'yyyyMMdd_hhmmss');


BACKUP DATABASE AdventureWorks2019 TO [AdventureData] WITH DIFFERENTIAL,NOFORMAT, NOINIT, NAME = @BackupDifName,
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


--3) BACKUP FULL 3
DECLARE @BackupName3 VARCHAR(100)
SET @BackupName3 = N'AdventureWorks2019 – Full Backup ' + FORMAT(GETDATE(),'yyyyMMdd_hhmmss');


BACKUP DATABASE AdventureWorks2019 TO [AdventureData] WITH NOFORMAT, NOINIT, NAME = @BackupName3,
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--4) NOMBRE DE BACKUP FULL
DECLARE @BackupName4 VARCHAR(100)
SET @BackupName4 = N'AwExamenBDII';


BACKUP DATABASE AdventureWorks2019 TO [AdventureData] WITH NOFORMAT, NOINIT, NAME = @BackupName4,
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-------d) Rutina que restaura uno de los backups con nombre AwExamenBDII basado en el numero del archivo de backup


RESTORE FILELISTONLY FROM AdventureData
GO
RESTORE HEADERONLY FROM AdventureData
GO

use master
drop database AdventureWorks2019

RESTORE DATABASE AdventureWorks2019
FROM AdventureData
WITH FILE = 4, recovery

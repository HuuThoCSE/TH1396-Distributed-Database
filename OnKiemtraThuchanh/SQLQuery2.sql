-- Tạo file backup
BACKUP DATABASE QLHS
TO DISK = 'D:\HK2_23_24\Backup_file_mau_ver1.bak'
WITH FORMAT, MEDIANAME = 'SQLServerBackup', name = 'Full Backup of QLHS';
GO

-- Phục hồi CSDL 
RESTORE DATABASE QLHS
FROM DISK = 'D:\HK2_23_24\Backup_file_mau_ver1.bak'
WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 5;
GO



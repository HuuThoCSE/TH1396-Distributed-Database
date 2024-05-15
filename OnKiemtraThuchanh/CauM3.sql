﻿-- m1
CREATE DATABASE VLTB
GO

USE VLTB
GO

SELECT DISTINCT [HOCSINH].* INTO [HOCSINH]
FROM [SERVER21022008].[QLHS].[dbo].[HOCSINH]
JOIN [SERVER21022008].[QLHS].[dbo].[HOCSINH_LOP] ON [HOCSINH].MAHS = [HOCSINH_LOP].MAHS
JOIN [SERVER21022008].[QLHS].[dbo].[LOP] ON [HOCSINH_LOP].MALOP = [LOP].MALOP
JOIN [SERVER21022008].[QLHS].[dbo].[TRUONG] ON [LOP].MATRUONG = [TRUONG].MATRUONG
JOIN [SERVER21022008].[QLHS].[dbo].[HUYEN] ON [TRUONG].MAH = [HUYEN].MAH
WHERE [HUYEN].TEN = N'Thành phố Vĩnh Long' OR [HUYEN].TEN = N'Tam Bình'
GO

-- m2
CREATE DATABASE TOBT008
GO

USE TOBT008
GO

SELECT DISTINCT [HOCSINH].* INTO [HOCSINH]
FROM [SERVER21022008].[QLHS].[dbo].[HOCSINH]
JOIN [SERVER21022008].[QLHS].[dbo].[HOCSINH_LOP] ON [HOCSINH].MAHS = [HOCSINH_LOP].MAHS
JOIN [SERVER21022008].[QLHS].[dbo].[LOP] ON [HOCSINH_LOP].MALOP = [LOP].MALOP
JOIN [SERVER21022008].[QLHS].[dbo].[TRUONG] ON [LOP].MATRUONG = [TRUONG].MATRUONG
JOIN [SERVER21022008].[QLHS].[dbo].[HUYEN] ON [TRUONG].MAH = [HUYEN].MAH
WHERE [HUYEN].TEN = N'Trà Ôn' OR [HUYEN].TEN = N'Bình Tân'
GO

-- m3
CREATE DATABASE QLHSRest
GO

USE QLHSRest
GO

SELECT DISTINCT [HOCSINH].* 
FROM [SERVER21022008].[QLHS].[dbo].[HOCSINH]
WHERE MAHS NOT IN (
    SELECT MAHS FROM [VLTB].[dbo].[HOCSINH]
    UNION
    SELECT MAHS FROM [TOBT008].[dbo].[HOCSINH]
)
GO

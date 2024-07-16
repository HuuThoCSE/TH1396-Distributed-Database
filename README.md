# TH1396-Distributed-Database

# Error
## ERROR1: Server tên ảo
### Bước 1: Kiểm tra server name có phải tên server ảo không?
```SQL
select @@SERVERNAME
```

### Bước 2: Nếu là tên ảo thì thực hiện
```SQL
sp_dropserver(‘Tên server ảo’)
sp_addserver(‘Tên server thật’)
```

# Hoàn chỉnh CSDL
## Check 
### Cách 1
```SQL
SELECT MAMH FROM MONHOC

SELECT * FROM CAUHOI WHERE MAMH NOT IN (SELECT MAMH FROM MONHOC)

UPDATE CAUHOI
	SET MAMH = 'DLPT'
	WHERE MAMH = 'CDLPT'

UPDATE CAUHOI
	SET MAMH = 'CSDL'
	WHERE MAMH = 'CSD'

ALTER TABLE CAUHOI
	ADD CONSTRAINT FK_CAUHOI_MONHOC FOREIGN KEY (MAMH)
		REFERENCES MONHOC(MAMH)

SELECT * FROM GIAOVIEN_DANGKY WHERE MAGV NOT IN (SELECT MAGV FROM GIAOVIEN)
```

### Cách 2
```SQL
SELECT MAGV FROM CAUHOI
EXCEPT
SELECT MAGV FROM GIAOVIEN
```

## Tạo ràng buộc
- Bước 1: Tạo liên kết trong giao diện Diagram
- Bước 2: Vào bảng sau đó Design nó, rùi lưu lại

# PROC
```SQL
REATE PROC ThemMH
	@MASV nvarchar(8)
AS
BEGIN 
	DECLARE @NgayThi DATETIME = GETDATE();
	DECLARE @LanThi INT = 1;

	-- Chèn các môn học hiện có cho sinh vien bản điểm
	INSERT INTO BANGDIEM (MASV, MAMH, LAN, NGAYTHI, DIEM, BAITHI)
	SELECT @MASV, MAMH, @LanThi, @NgayThi, NULL, NULL
	FROM MONHOC

END;

EXEC ThemMH '002'
```

# Trigger
```SQL
CREATE TRIGGER CheckWrong
   ON BANGDIEM
   AFTER INSERT, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	UPDATE BANGDIEM
	SET DIEM = CASE
			WHEN inserted.DIEM < 0 THEN 0
			WHEN inserted.DIEM > 10 THEN 10
			ELSE inserted.DIEM
		END,
		LAN = CASE
			WHEN inserted.LAN > 2 THEN 2
			ELSE inserted.LAN
		END
	FROM inserted
	WHERE BANGDIEM.MASV = inserted.MASV AND
			BANGDIEM.MAMH = inserted.MAMH AND
			BANGDIEM.NGAYTHI = inserted.NGAYTHI
END
GO
```

## Thêm, xóa, sửa trên site
```SQL
--Phòng ban
CREATE TRIGGER TRG_PB_INSERT
   ON  PHONGBAN
   AFTER INSERT
AS 
BEGIN
	if @@NESTLEVEL>1
		return
	insert into [LINK_SV2_SV1].QLDA.[dbo].PHONGBAN (MAPB,TENPB,EMail,SDT)
	select * from inserted
END
GO
CREATE TRIGGER TRG_PB_UPDATE
   ON  PHONGBAN
   AFTER UPDATE
AS 
BEGIN
	delete [LINK_SV2_SV1].QLDA.[dbo].PHONGBAN where MAPB in (select MAPB from inserted)
	insert into [LINK_SV2_SV1].QLDA.[dbo].PHONGBAN (MAPB,TENPB,EMail,SDT)
	select * from inserted
END
GO
CREATE TRIGGER TRG_PB_DELETE
   ON  PHONGBAN
   AFTER DELETE
AS 
BEGIN
	if @@NESTLEVEL>1
		return
	delete PHONGBAN where MAPB in (select MAPB from deleted)
	delete [LINK_SV2_SV1].QLDA.[dbo].PHONGBAN where MAPB in (select MAPB from deleted)
END
GO

```

## Kiểm tra xem trigger đang được kích hoạt ở mức lồng nhau nào.
```SQL
IF @@NEXTLEVEL > 1
   return 
```

## Dùng ngắn
```SQL
FROM inserted i
```

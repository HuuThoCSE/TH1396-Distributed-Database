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

# Trigger
```
FROM inserted
```

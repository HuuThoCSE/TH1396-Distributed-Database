----4. Thực hiện phân tán cơ sở dữ liệu:


-- m1: dự án có địa điểm tại 'Vĩnh Long'
-- có kinh phía trên 200000; phân tán đến CSDL QLDuAn2000

create database QLDuAn2000
go
use QLDuAn2000
go
--DUAN
select * into DUAN  from [QLDuAn].[dbo].[DUAN]
		where DIADIEM = N'Vĩnh Long' and KINHPHI > 200000

go
alter table DUAN
	add constraint PK_DUAN primary key(MADA)
go
--PHONGBAN
select  PHONGBAN.* into PHONGBAN from [QLDuAn].[dbo].[PHONGBAN]
go
alter table PHONGBAN
	add constraint PK_PHONGBAN primary key(MAPB)
go
--PHANCONG
select  PHANCONG.* into PHANCONG from [QLDuAn].[dbo].[PHANCONG],DUAN
		where PHANCONG.MADA = DUAN.MADA	
go
alter table PHANCONG
	add constraint PK_PHANCONG primary key(MADA,MANV)
go
--NHANVIEN
select distinct NHANVIEN.* into NHANVIEN from [QLDuAn].[dbo].[NHANVIEN],PHANCONG
	where NHANVIEN.MANV = PHANCONG.MANV
go
alter table NHANVIEN
	add constraint PK_NHANVIEN primary key(MANV)
go
--CHUCVU
select *  into CHUCVU from [QLDuAn].[dbo].[CHUCVU]
go
alter table CHUCVU
	add constraint PK_CHUCVU primary key(MACV)


alter table [dbo].[PHANCONG]
	add constraint FK_PC_DA foreign key(MADA) references DUAN(MADA)
	on delete cascade on update cascade

go
alter table [dbo].[PHANCONG]
	add constraint FK_PC_NV foreign key(MANV) references NHANVIEN(MANV)
	on delete cascade on update cascade
go

alter table [dbo].[NHANVIEN]
	add constraint FK_NV_PB foreign key(MAPB) references PHONGBAN(MAPB)
	on delete cascade on update cascade
go
alter table [dbo].[NHANVIEN]
	add constraint FK_NV_CV foreign key(MACV) references CHUCVU(MACV)
	on delete cascade on update cascade
go

alter table [dbo].[DUAN]
	add constraint FK_DA_PB foreign key(MaPB) references PHONGBAN(MAPB)
	
go
  
----
create database QLDuAnm2
go
use QLDuAnm2
go
--m2: các dự án do phòng Nhân dự 
--thực hiện trước năm 2000 phân tán đến Server 2

--DUAN
SELECT [DUAN].* into DUAN FROM [LINKSV_M2].[QLDuAn].[dbo].[DUAN]
JOIN [LINKSV_M2].[QLDuAn].[dbo].[PHONGBAN]
ON [DUAN].MAPB = [PHONGBAN].MAPB
WHERE
    (([PHONGBAN].TENPB = N'Nhân sự' AND [DUAN].[TGBATDAU] < '2000-01-01')) AND
(([DUAN].DIADIEM = N'Vĩnh Long' AND [DUAN].KINHPHI < 200000) OR [DUAN].DIADIEM <> N'Vĩnh Long')

alter table DUAN
	add constraint PK_DUAN primary key(MADA)
go

--PHONGBAN
select  PHONGBAN.* into PHONGBAN from [LINKSV_M2].[QLDuAn].[dbo].[PHONGBAN]
go
alter table PHONGBAN
	add constraint PK_PHONGBAN primary key(MAPB)
go
--PHANCONG
select  PHANCONG.* into PHANCONG from [LINKSV_M2].[QLDuAn].[dbo].[PHANCONG],DUAN
		where PHANCONG.MADA = DUAN.MADA	
go
alter table PHANCONG
	add constraint PK_PHANCONG primary key(MADA,MANV)
go

--NHANVIEN
select distinct NHANVIEN.* into NHANVIEN from [LINKSV_M2].[QLDuAn].[dbo].[NHANVIEN],PHANCONG
	where NHANVIEN.MANV = PHANCONG.MANV
go
alter table NHANVIEN
	add constraint PK_NHANVIEN primary key(MANV)
go
--CHUCVU
select *  into CHUCVU from [LINKSV_M2].[QLDuAn].[dbo].[CHUCVU]
go
alter table CHUCVU
	add constraint PK_CHUCVU primary key(MACV)
select *  into CHUCVU from [QLDuAn].[dbo].[CHUCVU]
go
alter table CHUCVU
	add constraint PK_CHUCVU primary key(MACV)


alter table [dbo].[PHANCONG]
	add constraint FK_PC_DA foreign key(MADA) references DUAN(MADA)
	on delete cascade on update cascade

go
alter table [dbo].[PHANCONG]
	add constraint FK_PC_NV foreign key(MANV) references NHANVIEN(MANV)
	on delete cascade on update cascade
go

alter table [dbo].[NHANVIEN]
	add constraint FK_NV_PB foreign key(MAPB) references PHONGBAN(MAPB)
	on delete cascade on update cascade
go
alter table [dbo].[NHANVIEN]
	add constraint FK_NV_CV foreign key(MACV) references CHUCVU(MACV)
	on delete cascade on update cascade
go

alter table [dbo].[DUAN]
	add constraint FK_DA_PB foreign key(MaPB) references PHONGBAN(MAPB)
	
go
  
----5. Đồng bộ dữ liệu từ các site lên server
Thêm Table CHUCVU
ALTER TRIGGER [dbo].[TG_CV_INS]
ON [dbo].[CHUCVU]
INSTEAD OF INSERT
AS 
BEGIN
    IF NOT EXISTS (SELECT * FROM CHUCVU WHERE CHUCVU.MACV = (SELECT MACV FROM inserted))
    BEGIN
        INSERT INTO [QLDuAn].[dbo].[CHUCVU] ([MACV], [TENCV], [PHUCAP])
        SELECT [MACV], [TENCV], [PHUCAP] FROM inserted;
    END
END


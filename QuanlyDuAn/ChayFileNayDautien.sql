use QLDA
go

--PHANCONG
alter table [dbo].[PHANCONG]
	drop constraint [PK_PHANCONG]
go
alter table [dbo].[PHANCONG]
	alter column [MADA] varchar(25) not null
go
alter table [dbo].[PHANCONG]
	alter column [MANV] varchar(15) not null
go
alter table [dbo].[PHANCONG]
	add constraint PK_PHANCONG primary key(MADA, MANV)
go
alter table [dbo].[PHANCONG]
	add constraint FK_PC_DA foreign key(MADA) references DUAN(MADA)
	on delete cascade on update cascade

go
alter table [dbo].[PHANCONG]
	add constraint FK_PC_NV foreign key(MANV) references NHANVIEN(MANV)
	on delete cascade on update cascade
go

--NHANVIEN

alter table [dbo].[NHANVIEN]
	add constraint FK_NV_PB foreign key(MAPB) references PHONGBAN(MAPB)
	on delete cascade on update cascade
go
alter table [dbo].[NHANVIEN]
	add constraint FK_NV_CV foreign key(MACV) references CHUCVU(MACV)
	on delete cascade on update cascade
go

--DUAN
alter table [dbo].[DUAN]
	alter column [MaPB] varchar(5) not null
go


alter table [dbo].[DUAN]
	add constraint FK_DA_PB foreign key(MaPB) references PHONGBAN(MAPB)
	
go

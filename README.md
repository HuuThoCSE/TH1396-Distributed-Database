# TH1396-Distributed-Database

# Error
## ERROR1: Server tên ảo
### Bước 1: Kiểm tra server name có phải tên server ảo không?
```
select @@SERVERNAME
```

### Bước 2: Nếu là tên ảo thì thực hiện
```
sp_dropserver(‘Tên server ảo’)
sp_addserver(‘Tên server thật’)
```

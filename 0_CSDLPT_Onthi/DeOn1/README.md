NỘI DUNG KIỂM TRA
1. RESTORE FILE QLVT_BACKUP.BAK vào cơ sở dữ liệu QLVT_<MSSV> trên SERVER2

2. Hoàn chỉnh cơ sở dữ liệu nếu cần thiết.

3. Dùng lệnh: 

3.1. Phân tán cơ sở dữ liệu QLVT_<MSSV>đến cơ sở dữ liệu QLVT1_<MSSV> trên SERVER1 thoả lược đồ phân mảnh m1: Tổng hợp tất cả dữ liệu của chi nhánh có địa chỉ ở Tp Cần Thơ.

3.2. Đồng bộ dữ liệu cho table NHANVIEN từ SERVER1 đến SERVER2

4. Dùng công cụ REPLICATION để thực hiện phân tán dữ liệu còn lại đến cơ sở dữ liệu QLVT2_<MSSV>

Lưu ý:
- Tạo File Word lưu lại quá trình thực hiện các yêu cầu

- Thang điểm: Câu 1 (1 điểm) ; Câu 2 (2 điểm); Câu 3: 4 điểm; Câu 4 (3 điểm)
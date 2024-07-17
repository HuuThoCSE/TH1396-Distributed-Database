CHO SẴN CƠ SỞ DỮ LIỆU QUẢN LÝ KẾT QUẢ THI TRẮC NGHIỆM ĐÃ ĐƯỢC BACKUP
YÊU CẦU:
1. Restore vào cơ sở dữ liệu QLThiTN
2. Hoàn chỉnh các RBTV cho CSDL
3. Viết thủ tục thêm tất cả môn học (MONHOC) hiện có  cho sinh viên @masv vào bảng điểm (BANGDIEM) với lần thi mặc định là 1, điểm thi sẽ được để trống, ngày thi là ngày của hệ thống

4. Viết trigger xử lý quá trình nhập bảng điểm: 
- Nếu người dùng cung cấp diểm bị sai thì để điểm mặc định hoặc 0 hoặc 10
- Nếu người dùng nhập lần thi trên 2 thì sửa lần thi lại là 2

5. Phân mảnh CSDL QLThiTN theo các yêu cầu sau:
5.1. Dùng script thực hiện phân tán và đồng bộ CSDL đến site1 (Server2) thoả lược đồ phân mảnh sau: Tổng hợp các dữ liệu của 'Co so 1' 
5.2. Dùng công cụ Replication thực hiện phân tán dữ liệu còn lại đến site2 (Máy khác: Tuỳ ý) vẫn đảm bảo ĐẦY ĐỦ và ĐỘC LẬP dữ liệu giữa 2 site.
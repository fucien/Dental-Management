INSERT INTO TaiKhoan (TaiKhoan, Pass, Loai)
VALUES ('admin', 'admin', 'AD'),
('nhanvien1', 'nhanvien', 'NV'),
('nhanvien2', 'nhanvien', 'NV'),
('doitac1', 'doitac', 'DT'),
('doitac2', 'doitac', 'DT'),
('taixe1','taixe','TX'),
('taixe2','taixe','TX'),
('khachhang1','khachhang','KH'),
('khachhang2','khachhang','KH');

INSERT INTO DoiTac (TaiKhoan, TenDT, DaiDien, ThanhPho, Quan, DiaChi, SoChiNhanh, LoaiAmThuc, Sdt, Email)
VALUES ('doitac1', N'Bistro du Philips', N'Trương Trần Phúc Tín', N'TP HCM', N'5', N'227 NVC', 3, N'French Cuisine', '0987654321', 'philipstruong194@gmail.com'),
('doitac2', N'PhiCha', N'Philips Trương',N'TP HCM', N'1', N'29/4 An Dương Vương', 3, N'Trà Sữa', '0987654322', 'tintruong@gmail.com');

INSERT INTO HopDong (MaDT, MaSoThue, NguoiDaiDien, NgayBatDau, NgayKetThuc, HD_Status)
VALUES (1, 'ABC123', 'Trương Trần Phúc Tín', '2023-02-01', '2024-02-01', 1),
(2, 'XYZ789', 'Philips Trương', '2023-03-01', '2024-03-01', 1);

INSERT INTO ChiNhanh (MaDT, MaHD, Ten, DiaChi, Sdt)
VALUES (1, 1, 'Chi nhánh chính', '123 Đường ABC', '0425421231'),
 (2, 2, 'An Dương Vương', '123 An Dương Vương', '0932482726'),
 (2, 2, 'Chi nhánh Minh Khai', '234 NTMK', '0122323421');

INSERT INTO SanPham (MaDT, Ten, Description, GIA_SP) VALUES 
(1, 'Coq au Vin', 'Traditional French dish of chicken braised with red wine, mushrooms, and garlic.', 250000),
(1, 'Boeuf Bourguignon', 'Slow-cooked beef stew made with red wine, onions, and bacon.', 300000),
(1, 'Quiche Lorraine', 'Savory tart filled with bacon, cheese, and custard.', 150000),
(1, 'Escargots de Bourgogne', 'Burgundy-style snails served in garlic butter sauce.', 200000),
(1, 'Soupe à l’Oignon', 'Traditional French onion soup with croutons and melted cheese.', 100000),
(2, 'Classic Milk Tea', 'Black tea with milk and boba', 45000),
(2, 'Taro Milk Tea', 'Taro-flavored milk tea with boba', 50000),
(2, 'Matcha Latte', 'Matcha powder with milk and boba', 55000),
(2, 'Thai Tea', 'Thai tea with milk and boba', 45000),
(2, 'Fruit Tea', 'Assorted fruit flavors with boba', 50000);

INSERT INTO ChiNhanh_SanPham (MaSP, MaCN, SoLuong_CS)
VALUES 
(1, 1, 50),
(2, 1, 30),
(3, 1, 40),
(4, 1, 20),
(5, 1, 60),
(6, 2, 100),
(7, 2, 80),
(8, 2, 70),
(9, 3, 120),
(10, 3, 90);

DBCC CHECKIDENT ('KhachHang', RESEED, 0);
DELETE FROM DonHang

INSERT INTO KhachHang (TaiKhoan, HoTen, DiaChi, SDT, Email)
VALUES ('khachhang1', 'Uyên Nguyễn', '226 Pasteur Q1 TPHCM', '0932222862', 'uyen73@gmail.com'),
       ('khachhang2', 'Trí Trần', '22 Lê Duẩn Q1 TPHCM', '0932402232', 'tri1911@gmail.com');

INSERT INTO TaiXe (TaiKhoan, HoTen, CMND, SDT, BienSo, KhuVuc, Email, Bank)
VALUES ('taixe1', 'Triết Nguyễn', '1231231231', '0934315612', '69A-12345', 'Quận 8', 'triet32@gmail.com', 'ACB-295829234'),
	   ('taixe2', 'Bu Nguyễn', '1923454321', '0123456523', '59G-67890', 'Quận 8', 'bu@gmail.com', 'VCB-016633202');

--INSERT INTO DonHang (MaCN, MaKH, MaTX, CachThanhToan, DiaChi, Gia, PhiVanChuyen)
--VALUES (1, 1, NULL, N'Thanh Toán trực tiếp bằng tiền mặt', N'123 Đường số 5', 500000, 50000),
--       (2, 2, NULL, N'Thanh Toán qua thẻ', N'456 An Dương Vương', 200000, 15000),
--       (3, 2, NULL, N'Thanh Toán qua ví điện tử', N'789 Nguyễn Trãi', 1500000, 100000);

--INSERT INTO DonHang_SanPham (MaDH, MaSP, SoLuong_SD, Gia_SD)
--VALUES 
--(1, 7, 5, 100000),
--(1, 2, 1, 300000),
--(2, 3, 5, 40000),
--(2, 4, 3, 100000),
--(3, 5, 2, 50000),
--(3, 6, 1, 80000);
--2 cái này vô khách hàng thêm chứ thêm bằng tay đau đầu
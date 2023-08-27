USE CHUYEN_HANG_ONLINE;
GO

--Procedure dùng để đăng nhập
CREATE PROCEDURE dang_nhap @tai_khoan VARCHAR(20), @mat_khau VARCHAR(50)
AS
BEGIN TRANSACTION
	DECLARE @loai_tk CHAR(2);
	SET @loai_tk = NULL;
	--Lấy ra loại tài khoản
	SET @loai_tk = (SELECT TOP 1 tk.Loai
					FROM TaiKhoan tk
					WHERE tk.TaiKhoan = @tai_khoan AND tk.Pass = @mat_khau AND tk.Lock = 0)
	IF @loai_tk IS NOT NULL
		BEGIN
			--Trả về mã (đối tác/khách hàng/tài xế) tương ứng với loại tài khoản đó
			IF @loai_tk = 'DT'
				BEGIN
					SELECT @loai_tk AS 'loai_tk', dt.MaDT AS 'ma', dt.TenDT as 'name' FROM DoiTac dt WHERE dt.TaiKhoan = @tai_khoan;
					COMMIT TRAN;
					RETURN;
				END
			ELSE IF @loai_tk = 'KH'
				BEGIN
					SELECT @loai_tk AS 'loai_tk', kh.MaKH AS 'ma', kh.HoTen as 'name' FROM KhachHang kh WHERE kh.TaiKhoan = @tai_khoan;
					COMMIT TRAN;
					RETURN;
				END
			ELSE IF @loai_tk = 'TX'
				BEGIN
					SELECT @loai_tk AS 'loai_tk', tx.MaTX AS 'ma', tx.HoTen as 'name' FROM TaiXe tx WHERE tx.TaiKhoan = @tai_khoan;
					COMMIT TRAN;
					RETURN
				END
		END
COMMIT TRANSACTION
GO

--Procedure gia hạn hợp đồng
CREATE PROCEDURE gia_han_hop_dong_ERROR @ma_hd INT, @so_ngay_them INT, @delay DATETIME
AS
BEGIN TRANSACTION
	DECLARE @ngay_hien_tai DATE;
	--Chọn ngày cuối hợp đồng
	SET @ngay_hien_tai = (SELECT TOP 1 NgayKetThuc FROM HopDong WHERE MaHD = @ma_hd);
	IF @ngay_hien_tai IS NOT NULL
	BEGIN
			
		WAITFOR DELAY @delay;

		--Tăng ngày cuối hợp đồng
		SET @ngay_hien_tai = (SELECT DATEADD(DAY, @so_ngay_them, @ngay_hien_tai));
		--Update lại ngày cuối của hợp đồng
		UPDATE HopDong
		SET NgayKetThuc = @ngay_hien_tai
		WHERE MaHD = @ma_hd;
	END
	COMMIT TRANSACTION;
GO

--Procedure gia hạn hợp đồng
CREATE PROCEDURE gia_han_hop_dong @ma_hd INT, @so_ngay_them INT, 
									@delay DATETIME
AS
BEGIN TRANSACTION
	DECLARE @ngay_hien_tai DATE;
	--Chọn ngày cuối hợp đồng
	SET @ngay_hien_tai = (SELECT TOP 1 NgayKetThuc 
							FROM HopDong WITH (UPDLOCK) 
							WHERE MaHD = @ma_hd);
	IF @ngay_hien_tai IS NOT NULL
	BEGIN
			
		WAITFOR DELAY @delay;

		--Tăng ngày cuối hợp đồng
		SET @ngay_hien_tai = (SELECT DATEADD(DAY, @so_ngay_them, @ngay_hien_tai));
		--Update lại ngày cuối của hợp đồng
		UPDATE HopDong
		SET NgayKetThuc = @ngay_hien_tai
		WHERE MaHD = @ma_hd;
	END
	COMMIT TRANSACTION;
GO

--Procedure cập nhật sản phẩm
CREATE PROCEDURE cap_nhat_san_pham @ma_sp INT, @ten_sp NVARCHAR(20), @mo_ta NVARCHAR(30), @gia INT, @delay DATETIME
AS
BEGIN TRANSACTION
	--Nếu tên sản phẩm, mô tả không trống, giá không bị âm -> cập nhật giá trị mới
	--Nếu không thì giữ những giá trị cũ lại
	IF (@ten_sp = '')
		BEGIN
			SET @ten_sp = (SELECT Ten FROM SanPham WHERE MaSP = @ma_sp);
		END
	IF (@mo_ta = '')
		BEGIN
			SET @mo_ta = (SELECT Description FROM SanPham WHERE MaSP = @ma_sp);
		END
	IF (@gia < 0)
		BEGIN
			SET @gia = (SELECT GIA_SP FROM SanPham WHERE MaSP = @ma_sp);
		END
	UPDATE SanPham
	SET Ten = @ten_sp,
		Description = @mo_ta,
		GIA_SP = @gia
	WHERE MaSP = @ma_sp
COMMIT TRANSACTION
GO

--Procedure tài xế tiếp nhận đơn hàng
CREATE PROCEDURE tiep_nhan_dh_ERROR @ma_tx INT, @ma_dh INT, 
									@delay DATETIME
AS
BEGIN TRANSACTION
	--Nếu đơn hàng đã có tài xế khác tiếp nhận
	IF NOT EXISTS (SELECT * 
				FROM DonHang
				WHERE MaDH = @ma_dh AND MaTX IS NULL 
						AND Status = N'Đang xử lý')
	BEGIN	
		PRINT N'Nhận đơn hàng thất bại'
		ROLLBACK TRANSACTION;
		RETURN;
	END

	--Delay để gây ra lỗi
	WAITFOR DELAY @delay;

	UPDATE DonHang
	SET MaTX = @ma_tx, Status = N'Đang giao'
	WHERE MaDH = @ma_dh;

	PRINT N'Nhận đơn hàng thành công'
COMMIT TRANSACTION
GO

--Procedure tài xế tiếp nhận đơn hàng
CREATE PROCEDURE tiep_nhan_dh @ma_tx INT, @ma_dh INT, 
									@delay DATETIME
AS
BEGIN TRANSACTION
	--Nếu đơn hàng đã có tài xế khác tiếp nhận
	IF NOT EXISTS (SELECT *
				FROM DonHang WITH (UPDLOCK)
				WHERE MaDH = @ma_dh AND MaTX IS NULL 
						AND Status = N'Đang xử lý')
	BEGIN	
		PRINT N'Nhận đơn hàng thất bại'
		ROLLBACK TRANSACTION;
		RETURN;
	END

	--Delay để gây ra lỗi
	WAITFOR DELAY @delay;

	UPDATE DonHang
	SET MaTX = @ma_tx, Status = N'Đang giao'
	WHERE MaDH = @ma_dh;

	PRINT N'Nhận đơn hàng thành công'
COMMIT TRANSACTION
GO

--Procedure tăng, giảm số lượng sản phẩm đang có
CREATE PROCEDURE cap_nhat_so_luong_cnsp_ERROR @ma_sp INT, @ma_cn INT, 
												@chenh_lech INT, 
												@delay DATETIME
AS
BEGIN TRANSACTION
	BEGIN TRY
		--Lấy số lượng sản phảm hiện tại
		DECLARE @so_luong_hien_tai INT;
		SET @so_luong_hien_tai = (SELECT TOP 1 SoLuong_CS 
								FROM ChiNhanh_SanPham 
								WHERE MaSP = @ma_sp AND MaCN = @ma_cn);

		WAITFOR DELAY @delay;

		--Thêm vào bảng chi nhánh sản phẩm nếu chưa tồn tại
		IF @so_luong_hien_tai IS NULL
			BEGIN
				INSERT INTO ChiNhanh_SanPham(MaCN, MaSP, SoLuong_CS)
				VALUES (@ma_sp, @ma_cn, @chenh_lech);
			END

		--Cập nhật lại số lượng nếu đã tồn tại
		ELSE
			BEGIN
				--Tính số lượng mới
				SET @so_luong_hien_tai = @so_luong_hien_tai + @chenh_lech;
				--Cập nhật lại số lượng
				UPDATE ChiNhanh_SanPham
				SET SoLuong_CS = @so_luong_hien_tai
				WHERE MaCN = @ma_cn AND MaSP = @ma_sp;
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RETURN;
	END CATCH
COMMIT TRANSACTION
GO

--Procedure tăng, giảm số lượng sản phẩm đang có
CREATE PROCEDURE cap_nhat_so_luong_cnsp @ma_sp INT, @ma_cn INT, 
												@chenh_lech INT, 
												@delay DATETIME
AS
BEGIN TRANSACTION
	BEGIN TRY
		--Lấy số lượng sản phảm hiện tại
		DECLARE @so_luong_hien_tai INT;
		SET @so_luong_hien_tai = (SELECT TOP 1 SoLuong_CS 
								FROM ChiNhanh_SanPham WITH (UPDLOCK)
								WHERE MaSP = @ma_sp AND MaCN = @ma_cn);

		WAITFOR DELAY @delay;

		--Thêm vào bảng chi nhánh sản phẩm nếu chưa tồn tại
		IF @so_luong_hien_tai IS NULL
			BEGIN
				INSERT INTO ChiNhanh_SanPham(MaCN, MaSP, SoLuong_CS)
				VALUES (@ma_sp, @ma_cn, @chenh_lech);
			END

		--Cập nhật lại số lượng nếu đã tồn tại
		ELSE
			BEGIN
				--Tính số lượng mới
				SET @so_luong_hien_tai = @so_luong_hien_tai + @chenh_lech;
				--Cập nhật lại số lượng
				UPDATE ChiNhanh_SanPham
				SET SoLuong_CS = @so_luong_hien_tai
				WHERE MaCN = @ma_cn AND MaSP = @ma_sp;
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RETURN;
	END CATCH
COMMIT TRANSACTION
GO

CREATE TYPE SAN_PHAM_SO_LUONG AS TABLE
(
	MaSP CHAR(8),
	SO_LUONG INT
);
GO

--Procedure tạo đơn hàng
CREATE PROCEDURE tao_don_dat_hang_ERROR @ma_cn INT, @ma_kh INT, @hinh_thuc_tt NVARCHAR(30),
									@dia_chi_gh NVARCHAR(30),  @phi_vc INT, @delay DATETIME, 
									@san_pham_so_luong SAN_PHAM_SO_LUONG READONLY
AS
BEGIN TRANSACTION

	BEGIN TRY
		
		DECLARE @phi_sp INT, @ma_dh INT;
		--Tính tổng giá sản phẩm của đơn hàng
		SET @phi_sp = (SELECT SUM(spsl.SO_LUONG * sp.GIA_SP)
						FROM SanPham sp JOIN @san_pham_so_luong spsl
								ON sp.MaSP = spsl.MaSP)

		--Tạo đơn hàng
		INSERT INTO DonHang(MaCN, MaTX, MaKH, CachThanhToan, DiaChi, Gia, PhiVanChuyen)
		VALUES (@ma_cn, NULL, @ma_kh, @hinh_thuc_tt, @dia_chi_gh, @phi_sp, @phi_vc);

		WAITFOR DELAY @delay;

		--Lấy mã đơn hàng vừa tạo
		SET @ma_dh = (SELECT TOP 1 MaDH FROM DonHang ORDER BY MaDH DESC);


		--Tạo chi tiết đơn hàng
		INSERT INTO DonHang_SanPham(MaDH, MaSP, SoLuong_SD, Gia_SD)
		SELECT @ma_dh, spsl.MaSP, spsl.SO_LUONG, SP.GIA_SP
		FROM @san_pham_so_luong spsl JOIN SanPham SP
			ON SP.MaSP = spsl.MaSP;


		--Trừ sản phẩm trong chi nhánh sản phẩm
		UPDATE ChiNhanh_SanPham
		SET SoLuong_CS = SoLuong_CS - (SELECT TOP 1 spsl.SO_LUONG 
												FROM @san_pham_so_luong spsl 
												WHERE spsl.MaSP = MaSP)
		WHERE MaCN = @ma_cn AND MaSP IN (SELECT MaSP FROM @san_pham_so_luong)
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RETURN;
	END CATCH
COMMIT TRANSACTION
GO

--Procedure tạo đơn hàng
CREATE PROCEDURE tao_don_dat_hang @ma_cn INT, @ma_kh INT, @hinh_thuc_tt NVARCHAR(30),
									@dia_chi_gh NVARCHAR(30),  @phi_vc INT, @delay DATETIME, 
									@san_pham_so_luong SAN_PHAM_SO_LUONG READONLY
AS
BEGIN TRANSACTION

	BEGIN TRY
		
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

		DECLARE @phi_sp INT, @ma_dh INT;
		--Tính tổng giá sản phẩm của đơn hàng
		SET @phi_sp = (SELECT SUM(spsl.SO_LUONG * sp.GIA_SP)
						FROM SanPham sp JOIN @san_pham_so_luong spsl
								ON sp.MaSP = spsl.MaSP)

		--Đọc để đặt khóa shared lock
		SELECT * FROM DonHang;

		--Tạo đơn hàng
		INSERT INTO DonHang(MaCN, MaTX, MaKH, CachThanhToan, DiaChi, Gia, PhiVanChuyen)
		VALUES (@ma_cn, NULL, @ma_kh, @hinh_thuc_tt, @dia_chi_gh, @phi_sp, @phi_vc);

		WAITFOR DELAY @delay;

		--Lấy mã đơn hàng vừa tạo
		SET @ma_dh = (SELECT TOP 1 MaDH FROM DonHang ORDER BY MaDH DESC);


		--Tạo chi tiết đơn hàng
		INSERT INTO DonHang_SanPham(MaDH, MaSP, SoLuong_SD, Gia_SD)
		SELECT @ma_dh, spsl.MaSP, spsl.SO_LUONG, SP.GIA_SP
		FROM @san_pham_so_luong spsl JOIN SanPham SP
			ON SP.MaSP = spsl.MaSP;


		--Trừ sản phẩm trong chi nhánh sản phẩm
		UPDATE ChiNhanh_SanPham
		SET SoLuong_CS = SoLuong_CS - (SELECT TOP 1 spsl.SO_LUONG 
												FROM @san_pham_so_luong spsl 
												WHERE spsl.MaSP = MaSP)
		WHERE MaCN = @ma_cn AND MaSP IN (SELECT MaSP FROM @san_pham_so_luong)
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RETURN;
	END CATCH
COMMIT TRANSACTION
GO

--Procedure cho khách hàng hủy đơn đặt hàng
CREATE PROC huy_don_dat_hang_ERROR @ma_dh INT, @delay DATETIME
AS
BEGIN TRANSACTION
	BEGIN TRY
	--Chỉ có thể hủy khi đơn hàng đang trong trạng thái Đang xử lý
	IF EXISTS (SELECT * 
				FROM DonHang
				WHERE MaDH = @ma_dh AND Status = N'Đang xử lý')
		BEGIN

			WAITFOR DELAY @delay;

			UPDATE DonHang
			SET Status = N'Đã hủy'
			WHERE MaDH = @ma_dh;

			--Cộng lại sản phẩm trong chi nhánh sản phẩm
			UPDATE ChiNhanh_SanPham
			SET SoLuong_CS = SoLuong_CS + (SELECT TOP 1 dhsp.SoLuong_SD
												FROM DonHang_SanPham dhsp
												WHERE dhsp.MaSP = MaSP 
													AND dhsp.MaDH = MaDH)
			WHERE MaCN = (SELECT TOP 1 dh.MaCN 
							FROM DonHang dh
							WHERE dh.MaDH = @ma_dh)
				AND MaSP IN (SELECT dhsp.MaSP 
								FROM DonHang_SanPham dhsp
								WHERE dhsp.MaDH = @ma_dh);

			PRINT N'Hủy đơn hàng thành công';
			COMMIT TRANSACTION;
			RETURN;
		END
		PRINT N'Hủy đơn hàng thất bại';
		ROLLBACK TRANSACTION;
		RETURN;
	END TRY
	BEGIN CATCH
		PRINT N'Hủy đơn hàng thất bại';
		ROLLBACK TRANSACTION;
		RETURN;
	END CATCH
GO

--Procedure cho khách hàng hủy đơn đặt hàng
CREATE PROC huy_don_dat_hang @ma_dh INT, @delay DATETIME
AS
BEGIN TRANSACTION
	BEGIN TRY
	--Chỉ có thể hủy khi đơn hàng đang trong trạng thái Đang xử lý
	IF EXISTS (SELECT * 
				FROM DonHang WITH (UPDLOCK)
				WHERE MaDH = @ma_dh AND Status = N'Đang xử lý')
		BEGIN

			WAITFOR DELAY @delay;

			UPDATE DonHang
			SET Status = N'Đã hủy'
			WHERE MaDH = @ma_dh;

			--Cộng lại sản phẩm trong chi nhánh sản phẩm
			UPDATE ChiNhanh_SanPham
			SET SoLuong_CS = SoLuong_CS + (SELECT TOP 1 dhsp.SoLuong_SD
												FROM DonHang_SanPham dhsp
												WHERE dhsp.MaSP = MaSP 
													AND dhsp.MaDH = MaDH)
			WHERE MaCN = (SELECT TOP 1 dh.MaCN 
							FROM DonHang dh
							WHERE dh.MaDH = @ma_dh)
				AND MaSP IN (SELECT dhsp.MaSP 
								FROM DonHang_SanPham dhsp
								WHERE dhsp.MaDH = @ma_dh);

			PRINT N'Hủy đơn hàng thành công';
			COMMIT TRANSACTION;
			RETURN;
		END
		PRINT N'Hủy đơn hàng thất bại';
		ROLLBACK TRANSACTION;
		RETURN;
	END TRY
	BEGIN CATCH
		PRINT N'Hủy đơn hàng thất bại';
		ROLLBACK TRANSACTION;
		RETURN;
	END CATCH
GO

--Store procedure để đối tác thống kê đơn hàng
CREATE PROC doi_tac_thong_ke_ERROR @ma_dt INT, 
									@delay DATETIME
AS
BEGIN TRANSACTION

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT 'total', COUNT(dh.MaDH) AS N'Tổng hóa đơn', 
					SUM(dh.Gia) AS N'Tổng giá sản phẩm hóa đơn', 
					SUM(dh.PhiVanChuyen) AS N'Tổng phí vận chuyển'
	FROM DonHang dh
		JOIN ChiNhanh cn ON dh.MaCN = cn.MaCN
	WHERE cn.MaDT = @ma_dt;

	SELECT 'shipping', COUNT(dh.MaDH) AS N'Tổng hóa đơn', 
						SUM(dh.Gia) AS N'Tổng giá sản phẩm hóa đơn', 
						SUM(dh.PhiVanChuyen) AS N'Tổng phí vận chuyển'
	FROM DonHang dh
		JOIN ChiNhanh cn ON dh.MaCN = cn.MaCN
	WHERE cn.MaDT = @ma_dt AND dh.Status = N'Đang giao';

	WAITFOR DELAY @delay;

	SELECT 'done', COUNT(dh.MaDH) AS N'Tổng hóa đơn', 
					SUM(dh.Gia) AS N'Tổng giá sản phẩm hóa đơn', 
					SUM(dh.PhiVanChuyen) AS N'Tổng phí vận chuyển'
	FROM DonHang dh
		JOIN ChiNhanh cn ON dh.MaCN = cn.MaCN
	WHERE cn.MaDT = @ma_dt AND dh.Status = N'Thành công';

	SELECT 'product', sp.MaSP, sp.Ten, 
			SUM(dhsp.SoLuong_SD) AS N'Số lượng đã bán'
	FROM DonHang_SanPham dhsp
		JOIN SanPham sp ON dhsp.MaSP = sp.MaSP
		JOIN DonHang dh ON dhsp.MaDH = dh.MaDH
		JOIN ChiNhanh_SanPham cnsp ON cnsp.MaCN = dh.MaCN
		JOIN ChiNhanh cn ON cn.MaCN = cnsp.MaCN
	WHERE cn.MaDT = @ma_dt
	GROUP BY sp.MaSP, sp.Ten
	HAVING SUM(dhsp.SoLuong_SD) >= ALL (SELECT SUM(dhsp.SoLuong_SD)
											FROM DonHang_SanPham dhsp
												JOIN DonHang dh ON dhsp.MaDH = dh.MaDH
												JOIN ChiNhanh_SanPham cnsp ON cnsp.MaCN = dh.MaCN
												JOIN ChiNhanh cn ON cn.MaCN = cnsp.MaCN
											WHERE cn.MaDT = @ma_dt
											GROUP BY dhsp.MaSP);
COMMIT TRANSACTION;
GO

--Store procedure để đối tác thống kê đơn hàng
CREATE PROC doi_tac_thong_ke @ma_dt INT, 
									@delay DATETIME
AS
BEGIN TRANSACTION
	
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

	SELECT 'total', COUNT(dh.MaDH) AS N'Tổng hóa đơn', 
					SUM(dh.Gia) AS N'Tổng giá sản phẩm hóa đơn', 
					SUM(dh.PhiVanChuyen) AS N'Tổng phí vận chuyển'
	FROM DonHang dh
		JOIN ChiNhanh cn ON dh.MaCN = cn.MaCN
	WHERE cn.MaDT = @ma_dt;

	SELECT 'shipping', COUNT(dh.MaDH) AS N'Tổng hóa đơn', 
						SUM(dh.Gia) AS N'Tổng giá sản phẩm hóa đơn', 
						SUM(dh.PhiVanChuyen) AS N'Tổng phí vận chuyển'
	FROM DonHang dh
		JOIN ChiNhanh cn ON dh.MaCN = cn.MaCN
	WHERE cn.MaDT = @ma_dt AND dh.Status = N'Đang giao';

	WAITFOR DELAY @delay;

	SELECT 'done', COUNT(dh.MaDH) AS N'Tổng hóa đơn', 
					SUM(dh.Gia) AS N'Tổng giá sản phẩm hóa đơn', 
					SUM(dh.PhiVanChuyen) AS N'Tổng phí vận chuyển'
	FROM DonHang dh
		JOIN ChiNhanh cn ON dh.MaCN = cn.MaCN
	WHERE cn.MaDT = @ma_dt AND dh.Status = N'Thành công';

	SELECT 'product', sp.MaSP, sp.Ten, 
			SUM(dhsp.SoLuong_SD) AS N'Số lượng đã bán'
	FROM DonHang_SanPham dhsp
		JOIN SanPham sp ON dhsp.MaSP = sp.MaSP
		JOIN DonHang dh ON dhsp.MaDH = dh.MaDH
		JOIN ChiNhanh_SanPham cnsp ON cnsp.MaCN = dh.MaCN
		JOIN ChiNhanh cn ON cn.MaCN = cnsp.MaCN
	WHERE cn.MaDT = @ma_dt
	GROUP BY sp.MaSP, sp.Ten
	HAVING SUM(dhsp.SoLuong_SD) >= ALL (SELECT SUM(dhsp.SoLuong_SD)
											FROM DonHang_SanPham dhsp
												JOIN DonHang dh ON dhsp.MaDH = dh.MaDH
												JOIN ChiNhanh_SanPham cnsp ON cnsp.MaCN = dh.MaCN
												JOIN ChiNhanh cn ON cn.MaCN = cnsp.MaCN
											WHERE cn.MaDT = @ma_dt
											GROUP BY dhsp.MaSP);
COMMIT TRANSACTION;
GO


--Store procedure để khách hàng thống kê đơn hàng
CREATE PROC khach_hang_thong_ke_ERROR @ma_kh INT, @delay DATETIME
AS
BEGIN TRANSACTION
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT 'total', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaKH = @ma_kh;

	SELECT 'shipping', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaKH = @ma_kh AND dh.Status = N'Đang giao';

	WAITFOR DELAY @delay;

	SELECT 'done', COUNT(dh.MaDH) , SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaKH = @ma_kh AND dh.Status = N'Thành công';
COMMIT TRANSACTION;
GO


--Store procedure để khách hàng thống kê đơn hàng
CREATE PROC khach_hang_thong_ke @ma_kh INT, @delay DATETIME
AS
BEGIN TRANSACTION
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

	SELECT 'total', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaKH = @ma_kh;

	SELECT 'shipping', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaKH = @ma_kh AND dh.Status = N'Đang giao';

	WAITFOR DELAY @delay;

	SELECT 'done', COUNT(dh.MaDH) , SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaKH = @ma_kh AND dh.Status = N'Thành công';
COMMIT TRANSACTION;
GO

--Store procedure để tài xế thống kê đơn hàng
CREATE PROC tai_xe_thong_ke_ERROR @ma_tx INT, @delay DATETIME
AS
BEGIN TRANSACTION
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT 'total', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaTX = @ma_tx;

	SELECT 'shipping', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaTX = @ma_tx AND dh.Status = N'Đang giao';

	WAITFOR DELAY @delay;

	SELECT 'done', COUNT(dh.MaDH) , SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaTX = @ma_tx AND dh.Status = N'Thành công';
COMMIT TRANSACTION;
GO

--Store procedure để tài xế thống kê đơn hàng
CREATE PROC tai_xe_thong_ke @ma_tx INT, @delay DATETIME
AS
BEGIN TRANSACTION
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

	SELECT 'total', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaTX = @ma_tx;

	SELECT 'shipping', COUNT(dh.MaDH), SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaTX = @ma_tx AND dh.Status = N'Đang giao';

	WAITFOR DELAY @delay;

	SELECT 'done', COUNT(dh.MaDH) , SUM(dh.Gia), SUM(dh.PhiVanChuyen)
	FROM DonHang dh
	WHERE dh.MaTX = @ma_tx AND dh.Status = N'Thành công';
COMMIT TRANSACTION;
GO
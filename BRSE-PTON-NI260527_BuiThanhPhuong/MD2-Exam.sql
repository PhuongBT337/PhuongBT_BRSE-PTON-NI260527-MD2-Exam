
----------------- Phần 1 ------------------------
-------- THAO TÁC VỚI DỮ LIỆU CÁC BẢNG ----------

CREATE DATABASE quanly_phongkham;

USE quanly_phongkham;

-- Tạo bảng bệnh nhân
CREATE TABLE BenhNhan(
	benhnhan_id VARCHAR(10) PRIMARY KEY NOT NULL,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    so_dien_thoai VARCHAR(15) NOT NULL,
    dia_chi  VARCHAR(200)
);

SELECT * FROM BenhNhan;

-- Tạo bảng dịch 
CREATE TABLE DichVu(
	dichvu_id VARCHAR(10) PRIMARY KEY,
    ten_dich_vu VARCHAR(150) NOT NULL UNIQUE,
    gia_dich_vu DECIMAL(12,2) NOT NULL,
    trang_thai VARCHAR(50) NOT NULL DEFAULT "Hoạt động",
    thoi_gian_uoc_tinh INT NOT NULL,
    CHECK(gia_dich_vu > 0)
);

SELECT * FROM DichVu;

-- Tạo bảng Phiếu Khám 
CREATE TABLE PhieuKham(
	phieukham_id INT PRIMARY  KEY AUTO_INCREMENT,
    benhnhan_id VARCHAR(10) NOT NULL,
    dichvu_id VARCHAR(10) NOT NULL,
    ngay_kham DATE NOT NULL,
    ngay_tai_kham DATE,
    tong_tien DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY(benhnhan_id) REFERENCES BenhNhan(benhnhan_id),
    FOREIGN KEY(dichvu_id) REFERENCES DichVu(dichvu_id)
); 

SELECT * FROM PhieuKham;

-- Tạo bảng Hóa đơn
CREATE TABLE HoaDon(
	hoadon_id INT PRIMARY KEY AUTO_INCREMENT,
    phieukham_id INT NOT NULL,
    phuong_thuc_tt VARCHAR(50) NOT NULL,
    ngay_tt DATE NOT NULL,
    so_tien_tt DECIMAL(12,2) NOT NULL,
    CHECK(so_tien_tt > 0),
    FOREIGN KEY(phieukham_id) REFERENCES PhieuKham(phieukham_id)
);

SELECT * FROM HoaDon;

-- Chèn dữ liệu vào bảng theo mẫu
-- bảng BenhNhan
INSERT INTO BenhNhan(benhnhan_id, ho_ten, email, so_dien_thoai, dia_chi) 
VALUES
("BN001", "Nguyen Anh Tu", "tu.nguyen@example.com", "0912345678", "Hanoi, Vietnam"),
("BN002", "Tran Thi Mai", "mai.tran@example.com", "0923456789", "Ho Chi Minh, Vietnam"),
("BN003", "Le Minh Hoang", "hoang.le@example.com", "0934567890", "Danang, Vietnam"),
("BN004", "Pham Hoang Nam", "nam.pham@example.com", "0945678901", "Hue, Vietnam"),
("BN005", "Vu Minh Thu", "thu.vu@example.com", "0956789012", "Hai Phong, Vietnam"),
("BN006", "Nguyen Thi Lan", "lan.nguyen@example.com", "0967890123", "Quang Ninh, Vietnam"),
("BN007", "Bui Minh Tuan", "tuan.bui@example.com", "0978901234", "Bac Giang, Vietnam"),
("BN008", "Pham Quang Hieu", "hieu.pham@example.com", "0989012345", "Quang Nam, Vietnam");

DELETE FROM BenhNhan
WHERE benhnhan_id IN (
    'BN01', 'BN02', 'BN03', 'BN04',
    'BN05', 'BN06', 'BN07', 'BN08'
);
SELECT * FROM BenhNhan;

-- bảng DichVu
INSERT INTO DichVu(dichvu_id, ten_dich_vu, gia_dich_vu, trang_thai, thoi_gian_uoc_tinh)
VALUES
("DV001", "Khám tổng quát", 200.0, "Hoạt động", 30),
("DV002", "Chụp X-Quang", 150.0, "Tạm ngưng", 15),
("DV003", "Xét nghiệm máu", 300.0, "Hoạt động", 20),
("DV004", "Siêu âm 4D", 400.0, "Hoạt động", 45),
("DV005", " Khám chuyên khoa", 250.0, "Hoạt động", 30),
("DV006", "Nội soi da dày", 500.0, "Hoạt động", 60),
("DV007", "Khám mắt", 150.0, "Hoạt động", 20),
("DV008", "Khám tai mũi họng", 200.0, "Tạm ngưng", 25);


SELECT * FROM DichVu;

-- bảng PhieuKham
-- phieukham_id đã set là AUTO_INCREMENT nên giá trị id tự tăng nên không cần nhập
INSERT INTO PhieuKham(benhnhan_id, dichvu_id, ngay_kham, ngay_tai_kham, tong_tien)
VALUES 
("BN001", "DV001", "2026-09-01", "2026-09-10", 200.0),
("BN002", "DV002", "2026-09-02", "2026-09-11", 150.0),
("BN003", "DV003", "2026-09-03", "2026-09-12", 300.0),
("BN004", "DV004", "2026-09-04", "2026-09-13", 400.0),
("BN005", "DV005", "2026-09-05", "2026-09-14", 250.0),
("BN006", "DV006", "2026-09-06", "2026-09-15", 500.0),
("BN007", "DV007", "2026-09-07", "2026-09-16", 150.0),
("BN008", "DV008", "2026-09-08", "2026-09-17", 200.0);

SELECT * FROM PhieuKham;

-- vì id bắt đầu từ 9 nên xóa và sửa 
DELETE FROM PhieuKham
WHERE phieukham_id >= 1;

ALTER TABLE PhieuKham AUTO_INCREMENT = 1;
SELECT * FROM PhieuKham;

-- bảng HoaDon
INSERT INTO HoaDon(phieukham_id, phuong_thuc_tt, ngay_tt, so_tien_tt)
VALUES
(1, "Cash", "2026-09-01", 200.0),
(2, "Credit Card", "2026-09-02", 150.0),
(3, "Bank Transfer", "2026-09-03", 300.0),
(4, "Cash", "2026-09-04", 400.0),
(5, "Credit Card", "2026-09-05", 250.0),
(6, "Bank Transfer", "2026-09-06", 500.0),
(7, "Cash", "2026-09-07", 150.0),
(8, "Credit Card", "2026-09-08", 200.0);

SELECT * FROM HoaDon;

-- Cập nhật(Update) lại tổng liền trong bảng PhieuKham
UPDATE PhieuKham PK JOIN DichVu DV ON PK.dichvu_id = DV.dichvu_id
SET PK.tong_tien = DV.gia_dich_vu + 50.0
WHERE DV.trang_thai = "Hoạt động" AND PK.ngay_kham < CURDATE();

SELECT * FROM PhieuKham;

-- Xóa dữ liệu trong bảng HoaDon
DELETE FROM HoaDon WHERE phuong_thuc_tt = "Cash" AND so_tien_tt < 200.0;
-- vì chế độ safe update mode nên không xóa được nên
SET SQL_SAFE_UPDATES = 0;
DELETE FROM HoaDon WHERE phuong_thuc_tt = "Cash" AND so_tien_tt < 200.0;
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM HoaDon; -- hóa đơn thanh toán bằng Cash và dưới 200 đã được xóa

----------------- Phần 2 ------------------------
----------- TRUY VẪN DỮ LIỆU --------------------

-- Lấy thông tin bệnh nhân rồi xếp họ tên bệnh nhân tăng dần từ A - Z 
SELECT benhnhan_id, ho_ten, email, so_dien_thoai, dia_chi 
FROM BenhNhan
ORDER BY ho_ten ASC;
 
 -- Lấy thông tin dịch vụ rồi xếp theo giá dịch vụ giảm dần
 SELECT dichvu_id, ten_dich_vu, gia_dich_vu, thoi_gian_uoc_tinh
 FROM DichVu
 ORDER BY gia_dich_vu DESC;
 
 -- Lấy thông tin bệnh nhân và dịch vụ đã đăng kí
 SELECT BN.benhnhan_id, BN.ho_ten, PK.dichvu_id,PK.ngay_kham, PK.ngay_tai_kham
 FROM BenhNhan BN
 JOIN PhieuKham PK ON BN.benhnhan_id = PK.benhnhan_id;

-- Lấy ds bệnh nhân và tổng tiền đã thanh toán rồi xếp 
-- theo số tiền thanh toán giảm dần
SELECT BN.benhnhan_id, BN.ho_ten, HD.phuong_thuc_tt, HD.so_tien_tt
FROM BenhNhan BN
JOIN PhieuKham PK ON BN.benhnhan_id = PK.benhnhan_id
JOIN HoaDon HD ON PK.phieukham_id = HD.phieukham_id
ORDER BY HD.so_tien_tt DESC;

-- Lấy thông tin bệnh nhân từ vị trí 2 đến 4 và xếp theo tên bệnh nhân
SELECT * FROM BenhNhan
ORDER BY ho_ten ASC -- xếp từ A - Z
LIMIT 3 OFFSET 1; -- ( bỏ qua 1 lấy từ 2 đến 4)

-- lấy ds bệnh nhân đã đăng kí ít nhất 2 PK và có thanh toán > 500 
SELECT BN.benhnhan_id, BN.ho_ten, COUNT(PK.phieukham_id) AS so_luong_phieu_kham
FROM BenhNhan BN
JOIN PhieuKham PK ON BN.benhnhan_id = PK.benhnhan_id
JOIN HoaDon HD ON PK.phieukham_id = HD.phieukham_id
GROUP BY BN.benhnhan_id, BN.ho_ten
HAVING COUNT(PK.phieukham_id) >= 2 AND SUM(HD.so_tien_tt) > 500.0;
-- vì hiện tại bệnh nhân nào cũng chỉ có 1 phiếu khám nên kết quả là không có ai

-- Lấy ds có sum thanh toán dưới 1000  và ít nhất 3 BN đăng kí
SELECT DV.dichvu_id, DV.ten_dich_vu, SUM(HD.so_tien_tt) AS tong_thanh_toans
FROM DichVu DV
JOIN PhieuKham PK ON DV.dichvu_id = PK.dichvu_id
JOIN HoaDon HD ON PK.phieukham_id = HD.phieukham_id
GROUP BY DV.dichvu_id, DV.ten_dich_vu, DV.gia_dich_vu
HAVING SUM(HD.so_tien_tt) < 1000.0 
	AND COUNT(DISTINCT PK.benhnhan_id) >= 3; -- ít nhất 3 người đăng kí
-- kết quả không có ai vì từ dữ liệu mẫu mỗi dịch vụ chỉ 1 người đăng kí
 
 
 -- lấy ds BN có tổng thanh toán > 500
 SELECT BN.benhnhan_id, BN.ho_ten, PK.dichvu_id, 
	SUM(HD.so_tien_tt) AS tong_thanh_toan
FROM BenhNhan BN
JOIN PhieuKham PK ON BN.benhnhan_id = PK.benhnhan_id
JOIN HoaDon HD ON PK.phieukham_id = HD.phieukham_id
GROUP BY BN.benhnhan_id, BN.ho_ten, PK.dichvu_id
HAVING SUM(HD.so_tien_tt) > 500.0;
-- kết quả không có ai vì từ dữ liệu mẫu MAXSUM thanh toán chỉ 500


----------------- Phần 3 ------------------------
----------- TẠO VIEW  --------------------
-- tạo view lấy thông tin dv và bn đã đăng kí
CREATE VIEW view_dichvu_benhnhan AS
SELECT DV.dichvu_id, DV.ten_dich_vu, BN.benhnhan_id, BN.ho_ten
FROM DichVu DV
JOIN PhieuKham PK ON DV.dichvu_id = PK.dichvu_id
JOIN BenhNhan BN ON PK.benhnhan_id = BN.benhnhan_id
WHERE PK.ngay_kham < "2026-09-08"; -- lấy ngày khám trước ngày này

SELECT * FROM view_dichvu_benhnhan;

-- tạo view lấy info bn và phiếu khám  đã đăng kí (giá dv > 200)
CREATE VIEW view_benhnhan_phieukham AS
SELECT BN.benhnhan_id, BN.ho_ten, DV.dichvu_id, DV.gia_dich_vu
FROM BenhNhan BN
JOIN PhieuKham PK ON BN.benhnhan_id = PK.benhnhan_id
JOIN DichVu DV ON PK.dichvu_id = DV.dichvu_id
WHERE DV.gia_dich_vu > 200.0;

SELECT * FROM view_benhnhan_phieukham;

----------------- Phần 4 ------------------------
----------- TẠO TRIGGER  --------------------

-- tạo trigger để kiểm tra dữ liệu mỗi khi chèn vào bảng
DELIMITER //
CREATE TRIGGER check_insert_phieukham
BEFORE INSERT ON PhieuKham
FOR EACH ROW
BEGIN
	IF NEW.ngay_tai_kham < NEW.ngay_kham THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Ngày tái khám không thể trước ngày khám bệnh được!";
	END IF;
END //
DELIMITER ;

-- ------------ Phần 5 ------------------------
-- ----------- TẠO STORE PROCEDURE  --------------------

-- viết store thêm mới bệnh nhân
 DELIMITER //
CREATE PROCEDURE add_benhnhan(
    IN p_benhnhan_id VARCHAR(10),
    IN p_ho_ten VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_so_dien_thoai VARCHAR(15),
    IN p_dia_chi VARCHAR(200))
BEGIN
    INSERT INTO BenhNhan(benhnhan_id, ho_ten, email, so_dien_thoai, dia_chi)
    VALUES(p_benhnhan_id, p_ho_ten, p_email, p_so_dien_thoai, p_dia_chi);
END //;

DELIMITER ;

-- test

CALL add_benhnhan(
    'BN009',
    'Bui Thanh Phuong',
    'phuong.bui@example.com',
    '0901234567',
    'Osaka, Japan'
);

SELECT * FROM BenhNhan;
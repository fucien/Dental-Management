-- Tạo bảng HOCSINH
CREATE TABLE HOCSINH (
    mahs INT PRIMARY KEY,
    hoten VARCHAR(50),
    gioitinh VARCHAR(10),
    ngaysinh DATE,
    diachi VARCHAR(100),
    malop INT,
    FOREIGN KEY (malop) REFERENCES LOPHOC(malop)
);

-- Tạo bảng LOPHOC
CREATE TABLE LOPHOC (
    malop INT PRIMARY KEY,
    tenlop VARCHAR(50),
    nam INT,
    gvcn INT,
    lop_tr INT,
    FOREIGN KEY (gvcn) REFERENCES GIAOVIEN(magv),
    FOREIGN KEY (lop_tr) REFERENCES HOCSINH(mahs)
);

-- Tạo bảng GIAOVIEN
CREATE TABLE GIAOVIEN (
    magv INT PRIMARY KEY,
    hoten VARCHAR(50),
    ngaysinh DATE,
    diachi VARCHAR(100)
);
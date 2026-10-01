create database baithicuoikydatabase;
use baithicuoikydatabase;

-- PHAN 1: TAO BANG & CHEN DU LIEU--
-- TAO BANG --

CREATE TABLE BenhNhan (
    benhnhan_id VARCHAR(10) PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    so_dien_thoai VARCHAR(15) NOT NULL,
    dia_chi VARCHAR(200)
);

create table DichVu(
	dichvu_id varchar(10) primary key ,
	ten_dich_vu varchar(150) not null unique,
	gia_dich_vu decimal(12,2) not null check(gia_dich_vu>0),
	trang_thai varchar(50) not null default 'Hoạt động',
	thoi_gian_uoc_tinh int not null
);

create table PhieuKham(
	phieukham_id int primary key auto_increment,
	benhnhan_id varchar(10) not null,
	constraint fk_phieukham_benhnhan
	foreign key (benhnhan_id) references BenhNhan(benhnhan_id),
	dichvu_id varchar(10) not null,
	constraint fk_phieukham_dichvu
	foreign key (dichvu_id) references DichVu(dichvu_id),
	ngay_kham date not null,
	ngay_tai_kham date not null,
	tong_tien decimal(12,2) default 0
);

create table HoaDon (
	hoadon_id int primary key auto_increment,
	phieukham_id int not null,
	constraint pk_hoadon_phieukham
	foreign key (phieukham_id) references PhieuKham(phieukham_id),
	phuong_thuc_tt varchar(50) not null,
	ngay_tt date not null,
	so_tien_tt decimal(12,2) not null check (so_tien_tt>0)
);

-- CHEN DU LIEU --

insert into BenhNhan (benhnhan_id, ho_ten, email, so_dien_thoai, dia_chi)
values 
('BN001','Nguyen Anh Tu', 'tu.nguyen@example.com','0912345678','Hanoi,Vietnam'),
('BN002','Tran Thi Mai', 'mai.tran@example.com','0923456789','Ho Chi Minh,Vietnam'),
('BN003','Le Minh Hoang', 'hoang.len@example.com','0934567890','Danang,Vietnam'),
('BN004','Pham Hoang Nam', 'nam.phamn@example.com','0945678901','Hue,Vietnam'),
('BN005','Vu Minh Thu', 'thu.vu@example.com','09456789012','Hai Phong,Vietnam'),
('BN006','Nguyen Thi Lan', 'lan.nguyen@example.com','0956780123','Quang Ninh,Vietnam'),
('BN007','Bui Minh Tuan', 'tuan.bui@example.com','09678901234','Bac Giang,Vietnam'),
('BN008','Pham Quang Hieu', 'hieu.pham@example.com','0978012345','Quang Nam,Vietnam');

insert into DichVu (dichvu_id, ten_dich_vu, gia_dich_vu, trang_thai, thoi_gian_uoc_tinh)
values
('DV001','Khám tổng quát','200.0','Hoạt động','30'),
('DV002','Chụp X-Quang','150.0','Tạm ngưng','15'),
('DV003','Xét nghiệm máu','300.0','Hoạt động','20'),
('DV004','Siêu âm 4D','400.0','Hoạt động','45'),
('DV005','Khám chuyên khoa','250.0','Hoạt động','30'),
('DV006','Nội soi dạ dày','500.0','Hoạt động','60'),
('DV007','Khám mắt','150.0','Hoạt động','20'),
('DV008','Khám tai mũi họng','200.0','Tạm ngưng','25');

insert into PhieuKham (phieukham_id, benhnhan_id, dichvu_id, ngay_kham, ngay_tai_kham, tong_tien)
values 
('1','BN001','DV001','2026-09-01','2026-09-10','200.0'),
('2','BN002','DV002','2026-09-02','2026-09-11','150.0'),
('3','BN003','DV003','2026-09-03','2026-09-12','300.0'),
('4','BN004','DV004','2026-09-04','2026-09-13','400.0'),
('5','BN005','DV005','2026-09-05','2026-09-14','250.0'),
('6','BN006','DV006','2026-09-06','2026-09-15','500.0'),
('7','BN007','DV007','2026-09-07','2026-09-16','150.0'),
('8','BN008','DV008','2026-09-08','2026-09-17','200.0');

insert into HoaDon (hoadon_id, phieukham_id, phuong_thuc_tt, ngay_tt, so_tien_tt)
values
('1','1','Cash','2026-09-01','200.0'),
('2','2','Credit Card','2026-09-02','150.0'),
('3','3','Bank Transfer','2026-09-03','300.0'),
('4','4','Cash','2026-09-04','400.0'),
('5','5','Credit Card','2026-09-05','250.0'),
('6','6','Bank Transfer','2026-09-06','500.0'),
('7','7','Cash','2026-09-07','150.0'),
('8','8','Credit Card','2026-09-08','200.0');

-- CAP NHAT DU LIEU: VIET CAU LENH UPDATE DE tong_tien trong bang PhieuKham = gia_dich_vu + 50.0 --
update PhieuKham pk 
join DichVu dv on pk.dichvu_id = dv.dichvu_id
set pk.tong_tien = dv.gia_dich_vu + 50.0
where dv.trang_thai = 'Hoạt động'
and pk.ngay_kham < curdate();
select * from phieukham;

-- VIET CAU LENH DELETE DE XOA THANH TOAN TRONG BANG HoaDon NEU phuong_thuc_tt la CASH va so_tien_tt <200.0 --
delete from HoaDon where phuong_thuc_tt = 'Cash' and so_tien_tt<200.0;
select * from HoaDon;

-- PHAN 2: TRUY VAN DU LIEU --

-- LAY THONG TIN BENH NHAN --
select benhnhan_id,ho_ten,email,so_dien_thoai,dia_chi from BenhNhan
order by ho_ten asc;

-- LAY THONG TIN DICH VU--
select dichvu_id,ten_dich_vu,gia_dich_vu,thoi_gian_uoc_tinh from DichVu
order by gia_dich_vu desc;

-- LAY THONG TIN BENH NHAN VA DICH VU DA DANG KY--
select bn.benhnhan_id,bn.ho_ten,pk.dichvu_id,pk.ngay_kham,pk.ngay_tai_kham
from BenhNhan bn 
join PhieuKham pk on bn.benhnhan_id = pk.benhnhan_id;

-- LAY DANH SACH BENH NHAN VA TONG TIEN DA THANH TOAN KHI KHAM BENH
select bn.benhnhan_id,bn.ho_ten,hd.phuong_thuc_tt,hd.so_tien_tt 
from BenhNhan bn
join PhieuKham pk on bn.benhnhan_id = pk.benhnhan_id
join HoaDon hd on pk.phieukham_id = hd.phieukham_id
order by hd.so_tien_tt desc;

-- LAY THONG TIN BENH NHAN TU VI TRI THU 2 DEN THU 4 TRONG BANG BenhNhan DUOC SAP XEP THEO TEN BENH NHAN
select * from BenhNhan 
order by ho_ten asc
limit 3 offset 1;

-- them du lieu de test--
insert into PhieuKham(phieukham_id,benhnhan_id,dichvu_id,ngay_kham,ngay_tai_kham,tong_tien)
values 
('9','BN001','DV004','2026-09-01','2026-09-10','400.0'),
('10','BN002','DV004','2026-09-01','2026-09-10','400.0'),
('11','BN003','DV002','2026-09-01','2026-09-10','150.0'),
('12','BN004','DV002','2026-09-01','2026-09-10','150.0');
select * from phieukham;

-- LAY DANH SACH BENH NHAN DANG KY IT NHAT 2 PHIEU KHAM VA CO TONG TIEN THANH TOAN >500.0
select bn.benhnhan_id,bn.ho_ten,count(distinct pk.phieukham_id) as tong_so_phieu_kham,SUM(pk.tong_tien) as Tong_tien_thanh_toan
from BenhNhan bn
join PhieuKham pk on bn.benhnhan_id = pk.benhnhan_id
group by bn.benhnhan_id,bn.ho_ten
having Count(distinct pk.phieukham_id)>=2
and    SUM(pk.tong_tien)>500.0;

-- LAY DANH SACH DICH VU CO TONG TIEN THANH TOAN <1000.0 VA CO IT NHAT 3 BENH NHAN DANG KY
select dv.dichvu_id,dv.ten_dich_vu,dv.gia_dich_vu,SUM(pk.tong_tien) as tong_tien_thanh_toan
from DichVu dv 
join PhieuKham pk on dv.dichvu_id = pk.dichvu_id
group by dv.dichvu_id,dv.ten_dich_vu,dv.gia_dich_vu
having COUNT(distinct pk.benhnhan_id)>=3
and    SUM(pk.tong_tien)<1000.0;

-- THEM DU LIEU DE TEST
insert into HoaDon(hoadon_id,phieukham_id,phuong_thuc_tt,ngay_tt,so_tien_tt)
values
('9','9','Cash','2026-09-01','400.0'),
('10','10','Cash','2026-09-01','400.0'),
('11','11','Cash','2026-09-01','150.0'),
('12','12','Cash','2026-09-01','150.0');
select * from PhieuKham;

-- LAY DANH SACH BENH NHAN CO SO TIEN THANH TOAN > 500.0, GOM MA BENH NHAN, HO TEN BENH NHAN, MA DICH VU, TONG SO TIEN THANH TOAN
select bn.benhnhan_id, bn.ho_ten, pk.dichvu_id,pk.tong_tien
from BenhNhan bn
join PhieuKham pk on bn.benhnhan_id = pk.benhnhan_id
where pk.tong_tien > 500.0;

-- LAY DANH SACH BENH NHAN CO HO TEN CHUA CHU "MINH" HOAC DIA CHI O "Hanoi", SAP XEP KET QUA THEO HO TEN TANG DAN --
select benhnhan_id,ho_ten,email,so_dien_thoai from BenhNhan
where ho_ten like '%Minh%' or dia_chi like '%Hanoi%';
-- cai nay dung de test lai xem dia chi co dung ko--
select * from BenhNhan 
where ho_ten like '%Minh%' or dia_chi like '%Hanoi%';

-- LAY DANH SACH TAT CA DICH VU SAP XEP THEO GIA DICH VU GIAM DAN, HIEN THI 3 DICH VU SAU 2 DICH VU DAU TIEN
select dichvu_id,ten_dich_vu,gia_dich_vu from DichVu
order by gia_dich_vu desc
limit 3 offset 2;

-- PHAN 3: TAO VIEW -- 
-- TAO VIEW LAY THONG TIN MA DICH VU, TEN DICH VU,MA BENH NHAN, HO TEN BENH NHAN VOI DIEU KIEN NGAY KHAM NHO HON 2026-09-08

create view View_BenhNhan_DichVu as
select dv.dichvu_id,dv.ten_dich_vu,bn.benhnhan_id,bn.ho_ten
from BenhNhan bn 
join PhieuKham pk on bn.benhnhan_id = pk.benhnhan_id
join DichVu dv on dv.dichvu_id = pk.dichvu_id
where pk.ngay_kham < '2026-09-08';
select * from View_BenhNhan_DichVu;

-- TAO VIEW LAY MA BENH NHAN, HO TEN BENH NHAN, MA DICH VU, GIA DICH VU VOI DIEU KIEN DICH VU CO GIA >200.0
create view View_BenhNhan_PhieuKham as
select bn.benhnhan_id,bn.ho_ten,dv.dichvu_id,dv.gia_dich_vu
from BenhNhan bn 
join PhieuKham pk on bn.benhnhan_id = pk.benhnhan_id
join DichVu dv on dv.dichvu_id = pk.dichvu_id
where dv.gia_dich_vu >200.0;
select * from View_BenhNhan_PhieuKham;

-- PHAN 5: TAO PROCEDURE --
-- VIET PROCEDURE CO TEN add_benhnhan DE THEM MOI BENH NHAN
DELIMITER //
create procedure add_benhnhan(
IN p_benhnhan_id Varchar (10),
IN p_ho_ten varchar(100),
IN p_email varchar(100),
IN p_so_dien_thoai varchar(15),
IN p_dia_chi varchar(200)
)
begin
insert into BenhNhan(benhnhan_id,ho_ten,email,so_dien_thoai,dia_chi)
values(p_benhnhan_id,p_ho_ten,p_email,p_so_dien_thoai,p_dia_chi);
END //
DELIMITER ;

call add_benhnhan('BN009','thuprocedure','testne@test.com','0909123456','Hanoi,Vietnam');
select * from BenhNhan

-- TAO STORED PROCEDURE CO TEN add_hoadon DE THUC HIEN VIEC THEM MOI MOT THANH TOAN --

DELIMITER //
create procedure add_hoadon(
IN p_phieukham_id INT,
IN p_phuong_thuc_tt varchar(50),
IN p_ngay_tt date,
IN p_so_tien_tt decimal(12,2)
)
begin
insert into HOADON(phieukham_id,phuong_thuc_tt,ngay_tt,so_tien_tt)
values (p_phieukham_id,p_phuong_thuc_tt,p_ngay_tt,p_so_tien_tt);
END //
DELIMITER ;

call add_hoadon('9','test','2026-11-11','900.0');
select * from Hoadon;
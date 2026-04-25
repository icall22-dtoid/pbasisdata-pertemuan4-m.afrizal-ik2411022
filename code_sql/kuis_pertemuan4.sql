DELIMITER //

CREATE PROCEDURE cek_predikat_mahasiswa(IN p_nilai INT)
BEGIN
    DECLARE v_predikat VARCHAR(50);
    DECLARE v_status VARCHAR(20);

    -- Menentukan Predikat berdasarkan rentang nilai [cite: 319]
    IF p_nilai >= 90 THEN 
        SET v_predikat = 'Sangat Memuaskan';
    ELSEIF p_nilai >= 80 THEN 
        SET v_predikat = 'Memuaskan';
    ELSEIF p_nilai >= 70 THEN 
        SET v_predikat = 'Baik';
    ELSEIF p_nilai >= 60 THEN 
        SET v_predikat = 'Cukup';
    ELSE 
        SET v_predikat = 'Kurang';
    END IF;

    -- Menentukan Status Kelulusan [cite: 320]
    IF p_nilai >= 70 THEN 
        SET v_status = 'Lulus';
    ELSE 
        SET v_status = 'Tidak Lulus';
    END IF;

    -- Menampilkan Output [cite: 322]
    SELECT 
        p_nilai AS 'Nilai', 
        v_predikat AS 'Predikat', 
        v_status AS 'Status';
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE cek_status_stok(IN p_stok INT)
BEGIN
    DECLARE v_status VARCHAR(50);

    -- Logika penentuan status stok [cite: 311]
    IF p_stok = 0 THEN 
        SET v_status = 'Habis';
    ELSEIF p_stok <= 5 THEN 
        SET v_status = 'Hampir Habis';
    ELSEIF p_stok <= 20 THEN 
        SET v_status = 'Tersedia';
    ELSE 
        SET v_status = 'Stok Aman';
    END IF;

    SELECT v_status AS 'Status';
END //

DELIMITER ;
-- Membuat tabel produk [cite: 315]
CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100),
    stok INT
);

-- Mengisi data contoh [cite: 316]
INSERT INTO produk (nama_produk, stok) VALUES
('Laptop Asus', 10),
('Mouse Logi', 3),
('Keyboard Mech', 0),
('Monitor Dell', 25),
('Printer HP', 15);

-- Menampilkan status menggunakan CASE Expression [cite: 121, 316]
SELECT 
    nama_produk, 
    stok,
    CASE 
        WHEN stok = 0 THEN 'Habis'
        WHEN stok <= 5 THEN 'Hampir Habis'
        WHEN stok <= 20 THEN 'Tersedia'
        ELSE 'Stok Aman'
    END AS status_stok
FROM produk;
DELIMITER //

CREATE PROCEDURE hitung_diskon(IN p_total_belanja DECIMAL(12,2))
BEGIN
    DECLARE v_persen_diskon INT;
    DECLARE v_jumlah_diskon DECIMAL(12,2);
    DECLARE v_total_bayar DECIMAL(12,2);

    -- Penentuan persentase diskon 
    IF p_total_belanja >= 1000000 THEN SET v_persen_diskon = 15;
    ELSEIF p_total_belanja >= 500000 THEN SET v_persen_diskon = 10;
    ELSEIF p_total_belanja >= 250000 THEN SET v_persen_diskon = 5;
    ELSE SET v_persen_diskon = 0;
    END IF;

    -- Perhitungan nilai uang 
    SET v_jumlah_diskon = p_total_belanja * (v_persen_diskon / 100);
    SET v_total_bayar = p_total_belanja - v_jumlah_diskon;

    -- Output hasil perhitungan 
    SELECT 
        p_total_belanja AS 'Total Belanja',
        CONCAT(v_persen_diskon, '%') AS 'Persentase Diskon',
        v_jumlah_diskon AS 'Jumlah Diskon',
        v_total_bayar AS 'Total Bayar';
END //

DELIMITER ;
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2024 at 08:18 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_tamu_reservasi` ()   BEGIN 
     SELECT t.id_tamu, t.nama, t.tanggal_lahir, t.alamat, t.no_hp 
     FROM tamu t 
     JOIN reservasi r 
     ON t.id_tamu = r.id_tamu;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaksi_by_metode_tanggal` (`p_metode` VARCHAR(20), `p_tgl_transaksi` DATE)   BEGIN 
     IF p_metode IS NOT NULL AND p_tgl_transaksi IS NOT NULL THEN
        SELECT * FROM transaksi 
        WHERE metode = p_metode AND tgl_transaksi = p_tgl_transaksi; 
     ELSEIF p_metode IS NOT NULL THEN 
        SELECT * FROM transaksi 
        WHERE metode = p_metode; 
     ELSEIF p_tgl_transaksi IS NOT NULL THEN 
        SELECT * FROM transaksi 
        WHERE tgl_transaksi = p_tgl_transaksi; 
     ELSE SELECT * FROM transaksi; 
     END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `jumlah_tamu_reservasi` () RETURNS INT(11) DETERMINISTIC BEGIN 
     DECLARE jumlah INT; 
     SELECT COUNT(DISTINCT id_tamu) INTO jumlah FROM reservasi; 
     RETURN jumlah; 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total_transaksi_by_reservasi_service` (`p_id_reservasi` VARCHAR(10), `p_id_service` VARCHAR(10)) RETURNS INT(11) DETERMINISTIC BEGIN 
     DECLARE total INT; 
     SELECT total_transaksi 
     INTO total 
     FROM transaksi 
     WHERE id_reservasi = p_id_reservasi AND id_service = p_id_service; 
     RETURN total; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `horizontalreservasi`
-- (See below for the actual view)
--
CREATE TABLE `horizontalreservasi` (
`id_reservasi` varchar(10)
,`id_tamu` varchar(10)
,`no_kamar` varchar(10)
,`tgl_checkin` date
,`tgl_checkout` date
);

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `no_kamar` varchar(10) NOT NULL,
  `tipe_kamar` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `harga_permalam` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`no_kamar`, `tipe_kamar`, `status`, `harga_permalam`, `jumlah`) VALUES
('NK01', 'Single', 'Reguler', 2500000, 2),
('NK02', 'Double', 'Reguler', 3000000, 1),
('NK03', 'Family', 'Exclusive', 5500000, 1),
('NK04', 'Single', 'Exclusive', 4000000, 2),
('NK05', 'Single', 'Reguler', 2500000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id_log` int(11) NOT NULL,
  `jenis_operasi` varchar(20) DEFAULT NULL,
  `nama_tabel` varchar(20) DEFAULT NULL,
  `waktu` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_lama` text DEFAULT NULL,
  `data_baru` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_aktivitas`
--

INSERT INTO `log_aktivitas` (`id_log`, `jenis_operasi`, `nama_tabel`, `waktu`, `data_lama`, `data_baru`) VALUES
(1, 'SEBELUM INSERT', 'tamu', '2024-07-14 15:46:12', NULL, 'id_tamu=IT06, nama=Budi Santoso, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081998877665'),
(2, 'SETELAH INSERT', 'tamu', '2024-07-14 15:46:12', NULL, 'id_tamu=IT06, nama=Budi Santoso, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081998877665'),
(3, 'SEBELUM UPDATE', 'tamu', '2024-07-14 15:48:04', 'id_tamu=IT06, nama=Budi Santoso, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081998877665', 'id_tamu=IT06, nama=Budi Pranoto, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081112223344'),
(4, 'SETELAH UPDATE', 'tamu', '2024-07-14 15:48:04', 'id_tamu=IT06, nama=Budi Santoso, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081998877665', 'id_tamu=IT06, nama=Budi Pranoto, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081112223344'),
(5, 'SEBELUM DELETE', 'tamu', '2024-07-14 15:50:13', 'id_tamu=IT06, nama=Budi Pranoto, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081112223344', NULL),
(6, 'SETELAH DELETE', 'tamu', '2024-07-14 15:50:13', 'id_tamu=IT06, nama=Budi Pranoto, tanggal_lahir=1995-06-15, alamat=Jl. Malioboro, No. 10, Yogyakarta, no_hp=081112223344', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reservasi`
--

CREATE TABLE `reservasi` (
  `id_reservasi` varchar(10) NOT NULL,
  `id_tamu` varchar(10) DEFAULT NULL,
  `no_kamar` varchar(10) DEFAULT NULL,
  `tgl_checkin` date DEFAULT NULL,
  `tgl_checkout` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservasi`
--

INSERT INTO `reservasi` (`id_reservasi`, `id_tamu`, `no_kamar`, `tgl_checkin`, `tgl_checkout`) VALUES
('IR01', 'IT01', 'NK01', '2024-08-07', '2024-08-08'),
('IR02', 'IT02', 'NK02', '2024-03-22', '2024-03-23'),
('IR03', 'IT03', 'NK03', '2024-11-13', '2024-11-11'),
('IR04', 'IT04', 'NK04', '2023-12-31', '2024-01-01'),
('IR05', 'IT05', 'NK05', '2023-12-23', '2023-12-24');

-- --------------------------------------------------------

--
-- Table structure for table `reservasi_baru`
--

CREATE TABLE `reservasi_baru` (
  `id_reservasi` varchar(5) NOT NULL,
  `id_tamu` varchar(5) DEFAULT NULL,
  `no_kamar` varchar(5) DEFAULT NULL,
  `tgl_checkin` date DEFAULT NULL,
  `tgl_checkout` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id_service` varchar(10) NOT NULL,
  `nama_karyawan` varchar(100) DEFAULT NULL,
  `jenis_service` varchar(20) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `ketersediaan` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id_service`, `nama_karyawan`, `jenis_service`, `harga`, `ketersediaan`) VALUES
('7', 'John Doe', 'gold', 450000, 'TERSEDIA'),
('S01', 'Eko', 'Premium', 2500000, 'available'),
('S02', 'Jonathan', 'Gold', 1000000, 'available'),
('S03', 'Aldi', 'Diamond', 1500000, 'available'),
('S04', 'Timy', 'Premium', 2500000, 'available'),
('S05', 'Winda', 'Silver', 800000, 'available');

-- --------------------------------------------------------

--
-- Table structure for table `tamu`
--

CREATE TABLE `tamu` (
  `id_tamu` varchar(10) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tamu`
--

INSERT INTO `tamu` (`id_tamu`, `nama`, `tanggal_lahir`, `alamat`, `no_hp`) VALUES
('IT01', 'Azmi Aziz', '2000-05-15', 'Jl.Magelang ,No 12.Magelang', '089987654321'),
('IT02', 'Egi Sugiono', '1997-02-21', 'Jl.Gorongan, No 03, Solo', '081234567899'),
('IT03', 'Surya Laksana', '1999-08-08', 'Jl.Piyungan, No 16, Salatiga', '080102030405'),
('IT04', 'Ita Wahyuningsih', '2000-01-21', 'Jl. Ahmad Yani, No 08, Bantul', '081122334455'),
('IT05', 'Kelvin Saputra', '1992-08-07', 'Jl. Kaliwaru, No.22, Sleman', '085544332211');

--
-- Triggers `tamu`
--
DELIMITER $$
CREATE TRIGGER `sebelum_delete_tamu` BEFORE DELETE ON `tamu` FOR EACH ROW BEGIN 
     INSERT INTO log_aktivitas (jenis_operasi, nama_tabel, data_lama) 
     VALUES ('SEBELUM DELETE', 'tamu', CONCAT('id_tamu=', OLD.id_tamu, ', nama=', OLD.nama, ', tanggal_lahir=', OLD.tanggal_lahir, ', alamat=', OLD.alamat, ', no_hp=', OLD.no_hp));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sebelum_insert_tamu` BEFORE INSERT ON `tamu` FOR EACH ROW BEGIN 
     INSERT INTO log_aktivitas (jenis_operasi, nama_tabel, data_baru) 
     VALUES ('SEBELUM INSERT', 'tamu', CONCAT('id_tamu=', NEW.id_tamu, ', nama=', NEW.nama, ', tanggal_lahir=', NEW.tanggal_lahir, ', alamat=', NEW.alamat, ', no_hp=', NEW.no_hp));
 END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sebelum_update_tamu` BEFORE UPDATE ON `tamu` FOR EACH ROW BEGIN 
     INSERT INTO log_aktivitas (jenis_operasi, nama_tabel, data_lama, data_baru) 
     VALUES ('SEBELUM UPDATE', 'tamu', CONCAT('id_tamu=', OLD.id_tamu, ', nama=', OLD.nama, ', tanggal_lahir=', OLD.tanggal_lahir, ', alamat=', OLD.alamat, ', no_hp=', OLD.no_hp), CONCAT('id_tamu=', NEW.id_tamu, ', nama=', NEW.nama, ', tanggal_lahir=', NEW.tanggal_lahir, ', alamat=', NEW.alamat, ', no_hp=', NEW.no_hp));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setelah_delete_tamu` AFTER DELETE ON `tamu` FOR EACH ROW BEGIN 
     INSERT INTO log_aktivitas (jenis_operasi, nama_tabel, data_lama) 
     VALUES ('SETELAH DELETE', 'tamu', CONCAT('id_tamu=', OLD.id_tamu, ', nama=', OLD.nama, ', tanggal_lahir=', OLD.tanggal_lahir, ', alamat=', OLD.alamat, ', no_hp=', OLD.no_hp));

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setelah_insert_tamu` AFTER INSERT ON `tamu` FOR EACH ROW BEGIN 
     INSERT INTO log_aktivitas (jenis_operasi, nama_tabel, data_baru) 
     VALUES ('SETELAH INSERT', 'tamu', CONCAT('id_tamu=', NEW.id_tamu, ', nama=', NEW.nama, ', tanggal_lahir=', NEW.tanggal_lahir, ', alamat=', NEW.alamat, ', no_hp=', NEW.no_hp));
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `setelah_update_tamu` AFTER UPDATE ON `tamu` FOR EACH ROW BEGIN 
    INSERT INTO log_aktivitas (
        jenis_operasi, 
        nama_tabel, 
        data_lama, 
        data_baru
    ) 
    VALUES (
        'SETELAH UPDATE', 
        'tamu', 
        CONCAT('id_tamu=', OLD.id_tamu, ', nama=', OLD.nama, ', tanggal_lahir=', OLD.tanggal_lahir, ', alamat=', OLD.alamat, ', no_hp=', OLD.no_hp), 
        CONCAT('id_tamu=', NEW.id_tamu, ', nama=', NEW.nama, ', tanggal_lahir=', NEW.tanggal_lahir, ', alamat=', NEW.alamat, ', no_hp=', NEW.no_hp)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` varchar(10) NOT NULL,
  `id_reservasi` varchar(10) DEFAULT NULL,
  `id_service` varchar(10) DEFAULT NULL,
  `metode` varchar(20) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `total_transaksi` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_reservasi`, `id_service`, `metode`, `tgl_transaksi`, `total_transaksi`) VALUES
('T01', 'IR01', 'S02', 'kartu credit', '2024-08-07', 6000000),
('T02', 'IR02', 'S01', 'cash', '2024-03-22', 5500000),
('T03', 'IR03', 'S05', 'kartu credit', '2024-11-13', 11800000),
('T04', 'IR04', 'S03', 'kartu credit', '2023-12-31', 9500000),
('T05', 'IR05', 'S04', 'cash', '2023-12-23', 5000000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `verticaltamu`
-- (See below for the actual view)
--
CREATE TABLE `verticaltamu` (
`id_tamu` varchar(10)
,`nama` varchar(100)
,`alamat` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_inside_service_cascaded`
-- (See below for the actual view)
--
CREATE TABLE `vw_inside_service_cascaded` (
`id_service` varchar(10)
,`nama_karyawan` varchar(100)
,`jenis_service` varchar(20)
,`harga` int(11)
,`ketersediaan` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_inside_service_local`
-- (See below for the actual view)
--
CREATE TABLE `vw_inside_service_local` (
`id_service` varchar(10)
,`nama_karyawan` varchar(100)
,`jenis_service` varchar(20)
,`harga` int(11)
,`ketersediaan` varchar(20)
);

-- --------------------------------------------------------

--
-- Structure for view `horizontalreservasi`
--
DROP TABLE IF EXISTS `horizontalreservasi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontalreservasi`  AS SELECT `reservasi`.`id_reservasi` AS `id_reservasi`, `reservasi`.`id_tamu` AS `id_tamu`, `reservasi`.`no_kamar` AS `no_kamar`, `reservasi`.`tgl_checkin` AS `tgl_checkin`, `reservasi`.`tgl_checkout` AS `tgl_checkout` FROM `reservasi` WHERE `reservasi`.`tgl_checkin` >= curdate() AND `reservasi`.`tgl_checkin` < curdate() + interval 7 day ;

-- --------------------------------------------------------

--
-- Structure for view `verticaltamu`
--
DROP TABLE IF EXISTS `verticaltamu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `verticaltamu`  AS SELECT `tamu`.`id_tamu` AS `id_tamu`, `tamu`.`nama` AS `nama`, `tamu`.`alamat` AS `alamat` FROM `tamu` ;

-- --------------------------------------------------------

--
-- Structure for view `vw_inside_service_cascaded`
--
DROP TABLE IF EXISTS `vw_inside_service_cascaded`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_inside_service_cascaded`  AS SELECT `service`.`id_service` AS `id_service`, `service`.`nama_karyawan` AS `nama_karyawan`, `service`.`jenis_service` AS `jenis_service`, `service`.`harga` AS `harga`, `service`.`ketersediaan` AS `ketersediaan` FROM `service` WHERE `service`.`jenis_service` in ('gold','diamond') AND `service`.`ketersediaan` = 'TERSEDIA'WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `vw_inside_service_local`
--
DROP TABLE IF EXISTS `vw_inside_service_local`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_inside_service_local`  AS SELECT `service`.`id_service` AS `id_service`, `service`.`nama_karyawan` AS `nama_karyawan`, `service`.`jenis_service` AS `jenis_service`, `service`.`harga` AS `harga`, `service`.`ketersediaan` AS `ketersediaan` FROM `service` WHERE `service`.`jenis_service` in ('gold','diamond')WITH CASCADED CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`no_kamar`);

--
-- Indexes for table `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `reservasi`
--
ALTER TABLE `reservasi`
  ADD PRIMARY KEY (`id_reservasi`),
  ADD KEY `id_tamu` (`id_tamu`),
  ADD KEY `no_kamar` (`no_kamar`),
  ADD KEY `tambah_reservasi` (`id_tamu`,`no_kamar`);

--
-- Indexes for table `reservasi_baru`
--
ALTER TABLE `reservasi_baru`
  ADD PRIMARY KEY (`id_reservasi`),
  ADD KEY `idx_composite_reservasi_baru` (`id_tamu`,`no_kamar`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id_service`);

--
-- Indexes for table `tamu`
--
ALTER TABLE `tamu`
  ADD PRIMARY KEY (`id_tamu`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_reservasi` (`id_reservasi`),
  ADD KEY `id_service` (`id_service`),
  ADD KEY `tambah_reservasi` (`id_reservasi`,`id_service`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservasi`
--
ALTER TABLE `reservasi`
  ADD CONSTRAINT `reservasi_ibfk_1` FOREIGN KEY (`id_tamu`) REFERENCES `tamu` (`id_tamu`),
  ADD CONSTRAINT `reservasi_ibfk_2` FOREIGN KEY (`no_kamar`) REFERENCES `kamar` (`no_kamar`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_reservasi`) REFERENCES `reservasi` (`id_reservasi`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_service`) REFERENCES `service` (`id_service`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

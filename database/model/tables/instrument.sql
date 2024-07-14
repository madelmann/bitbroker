CREATE TABLE `instrument` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) DEFAULT NULL,
  `base` varchar(8) NOT NULL,
  `quote` varchar(8) NOT NULL,
  `state` varchar(32) NOT NULL DEFAULT 'INACTIVE',
  `amount_precision` int(11) NOT NULL DEFAULT 0,
  `market_precision` int(11) NOT NULL DEFAULT 0,
  `min_size` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `instruments_code_uindex` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
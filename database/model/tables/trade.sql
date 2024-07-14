CREATE TABLE `trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `trade_id` varchar(80) DEFAULT NULL,
  `order_id` varchar(80) NOT NULL,
  `account_id` varchar(80) NOT NULL,
  `side` varchar(8) NOT NULL,
  `instrument_code` varchar(16) NOT NULL,
  `amount` float NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trades_trade_id_uindex` (`trade_id`),
  KEY `trade_account_id_fk` (`account_id`),
  KEY `trade_side_index` (`side`),
  CONSTRAINT `trade_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
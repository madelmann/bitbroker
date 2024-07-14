CREATE TABLE `balance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(80) NOT NULL,
  `currency_code` varchar(16) NOT NULL,
  `available` float NOT NULL DEFAULT 0,
  `locked` float NOT NULL DEFAULT 0,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `balance_account_id_fk` (`account_id`),
  CONSTRAINT `balance_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
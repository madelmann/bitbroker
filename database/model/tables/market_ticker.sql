CREATE TABLE `market_ticker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `instrument_code` varchar(16) NOT NULL,
  `last_price` float NOT NULL,
  `best_ask` float NOT NULL DEFAULT 0,
  `best_bid` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `market_ticker_pk` (`time`,`instrument_code`),
  KEY `market_ticker_instrument_code_index` (`instrument_code`),
  KEY `market_ticker_time_index` (`time`),
  CONSTRAINT `market_ticker_instrument_code_fk` FOREIGN KEY (`instrument_code`) REFERENCES `instrument` (`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
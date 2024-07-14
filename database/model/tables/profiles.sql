CREATE TABLE `profiles` (
  `identifier` varchar(255) NOT NULL,
  `create_users` tinyint(1) NOT NULL DEFAULT 0,
  `delete_users` tinyint(1) NOT NULL DEFAULT 0,
  `update_users` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
CREATE DEFINER=`root`@`localhost` FUNCTION `CreateSessionId`(identifier_ varchar(256)) RETURNS varchar(256) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
begin
    return sha2(identifier_ + NOW(), 256);
end;
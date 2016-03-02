CREATE TABLE IF NOT EXISTS `sns`.`usernet` (
  `id` INT GENERATED ALWAYS AS (),
  `uid` VARCHAR(45) NOT NULL COMMENT '关注用户id',
  `fuid` VARCHAR(45) NULL COMMENT '被关注用户id',
  `ftime` DATETIME NOT NULL COMMENT '关注时间\n',
  PRIMARY KEY (`id`))
ENGINE = InnoDB

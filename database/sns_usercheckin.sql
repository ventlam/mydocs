CREATE TABLE IF NOT EXISTS `sns`.`usercheckin` (
  `id` INT GENERATED ALWAYS AS (),
  `uid` INT NOT NULL,
  `indays` INT NOT NULL COMMENT '连续签到天数',
  `last_login` DATETIME NOT NULL,
  `create_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB

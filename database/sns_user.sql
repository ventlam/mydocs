CREATE TABLE IF NOT EXISTS `sns`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '用户id，自增',
  `password` VARCHAR(250) NOT NULL COMMENT '加密后密码',
  `first_login` DATETIME NOT NULL COMMENT '第一次登录时间',
  `last_login` DATETIME NOT NULL COMMENT '最后一次登录时间',
  `last_updatetime` DATETIME NOT NULL COMMENT '最后一次更新信息时间',
  `username` VARCHAR(90) NOT NULL COMMENT '用户名',
  `nickname` VARCHAR(90) NULL COMMENT '昵称\n',
  `is_kill` TINYINT(2) NOT NULL DEFAULT 0 COMMENT '是否被禁',
  `gender` TINYINT(2) NULL COMMENT '性别\n',
  `avatar` VARCHAR(100) NOT NULL COMMENT '头像',
  `birthday` VARCHAR(50) NULL COMMENT '用户录入生日',
  `province` VARCHAR(45) NULL COMMENT '用户所在省',
  `city` VARCHAR(45) NULL COMMENT '用户所在城市',
  `lat` VARCHAR(45) NULL COMMENT '经度',
  `lon` VARCHAR(45) NULL COMMENT '纬度',
  PRIMARY KEY (`id`))
ENGINE = InnoDB

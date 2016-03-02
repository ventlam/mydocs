CREATE TABLE IF NOT EXISTS `sns`.`userdevice` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL COMMENT '用户ID\n',
  `app_type` INT NOT NULL DEFAULT 0 COMMENT 'app类型，0为糖豆广场舞；',
  `os` VARCHAR(10) NOT NULL COMMENT '操作系统',
  `token` VARCHAR(45) NOT NULL,
  `diu1` VARCHAR(60) NOT NULL COMMENT '安卓为imei，iOS为idfv',
  `diu2` VARCHAR(60) NOT NULL COMMENT 'uuid',
  `diu3` VARCHAR(60) NOT NULL COMMENT '全局唯一id',
  `div` VARCHAR(15) NOT NULL COMMENT '版本',
  `dic` VARCHAR(20) NOT NULL COMMENT '渠道',
  `create_time` DATETIME NOT NULL,
  `is_kill` TINYINT(1) NOT NULL COMMENT '是否被封禁，0为no，1为yes。\n',
  `device` VARCHAR(90) NULL COMMENT '设备',
  `manf` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL COMMENT '机型',
  `last_update` DATETIME NOT NULL COMMENT '最后一次更新',
  PRIMARY KEY (`id`))
ENGINE = InnoDB

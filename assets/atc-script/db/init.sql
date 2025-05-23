-- 初始化数据库
CREATE DATABASE  `control_atigue` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `control_atigue`;


-- 初始化表
DROP TABLE IF EXISTS `atc_seat`;
CREATE TABLE `atc_seat`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `seat_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '席位id',
  `seat_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '席位名称',
  `camera_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控ip',
  `camera_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控名称',
  `channel_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控通道号',
  `device_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控设备号',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `login_user_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前登陆人员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '席位表' ROW_FORMAT = DYNAMIC;


INSERT INTO `atc_seat` VALUES ('1911676916373696513', NULL, '席位2', NULL, NULL, NULL, NULL, 'admin', '2025-04-14 15:04:29', 'tiantian', '2025-05-20 13:53:42', '61210f440df34600a0dfacf2df9bb721');
INSERT INTO `atc_seat` VALUES ('1911676944626528257', NULL, '席位3', NULL, NULL, NULL, NULL, 'admin', '2025-04-14 15:04:36', 'tiantian', '2025-05-19 14:46:35', NULL);
INSERT INTO `atc_seat` VALUES ('1916735967239135234', '1', '席位1', '140.249.23.155:8081', '席位4监控', '34020000001320000001', '34020000001320000001', 'admin', '2025-04-28 00:00:00', 'admin', '2025-05-22 09:11:47', NULL);

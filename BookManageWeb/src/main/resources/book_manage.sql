/*
 Navicat Premium Data Transfer

 Source Server         : 本地数据库
 Source Server Type    : MySQL
 Source Server Version : 50719 (5.7.19)
 Source Host           : localhost:3306
 Source Schema         : book_manage

 Target Server Type    : MySQL
 Target Server Version : 50719 (5.7.19)
 File Encoding         : 65001

 Date: 28/11/2022 12:14:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '图书管理员', '123456');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '三国', '刘备', 9.90);
INSERT INTO `book` VALUES (2, '水浒', '鲁智深', 6.00);
INSERT INTO `book` VALUES (3, '计算机组成', '被摆了一道啊', 8.00);
INSERT INTO `book` VALUES (4, '查理九世', '小说', 5.00);
INSERT INTO `book` VALUES (5, '电锯人', '漫画', 10.00);
INSERT INTO `book` VALUES (6, '再见绘梨', '藤本树', 6.60);
INSERT INTO `book` VALUES (7, '进击的巨人', '谏山创', 8.80);
INSERT INTO `book` VALUES (8, '间谍过家家', '阿尼亚', 18.00);
INSERT INTO `book` VALUES (9, '五等分的花嫁', '二乃', 15.00);
INSERT INTO `book` VALUES (10, '数据结构', '脑子坏了', 5.00);
INSERT INTO `book` VALUES (11, '伞兵一号', 'lbw', 5.00);

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NULL DEFAULT NULL,
  `bid` int(11) NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_sid_bid`(`sid`, `bid`) USING BTREE,
  UNIQUE INDEX `f_bid`(`bid`) USING BTREE,
  CONSTRAINT `f_bid` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `f_sid` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES (1, 3, 1, '2022-11-24 17:51:02');
INSERT INTO `borrow` VALUES (2, 6, 9, '2022-11-27 17:51:20');
INSERT INTO `borrow` VALUES (3, 8, 4, '2022-11-16 17:51:32');
INSERT INTO `borrow` VALUES (4, 5, 8, '2022-11-06 17:51:45');
INSERT INTO `borrow` VALUES (7, 6, 6, '2022-11-27 21:51:44');
INSERT INTO `borrow` VALUES (8, 5, 2, '2022-11-27 22:42:04');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男',
  `grade` int(11) NOT NULL,
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (3, '小刚', '男', 2020);
INSERT INTO `student` VALUES (4, '阿尼亚', '女', 2021);
INSERT INTO `student` VALUES (5, '甘雨', '女', 2022);
INSERT INTO `student` VALUES (6, '可莉', '女', 1314);
INSERT INTO `student` VALUES (7, '赛文', '男', 555);
INSERT INTO `student` VALUES (8, '天选姬', '女', 666);
INSERT INTO `student` VALUES (9, '唐老鸭', '男', 888);

-- ----------------------------
-- Triggers structure for table book
-- ----------------------------
DROP TRIGGER IF EXISTS `del_book`;
delimiter ;;
CREATE TRIGGER `del_book` BEFORE DELETE ON `book` FOR EACH ROW delete FROM borrow where bid = old.bid
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `del`;
delimiter ;;
CREATE TRIGGER `del` BEFORE DELETE ON `student` FOR EACH ROW DELETE FROM borrow where sid = old.sid
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

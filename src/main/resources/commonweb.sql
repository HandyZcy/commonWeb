/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50627
Source Host           : 127.0.0.1:3306
Source Database       : commonweb

Target Server Type    : MYSQL
Target Server Version : 50627
File Encoding         : 65001

Date: 2017-04-25 10:32:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_manager
-- ----------------------------
DROP TABLE IF EXISTS `sys_manager`;
CREATE TABLE `sys_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `pwd` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(255) NOT NULL COMMENT '用户名',
  `state` varchar(2) DEFAULT '1' COMMENT '状态：0、禁用；1、启用；',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱地址',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_manager
-- ----------------------------
INSERT INTO `sys_manager` VALUES ('1', '超级管理员', '8503e64c755a995d588df577e61015c07a5a9aea', 'admin@admin.com', '1', '', '', '2016-06-29 14:03:23', '2017-04-21 17:05:03');

-- ----------------------------
-- Table structure for sys_manager_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_manager_role`;
CREATE TABLE `sys_manager_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `manager_id` int(11) NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

-- ----------------------------
-- Records of sys_manager_role
-- ----------------------------
INSERT INTO `sys_manager_role` VALUES ('1', '1', '1', '2016-07-04 15:58:46');

-- ----------------------------
-- Table structure for sys_right
-- ----------------------------
DROP TABLE IF EXISTS `sys_right`;
CREATE TABLE `sys_right` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) NOT NULL COMMENT '权限名',
  `link` varchar(255) DEFAULT NULL COMMENT 'url 链接地址',
  `description` varchar(255) DEFAULT NULL COMMENT '权限标识（shiro 判断权限使用）',
  `parent_id` int(11) DEFAULT NULL COMMENT '当前权限所属父级id（当前表id，权限分组显示时使用）',
  `type` tinyint(4) DEFAULT NULL COMMENT '权限类型：0、包；1、菜单；2、功能；',
  `seqnum` int(11) DEFAULT NULL COMMENT '排列序号',
  `state` tinyint(1) DEFAULT '1' COMMENT '状态：0、禁用；1、启用；',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='权限表';

-- ----------------------------
-- Records of sys_right
-- ----------------------------
INSERT INTO `sys_right` VALUES ('1', 'ROOT', null, null, '0', '0', '0', '1', '2016-05-30 09:36:09', '2016-05-30 09:48:01');
INSERT INTO `sys_right` VALUES ('2', '系统管理', null, null, '1', '0', '1', '1', '2016-05-30 09:48:07', '2016-05-30 09:48:09');
INSERT INTO `sys_right` VALUES ('3', '权限管理', null, null, '2', '0', '1', '1', '2016-05-30 09:49:38', '2016-05-30 09:49:41');
INSERT INTO `sys_right` VALUES ('4', '权限管理', 'right/list', 'superman:right:list', '3', '1', '1', '1', '2016-05-30 09:50:55', '2017-04-12 19:48:14');
INSERT INTO `sys_right` VALUES ('5', '角色管理', 'role/getRoleList', 'superman:role:list', '3', '1', '2', '1', '2016-05-30 10:50:47', '2017-04-12 15:44:17');
INSERT INTO `sys_right` VALUES ('6', '管理员管理', 'manager/getManagerList', 'superman:manager:list', '3', '1', '3', '1', '2016-05-30 10:51:36', '2017-04-15 10:55:05');
INSERT INTO `sys_right` VALUES ('7', '添加角色', '', 'superman:role:add', '5', '2', '1', '1', '2016-06-03 16:18:17', '2016-06-03 16:18:17');
INSERT INTO `sys_right` VALUES ('8', '修改角色', '', 'superman:role:update', '5', '2', null, '1', '2016-07-05 11:39:48', '2016-07-05 11:39:48');
INSERT INTO `sys_right` VALUES ('9', '删除角色', '', 'superman:role:del', '5', '2', '4', '1', '2016-07-05 11:40:18', '2016-07-05 11:40:18');
INSERT INTO `sys_right` VALUES ('10', '分配权限', '', 'superman:role:authorize', '5', '2', '5', '1', '2016-07-05 11:42:39', '2016-07-05 15:40:44');
INSERT INTO `sys_right` VALUES ('11', '添加管理员', '', 'superman:manager:add', '6', '2', '1', '1', '2016-07-05 11:44:02', '2016-07-05 11:44:02');
INSERT INTO `sys_right` VALUES ('12', '修改管理员', '', 'superman:manager:update', '6', '2', '2', '1', '2016-07-05 11:44:24', '2016-07-05 11:44:24');
INSERT INTO `sys_right` VALUES ('13', '删除管理员', '', 'superman:manager:del', '6', '2', '3', '1', '2016-07-05 11:44:44', '2016-07-05 11:44:44');
INSERT INTO `sys_right` VALUES ('30', '服务类型管理', 'serviceTypeController/getDataList?type=0', '', '29', '1', '1', '1', '2016-07-21 09:54:14', '2016-07-21 09:54:14');
INSERT INTO `sys_right` VALUES ('31', '商户信息管理', 'shopController/findShopList', '', '29', '1', '2', '1', '2016-07-21 16:19:20', '2016-07-22 17:02:22');
INSERT INTO `sys_right` VALUES ('33', '会员卡交易订单', 'shopBillController/getShopBillList', '', '32', '1', '1', '1', '2016-07-24 15:20:24', '2016-07-24 15:20:24');
INSERT INTO `sys_right` VALUES ('35', '空卡管理', 'cardController/getBlankCardList', '', '48', '1', '1', '1', '2016-07-25 15:27:26', '2016-09-18 15:32:01');
INSERT INTO `sys_right` VALUES ('38', '买家管理', '', '', '37', '0', '1', '1', '2016-07-28 17:54:04', '2016-07-28 17:54:04');
INSERT INTO `sys_right` VALUES ('39', '绑卡买家管理', 'accountController/getTieBuyerListPage', '', '38', '1', '1', '1', '2016-07-28 17:55:14', '2016-07-28 17:55:14');
INSERT INTO `sys_right` VALUES ('40', '未绑卡买家管理', 'accountController/getNoTieBuyerListPage', '', '38', '1', '2', '1', '2016-07-30 16:28:38', '2016-07-30 16:29:42');
INSERT INTO `sys_right` VALUES ('41', '卖家管理', 'sellerManageController/getSellerList', '', '37', '1', '2', '1', '2016-07-30 18:39:59', '2016-07-30 18:40:42');
INSERT INTO `sys_right` VALUES ('46', '交易统计', 'statisticalController/tradingRecord', '1', '45', '1', '2', '1', '2016-09-09 14:52:27', '2017-04-14 19:06:47');
INSERT INTO `sys_right` VALUES ('47', '对账管理', '', '', '34', '0', '2', '1', '2016-09-18 15:27:45', '2016-09-18 15:27:45');
INSERT INTO `sys_right` VALUES ('48', '会员卡管理', '', '', '34', '0', '1', '1', '2016-09-18 15:28:07', '2016-09-18 15:28:07');
INSERT INTO `sys_right` VALUES ('49', '交易对账', 'shopBalanceController/shopBalanceList', '', '47', '1', '1', '1', '2016-09-18 15:29:01', '2016-09-18 15:29:57');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '角色名称',
  `description` varchar(255) DEFAULT NULL COMMENT '角色标识，shiro判断使用',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'superman', '2016-05-30 14:28:11', '2016-06-03 16:15:23');
INSERT INTO `sys_role` VALUES ('3', '对账小组', null, '2016-08-01 15:06:50', '2016-08-01 15:06:50');
INSERT INTO `sys_role` VALUES ('4', '系统管理员', null, '2016-08-01 17:29:08', '2016-08-01 17:29:08');
INSERT INTO `sys_role` VALUES ('5', '测试角色', null, '2017-04-12 15:54:21', '2017-04-12 16:48:22');

-- ----------------------------
-- Table structure for sys_role_right
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_right`;
CREATE TABLE `sys_role_right` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `right_id` int(11) NOT NULL COMMENT '权限id',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=703 DEFAULT CHARSET=utf8 COMMENT='角色和权限关联关系表';

-- ----------------------------
-- Records of sys_role_right
-- ----------------------------
INSERT INTO `sys_role_right` VALUES ('602', '1', '1', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('603', '1', '2', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('604', '1', '3', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('605', '1', '4', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('606', '1', '5', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('607', '1', '7', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('608', '1', '8', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('609', '1', '9', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('610', '1', '10', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('611', '1', '6', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('612', '1', '11', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('613', '1', '12', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('614', '1', '13', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('615', '1', '29', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('616', '1', '30', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('617', '1', '31', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('618', '1', '53', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('619', '1', '32', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('620', '1', '33', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('621', '1', '34', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('622', '1', '47', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('623', '1', '49', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('624', '1', '48', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('625', '1', '35', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('626', '1', '36', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('627', '1', '42', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('628', '1', '37', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('629', '1', '38', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('630', '1', '39', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('631', '1', '40', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('632', '1', '41', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('633', '1', '45', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('634', '1', '46', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('635', '1', '50', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('636', '1', '51', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('637', '1', '52', '2016-10-11 09:32:40');
INSERT INTO `sys_role_right` VALUES ('657', '3', '1', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('658', '3', '29', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('659', '3', '30', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('660', '3', '31', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('661', '3', '53', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('662', '3', '32', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('663', '3', '33', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('664', '3', '34', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('665', '3', '47', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('666', '3', '49', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('667', '3', '48', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('668', '3', '35', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('669', '3', '36', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('670', '3', '42', '2016-12-07 17:41:19');
INSERT INTO `sys_role_right` VALUES ('671', '4', '1', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('672', '4', '29', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('673', '4', '30', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('674', '4', '31', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('675', '4', '53', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('676', '4', '32', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('677', '4', '33', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('678', '4', '34', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('679', '4', '47', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('680', '4', '49', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('681', '4', '48', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('682', '4', '35', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('683', '4', '36', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('684', '4', '42', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('685', '4', '37', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('686', '4', '38', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('687', '4', '39', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('688', '4', '40', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('689', '4', '41', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('690', '4', '45', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('691', '4', '46', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('692', '4', '50', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('693', '4', '51', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('694', '4', '52', '2016-12-07 17:41:36');
INSERT INTO `sys_role_right` VALUES ('698', '5', '1', '2017-04-15 00:38:49');
INSERT INTO `sys_role_right` VALUES ('699', '5', '37', '2017-04-15 00:38:49');
INSERT INTO `sys_role_right` VALUES ('700', '5', '41', '2017-04-15 00:38:49');
INSERT INTO `sys_role_right` VALUES ('701', '5', '45', '2017-04-15 00:38:49');
INSERT INTO `sys_role_right` VALUES ('702', '5', '46', '2017-04-15 00:38:49');

/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : video

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2019-02-27 14:27:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `truename` varchar(20) NOT NULL COMMENT '真实姓名',
  `gid` int(10) NOT NULL COMMENT '角色id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 | 0正常 1禁用',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES ('3', 'zhangsan', '4e7bdb88640b376ac6646b8f1ecfb558', '张三', '1', '0', '1541057538');
INSERT INTO `admins` VALUES ('4', 'zhangsan', '4e7bdb88640b376ac6646b8f1ecfb558', '123', '2', '0', '1541057612');
INSERT INTO `admins` VALUES ('11', 'zhangsan1233', 'db3db5e126ed3dd466db8f0ed312b536', '213', '1', '1', '1541058141');
INSERT INTO `admins` VALUES ('18', 'zhangsan', '4e7bdb88640b376ac6646b8f1ecfb558', '张三1', '1', '0', '1541067277');
INSERT INTO `admins` VALUES ('19', '123', '123123', '123', '2', '0', '20181025');
INSERT INTO `admins` VALUES ('29', 'admin', 'admin', '123', '1', '0', '1541471991');

-- ----------------------------
-- Table structure for admin_groups
-- ----------------------------
DROP TABLE IF EXISTS `admin_groups`;
CREATE TABLE `admin_groups` (
  `gid` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `title` varchar(20) NOT NULL COMMENT '角色名称',
  `rights` text COMMENT '角色权限,json',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_groups
-- ----------------------------
INSERT INTO `admin_groups` VALUES ('1', '系统管理员', '[15,16,18,19,17,20,21,22,23,24,25,26,27,28,29]');
INSERT INTO `admin_groups` VALUES ('2', '开发人员', '[1,4,15,16,18,19,17,20,21,22,23,24,25,26]');

-- ----------------------------
-- Table structure for admin_menus
-- ----------------------------
DROP TABLE IF EXISTS `admin_menus`;
CREATE TABLE `admin_menus` (
  `mid` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `ord` int(10) NOT NULL COMMENT '排序',
  `title` varchar(20) NOT NULL COMMENT '菜单名称',
  `controller` varchar(30) DEFAULT NULL COMMENT '控制器名称',
  `method` varchar(30) DEFAULT NULL,
  `ishidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否隐藏 0正常显示 1隐藏',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常 1禁用',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_menus
-- ----------------------------
INSERT INTO `admin_menus` VALUES ('1', '0', '0', '管理员权限', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('4', '1', '0', '管理员列表设置', 'Admin', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('5', '1', '0', '管理员添加', 'Adimin', 'add', '1', '1');
INSERT INTO `admin_menus` VALUES ('15', '0', '0', '标签设置', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('16', '15', '0', '频道标签', 'Labels', 'channel', '0', '0');
INSERT INTO `admin_menus` VALUES ('17', '0', '0', '系统设置', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('18', '15', '0', '资费标签', 'Labels', 'charge', '0', '0');
INSERT INTO `admin_menus` VALUES ('19', '15', '0', '地区标签', 'Labels', 'area', '0', '0');
INSERT INTO `admin_menus` VALUES ('20', '17', '0', '网站设置', 'Site', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('21', '17', '0', '保存设置', 'Site', 'save', '1', '0');
INSERT INTO `admin_menus` VALUES ('22', '0', '0', '影片管理', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('23', '22', '0', '影片列表', 'Video', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('24', '22', '0', '添加影片', 'Video', 'add', '1', '0');
INSERT INTO `admin_menus` VALUES ('25', '22', '0', '保存影片', 'Video', 'save', '1', '0');
INSERT INTO `admin_menus` VALUES ('26', '22', '0', '图片上传', 'Video', 'upload_img', '1', '0');
INSERT INTO `admin_menus` VALUES ('27', '0', '0', '幻灯片管理', '', '', '0', '0');
INSERT INTO `admin_menus` VALUES ('28', '27', '0', '首页首屏', 'Slide', 'index', '0', '0');
INSERT INTO `admin_menus` VALUES ('29', '27', '0', '幻灯片保存', 'Slide', 'save', '1', '0');

-- ----------------------------
-- Table structure for sites
-- ----------------------------
DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `names` varchar(50) NOT NULL,
  `values` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sites
-- ----------------------------
INSERT INTO `sites` VALUES ('site', '\"\\u5416\\u513f\\u86cb\\u86cb\"');

-- ----------------------------
-- Table structure for slide
-- ----------------------------
DROP TABLE IF EXISTS `slide`;
CREATE TABLE `slide` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '类型:0 首页首屏',
  `ord` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排序',
  `title` varchar(30) NOT NULL COMMENT '标题',
  `url` varchar(255) NOT NULL COMMENT '链接地址',
  `img` varchar(255) NOT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of slide
-- ----------------------------
INSERT INTO `slide` VALUES ('16', '0', '0', '追捕者：陈龙于和伟热血追捕', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\885162c510b9b5a874b261c082e27dc2.jpg');
INSERT INTO `slide` VALUES ('17', '0', '0', '四海鲸骑：师徒反目首季收官', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\05502ded49e31fa9ec1869db96c9b0b3.jpg');
INSERT INTO `slide` VALUES ('18', '0', '0', '奇葩说：陈铭放大招邱晨急眼', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\f5edb6d0a07aa0deb818f777184b70e3.jpg');
INSERT INTO `slide` VALUES ('19', '0', '0', '声入人心：高天鹤批廖佳琳讨巧', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\5634759793d4b6216fbc0c68780993c6.jpg');
INSERT INTO `slide` VALUES ('20', '0', '0', '凉生:天佑不顾一切追回姜生', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\2bf2d30700218b513b34589b4593df40.jpg');
INSERT INTO `slide` VALUES ('21', '0', '0', '梁知·人情观察室：老梁侃兴趣', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\15da566609c13aa106a1a47438a8e876.jpg');
INSERT INTO `slide` VALUES ('22', '0', '0', '虎胆追凶： 双面硬汉暴力复仇', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\09770c9ca26bfacb8928278f48310f91.jpg');
INSERT INTO `slide` VALUES ('23', '0', '0', '共筑中国梦：优秀视听节目展播', 'https://www.iqiyi.com/v_19rr2kbzd8.html', '/tp5/public/uploads/20181108\\5486889c8cc6b9614ccc4ac94199bae0.jpg');

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) NOT NULL COMMENT '频道',
  `charge_id` int(10) NOT NULL COMMENT '资费',
  `area_id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '影片名称',
  `keywords` varchar(255) NOT NULL COMMENT '关键字',
  `desc` varchar(255) NOT NULL COMMENT '影片描述',
  `img` varchar(255) NOT NULL COMMENT '封面图',
  `url` varchar(255) NOT NULL,
  `pv` int(10) NOT NULL DEFAULT '0' COMMENT '点击数量',
  `score` int(3) NOT NULL DEFAULT '0' COMMENT '影片评分',
  `is_vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否vip才能看 0否 1是',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常1下线',
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES ('1', '1', '87', '89', '测试', '2131', '32131', '/tp5/public/uploads/20181107\\d9df4efcca7ba1ce2f308131e3085a38.jpg', 'http://www.360doc.com/content/16/0516/22/20433456_559729778.shtml', '0', '0', '0', '1', '1541564172');
INSERT INTO `video` VALUES ('5', '1', '87', '89', '测试22', '222', '2222', '/tp5/public/uploads/20181107\\849a4559c472e0a5544710d154c36332.jpg', 'http://www.360doc.com/content/16/0516/22/20433456_559729778.shtml', '0', '0', '0', '1', '1541571819');

-- ----------------------------
-- Table structure for video_label
-- ----------------------------
DROP TABLE IF EXISTS `video_label`;
CREATE TABLE `video_label` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ord` int(3) NOT NULL DEFAULT '0' COMMENT '排序',
  `title` varchar(50) NOT NULL COMMENT '标签标题',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0正常 1禁用',
  `flag` varchar(50) NOT NULL COMMENT '标签分类标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video_label
-- ----------------------------
INSERT INTO `video_label` VALUES ('1', '0', '电视剧', '0', 'channel');
INSERT INTO `video_label` VALUES ('6', '0', '电影1', '0', 'channel');
INSERT INTO `video_label` VALUES ('18', '1', '综艺', '0', 'channel');
INSERT INTO `video_label` VALUES ('21', '0', '动漫2', '0', 'channel');
INSERT INTO `video_label` VALUES ('23', '0', '纪录片', '0', 'channel');
INSERT INTO `video_label` VALUES ('25', '0', '资讯', '0', 'channel');
INSERT INTO `video_label` VALUES ('26', '0', '娱乐', '0', 'channel');
INSERT INTO `video_label` VALUES ('27', '0', '财经', '0', 'channel');
INSERT INTO `video_label` VALUES ('87', '0', '免费', '0', 'charge');
INSERT INTO `video_label` VALUES ('88', '0', '付费', '0', 'charge');
INSERT INTO `video_label` VALUES ('89', '0', '华语', '0', 'area');
INSERT INTO `video_label` VALUES ('90', '0', '香港', '0', 'area');
INSERT INTO `video_label` VALUES ('91', '0', '美国', '0', 'area');
INSERT INTO `video_label` VALUES ('92', '0', '欧洲', '0', 'area');
INSERT INTO `video_label` VALUES ('93', '0', '韩国', '0', 'area');
INSERT INTO `video_label` VALUES ('94', '0', '日本', '0', 'area');
INSERT INTO `video_label` VALUES ('95', '0', '泰国', '0', 'area');
INSERT INTO `video_label` VALUES ('96', '0', '其他', '0', 'area');

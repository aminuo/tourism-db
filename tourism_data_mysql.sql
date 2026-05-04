CREATE DATABASE IF NOT EXISTS `tourism_data` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `tourism_data`;

-- 景点主表
CREATE TABLE `scenic_spots` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `img` TEXT,
    `introduce` TEXT,
    `address` VARCHAR(500) NOT NULL,
    `times` VARCHAR(255),
    `price` DECIMAL(10,2) DEFAULT 0,
    `score` FLOAT DEFAULT 0,
    `star_level` INT DEFAULT 0,
    `phone` VARCHAR(50),
    `traffic` TEXT,
    `latitude` DECIMAL(10,6),
    `longitude` DECIMAL(10,6),
    `is_hot` TINYINT DEFAULT 0,
    `is_recommend` TINYINT DEFAULT 0,
    `view_count` INT DEFAULT 0,
    `create_time` DATETIME,
    `update_time` DATETIME,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 轮播图
CREATE TABLE `banner` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `image` VARCHAR(500) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 用户表
CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `openid` VARCHAR(128) NOT NULL,
    `session_key` VARCHAR(255) NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `avatar_url` VARCHAR(500),
    `nick_name` VARCHAR(100),
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 收藏表
CREATE TABLE `favorites` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `scenic_spot_id` INT NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_scenic` (`user_id`, `scenic_spot_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`scenic_spot_id`) REFERENCES `scenic_spots`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 一级分类标签
CREATE TABLE `tag_category1` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `sort` INT DEFAULT 0,
    `code` VARCHAR(50),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 二级分类标签
CREATE TABLE `tag_category2` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `c1_code` VARCHAR(50) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `sort` INT DEFAULT 0,
    `code` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 三级分类标签
CREATE TABLE `tag_category3` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `c2_code` VARCHAR(50) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `sort` INT DEFAULT 0,
    `code` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 标签属性（等级/费用/人群/体验/便捷/季节）
CREATE TABLE `tag_property` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `type` VARCHAR(50) NOT NULL,
    `sort` INT DEFAULT 0,
    `code` VARCHAR(50),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 景点-三级标签关联
CREATE TABLE `scenic_tag3` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `scenic_id` INT NOT NULL,
    `tag3_code` VARCHAR(50),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 景点-属性标签关联
CREATE TABLE `scenic_tag_property` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `scenic_id` INT NOT NULL,
    `property_code` VARCHAR(50),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 搜索历史
CREATE TABLE `search_history` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `keyword` VARCHAR(255) NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

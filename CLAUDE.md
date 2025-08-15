# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述
这是一个基于Flutter的模板项目，使用了GetX状态管理和ObjectBox本地数据库，包含两个主要内部包：core（核心功能）和updater（更新器）。

## 技术栈
- Flutter 3.23.3+
- GetX (状态管理 + 路由)
- ObjectBox (本地数据库)
- Injectable (依赖注入)
- FlexColorScheme (主题系统)
- 国际化支持 (CSV + JSON)

## 核心架构

### 目录结构
```
lib/
├── app/
│   ├── common/          # 全局配置和初始化
│   ├── controllers/     # GetX控制器
│   ├── features/        # 功能模块页面
│   ├── layouts/         # 布局组件
│   ├── locales/         # 国际化
│   ├── middlewares/     # 路由中间件
│   ├── routes/          # 路由配置
│   └── utils/           # 工具类
data/
├── models/              # 数据模型
└── services/            # 数据服务
db/
├── entity/              # 数据库实体
├── mapper/              # 实体映射器
└── services/            # 数据库服务
packages/
├── core/                # 核心功能包
└── updater/             # 应用更新包
```

### 关键入口点
- `main.dart:6` - 应用入口，初始化全局配置
- `Global.init()` - 全局初始化，位于 `lib/app/common/global.dart:39`
- `AppPages.initial` - 初始路由配置，位于 `lib/app/routes/app_pages.dart:8`

## 常用命令

### 开发相关
```bash
# 运行应用
flutter run

# 运行测试
flutter test

# 代码分析
flutter analyze

# 构建APK
flutter build apk --release

# 构建Windows
flutter build windows --release
```

### 代码生成
```bash
# 生成ObjectBox代码
flutter packages pub run build_runner build

# 生成Injectable依赖注入代码
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 构建脚本
- `scripts/build_android.sh` - Android APK构建脚本
- 使用fastforge进行分发构建（见distribute_options.yaml）

## 依赖注入
使用Injectable + GetIt实现依赖注入，配置在：`lib/app/common/global.dart:17`

## 数据库
- 使用ObjectBox作为本地数据库
- 实体定义在 `db/entity/` 目录
- 服务层在 `db/services/` 目录
- 映射器在 `db/mapper/` 目录

## 国际化
- 多语言文件位于 `assets/locales/`
- 支持CSV和JSON格式
- 自定义CSV加载器在 `lib/app/utils/csv_localization_loader.dart`

## 路由系统
- 基于GetX的路由管理
- 中间件系统包括：OOBE中间件和认证中间件
- 白名单路由配置在 `AppPages.whiteList`

## 包结构
### core包
- 核心功能：日志、网络、存储、工具类等
- 位于 `packages/core/`

### updater包
- 应用更新功能
- 位于 `packages/updater/`
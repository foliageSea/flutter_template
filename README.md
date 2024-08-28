# Flutter Template
> foliage

## TODO


## 开发环境
> 建议使用 fvm 管理 Flutter SDK 的版本
- flutter version: 3.22.2
- dart version: 3.4.3

## 快速开始
1. 拉取模板
```bash
git clone -b v0.0.2+5 https://github.com/foliageSea/flutter_template.git flutter_template
```

2. 修改跨平台项目名称
- 修改 pubspec.yaml 的 package_rename_config 字段
- 执行批量修改命令
```bash
flutter pub run package_rename
```

3. 修改 Flutter 项目名称
- 修改 pubspec.yaml 的 name 字段
- 使用 VSCode 全文本替换 lib 目录的包名

4. 修改应用图标
- 修改 pubspec.yaml 的 flutter_launcher_icons 字段
- 执行批量生成应用图标命令
```bash
flutter pub run flutter_launcher_icons
```

5. 拉取依赖
```bash
flutter pub get

flutter devices
flutter run -d android -v
```

6. 追加依赖
```bash
flutter pub add <dependency>
flutter pub add dev:<dependency>

flutter pub remove <dependency>
```
## 项目依赖

### 路由&状态管理
- Get

### UI
- tdesign_flutter

### 国际化
- Get

### JSON序列化
- json_serializable

### 数据库
- isar

### 持久化
- get_storage

### 日志
- talker_flutter

### 用户提示
- flutter_smart_dialog
- modal_bottom_sheet
- adaptive_dialog

### 网络请求
- dio

### 字体图标
- font_awesome_flutter (https://fontawesome.com/icons)

### 动画
- flutter_animate

### 表单
- form_builder

## 辅助类
- ListViewScrollControllerHelper

## 示例
- FormBuilderExample(form_builder_example)
- ScaffoldExample(scaffold_example)
- AdaptiveDialogExample(adaptive_dialog_example)

## 代码片段

### 创建跨平台代码
```bash
flutter create .
flutter create --platforms=android .
# [ios (default), android (default), windows (default), linux (default), macos (default), web(default)]
```

### 代码执行计时器
```dart
final stopwatch = Stopwatch()..start();
stopwatch.stop();
print(
    'Function execution time: ${stopwatch.elapsedMilliseconds} milliseconds');
```



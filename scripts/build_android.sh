#!/bin/bash

# 计时开始
start=`date +%s`

# /scripts
cd "$(dirname "$0")"

# /
cd ..

#export PUB_HOSTED_URL="https://pub.flutter-io.cn"
#export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"


echo "🚀配置代理"
export https_proxy=http://127.0.0.1:7890; export http_proxy=http://127.0.0.1:7890;

echo "🚀清理缓存"
/c/tools/fvm/fvm.bat flutter clean

echo "🚀安装依赖"
/c/tools/fvm/fvm.bat flutter pub get

echo "🚀正在编译Flutter项目..."
/c/tools/fvm/fvm.bat flutter build apk --release -v

# 检查编译是否成功
if [ $? -eq 0 ]; then
    # 读取版本号
    VERSION=$(grep 'version:' pubspec.yaml | cut -d '+' -f 1 | awk '{print $2}')
    echo "🚀项目版本号: $VERSION"


    # 读取项目名称
    PROJECT_NAME=$(grep '^name:' pubspec.yaml | awk '{print $2}')
    echo "🚀项目名称: $PROJECT_NAME"

    # 修改APK文件名
    mv build/app/outputs/apk/release/app-release.apk build/app/outputs/apk/release/${PROJECT_NAME}_$VERSION.apk
 
    # 打开包含APK文件的目录
    start 'build\\app\\outputs\\apk\\release'

    # 计时结束
    end=`date +%s`
    runtime=$((end-start))

    echo "🚀编译完成，耗时 $runtime 秒"
else
    echo "❌编译失败"
    exit 1
fi

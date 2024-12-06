#!/bin/bash
set -e

# 计时开始
start=`date +%s`

# /scripts
cd "$(dirname "$0")"

# /
cd ..


echo "🚚 开始构建 Android 项目..."
echo "📌 当前路径: $(pwd)"
# fvm 路径
FVM_CMD="/c/tools/fvm/fvm.bat"
# 读取版本号
VERSION=$(grep 'version:' pubspec.yaml | cut -d '+' -f 1 | awk '{print $2}')
echo "📌 项目版本号: $VERSION"
# 读取项目名称
PROJECT_NAME=$(grep '^name:' pubspec.yaml | awk '{print $2}')
echo "📦 项目名称: $PROJECT_NAME"
# 编译文件名
BUILD_FILE_NAME="${PROJECT_NAME}_$VERSION"
# 编译输出目录
OUTPUT_DIR="build\\app\\outputs\\apk\\release\\"


# 国内镜像
#export PUB_HOSTED_URL="https://pub.flutter-io.cn"
#export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

# 代理
echo "⚡️ 配置代理"
export https_proxy=http://127.0.0.1:7890; export http_proxy=http://127.0.0.1:7890;

echo "🚧 清理缓存"
# $FVM_CMD flutter clean > /dev/null 2>&1

echo "🍱 安装依赖"
$FVM_CMD flutter pub get > /dev/null 2>&1

echo "🚀 正在编译Flutter项目"
$FVM_CMD flutter build apk --release > /dev/null 2>&1

# 检查编译是否成功
if [ $? -eq 0 ]; then
    # 修改APK文件名
    mv ${OUTPUT_DIR}app-release.apk ${OUTPUT_DIR}${BUILD_FILE_NAME}.apk
 
    # 打开包含APK文件的目录
    start $OUTPUT_DIR

    echo "📦 输出文件名: ${BUILD_FILE_NAME}.apk"

    # 计时结束
    end=`date +%s`
    runtime=$((end-start))
    echo "🐳 编译完成，耗时 $runtime 秒"
else
    echo "❌ 编译失败"
    exit 1
fi

# 编译Flutter项目
echo "正在编译Flutter项目..."
/c/tools/fvm/fvm.bat flutter build apk --release -v

# 检查编译是否成功
if [ $? -eq 0 ]; then
    echo "编译成功"
    # 打开包含APK文件的目录
    start '..\\build\\app\\outputs\\apk\\release'
else
    echo "编译失败"
    exit 1
fi
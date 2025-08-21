import 'dart:math' as math;

StackTrace? handleStackTrace(StackTrace? stackTrace) {
  if (stackTrace != null) {
    final stackLines = stackTrace.toString().split('\n');
    if (stackLines.length > 8) {
      stackTrace = StackTrace.fromString(
          '${stackLines.take(8).join('\n')}\n... (${stackLines.length - 8} more)');
    }
  }
  return stackTrace;
}

/// 格式化文件大小为易读格式
/// 
/// [bytes] 文件大小（字节）
/// [decimals] 小数位数（默认2位）
/// [round] 是否四舍五入（默认true）
/// 
/// 返回格式化后的字符串，例如：
/// - 1024 -> "1.00 KB"
/// - 1048576 -> "1.00 MB"
/// - 1073741824 -> "1.00 GB"
String formatFileSize(int bytes, {int decimals = 2, bool round = true}) {
  if (bytes <= 0) return '0 B';
  
  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
  var i = 0;
  var size = bytes.toDouble();
  
  while (size >= 1024 && i < suffixes.length - 1) {
    size /= 1024;
    i++;
  }
  
  if (round) {
    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  } else {
    final factor = math.pow(10, decimals);
    final truncated = (size * factor).floor() / factor;
    return '${truncated.toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

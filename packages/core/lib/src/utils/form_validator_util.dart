class FormValidatorUtil {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return '必填';
    }
    return null;
  }

  static String? isServerUrl(String? value) {
    if (value == null || value.isEmpty) {
      return '必填';
    }
    try {
      final uri = Uri.parse(value);
      if (!uri.isAbsolute) {
        return '请输入有效的URL地址';
      }
      if (!uri.hasScheme) {
        return '请包含协议头(http://或https://)';
      }
      if (!['http', 'https'].contains(uri.scheme)) {
        return '仅支持http或https协议';
      }
      if (value.endsWith('/')) {
        return '请不要包含末尾的/';
      }
    } catch (e) {
      return '请输入有效的URL地址';
    }
    return null;
  }

  static String? isIp(String? value) {
    if (value == null || value.isEmpty) {
      return '必填';
    }
    final parts = value.split(':');
    if (parts.length != 2) {
      return '格式应为IP:端口';
    }

    final ip = parts[0];
    final port = parts[1];

    // IP地址校验
    if (!RegExp(r'^(\d{1,3}\.){3}\d{1,3}$').hasMatch(ip)) {
      return '请输入有效的IP地址';
    }

    // 端口校验
    if (!RegExp(r'^\d+$').hasMatch(port)) {
      return '端口号必须为数字';
    }
    final portNum = int.tryParse(port);
    if (portNum == null || portNum < 1 || portNum > 65535) {
      return '端口号范围1-65535';
    }

    return null;
  }
}

class CoreConfig {
  CoreConfig._();

  /// 网络请求超时时间
  static Duration requestClientConnectTimeout = const Duration(seconds: 10);

  /// 网络请求超时时间
  static Duration requestClientReceiveTimeout = const Duration(seconds: 30);
}

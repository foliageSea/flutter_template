class CancelToken {
  bool _isCancelled = false;

  /// 取消标记
  bool get isCancelled => _isCancelled;

  /// 重置控制器状态
  void reset() {
    _isCancelled = false;
  }

  /// 取消递归
  void cancel() {
    _isCancelled = true;
  }
}

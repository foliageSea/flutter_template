import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends FutureBuilder<T> {
  CustomFutureBuilder({
    super.key,
    required super.future,
    required AsyncWidgetBuilder<T> builder,
    super.initialData,
    Widget? loadingWidget,
    Widget? errorWidget,
    Widget? emptyWidget,
  }) : super(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingWidget ??
                  const Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.hasError) {
              return errorWidget ?? const Center(child: Text('加载出错'));
            }
            if (snapshot.hasData && snapshot.data != null) {
              return builder(context, snapshot);
            }
            return emptyWidget ?? const Center(child: Text('暂无数据'));
          },
        );

  static Widget buildRefreshButton({
    required String label,
    VoidCallback? onPressed,
  }) {
    return Center(
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.refresh),
        label: Text(label),
      ),
    );
  }
}

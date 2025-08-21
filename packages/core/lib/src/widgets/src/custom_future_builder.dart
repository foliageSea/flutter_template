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

class _DemoPage extends StatefulWidget {
  const _DemoPage();

  @override
  State<_DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<_DemoPage> {
  late Future<String?> future;

  @override
  void initState() {
    super.initState();
    future = _getData();
  }

  Future<String?> _getData() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Hello World';
  }

  @override
  Widget build(BuildContext context) {
    var errorWidget = CustomFutureBuilder.buildRefreshButton(
      label: '重新加载',
      onPressed: () {
        setState(() {
          future = _getData();
        });
      },
    );

    return Scaffold(
      body: CustomFutureBuilder<String?>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          String data = snapshot.data!;
          return Text(data);
        },
        errorWidget: errorWidget,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_template/fs_widgets/fs_future_builder.dart';
import 'package:flutter_template/pages/examples/scaffold_example/scaffold_example.dart';

class FsFutureBuilderExamplePage extends StatefulWidget {
  const FsFutureBuilderExamplePage({super.key});

  @override
  State<FsFutureBuilderExamplePage> createState() =>
      _FsFutureBuilderExamplePageState();
}

class _FsFutureBuilderExamplePageState
    extends State<FsFutureBuilderExamplePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldExample(
      title: 'FsFutureBuilderExamplePage',
      body: FsFutureBuilder(
        future: _loadData,
        build: (context, data) {
          return Column(
            children: [
              Text(data),
            ],
          );
        },
      ),
    );
  }

  Future<String> _loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    // if (Random().nextInt(2) == 1) {
    //   throw Exception('test error');
    // }
    // if (Random().nextInt(2) == 1) {
    //   throw FsFutureBuilderDataEmptyError(msg: '暂无数据');
    // }
    return 'success: data';
  }
}

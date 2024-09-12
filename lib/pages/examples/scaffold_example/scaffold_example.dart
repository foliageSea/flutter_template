import 'package:flutter/material.dart';
import 'package:fs_widgets/fs_widgets/fs_widgets.dart';

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FsAppBar(
        title: title,
      ),
      body: body,
    );
  }
}

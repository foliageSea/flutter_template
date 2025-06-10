import 'package:get/get.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const BaseLayout({
    super.key,
    required this.child,
    this.title,
    this.actions,
  });

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      loadingProgressIndeterminate: false,
      headers: <Widget>[
        AppBar(
          title: Text(widget.title ?? ""),
          leading: [
            OutlineButton(
              density: ButtonDensity.icon,
              child: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ],
          trailing: const [],
        ),
      ],
      child: widget.child,
    );
  }
}

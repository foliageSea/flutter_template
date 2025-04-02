import 'package:fluent_ui/fluent_ui.dart';

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget> actions,
  bool barrierDismissible = true,
}) async {
  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    ),
  );
}

Future<bool?> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  bool barrierDismissible = true,
}) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        Button(
          child: const Text('取消'),
          onPressed: () => Navigator.pop(context, false),
        ),
        FilledButton(
          child: const Text('确认'),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
  );
}

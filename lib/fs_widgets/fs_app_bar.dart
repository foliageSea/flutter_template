import 'package:flutter/material.dart';

class FsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FsAppBar({
    super.key,
    this.title,
    this.actions,
  });

  final Widget? title;
  final List<Widget>? actions;

  @override
  State<FsAppBar> createState() => _FsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}

class _FsAppBarState extends State<FsAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: widget.title,
      actions: widget.actions,
    );
  }
}

import 'package:flutter/material.dart';

class FSAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FSAppBar({
    super.key,
    this.title,
    this.actions,
  });

  final Widget? title;
  final List<Widget>? actions;

  @override
  State<FSAppBar> createState() => _FSAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}

class _FSAppBarState extends State<FSAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: widget.title,
      actions: widget.actions,
    );
  }
}

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/router/routesr.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
    required this.child,
    required this.shellContext,
  });

  final Widget child;
  final BuildContext? shellContext;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildNavigationView();
  }

  Widget _buildNavigationView() {
    return NavigationView(
      appBar: _buildNavigationAppBar(),
      content: widget.child,
    );
  }

  NavigationAppBar _buildNavigationAppBar() {
    return NavigationAppBar(
      automaticallyImplyLeading: false,
      title: const DragToMoveArea(
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(Global.appName),
        ),
      ),
      leading: () {
        // final enabled = widget.shellContext != null && router.canPop();

        onPressed() {
          if (router.canPop()) {
            context.pop();
            setState(() {});
          }
        }

        return NavigationPaneTheme(
          data: NavigationPaneTheme.of(context).merge(NavigationPaneThemeData(
            unselectedIconColor: WidgetStateProperty.resolveWith((states) {
              if (states.isDisabled) {
                return ButtonThemeData.buttonColor(context, states);
              }
              return ButtonThemeData.uncheckedInputColor(
                FluentTheme.of(context),
                states,
              ).basedOnLuminance();
            }),
          )),
          child: Builder(
            builder: (context) => PaneItem(
              icon: const Center(child: Icon(FluentIcons.back, size: 12.0)),
              body: const SizedBox.shrink(),
              enabled: true,
            ).build(
              context,
              false,
              onPressed,
              displayMode: PaneDisplayMode.compact,
            ),
          ),
        );
      }(),
      actions: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          WindowButtons(),
        ],
      ),
    );
  }

  @override
  void onWindowClose() async {
    exit(0);
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

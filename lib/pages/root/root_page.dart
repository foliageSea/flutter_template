import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/router/get_router.dart';
import 'package:flutter_template/router/router.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
    this.child,
    this.shellContext,
  });

  final Widget? child;
  final BuildContext? shellContext;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildNavigationView();
  }

  Widget _buildNavigationView() {
    return NavigationView(
      appBar: _buildNavigationAppBar(),
      content: GetRouterOutlet(
        initialRoute: AppPages.install,
      ),
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
      leading: Builder(
        builder: (BuildContext context) {
          onPressed() {
            if (router.canPop()) {
              context.pop();
              setState(() {});
            }
          }

          var themeData =
              NavigationPaneTheme.of(context).merge(NavigationPaneThemeData(
            unselectedIconColor: WidgetStateProperty.resolveWith((states) {
              if (states.isDisabled) {
                return ButtonThemeData.buttonColor(context, states);
              }
              return ButtonThemeData.uncheckedInputColor(
                FluentTheme.of(context),
                states,
              ).basedOnLuminance();
            }),
          ));

          return NavigationPaneTheme(
            data: themeData,
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
        },
      ),
      actions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (Platform.isWindows) const WindowButtons(),
        ],
      ),
    );
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

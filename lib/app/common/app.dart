import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/controllers/src/theme_controller.dart';
import 'package:flutter_template/app/locales/locales.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import 'global.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with AppLogMixin {
  @override
  void initState() {
    super.initState();

    PermissionUtil.getInstance().requestPermissions().catchError((e, st) {
      handle(e, st);
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeController = Get.find<ThemeController>();
    var locales = Locales();
    return CustomGetApp(
      title: '${Global.appName} ${Global.appVersion}',
      initialRoute: AppPages.initial,
      getPages: AppPages.getRoutes(),
      debugShowCheckedModeBanner: false,
      themeMode: themeController.getThemeMode(),
      theme: themeController.getThemeData(),
      darkTheme: themeController.getDarkThemeData(),
      translations: locales,
      // supportedLocales: locales.getSupportedLocales(),
      localizationsDelegates: locales.localizationsDelegates,
      builder: AppMessage().init(),
    );
  }
}

class CustomGetApp extends GetMaterialApp {
  const CustomGetApp({
    super.key,
    super.title,
    super.initialRoute,
    super.getPages,
    super.routes,
    super.debugShowCheckedModeBanner,
    super.themeMode,
    super.theme,
    super.darkTheme,
    super.translations,
    super.supportedLocales,
    super.localizationsDelegates,
    super.builder,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetMaterialController>(
      init: Get.rootController,
      dispose: (d) {
        onDispose?.call();
      },
      initState: (i) {
        Get.engine.addPostFrameCallback((timeStamp) {
          onReady?.call();
        });
        if (locale != null) Get.locale = locale;

        if (fallbackLocale != null) Get.fallbackLocale = fallbackLocale;

        if (translations != null) {
          Get.addTranslations(translations!.keys);
        } else if (translationsKeys != null) {
          Get.addTranslations(translationsKeys!);
        }

        Get.customTransition = customTransition;

        initialBinding?.dependencies();
        if (getPages != null) {
          Get.addPages(getPages!);
        }

        //Get.setDefaultDelegate(routerDelegate);
        Get.smartManagement = smartManagement;
        onInit?.call();

        Get.config(
          enableLog: enableLog ?? Get.isLogEnable,
          logWriterCallback: logWriterCallback,
          defaultTransition: defaultTransition ?? Get.defaultTransition,
          defaultOpaqueRoute: opaqueRoute ?? Get.isOpaqueRouteDefault,
          defaultPopGesture: popGesture ?? Get.isPopGestureEnable,
          defaultDurationTransition:
              transitionDuration ?? Get.defaultTransitionDuration,
        );
      },
      builder: (c) => routerDelegate != null
          ? _buildRouterMaterialApp(c)
          : _buildMaterialApp(c),
    );
  }

  Widget _buildMaterialApp(GetMaterialController c) {
    var materialApp = MaterialApp(
      key: c.unikey,
      navigatorKey: (navigatorKey == null
          ? Get.key
          : Get.addKey(navigatorKey!)),
      scaffoldMessengerKey: scaffoldMessengerKey ?? c.scaffoldMessengerKey,
      home: home,
      routes: routes ?? const <String, WidgetBuilder>{},
      initialRoute: initialRoute,
      onGenerateRoute: (getPages != null ? generator : onGenerateRoute),
      onGenerateInitialRoutes: (getPages == null || home != null)
          ? onGenerateInitialRoutes
          : initialRoutesGenerate,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers:
          (navigatorObservers == null
                ? <NavigatorObserver>[GetObserver(routingCallback, Get.routing)]
                : <NavigatorObserver>[GetObserver(routingCallback, Get.routing)]
            ..addAll(navigatorObservers!)),
      builder: defaultBuilder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: c.theme ?? theme ?? ThemeData.fallback(),
      darkTheme: c.darkTheme ?? darkTheme ?? theme ?? ThemeData.fallback(),
      themeMode: c.themeMode ?? themeMode,
      locale: Get.locale ?? locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowMaterialGrid: debugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      scrollBehavior: scrollBehavior,
      // useInheritedMediaQuery: useInheritedMediaQuery,
      //   actions: actions,
    );
    return materialApp;
  }

  Widget _buildRouterMaterialApp(GetMaterialController c) {
    return MaterialApp.router(
      routerDelegate: routerDelegate!,
      routeInformationParser: routeInformationParser!,
      backButtonDispatcher: backButtonDispatcher,
      routeInformationProvider: routeInformationProvider,
      key: c.unikey,
      builder: defaultBuilder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: c.theme ?? theme ?? ThemeData.fallback(),
      darkTheme: c.darkTheme ?? darkTheme ?? theme ?? ThemeData.fallback(),
      themeMode: c.themeMode ?? themeMode,
      locale: Get.locale ?? locale,
      scaffoldMessengerKey: scaffoldMessengerKey ?? c.scaffoldMessengerKey,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowMaterialGrid: debugShowMaterialGrid,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      scrollBehavior: scrollBehavior,
      // useInheritedMediaQuery: useInheritedMediaQuery,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/request.dart';
import 'package:flutter_template/widgets/global_error.dart';
import 'package:flutter_template/widgets/global_loading.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global.g.dart';

@riverpod
class Global extends _$Global {
  /// 应用名称
  static const String appName = 'flutter_template';

  @override
  FutureOr<void> build() async {
    await Future.delayed(const Duration(seconds: 1));
    Request();
  }
}

class EagerInitialization extends ConsumerWidget {
  const EagerInitialization({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var global = ref.watch(globalProvider);

    var widget = global.when(
      data: (data) => child,
      error: (err, st) => GlobalError(err, st),
      loading: () => const GlobalLoading(),
    );

    return Scaffold(
      body: Center(child: widget),
    );
  }
}

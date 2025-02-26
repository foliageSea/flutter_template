import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/app.dart';
import 'package:flutter_template/utils/custom_provider_observer.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        CustomProviderObserver(),
      ],
      child: const MainApp(),
    ),
  );
}



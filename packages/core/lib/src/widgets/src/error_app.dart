import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ErrorApp extends StatelessWidget {
  final dynamic error;
  final StackTrace? stackTrace;

  const ErrorApp({
    super.key,
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('启动异常'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 120,
              ),
              Text(
                "$error",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${handleStackTrace(stackTrace)}",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ].insertSizedBoxBetween(height: 8),
          ),
        ),
      ),
    );
  }
}

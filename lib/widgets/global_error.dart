import 'package:flutter/material.dart';

class GlobalError extends StatelessWidget {
  const GlobalError(this.err, this.st, {super.key});

  final Object err;
  final StackTrace st;

  @override
  Widget build(BuildContext context) {
    return Text('$err');
  }
}

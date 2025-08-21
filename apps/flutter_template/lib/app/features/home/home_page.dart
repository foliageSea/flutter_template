import 'package:flutter/material.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(title: 'Home', child: Container());
  }
}

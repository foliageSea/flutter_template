import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web Admin'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: NavigationDrawer(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Admin Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('首页'),
            onTap: () {
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.data_array),
            title: const Text('数据管理'),
            onTap: () {
              context.go('/data');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('应用信息'),
            onTap: () {
              context.go('/info');
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '欢迎使用 Flutter Web Admin',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '这是一个内嵌的管理界面',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
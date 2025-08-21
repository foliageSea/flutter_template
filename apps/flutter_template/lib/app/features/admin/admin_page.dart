import 'package:flutter/material.dart';
import 'package:http_server/http_server.dart' as server;
import 'package:url_launcher/url_launcher.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String? _serverUrl;

  @override
  void initState() {
    super.initState();
    _updateServerStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateServerStatus() {
    setState(() {
      _serverUrl = server.Server.serverUrl;
    });
  }

  Future<void> _startServer() async {
    try {
      await server.Server.start(webPath: 'packages/flutter_web/build/web');

      _updateServerStatus();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('启动服务器失败: $e')));
      }
    }
  }

  Future<void> _stopServer() async {
    await server.Server.stop();
    _updateServerStatus();
  }

  Future<void> _openWebAdmin() async {
    final url = _serverUrl;
    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('无法打开管理界面')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('应用管理后台')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '内嵌Web服务',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: server.Server.isRunning
                              ? null
                              : _startServer,
                          child: const Text('启动服务'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: server.Server.isRunning
                              ? _stopServer
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('停止服务'),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          server.Server.isRunning ? '运行中' : '已停止',
                          style: TextStyle(
                            color: server.Server.isRunning
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_serverUrl != null) ...[
                      Text('访问地址: $_serverUrl'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _openWebAdmin,
                        child: const Text('打开管理界面'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '使用说明',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. 点击"启动服务"按钮启动内嵌的HTTP服务器',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '2. 服务启动后，点击"打开管理界面"进入Web管理后台',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '3. 管理界面提供数据查看、应用信息等功能',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '4. 使用完毕后可以点击"停止服务"关闭服务器',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

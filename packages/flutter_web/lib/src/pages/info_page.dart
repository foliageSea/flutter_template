import 'package:flutter/material.dart';
import '../services/api_service.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _info;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    try {
      final info = await _apiService.fetchInfo();
      setState(() {
        _info = info;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载信息失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('应用信息'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _info == null
              ? const Center(child: Text('无法加载应用信息'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.apps),
                            title: const Text('应用名称'),
                            subtitle: Text(_info!['appName'] ?? '未知'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.numbers),
                            title: const Text('版本号'),
                            subtitle: Text(_info!['version'] ?? '未知'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.devices),
                            title: const Text('平台'),
                            subtitle: Text(_info!['platform'] ?? '未知'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
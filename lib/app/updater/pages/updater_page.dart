import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:flutter_template/core/logger/logger.dart';
import 'package:get/get.dart';

import '../updater.dart';

class UpdaterPage extends StatefulWidget {
  const UpdaterPage({super.key, required this.data});

  final UpdaterData data;

  @override
  State<UpdaterPage> createState() => _UpdaterPageState();
}

class _UpdaterPageState extends State<UpdaterPage> {
  UpdaterAble updater = UpdaterAble.getInstance();

  @override
  void initState() {
    super.initState();
    updater.updateStatus = true;
    updater.provider.updateMessage('');
    _startUpdate();
  }

  @override
  void dispose() {
    updater.updateStatus = false;
    super.dispose();
  }

  Future _startUpdate() async {
    try {
      var r = await updater.downloadUpdate(widget.data);
      if (r != true) {
        return;
      }
      await updater.installUpdate();
    } catch (e, st) {
      AppLogger().handle(e, st);
      await _delayedClose();
    }
  }

  Future _delayedClose() async {
    updater.provider.updateMessage('更新失败, 5秒后关闭该页面');
    await Future.delayed(const Duration(seconds: 5));
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: BaseLayout(
        title: "Updater",
        child: NotificationListener(
          child: _buildPage(),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('确认离开'),
            content: const Text('您确定要离开此页面吗？'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  updater.cancelToken?.cancel();

                  Navigator.of(context).pop(true);
                },
                child: const Text('确定'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 32),
          _buildProgress(),
          const SizedBox(height: 16),
          _buildProgressNumber(),
          const SizedBox(height: 16),
          _buildMessage(),
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return ValueListenableBuilder<String>(
      valueListenable: updater.provider.message,
      builder: (context, value, _) {
        return Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  Text _buildTitle() {
    return const Text(
      'UPDATE',
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProgress() {
    return ValueListenableBuilder<double>(
      valueListenable: updater.provider.progress,
      builder: (context, value, _) {
        return SizedBox(
          height: 1,
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressNumber() {
    return ValueListenableBuilder<double>(
      valueListenable: updater.provider.progress,
      builder: (context, value, _) {
        return Text(
          '${(value * 100).toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 16),
        );
      },
    );
  }
}

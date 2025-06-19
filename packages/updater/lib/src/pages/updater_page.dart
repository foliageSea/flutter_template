import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../updater.dart';

class UpdaterPage extends StatefulWidget {
  const UpdaterPage({super.key, required this.data});

  final UpdaterData data;

  @override
  State<UpdaterPage> createState() => _UpdaterPageState();
}

class _UpdaterPageState extends State<UpdaterPage> with AppLogMixin {
  Updater updater = Updater.getInstance();

  late UpdaterPageController controller;

  @override
  void initState() {
    super.initState();
    controller = updater.controller;
    updater.updateStatus = true;
    controller.reset();
    _startUpdate();
  }

  @override
  void dispose() {
    updater.updateStatus = false;
    super.dispose();
  }

  Future _startUpdate() async {
    try {
      await updater.downloadUpdate(widget.data);
      await updater.installUpdate();
    } catch (_) {
      // AppLogger().handle(e, st);
      await _delayedClose();
    }
  }

  Future _delayedClose() async {
    warning('更新失败, 5秒后关闭该页面');
    controller.updateMessage('更新失败, 5秒后关闭该页面');
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Updater'),
        ),
        body: NotificationListener(
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
                  warning('用户取消更新');
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
          const SizedBox(height: 16),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return ValueListenableBuilder<String>(
      valueListenable: controller.message,
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
      valueListenable: controller.progress,
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
      valueListenable: controller.progress,
      builder: (context, value, _) {
        return Text(
          '${(value * 100).toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 16),
        );
      },
    );
  }

  Widget _buildButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.finish,
      builder: (BuildContext context, bool value, Widget? child) {
        if (!value) {
          return Container();
        }

        return FilledButton(
          onPressed: () async {
            await updater.installUpdate();
          },
          child: Text('开始安装'),
        );
      },
    );
  }
}

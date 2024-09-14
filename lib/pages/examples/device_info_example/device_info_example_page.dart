import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/services/device_info_service.dart';
import 'package:get/get.dart';

class DeviceInfoExamplePage extends StatefulWidget {
  const DeviceInfoExamplePage({super.key});

  @override
  State<DeviceInfoExamplePage> createState() => _DeviceInfoExamplePageState();
}

class _DeviceInfoExamplePageState extends State<DeviceInfoExamplePage> {
  final DeviceInfoService deviceInfoService = Get.find();

  late Rx<AndroidDeviceInfo> deviceInfo;

  @override
  void initState() {
    super.initState();
    deviceInfo = deviceInfoService.androidInfo.obs;
    deviceInfo.refresh();
    talker.info(deviceInfo.value.version.baseOS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设备信息'),
      ),
      body: Obx(
        () => ListView(
          children: [
            ListTile(
              title: const Text('安卓版本'),
              subtitle: Text(deviceInfo.value.version.release),
            ),
            ListTile(
              title: const Text('SDK版本'),
              subtitle: Text('${deviceInfo.value.version.sdkInt}'),
            ),
            ListTile(
              title: const Text('品牌'),
              subtitle: Text(deviceInfo.value.brand),
            ),
            ListTile(
              title: const Text('分辨率'),
              subtitle: Text(
                  '${deviceInfo.value.displayMetrics.widthPx}*${deviceInfo.value.displayMetrics.heightPx}'),
            ),
            ListTile(
              title: const Text('模拟器'),
              subtitle: Text(deviceInfo.value.isPhysicalDevice ? '否' : '是'),
            ),
          ],
        ),
      ),
    );
  }
}

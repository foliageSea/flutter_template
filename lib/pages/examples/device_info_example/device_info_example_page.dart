import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/logs/log.dart';
import 'package:flutter_template/services/device_info_service.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

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
        () => TDCellGroup(
          scrollable: true,
          theme: TDCellGroupTheme.cardTheme,
          cells: [
            TDCell(
              title: '安卓版本',
              description: deviceInfo.value.version.release,
            ),
            TDCell(
              title: 'SDK版本',
              description: '${deviceInfo.value.version.sdkInt}',
            ),
            TDCell(
              title: '品牌',
              description: deviceInfo.value.brand,
            ),
            TDCell(
              title: '分辨率',
              description:
                  '${deviceInfo.value.displayMetrics.widthPx}*${deviceInfo.value.displayMetrics.heightPx}',
            ),
            TDCell(
              title: '模拟器',
              description: deviceInfo.value.isPhysicalDevice ? '否' : '是',
            ),
          ],
        ),
      ),
    );
  }
}

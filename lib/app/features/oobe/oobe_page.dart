import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/common/global.dart';
import 'package:flutter_template/app/layouts/base_layout.dart';
import 'package:flutter_template/db/db.dart';
import 'package:flutter_template/db/mappers/server_mapper.dart';

class OobePage extends StatefulWidget {
  const OobePage({super.key});

  @override
  State<OobePage> createState() => _OobePageState();
}

class _OobePageState extends State<OobePage> with AppLogMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Oobe',
      child: FilledButton(
        onPressed: () {
          var serverMapper = ServerMapper(Global.db);
          var companion = ServerEntityCompanion.insert(
              url: '123', type: 1, username: '123', password: '123');
          serverMapper.add(companion).then((value) {
            log('插入成功');
          });
        },
        child: const Text('插入'),
      ),
    );
  }
}

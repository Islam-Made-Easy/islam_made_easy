import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class Prerequisite extends StatefulWidget {
  @override
  _PrerequisiteState createState() => _PrerequisiteState();
}

class _PrerequisiteState extends State<Prerequisite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

Future<bool> hasSupport() async {
  final deviceInfo = DeviceInfoPlugin();
  bool hasSupport = false;
  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    hasSupport = int.parse(iosInfo.systemVersion.split('.').first) >= 11;
  } else if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    hasSupport = androidInfo.version.sdkInt >= 21;
  }
  return hasSupport;
}

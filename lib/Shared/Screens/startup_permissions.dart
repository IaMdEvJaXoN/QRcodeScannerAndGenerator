import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proscan/Core/Utils/scanQr_utils/camera_permission_check.dart';
import 'package:proscan/Shared/Screens/appshell.dart';
import 'package:proscan/Shared/Screens/permissions_screen.dart';

class StartupGate extends StatefulWidget {
  const StartupGate({super.key});

  @override
  State<StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends State<StartupGate> {
  bool? _hasPermission;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    if (kIsWeb) {
      setState(() {
        _hasPermission = true;
      });

      return;
    }
    if (Platform.isAndroid) {
      final status = await CameraPermissionCheck.checkStatus();
      if (!mounted) return;
      setState(() {
        _hasPermission = status.isGranted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasPermission == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_hasPermission == true) {
      return const Appshell();
    } else {
      return CameraPermissionScreen(
        onPermissionGranted: () {
          setState(() => _hasPermission = true);
        },
      );
    }
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:videostitch/widgets/CameraView/camera_view.dart';

class CameraScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraView(cameras),
    );
  }
}

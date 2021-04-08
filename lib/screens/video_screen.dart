import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:videostitch/widgets/VideoView/video_view.dart';

class VideoScreen extends StatelessWidget {
  final XFile video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoView(),
    );
  }
}

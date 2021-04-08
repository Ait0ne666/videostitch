import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final XFile file;

  VideoView(this.file);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController _videoController;
  VoidCallback videoPlayerListener;

  void startVideo() async {
    try {
      VideoPlayerController vController =
          VideoPlayerController.file(File(widget.file.path));

      videoPlayerListener = () {
        if (_videoController != null && _videoController.value.size != null) {
          // Refreshing the state to update video player with the correct ratio.
          if (mounted) setState(() {});
          _videoController.removeListener(videoPlayerListener);
        }
      };
      vController.addListener(videoPlayerListener);

      await vController.setLooping(false);
      await vController.initialize();
      if (_videoController != null) {
        await _videoController.dispose();
      }
      if (mounted) {
        setState(() {
          _videoController = vController;
        });
      }
      await vController.play();
    } catch (error) {}
  }

  void stopVideo() {
    if (_videoController != null && _videoController.value.isPlaying) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : Container(),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videostitch/bloc/video/video_bloc.dart';
import 'package:videostitch/bloc/video/video_event.dart';
import 'package:videostitch/widgets/CameraView/CameraOverlay/camera_overlay.dart';

class CameraView extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraView(this.cameras);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController _controller;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.max,
    );
    _controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startVideoRecording(BuildContext context) async {
    final CameraController cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('no camera'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  void stopVideoRecording(BuildContext context) async {
    final CameraController cameraController = _controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      setState(() {
        isRecording = false;
      });
      return null;
    }

    try {
      var videofile = await cameraController.stopVideoRecording();

      setState(() {
        isRecording = false;
      });

      if (videofile != null) {
        BlocProvider.of<VideoBloc>(context).add(
          AddVideo(videofile),
        );
      }

      Navigator.of(context).pop();
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = _controller.value.previewSize.height;

    // Modify the yScale if you are in Landscape
    final double scale = size.height / height + 0.05;

    print(scale);
    return Stack(
      children: [
        _controller == null || !_controller.value.isInitialized
            ? Container()
            : Container(
                child: Center(
                  child: Transform.scale(
                    scale: scale,
                    child: CameraPreview(
                      _controller,
                    ),
                  ),
                ),
              ),
        CameraOverlay(
          isRecording: isRecording,
          startRecording: startVideoRecording,
          stopRecording: stopVideoRecording,
        )
      ],
    );
  }
}

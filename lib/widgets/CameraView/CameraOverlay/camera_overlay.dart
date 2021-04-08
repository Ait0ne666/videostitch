import 'package:flutter/material.dart';

class CameraOverlay extends StatelessWidget {
  final Function startRecording;
  final Function stopRecording;
  final bool isRecording;

  CameraOverlay({this.isRecording, this.startRecording, this.stopRecording});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isRecording
                  ? IconButton(
                      icon: Icon(Icons.pause_circle_outline),
                      onPressed: () => stopRecording(context),
                      iconSize: 80,
                      color: Colors.red,
                    )
                  : IconButton(
                      icon: Icon(Icons.play_arrow_rounded),
                      onPressed: () => startRecording(context),
                      iconSize: 80,
                      color: Colors.red,
                    )
            ],
          )
        ],
      ),
    );
  }
}

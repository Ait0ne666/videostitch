import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videostitch/bloc/video/video_bloc.dart';
import 'package:videostitch/bloc/video/video_event.dart';
import 'package:videostitch/bloc/video/video_state.dart';

class MainView extends StatelessWidget {
  List<Widget> buildVideoList(List<XFile> files, BuildContext context) {
    return files.map((e) {
      return Row(
        children: [
          Text(e.name),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.play_arrow), onPressed: () => playVideo(e)),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => removeVideo(e, context)),
            ],
          )
        ],
      );
    }).toList();
  }

  void removeVideo(XFile file, BuildContext context) {
    BlocProvider.of<VideoBloc>(context).add(
      RemoveVideo(file.name),
    );
  }

  void playVideo(XFile file) {}

  void goToCamera(BuildContext context) {
    Navigator.of(context).pushNamed('/camera');
  }

  void uploadFiles(List<XFile> files) {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(25),
        width: double.infinity,
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: buildVideoList(state.videos, context),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () => goToCamera(context),
                    child: Text('Camera'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () => uploadFiles(state.videos),
                    child: Text('Upload'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videostitch/bloc/video/video_event.dart';
import 'package:videostitch/bloc/video/video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  List<XFile> videos = [];

  VideoBloc() : super(VideosLoaded([]));

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    if (event is AddVideo) {
      videos.add(event.file);
      yield VideosLoaded([...videos]);
    } else if (event is RemoveVideo) {
      int indexToRemove =
          videos.indexWhere((element) => element.name == event.name);
      if (indexToRemove != -1) {
        videos.removeAt(indexToRemove);
      }
      yield VideosLoaded([...videos]);
    }
  }
}

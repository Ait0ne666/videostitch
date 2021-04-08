import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class VideoState extends Equatable {
  final List<XFile> videos;

  VideoState(this.videos);

  @override
  List<Object> get props => [videos];
}

class VideosLoaded extends VideoState {
  final List<XFile> videos;

  VideosLoaded(this.videos) : super(videos);
}

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class VideoEvent extends Equatable {
  VideoEvent();

  @override
  List<Object> get props => [];
}

class AddVideo extends VideoEvent {
  final XFile file;

  AddVideo(this.file);

  @override
  List<Object> get props => [file];
}

class RemoveVideo extends VideoEvent {
  final String name;

  RemoveVideo(this.name);

  @override
  List<Object> get props => [name];
}

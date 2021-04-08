import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videostitch/bloc/video/video_bloc.dart';
import 'package:videostitch/screens/camera_screen.dart';
import 'package:videostitch/screens/main_screen.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VideoBloc videoBloc;

  @override
  void initState() {
    super.initState();
    videoBloc = VideoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoBloc>(
      create: (context) => videoBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/camera': (context) => CameraScreen(cameras)
        },
      ),
    );
  }
}

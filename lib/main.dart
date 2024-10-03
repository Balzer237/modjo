import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Blocs/PlayAudioBloc.dart';
import 'Blocs/getListAudio.dart';
import 'Service/SongService.dart';
import 'Themes/Theme.dart';
import 'IU/HomePage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  AudioPlayer audioPlayer = AudioPlayer();
  SongService songService = SongService(audioPlayer);
  runApp( MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>GetListAudioBloc(songService)..add(getSong())),
        BlocProvider(create: (context)=>PlayAudioBloc(songService))
      ],
      child: MyApp(songService: songService, audioPlayer: audioPlayer,)));
}

class MyApp extends StatefulWidget {
  MyApp({super.key,required this.songService,required this.audioPlayer});
  AudioPlayer  audioPlayer;
  SongService songService;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
    getPermission();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        /*routes: {
        '/crieSong':(context)=>Criesongartistepage()
      },*/
        title: 'Flutter Demo',
        theme:  DarckTheme,
        home:  MyHomePage(audioPlayer: widget.audioPlayer, songService: widget.songService,));
  }
}
Future<void> getPermission()async{
  var value = await Permission.storage.status;
  if(!value.isGranted){
    await Permission.storage.request();
    if(!value.isGranted){

    }
  }
}



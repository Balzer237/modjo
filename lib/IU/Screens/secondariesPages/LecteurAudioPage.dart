import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../../../Blocs/PlayAudioBloc.dart';
import '../../../Models/SongModel.dart';

class Lecteuraudiopage extends StatefulWidget {
  Lecteuraudiopage({super.key,required this.audioPlayer});

  AudioPlayer audioPlayer =AudioPlayer();
  @override
  State<Lecteuraudiopage> createState() => _LecteuraudiopageState();
}

class _LecteuraudiopageState extends State<Lecteuraudiopage> {
  OnAudioQuery onAudioQuery=OnAudioQuery();
  late List<songModel> song=[];
  Future<List<songModel>?> getAllSong()async{
    List songs= await onAudioQuery.querySongs();
    return song = songs.map((song){
      return songModel(title:song.title, artist:song.artist, duration:song.duration, uri:song.uri, album: song.album);
    }).toList();
  }

  int index=0 ;
  double _position=0;
  double _duration=0;

  @override
  void initState(){
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    getAllSong();

    widget.audioPlayer.positionStream.listen((position){
      setState(() {
        _position=position.inSeconds.toDouble();
      });
    });
    widget.audioPlayer.durationStream.listen((duration){
      setState(() {
        _duration = duration!.inSeconds.toDouble();
      });
    });
    widget.audioPlayer.currentIndexStream.listen((index1){
      setState(() {
        index = index1!;
      });
    });


  }
  String formatTime(double value){
    int minute =(value/60).truncate();
    int seconde = (value % 60).truncate();
    return '${minute.toString().padRight(2)}:${seconde.toString().padLeft(2)}';
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;


    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: song.isEmpty?const Text("je suis vide"):Text("${song[index].title}",maxLines: 1,),
        ),
        body:Stack(
          children: [
            Container(
                height: height,
                width:  width,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/disc.jpg"),fit: BoxFit.cover)
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18,sigmaY: 18),
                  child: Container(),
                )
            ),
            Positioned(
                top: 0.0,
                child: Container(
                  width: width,
                  height: height*0.70,
                  decoration: const BoxDecoration(
                      color: Colors.transparent
                  ),
                  child: Center(
                      child: Card(
                        elevation: 8,
                        child: Container(
                          height: height*0.30,
                          width: width*0.85,
                          decoration: BoxDecoration(
                              image: const DecorationImage(image:AssetImage("assets/images/disc.jpg"),fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      )
                  ),
                )
            ),
            Positioned(
                bottom:0.0,
                child: Container(
                    color: Colors.transparent,
                    height:height*0.30,
                    width: MediaQuery.sizeOf(context).width,
                    child: _column()
                )
            )
          ],
        )
    );
  }
  Widget _column(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatTime(_position)),
            Expanded(
              child: Slider(
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  thumbColor: Colors.white,
                  value: _position,
                  max: _duration,
                  onChanged: (position){
                    widget.audioPlayer.seek(Duration(seconds:  position.toInt()));
                    //context.read<PlayAudioBloc>()..add(audioSeek(position));
                  }),

            ),
            Text(formatTime(_duration))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              widget.audioPlayer.loopMode;
            }, icon: const Icon(Icons.repeat)),
            IconButton(onPressed: (){
              context.read<PlayAudioBloc>().add(audioPlay(index: (index-1)%song.length, song: (song[(index-1)%song.length])));

            }, icon: const Icon(Icons.skip_previous)),

            BlocBuilder<PlayAudioBloc,PlayAudioState>(
                builder: (context,state){
                  if(state is audioPlaying){
                    return IconButton(onPressed: (){
                      context.read<PlayAudioBloc>().add(audioPause());
                    }, icon: const Icon(Icons.pause));
                  }else if(state is audioPaused){
                    return IconButton(onPressed: (){
                      context.read<PlayAudioBloc>().add(audioResume(song: song[index], index:index));
                    }, icon: const Icon(Icons.play_arrow));
                  }return  const Icon(Icons.play_arrow);
                }
            ),
            /*widget.audioPlayer.playing? IconButton(onPressed: (){
                  widget.audioPlayer.pause();
                }, icon: Icon(Icons.pause)):IconButton(onPressed: (){
                  widget.audioPlayer.play();
                }, icon: Icon(Icons.play_arrow)),*/

            IconButton(onPressed: (){
              context.read<PlayAudioBloc>().add(audioPlay(index: (index+1)%song.length, song: (song[(index+1)%song.length])));
            }, icon: const Icon(Icons.skip_next)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.menu_outlined))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_outlined,)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined))
          ],
        )
      ],
    );
  }
}



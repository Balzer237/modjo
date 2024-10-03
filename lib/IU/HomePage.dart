import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Blocs/PlayAudioBloc.dart';
import '../Models/SongModel.dart';
import '../Service/SongService.dart';
import 'Screens/AlbumPage.dart';
import 'Screens/ArtistPage.dart';
import 'Screens/ListAudioPage.dart';
import 'Screens/TitleAudioPage.dart';
import 'Screens/secondariesPages/LecteurAudioPage.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({super.key,required this.audioPlayer,required this.songService});
  AudioPlayer audioPlayer = AudioPlayer();
  SongService songService;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  OnAudioQuery onAudioQuery=OnAudioQuery();
  late List<songModel> song=[];
  Future<List<songModel>?> getAllSong()async{
    List songs= await onAudioQuery.querySongs();
    return song = songs.map((song){
      return songModel(title:song.title, artist:song.artist, duration:song.duration, uri:song.uri, album: song.album);
    }).toList();
  }

  @override
  void initState(){
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    getAllSong();
  }

  @override
  Widget build(BuildContext context) {

    TabController tabController = TabController(length: 4, vsync: this);
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu_rounded)),
          title: const Text("Modjo"),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.search))
          ],
          bottom: TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: "List",),
                Tab(text: "Titles",),
                Tab(text: "Artists",),
                Tab(text: "Albums",)
              ]),
        ),
        body: TabBarView(
            controller: tabController,
            children: const [
              Listaudiopage(),
              Titleaudiopage(),
              Artistpage(),
              Albumpage(),
            ]),

        bottomNavigationBar: BlocBuilder<PlayAudioBloc,PlayAudioState>(
            builder: (context,state){
              if(state is audioPlaying){
                return Container(
                  height: 60,
                  color: Colors.white24,
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Lecteuraudiopage(audioPlayer: widget.audioPlayer)));
                    },
                    leading: const CircleAvatar(),
                    title: Text("${song[widget.audioPlayer.currentIndex!].title}",maxLines: 1,),
                    subtitle: Text("${song[widget.audioPlayer.currentIndex!].artist}",maxLines: 1,),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){context.read<PlayAudioBloc>().add(audioStop());}, icon: const Icon(Icons.close,size: 30,)),
                        IconButton(onPressed: (){context.read<PlayAudioBloc>().add(audioPause());}, icon: const Icon(Icons.pause,size: 30,)),
                        IconButton(onPressed: (){context.read<PlayAudioBloc>().add(audioPlay(index: (widget.audioPlayer.currentIndex!+1)%song.length, song: (song[(widget.audioPlayer.currentIndex!+1)%song.length])));}, icon: const Icon(Icons.skip_next,size: 30,))

                      ],),
                  ),
                );
              }else if(state is audioPaused){
                return Container(
                  height: 60,
                  color: Colors.white24,
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Lecteuraudiopage(audioPlayer: widget.audioPlayer)));
                    },
                    leading: const CircleAvatar(),
                    title: Text("${song[widget.audioPlayer.currentIndex!].title}",maxLines: 1,),
                    subtitle: Text("${song[widget.audioPlayer.currentIndex!].artist}",maxLines: 1,),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){context.read<PlayAudioBloc>().add(audioStop());}, icon: const Icon(Icons.close,size: 30,)),
                        IconButton(onPressed: (){context.read<PlayAudioBloc>().add(audioResume(index: widget.audioPlayer.currentIndex!, song: song[widget.audioPlayer.currentIndex!]));}, icon: const Icon(Icons.play_arrow,size: 30,)),
                        IconButton(onPressed: (){context.read<PlayAudioBloc>().add(audioPlay(index: (widget.audioPlayer.currentIndex!+1)%song.length, song: (song[(widget.audioPlayer.currentIndex!+1)%song.length])));}, icon: const Icon(Icons.skip_next,size: 30,))

                      ],),
                  ),
                );
              }else {
                return Container(
                  height: 0.0,
                  color: Colors.white24,
                );
              }
              return Container(
                height: 10,
              );
            }
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Blocs/PlayAudioBloc.dart';
import '../../../Blocs/getListAudio.dart';
import '../../../Models/SongModel.dart';

class Criesongartistepage extends StatelessWidget {
  Criesongartistepage({super.key,required this.nomArtiste});

  String nomArtiste;
  @override
  Widget build(BuildContext context) {
    List<songModel> songs=[];
    return BlocBuilder<GetListAudioBloc,audioState>(
        builder: (context,state){
          if(state is audioLoading){
            return const CircularProgressIndicator();
          }else if(state is audioLoaded){
            songs.addAll(state.song.where((element)=>element.artist!.contains(nomArtiste)));
            return  Scaffold(
              appBar: AppBar(),
              body: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context,index) {
                    return ListTile(
                      onTap: (){
                        context.read<PlayAudioBloc>().add(audioPlay(index: index, song: state.song[index]));
                      },
                      title: Text("${songs[index].title}",maxLines: 2,),
                      subtitle: Text("${songs[index].artist}"),
                    );
                  }),
            );
          }
          return Container();
        }
    );
  }
}

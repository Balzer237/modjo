import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Blocs/PlayAudioBloc.dart';
import '../../Blocs/getListAudio.dart';

class Titleaudiopage extends StatelessWidget {
  const Titleaudiopage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: BlocBuilder<GetListAudioBloc,audioState>(
          builder: (context,state){
            if(state is audioLoading){
              return const Center(child: CircularProgressIndicator(),);
            }else if(state is audioLoaded){
              if(state.song.isEmpty){
               return const Center(child: Text("Aucun audio pour le moment",style: TextStyle(color: Colors.white),),);
              }else{
                return  ListView.builder(
                    itemCount: state.song.length,
                    itemBuilder: (context,index) {
                      return ListTile(
                        onTap: (){
                          context.read<PlayAudioBloc>().add(audioPlay(index: index, song: state.song[index]));
                        },
                        title: Text("${state.song[index].title}"),
                        subtitle: Text("${state.song[index].artist}"),
                      );
                    });}
            }else if(state is audioError){
              return Center(child: Text(state.message,style: const TextStyle(color: Colors.white),),);
            }
            return Container();
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Blocs/getListAudio.dart';

class Albumpage extends StatelessWidget {
  const Albumpage({super.key});



  @override
  Widget build(BuildContext context) {
    List<String> filterAlbum=[];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<GetListAudioBloc,audioState>(
          builder: (context,state){
            if(state is audioLoading){
              return const Center(child: CircularProgressIndicator(),);
            }else if(state is audioLoaded){
              if(state.song.isEmpty){
                return const Center(child: Text("Aucun audio pour le moment",style: TextStyle(color: Colors.white),),);
              }else{

                for(int i=0;i<state.song.length;i++){
                  if(!filterAlbum.contains(state.song[i].album)){
                    filterAlbum.add(state.song[i].album.toString());
                  }
                }
                return Scaffold(
                  body: GridView.builder(
                    itemCount: filterAlbum.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Criesongartistepage (nomArtiste: filterSong[index])));
                            },
                            child: Card(
                              elevation:4,
                              child:Container(height: 120,width: 120,decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),image: const DecorationImage(image: AssetImage('assets/images/disc.jpg',),fit: BoxFit.cover)),),
                            ),
                          ),
                          Text(filterAlbum[index],maxLines: 1,),
                        ],

                      );
                    }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                  ),
                );
              }
            }else if(state is audioError){
              return Center(child: Text(state.message,style: const TextStyle(color: Colors.white),),);
            }
            return Container();
          }),
    );
  }
}

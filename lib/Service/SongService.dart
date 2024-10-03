
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../Models/SongModel.dart';


class SongService{
  SongService( this.audioPlayer);
  final OnAudioQuery onAudioQuery =OnAudioQuery();
  final AudioPlayer audioPlayer;

  List<SongModel> songs=[];

  //on recupere la liste de songs present dans le stockage de l'utilisateur
  Future<List<songModel>?> getAllSong()async{
    songs= await onAudioQuery.querySongs();
    getSource(songs, audioPlayer); // on map la liste d'uri dans l'audioPlayer
    return songs.map((song){
      return songModel(title:song.title, artist:song.artist, duration:song.duration, uri:song.uri, album:song.album);
    }).toList();

  }
  // on prepare les operations asynchrones pour le bloc(PlayAudioBloc)
  Future<void> playAudio(int index)async{
    await audioPlayer.seek(Duration.zero, index:index );
    await audioPlayer.play();
  }
  Future<void> resumeAudio()async{
    await audioPlayer.play();
  }
  Future<void> pauseAudio()async{
    await audioPlayer.pause();
  }
  Future<void> stopAudio()async{
    await audioPlayer.stop();
  }
  Future<void> seekAudio(double position)async{

    await audioPlayer.seek(Duration(seconds:  position.toInt()));
  }
  Future<void> nextAudio()async{
    await audioPlayer.seekToNext();
  }
  Future<void> previousAudio()async{

    await audioPlayer.seekToPrevious();
  }

}
Future<void> getSource(List<SongModel> songs,AudioPlayer audioPlayer)async{
  List<String?> uri = songs.map((song)=> song.uri).toList();
  List<AudioSource> source  =uri.map((element)=> AudioSource.uri(Uri.parse(element!))).toList();
  await audioPlayer.setAudioSource(
    ConcatenatingAudioSource(
      children: source,
    ),
  );
}




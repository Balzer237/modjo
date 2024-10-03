import 'package:bloc/bloc.dart';
import '../Models/SongModel.dart';
import '../Service/SongService.dart';


// liste d'evenement
class PlayAudioEvent{}

class audioPause extends PlayAudioEvent{}
class audioPlay extends PlayAudioEvent{
  int index;
  songModel song;

  audioPlay({required this.index,required this.song});
}
class audioResume extends PlayAudioEvent{
  songModel song;
  int index;

  audioResume({required this.index,required this.song});
}
class audioStop extends PlayAudioEvent{}
class audioSeek extends PlayAudioEvent{
  double position;

  audioSeek(this.position);
}
class audioNext extends PlayAudioEvent{}
class audioPrevious extends PlayAudioEvent{}

//liste d'etat
class PlayAudioState{}
class audioPaused extends PlayAudioState{}
class audioPlaying extends PlayAudioState{
  songModel song;
  int index;
  audioPlaying(this.song,this.index);

}
class audioStoped extends PlayAudioState{}

//debut du bloc
class PlayAudioBloc extends Bloc<PlayAudioEvent,PlayAudioState> {
  final SongService songService;


  PlayAudioBloc(this.songService) : super(audioStoped()) {
    on<audioPause>((event, emit){
      songService.pauseAudio(); //on recupere les methodes asynchrones du service
      emit(audioPaused());
    });
    //...play
    on<audioPlay>((event, emit) {
      songService.playAudio(event.index);
      emit(audioPlaying(event.song,event.index));
    });
    //...seek
    on<audioSeek>((event, emit){
      songService.seekAudio(event.position);
    });
    //...stop
    on<audioStop>((event,emit){
      songService.stopAudio();
      emit(audioStoped());
    });
    //...resume
    on<audioResume>((event,emit){
      songService.resumeAudio();
      emit(audioPlaying(event.song, event.index));
    });
    //..next
    on<audioNext>((event,emit){
      songService.nextAudio();
    });
    //..previous
    on<audioPrevious>((event,emit){
      songService.previousAudio();
    });
  }
}
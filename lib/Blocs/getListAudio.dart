import 'package:bloc/bloc.dart';
import '../Models/SongModel.dart';
import '../Service/SongService.dart';

abstract class audioEvent{}
  class getSong extends audioEvent{}


abstract class audioState{}
class initialise extends audioState{}
class audioLoading extends audioState{}
class audioLoaded extends audioState{
  List<songModel> song;

  audioLoaded(this.song);

}
class audioError extends audioState{
  String message;

  audioError(this.message);
}



class GetListAudioBloc extends Bloc<audioEvent,audioState>{
  final SongService songService;
  GetListAudioBloc(this.songService) : super(initialise()){

    on<getSong>((event,emit)async{
      emit(audioLoading());
      try{final song = await songService.getAllSong();
        emit(audioLoaded(song!));
      }catch (e){
        emit(audioError("erreur de recuperation de l'audio"));
      }
    });

  }



}

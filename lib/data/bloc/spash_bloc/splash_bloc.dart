import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'splash_event.dart';
part 'splash_state.dart';
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashLoadedEvent>((event, emit) async{
     await Future.delayed(Duration(seconds: 6),(){
       emit(SplashSuccesState());
       });
    });
  }
}

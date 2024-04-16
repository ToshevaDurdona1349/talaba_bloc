import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talaba_backend/data/model/talaba_model.dart';

import '../../service/network_service.dart';

part 'get_student_event.dart';
part 'get_student_state.dart';

class GetStudentBloc extends Bloc<GetStudentEvent, GetStudentState> {
  NetworkService networkService;

  GetStudentBloc(this.networkService) : super(GetStudentInitialState()) {
    //--------------------------------------------------------------------------
    on<GetReadStudent>((event, emit) async{
      emit(GetStudentLoadInProgressState());
      List<TalabaModel>? list=await networkService.getStudents();
      if(list!=null){
        emit(GetStudentSuccessState(list));
      }
      else emit(GetStudentFailureState());

    });
    //--------------------------------------------------------------------------
    on<CreateStudentEmit>((event, emit)async{
      emit(GetStudentLoadInProgressState());
      try{
        await networkService.addStudent(event.talabaModel);
        List<TalabaModel>? list=await networkService.getStudents();
        if(list!=null){
          emit(GetStudentSuccessState(list));
        }
        else emit(GetStudentFailureState());
      }
      catch (e){
        emit(GetStudentFailureState());
        print("e :$e");
      }
    });
    //--------------------------------------------------------------------------
    on<UpdateStudentEvent>((event, emit) async{
      emit(GetStudentLoadInProgressState());

      try{
        await networkService.updateStudent(event.email, event.talabaModel);
        List<TalabaModel>? list=await networkService.getStudents();
        if(list!=null){
          emit(GetStudentSuccessState(list));
        }
        else emit(GetStudentFailureState());
      }
      catch (e){
        emit(GetStudentFailureState());
        print("e :$e");
          }
    },);
    //--------------------------------------------------------------------------
    on<DeleteStudentevent> ((event, emit) async {
      emit(GetStudentLoadInProgressState());
      try{
        await networkService.deleteStudent(event.pochta);
        List<TalabaModel>? list=await networkService.getStudents();
        if(list!=null){
          emit(GetStudentSuccessState(list));
        }
        else emit(GetStudentFailureState());
      }
      catch(e){
        emit(GetStudentFailureState());
        print("e :$e");
      }

     },);


  }
}

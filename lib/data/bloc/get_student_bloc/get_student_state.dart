part of 'get_student_bloc.dart';
@immutable
abstract class GetStudentState {}

class GetStudentInitialState extends GetStudentState {}

class GetStudentLoadInProgressState extends GetStudentState {}

class GetStudentSuccessState extends GetStudentState {
  List<TalabaModel> list;
  GetStudentSuccessState(this.list);
  }
class GetStudentFailureState extends GetStudentState {}

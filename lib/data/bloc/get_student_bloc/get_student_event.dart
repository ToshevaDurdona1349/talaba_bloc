part of 'get_student_bloc.dart';

@immutable
abstract class GetStudentEvent {}

class GetReadStudent extends GetStudentEvent{}

class CreateStudentEmit extends GetStudentEvent{
  final TalabaModel talabaModel;
  CreateStudentEmit(this.talabaModel);
 }
class UpdateStudentEvent extends GetStudentEvent{
  String email;
  TalabaModel talabaModel;
  UpdateStudentEvent({required this.email, required this.talabaModel});
 }
 class DeleteStudentevent extends GetStudentEvent{
  final String pochta;

  DeleteStudentevent(this.pochta);
}
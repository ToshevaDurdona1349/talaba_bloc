import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:talaba_backend/data/model/talaba_model.dart';
part 'network_service.g.dart';
@RestApi(baseUrl:'https://08e5-195-158-16-140.ngrok-free.app')
abstract class NetworkService{
  factory NetworkService(Dio dio, {String baseUrl})=_NetworkService;
  @GET('/all-students') Future<List<TalabaModel>?> getStudents();
  
  @POST('/create-student') Future<TalabaModel> addStudent(@Body() TalabaModel talabaModel);
  
  @PUT('/update-student/{email}') Future<void> updateStudent(@Path()String email,@Body() TalabaModel talabaModel);

  @DELETE('/del-student/{email}') Future<void>deleteStudent(@Path() String email);
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talaba_backend/data/bloc/get_student_bloc/get_student_bloc.dart';
import 'package:talaba_backend/data/model/talaba_model.dart';
import 'package:talaba_backend/data/service/network_service.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  GetStudentBloc getStudentBloc = GetStudentBloc(NetworkService(Dio()));

  TextEditingController controllerName=TextEditingController();
  TextEditingController controllerCourse=TextEditingController();
  TextEditingController controllergpa=TextEditingController();
  TextEditingController controllerEmail=TextEditingController();

  TextEditingController controllerEmailSearcheUp=TextEditingController();
  TextEditingController controllerNameUp=TextEditingController();
  TextEditingController controllerCourseUp=TextEditingController();
  TextEditingController controllergpaUp=TextEditingController();
  TextEditingController controllerEmailUp=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getStudentBloc..add(GetReadStudent()),
        child:
        BlocBuilder<GetStudentBloc, GetStudentState>(
          builder: (context, state) {
            return Scaffold(
              //resizeToAvoidBottomInset: false,
              appBar: AppBar(actions: [
                IconButton(   // create
                  onPressed: (){
                    showDialog(
                        context: context, builder: (context)=>SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                          child: AlertDialog(
                      title: Text("Add Student"),
                      actions: [

                          TextField(controller: controllerName,decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Familya Ism'
                          ),),
                          SizedBox(height: 10,),
                          TextField(controller: controllerCourse,decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Course'
                          ),),
                          SizedBox(height: 10,),
                          TextField(controller: controllerEmail,decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email'
                          ),),
                          SizedBox(height: 10,),
                          TextField(controller: controllergpa,decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter double'
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                           TextButton(onPressed: (){
                             Navigator.pop(context);
                           }, child:Text('CANCEL')),
                           TextButton(onPressed: (){
                             getStudentBloc.add(CreateStudentEmit(TalabaModel(
                               name: controllerName.text,
                               email: controllerEmail.text,
                               course: controllerCourse.text,
                               gpa: double.parse(controllergpa.text)
                             )));
                             Navigator.pop(context);
                           }, child:Text('ADD')),
                          ],)
                      ],
                    ),
                        ));
                  },
                  icon: Icon(Icons.add,color: Colors.blue,size: 30,),
                ),  //create account
                IconButton(   // update
                  onPressed: (){
                    showDialog(
                        context: context, builder: (context)=>SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                          child: AlertDialog(
                           title: Text("Update  Student"),
                           actions: [
                          TextField(
                            controller: controllerEmailSearcheUp,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email'
                          ),),
                          SizedBox(height: 10,),
                          TextField(controller: controllerNameUp,decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Familya Ism'
                          ),),
                          SizedBox(height: 10,),
                          TextField(controller: controllerCourseUp,decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Course'
                          ),),
                          SizedBox(height: 10,),
                          TextField(controller: controllergpaUp,decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'enter double'
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child:Text('CANCEL')),
                              TextButton(onPressed: (){
                               getStudentBloc.add(UpdateStudentEvent(
                                   email: controllerEmailSearcheUp.text,
                                   talabaModel: TalabaModel(
                                     name: controllerNameUp.text,
                                     course: controllerCourseUp.text,
                                     gpa: double.parse(controllergpaUp.text)
                                   )
                               ));
                                Navigator.pop(context);
                              }, child:Text('Update')),
                            ],)
                      ],
                    ),
                        ));
                  },
                  icon: Icon(Icons.create,color: Colors.red,size: 30,),
                ),
              ],),
              body:getBody(state),
            );
          },
        )
    );

  }
  Widget getBody(GetStudentState state){
    print("state is ${state}");
    if(state is GetStudentLoadInProgressState){
      return Center(child: CircularProgressIndicator(),);
    }
    else if(state is GetStudentSuccessState){
      List<TalabaModel>list=state.list;
      return ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              color: index%2==1?Color(0xFFBFC7F6):Color(0xFFF1D8C0),
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              // height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("         ${list[index].name}",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("id:  ${list[index].sId}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$index"),
                      Expanded(child: Text("course:  ${list[index].course}")),
                      IconButton(onPressed: (){
                        getStudentBloc.add(DeleteStudentevent(list[index].email!));
                      },
                      icon: Icon(Icons.delete,color: Colors.red,),)
                    ],
                  ),
                  Text("email:  ${list[index].email}"),
                  Text("gpa:  ${list[index].gpa}"),
              ],),
            );
          },
        itemCount: state.list.length,
      );
    }
    else if (state is GetStudentFailureState){
      return Center(child: Text("Error"),);
    }
    else {
      return Center(child: Text("Defoult"),);
    }
  }
}

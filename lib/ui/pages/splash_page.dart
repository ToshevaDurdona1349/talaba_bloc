import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talaba_backend/data/bloc/spash_bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
   SplashPage({Key? key}) : super(key: key);
  
  SplashBloc splashBloc=SplashBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>splashBloc..add(SplashLoadedEvent()),
        child:
        BlocListener<SplashBloc,SplashState>(
        listener: (context,state){
          if(state is SplashSuccesState){
            Navigator.pushNamed(context, '/main');}
         },
          child: Scaffold(
            body: SafeArea(child: Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 30,top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/img.jpg'),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            )),
          ),
        )
    );
  }
}


import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/screen/auth/loginscreen.dart';
import 'package:mart_connect/screen/dasboard/mian_dashboard_screen.dart';
import 'package:mart_connect/screen/home_user_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3),
            () async{
          if(FirebaseAuth.instance.currentUser?.uid!=null){
            BlocProvider.of<AppCubit>(context).getDateUser();
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return LoginScreen();
            }));
          }
        }
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit,AppState>(
        listener: (context,state){
          if(state is SuccessGetUserState){

            if((BlocProvider.of<AppCubit>(context).signUpModel?.type??'') == 'User'){
              BlocProvider.of<AppCubit>(context).getAllStores();
            }
            else{
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return MainDashBoardScreen();
              }));
            }
          }else if (state is SuccessGetAllUser){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return HomeUserScreen();
            }));
          }
        },
    child: Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.jpg',fit: BoxFit.fitHeight,
        width: double.infinity,height: double.infinity),
      ),
    ),);
  }
}

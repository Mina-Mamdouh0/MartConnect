

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/shared/companet.dart';

class AddAdminScreen extends StatelessWidget {
  AddAdminScreen({Key? key}) : super(key: key);

  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();

  String ? area;
  String ? category;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is SuccessSignUpState){
          Navigator.pop(context);
        }
        else if (state is ErrorSignUpState){
          showToast(color: Colors.red,msg: 'Check in information');
        }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text('Add Admin'),
              elevation: 0.0,
            ),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        Text('Add Admin now with Friends',
                            style: Theme.of(context).textTheme.headline5),
                        const SizedBox(height: 25,),
                        defaultTextFiled(
                          controller: nameController,
                          inputType: TextInputType.text,
                          labelText: 'Name',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please Enter The Name';
                            }
                          },
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFiled(
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please Enter The Email';
                            }
                          },
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFiled(
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            labelText: 'Password',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please Password is Shorted';
                              }
                            },
                            prefixIcon: Icons.lock,
                            suffixIcon: cubit.obscureText?Icons.visibility:Icons.visibility_off,
                            fctSuffixIcon: ()=>cubit.visiblePassword(),
                            obscureText: cubit.obscureText
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFiled(
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          labelText: 'Phone Number',
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please Enter The Phone';
                            }
                          },
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 15,),

                        const SizedBox(height: 25,),
                        (state is! LoadingSignUpState)?
                        MaterialButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.signUp(
                                type: 'Admin',
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,);
                            }
                          },
                          minWidth: double.infinity,
                          color: Colors.blue,
                          textColor: Colors.white,
                          height: 50,
                          child:  const Text('Add New Admin',style: TextStyle(
                              fontSize: 20
                          ),),
                        ):
                        const Center(child:CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}

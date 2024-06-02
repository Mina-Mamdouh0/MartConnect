

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/shared/companet.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<CardScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          elevation: 0.0,
        ),
        body: BlocConsumer<AppCubit,AppState>(
          builder: (context,state){
            var cubit= AppCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child:
                  (state is LoadingGetAllUser)?
                  const Center(child: CircularProgressIndicator()):
                  ListView.builder(
                      itemCount:cubit.cardList.length ,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context,index){
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                      child: Image.network(cubit.cardList[index].image??'',
                                    height: 80,width: 80,fit: BoxFit.fill,)),
                                  const SizedBox(width: 10,),
                                  Expanded(child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cubit.cardList[index].name??'',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),
                                      SizedBox(height: 3,),
                                      Text('${cubit.cardList[index].price??''} EGP',
                                          style: const TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        );
                      })),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text('Total',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              fontFamily: 'KantumruyPro'
                          ),textAlign: TextAlign.center),
                      const Spacer(),
                      Text((cubit.totalPrice).toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              fontFamily: 'KantumruyPro'
                          ),textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(height: 15,),
                  MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CheckOutScreen();
                      }));
                    },
                    minWidth: double.infinity,

                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    height: 50,
                    child:  const Text('Check Out',style: TextStyle(
                        fontSize: 20
                    ),),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            );
          },
          listener: (context,state){
          },
        )
    );
  }
}


class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Check Out'),
          elevation: 0.0,
        ),
        body: BlocConsumer<AppCubit,AppState>(
          builder: (context,state){
            var cubit= AppCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child:
                  (state is LoadingGetAllUser)?
                  const Center(child: CircularProgressIndicator()):
                  ListView.builder(
                      itemCount:cubit.cardList.length ,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context,index){
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(cubit.cardList[index].image??'',
                                        height: 80,width: 80,fit: BoxFit.fill,)),
                                  const SizedBox(width: 10,),
                                  Expanded(child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cubit.cardList[index].name??'',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),
                                      Text('${cubit.cardList[index].price??''} EGP',
                                          style: const TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        );
                      })),
                  SizedBox(height: 15,),

                  defaultTextFiled(
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
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
                    controller: TextEditingController(),
                    inputType: TextInputType.phone,
                    labelText: 'Phone Number',
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter The Phone';
                      }
                    },
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(height: 15,),
                  defaultTextFiled(
                    controller: TextEditingController(),
                    inputType: TextInputType.phone,
                    labelText: 'Address',
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter The Address';
                      }
                    },
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text('Total',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              fontFamily: 'KantumruyPro'
                          ),textAlign: TextAlign.center),
                      const Spacer(),
                      Text((cubit.totalPrice).toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              fontFamily: 'KantumruyPro'
                          ),textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(height: 15,),
                  MaterialButton(
                    onPressed: (){
                      showDialog(context: context,
                          builder: (context){
                        return AlertDialog(
                          title: Text('Created Order'),
                          content: Text('Order successful and it will be sent to you soon'),
                          actions: [
                            TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Cancel')),
                            SizedBox(width: 20,),
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              cubit.cardList=[];
                            }, child: Text('Ok')),
                          ],
                        );
                          });



                    },
                    minWidth: double.infinity,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    height: 50,
                    child:  const Text('Create Order',style: TextStyle(
                        fontSize: 20
                    ),),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            );
          },
          listener: (context,state){
          },
        )
    );
  }
}


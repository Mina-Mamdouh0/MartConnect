
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllProduct();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Product'),
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
                      itemCount:cubit.productList.length ,
                      padding: EdgeInsets.all(20),
                      itemBuilder: (context,index){
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipOval(child: Image.network(cubit.storeList[index].image??'',
                                    height: 80,width: 80,fit: BoxFit.fill,)),
                                  const SizedBox(width: 10,),
                                  Expanded(child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cubit.productList[index].name??'',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),

                                      const SizedBox(height: 10,),
                                      Text(cubit.productList[index].desc??'',
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.start,),
                                      const SizedBox(height: 10,),
                                      Text(cubit.productList[index].price??'',
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),
                                      const SizedBox(height: 10,),
                                      Text(cubit.productList[index].rate??'',
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),
                                    ],
                                  )),
                                  const SizedBox(width: 10,),
                                  InkWell(
                                      onTap: ()async{
                                        var number = cubit.productList[index].phone??''; //set the number here
                                        bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                                      },
                                      child: Icon(Icons.call,size: 30,))
                                ],
                              ),


                            ],
                          ),
                        );
                      }))
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

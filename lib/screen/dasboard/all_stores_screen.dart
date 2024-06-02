
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class AllStoreScreen extends StatefulWidget {
  const AllStoreScreen({Key? key}) : super(key: key);

  @override
  State<AllStoreScreen> createState() => _AllStoreScreenState();
}

class _AllStoreScreenState extends State<AllStoreScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllStores();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Stores'),
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
                      itemCount:cubit.storeList.length ,
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
                                    height: 50,width: 50,fit: BoxFit.fill,)),
                                  const SizedBox(width: 10,),
                                  Expanded(child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cubit.storeList[index].name??'',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.center),

                                      const SizedBox(height: 10,),
                                      Text(cubit.storeList[index].desc??'',
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'KantumruyPro'
                                          ),textAlign: TextAlign.start),
                                    ],
                                  )),
                                  const SizedBox(width: 10,),
                                  InkWell(
                                      onTap: ()async{
                                        var number = cubit.storeList[index].phone??''; //set the number here
                                        bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                                      },
                                      child: Icon(Icons.call,size: 30,))
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: ()async{
                                        try{
                                          await launch(cubit.storeList[index].webSiteLink??'');
                                        }catch(e){
                                          debugPrint(e.toString());
                                        }
                                      },
                                      child: Icon(Icons.link,size: 30,)),

                                  InkWell(
                                      onTap: ()async{
                                        try{
                                          await launch(cubit.storeList[index].location??'');
                                        }catch(e){
                                          debugPrint(e.toString());
                                        }
                                      },
                                      child: Icon(Icons.location_on_outlined,size: 30,))
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

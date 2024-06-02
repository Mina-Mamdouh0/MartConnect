
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/model/store_model.dart';
import 'package:mart_connect/screen/details_product_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsStoreScreen extends StatefulWidget {
  final StoreModel storeModel;
  const DetailsStoreScreen({Key? key, required this.storeModel}) : super(key: key);

  @override
  State<DetailsStoreScreen> createState() => _DetailsStoreScreenState();
}

class _DetailsStoreScreenState extends State<DetailsStoreScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getStoreProduct(idStore: widget.storeModel.uid??'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Details Store'),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.storeModel.image??''),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 20,),

                    Text(
                      widget.storeModel.name??'',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10,),

                    Text(
                      widget.storeModel.desc??'',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                              onTap: ()async{
                                var number = widget.storeModel.phone??''; //set the number here
                                bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                              },
                              child: const Icon(
                                Icons.call,
                                color: Colors.deepPurple,
                                size: 20,
                              )
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                              onTap: ()async{
                                try{
                                  await launch(widget.storeModel.location??'');
                                }catch(e){
                                  debugPrint(e.toString());
                                }
                              },
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.deepPurple,
                                size: 20,
                              )
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                              onTap: ()async{
                                try{
                                  await launch(widget.storeModel.webSiteLink??'');
                                }catch(e){
                                  debugPrint(e.toString());
                                }},

                              child: const Icon(
                                Icons.link,
                                color: Colors.deepPurple,
                                size: 20,
                              )
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),

                    (state is LoadingGetAllUser)?
                        Center(child: CircularProgressIndicator(),):
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1/1.3,
                        mainAxisSpacing: 20
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:cubit.productStoreList.length ,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ProductDetailsScreen(productModel: cubit.productStoreList[index],);
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(cubit.productStoreList[index].image??'',
                                        fit: BoxFit.fill,
                                        width: double.infinity,),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(cubit.productStoreList[index].name??'',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                        ),
                                        maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: true,
                                      )
                                  ),
                                  Text('${cubit.productStoreList[index].price??''}\$',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })


                  ],
                )),
          );
        });
  }
}





import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/model/store_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/product_model.dart';

/*
class DetailsProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const DetailsProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Details Product'),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(widget.productModel.image??'',fit: BoxFit.fill,
                      height: 300,width: double.infinity,),
                    const SizedBox(height: 20,),

                    Text(widget.productModel.name??'',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.center),

                    const SizedBox(height: 10,),
                    Text(widget.productModel.desc??'',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.center),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Phone : ${widget.productModel.phone??''}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontFamily: 'KantumruyPro'
                            ),textAlign: TextAlign.center),
                        Spacer(),
                        InkWell(
                            onTap: ()async{
                              var number = widget.productModel.phone??''; //set the number here
                              bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                            },
                            child: Icon(Icons.call,size: 30,)),
                      ],
                    ),
                    SizedBox(height: 15,),

                    Text('Rate : ${widget.productModel.rate??''}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.center),

                    SizedBox(height: 15,),

                    Text('Stock : ${widget.productModel.stock??''}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.center),

                    SizedBox(height: 15,),

                    Text('Size : ${widget.productModel.size??''}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.center),

                    const SizedBox(height: 40,),


                    MaterialButton(
                      onPressed: (){
                       cubit.addCard(widget.productModel);
                       Navigator.pop(context);

                      },
                      minWidth: double.infinity,
                      color: Colors.blue,
                      textColor: Colors.white,
                      height: 50,
                      child:  const Text('Add To Card',style: TextStyle(
                          fontSize: 20
                      ),),
                    ),
                    const SizedBox(height: 40,),




                  ],
                )),
          );
        });
  }
}
*/

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(builder: (context,state){
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Details Product',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  height: 250,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.productModel.image??''),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),


                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.productModel.name??'',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                                onTap: () {

                                },
                                child: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.black,
                                  size: 20,
                                )
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              widget.productModel.rate??'',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.star,color: Colors.yellow,size: 30,),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Phone : ${widget.productModel.phone??''}',
                              style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  fontFamily: 'KantumruyPro'
                              ),textAlign: TextAlign.center),
                          Spacer(),
                          InkWell(
                              onTap: ()async{
                                var number = widget.productModel.phone??''; //set the number here
                                bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                              },
                              child: Icon(Icons.call,size: 20,color: Colors.deepPurple,)),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(
                            child: Text('Stock : ${widget.productModel.stock??''}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),textAlign: TextAlign.center),
                          ),

                          SizedBox(height: 15,),

                          Expanded(
                            child: Text('Size : ${widget.productModel.size??''}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),textAlign: TextAlign.center),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.productModel.desc??'',
                        style: TextStyle(
                          fontSize: 16,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),



                Container(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),

                          Text(
                            widget.productModel.price??'',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              AppCubit.get(context).addCard(widget.productModel);
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}





import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/model/store_model.dart';
import 'package:mart_connect/shared/companet.dart';

class AddProductScreen extends StatefulWidget {
  final bool isEdit;
  final StoreModel storeModel;
  const AddProductScreen({Key? key, required this.isEdit, required this.storeModel}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var formKey=GlobalKey<FormState>();

  var rate=TextEditingController();
  var price=TextEditingController();
  var descController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  String? uidStore;
  String? size;
  String? stock;

  List<String> sizeList =['M','S','X','XL','XXL'];
  List<String> stockList =['in stock','out stock',];

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllStores();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){
        if(state is SuccessPostStoreState){
          Navigator.pop(context);
        }
        else if (state is ErrorPostStoreState){
          showToast(color: Colors.red,msg: 'Check in information');
        }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text('Add New Product'),
              elevation: 0.0,
            ),
            body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 85,
                          height: 85,
                          child: Stack(
                            children: [
                              Container(
                                width:80,
                                height: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey
                                    )
                                ),
                                child:

                                cubit.image==null?
                                Center(
                                  child: Icon(Icons.image_aspect_ratio_rounded,size: 30),
                                )
                                    : Image.file(cubit.image!,fit: BoxFit.fill,
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: ()async{
                                    XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                    if(picked !=null){
                                      cubit.changeImage(img: File(picked.path));
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration:BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child:Center(
                                      child:Icon(cubit.image == null ? Icons.add : Icons.edit,color:Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),


                      const SizedBox(height: 15,),

                      defaultTextFiled(
                        controller: nameController,
                        inputType: TextInputType.text,
                        labelText: 'Name',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The Name';
                          }
                        },
                        prefixIcon: Icons.title,
                      ),
                      const SizedBox(height: 15,),
                      defaultTextFiled(
                        controller: descController,
                        inputType: TextInputType.text,
                        labelText: 'Desc',
                        maxLines: 3,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The Desc';
                          }
                        },
                        prefixIcon: Icons.title,
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


                      defaultTextFiled(
                        controller: rate,
                        inputType: TextInputType.number,
                        labelText: 'Rate',
                        validator: (value){
                          if(value!.isEmpty || int.parse(value)>5){
                            return 'Please Enter The Rate';
                          }
                        },
                        prefixIcon: Icons.star_rate,
                      ),
                      const SizedBox(height: 15,),

                      defaultTextFiled(
                        controller: price,
                        inputType: TextInputType.phone,
                        labelText: 'Price',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The Price';
                          }
                        },
                        prefixIcon: Icons.price_change,
                      ),
                      const SizedBox(height: 15,),

                      (state is LoadingGetAllUser)?
                      CircularProgressIndicator():
                      DropdownButtonFormField(
                        hint: const Text('Store'),
                        items: [
                          ...cubit.storeList.map((e){
                            return DropdownMenuItem(
                              value: e.uid,
                              child: Text(e.name??''),
                            );
                          })
                        ],
                        value: uidStore,
                        onChanged: (val){
                          uidStore =val;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_city),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.blue,width: 5),
                          ),
                        ),
                        validator: (val){
                          if(val==null){
                            return 'Please Enter The Store';

                          }
                        },
                      ),
                      const SizedBox(height: 15,),
                      DropdownButtonFormField(
                        hint: const Text('Stock'),
                        items: [
                          ...stockList.map((e){
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          })
                        ],
                        value: stock,
                        onChanged: (val){
                          stock =val;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.blue,width: 5),
                          ),
                        ),
                        validator: (val){
                          if(val==null){
                            return 'Please Enter The Store';

                          }
                        },
                      ),
                      const SizedBox(height: 15,),
                      DropdownButtonFormField(
                        hint: const Text('Size'),
                        items: [
                          ...sizeList.map((e){
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          })
                        ],
                        value: size,
                        onChanged: (val){
                          size =val;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.blue,width: 5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),


                      const SizedBox(height: 25,),
                      (state is! LoadingPostStoreState)?
                      MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            if(cubit.image!=null){
                              cubit.postProduct(
                                desc: descController.text,
                                price: price.text,
                                rate: rate.text,
                                stock: stock!,
                                size: size??'',
                                uidStore: uidStore!,
                                name: nameController.text,
                                phone: phoneController.text,);
                            }else{
                              showToast(msg: 'Select Image', color: Colors.red);
                            }
                          }
                        },
                        minWidth: double.infinity,
                        color: Colors.blue,
                        textColor: Colors.white,
                        height: 50,
                        child:  const Text('Add New Product',style: TextStyle(
                            fontSize: 20
                        ),),
                      ):
                      const Center(child:CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}

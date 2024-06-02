

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/model/store_model.dart';
import 'package:mart_connect/shared/companet.dart';

class AddStoreScreen extends StatefulWidget {
  final bool isEdit;
  final StoreModel storeModel;
  const AddStoreScreen({Key? key, required this.isEdit, required this.storeModel}) : super(key: key);

  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  var formKey=GlobalKey<FormState>();

  var webSiteLinkController=TextEditingController();

  var locationController=TextEditingController();

  var latController=TextEditingController();

  var longController=TextEditingController();

  var descController=TextEditingController();

  var nameController=TextEditingController();

  var phoneController=TextEditingController();

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
              title: Text('Add New Store'),
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
                        controller: webSiteLinkController,
                        inputType: TextInputType.phone,
                        labelText: 'webSite Link',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The webSite Link';
                          }
                        },
                        prefixIcon: Icons.phone,
                      ),
                      const SizedBox(height: 15,),

                      defaultTextFiled(
                        controller: locationController,
                        inputType: TextInputType.text,
                        labelText: 'Location Link',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The Location Link';
                          }
                        },
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 15,),

                      defaultTextFiled(
                        controller: latController,
                        inputType: TextInputType.text,
                        labelText: 'Lat',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The Lat';
                          }
                        },
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 15,),

                      defaultTextFiled(
                        controller: longController,
                        inputType: TextInputType.text,
                        labelText: 'Long',
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter The Long';
                          }
                        },
                        prefixIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 15,),



                      const SizedBox(height: 25,),
                      (state is! LoadingPostStoreState)?
                      MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            if(cubit.image!=null){
                              cubit.postStore(
                                desc: descController.text,
                                lat: latController.text,
                                long: longController.text,
                                location: locationController.text,
                                webSiteLink: webSiteLinkController.text,
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
                        child:  const Text('Add New Store',style: TextStyle(
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

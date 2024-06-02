
import 'dart:core';
import 'dart:core';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/model/product_model.dart';
import 'package:mart_connect/model/profile_model.dart';
import 'package:mart_connect/model/store_model.dart';
import 'package:uuid/uuid.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool obscureText=true;
  void visiblePassword(){
    obscureText=!obscureText;
    emit(VisiblePasswordState());
  }

  void userLogin({required String email, required String password,}){
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).
    then((value){
      emit(SuccessLoginState());
      getDateUser();
    }).
    onError((error,_){
      emit(ErrorLoginState());
    });
  }

  void signUp({required String email, required String password, required String name, required String phone,required String type}){
    emit(LoadingSignUpState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
      SignUpModel model=SignUpModel(name: name, email: email, phone: phone, uId: value.user?.uid,
          image: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
          createdAt: Timestamp.now(),
          type: type
      );
      FirebaseFirestore.instance.collection('Users').doc(value.user?.uid).set(
          model.toMap()
      ).then((value){
        emit(SuccessSignUpState());
        getDateUser();
      }).onError((error,_){
        emit(ErrorSignUpState());
      });
    }).onError((error,_){
      emit(ErrorSignUpState());
    });
  }

  SignUpModel? signUpModel;
  void getDateUser(){
    emit(LoadingGetUserState());
    signUpModel=null;
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).
      get().
      then((value){
        signUpModel=SignUpModel.formJson(value.data()!);
        emit(SuccessGetUserState());
      }).onError((error,_){
        emit(ErrorGetUserState());
      });
    }
  }

  void logout(){
    FirebaseAuth.instance.signOut().whenComplete((){
      emit(LogoutState());
    });
  }

  List<SignUpModel> usersDate=[];
  void getAllUser(){
    emit(LoadingGetAllUser());
    usersDate=[];
    FirebaseFirestore.instance
        .collection('Users').where('Type',isEqualTo: 'User').get().
    then((value){
      for (var element in value.docs) {
        SignUpModel? s = SignUpModel.formJson(element);
        if(s.uId != FirebaseAuth.instance.currentUser?.uid){
          usersDate.add(SignUpModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  void getAllAdmin(){
    emit(LoadingGetAllUser());
    usersDate=[];
    FirebaseFirestore.instance
        .collection('Users').where('Type',isEqualTo: 'Admin').get().
    then((value){
      for (var element in value.docs) {
        SignUpModel? s = SignUpModel.formJson(element);
        if(s.uId != FirebaseAuth.instance.currentUser?.uid){
          usersDate.add(SignUpModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  File? image;
  String ? url;

  void changeImage({required File img,}){
    image=img;
    emit(ChangeImage());
  }

  void postStore({required String webSiteLink,required String location , required String long, required String lat ,required String desc , required String name , required String phone})async{
    emit(LoadingPostStoreState());
    String uIdStore=const Uuid().v4();
    final ref= FirebaseStorage.instance.ref().child('Stores').
    child(FirebaseAuth.instance.currentUser?.uid??'').
    child('$name$uIdStore.jpg');
    await ref.putFile(image!).then((p0)async {
      url =await ref.getDownloadURL();
      StoreModel model=StoreModel(
          image: url!,
          createAt: Timestamp.now(),
          webSiteLink: webSiteLink,
          adminUid: FirebaseAuth.instance.currentUser?.uid,
          location: location,
          long: long,
          uid:uIdStore,
          lat: lat,
          desc: desc,
          name: name,
          phone: phone
      );
      FirebaseFirestore.instance.collection('Stores').doc(uIdStore).
      set(model.toMap())
          .then((value){
            image=null;
            url=null;
        emit(SuccessPostStoreState());
      });
    }).onError((error,_){
      emit(ErrorPostStoreState());
    });
  }

  List<StoreModel> storeList=[];
  void getAllStores(){
    emit(LoadingGetAllUser());
    storeList=[];
    FirebaseFirestore.instance
        .collection('Stores').get().
    then((value){
      for (var element in value.docs) {
        storeList.add(StoreModel.formJson(element.data()));
      }
      print(storeList.length);
      print('gg');
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  void postProduct({required String price,required String uidStore , required String rate ,required String desc , required String name , required String phone , required String stock , String ? size})async{
    emit(LoadingPostStoreState());
    String uIdStore=const Uuid().v4();
    String nameStore='';
    FirebaseFirestore.instance.collection('Stores').doc(uidStore).get().then((value){
      nameStore=value.get('Name');
    });
    
    
    final ref= FirebaseStorage.instance.ref().child('Products').
    child(FirebaseAuth.instance.currentUser?.uid??'').
    child('$name$uIdStore.jpg');
    await ref.putFile(image!).then((p0)async {
      url =await ref.getDownloadURL();
      ProductModel model=ProductModel(
          image: url!,
          createAt: Timestamp.now(),
          price: price,
          size: size,
          stock: stock,
          adminUid: FirebaseAuth.instance.currentUser?.uid,
          nameStore: nameStore,
          rate: rate,
          uid:uIdStore,
          uidStore: uidStore,
          desc: desc,
          name: name,
          phone: phone
      );
      FirebaseFirestore.instance.collection('Products').doc(uIdStore).
      set(model.toMap())
          .then((value){
        image=null;
        url=null;
        emit(SuccessPostStoreState());
      });
    }).onError((error,_){
      emit(ErrorPostStoreState());
    });
  }

  List<ProductModel> productList=[];
  void getAllProduct(){
    emit(LoadingGetAllUser());
    productList=[];
    FirebaseFirestore.instance
        .collection('Products').get().
    then((value){
      for (var element in value.docs) {
        productList.add(ProductModel.formJson(element.data()));
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  List<ProductModel> productStoreList=[];
  void getStoreProduct({required String idStore}){
    emit(LoadingGetAllUser());
    productStoreList=[];
    FirebaseFirestore.instance
        .collection('Products').get().
    then((value){
      for (var element in value.docs) {
        ProductModel p = ProductModel.formJson(element.data());
        if(p.uidStore == idStore){
          productStoreList.add(ProductModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  List<ProductModel> search=[];
  void getSearchProduct({required String text}){
    emit(LoadingGetAllUser());
    search=[];
    FirebaseFirestore.instance
        .collection('Products').get().
    then((value){
      for (var element in value.docs) {
        ProductModel p = ProductModel.formJson(element.data());
        if((p.name??'').contains(text)){
          search.add(ProductModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }


  double currentLatitudeSearch=30.0594885;
  double currentLongitudeSearch=31.2584644;

  CameraPosition? cameraPosition;
  void uploadCameraPosition(CameraPosition camera){
    cameraPosition=camera;
    currentLatitudeSearch=cameraPosition!.target.latitude;
    currentLongitudeSearch=cameraPosition!.target.longitude;
    emit(SuccessGetAllUser());
  }

  List<ProductModel> cardList=[];

  void addCard(ProductModel productModel){
    cardList.add(productModel);
    emit(SuccessGetAllUser());
  }

  get  totalPrice{
    double pp = 0.0;
  cardList.forEach((element) {
  pp+= double.parse(element.price??'');
  });
    return pp;
  }
}

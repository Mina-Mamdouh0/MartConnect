

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/model/store_model.dart';
import 'package:mart_connect/screen/auth/loginscreen.dart';
import 'package:mart_connect/screen/dasboard/add_admin_screen.dart';
import 'package:mart_connect/screen/dasboard/add_product_screen.dart';
import 'package:mart_connect/screen/dasboard/add_store_screen.dart';
import 'package:mart_connect/screen/dasboard/all_admin_screen.dart';
import 'package:mart_connect/screen/dasboard/all_product_screen.dart';
import 'package:mart_connect/screen/dasboard/all_stores_screen.dart';
import 'package:mart_connect/screen/dasboard/all_users_screen.dart';
import 'package:mart_connect/shared/companet.dart';

class MainDashBoardScreen extends StatelessWidget {
  const MainDashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit =AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('DashBoard'),
              elevation: 0.0,
              actions: [
                InkWell(
                    onTap: (){
                      cubit.logout();
                    },
                    child: Icon(Icons.logout)),
                SizedBox(width: 10,),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: cardHomeDash(
                          title: 'Add Admin',
                          fct: (){
                            navigatorPush(context: context, widget: AddAdminScreen());
                          }
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: cardHomeDash(
                            title: 'All Admins',
                            fct: (){
                              navigatorPush(context: context, widget: AllAdminScreen());
                            }
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: cardHomeDash(
                            title: 'All Users',
                            fct: (){
                              navigatorPush(context: context, widget: AllUsersScreen());
                            }
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: cardHomeDash(
                            title: 'Add Store',
                            fct: (){
                              navigatorPush(context: context, widget: AddStoreScreen(isEdit: false,storeModel: StoreModel(),));
                            }
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: cardHomeDash(
                            title: 'All Stores',
                            fct: (){
                              navigatorPush(context: context, widget: AllStoreScreen());
                            }
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: cardHomeDash(
                            title: 'Add Product',
                            fct: (){
                              navigatorPush(context: context, widget: AddProductScreen(storeModel: StoreModel(),isEdit: false,));

                            }
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  cardHomeDash(
                      title: 'All Products',
                      fct: (){
                        navigatorPush(context: context, widget: AllProductScreen());

                      }
                  ),

                ],
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is LogoutState){
            navigatorAndRemove(context: context, widget: LoginScreen());
          }

        });
  }

  Widget cardHomeDash({required String title, required Function() fct}){
    return GestureDetector(
      onTap: fct,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                  height: 150, width: 150, 'assets/images/logo.jpg'),
            ),
            const SizedBox(
              height: 18,
            ),
             Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}



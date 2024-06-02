
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mart_connect/bloc/app_cubit.dart';
import 'package:mart_connect/bloc/app_state.dart';
import 'package:mart_connect/model/store_model.dart';
import 'package:mart_connect/screen/auth/loginscreen.dart';
import 'package:mart_connect/screen/card_screen.dart';
import 'package:mart_connect/screen/dasboard/all_stores_screen.dart';
import 'package:mart_connect/screen/details_store_screen.dart';
import 'package:mart_connect/shared/companet.dart';

import 'search_screen.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({Key? key}) : super(key: key);

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {

  GoogleMapController? _mapController;

  Set<Marker> markers = {};

  void addImageMarkers({required List<StoreModel> s}) async {

    s.forEach((element) async{
      markers.add(
        Marker(
          onTap: (){
            navigatorPush(context: context, widget: DetailsStoreScreen(storeModel: element,));
          },
          markerId:  MarkerId(element.uid??''),
          position:  LatLng(double.parse(element.lat??''),double.parse(element.long??'')),
          infoWindow:  InfoWindow(
            title: element.name??'',
            snippet: element.phone??'',
          ),
          icon: await MarkerIcon.downloadResizePictureCircle(
          element.image??'',
          size: 200,
          addBorder: true,
          borderColor:Colors.blue,
          borderSize: 20,
        ),
      ));
      setState(() {});
    });
    print('jjjj');
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addImageMarkers(s:  BlocProvider.of<AppCubit>(context).storeList);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit =AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
              elevation: 0.0,
              actions: [

                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SearchScreen();
                      }));
                    },
                    child: Icon(Icons.search)),
                SizedBox(width: 10,),

                InkWell(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return CardScreen();
                     }));
                    },
                    child: Icon(Icons.shopping_cart)),
                SizedBox(width: 10,),
                InkWell(
                    onTap: (){
                      cubit.logout();
                    },
                    child: Icon(Icons.logout)),
                SizedBox(width: 10,),
              ],
            ),
            body: (state is LoadingGetAllUser)?
            Center(child: CircularProgressIndicator()):GoogleMap(
              markers: markers,
              trafficEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              buildingsEnabled: true,
              zoomGesturesEnabled: true,onMapCreated: (GoogleMapController controller)=>addImageMarkers,

              initialCameraPosition: CameraPosition(
                target: LatLng(cubit.currentLatitudeSearch,cubit.currentLongitudeSearch),
                zoom: 14.0,
              ),
              mapType: MapType.normal,
             /* onMapCreated: (controller) {
                _mapController = controller;
              },*/
              onCameraMove: (CameraPosition camera) {
                cubit.uploadCameraPosition(camera);
              },
              onCameraIdle: ()async{
                List<Placemark> placeMarks= await placemarkFromCoordinates(
                    cubit.cameraPosition==null?cubit.currentLatitudeSearch:cubit.cameraPosition!.target.latitude, cubit.cameraPosition==null?
                cubit.currentLatitudeSearch:cubit.cameraPosition!.target.longitude,localeIdentifier: 'ar_SA');
                //cubit.getLocationInMap(placeMarks[0]);
              },
            ),
          );
        },
        listener: (context,state){
          if(state is LogoutState){
            navigatorAndRemove(context: context, widget: LoginScreen());
          }

        });
  }
}

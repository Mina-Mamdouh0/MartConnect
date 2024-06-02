
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel{
  String? webSiteLink;
  String? phone;
  String? location;
  String? lat;
  String? long;
  String? desc;
  String? name;
  String? image;
  String? uid;
  String? adminUid;
  Timestamp? createAt;

  StoreModel(
      {this.phone,
      this.name,
      this.uid,
      this.image,
      this.location,
      this.long,
      this.lat,
      this.createAt,
      this.desc,
      this.adminUid,
      this.webSiteLink});

  factory StoreModel.formJson(json,){
    return StoreModel(
      name: json['Name'],
      desc:json['Desc'],
      phone: json['Phone'],
      uid: json['UId'],
      lat: json['Lat'],
      long: json['Long'],
      createAt: json['CreatedAt'],
      image: json['Image'],
      location: json['Location'],
      webSiteLink: json['WebSiteLink'],
      adminUid: json['AdminUid'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Name': name,
      'Desc':desc,
      'Phone': phone,
      'UId': uid,
      'CreatedAt': createAt,
      'Image': image,
      'AdminUid': adminUid,
      'Lat': lat,
      'Long': long,
      'Location': location,
      'WebSiteLink': webSiteLink,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String? rate;
  String? phone;
  String? price;
  String? uidStore;
  String? nameStore;
  String? desc;
  String? name;
  String? image;
  String? uid;
  String? adminUid;
  String? size;
  String? stock;
  Timestamp? createAt;

  ProductModel(
      {this.phone,
        this.name,
        this.uid,
        this.image,
        this.price,
        this.rate,
        this.nameStore,
        this.createAt,
        this.desc,
        this.adminUid,
        this.size,
        this.stock,
        this.uidStore});

  factory ProductModel.formJson(json,){
    return ProductModel(
      name: json['Name'],
      desc:json['Desc'],
      phone: json['Phone'],
      uid: json['UId'],
      uidStore: json['UidStore'],
      nameStore: json['NameStore'],
      createAt: json['CreatedAt'],
      image: json['Image'],
      rate: json['Rate'],
      price: json['Price'],
      stock: json['Stock'],
      size: json['Size'],
      adminUid: json['AdminUid'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Name': name,
      'Stock': stock,
      'Size': size,
      'Desc':desc,
      'Phone': phone,
      'UId': uid,
      'CreatedAt': createAt,
      'Image': image,
      'AdminUid': adminUid,
      'UidStore': uidStore,
      'NameStore': nameStore,
      'Rate': rate,
      'Price': price,
    };
  }
}
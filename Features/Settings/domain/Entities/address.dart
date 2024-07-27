import 'package:cloud_firestore/cloud_firestore.dart';

class Address{
  String id;
  final String name;
  final String phoneNumber;
  final String country;
  final String house;
  final String street;
  final String postalCode;

  String userId;
  Address(  {required this.country,required this.house,required this.street,required this.postalCode,this.userId='',required this.id,required this.name, required this.phoneNumber});
  factory Address.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> doc){
    late final Map<String,dynamic> map;
    if(doc.data()!=null) {
      map=doc.data()!;
    }
    return Address(name: map['name'], phoneNumber: map['phoneNumber'], id: map['id'], country: map['country'], house: map['house'], street: map['street'], postalCode: map['postalCode']);
  }
  Map<String,dynamic> toJson(){
    return {
      'name':name,
      'phoneNumber':phoneNumber,
      'id':id,
      'userId':userId,
      'country':country,
      'house':house,
      'street':street,
      'postalCode':postalCode
    };
  }
}
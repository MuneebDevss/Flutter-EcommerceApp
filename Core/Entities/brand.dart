import 'package:cloud_firestore/cloud_firestore.dart';

class Brand{
  final String name;
  final String image;

  Brand({required this.name, required this.image});
  factory Brand.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> doc){
    late Map<String,dynamic> map;
    if(doc.data()!=null){
      map=doc.data()!;
    }
    return Brand(name: map['name'], image: map['image']);
  }
  Map<String,dynamic> toJson(){
    return{
      'name':name,
      'image':image
    };
  }
}
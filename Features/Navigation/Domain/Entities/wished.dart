import 'package:cloud_firestore/cloud_firestore.dart';


class Wished{
   String id;
  final String productId;
   String userId;
  Wished({required this.id,required this.userId, required this.productId});
  factory Wished.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> doc)
  {
    late Map<String,dynamic> map;
    if(doc.data()!=null) {
      map=doc.data()!;
    }
    return Wished(id: map['id'], productId: map['productId'], userId: map['userId']);

  }
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'productId':productId,
      'userId':userId
    };
  }
}
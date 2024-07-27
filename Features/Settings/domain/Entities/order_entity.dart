import 'package:cloud_firestore/cloud_firestore.dart';

class Orders{
  String orderBy;
  final List<String> products;
  final String orderState;
  final String shippingDate;
   String orderId;

  Orders( { this.orderBy='',required this.orderState, required this.shippingDate, required this.orderId,required this.products});
  factory Orders.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> doc){
    late final Map<String,dynamic> map;
    if(doc.data()!=null) {
      map=doc.data()!;
    }
    return Orders(orderState: map['orderState'], shippingDate: map['shippingDate'], orderId: map['orderId'], products: List<String>.from(map['products']));
  }
  Map<String,dynamic>toJson()
  {
    return{
      'orderState':orderState,
      'orderId':orderId,
      'shippingDate':shippingDate,
      'products':FieldValue.arrayUnion(products),
      'orderBy':orderBy
    };
  }
}
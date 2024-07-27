import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem{
  String id;
  String userId;
  final String brand;
  final String title;
  int quantity;
  final String size;
  final String color;
  final double price;
  final String imageUrl;

  CartItem({this.userId='',required this.id, required this.brand, required this.title, required this.quantity, required this.size, required this.color, required this.price, required this.imageUrl});

  factory CartItem.fromSnapShot(DocumentSnapshot<Map<String,dynamic>>doc)
  {
    late final Map<String,dynamic> map;
    if(doc.data()!=null) {
      map=doc.data()!;

    }
    return CartItem(id: map['id'], brand: map['brand'], title: map['title'], quantity: map['quantity'], size: map['size'], color: map['color'], price: map['price'], imageUrl: map['imageUrl']);
  }
  Map<String,dynamic> toJson()
  {
    return {
      'id':id,
      'brand':brand,
      'title':title,
      'quantity':quantity,
      'size':size,
      'color':color,
      'imageUrl':imageUrl,
      'price':price,
      'userId':userId
    };
  }
}

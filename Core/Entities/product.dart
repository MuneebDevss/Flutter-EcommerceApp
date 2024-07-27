import 'package:cloud_firestore/cloud_firestore.dart';

class Product
{
  String id;
  final String? off;
  final String title;
  final String brand;
  double price;
  final int likes;
  final String category;
  final String subCategory;
  List<String> imageUrl;
  final String? description;
  final List<String> sizes;
  final List<String> colors;
  Product(  {required this.id,required this.subCategory,this.imageUrl=const [],required this.category,required this.description, required this.sizes, required this.colors,this.off, required this.title, required this.brand, required this.price, required this.likes});
  factory Product.fromSnapShot(DocumentSnapshot<Map<String,dynamic>> doc)
  {
    late Map<String,dynamic> data;
    if(doc.data()!=null) {
      data=doc.data()!;
    }
    return Product(title: data['title']??'', brand: data['brand']??'', price: data['price'], likes: data['likes'],off: data['off']??'', category: data['category'], description: data['description'], sizes: data['sizes'], colors: data['colors'], imageUrl: data['imageUrl'], subCategory: data['subCategory'], id: data['id']);
  }
  Map<String,dynamic> toJson()
  {
    return {
      'off':off??'',
      'title':title,
      'brand':brand,
      'price':price,
      'likes':likes,
      'category':category,
      'subCategory':subCategory,
      'description':description??'',
      'sizes':FieldValue.arrayUnion(sizes),
      'colors':FieldValue.arrayUnion(colors),
      'imageUrl':FieldValue.arrayUnion(imageUrl),
    };
  }
}
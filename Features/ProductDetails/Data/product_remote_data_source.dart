import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../Core/Entities/product.dart';

abstract interface class ProductRemoteDataSource
{
  Future<void> uploadProduct(Product product,String imageUrl);
  Future<List<Product>> retrieveFeatured();
  Future<List<Product>> retrieveByBrand(String brandName);
  Future<List<Product>> retrieveCategory(String category);
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(String id,{String? category, String? description, List<String>? sizes, List<String>? colors, String? off, String? title, String? brand, String? price, int? likes});
  Future<void> uploadProductImages(List<File> images,String imageUrl);
}
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource{
  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String get() => _db.collection('Products').doc().id;
  @override
  Future<void> deleteProduct(String id) async {

    try{
      await _db.collection('Products').doc(id).delete();
    }
        catch(e){
      throw e.toString();
        }
  }

  @override
  Future<List<Product>> retrieveByBrand(String brandName) async {

    try{
      QuerySnapshot<Map<String,dynamic>> res=await _db.collection('Products').where('brand',isEqualTo:brandName).get();
      List<Product> products=res.docs.map((e) => Product.fromSnapShot(e)).toList();
      return products;
    }
        catch(e){
      throw e.toString();
        }
  }

  @override
  Future<List<Product>> retrieveCategory(String category) async {

    try{
      QuerySnapshot<Map<String,dynamic>> res=await _db.collection('Products').where('category',isEqualTo:category).get();
      List<Product> products=res.docs.map((e) => Product.fromSnapShot(e)).toList();
      return products;
    }
    catch(e){
      throw e.toString();
    }
  }

  @override
  Future<List<Product>> retrieveFeatured() async {

    try{
      QuerySnapshot<Map<String,dynamic>> res=await _db.collection('Products').orderBy('likes',descending: true).limit(10).get();
      List<Product> products=res.docs.map((e) => Product.fromSnapShot(e)).toList();
      return products;
    }
    catch(e){
      throw e.toString();
    }
  }

  @override
  Future<void> updateProduct(String id,{String? category, String? description, List<String>? sizes, List<String>? colors, String? off, String? title, String? brand, String? price, int? likes}) async {
    // TODO: implement updateProduct
    try{
      await _db.collection('Products').doc(id).update({
        'off':off,
        'title':title,
        'brand':brand,
        'price':price,
        'likes':likes,
        'category':category,
        'description':description,
        'sizes':sizes==null?null:FieldValue.arrayUnion(sizes),
        'colors':colors==null?null:FieldValue.arrayUnion(colors)
      });

    }
    catch(e){
      throw e.toString();
    }
  }

  @override
  Future<void> uploadProduct(Product product,String id) async {
    try{
      product.id=id;
      await _db.collection('Products').add(product.toJson());
    }
    catch(e){
      throw e.toString();
    }
  }

  @override
  Future<List<String>> uploadProductImages(List<File> images, String imageUrl) async {
    try{
      List<String> urls=[];
      for(int x=0;x<images.length;x++) {
        Reference storageRef = _storage.ref().child('$imageUrl/$x');
        await storageRef.putFile(images[x]);
        String url=await storageRef.getDownloadURL();
        urls.add(url);
      }
      return urls;
    }
    catch(e){
      throw e.toString();
    }
  }
}
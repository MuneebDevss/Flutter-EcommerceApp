import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Core/Controllers/product_controller.dart';
import 'package:ecommerce_app/Core/Entities/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Domain/Entities/wished.dart';

abstract interface class NavigationRemoteDataSource{
  Future<void> wishItem(Wished wished);
  Future<void> unWishItem(String id);
  Future<List<Wished>> getWished();
  Future<List<Product>> getWishProduct();
  Future<int> getTotalCartItems();
}
class NavigationRemoteDataSourceImpl extends NavigationRemoteDataSource{

  final FirebaseFirestore _db=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Future<int> getTotalCartItems() async {
    try {
      final  res = await _db
          .collection('CartItems').count().get();

      int x=res.count??0;

      return x;
    } catch (e) {
      throw ('Exception: $e');
    }
  }
  @override
  Future<List<Wished>> getWished() async {
    try{
      final res=await _db.collection('Wished').where('userId',isEqualTo:_auth.currentUser!.uid).get();
      final List<Wished> wishes=res.docs.map((e) => Wished.fromSnapShot(e)).toList();
      return wishes;
    }
    catch(e){
      throw e.toString();
    }
  }
  @override
  Future<void> unWishItem(String id) async {
    try{

      final res=await _db.collection('Wished').where('userId',isEqualTo:_auth.currentUser!.uid).where('productId',isEqualTo: id).get();
      for(QueryDocumentSnapshot<Map<String,dynamic>> result in res.docs){
        await result.reference.delete();
      }
    }
    catch(e){
      throw e.toString();
    }
  }

  @override
  Future<void> wishItem(Wished wished) async {
    try{
     wished.id= _db.collection('Wished').doc().id;
     wished.userId=_auth.currentUser!.uid;
     await _db.collection('Wished').add(wished.toJson());
    }
    catch(e){
      throw e.toString();
    }
  }

  @override
  Future<List<Product>> getWishProduct() async {
    try{
      //final pRes=await _db.collection('Products').get();
      //final List<Product>products=pRes.docs.map((e) => Product.fromSnapShot(e)).toList();
      final res=await _db.collection('Wished').get();
      final List<Wished>wishes=res.docs.map((e) => Wished.fromSnapShot(e)).toList();
      final List<Product> temp=[];
      // for(Product product in products){
      //   for(Wished wish in wishes){
      //     if(wish.id==product.id) {
      //       temp.add(product);
      //     }
      //   }
      for(Product product in CategoryController.products){

        for(Wished wish in wishes){
          if(wish.productId==product.id) {
            temp.add(product);
          }
        }
      }
      return temp;
    }
    catch(e){
      throw e.toString();
    }
  }

}
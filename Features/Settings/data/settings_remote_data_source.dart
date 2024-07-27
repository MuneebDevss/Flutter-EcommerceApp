import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Core/Entities/user.dart';
import 'package:ecommerce_app/Features/Settings/domain/Entities/order_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../domain/Entities/address.dart';
import '../domain/Entities/cart_entity.dart';

abstract interface class SettingsRemoteDataSource {
  Future<void> signOut();
  Future<List<CartItem>> getCartItems();
  Future<void> addCartItems(CartItem item);
  Future<void> makeOrder(Orders order);
  Future<List<Orders>> getOrders();
  Future<List<Address>> getAddresses(bool first);
  Future<void> deleteAddress(String id);
  Future<void> addAddress(Address address);
  Future<void> deleteCartItem(String id,bool all);
  Future<void> uploadProfilePicture(File image);
  Future<UserModel> getUserData();


}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _st=FirebaseStorage.instance;
  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific exceptions
      if (e.code == 'account-exists-with-different-credential') {
        throw 'account-exists-with-different-credential';
      } else if (e.code == 'operation-not-allowed') {
        throw 'operation-not-allowed';
      } else if (e.code == 'user-disabled') {
        throw 'user-disabled';
      } else if (e.code == 'user-not-found') {
        throw 'user-not-found';
      }
    } catch (e) {
      // Handle generic exceptions
      throw ('Exception: $e');
    }
  }

  @override
  Future<void> addCartItems(CartItem item) async {
    try {

      item.userId = _auth.currentUser!.uid;
      await _db.collection('CartItems').add(item.toJson());
    } catch (e) {
      // Handle generic exceptions
      throw ('Exception: $e');
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      final res = await _db
          .collection('Address')
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .where('id', isEqualTo: addressId)
          .get();
      var results = res.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> result in results) {
        await result.reference.delete();
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific exceptions
      if (e.code == 'account-exists-with-different-credential') {
        throw 'account-exists-with-different-credential';
      } else if (e.code == 'operation-not-allowed') {
        throw 'operation-not-allowed';
      } else if (e.code == 'user-disabled') {
        throw 'user-disabled';
      } else if (e.code == 'user-not-found') {
        throw 'user-not-found';
      } else {
        throw "Unknown Errors";
      }
    } catch (e) {
      // Handle generic exceptions
      throw ('Exception: $e');
    }
  }

  @override
  Future<List<Address>> getAddresses(bool? first) async {
    try {
      late final QuerySnapshot<Map<String, dynamic>> res;
      if(first==null)
      {
         res = await _db
            .collection('Address')
            .where('userId', isEqualTo: _auth.currentUser!.uid)
            .get();
      }
      else{
         res = await _db
            .collection('Address')
            .where('userId', isEqualTo: _auth.currentUser!.uid).limit(1)
            .get();
      }
      final List<Address> addresses =
          res.docs.map((e) => Address.fromSnapShot(e)).toList();


      return addresses;
    } catch (e) {
      throw ('Exception: $e');
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> res = await _db
          .collection('CartItems')
          .where('userId', isEqualTo: _auth.currentUser!.uid)
          .get();
      final List<CartItem> cartItems =
          res.docs.map((e) => CartItem.fromSnapShot(e)).toList();
      return cartItems;
    } catch (e) {
      throw ('Exception: $e');
    }
  }

  @override
  Future<List<Orders>> getOrders() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> res = await _db
          .collection('Orders')
          .where('orderBy', isEqualTo: _auth.currentUser!.uid)
          .get();
      final List<Orders> orders =
          res.docs.map((e) => Orders.fromSnapShot(e)).toList();
      return orders;
    } catch (e) {
      throw ('Exception: $e');
    }
  }

  @override
  Future<void> makeOrder(Orders order) async {
    try {
      order.orderBy = _auth.currentUser!.uid;
      order.orderId=_db.collection('Orders').doc().id;
      await _db.collection('Orders').doc(order.orderId).set(order.toJson());
    } catch (e) {
      throw ('Exception: $e');
    }
  }

  @override
  Future<void> addAddress(Address address) async {
    try {
      address.userId = _auth.currentUser!.uid;
      address.id=_db.collection('Address').doc().id;
      await _db.collection('Address').doc(address.id).set(address.toJson());
    } catch (e) {
      throw ('Exception: $e');
    }
  }

  @override
  Future<void> deleteCartItem(String id,bool all) async {
    try {
    late final QuerySnapshot<Map<String,dynamic>> res;
      if(!all) {
        res=await _db.collection('CartItems').where('id',isEqualTo:id).where('userId',isEqualTo:_auth.currentUser!.uid).get();
      }
      else{
        res=await _db.collection('CartItems').where('userId',isEqualTo:_auth.currentUser!.uid).get();
      }
      for(QueryDocumentSnapshot<Map<String,dynamic>> result in res.docs) {
        await result.reference.delete();
      }
    } catch (e) {
      throw ('Exception: $e');
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> res = await _db
          .collection('User')
          .where('id', isEqualTo: _auth.currentUser!.uid)
          .get();

      final List<UserModel> user =
      res.docs.map((e) => UserModel.fromSnapShot(e)).toList();

      return user.first;
    } catch (e) {
      throw ('Exception: $e');
    }
  }

  @override
  Future<String> uploadProfilePicture(File images) async {
    try {
      final res= _st.ref();

      final imagesRef = res.child("images/ProfilePicture");
      await imagesRef.putFile(images);
      final String image=await imagesRef.getDownloadURL();
        final QuerySnapshot<Map<String,dynamic>> user=await _db
          .collection('User').where('id', isEqualTo: _auth.currentUser!.uid).get();

        for(QueryDocumentSnapshot<Map<String,dynamic>> map in user.docs){
          await map.reference.update({'profilePicture': image});
        }

        return image;
    } catch (e) {
      throw ('Exception: $e');
    }

  }


}


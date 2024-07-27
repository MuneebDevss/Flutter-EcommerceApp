import 'dart:io';

import 'package:ecommerce_app/Core/Entities/user.dart';
import 'package:ecommerce_app/Features/Settings/data/settings_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

import '../Entities/address.dart';
import '../Entities/cart_entity.dart';
import '../Entities/order_entity.dart';


class SettingsRepository
{
  final SettingsRemoteDataSourceImpl impl;

  SettingsRepository({required this.impl});

  Future<Either<String,UserModel>> getUserData() async {
    try{
      final user=await impl.getUserData();
      return  Right(user);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,bool>> signOut()
  async {
    try{
      await impl.signOut();
      return const Right(true);
    }
    catch(e){
      return Left(e.toString());
    }
  }

  Future<Either<String,String>> addCartItems(CartItem item) async {
    try {
      await impl.addCartItems(item);
      return const Right('Added');
    }
    catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String,String>> deleteAddress(String addressId) async {
    try {
      await impl.deleteAddress(addressId);
      return const Right('Address deleted');
    }
    catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String,String>> uploadProfilePicture(File image) async {
      try{
        String url =await impl.uploadProfilePicture(image);
        return  Right(url);
      }
      catch(e){
        return Left(e.toString());
      }
  }
  Future<Either<String,String>> addAddress(Address address) async {
    try {
      await impl.addAddress(address);
      return const Right('Address deleted');
    }
    catch (e) {
      return Left(e.toString());
    }
  }Future<Either<String,String>> deleteCartItems(String id,bool all) async {
    try {
      await impl.deleteCartItem(id,all);
      return const Right('Processing');
    }
    catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String,List<Address>>> getAddresses(bool? first) async {
    try {
     final List<Address> address= await impl.getAddresses(first);
      return  Right(address);
    }
    catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String,List<CartItem>>> getCartItems() async {
    try {
      final List<CartItem> cartItems= await impl.getCartItems();
      return  Right(cartItems);
    }
    catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String,List<Orders>>> getOrders() async {
    try {
      final List<Orders> orders= await impl.getOrders();
      return  Right(orders);
    }
    catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String,String>> makeOrder(Orders order) async {
    try {
      await impl.makeOrder(order);
      return  const Right('Your order has been placed for the verification');
    }
    catch (e) {
      return Left(e.toString());
    }
  }
}
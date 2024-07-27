import 'dart:io';
import 'package:ecommerce_app/Features/ProductDetails/Data/product_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../Core/Entities/product.dart';

class ProductRepository
{
  final ProductRemoteDataSourceImpl impl;
  ProductRepository({required this.impl});
  
  Future<Either<String,String>> deleteProduct(String id) async {

    try{
      await impl.deleteProduct(id);
      return const Right('Deleted');
    }
    catch(e){
      return Left(e.toString());
    }
  }


  Future<Either<String,List<Product>>> retrieveByBrand(String brandName) async {

    try{
      List<Product>products=await impl.retrieveByBrand(brandName);
      return  Right(products);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,List<Product>>> retrieveCategory(String category) async {

    try{
      List<Product>products=await impl.retrieveCategory(category);
      return  Right(products);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,List<Product>>> retrieveFeatured() async {
    try{
      List<Product>products=await impl.retrieveFeatured();
      return  Right(products);
    }
    catch(e){
      return Left(e.toString());
    }
  }


  Future<Either<String,String>> updateProduct(String id,{String? category, String? description, List<String>? sizes, List<String>? colors, String? off, String? title, String? brand, String? price, int? likes}) async {
    try{
      await impl.updateProduct(id,category: category, description:  description, sizes:  sizes,  colors: colors, off:  off, title:  title, brand:  brand,price:   price, likes:likes);
      return const Right('Updated');
    }
    catch(e){
      return Left(e.toString());
    }
  }

  
  Future<Either<String,String>> uploadProduct(Product product,List<File>images) async {
    try{
      String id=impl.get();
      List<String>imageUrls=await impl.uploadProductImages(images, id);
      product.imageUrl=imageUrls;
      await impl.uploadProduct(product, id);
      return const Right('Uploaded');
    }
    catch(e){
      return Left(e.toString());
    }
  }
}
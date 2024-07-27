import 'package:ecommerce_app/Core/Entities/product.dart';
import 'package:ecommerce_app/Features/Navigation/Data/navigation_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';
import '../Entities/wished.dart';

class NavigationRepository{
  final NavigationRemoteDataSourceImpl impl;

  NavigationRepository({required this.impl});
  Future<Either<String,List<Wished>>> getWished() async {
    try{
      final res=await impl.getWished();
      return Right(res);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,int>> getTotalCartItems() async {
    try{
      final user=await impl.getTotalCartItems();
      return  Right(user);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,List<Product>>> getWishedProducts() async {
    try{
      final res=await impl.getWishProduct();
      return Right(res);
    }
    catch(e){
      return Left(e.toString());
    }
  }


  Future<Either<String,String>> unWishItem(String id) async {
    try{
      await impl.unWishItem(id);
      return const Right("unWished");
    }
    catch(e){
      return Left(e.toString());
    }
  }


  Future<Either<String,String>> wishItem(Wished wished) async {
    try{
      await impl.wishItem(wished);
      return const Right('Wished');
    }
    catch(e){
      return Left(e.toString());
    }
  }
}
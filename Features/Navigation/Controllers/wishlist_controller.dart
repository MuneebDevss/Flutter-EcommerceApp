import 'package:ecommerce_app/Core/Entities/product.dart';

import '../Domain/Entities/wished.dart';

class WishListController{
  static List<Wished> wishes=[];
  List<Product> wishedProducts=[];
  static bool checkWish(String productId){
    for(Wished wish in wishes) {
      if(wish.productId==productId) {
        return true;
      }
    }
    return false;
  }
  static void removeWhereId(String productId){
    for(int x=0;x<wishes.length;x++) {
      if(wishes[x].productId==productId) {
        wishes.removeAt(x);
      }
    }
  }
}